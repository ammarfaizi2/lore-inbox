Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261346AbULXAuq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261346AbULXAuq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Dec 2004 19:50:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261352AbULXAuq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Dec 2004 19:50:46 -0500
Received: from mail.dif.dk ([193.138.115.101]:62916 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S261346AbULXAua (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Dec 2004 19:50:30 -0500
Date: Fri, 24 Dec 2004 02:01:18 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Alan Cox <alan@redhat.com>
Cc: Moxa Technologies <support@moxa.com.tw>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] fix inlining related build failures in mxser.c
Message-ID: <Pine.LNX.4.61.0412240155070.3504@dragon.hygekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

An allyesconfig build of 2.6.10-rc3-bk16 revealed the following build 
failures (which arefixed by the patch below) :

  CC      drivers/char/mxser.o
drivers/char/mxser.c: In function `mxser_ioctl':
drivers/char/mxser.c:415: sorry, unimplemented: inlining failed in call to 
'mxser_check_modem_status': function body not available
drivers/char/mxser.c:1407: sorry, unimplemented: called from here
make[2]: *** [drivers/char/mxser.o] Error 1
make[1]: *** [drivers/char] Error 2
make: *** [drivers] Error 2

  CC      drivers/char/mxser.o
drivers/char/mxser.c: In function `mxser_interrupt':
drivers/char/mxser.c:413: sorry, unimplemented: inlining failed in call to 
'mxser_receive_chars': function body not available
drivers/char/mxser.c:1953: sorry, unimplemented: called from here
drivers/char/mxser.c:413: sorry, unimplemented: inlining failed in call to 
'mxser_receive_chars': function body not available
drivers/char/mxser.c:1960: sorry, unimplemented: called from here
drivers/char/mxser.c:414: sorry, unimplemented: inlining failed in call to 
'mxser_transmit_chars': function body not available
drivers/char/mxser.c:1969: sorry, unimplemented: called from here
drivers/char/mxser.c:414: sorry, unimplemented: inlining failed in call to 
'mxser_transmit_chars': function body not available
drivers/char/mxser.c:1978: sorry, unimplemented: called from here
make[2]: *** [drivers/char/mxser.o] Error 1
make[1]: *** [drivers/char] Error 2
make: *** [drivers] Error 2

  CC      drivers/char/mxser.o
drivers/char/mxser.c: In function `mxser_interrupt':
drivers/char/mxser.c:414: sorry, unimplemented: inlining failed in call to 
'mxser_transmit_chars': function body not available
drivers/char/mxser.c:1969: sorry, unimplemented: called from here
drivers/char/mxser.c:414: sorry, unimplemented: inlining failed in call to 
'mxser_transmit_chars': function body not available
drivers/char/mxser.c:1978: sorry, unimplemented: called from here
make[2]: *** [drivers/char/mxser.o] Error 1
make[1]: *** [drivers/char] Error 2
make: *** [drivers] Error 2


One simple way to fix those is to simply un-inline the functions in 
question (and since they are somewhat large that's what I did) - an 
alternative would be to rework the ordering of the file so the functions 
are defined before their first use.


Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

diff -up linux-2.6.10-rc3-bk16-orig/drivers/char/mxser.c linux-2.6.10-rc3-bk16/drivers/char/mxser.c
--- linux-2.6.10-rc3-bk16-orig/drivers/char/mxser.c	2004-12-23 23:26:48.000000000 +0100
+++ linux-2.6.10-rc3-bk16/drivers/char/mxser.c	2004-12-24 01:54:15.000000000 +0100
@@ -410,9 +410,9 @@ static void mxser_start(struct tty_struc
 static void mxser_hangup(struct tty_struct *);
 static void mxser_rs_break(struct tty_struct *, int);
 static irqreturn_t mxser_interrupt(int, void *, struct pt_regs *);
-static inline void mxser_receive_chars(struct mxser_struct *, int *);
-static inline void mxser_transmit_chars(struct mxser_struct *);
-static inline void mxser_check_modem_status(struct mxser_struct *, int);
+static void mxser_receive_chars(struct mxser_struct *, int *);
+static void mxser_transmit_chars(struct mxser_struct *);
+static void mxser_check_modem_status(struct mxser_struct *, int);
 static int mxser_block_til_ready(struct tty_struct *, struct file *, struct mxser_struct *);
 static int mxser_startup(struct mxser_struct *);
 static void mxser_shutdown(struct mxser_struct *);
@@ -1989,7 +1989,7 @@ static irqreturn_t mxser_interrupt(int i
 	return handled;
 }
 
-static inline void mxser_receive_chars(struct mxser_struct *info, int *status)
+static void mxser_receive_chars(struct mxser_struct *info, int *status)
 {
 	struct tty_struct *tty = info->tty;
 	unsigned char ch, gdl;
@@ -2143,7 +2143,7 @@ intr_old:
 
 }
 
-static inline void mxser_transmit_chars(struct mxser_struct *info)
+static void mxser_transmit_chars(struct mxser_struct *info)
 {
 	int count, cnt;
 	unsigned long flags;
@@ -2206,7 +2206,7 @@ static inline void mxser_transmit_chars(
 	spin_unlock_irqrestore(&info->slock, flags);
 }
 
-static inline void mxser_check_modem_status(struct mxser_struct *info, int status)
+static void mxser_check_modem_status(struct mxser_struct *info, int status)
 {
 	/* update input line counters */
 	if (status & UART_MSR_TERI)



