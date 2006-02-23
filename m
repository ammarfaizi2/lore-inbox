Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751239AbWBWNzb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751239AbWBWNzb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 08:55:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751244AbWBWNzb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 08:55:31 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:44238 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751239AbWBWNza (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 08:55:30 -0500
Date: Thu, 23 Feb 2006 14:53:50 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Bill Huey <billh@gnuppy.monkey.org>
Cc: linux-kernel@vger.kernel.org, Esben Nielsen <simlo@phys.au.dk>,
       Thomas Gleixner <tglx@linutronix.de>,
       Steven Rostedt <rostedt@goodmis.org>
Subject: Re: 2.6.15-rt17
Message-ID: <20060223135350.GA20638@elte.hu>
References: <20060221155548.GA30146@elte.hu> <20060223134928.GA30170@gnuppy.monkey.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060223134928.GA30170@gnuppy.monkey.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Bill Huey <billh@gnuppy.monkey.org> wrote:

> On Tue, Feb 21, 2006 at 04:55:48PM +0100, Ingo Molnar wrote:
> > another change is the reworking of the SLAB code: it now closely matches 
> > the upstream SLAB code, and it should now work on NUMA systems too 
> > (untested though).
> 
> SLAB you say ? What's going on with this error ?
> 
> ----
> mm/built-in.o: In function `drain_alien_cache':slab.c:(.text+0x1fb2c):
> undefined reference to `slab_spin_unlock_irqrestore'
> make: *** [.tmp_vmlinux1] Error 1
> ----

find the fix from S�bastien Dugu� below.

	Ingo

Index: linux-2.6.15-rt17-numa/mm/slab.c
===================================================================
--- linux-2.6.15-rt17-numa.orig/mm/slab.c	2006-02-22 10:38:26.000000000 +0100
+++ linux-2.6.15-rt17-numa/mm/slab.c	2006-02-22 11:12:42.000000000 +0100
@@ -163,8 +163,8 @@
 				 	spin_unlock_irq(lock)
 # define slab_spin_lock_irqsave(lock, flags, cpu) \
  	do { spin_lock_irqsave(lock, flags); (cpu) = smp_processor_id(); } while (0)
-# define slab_spin_lock_irqrestore(lock, flags, cpu) \
- 	do { spin_lock_irqrestore(lock, flags); } while (0)
+# define slab_spin_unlock_irqrestore(lock, flags, cpu) \
+ 	do { spin_unlock_irqrestore(lock, flags); } while (0)
 #else
 DEFINE_PER_CPU_LOCKED(int, slab_locks) = { 0, };
 # define slab_irq_disable(cpu)		get_cpu_var_locked(slab_locks, &(cpu))
@@ -183,8 +183,8 @@
 		do { spin_unlock(lock); slab_irq_enable(cpu); } while (0)
 # define slab_spin_lock_irqsave(lock, flags, cpu) \
  	do { slab_irq_disable(cpu); spin_lock_irqsave(lock, flags); } while (0)
-# define slab_spin_lock_irqrestore(lock, flags, cpu) \
- 	do { spin_lock_irqrestore(lock, flags); slab_irq_enable(cpu); } while (0)
+# define slab_spin_unlock_irqrestore(lock, flags, cpu) \
+ 	do { spin_unlock_irqrestore(lock, flags); slab_irq_enable(cpu); } while (0)
 #endif
 
 /* Shouldn't this be in a header file somewhere? */
