Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262771AbTE2VUp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 May 2003 17:20:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262763AbTE2VUp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 May 2003 17:20:45 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:61835 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262742AbTE2VUm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 May 2003 17:20:42 -0400
Date: Thu, 29 May 2003 14:35:10 -0700
From: Hanna Linder <hannal@us.ibm.com>
Reply-To: Hanna Linder <hannal@us.ibm.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
cc: linux-kernel-owner@vger.kernel.org, rusty@rustcorp.com.au,
       hannal@us.ibm.com
Subject: Re: [PATCH] sx tty_driver add .owner field remove MOD_INC_DEC_USE_COUNT
Message-ID: <12430000.1054244110@w-hlinder>
In-Reply-To: <20030529190250.GB24737@kroah.com>
References: <200305270126.h4R1QjA3029554@hera.kernel.org> <20030529190250.GB24737@kroah.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--On Thursday, May 29, 2003 12:02:50 PM -0700 Greg KH <greg@kroah.com> wrote:

> 
> Ick, this patch should be reverted, it should not be removing
> sx_hungup() for no reason.  I think Hanna agrees with this.

Yup. Sorry. Not sure what happened there. Here is the patch
to replace the sx_hangup function. This is based off 2.5.70-bk3
and I have compiled it but dont have the hardware to test it.

Hanna

---
diff -Nrup -Xdontdiff linux-2.5.70-bk3/drivers/char/sx.c linux-sx/drivers/char/sx.c
--- linux-2.5.70-bk3/drivers/char/sx.c	Thu May 29 14:03:43 2003
+++ linux-sx/drivers/char/sx.c	Thu May 29 14:11:39 2003
@@ -299,6 +299,7 @@ static void sx_enable_rx_interrupts (voi
 static int  sx_get_CD (void * ptr); 
 static void sx_shutdown_port (void * ptr);
 static int  sx_set_real_termios (void  *ptr);
+static void sx_hungup (void  *ptr);
 static void sx_close (void  *ptr);
 static int sx_chars_in_buffer (void * ptr);
 static int sx_init_board (struct sx_board *board);
@@ -379,6 +380,7 @@ static struct real_driver sx_real_driver
 	sx_set_real_termios, 
 	sx_chars_in_buffer,
 	sx_close,
+	sx_hungup,
 };
 
 
@@ -1499,6 +1501,39 @@ static int sx_open  (struct tty_struct *
 }
 
 
+/* I haven't the foggiest why the decrement use count has to happen
+   here. The whole linux serial drivers stuff needs to be redesigned.
+   My guess is that this is a hack to minimize the impact of a bug
+   elsewhere. Thinking about it some more. (try it sometime) Try
+   running minicom on a serial port that is driven by a modularized
+   driver. Have the modem hangup. Then remove the driver module. Then
+   exit minicom.  I expect an "oops".  -- REW */
+static void sx_hungup (void *ptr)
+{
+  /*
+	struct sx_port *port = ptr; 
+  */
+	func_enter ();
+
+	/* Don't force the SX card to close. mgetty doesn't like it !!!!!! -- pvdl */
+	/* For some reson we added this code. Don't know why anymore ;-( -- pvdl */
+	/*
+	sx_setsignals (port, 0, 0);
+	sx_reconfigure_port(port);	
+	sx_send_command (port, HS_CLOSE, 0, 0);
+
+	if (sx_read_channel_byte (port, hi_hstat) != HS_IDLE_CLOSED) {
+		if (sx_send_command (port, HS_FORCE_CLOSED, -1, HS_IDLE_CLOSED) != 1) {
+			printk (KERN_ERR 
+			        "sx: sent the force_close command, but card didn't react\n");
+		} else
+			sx_dprintk (SX_DEBUG_CLOSE, "sent the force_close command.\n");
+	}
+	*/
+	func_exit ();
+}
+
+
 static void sx_close (void *ptr)
 {
 	struct sx_port *port = ptr; 

