Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265095AbUD3HI2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265095AbUD3HI2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Apr 2004 03:08:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265096AbUD3HI2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Apr 2004 03:08:28 -0400
Received: from fw.osdl.org ([65.172.181.6]:25764 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265095AbUD3HIW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Apr 2004 03:08:22 -0400
Date: Fri, 30 Apr 2004 00:07:51 -0700
From: Andrew Morton <akpm@osdl.org>
To: Keith Owens <kaos@sgi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] 2.6.6-rc3 Allow architectures to reenable interrupts on
 contended spinlocks
Message-Id: <20040430000751.6703e950.akpm@osdl.org>
In-Reply-To: <7094.1083122965@kao2.melbourne.sgi.com>
References: <Pine.LNX.4.58.0404270856260.19703@ppc970.osdl.org>
	<7094.1083122965@kao2.melbourne.sgi.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens <kaos@sgi.com> wrote:
>
>  As requested by Linus, update all architectures to add the common
>  infrastructure.  Tested on ia64 and i386.
> 
> 
>  Enable interrupts while waiting for a disabled spinlock, but only if
>  interrupts were enabled before issuing spin_lock_irqsave().

Please test stuff with CONFIG_SMP=n?

include/linux/sched.h: In function `dequeue_signal_lock':
include/linux/sched.h:795: warning: implicit declaration of function `_raw_spin_lock_flags'

--- 25/include/linux/spinlock.h~allow-architectures-to-reenable-interrupts-on-contended-spinlocks-fix	2004-04-29 23:53:48.357203736 -0700
+++ 25-akpm/include/linux/spinlock.h	2004-04-29 23:54:15.053145336 -0700
@@ -46,6 +46,8 @@
 
 #else
 
+#define _raw_spin_lock_flags(lock, flags) _raw_spin_lock(lock)
+
 #if !defined(CONFIG_PREEMPT) && !defined(CONFIG_DEBUG_SPINLOCK)
 # define atomic_dec_and_lock(atomic,lock) atomic_dec_and_test(atomic)
 # define ATOMIC_DEC_AND_LOCK

_


The feature is only enabled for spin_lock_irqsave().  Should it not also do
something about spin_lock_irq()?

