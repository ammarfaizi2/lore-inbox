Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262282AbVAUGfi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262282AbVAUGfi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 01:35:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262283AbVAUGfh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 01:35:37 -0500
Received: from mx1.elte.hu ([157.181.1.137]:26785 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262282AbVAUGf2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 01:35:28 -0500
Date: Fri, 21 Jan 2005 07:35:19 +0100
From: Ingo Molnar <mingo@elte.hu>
To: George Anzinger <george@mvista.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] to fix xtime lock for in the RT kernel patch
Message-ID: <20050121063519.GA19954@elte.hu>
References: <41F04573.7070508@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41F04573.7070508@mvista.com>
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


* George Anzinger <george@mvista.com> wrote:

> It seems to me that we need to either do the attached or to rewrite
> the timer front end code to just gather the offset info and defer to
> the timer irq thread to update jiffies and the offset stuff.  In
> either case we really can not split the two and we do need the
> xtime_lock protection.

how about the patch below? One of the important benefits of the threaded
timer IRQ is the ability to make xtime_lock a mutex.

	Ingo

--- linux/arch/i386/kernel/time.c.orig2	
+++ linux/arch/i386/kernel/time.c	
@@ -313,6 +313,7 @@ irqreturn_t timer_interrupt(int irq, voi
 	write_seqlock(&xtime_lock);
 
 	cur_timer->mark_offset();
+	do_timer(regs);
  
 	do_timer_interrupt(irq, NULL, regs);
 
--- linux/include/asm-i386/mach-default/do_timer.h.orig2	
+++ linux/include/asm-i386/mach-default/do_timer.h	
@@ -16,7 +16,6 @@
 
 static inline void do_timer_interrupt_hook(struct pt_regs *regs)
 {
-	do_timer(regs);
 #ifndef CONFIG_SMP
 	update_process_times(user_mode(regs));
 #endif
