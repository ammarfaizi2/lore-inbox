Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266005AbUBKSNc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Feb 2004 13:13:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265954AbUBKSNc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Feb 2004 13:13:32 -0500
Received: from anor.ics.muni.cz ([147.251.4.35]:59523 "EHLO anor.ics.muni.cz")
	by vger.kernel.org with ESMTP id S266005AbUBKSLy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Feb 2004 13:11:54 -0500
Date: Wed, 11 Feb 2004 19:11:14 +0100
From: Jan Kasprzak <kas@informatics.muni.cz>
To: linux-kernel@vger.kernel.org
Cc: kuznet@ms2.inr.ac.ru
Subject: [Patch] Netlink BUG() on AMD64
Message-ID: <20040211181113.GA2849@fi.muni.cz>
References: <20040205183604.N26559@fi.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040205183604.N26559@fi.muni.cz>
User-Agent: Mutt/1.4.1i
X-Muni-Spam-TestIP: 147.251.48.3
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Kasprzak wrote:
: I have got kernel BUG() while running the "ip rule list" command
: on my dual AMD64 box with 2.6.2 kernel. I have a blacklist of IP
: addresses, and I have one IP rule for each of this addresses:
: 
: ip rule add pref 500 from x.y.z.a dev $UPLINK_DEV blackhole
: 
: I have about 200 such rules (with different x.y.z.a IPv4 addresses,
: but all with the same preference of 500 and same $UPLINK_DEV - currently
: eth3). I have measured that when I add less than 60 such rules, I do not
: get BUG() during "ip rule list" command. When I add 60 or more,
: I get overflow in skb_put(). So the kernel is definitely overflowing
: something.

	The problem is that in fib_rules.c there is an attempt to
skb_put() a negative increment. Which is OK on platforms where sizeof(unsigned)
== sizeof(void *). skb_put() has its second argument as unsigned int,
so instead of adding a -36 bytes here, it adds 4294967260 bytes to the
skb->tail, which extends it further than skb->end, which causes the
BUG() I have mentioned. The solution would be to change the argument
of skb_put() and friends to be either long or signed int, or to call
skb_trim() instead of skb_put in fib_rules.c instead.

	I suggest the following patch, but all occurences of
nlmsg_failure: and rtattr_failure: labels should be checked for a similar
problem.

--- linux-2.6.2/net/ipv4/fib_rules.c.orig	2004-02-11 18:55:58.000000000 +0100
+++ linux-2.6.2/net/ipv4/fib_rules.c	2004-02-11 19:03:08.319215408 +0100
@@ -438,7 +438,7 @@
 
 nlmsg_failure:
 rtattr_failure:
-	skb_put(skb, b - skb->tail);
+	skb_trim(skb, b - skb->data);
 	return -1;
 }
 
Please apply or let me know what the proper fix should be.

-Yenya

-- 
| Jan "Yenya" Kasprzak  <kas at {fi.muni.cz - work | yenya.net - private}> |
| GPG: ID 1024/D3498839      Fingerprint 0D99A7FB206605D7 8B35FCDE05B18A5E |
| http://www.fi.muni.cz/~kas/   Czech Linux Homepage: http://www.linux.cz/ |
 Any compiler or language that likes to hide things like memory allocations
 behind your back just isn't a good choice for a kernel.   --Linus Torvalds
