Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264376AbTEGXhX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 19:37:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264196AbTEGXCy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 19:02:54 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:55689 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S264189AbTEGXCB convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 19:02:01 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10523493864071@kroah.com>
Subject: Re: [PATCH] TTY changes for 2.5.69
In-Reply-To: <10523493863054@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 7 May 2003 16:16:26 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1094, 2003/05/07 14:58:52-07:00, hannal@us.ibm.com

[PATCH] sh-sci tty_driver add .owner field remove MOD_INC/DEC_USE_COUNT


 drivers/char/sh-sci.c |   22 +---------------------
 1 files changed, 1 insertion(+), 21 deletions(-)


diff -Nru a/drivers/char/sh-sci.c b/drivers/char/sh-sci.c
--- a/drivers/char/sh-sci.c	Wed May  7 16:01:36 2003
+++ b/drivers/char/sh-sci.c	Wed May  7 16:01:36 2003
@@ -71,8 +71,6 @@
 static int  sci_get_CD(void *ptr);
 static void sci_shutdown_port(void *ptr);
 static int sci_set_real_termios(void *ptr);
-static void sci_hungup(void *ptr);
-static void sci_close(void *ptr);
 static int sci_chars_in_buffer(void *ptr);
 static int sci_request_irq(struct sci_port *port);
 static void sci_free_irq(struct sci_port *port);
@@ -216,8 +214,6 @@
 	sci_shutdown_port,
 	sci_set_real_termios,
 	sci_chars_in_buffer,
-	sci_close,
-	sci_hungup,
 	NULL
 };
 
@@ -838,12 +834,7 @@
 	sci_setsignals(port, 1,1);
 
 	if (port->gs.count == 1) {
-		MOD_INC_USE_COUNT;
-
 		retval = sci_request_irq(port);
-		if (retval) {
-			goto failed_2;
-		}
 	}
 
 	retval = gs_block_til_ready(port, filp);
@@ -878,23 +869,11 @@
 
 failed_3:
 	sci_free_irq(port);
-failed_2:
-	MOD_DEC_USE_COUNT;
 failed_1:
 	port->gs.count--;
 	return retval;
 }
 
-static void sci_hungup(void *ptr)
-{
-	MOD_DEC_USE_COUNT;
-}
-
-static void sci_close(void *ptr)
-{
-	MOD_DEC_USE_COUNT;
-}
-
 static int sci_ioctl(struct tty_struct * tty, struct file * filp, 
                      unsigned int cmd, unsigned long arg)
 {
@@ -1019,6 +998,7 @@
 
 	memset(&sci_driver, 0, sizeof(sci_driver));
 	sci_driver.magic = TTY_DRIVER_MAGIC;
+	sci_driver.owner = THIS_MODULE;
 	sci_driver.driver_name = "sci";
 #ifdef CONFIG_DEVFS_FS
 	sci_driver.name = "ttsc/";

