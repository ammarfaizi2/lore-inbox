Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283212AbRK2NLk>; Thu, 29 Nov 2001 08:11:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283210AbRK2NLb>; Thu, 29 Nov 2001 08:11:31 -0500
Received: from [212.18.232.186] ([212.18.232.186]:6159 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S283212AbRK2NLR>; Thu, 29 Nov 2001 08:11:17 -0500
Date: Thu, 29 Nov 2001 13:10:59 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Patch: Fix serial module use count (2.4.16 _and_ 2.5)
Message-ID: <20011129131059.A6214@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The existing serial.c contains a nice module use count bug which is easily
triggerable.  Without anything connected to ttyS0, do:

 stty -clocal -F /dev/ttyS0
 stty -aF /dev/ttyS0

Hit ^c, lsmod shows use count of -1.  Repeat to decrement further.

Here's a patch that fixes this bogosity - please see the comment within
the patch for the reason.

Marcelo, please apply to both 2.4.
Linus, please apply to 2.5 as a stop-gap until my new serial drivers are
ready to be merged.

Thanks.

--- linux-orig/drivers/char/serial.c	Tue Nov 13 12:37:12 2001
+++ linux/drivers/char/serial.c	Thu Nov 29 13:07:52 2001
@@ -3133,6 +3133,10 @@
  * enables interrupts for a serial port, linking in its async structure into
  * the IRQ chain.   It also performs the serial-specific
  * initialization for the tty structure.
+ *
+ * Note that on failure, we don't decrement the module use count - the tty
+ * later will call rs_close, which will decrement it for us as long as
+ * tty->driver_data is set non-NULL. --rmk
  */
 static int rs_open(struct tty_struct *tty, struct file * filp)
 {
@@ -3153,10 +3157,8 @@
 	}
 	tty->driver_data = info;
 	info->tty = tty;
-	if (serial_paranoia_check(info, tty->device, "rs_open")) {
-		MOD_DEC_USE_COUNT;		
+	if (serial_paranoia_check(info, tty->device, "rs_open"))
 		return -ENODEV;
-	}
 
 #ifdef SERIAL_DEBUG_OPEN
 	printk("rs_open %s%d, count = %d\n", tty->driver.name, info->line,
@@ -3171,10 +3173,8 @@
 	 */
 	if (!tmp_buf) {
 		page = get_zeroed_page(GFP_KERNEL);
-		if (!page) {
-			MOD_DEC_USE_COUNT;
+		if (!page)
 			return -ENOMEM;
-		}
 		if (tmp_buf)
 			free_page(page);
 		else
@@ -3188,7 +3188,6 @@
 	    (info->flags & ASYNC_CLOSING)) {
 		if (info->flags & ASYNC_CLOSING)
 			interruptible_sleep_on(&info->close_wait);
-		MOD_DEC_USE_COUNT;
 #ifdef SERIAL_DO_RESTART
 		return ((info->flags & ASYNC_HUP_NOTIFY) ?
 			-EAGAIN : -ERESTARTSYS);
@@ -3201,10 +3200,8 @@
 	 * Start up serial port
 	 */
 	retval = startup(info);
-	if (retval) {
-		MOD_DEC_USE_COUNT;
+	if (retval)
 		return retval;
-	}
 
 	retval = block_til_ready(tty, filp, info);
 	if (retval) {
@@ -3212,7 +3209,6 @@
 		printk("rs_open returning after block_til_ready with %d\n",
 		       retval);
 #endif
-		MOD_DEC_USE_COUNT;
 		return retval;
 	}
 


--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

