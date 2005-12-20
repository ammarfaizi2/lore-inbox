Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750753AbVLTRoO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750753AbVLTRoO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 12:44:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750755AbVLTRoO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 12:44:14 -0500
Received: from lirs02.phys.au.dk ([130.225.28.43]:6808 "EHLO lirs02.phys.au.dk")
	by vger.kernel.org with ESMTP id S1750753AbVLTRoO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 12:44:14 -0500
Date: Tue, 20 Dec 2005 18:43:03 +0100 (MET)
From: Esben Nielsen <simlo@phys.au.dk>
To: Dinakar Guniguntala <dino@in.ibm.com>
Cc: Ingo Molnar <mingo@elte.hu>, robustmutexes@lists.osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: Recursion bug in -rt
In-Reply-To: <20051220155004.GA3906@in.ibm.com>
Message-Id: <Pine.OSF.4.05.10512201834580.1720-100000@da410.phys.au.dk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 20 Dec 2005, Dinakar Guniguntala wrote:

> On Tue, Dec 20, 2005 at 02:19:56PM +0100, Ingo Molnar wrote:
> > 
> > hm, i'm looking at -rf4 - these changes look fishy:
> > 
> > -       _raw_spin_lock(&lock_owner(lock)->task->pi_lock);
> > +       if (current != lock_owner(lock)->task)
> > +               _raw_spin_lock(&lock_owner(lock)->task->pi_lock);
> > 
> > why is this done?
> >
>  
> Ingo, this is to prevent a kernel hang due to application error.
> 
> Basically when an application does a pthread_mutex_lock twice on a
> _nonrecursive_ mutex with robust/PI attributes the whole system hangs.
> Ofcourse the application clearly should not be doing anything like
> that, but it should not end up hanging the system either
>

Hmm, reading the comment on the function, wouldn't it be more natural to
use 
    if(task != lock_owner(lock)->task)
as it assumes that task->pi_lock is locked, not that current->pi_lock is
locked.

By the way:
 task->pi_lock is taken. lock_owner(lock)->task->pi_lock will be taken.
What if the task lock_owner(lock)->task tries to lock another futex,
(lock2) with which has lock_owner(lock2)->task==task.
Can't you promote a user space futex deadlock into a kernel spin deadlock 
this way?

Esben
 
> 	-Dinakar
> 
> 

