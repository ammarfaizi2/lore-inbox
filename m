Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750715AbWHIMbH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750715AbWHIMbH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 08:31:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750719AbWHIMbH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 08:31:07 -0400
Received: from filfla-vlan276.msk.corbina.net ([213.234.233.49]:21130 "EHLO
	screens.ru") by vger.kernel.org with ESMTP id S1750715AbWHIMbE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 08:31:04 -0400
Date: Wed, 9 Aug 2006 20:54:41 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
To: Kirill Korotaev <dev@sw.ru>
Cc: Andrew Morton <akpm@osdl.org>, Dave Hansen <haveblue@us.ibm.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sys_getppid oopses on debug kernel (v2)
Message-ID: <20060809165441.GA187@oleg>
References: <20060809143816.GA142@oleg> <44D9D03B.6060907@sw.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44D9D03B.6060907@sw.ru>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/09, Kirill Korotaev wrote:
>
> >Why do we need to use ->group_leader? All threads should have the same
> >->real_parent.
> I'm not sure this is true for old LinuxThreads...

Yes, from the user-space pov it may be not true, but ->group_leader->real_parent
should be equal ->real_parent anyway.

> >Why do we need tasklist_lock? I think rcu_read_lock() is enough.
> >
> >In other words, do you see any problems with this code
> >
> >	smlinkage long sys_getppid(void)
> >	{
> >		int pid;
> >
> >		rcu_read_lock();
> >		pid = rcu_dereference(current->real_parent)->tgid;
> >		rcu_read_unlock();
> >
> >		return pid;
> >	}
> >
> >? Yes, we may read a stale value for ->real_parent, but the memory
> >can't be freed while we are under rcu_read_lock(). And in this case
> >the returned value is ok because the task could be reparented just
> >after return anyway.
> Your patch doesn't cure the problem.
> rcu_read_lock just disables preemtion and rcu_dereference
> introduces memory barrier. _None_ of this _prevents_
> another CPU from freeing old real_parent in parallel with your dereference.

How so? Note that release_task() doesn't call put_task_struct(), it does
call_rcu(&p->rcu, delayed_put_task_struct) instead. When delayed_put_task_struct()
is called, all CPUs must see the new value of ->real_parent (otherwise
RCU is just broken). If CPU sees the old value of ->real_parent, rcu_read_lock()
protects us from delayed_put_task_struct() on another CPU.

Ok, I think this is the same "classic" pattern as:

	old = global_ptr;
	global_ptr = new;
	call_rcu(..free_old...);
vs
	rcu_read_lock();
	use(global_ptr);
	rcu_read_unlock();

Do you agree?

Oleg.

