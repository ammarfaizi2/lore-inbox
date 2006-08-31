Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964810AbWHaXN3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964810AbWHaXN3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 19:13:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751248AbWHaXN3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 19:13:29 -0400
Received: from mail.gmx.net ([213.165.64.20]:31651 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750907AbWHaXN2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 19:13:28 -0400
X-Authenticated: #704063
Subject: [Patch] Uninitialized variable in drivers/net/wan/syncppp.c
From: Eric Sesterhenn <snakebyte@gmx.de>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Fri, 01 Sep 2006 01:13:22 +0200
Message-Id: <1157066002.13592.3.camel@alice>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

this was spotted by coverity (id #891), when
len is equal to 4, we dont call sppp_lcp_conf_parse_options(),
to initialize rmagic.

Signed-off-by: Eric Sesterhenn <snakebyte@gmx.de>

--- linux-2.6.18-rc5/drivers/net/wan/syncppp.c.orig	2006-09-01 00:55:08.000000000 +0200
+++ linux-2.6.18-rc5/drivers/net/wan/syncppp.c	2006-09-01 00:55:45.000000000 +0200
@@ -505,14 +505,15 @@ static void sppp_lcp_input (struct sppp 
 			skb->len, h);
 		break;
 	case LCP_CONF_REQ:
-		if (len < 4) {
+		if (len <= 4) {
 			if (sp->pp_flags & PP_DEBUG)
 				printk (KERN_DEBUG"%s: invalid lcp configure request packet length: %d bytes\n",
 					dev->name, len);
 			break;
 		}
-		if (len>4 && !sppp_lcp_conf_parse_options (sp, h, len, &rmagic))
+		if (!sppp_lcp_conf_parse_options (sp, h, len, &rmagic))
 			goto badreq;
+
 		if (rmagic == sp->lcp.magic) {
 			/* Local and remote magics equal -- loopback? */
 			if (sp->pp_loopcnt >= MAXALIVECNT*5) {


