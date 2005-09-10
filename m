Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932263AbVIJH1d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932263AbVIJH1d (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 03:27:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932712AbVIJH1d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 03:27:33 -0400
Received: from [80.71.243.242] ([80.71.243.242]:45999 "EHLO tau.rusteko.ru")
	by vger.kernel.org with ESMTP id S932263AbVIJH1c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 03:27:32 -0400
From: Nikita Danilov <nikita@clusterfs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17186.35554.43089.674075@gargle.gargle.HOWL>
Date: Sat, 10 Sep 2005 11:27:30 +0400
To: Paul Jackson <pj@sgi.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Simon Derr <Simon.Derr@bull.net>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpuset semaphore depth check deadlock fix
Newsgroups: gmane.linux.kernel
In-Reply-To: <20050909220116.26993.9674.sendpatchset@jackhammer.engr.sgi.com>
References: <20050909220116.26993.9674.sendpatchset@jackhammer.engr.sgi.com>
X-Mailer: VM 7.17 under 21.5 (patch 17) "chayote" (+CVS-20040321) XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jackson writes:
 > The cpusets-formalize-intermediate-gfp_kernel-containment patch
 > has a deadlock problem.

[...]

 >  
 >  /*
 > + * The global cpuset semaphore cpuset_sem can be needed by the
 > + * memory allocator to update a tasks mems_allowed (see the calls
 > + * to cpuset_update_current_mems_allowed()) or to walk up the
 > + * cpuset hierarchy to find a mem_exclusive cpuset see the calls
 > + * to cpuset_excl_nodes_overlap()).
 > + *
 > + * But if the memory allocation is being done by cpuset.c code, it
 > + * usually already holds cpuset_sem.  Double tripping on a kernel
 > + * semaphore deadlocks the current task, and any other task that
 > + * subsequently tries to obtain the lock.
 > + *
 > + * Run all up's and down's on cpuset_sem through the following
 > + * wrappers, which will detect this nested locking, and avoid
 > + * deadlocking.
 > + */
 > +
 > +static inline void cs_down(struct semaphore *psem)
 > +{
 > +	if (current->cpuset_sem_nest_depth == 0)
 > +		down(psem);
 > +	current->cpuset_sem_nest_depth++;
 > +}
 > +
 > +static inline void cs_up(struct semaphore *psem)
 > +{
 > +	current->cpuset_sem_nest_depth--;
 > +	if (current->cpuset_sem_nest_depth == 0)
 > +		up(psem);
 > +}

I am somewhat concerned that new fields are added to the struct
task_struct all the time: it's already over 1.3KB.

In that particular case, it seems that cs_{up,down}() (or however they
end up being named), are used only on &cpuset_sem, and adding new field
to the thread struct can be avoided by doing:

static DECLARE_MUTEX(cpuset_sem);
static struct task_struct *cpuset_sem_owner = NULL;
static int cpuset_sem_depth = 0;

static void cpusets_lock(void)
{
	if (cpuset_sem_owner != current) {
		down(&cpuset_sem);
		cpuset_sem_owner = current;
	}
	cpuset_sem_depth ++;
}

static void cpusets_unlock(void)
{
	if (-- cpuset_sem_depth == 0) {
		cpuset_sem_owner = NULL;
		up(&cpuset_sem);
	}
}

Nikita.
