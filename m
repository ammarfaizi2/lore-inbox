Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261262AbVFJXvA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261262AbVFJXvA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Jun 2005 19:51:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261438AbVFJXsR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Jun 2005 19:48:17 -0400
Received: from gate.crashing.org ([63.228.1.57]:51133 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261476AbVFJXqC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Jun 2005 19:46:02 -0400
Subject: [PATCH] radeonfb: don't blow up VGA console on load
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
Content-Type: text/plain
Date: Sat, 11 Jun 2005 09:45:30 +1000
Message-Id: <1118447130.5986.69.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

Current radeonfb memset's the framebuffer to 0 when loaded. This removes
occasional artifacts but has the nasty side effect that if you load
radeonfb without framebuffer console, you destroy the VGA text buffer,
font, etc... radeon must not touch the framebuffer content when it
doesn't "own" it.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Index: linux-work/drivers/video/aty/radeon_base.c
===================================================================
--- linux-work.orig/drivers/video/aty/radeon_base.c	2005-06-09 16:22:08.000000000 +1000
+++ linux-work/drivers/video/aty/radeon_base.c	2005-06-11 09:42:19.000000000 +1000
@@ -2374,10 +2374,9 @@
 	} while (   rinfo->fb_base == 0 &&
 		  ((rinfo->mapped_vram /=2) >= MIN_MAPPED_VRAM) );
 
-	if (rinfo->fb_base)
-		memset_io(rinfo->fb_base, 0, rinfo->mapped_vram);
-	else {
-		printk (KERN_ERR "radeonfb (%s): cannot map FB\n", pci_name(rinfo->pdev));
+	if (rinfo->fb_base == NULL) {
+		printk (KERN_ERR "radeonfb (%s): cannot map FB\n",
+			pci_name(rinfo->pdev));
 		ret = -EIO;
 		goto err_unmap_rom;
 	}


