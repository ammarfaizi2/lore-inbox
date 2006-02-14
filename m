Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422712AbWBNRrw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422712AbWBNRrw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 12:47:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422714AbWBNRrw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 12:47:52 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:39094 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1422712AbWBNRrv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 12:47:51 -0500
Subject: PATCH: locking error in esp
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@osdl.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 14 Feb 2006 17:50:54 +0000
Message-Id: <1139939454.11979.0.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Noted by Al Viro.

Also remove unused tmp_buf

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.16-rc3/drivers/char/esp.c linux-2.6.16-rc3/drivers/char/esp.c
--- linux.vanilla-2.6.16-rc3/drivers/char/esp.c	2006-02-14 17:08:55.054477872 +0000
+++ linux-2.6.16-rc3/drivers/char/esp.c	2006-02-14 17:16:24.851098392 +0000
@@ -150,17 +150,6 @@
 /* Standard COM flags (except for COM4, because of the 8514 problem) */
 #define STD_COM_FLAGS (ASYNC_BOOT_AUTOCONF | ASYNC_SKIP_TEST)
 
-/*
- * tmp_buf is used as a temporary buffer by serial_write.  We need to
- * lock it in case the memcpy_fromfs blocks while swapping in a page,
- * and some other program tries to do a serial write at the same time.
- * Since the lock will only come under contention when the system is
- * swapping and available memory is low, it makes sense to share one
- * buffer across all the serial ports, since it significantly saves
- * memory if large numbers of serial ports are open.
- */
-static unsigned char *tmp_buf;
-
 static inline int serial_paranoia_check(struct esp_struct *info,
 					char *name, const char *routine)
 {
@@ -1267,7 +1256,7 @@
 	if (serial_paranoia_check(info, tty->name, "rs_write"))
 		return 0;
 
-	if (!tty || !info->xmit_buf || !tmp_buf)
+	if (!tty || !info->xmit_buf)
 		return 0;
 	    
 	while (1) {
@@ -2291,11 +2280,7 @@
 	tty->driver_data = info;
 	info->tty = tty;
 
-	if (!tmp_buf) {
-		tmp_buf = (unsigned char *) get_zeroed_page(GFP_KERNEL);
-		if (!tmp_buf)
-			return -ENOMEM;
-	}
+	spin_unlock_irqrestore(&info->lock, flags);
 	
 	/*
 	 * Start up serial port
@@ -2602,9 +2587,6 @@
 		free_pages((unsigned long)dma_buffer,
 			get_order(DMA_BUFFER_SZ));
 
-	if (tmp_buf)
-		free_page((unsigned long)tmp_buf);
-
 	while (free_pio_buf) {
 		pio_buf = free_pio_buf->next;
 		kfree(free_pio_buf);

