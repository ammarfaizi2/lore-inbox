Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261641AbVF1Gom@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261641AbVF1Gom (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 02:44:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261899AbVF1Gn5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 02:43:57 -0400
Received: from mx2.elte.hu ([157.181.151.9]:60636 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261718AbVF1Gmt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 02:42:49 -0400
Date: Tue, 28 Jun 2005 08:42:09 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Roland McGrath <roland@redhat.com>
Cc: Oleg Nesterov <oleg@tv-sign.ru>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] de_thread: eliminate unneccessary sighand locking
Message-ID: <20050628064209.GA29540@elte.hu>
References: <42C0EB8A.4F6F1336@tv-sign.ru> <200506280627.j5S6RBSd027251@magilla.sf.frob.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200506280627.j5S6RBSd027251@magilla.sf.frob.com>
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

> That is not the scenario.  Something else must hold tasklist_lock 
> while acquiring ourtask->sighand->siglock, but need not hold 
> tasklist_lock throughout.  Someone can be holding oldsighand->lock but 
> not not tasklist_lock, at the time we lock tasklist_lock.  So like I 
> said, we need to hold oldsighand->siglock until the switch has been 
> done.
> 
> It's possible that no such scenarios exist, but I'd really have to 
> check on that.  My recollection is that there might be some.

i have checked it when acking the patch and it does not seem we do that 
anywhere in the kernel. It would also be dangerous as per Oleg's 
observations, unless something like this is done:

	read_lock(&tasklist_lock);
	p = find_task_by_pid(pid);
	task_lock(p);
	spin_lock(&p->sighand->siglock);
	read_unlock(&tasklist_lock);

	...

do you know any such code?

> > Just for my education, could you please point me to the existed example?
> 
> It would require some auditing to hunt down whether they exist or 
> don't. To make the change you suggest would require complete 
> confidence none exist.

i have manually reviewed every .[ch] file that uses tasklist_lock, 
siglock and lock_task:

  fs/proc/array.c
  fs/exec.c
  kernel/ptrace.c
  kernel/fork.c
  kernel/exit.c
  kernel/sys.c
  include/linux/sched.h
  security/selinux/hooks.c

can other valid locking variations exist, other than the one i outlined 
above?

	Ingo
