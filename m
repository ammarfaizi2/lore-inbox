Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129391AbQLRTra>; Mon, 18 Dec 2000 14:47:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130147AbQLRTrV>; Mon, 18 Dec 2000 14:47:21 -0500
Received: from coruscant.franken.de ([193.174.159.226]:267 "EHLO
	coruscant.gnumonks.org") by vger.kernel.org with ESMTP
	id <S129391AbQLRTrK>; Mon, 18 Dec 2000 14:47:10 -0500
Date: Mon, 18 Dec 2000 20:14:02 +0100
From: Harald Welte <laforge@gnumonks.org>
To: "David S. Miller" <davem@redhat.com>
Cc: rusty@linuxcare.com.au, kuznet@ms2.inr.ac.ru,
        netfilter-devel@us5.samba.org, linux-kernel@vger.kernel.org
Subject: ip_defrag / ip_conntrack issues (was Re: [PATCH] Fix netfilter locking)
Message-ID: <20001218201402.Y7422@coruscant.gnumonks.org>
In-Reply-To: <E147qmG-0001yB-00@halfway> <200012181811.KAA05490@pizda.ninka.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200012181811.KAA05490@pizda.ninka.net>; from davem@redhat.com on Mon, Dec 18, 2000 at 10:11:14AM -0800
X-Operating-System: 2.4.0-test11p4
X-Date: Today is Setting Orange, the 58th day of The Aftermath in the YOLD 3166
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 18, 2000 at 10:11:14AM -0800, David S. Miller wrote:
>    From: Rusty Russell <rusty@linuxcare.com.au>
>    Date: Mon, 18 Dec 2000 14:15:52 +1100
> 
>    Alexey is right, locking is screwed (explains some reports of
>    occasional failure during rmmod).
> 
> Patch applied, thank you.
> 
>    I have a patch which compiles for non-linear skb mods to netfilter
>    (NAT uses linear packets still, but connection tracking and packet
>    filtering only linearize minimal requirements).  Waiting for
>    DaveM's solution to ip_ct_gather_frags()...
> 
> I feel it's best to just skb_clone() the skb arg to ip_defrag
> and this will close the whole thing, I think.

no. The clone()d skb will still have a skb->dev pointing to NULL.

The problem occurs only for locally-generated outgoing packets, which 
need to be fragmented:

- ip_build_xmit() discoveres it has to fragment
- ip_build_xmit_slow() generates fragments and calls
- NF_HOOK() for NF_IP_LOCAL_OUT
- ip_conntrack_local() is called, which in turn calls
- ip_conntrack_in(), which calls
- ip_ct_gather_frags(), which calls
- ip_defrag(), which calls 

[now we have two possible oops - caues]

a ip_find(), which calls
a ip_frag_create(), which initialises a timer with the function
a ip_expire(), which dereferences qp->iif

b ip_frag_queue(), which dereferences it in qp->iif= skb->dev->ifindex


as andi kleen pointed out:

> > Also is it sure that the backtrace involves ip_rcv ? A more likely
> > guess is that it happens during the IP_LOCAL_OUT hook, when skb->dev
> > isn't set yet, but conntrack already has to already reassemble fragments.

 
> Actually, I do not understand how current code could even have worked
> in the past.  Once the SKB is passed to ip_defrag, it is nobody's
> buisness to reference that SKB anymore.  This ip_defrag call is (from

mmh... we really don't do this. We use the return value of ip_defrag(),
which is what ip_frag_reasm() returns (== the new datagram consisting
out of all its fragments).

> Alexey, what have I missed?  I don't like the ip_fragment.c proposed
> fix for this reason, what netfilter is doing with ip_defrag here looks
> just wrong.

Well, my conclusion is:

- the defragmentation code in the ipv4 stack assumes that skb->dev points
  to a valid device. It does this primaryly to send icmp reassembly errors
  if a fragment reassembly timeout occurs

- netfilter wants to use the ip_defrag for defragmentation, not only for 
  incoming packets from the network at NF_IP_PRE_ROUTING, but also for
  locally-generated fragmented packets (at NF_IP_LOCAL_OUT). Unfortunately
  we don't have a valid skb->dev at this point. 

I don't think that there is any skb_clone()ing needed, nor this would solve
the problem. The solution is

a) netfilter conntrack (more exactly: ip_ct_gather_frags) sets skb->dev to
   something valid (skb->dst->dev). Dirty hack.

b) make ip_defrag(), ... aware of the case where skb->dev == NULL. Sounds
   like a good idea, since it is only one if(skb->dev) clause.

c) netfilter stops using ip_defrag() for this case. Bad idea, it had to
   reinvent the wheel :(

> David S. Miller
> davem@redhat.com

-- 
Live long and prosper
- Harald Welte / laforge@gnumonks.org                http://www.gnumonks.org
============================================================================
GCS/E/IT d- s-: a-- C+++ UL++++$ P+++ L++++$ E--- W- N++ o? K- w--- O- M- 
V-- PS+ PE-- Y+ PGP++ t++ 5-- !X !R tv-- b+++ DI? !D G+ e* h+ r% y+(*)
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
