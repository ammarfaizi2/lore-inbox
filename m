Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261184AbUEXHEb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261184AbUEXHEb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 May 2004 03:04:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262873AbUEXHEb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 May 2004 03:04:31 -0400
Received: from mx2.elte.hu ([157.181.151.9]:11165 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261184AbUEXHE3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 May 2004 03:04:29 -0400
Date: Mon, 24 May 2004 11:05:38 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>,
       rmk+lkml@arm.linux.org.uk
Subject: Re: scheduler: IRQs disabled over context switches
Message-ID: <20040524090538.GA26183@elte.hu>
References: <20040523174359.A21153@flint.arm.linux.org.uk> <20040524083715.GA24967@elte.hu> <Pine.LNX.4.58.0405232340070.2676@bigblue.dev.mdolabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0405232340070.2676@bigblue.dev.mdolabs.com>
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


* Davide Libenzi <davidel@xmailserver.org> wrote:

> We used to do it in 2.4. What changed to make it fragile? The
> threading (TLS) thing?

it _should_ work, but in the past we only had trouble from such changes
(at least in the O(1) tree of scheduling - 2.4 scheduler is OK.). We
could try the patch below. It certainly boots on SMP x86. But it causes
a 3.5% slowdown in lat_ctx so i'd not do it unless there are some really
good reasons.

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
+			spin_unlock(&(rq)->lock);		\
+		} while (0)
+# define finish_arch_switch(rq, prev) \
+		spin_unlock_irq(&(prev)->switch_lock)
+# define task_running(rq, p) \
+		((rq)->curr == (p) || spin_is_locked(&(p)->switch_lock))
 #endif
 
 /*
