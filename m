Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261435AbVHBLxe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261435AbVHBLxe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Aug 2005 07:53:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261440AbVHBLxe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Aug 2005 07:53:34 -0400
Received: from ozlabs.org ([203.10.76.45]:4533 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261435AbVHBLxd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Aug 2005 07:53:33 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17135.24136.268138.511779@cargo.ozlabs.ibm.com>
Date: Tue, 2 Aug 2005 21:51:36 +1000
From: Paul Mackerras <paulus@samba.org>
To: torvalds@osdl.org, Dominik Brodowski <linux@dominikbrodowski.net>
CC: linux-kernel@vger.kernel.org
Subject: [PATCH] Obvious bugfix for yenta resource allocation
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Recent changes (well, dating from 12 July) have broken cardbus on my
powerbook: I get 3 messages saying "no resource of type xxx available,
trying to continue", and if I plug in my wireless card, it complains
that there are no resources allocated to the card.  This all worked in
2.6.12.

Looking at the code in yenta_socket.c, function yenta_allocate_res,
it's obvious what is wrong: if we get to line 639 (i.e. there wasn't a
usable preassigned resource), we will always flow through to line 668,
which is the printk that I was seeing, even if a resource was
successfully allocated.  It looks to me as though there should be a
return statement after the two config_writel's in each of the 3
branches of the if statements, so that the function returns after
successfully setting up the resource.

The patch below adds these return statements, and with this patch,
cardbus works on my powerbook once again.

Signed-off-by: Paul Mackerras <paulus@samba.org>
---
diff -urN linux-2.6/drivers/pcmcia/yenta_socket.c pmac-2.6/drivers/pcmcia/yenta_socket.c
--- linux-2.6/drivers/pcmcia/yenta_socket.c	2005-07-31 17:38:35.000000000 +1000
+++ pmac-2.6/drivers/pcmcia/yenta_socket.c	2005-08-02 21:32:53.000000000 +1000
@@ -642,6 +642,7 @@
 		    (yenta_search_res(socket, res, BRIDGE_IO_MIN))) {
 			config_writel(socket, addr_start, res->start);
 			config_writel(socket, addr_end, res->end);
+			return;
 		}
 	} else {
 		if (type & IORESOURCE_PREFETCH) {
@@ -650,6 +651,7 @@
 			    (yenta_search_res(socket, res, BRIDGE_MEM_MIN))) {
 				config_writel(socket, addr_start, res->start);
 				config_writel(socket, addr_end, res->end);
+				return;
 			}
 			/* Approximating prefetchable by non-prefetchable */
 			res->flags = IORESOURCE_MEM;
@@ -659,6 +661,7 @@
 		    (yenta_search_res(socket, res, BRIDGE_MEM_MIN))) {
 			config_writel(socket, addr_start, res->start);
 			config_writel(socket, addr_end, res->end);
+			return;
 		}
 	}
 
