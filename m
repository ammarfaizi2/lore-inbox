Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266585AbUJSJdW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266585AbUJSJdW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 05:33:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268101AbUJSJdW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 05:33:22 -0400
Received: from mx2.elte.hu ([157.181.151.9]:4557 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S266585AbUJSJdS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 05:33:18 -0400
Date: Tue, 19 Oct 2004 11:34:14 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-rc4-mm1-U5
Message-ID: <20041019093414.GA18086@elte.hu>
References: <20041013061518.GA1083@elte.hu> <20041014002433.GA19399@elte.hu> <20041014143131.GA20258@elte.hu> <20041014234202.GA26207@elte.hu> <20041015102633.GA20132@elte.hu> <20041016153344.GA16766@elte.hu> <20041018145008.GA25707@elte.hu> <1098173546.12223.737.camel@thomas> <20041019090428.GA17204@elte.hu> <1098176615.12223.753.camel@thomas>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1098176615.12223.753.camel@thomas>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Thomas Gleixner <tglx@linutronix.de> wrote:

> On Tue, 2004-10-19 at 11:04, Ingo Molnar wrote:
> > > All sleep_on variants trigger the irqs_disabled() check in schedule(). 
> > > tglx
> > 
> > ah, forgot that the waitqueue lock is a raw lock. Is there _any_
> > scenario where sleep_on() is actually correct kernel code?
> 
> Hmm, the sleep_on() variants are used quite a lot over the kernel.
> Whats wrong with them and to what should they be converted ?

they are racy on SMP. It does:

	current->state = TASK_INTERRUPTIBLE;

	schedule();

which is almost always a bug to go to sleep via sleep_on() _after_
checking for the condition, because the following could happen:

	CPU1				CPU2

	if (condition)
		goto done;

					wake_up(&waitqueue);

	current->state = TASK_INTERRUPTIBLE;

	schedule();

The proper interface is wait_event() (and variants).

your patch probably only works due to timing - the wakeup always happens
after sleep_on() has been called.

this particular NFS case is probably only correct due to userspace
behavior. The code is apparently relying on the wake_up() never
happening _before_ we do the sleep_on().

so, could you try the init_MUTEX_LOCKED() fix plus the patch below -
does that turn off the deadlock assert? (Plus also uncomment the
RWSEM_BUG() around line 130.)

	Ingo

--- linux/lib/rwsem-generic.c.orig
+++ linux/lib/rwsem-generic.c
@@ -750,6 +750,15 @@ void fastcall sema_init(struct semaphore
 	case 0:
 		init_rwsem(&sem->lock);
 		down(sem);
+#ifdef CONFIG_RWSEM_DEADLOCK_DETECT
+		{
+			unsigned long flags;
+
+			rwsem_lock_irqsave(&rwsem_lock, flags);
+			rwsem_owner_del(&sem->lock);
+			rwsem_unlock_irqrestore(&rwsem_lock, flags);
+		}
+#endif
 		break;
 	default:
 		RWSEM_BUG();
