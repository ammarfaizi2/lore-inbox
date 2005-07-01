Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263254AbVGAG5t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263254AbVGAG5t (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Jul 2005 02:57:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263256AbVGAG5t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Jul 2005 02:57:49 -0400
Received: from mx1.elte.hu ([157.181.1.137]:42417 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S263254AbVGAG5g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Jul 2005 02:57:36 -0400
Date: Fri, 1 Jul 2005 08:57:21 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Keith Owens <kaos@ocs.com.au>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.13-rc1 CONFIG_DEBUG_SPINLOCK is useless on SMP
Message-ID: <20050701065721.GA17321@elte.hu>
References: <6140.1120192710@kao2.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6140.1120192710@kao2.melbourne.sgi.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Keith Owens <kaos@ocs.com.au> wrote:

> 2.6.13-rc1 built with SMP=Y and DEBUG_SPINLOCK=y.  That uses 
> kernel/spinlock.c instead of the inline definitions of the spinlock 
> functions.  Alas only the inline definitions test for 
> DEBUG_SPINLOCK=y, none of the code in in spinlock.c has any debug 
> facilities.

the spinlock cleanups in -mm (not yet in -git) obsolete most of the 
debugging approach of the current kernel.

but even in terms of 2.6.13-rc1, i'm not completely sure what you mean.
Yes, there's no debugging code in kernel/spinlock.c because much of the
DEBUG_SPINLOCK code (under the old method) is located in the arch
spinlock.h files. I.e. on x86 you'll get SMP spinlock debugging from
asm-i386/spinlock.h:

 static inline void _raw_spin_lock(spinlock_t *lock)
 {
 #ifdef CONFIG_DEBUG_SPINLOCK
         if (unlikely(lock->magic != SPINLOCK_MAGIC)) {
                 printk("eip: %p\n", __builtin_return_address(0));
                 BUG();
         }
 #endif

the only practical exception is when CONFIG_PREEMPT is enabled: the arch 
level trylock, upon which the PREEMPT spinlocks rely on heavily, has no 
meaningful DEBUG_SPINLOCK checks. (but PREEMPT has other checks which 
partly offset this.) In any case, this too is fixed by my spinlock 
cleanups - there all debugging is done centrally in 
lib/spinlock_debug.c.

	Ingo
