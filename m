Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261940AbVF1HFl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261940AbVF1HFl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 03:05:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261889AbVF1HEV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 03:04:21 -0400
Received: from graphe.net ([209.204.138.32]:61363 "EHLO graphe.net")
	by vger.kernel.org with ESMTP id S261860AbVF1HCC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 03:02:02 -0400
Date: Tue, 28 Jun 2005 00:01:45 -0700 (PDT)
From: Christoph Lameter <christoph@lameter.com>
X-X-Sender: christoph@graphe.net
To: Kirill Korotaev <dev@sw.ru>
cc: Pavel Machek <pavel@ucw.cz>, Linus Torvalds <torvalds@osdl.org>,
       linux-mm@kvack.org, linux-kernel@vger.kernel.org, raybry@engr.sgi.com,
       Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
Subject: Re: [RFC] Fix SMP brokenness for PF_FREEZE and make freezing usable
 for other purposes
In-Reply-To: <42C0EBAB.8070709@sw.ru>
Message-ID: <Pine.LNX.4.62.0506272323490.30956@graphe.net>
References: <Pine.LNX.4.62.0506241316370.30503@graphe.net>
 <20050625025122.GC22393@atrey.karlin.mff.cuni.cz> <Pine.LNX.4.62.0506242311220.7971@graphe.net>
 <20050626023053.GA2871@atrey.karlin.mff.cuni.cz> <Pine.LNX.4.62.0506251954470.26198@graphe.net>
 <20050626030925.GA4156@atrey.karlin.mff.cuni.cz> <Pine.LNX.4.62.0506261928010.1679@graphe.net>
 <Pine.LNX.4.58.0506262121070.19755@ppc970.osdl.org>
 <Pine.LNX.4.62.0506262249080.4374@graphe.net> <20050627141320.GA4945@atrey.karlin.mff.cuni.cz>
 <Pine.LNX.4.62.0506270804450.17400@graphe.net> <42C0EBAB.8070709@sw.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: -5.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Jun 2005, Kirill Korotaev wrote:

> > -static inline int freezing(struct task_struct *p)
> > -{
> > -	return p->flags & PF_FREEZE;
> > -}
> > +#if defined(CONFIG_PM) || defined(CONFIG_MIGRATE)
> <<<< why not to make a single option CONFIG_REFRIGERATOR? It looks to be a
> more robust way, since there are multiple users of it.

Yes. That may be better. We can do that once the migration code is 
finished and when we know what kind of CONFIG_XXX the migration code 
really needs.

> > +#ifdef CONFIG_PM
> <<<< is it intentionaly? or you just lost CONFIG_MIGRATE?

It is intentional. freeze_processes and thaw_processes are only needed 
for suspend. One only needs to freeze a couple of processes for process 
migration.

> <<<< I still think this refrigerator is racy with freeze_processes():
> <<<< scenarios:
> <<<< scenario 1
> <<<<
> task1 -> freeze_processes():			taskXXX ->refrigerator()
>   checked (task->flags & PF_FROZEN) == 0	cur->flags |= PF_FROZEN
> 						clear TIF_FREEZE
> 						<sleep on thaw>
>   set TIF_FREEZING
> 						clear PF_FROZEN
> 
> <<<< so the task awakes with TIF_FREEZE flag set!!!

Hmm... If we wait to clear both flags until after the completion 
notification then we do not have the race right? But then we need to move 
the signal recalc since it tests for TIF_FREEZE too.
 
> <<<< scenario 2
> <<<< look at error path in freeze_processes (on timeout), it is broken as
> well. You need to wakeup tasks there...

Ok. How about this additional patch? This still requires that process 
freezing does not immediately occurr again after the completion 
handler. All of this is iffy due to not having a real lock protecting all 
these values and we may still need to add some barriers.

Index: linux-2.6.12/kernel/power/process.c
===================================================================
--- linux-2.6.12.orig/kernel/power/process.c	2005-06-28 06:34:52.000000000 +0000
+++ linux-2.6.12/kernel/power/process.c	2005-06-28 06:40:28.000000000 +0000
@@ -47,12 +47,13 @@ int freeze_processes(void)
 			unsigned long flags;
 			if (!freezeable(p))
 				continue;
-			if ((p->flags & PF_FROZEN) ||
-			    (p->state == TASK_TRACED) ||
+			if ((p->state == TASK_TRACED) ||
 			    (p->state == TASK_STOPPED))
 				continue;
 
 			set_thread_flag(TIF_FREEZE);
+			if (p->flags & PF_FROZEN)
+				continue;
 			spin_lock_irqsave(&p->sighand->siglock, flags);
 			signal_wake_up(p, 0);
 			spin_unlock_irqrestore(&p->sighand->siglock, flags);
@@ -63,6 +64,8 @@ int freeze_processes(void)
 		if (time_after(jiffies, start_time + TIMEOUT)) {
 			printk( "\n" );
 			printk(KERN_ERR " stopping tasks failed (%d tasks remaining)\n", todo );
+			complete_all(&thaw);
+			up(&freezer_sem);
 			return todo;
 		}
 	} while(todo);
Index: linux-2.6.12/kernel/sched.c
===================================================================
--- linux-2.6.12.orig/kernel/sched.c	2005-06-28 06:34:52.000000000 +0000
+++ linux-2.6.12/kernel/sched.c	2005-06-28 06:37:36.000000000 +0000
@@ -5210,13 +5210,13 @@ DECLARE_COMPLETION(thaw);
 void refrigerator(void)
 {
 	current->flags |= PF_FROZEN;
+	wait_for_completion(&thaw);
 	clear_thread_flag(TIF_FREEZE);
+	current->flags &= ~PF_FROZEN;
 	/* A fake signal 0 may have been sent. Recalculate sigpending */
 	spin_lock_irq(&current->sighand->siglock);
 	recalc_sigpending();
 	spin_unlock_irq(&current->sighand->siglock);
-	wait_for_completion(&thaw);
-	current->flags &= ~PF_FROZEN;
 }
 EXPORT_SYMBOL(refrigerator);
 #endif
