Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283166AbRK2LJy>; Thu, 29 Nov 2001 06:09:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283168AbRK2LJp>; Thu, 29 Nov 2001 06:09:45 -0500
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:32253 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S283166AbRK2LJd>; Thu, 29 Nov 2001 06:09:33 -0500
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <E169MJp-0007m6-00@the-village.bc.nu> 
In-Reply-To: <E169MJp-0007m6-00@the-village.bc.nu> 
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: tao@acc.umu.se (David Weinehall),
        linux-kernel@vger.kernel.org (Linux-Kernel Mailing List),
        torvalds@transmeta.com
Subject: Re: Poke in the eye regarding sleep_on 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 29 Nov 2001 11:09:11 +0000
Message-ID: <15351.1007032151@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


alan@lxorguk.ukuu.org.uk said:
> > Since the 2.5 work now has begun, I should remind you Alan that you
> > promised on this listto take care of getting rid of sleep_on for good
> > just as soon as this tree opened.

> That was David Woodhouse.. but he is right

There are still cases where it's just about OK to use sleep_on(). If you
_and_ your waker will hold the BKL, or if you call it with IRQs disabled and
are woken from an ISR, which is horrible but does currently work. Also if
you just don't _care_ if you miss a wakeup sometimes.

ISTR much filesystem code falls into the former category at the moment.
 
We _should_ remove sleep_on and friends, but let's start with this patch, 
which allows us to clean up the filesystem code later...

Note that I haven't put the check in the _timeout versions. Maybe we should.

Index: kernel/sched.c
===================================================================
RCS file: /inst/cvs/linux/kernel/sched.c,v
retrieving revision 1.4.2.57
diff -u -r1.4.2.57 sched.c
--- kernel/sched.c	22 Nov 2001 08:41:45 -0000	1.4.2.57
+++ kernel/sched.c	29 Nov 2001 10:57:48 -0000
@@ -777,6 +777,12 @@
 	wait_queue_t wait;			\
 	init_waitqueue_entry(&wait, current);
 
+#define SLEEP_ON_CHECK										\
+	if (current->lock_depth == -1) {							\
+		printk(KERN_WARNING __FUNCTION__ " called without BKL. Probable race.\n");	\
+		BUG();										\
+	}	
+		
 #define	SLEEP_ON_HEAD					\
 	wq_write_lock_irqsave(&q->lock,flags);		\
 	__add_wait_queue(q, &wait);			\
@@ -790,6 +796,7 @@
 void interruptible_sleep_on(wait_queue_head_t *q)
 {
 	SLEEP_ON_VAR
+	SLEEP_ON_CHECK
 
 	current->state = TASK_INTERRUPTIBLE;
 
@@ -814,6 +821,7 @@
 void sleep_on(wait_queue_head_t *q)
 {
 	SLEEP_ON_VAR
+	SLEEP_ON_CHECK
 	
 	current->state = TASK_UNINTERRUPTIBLE;
 



--
dwmw2


