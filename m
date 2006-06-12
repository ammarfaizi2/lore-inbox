Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751696AbWFLKC1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751696AbWFLKC1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 06:02:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751710AbWFLKC0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 06:02:26 -0400
Received: from mail.gmx.de ([213.165.64.20]:59573 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751685AbWFLKCZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 06:02:25 -0400
X-Authenticated: #704063
Subject: [Patch] More !tty cleanups in drivers/char
From: Eric Sesterhenn <snakebyte@gmx.de>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Mon, 12 Jun 2006 12:02:22 +0200
Message-Id: <1150106542.10437.3.camel@alice>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

another bunch of checks in the char drivers .put_char() and
.write() routines, where tty can never be NULL. This patch removes
these checks to save some code. Coverity choked at those with the
following bug ids:

isicom.c  767, 766
specialix.c 773, 774
synclink_cs.c 779, 781
synclink_gt.c 784, 785
synclinkmp.c 784, 785

Signed-off-by: Eric Sesterhenn <snakebyte@gmx.de>

--- linux-2.6.17-rc5/drivers/char/isicom.c.orig	2006-06-12 11:48:16.000000000 +0200
+++ linux-2.6.17-rc5/drivers/char/isicom.c	2006-06-12 11:49:23.000000000 +0200
@@ -1145,7 +1145,7 @@ static int isicom_write(struct tty_struc
 	if (isicom_paranoia_check(port, tty->name, "isicom_write"))
 		return 0;
 
-	if (!tty || !port->xmit_buf)
+	if (!port->xmit_buf)
 		return 0;
 
 	spin_lock_irqsave(&card->card_lock, flags);
@@ -1180,7 +1180,7 @@ static void isicom_put_char(struct tty_s
 	if (isicom_paranoia_check(port, tty->name, "isicom_put_char"))
 		return;
 
-	if (!tty || !port->xmit_buf)
+	if (!port->xmit_buf)
 		return;
 
 	spin_lock_irqsave(&card->card_lock, flags);
--- linux-2.6.17-rc5/drivers/char/specialix.c.orig	2006-06-12 11:50:53.000000000 +0200
+++ linux-2.6.17-rc5/drivers/char/specialix.c	2006-06-12 11:51:40.000000000 +0200
@@ -1683,7 +1683,7 @@ static int sx_write(struct tty_struct * 
 
 	bp = port_Board(port);
 
-	if (!tty || !port->xmit_buf || !tmp_buf) {
+	if (!port->xmit_buf || !tmp_buf) {
 		func_exit();
 		return 0;
 	}
@@ -1733,7 +1733,7 @@ static void sx_put_char(struct tty_struc
 		return;
 	}
 	dprintk (SX_DEBUG_TX, "check tty: %p %p\n", tty, port->xmit_buf);
-	if (!tty || !port->xmit_buf) {
+	if (!port->xmit_buf) {
 		func_exit();
 		return;
 	}
--- linux-2.6.17-rc5/drivers/char/pcmcia/synclink_cs.c.orig	2006-06-12 11:52:31.000000000 +0200
+++ linux-2.6.17-rc5/drivers/char/pcmcia/synclink_cs.c	2006-06-12 11:53:33.000000000 +0200
@@ -1582,7 +1582,7 @@ static void mgslpc_put_char(struct tty_s
 	if (mgslpc_paranoia_check(info, tty->name, "mgslpc_put_char"))
 		return;
 
-	if (!tty || !info->tx_buf)
+	if (!info->tx_buf)
 		return;
 
 	spin_lock_irqsave(&info->lock,flags);
@@ -1649,7 +1649,7 @@ static int mgslpc_write(struct tty_struc
 			__FILE__,__LINE__,info->device_name,count);
 	
 	if (mgslpc_paranoia_check(info, tty->name, "mgslpc_write") ||
-	    !tty || !info->tx_buf)
+		!info->tx_buf)
 		goto cleanup;
 
 	if (info->params.mode == MGSL_MODE_HDLC) {
--- linux-2.6.17-rc5/drivers/char/synclink_gt.c.orig	2006-06-12 11:54:39.000000000 +0200
+++ linux-2.6.17-rc5/drivers/char/synclink_gt.c	2006-06-12 11:55:14.000000000 +0200
@@ -870,7 +870,7 @@ static int write(struct tty_struct *tty,
 		goto cleanup;
 	DBGINFO(("%s write count=%d\n", info->device_name, count));
 
-	if (!tty || !info->tx_buf)
+	if (!info->tx_buf)
 		goto cleanup;
 
 	if (count > info->max_frame_size) {
@@ -924,7 +924,7 @@ static void put_char(struct tty_struct *
 	if (sanity_check(info, tty->name, "put_char"))
 		return;
 	DBGINFO(("%s put_char(%d)\n", info->device_name, ch));
-	if (!tty || !info->tx_buf)
+	if (!info->tx_buf)
 		return;
 	spin_lock_irqsave(&info->lock,flags);
 	if (!info->tx_active && (info->tx_count < info->max_frame_size))
--- linux-2.6.17-rc5/drivers/char/synclinkmp.c.orig	2006-06-12 11:56:12.000000000 +0200
+++ linux-2.6.17-rc5/drivers/char/synclinkmp.c	2006-06-12 11:56:27.000000000 +0200
@@ -988,7 +988,7 @@ static int write(struct tty_struct *tty,
 	if (sanity_check(info, tty->name, "write"))
 		goto cleanup;
 
-	if (!tty || !info->tx_buf)
+	if (!info->tx_buf)
 		goto cleanup;
 
 	if (info->params.mode == MGSL_MODE_HDLC) {
@@ -1067,7 +1067,7 @@ static void put_char(struct tty_struct *
 	if (sanity_check(info, tty->name, "put_char"))
 		return;
 
-	if (!tty || !info->tx_buf)
+	if (!info->tx_buf)
 		return;
 
 	spin_lock_irqsave(&info->lock,flags);


