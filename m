Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422669AbWCWUFy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422669AbWCWUFy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 15:05:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422673AbWCWUFy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 15:05:54 -0500
Received: from adsl-70-250-156-241.dsl.austtx.swbell.net ([70.250.156.241]:48285
	"EHLO gw.microgate.com") by vger.kernel.org with ESMTP
	id S1422669AbWCWUFx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 15:05:53 -0500
Subject: [PATCH] synclink remove dead code
From: Paul Fulghum <paulkf@microgate.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Thu, 23 Mar 2006 14:05:38 -0600
Message-Id: <1143144338.8304.2.camel@amdx2.microgate.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove dead code from synclink driver.
This was used previously when the write method
had a from_user flag, which has been removed.

Signed-off-by: Paul Fulghum <paulkf@microgate.com>

--- linux-2.6.16/drivers/char/synclink.c	2006-03-23 13:56:00.000000000 -0600
+++ b/drivers/char/synclink.c	2006-03-23 13:53:04.000000000 -0600
@@ -941,17 +941,6 @@ static void* mgsl_get_text_ptr(void)
 	return mgsl_get_text_ptr;
 }
 
-/*
- * tmp_buf is used as a temporary buffer by mgsl_write.  We need to
- * lock it in case the COPY_FROM_USER blocks while swapping in a page,
- * and some other program tries to do a serial write at the same time.
- * Since the lock will only come under contention when the system is
- * swapping and available memory is low, it makes sense to share one
- * buffer across all the serial ioports, since it significantly saves
- * memory if large numbers of serial ports are open.
- */
-static unsigned char *tmp_buf;
-
 static inline int mgsl_paranoia_check(struct mgsl_struct *info,
 					char *name, const char *routine)
 {
@@ -2150,7 +2139,7 @@ static int mgsl_write(struct tty_struct 
 	if (mgsl_paranoia_check(info, tty->name, "mgsl_write"))
 		goto cleanup;
 
-	if (!tty || !info->xmit_buf || !tmp_buf)
+	if (!tty || !info->xmit_buf)
 		goto cleanup;
 
 	if ( info->params.mode == MGSL_MODE_HDLC ||
@@ -3438,7 +3427,6 @@ static int mgsl_open(struct tty_struct *
 {
 	struct mgsl_struct	*info;
 	int 			retval, line;
-	unsigned long		page;
 	unsigned long flags;
 
 	/* verify range of specified line number */	
@@ -3472,18 +3460,6 @@ static int mgsl_open(struct tty_struct *
 		goto cleanup;
 	}
 	
-	if (!tmp_buf) {
-		page = get_zeroed_page(GFP_KERNEL);
-		if (!page) {
-			retval = -ENOMEM;
-			goto cleanup;
-		}
-		if (tmp_buf)
-			free_page(page);
-		else
-			tmp_buf = (unsigned char *) page;
-	}
-	
 	info->tty->low_latency = (info->flags & ASYNC_LOW_LATENCY) ? 1 : 0;
 
 	spin_lock_irqsave(&info->netlock, flags);
@@ -4502,11 +4478,6 @@ static void synclink_cleanup(void)
 		kfree(tmp);
 	}
 	
-	if (tmp_buf) {
-		free_page((unsigned long) tmp_buf);
-		tmp_buf = NULL;
-	}
-	
 	if (pci_registered)
 		pci_unregister_driver(&synclink_pci_driver);
 }


