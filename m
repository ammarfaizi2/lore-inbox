Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268365AbUILQiI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268365AbUILQiI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 12:38:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268463AbUILQiI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 12:38:08 -0400
Received: from verein.lst.de ([213.95.11.210]:46769 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S268365AbUILQiC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 12:38:02 -0400
Date: Sun, 12 Sep 2004 18:37:56 +0200
From: Christoph Hellwig <hch@lst.de>
To: akpm@osdl.org, geert@linux-m68k.org
Cc: linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mark amiflop non-unloadable
Message-ID: <20040912163756.GA5002@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

as it's using the obsolete MOD_{INC,DEC}_USE_COUNT it's implicitly
locked already, but let's remove them and make it explicit so these
macros can go away completely without breaking m68k compile.


--- 1.46/drivers/block/amiflop.c	2003-09-03 12:32:10 +02:00
+++ edited/drivers/block/amiflop.c	2004-09-12 18:37:32 +02:00
@@ -386,16 +386,6 @@
 	fd_select(drive);
 	udelay (1);
 	fd_deselect(drive);
-
-#ifdef MODULE
-/*
-  this is the last interrupt for any drive access, happens after
-  release (from floppy_off). So we have to wait until now to decrease
-  the use count.
-*/
-	if (decusecount)
-		MOD_DEC_USE_COUNT;
-#endif
 }
 
 static void floppy_off (unsigned int nr)
@@ -1590,10 +1580,6 @@
 	local_irq_save(flags);
 	fd_ref[drive]++;
 	fd_device[drive] = system;
-#ifdef MODULE
-	if (unit[drive].motor == 0)
-		MOD_INC_USE_COUNT;
-#endif
 	local_irq_restore(flags);
 
 	unit[drive].dtype=&data_types[system];
@@ -1839,6 +1825,7 @@
 	return amiga_floppy_init();
 }
 
+#if 0 /* not safe to unload */
 void cleanup_module(void)
 {
 	int i;
@@ -1859,4 +1846,5 @@
 	release_mem_region(CUSTOM_PHYSADDR+0x20, 8);
 	unregister_blkdev(FLOPPY_MAJOR, "fd");
 }
+#endif
 #endif
