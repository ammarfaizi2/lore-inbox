Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129267AbQLOAw2>; Thu, 14 Dec 2000 19:52:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129325AbQLOAwU>; Thu, 14 Dec 2000 19:52:20 -0500
Received: from coruscant.franken.de ([193.174.159.226]:27151 "EHLO
	coruscant.gnumonks.org") by vger.kernel.org with ESMTP
	id <S129267AbQLOAwC>; Thu, 14 Dec 2000 19:52:02 -0500
Date: Fri, 15 Dec 2000 01:20:00 +0100
From: Harald Welte <laforge@gnumonks.org>
To: "David S. Miller" <davem@redhat.com>
Cc: ionut@cs.columbia.edu, mhaque@haque.net, linux-kernel@vger.kernel.org
Subject: Re: Netfilter is broken (was Re: ip_defrag is broken (was: Re: test12 lockups -- need feedback))
Message-ID: <20001215012000.B6775@coruscant.gnumonks.org>
In-Reply-To: <Pine.LNX.4.30.0012141204210.27848-100000@age.cs.columbia.edu> <200012141955.LAA08814@pizda.ninka.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200012141955.LAA08814@pizda.ninka.net>; from davem@redhat.com on Thu, Dec 14, 2000 at 11:55:43AM -0800
X-Operating-System: 2.4.0-test11p4
X-Date: Today is Setting Orange, the 53rd day of The Aftermath in the YOLD 3166
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 14, 2000 at 11:55:43AM -0800, David S. Miller wrote:
>    Date: Thu, 14 Dec 2000 12:07:38 -0800 (PST)
>    From: Ion Badulescu <ionut@cs.columbia.edu>
> 
>    I'm afraid I won't be able to answer this question, since I'm
>    leaving for a 3-week vacation in about 50 minutes and I need my
>    firewall functional until then. :-) Maybe other people who have
>    seen this problem can experiment further.
> 
> Ok, regardless I'm very confident netfilter is doing something
> very bad.
> 
> Essentially it is feeding SKBs into IPv4 receive processing which
> have a NULL skb->dev, that has always been illegal.  Now it OOPSs
> so we can spot such violations.

mmh... After checking some of my assumptions with the code again, I don't
think that netfilter does something wrong.

Referring to some of the other messages in this thread, ip_conntrack seems
to be blamed.

Conntrack is registered at the NF_IP_PRE_ROUTING hook and calls ip_defrag
for all skb's it receives. But we don't touch the dev member of the skb
at all... 

Or is there something wrong with:

- packet arrives in net/ipv4/ip_input.c:ip_rcv()
- netfilter hook NF_IP_PRE_ROUTING is called
- net/ipv4/netfilter/ip_conntrack_core.c:ip_conntrack_in() is called
- net/ipv4/netfilter/ip_conntrack_core.c:ip_ct_gather_frags() is called
- net/ipv4/ip_input.c:ip_defrag() is called

Isn't the skb->dev member supposed to still point to the receiving 
device?


> David S. Miller

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
