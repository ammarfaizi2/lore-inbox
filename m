Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262179AbTERTgW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 May 2003 15:36:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262177AbTERTgV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 May 2003 15:36:21 -0400
Received: from smtp03.uc3m.es ([163.117.136.123]:16910 "HELO smtp.uc3m.es")
	by vger.kernel.org with SMTP id S262176AbTERTgT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 May 2003 15:36:19 -0400
From: "Peter T. Breuer" <ptb@it.uc3m.es>
Message-Id: <200305181949.h4IJn9L05083@oboe.it.uc3m.es>
Subject: Re: recursive spinlocks. Shoot.
In-Reply-To: <Pine.LNX.4.55.0305181228390.3568@bigblue.dev.mcafeelabs.com> from
 Davide Libenzi at "May 18, 2003 12:31:03 pm"
To: Davide Libenzi <davidel@xmailserver.org>
Date: Sun, 18 May 2003 21:49:09 +0200 (MET DST)
Cc: "Peter T. Breuer" <ptb@it.uc3m.es>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Anonymously-To: 
Reply-To: ptb@it.uc3m.es
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Davide Libenzi wrote:"
> On Sun, 18 May 2003, Peter T. Breuer wrote:
> > Going against is the point that it may be slower.  Can you dig out your
> > implementation and show me it?  I wasn't going for assembler in my hasty
> > example.  I just wanted to establish that it's easy, so that it becomes
> 
> It was something like this. The real code should be in 2.2.x I believe.
> The problem at the time was nested ( recursive ) spinlocks.
> 
> 
> typedef struct s_nestlock {
> 	spinlock_t lock;
> 	void *uniq;
> 	atomic_t count;
> } nestlock_t;

This is essentially the same struct as mine. I used the pid of the task,
where you use the address of the task. You use an atomic count, whereas
I used an ordinary int, guarded by the embedded spinlock.


> #define nestlock_lock(snl) \
> 	do { \
> 		if ((snl)->uniq == current) { \

That would be able to read uniq while it is being written by something
else (which it can, according to the code below). It needs protection.
Probably you want the (< 24 bit) pid instead and to use atomic ops on
it.

> 			atomic_inc(&(snl)->count); \

OK, that's the same.

> 		} else { \
> 			spin_lock(&(snl)->lock); \
> 			atomic_inc(&(snl)->count); \
> 			(snl)->uniq = current; \

Hmm .. else we wait for the lock, and then set count and uniq, while
somebody else may have entered and be reading it :-). You exit with
the embedded lock held, while I used the lock only as a guard to
make the ops atomic.

> 		} \
> 	} while (0)
> 
> #define nestlock_unlock(snl) \
> 	do { \
> 		if (atomic_dec_and_test(&(snl)->count)) { \
> 			(snl)->uniq = NULL; \
> 			spin_unlock(&(snl)->lock); \

That's OK.

> 		} \
> 	} while (0)


Well, it's not assembler either, but at least it's easily comparable
with the nonrecursive version. It's essentially got an extra if and
an inc in the lock. That's all.

I suspect that the rwlock assembler can be coerced to do the job.

Peter
