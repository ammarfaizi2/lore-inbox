Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750997AbVLTTeQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750997AbVLTTeQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 14:34:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751009AbVLTTeQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 14:34:16 -0500
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:59284 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1750979AbVLTTeQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 14:34:16 -0500
Subject: Re: Recursion bug in -rt
From: Steven Rostedt <rostedt@goodmis.org>
To: Esben Nielsen <simlo@phys.au.dk>
Cc: linux-kernel@vger.kernel.org, robustmutexes@lists.osdl.org,
       Ingo Molnar <mingo@elte.hu>, Dinakar Guniguntala <dino@in.ibm.com>
In-Reply-To: <Pine.OSF.4.05.10512201834580.1720-100000@da410.phys.au.dk>
References: <Pine.OSF.4.05.10512201834580.1720-100000@da410.phys.au.dk>
Content-Type: text/plain
Date: Tue, 20 Dec 2005 14:33:52 -0500
Message-Id: <1135107232.13138.348.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-12-20 at 18:43 +0100, Esben Nielsen wrote:
> 
> On Tue, 20 Dec 2005, Dinakar Guniguntala wrote:
> 
> > On Tue, Dec 20, 2005 at 02:19:56PM +0100, Ingo Molnar wrote:
> > > 
> > > hm, i'm looking at -rf4 - these changes look fishy:
> > > 
> > > -       _raw_spin_lock(&lock_owner(lock)->task->pi_lock);
> > > +       if (current != lock_owner(lock)->task)
> > > +               _raw_spin_lock(&lock_owner(lock)->task->pi_lock);
> > > 
> > > why is this done?
> > >
> >  
> > Ingo, this is to prevent a kernel hang due to application error.
> > 
> > Basically when an application does a pthread_mutex_lock twice on a
> > _nonrecursive_ mutex with robust/PI attributes the whole system hangs.
> > Ofcourse the application clearly should not be doing anything like
> > that, but it should not end up hanging the system either
> >
> 
> Hmm, reading the comment on the function, wouldn't it be more natural to
> use 
>     if(task != lock_owner(lock)->task)
> as it assumes that task->pi_lock is locked, not that current->pi_lock is
> locked.
> 
> By the way:
>  task->pi_lock is taken. lock_owner(lock)->task->pi_lock will be taken.
> What if the task lock_owner(lock)->task tries to lock another futex,
> (lock2) with which has lock_owner(lock2)->task==task.
> Can't you promote a user space futex deadlock into a kernel spin deadlock 
> this way?

Yes!

The locking code of the pi locks in the rt.c code is VERY dependent on
the order of locks taken.  It works by assuming the order of locks taken
will not themselves cause a deadlock.  I just recently submitted a patch
to Ingo because I found that mutex_trylock can cause a deadlock, since
it is not bound to the order of locks.

So, to answer your question more formal this time.  If the futex code
uses the pi_lock code in rt.c and the futex causes a deadlock, then the
kernel can deadlock too.

The benefit of this locking order is that we got rid of the global
pi_lock, and that was worth the problems you face today.

-- Steve


