Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129523AbQLSOfE>; Tue, 19 Dec 2000 09:35:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129614AbQLSOey>; Tue, 19 Dec 2000 09:34:54 -0500
Received: from smtp.mountain.net ([198.77.1.35]:13584 "EHLO riker.mountain.net")
	by vger.kernel.org with ESMTP id <S129523AbQLSOeh>;
	Tue, 19 Dec 2000 09:34:37 -0500
Message-ID: <3A3F68D7.A167E01@mountain.net>
Date: Tue, 19 Dec 2000 08:55:35 -0500
From: Tom Leete <tleete@mountain.net>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.4.0-test12 i486)
X-Accept-Language: en-US,en-GB,en,fr,es,it,de,ru
MIME-Version: 1.0
To: Harald Welte <laforge@gnumonks.org>
CC: "David S. Miller" <davem@redhat.com>, rusty@linuxcare.com.au,
        kuznet@ms2.inr.ac.ru, netfilter-devel@us5.samba.org,
        linux-kernel@vger.kernel.org
Subject: Re: ip_defrag / ip_conntrack issues (was Re: [PATCH] Fix netfilter 
 locking)
In-Reply-To: <E147qmG-0001yB-00@halfway> <200012181811.KAA05490@pizda.ninka.net> <20001218201402.Y7422@coruscant.gnumonks.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Harald Welte wrote:
> 
> On Mon, Dec 18, 2000 at 10:11:14AM -0800, David S. Miller wrote:
> >    From: Rusty Russell <rusty@linuxcare.com.au>
> >    Date: Mon, 18 Dec 2000 14:15:52 +1100
> >
> >    Alexey is right, locking is screwed (explains some reports of
> >    occasional failure during rmmod).
> >
> > Patch applied, thank you.
> >
> >    I have a patch which compiles for non-linear skb mods to netfilter
> >    (NAT uses linear packets still, but connection tracking and packet
> >    filtering only linearize minimal requirements).  Waiting for
> >    DaveM's solution to ip_ct_gather_frags()...
> >
> > I feel it's best to just skb_clone() the skb arg to ip_defrag
> > and this will close the whole thing, I think.
> 
> no. The clone()d skb will still have a skb->dev pointing to NULL.
> 
> The problem occurs only for locally-generated outgoing packets, which
> need to be fragmented:
> 
> - ip_build_xmit() discoveres it has to fragment
> - ip_build_xmit_slow() generates fragments and calls
> - NF_HOOK() for NF_IP_LOCAL_OUT
> - ip_conntrack_local() is called, which in turn calls
> - ip_conntrack_in(), which calls
> - ip_ct_gather_frags(), which calls
> - ip_defrag(), which calls
> 
> [now we have two possible oops - caues]
> 
> a ip_find(), which calls
> a ip_frag_create(), which initialises a timer with the function
> a ip_expire(), which dereferences qp->iif
> 
> b ip_frag_queue(), which dereferences it in qp->iif= skb->dev->ifindex
> 
> as andi kleen pointed out:
> 
> > > Also is it sure that the backtrace involves ip_rcv ? A more likely
> > > guess is that it happens during the IP_LOCAL_OUT hook, when skb->dev
> > > isn't set yet, but conntrack already has to already reassemble fragments.
> 
> 
> > Actually, I do not understand how current code could even have worked
> > in the past.  Once the SKB is passed to ip_defrag, it is nobody's
> > buisness to reference that SKB anymore.  This ip_defrag call is (from
> 
> mmh... we really don't do this. We use the return value of ip_defrag(),
> which is what ip_frag_reasm() returns (== the new datagram consisting
> out of all its fragments).
> 
> > Alexey, what have I missed?  I don't like the ip_fragment.c proposed
> > fix for this reason, what netfilter is doing with ip_defrag here looks
> > just wrong.
> 
> Well, my conclusion is:
> 
> - the defragmentation code in the ipv4 stack assumes that skb->dev points
>   to a valid device. It does this primaryly to send icmp reassembly errors
>   if a fragment reassembly timeout occurs
> 
> - netfilter wants to use the ip_defrag for defragmentation, not only for
>   incoming packets from the network at NF_IP_PRE_ROUTING, but also for
>   locally-generated fragmented packets (at NF_IP_LOCAL_OUT). Unfortunately
>   we don't have a valid skb->dev at this point.
> 
> I don't think that there is any skb_clone()ing needed, nor this would solve
> the problem. The solution is
> 
> a) netfilter conntrack (more exactly: ip_ct_gather_frags) sets skb->dev to
>    something valid (skb->dst->dev). Dirty hack.
> 
> b) make ip_defrag(), ... aware of the case where skb->dev == NULL. Sounds
>    like a good idea, since it is only one if(skb->dev) clause.
> 
> c) netfilter stops using ip_defrag() for this case. Bad idea, it had to
>    reinvent the wheel :(
> 
> - Harald Welte / laforge@gnumonks.org                http://www.gnumonks.org

I'm now testing this small patch based on your suggestion b). I have
netfilter running, nfs mounts are behaving well, and fragmented pings dont
kill the box. I made no attempt to resolve anything but the derefernce of a
netdevice *dev.= NULL

The patch only deals with the ip_defrag_queue path. I have not seen the
alternate one happen. It's only been up an hour, I'll put some more time on
it.

Cheers,
Tom

--- linux/net/ipv4/ip_fragment.c~	Tue Dec 12 06:56:29 2000
+++ linux/net/ipv4/ip_fragment.c	Tue Dec 19 07:29:53 2000
@@ -485,7 +485,8 @@
 	else
 		qp->fragments = skb;
 
-	qp->iif = skb->dev->ifindex;
+	if (skb->dev)
+	        qp->iif = skb->dev->ifindex;
 	skb->dev = NULL;
 	qp->meat += skb->len;
 	atomic_add(skb->truesize, &ip_frag_mem);
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
