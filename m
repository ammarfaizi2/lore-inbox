Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263413AbUEXHOP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263413AbUEXHOP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 May 2004 03:14:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263664AbUEXHOO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 May 2004 03:14:14 -0400
Received: from mx2.elte.hu ([157.181.151.9]:50847 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S263413AbUEXHNu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 May 2004 03:13:50 -0400
Date: Mon, 24 May 2004 11:15:04 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Davide Libenzi <davidel@xmailserver.org>,
       Linux Kernel List <linux-kernel@vger.kernel.org>,
       rmk+lkml@arm.linux.org.uk
Subject: Re: scheduler: IRQs disabled over context switches
Message-ID: <20040524091504.GC26183@elte.hu>
References: <20040523174359.A21153@flint.arm.linux.org.uk> <20040524083715.GA24967@elte.hu> <Pine.LNX.4.58.0405232340070.2676@bigblue.dev.mdolabs.com> <20040524090538.GA26183@elte.hu> <40B19FF8.2050402@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40B19FF8.2050402@yahoo.com.au>
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


* Nick Piggin <nickpiggin@yahoo.com.au> wrote:

> >+# define prepare_arch_switch(rq, next)				\
> >+		do {						\
> >+			spin_lock(&(next)->switch_lock);	\
> >+			spin_unlock(&(rq)->lock);		\
> 
> spin_unlock_irq?

and spin_unlock in the finish_arch_switch() case, instead of
spin_unlock_irq. New patch below.

	Ingo

--- linux/kernel/sched.c.orig	
+++ linux/kernel/sched.c	
@@ -247,9 +247,15 @@ static DEFINE_PER_CPU(struct runqueue, r
  * Default context-switch locking:
  */
 #ifndef prepare_arch_switch
-# define prepare_arch_switch(rq, next)	do { } while (0)
-# define finish_arch_switch(rq, next)	spin_unlock_irq(&(rq)->lock)
-# define task_running(rq, p)		((rq)->curr == (p))
+# define prepare_arch_switch(rq, next)				\
+		do {						\
+			spin_lock(&(next)->switch_lock);	\
+			spin_unlock_irq(&(rq)->lock);		\
+		} while (0)
+# define finish_arch_switch(rq, prev) \
+		spin_unlock(&(prev)->switch_lock)
+# define task_running(rq, p) \
+		((rq)->curr == (p) || spin_is_locked(&(p)->switch_lock))
 #endif
 
 /*
