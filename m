Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261382AbVCaMOq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261382AbVCaMOq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 07:14:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261386AbVCaMOq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 07:14:46 -0500
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:58603 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S261382AbVCaMOm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 07:14:42 -0500
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc1-V0.7.41-07
From: Steven Rostedt <rostedt@goodmis.org>
To: Esben Nielsen <simlo@phys.au.dk>
Cc: Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.OSF.4.05.10503311301210.11827-100000@da410.phys.au.dk>
References: <Pine.OSF.4.05.10503311301210.11827-100000@da410.phys.au.dk>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Thu, 31 Mar 2005 07:14:30 -0500
Message-Id: <1112271270.3691.209.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-03-31 at 13:03 +0100, Esben Nielsen wrote:
> On Thu, 31 Mar 2005, Ingo Molnar wrote:
> 
> > 
> > * Steven Rostedt <rostedt@goodmis.org> wrote:
> > 
> > > Well, here it finally is. There's still things I don't like about it. 
> > > But it seems to work, and that's the important part.
> > > 
> > > I had to reluctantly add two items to the task_struct.  I was hoping 
> > > to avoid that. But because of race conditions it seemed to be the only 
> > > way.
> > 
> > well it's not a big problem, and we avoided having to add flags to the 
> > rt_lock structure, which is the important issue.
> > 
> I was going to say the opposit. I know that there are many more rt_locks
> locks around and the fields thus will take more memory when put there but
> I believe it is more logical to have the fields there.

It seems logical to be there, but in practicality, it's not. 

The problem is that the flags represent a state of the task with respect
to a single lock.  When the task loses ownership of a lock, the state of
the task changes. But the the lock has a different state at that moment
(it has a new onwner).  Now when it releases the lock, it might give the
lock to another task, and that becomes the pending owner. Now the state
of the lock is the same as in the beginning. But the first task needs to
see this change.

You can still pull this off by testing the state of the lock and compare
it to the current owner, but I too like the fact that you don't increase
the size of the kernel statically.  There are a lot more locks in the
kernel than tasks on most systems. And those systems that will have more
tasks than locks, need a lot of memory anyway.  So we only punish the
big systems (that expect to be punished) and keep the little guys safe.

-- Steve


