Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135961AbREBGYM>; Wed, 2 May 2001 02:24:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135962AbREBGYD>; Wed, 2 May 2001 02:24:03 -0400
Received: from juicer39.bigpond.com ([139.134.6.96]:36293 "EHLO
	mailin8.bigpond.com") by vger.kernel.org with ESMTP
	id <S135961AbREBGX7>; Wed, 2 May 2001 02:23:59 -0400
Message-Id: <m14uoi4-001QJwC@mozart>
From: Rusty Russell <rusty@rustcorp.com.au>
To: Russell King <rmk@arm.linux.org.uk>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: IPv4 NAT doesn't compile in 2.4.4 
In-Reply-To: Your message of "Sat, 28 Apr 2001 17:25:54 +0100."
             <20010428172554.H21792@flint.arm.linux.org.uk> 
Date: Wed, 02 May 2001 14:57:55 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20010428172554.H21792@flint.arm.linux.org.uk> you write:
> net/network.o: In function `init_or_cleanup':
> net/network.o(.text+0x4a530): relocation truncated to fit: R_ARM_PC24 ip_nat_
cleanup

My bad: Russell, you're absolutely right.

Obvious fix below.

Thanks!
Rusty.

diff -urN -I \$.*\$ -X /tmp/kerndiff.guovnD --minimal linux-2.4.4-official/net/ipv4/netfilter/ip_nat_core.c tmp/net/ipv4/netfilter/ip_nat_core.c
--- linux-2.4.4-official/net/ipv4/netfilter/ip_nat_core.c	Tue May  1 12:27:32 2001
+++ tmp/net/ipv4/netfilter/ip_nat_core.c	Wed May  2 14:55:01 2001
@@ -890,13 +890,14 @@
 }
 
 /* Clear NAT section of all conntracks, in case we're loaded again. */
-static int __exit clean_nat(const struct ip_conntrack *i, void *data)
+static int clean_nat(const struct ip_conntrack *i, void *data)
 {
 	memset((void *)&i->nat, 0, sizeof(i->nat));
 	return 0;
 }
 
-void __exit ip_nat_cleanup(void)
+/* Not __exit: called from ip_nat_standalone.c:init_or_cleanup() --RR */
+void ip_nat_cleanup(void)
 {
 	ip_ct_selective_cleanup(&clean_nat, NULL);
 	ip_conntrack_destroyed = NULL;
--
Premature optmztion is rt of all evl. --DK
