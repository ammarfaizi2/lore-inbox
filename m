Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261356AbULXBKL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261356AbULXBKL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Dec 2004 20:10:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261353AbULXBKL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Dec 2004 20:10:11 -0500
Received: from mail.dif.dk ([193.138.115.101]:11974 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S261357AbULXBJp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Dec 2004 20:09:45 -0500
Date: Fri, 24 Dec 2004 02:20:32 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Jesper Juhl <juhl-lkml@dif.dk>, Alan Cox <alan@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fix inlining related build failures in mxser.c
In-Reply-To: <20041224005900.GA22106@devserv.devel.redhat.com>
Message-ID: <Pine.LNX.4.61.0412240215400.3504@dragon.hygekrogen.localhost>
References: <Pine.LNX.4.61.0412240155070.3504@dragon.hygekrogen.localhost>
 <20041224005900.GA22106@devserv.devel.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Linus,

Sending this to you as pr Alan's request.

On Thu, 23 Dec 2004, Alan Cox wrote:

> On Fri, Dec 24, 2004 at 02:01:18AM +0100, Jesper Juhl wrote:
> > An allyesconfig build of 2.6.10-rc3-bk16 revealed the following build 
> > failures (which arefixed by the patch below) :
> 
> Please send it on to Linus. I've never tried to build any moxa driver with
> such a new compiler version. It looks the right thing to do.
> 
> (Moxa support removed from cc list)
> 
> Alan
> 

Simple way to fix those is to simply un-inline the functions in question 
(and since they are somewhat large that's what I did) - an alternative 
would be to rework the ordering of the file so the functions are defined 
before their first use.
(for the actual build errors see my original post to Alan/lkml with same 
subject - I got this with gcc 3.4.1 btw)


Signed-off-by: Jesper juhl <juhl-lkml@dif.dk>

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



