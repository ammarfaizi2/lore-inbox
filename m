Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319803AbSIMWD6>; Fri, 13 Sep 2002 18:03:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319804AbSIMWD6>; Fri, 13 Sep 2002 18:03:58 -0400
Received: from 12-222-109-15.client.insightBB.com ([12.222.109.15]:43435 "EHLO
	blorp.plorb.com") by vger.kernel.org with ESMTP id <S319803AbSIMWDy>;
	Fri, 13 Sep 2002 18:03:54 -0400
Date: Fri, 13 Sep 2002 17:08:38 -0500
From: Jeff DeFouw <defouwj@purdue.edu>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.0-2.5 bug in ip_options_compile
Message-ID: <20020913220838.GA1579@blorp.plorb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While reading about IP options, I found the IPOPT_END padding (cleaning)
in ip_options_compile (net/ipv4/ip_options.c) was not incrementing a
pointer.  There should be an optptr++ in the for end-of-block statement
to go along with the l--, otherwise it's just comparing the same byte
for each l.  Patch is against 2.4.19.  From the kernel source browser
this bug is also in 2.5.31, 2.2.21, and 2.0.39.

--- linux/net/ipv4/ip_options.c.orig	2002-09-13 15:12:24.000000000 -0500
+++ linux/net/ipv4/ip_options.c	2002-09-13 15:12:50.000000000 -0500
@@ -266,7 +266,7 @@
 	for (l = opt->optlen; l > 0; ) {
 		switch (*optptr) {
 		      case IPOPT_END:
-			for (optptr++, l--; l>0; l--) {
+			for (optptr++, l--; l>0; optptr++, l--) {
 				if (*optptr != IPOPT_END) {
 					*optptr = IPOPT_END;
 					opt->is_changed = 1;


-- 
Jeff DeFouw <defouwj@purdue.edu>
