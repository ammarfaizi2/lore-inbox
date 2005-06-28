Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261933AbVF1HT6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261933AbVF1HT6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 03:19:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261688AbVF1HTa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 03:19:30 -0400
Received: from mx2.elte.hu ([157.181.151.9]:64992 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261504AbVF1HQt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 03:16:49 -0400
Date: Tue, 28 Jun 2005 09:16:24 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Roland McGrath <roland@redhat.com>
Cc: Oleg Nesterov <oleg@tv-sign.ru>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] de_thread: eliminate unneccessary sighand locking
Message-ID: <20050628071624.GA2302@elte.hu>
References: <20050628064209.GA29540@elte.hu> <200506280708.j5S78FtD027410@magilla.sf.frob.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200506280708.j5S78FtD027410@magilla.sf.frob.com>
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


* Roland McGrath <roland@redhat.com> wrote:

> > do you know any such code?
> 
> I was thinking it would look more like:
> 
>  	read_lock(&tasklist_lock);
>  	p = find_task_by_pid(pid);
>  	get_task_struct(p);
>  	read_unlock(&tasklist_lock);
> 	...
> 	spin_lock_irq(&p->sighand->siglock);
> 	...

the amount of potentially affected code (assuming all the locking is 
done in a single .[ch] file) is even smaller:

  kernel/posix-cpu-timers.c
  kernel/exit.c
  kernel/posix-timers.c
  include/linux/sched.h

checked these, we dont seem to do that.

> I am not sure whether such code exists or not.  It won't look quite 
> like that, in that the siglock use may be far away from the 
> extraction.  There are things that store pointers like that (like 
> real_timer.data, and posix_timers stuff).  But it may well be that all 
> those places take tasklist_lock before using the saved task_struct, in 
> which case it's fine. (Anything doing signals stuff usually needs 
> tasklist_lock anyway in case it has to traverse the thread group.)

this reminds me about the patch below: it gets rid of tasklist_lock use 
in the POSIX timer signal delivery critical path.

> You mean those are the files that use all three of those, or what?  
> That's clearly not the complete list of siglock uses.  Any code using 
> siglock needs to be grokked adequately to see if tasklist_lock is 
> always held around looking at ->sighand.

yeah.

	Ingo

---

dont use the tasklist_lock in the POSIX timer-delivery critical path.

Signed-off-by: Ingo Molnar <mingo@elte.hu>

--- linux/kernel/signal.c.orig
+++ linux/kernel/signal.c
@@ -1384,7 +1384,7 @@ send_sigqueue(int sig, struct sigqueue *
 	 * going away or changing from under us.
 	 */
 	BUG_ON(!(q->flags & SIGQUEUE_PREALLOC));
-	read_lock(&tasklist_lock);  
+	task_lock(p);  
 	spin_lock_irqsave(&p->sighand->siglock, flags);
 	
 	if (unlikely(!list_empty(&q->list))) {
@@ -1411,7 +1411,7 @@ send_sigqueue(int sig, struct sigqueue *
 
 out:
 	spin_unlock_irqrestore(&p->sighand->siglock, flags);
-	read_unlock(&tasklist_lock);
+	task_unlock(p);
 	return(ret);
 }
 
