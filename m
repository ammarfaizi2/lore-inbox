Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267492AbSLSBpx>; Wed, 18 Dec 2002 20:45:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267494AbSLSBpx>; Wed, 18 Dec 2002 20:45:53 -0500
Received: from fmr01.intel.com ([192.55.52.18]:50896 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id <S267492AbSLSBpv>;
	Wed, 18 Dec 2002 20:45:51 -0500
Message-ID: <A46BBDB345A7D5118EC90002A5072C7806CACA2D@orsmsx116.jf.intel.com>
From: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
To: "'Robert Love'" <rml@tech9.net>,
       "'torvalds@transmeta.com'" <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: RE: [PATCH 2.5.52] Use __set_current_state() instead of current->
	 state = (take 1)
Date: Wed, 18 Dec 2002 17:53:50 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="ISO-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > Agreed; however, I also don't want to introduce unnecessary
> > bloat, so I need to understand first what cases need it - it
> > is kind of hard for me. Care to let me know some gotchas?
> 
> set_current_state() includes a write barrier to ensure the setting of
> the state is flushed before any further instructions.  This is to
> provide a memory barrier for weak-ordering processors that 
> can and will rearrange the writes.

It is what I was expecting, given xchg() being in the equation;
then it is reduced to a problem of guessing what can be the 
delay for the flushing of the write ... beautiful ...

So, in that scenario, it means that:

- any setting before a return should be barriered unless we 
  return to a place[s] known to be harmless

- any setting to TASK_RUNNING should be kind of safe

- exec.c:de_thread(), 

 	while (atomic_read(&oldsig->count) > count) {
 		oldsig->group_exit_task = current;
-		current->state = TASK_UNINTERRUPTIBLE;
+		__set_current_state(TASK_UNINTERRUPTIBLE);
 		spin_unlock_irq(&oldsig->siglock);

  Should be safe, as spin_unlock_irq() will do memory clobber
  on sti() [undependant from UP/SMP].

- namei.c:do_follow_link()


 	if (current->total_link_count >= 40)
 		goto loop;
 	if (need_resched()) {
-		current->state = TASK_RUNNING;
+		__set_current_state(TASK_RUNNING);
 		schedule();
 	}
 	err = security_inode_follow_link(dentry, nd);

  There is a function for it, cond_resched().

So, sending an updated patch right now

> Not all processors like those made by your employer are 
> strongly-ordered :)

You'd be surprised how little about those gory details I do know :]

Inaky Perez-Gonzalez -- Not speaking for Intel - opinions are my own [or my
fault]

