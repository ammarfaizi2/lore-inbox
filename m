Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312802AbSCZXH3>; Tue, 26 Mar 2002 18:07:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312803AbSCZXHU>; Tue, 26 Mar 2002 18:07:20 -0500
Received: from [202.135.142.196] ([202.135.142.196]:2313 "EHLO
	wagner.rustcorp.com.au") by vger.kernel.org with ESMTP
	id <S312802AbSCZXHO>; Tue, 26 Mar 2002 18:07:14 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Martin Wirth <martin.wirth@dlr.de>
Cc: Peter =?ISO-8859-1?Q?W=E4chtler?= <pwaechtler@loewe-komp.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Futexes IV (Fast Lightweight Userspace Semaphores) 
In-Reply-To: Your message of "Tue, 26 Mar 2002 09:17:04 BST."
             <3CA02E80.1000600@dlr.de> 
Date: Wed, 27 Mar 2002 10:10:22 +1100
Message-Id: <E16q059-00088e-00@wagner.rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <3CA02E80.1000600@dlr.de> you write:
> 
> >
> >   And on top of them:
> >   futex_down(struct futex *);
> >   futex_up(struct futex *);
> >
> Why not keep the simple one-sys-call interface for the fuxtexes. The 
> code is so small that it is
>  not worth to delete it.

Because it's a premature optimization.  We can add it later if someone
proves it's a major hotspot.  But it may turn out some other primitive
is more important: I'm not smart enough to know.

> >int pthread_cond_wait(pthread_cond_t *cond, pthread_mutex_t *mutex)
> >{
...
> >	futex_down(&mutex);
> >
> You should loop here in order catch signals:
> 
> 	while ( futex_down(&mutex) < 0 && errno == EINTR)

Yep.

> >	if (ret < 0 && errno == EINTR)
> >		goto again;
> >
> This assumes that you are allowed to do a double uwaitq_add.

Oops.... Fixed by moving the uwaitq_add above the again: label.

> >
> >	saved_errno = errno;
> >	uwaitq_remove(cond);
> >	futex_down(&mutex);
> >
> Also loop here

Yep.

> Now whats interesting is the kernel part. I must admit that I haven't 
> fully understood all
> effects of the double use of the cookie in your first implementation. 
> But if you use a memory
> location as identifier you have to keep a separate flag within 
> uwaitq_head that is zeroed
> before you add to the waitqueue and set by the signal functions. Then 
> uwaitq_wait has to check for it.

Yes.  My prior implementation actually deleted the sleeper from the
queue on wakeup, making it easy to detect and also saving a syscall.
I'm leaning towards the "flag" idea now though.

> uwaitq_remove also takes an argument, are you heading for waiting on 
> multiple events?

Yes.  The problem is: how many?  Each one takes memory and (as you
point out) pinned pages (although this could be changed with some loss
of simplicity).  An arbitrary limit smacks of SysV IPC: a sure sign of
bad taste.  So for the moment, the limit is 1.

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
