Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264367AbUFVOsI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264367AbUFVOsI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 10:48:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264206AbUFVOrV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 10:47:21 -0400
Received: from mx2.elte.hu ([157.181.151.9]:28870 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S264444AbUFVOhV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 10:37:21 -0400
Date: Tue, 22 Jun 2004 12:19:14 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Nobuhiro Tachino <ntachino@redhat.com>
Cc: Takao Indoh <indou.takao@soft.fujitsu.com>, linux-kernel@vger.kernel.org,
       Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@muc.de>
Subject: Re: [3/4] [PATCH]Diskdump - yet another crash dump function
Message-ID: <20040622101914.GA20623@elte.hu>
References: <20040617121356.GA24338@elte.hu> <D3C4552C24A60Aindou.takao@soft.fujitsu.com> <40D747B1.9030406@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40D747B1.9030406@redhat.com>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.26.8-itk2 (ELTE 1.1) SpamAssassin 2.63 ClamAV 0.65
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Nobuhiro Tachino <ntachino@redhat.com> wrote:

> Your new dump_run_timers() calls __run_timers() directly. I think
> that's the reason of unstability. __run_timers() calls
> spin_unlock_irq() and enables IRQ, but diskdump expects everything
> runs with IRQ disabled.

indeed!

luckily we can solve this in the upstream kernel without too much fuss,
see the patch below. All callers of __run_timers() run with irqs
enabled.

(NOTE: we unconditionally disable interrupts after having run the timer
fn - this solves the problem of a timer fn keeping irqs disabled.)

does this patch stabilize diskdump?

	Ingo

--- linux/kernel/timer.c.orig
+++ linux/kernel/timer.c
@@ -423,8 +423,9 @@ static int cascade(tvec_base_t *base, tv
 static inline void __run_timers(tvec_base_t *base)
 {
 	struct timer_list *timer;
+	unsigned long flags;
 
-	spin_lock_irq(&base->lock);
+	spin_lock_irqsave(&base->lock, flags);
 	while (time_after_eq(jiffies, base->timer_jiffies)) {
 		struct list_head work_list = LIST_HEAD_INIT(work_list);
 		struct list_head *head = &work_list;
@@ -453,14 +454,14 @@ repeat:
 			set_running_timer(base, timer);
 			smp_wmb();
 			timer->base = NULL;
-			spin_unlock_irq(&base->lock);
+			spin_unlock_irqrestore(&base->lock, flags);
 			fn(data);
 			spin_lock_irq(&base->lock);
 			goto repeat;
 		}
 	}
 	set_running_timer(base, NULL);
-	spin_unlock_irq(&base->lock);
+	spin_unlock_irqrestore(&base->lock, flags);
 }
 
 #ifdef CONFIG_NO_IDLE_HZ
