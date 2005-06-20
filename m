Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261518AbVFTWqY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261518AbVFTWqY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 18:46:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261515AbVFTWm5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 18:42:57 -0400
Received: from coderock.org ([193.77.147.115]:29595 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S262289AbVFTWFk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 18:05:40 -0400
Message-Id: <20050620215720.800951000@nd47.coderock.org>
Date: Mon, 20 Jun 2005 23:57:20 +0200
From: domen@coderock.org
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, Nishanth Aravamudan <nacc@us.ibm.com>,
       domen@coderock.org
Subject: [patch 2/4] serial/68328serial: replace schedule_timeout() with msleep_interruptible()
Content-Disposition: inline; filename=msleep-drivers_serial_68328serial.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nishanth Aravamudan <nacc@us.ibm.com>



Use msleep_interruptible() instead of schedule_timeout() in
send_break() to guarantee the task delays as expected. Change
@duration's units to milliseconds, and modify arguments in callers
appropriately.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
Signed-off-by: Domen Puncer <domen@coderock.org>
---
 68328serial.c |    9 ++++-----
 1 files changed, 4 insertions(+), 5 deletions(-)

Index: quilt/drivers/serial/68328serial.c
===================================================================
--- quilt.orig/drivers/serial/68328serial.c
+++ quilt/drivers/serial/68328serial.c
@@ -992,18 +992,17 @@ static int get_lsr_info(struct m68k_seri
 /*
  * This routine sends a break character out the serial port.
  */
-static void send_break(	struct m68k_serial * info, int duration)
+static void send_break(struct m68k_serial * info, unsigned int duration)
 {
 	m68328_uart *uart = &uart_addr[info->line];
         unsigned long flags;
         if (!info->port)
                 return;
-        set_current_state(TASK_INTERRUPTIBLE);
         save_flags(flags);
         cli();
 #ifdef USE_INTS	
 	uart->utx.w |= UTX_SEND_BREAK;
-        schedule_timeout(duration);
+	msleep_interruptible(duration);
 	uart->utx.w &= ~UTX_SEND_BREAK;
 #endif		
         restore_flags(flags);
@@ -1033,14 +1032,14 @@ static int rs_ioctl(struct tty_struct *t
 				return retval;
 			tty_wait_until_sent(tty, 0);
 			if (!arg)
-				send_break(info, HZ/4);	/* 1/4 second */
+				send_break(info, 250);	/* 1/4 second */
 			return 0;
 		case TCSBRKP:	/* support for POSIX tcsendbreak() */
 			retval = tty_check_change(tty);
 			if (retval)
 				return retval;
 			tty_wait_until_sent(tty, 0);
-			send_break(info, arg ? arg*(HZ/10) : HZ/4);
+			send_break(info, arg ? arg*(100) : 250);
 			return 0;
 		case TIOCGSOFTCAR:
 			error = put_user(C_CLOCAL(tty) ? 1 : 0,

--
