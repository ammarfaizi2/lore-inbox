Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932244AbWCXSfc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932244AbWCXSfc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 13:35:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751357AbWCXSfb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 13:35:31 -0500
Received: from iron.cat.pdx.edu ([131.252.208.92]:52188 "EHLO iron.cat.pdx.edu")
	by vger.kernel.org with ESMTP id S1751144AbWCXSfb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 13:35:31 -0500
Date: Fri, 24 Mar 2006 10:34:53 -0800 (PST)
From: Suzanne Wood <suzannew@cs.pdx.edu>
Message-Id: <200603241834.k2OIYrB3006877@baham.cs.pdx.edu>
To: akpm@osdl.org, oleg@tv-sign.ru
Cc: kiran@scalex86.org, linux-kernel@vger.kernel.org, paulmck@us.ibm.com,
       suzannew@cs.pdx.edu
Subject: Re: [PATCH 2.6.16-mm1] cleanup __exit_signal->cleanup_sighand path
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you.  This looks good.  It clarifies the setting of tsk->sighand to NULL 
before releasing siglock as you suggested earlier on LKML.

And it addresses all the occurrences in the mm-kernel of cleanup_sighand() to 
become __cleanup_sighand() with the different argument -- paralleling the 
__cleanup_signal().

The patch draws attention to __exit_signal() of fork.c and when the decremented 
sig->count doesn't go to zero, the 'else' branch of the conditional, after 
incrementing several counter fields of sig, sets sig to NULL to morph it 
into a flag -- interesting.
Thanks.
Suzanne

  > From Oleg Nesterov Thu Mar 23 10:59:36 2006

  > This patch moves 'tsk->sighand = NULL' from cleanup_sighand() to
  > __exit_signal(). This makes the exit path more understandable and
  > allows us to do cleanup_sighand() outside of ->siglock protected
  > section.

  > Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

  > --- MM/include/linux/sched.h~1_ESCS	2006-03-23 22:48:10.000000000 +0300
  > +++ MM/include/linux/sched.h	2006-03-23 23:00:02.000000000 +0300
  > @@ -1184,7 +1184,7 @@ extern void exit_thread(void);
  >  
  >  extern void exit_files(struct task_struct *);
  >  extern void __cleanup_signal(struct signal_struct *);
  > -extern void cleanup_sighand(struct task_struct *);
  > +extern void __cleanup_sighand(struct sighand_struct *);
  >  extern void exit_itimers(struct signal_struct *);
  >  
  >  extern NORET_TYPE void do_group_exit(int);
  > --- MM/kernel/fork.c~1_ESCS	2006-03-23 22:48:10.000000000 +0300
  > +++ MM/kernel/fork.c	2006-03-23 22:59:33.000000000 +0300
  > @@ -808,12 +808,8 @@ static inline int copy_sighand(unsigned 
  >  	return 0;
  >  }
  >  
  > -void cleanup_sighand(struct task_struct *tsk)
  > +void __cleanup_sighand(struct sighand_struct *sighand)
  >  {
  > -	struct sighand_struct * sighand = tsk->sighand;
  > -
  > -	/* Ok, we're done with the signal handlers */
  > -	tsk->sighand = NULL;
  >  	if (atomic_dec_and_test(&sighand->count))
  >  		kmem_cache_free(sighand_cachep, sighand);
  >  }
  > @@ -1232,7 +1228,7 @@ bad_fork_cleanup_mm:
  >  bad_fork_cleanup_signal:
  >  	cleanup_signal(p);
  >  bad_fork_cleanup_sighand:
  > -	cleanup_sighand(p);
  > +	__cleanup_sighand(p->sighand);
  >  bad_fork_cleanup_fs:
  >  	exit_fs(p); /* blocking */
  >  bad_fork_cleanup_files:
  > --- MM/kernel/exit.c~1_ESCS	2006-03-23 22:48:10.000000000 +0300
  > +++ MM/kernel/exit.c	2006-03-23 23:02:53.000000000 +0300
  > @@ -114,10 +114,11 @@ static void __exit_signal(struct task_st
  >  	__unhash_process(tsk);
  >  
  >  	tsk->signal = NULL;
  > -	cleanup_sighand(tsk);
  > +	tsk->sighand = NULL;
  >  	spin_unlock(&sighand->siglock);
  >  	rcu_read_unlock();
  >  
  > +	__cleanup_sighand(sighand);
  >  	clear_tsk_thread_flag(tsk,TIF_SIGPENDING);
  >  	flush_sigqueue(&tsk->pending);
  >  	if (sig) {

