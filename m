Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264199AbTEGXhR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 19:37:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264338AbTEGXCT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 19:02:19 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:5589 "EHLO e35.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S264184AbTEGXCA convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 19:02:00 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10523493863054@kroah.com>
Subject: Re: [PATCH] TTY changes for 2.5.69
In-Reply-To: <10523493864074@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 7 May 2003 16:16:26 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1093, 2003/05/07 14:58:42-07:00, hannal@us.ibm.com

[PATCH] serial_tx3912  tty_driver add .owner field remove MOD_INC/DEC_USE_COUNT


 drivers/char/serial_tx3912.c |   35 +----------------------------------
 1 files changed, 1 insertion(+), 34 deletions(-)


diff -Nru a/drivers/char/serial_tx3912.c b/drivers/char/serial_tx3912.c
--- a/drivers/char/serial_tx3912.c	Wed May  7 16:01:40 2003
+++ b/drivers/char/serial_tx3912.c	Wed May  7 16:01:40 2003
@@ -41,8 +41,6 @@
 static void rs_shutdown_port (void * ptr); 
 static int rs_set_real_termios (void *ptr);
 static int rs_chars_in_buffer (void * ptr); 
-static void rs_hungup (void *ptr);
-static void rs_close (void *ptr);
 
 /*
  * Used by generic serial driver to access hardware
@@ -56,8 +54,6 @@
 	.shutdown_port         = rs_shutdown_port,  
 	.set_real_termios      = rs_set_real_termios,  
 	.chars_in_buffer       = rs_chars_in_buffer, 
-	.close                 = rs_close, 
-	.hungup                = rs_hungup,
 }; 
 
 /*
@@ -579,9 +575,6 @@
 
 	rs_dprintk (TX3912_UART_DEBUG_OPEN, "before inc_use_count (count=%d.\n", 
 	            port->gs.count);
-	if (port->gs.count == 1) {
-		MOD_INC_USE_COUNT;
-	}
 	rs_dprintk (TX3912_UART_DEBUG_OPEN, "after inc_use_count\n");
 
 	/* Jim: Initialize port hardware here */
@@ -595,7 +588,6 @@
 	            retval, port->gs.count);
 
 	if (retval) {
-		MOD_DEC_USE_COUNT;
 		port->gs.count--;
 		return retval;
 	}
@@ -621,32 +613,6 @@
 }
 
 
-
-static void rs_close (void *ptr)
-{
-	func_enter ();
-
-	/* Anything to do here? */
-
-	MOD_DEC_USE_COUNT;
-	func_exit ();
-}
-
-
-/* I haven't the foggiest why the decrement use count has to happen
-   here. The whole linux serial drivers stuff needs to be redesigned.
-   My guess is that this is a hack to minimize the impact of a bug
-   elsewhere. Thinking about it some more. (try it sometime) Try
-   running minicom on a serial port that is driven by a modularized
-   driver. Have the modem hangup. Then remove the driver module. Then
-   exit minicom.  I expect an "oops".  -- REW */
-static void rs_hungup (void *ptr)
-{
-	func_enter ();
-	MOD_DEC_USE_COUNT;
-	func_exit ();
-}
-
 static int rs_ioctl (struct tty_struct * tty, struct file * filp, 
                      unsigned int cmd, unsigned long arg)
 {
@@ -839,6 +805,7 @@
 
 	memset(&rs_driver, 0, sizeof(rs_driver));
 	rs_driver.magic = TTY_DRIVER_MAGIC;
+	rs_driver.owner = THIS_MODULE;
 	rs_driver.driver_name = "serial";
 	rs_driver.name = "ttyS";
 	rs_driver.major = TTY_MAJOR;

