Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268254AbUIWE1D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268254AbUIWE1D (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 00:27:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268257AbUIWE1C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 00:27:02 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:3976 "EHLO
	pd4mo3so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S268254AbUIWE07 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 00:26:59 -0400
Date: Wed, 22 Sep 2004 22:25:31 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Strangeness with spinlocks declared static
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <000801c4a125$5d0e80f0$6601a8c0@northbrook>
MIME-version: 1.0
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
X-Mailer: Microsoft Outlook Express 6.00.2900.2180
Content-type: text/plain; reply-type=original; charset=iso-8859-1; format=flowed
Content-transfer-encoding: 7bit
X-Priority: 3
X-MSMail-priority: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was recently debugging a Linux driver for a PCI card that was developed 
in-house at our company. I was having a problem whereby a function which did 
a spin_lock_irqsave and spin_unlock_irqsave seemed to hang up sometimes, 
especially when the function was called very rapidly. It appeared that 
sometimes the spin_lock_irqsave was blocking, even though the spinlock 
should not have been locked. (This was on an SMP system, dual Xeon 
processors or 4 logical CPUs.)

The spinlock was declared like this (outside of any function):

static spinlock_t debug_spinlock;

and initialized with spin_lock_init.

Eventually I went and looked at the assembly that gcc was generating for the 
spinlock operations, and noticed that the spin loop appeared to be 
performing operations checking the %ebx register instead of the actual 
memory location of the spinlock. That explains why it was behaving so 
strangely, since clearly another CPU won't be able to see/affect the 
register contents.

I then changed the declaration of the spinlock to do it more like most other 
code I've seen:

spinlock_t debug_spinlock = SPIN_LOCK_UNLOCKED;

When I looked at the code for the operations then, it was operating on the 
spinlock in memory as I expected, and the hang problem went away.

This was on Red Hat 9, kernel version 2.4.20-31.9, compiler version gcc 
3.2.2.

I am curious whether this is a known/unknown gcc bug, or whether the 
declaration as static causes it to legally assume that the spinlock counter 
can be cached in a register? The latter seems rather insane to me, 
considering that the lock variable inside the spinlock_t is declared as 
volatile..

