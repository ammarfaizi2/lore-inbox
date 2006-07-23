Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750862AbWGWBGU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750862AbWGWBGU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jul 2006 21:06:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750960AbWGWBGU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jul 2006 21:06:20 -0400
Received: from smtp.osdl.org ([65.172.181.4]:14009 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750862AbWGWBGT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jul 2006 21:06:19 -0400
Date: Sat, 22 Jul 2006 18:06:02 -0700
From: Andrew Morton <akpm@osdl.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: davej@redhat.com, linux-kernel@vger.kernel.org,
       Ashok Raj <ashok.raj@intel.com>
Subject: Re: remove cpu hotplug bustification in cpufreq.
Message-Id: <20060722180602.ac0d36f5.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0607221707400.29649@g5.osdl.org>
References: <20060722194018.GA28924@redhat.com>
	<Pine.LNX.4.64.0607221707400.29649@g5.osdl.org>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.19; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 22 Jul 2006 17:10:36 -0700 (PDT)
Linus Torvalds <torvalds@osdl.org> wrote:

> 
> 
> On Sat, 22 Jul 2006, Dave Jones wrote:
> >
> > This stuff makes my head hurt. Someone who is motivated
> > enough to fix up hotplug-cpu can fix this up later.
> > In the meantime, this patch should cure the lockdep
> > warnings that seem to trigger very easily.
> 
> It doesn't seem to fix all problems. On CPU unplug, I still get deadlocks 
> through some workqueue:
> 
>  [<c03af64a>] __mutex_lock_slowpath+0x4d/0x7b
>  [<c03af687>] .text.lock.mutex+0xf/0x14
>  [<c0137591>] __lock_cpu_hotplug+0x36/0x56
>  [<c01375ca>] lock_cpu_hotplug+0xa/0xc
>  [<c012f7c2>] flush_workqueue+0x2d/0x61
>  [<c012f83b>] flush_scheduled_work+0xd/0xf
>  ...
> 
> and the nasty part is that this can apparently hit _any_ process that 
> wants to flush workqueues (in one particular case, it was through 
> tty_release() -> release_dev() in drivers/char/tty.c).

If one was sufficiently morbidly curious, one would ask for the rest of the
trace, to identify the deadlock.  But it's just not interesting.

Let's just delete the whole thing.

> The whole CPU hotplug locking seems to be broken.

It was just wrong in conception.  We should not and probably cannot fix it.
Let's just delete it all, then implement version 2.

Which is: subsystems are locally responsible for locking their per-cpu
resources.  No global lock.  Subsystems have two options:

a) If the resource can be accessed while running atomically, lock it
   with preempt_disable().  Because preempt_disable() holds off hotunplug.

b) If the kernel wants to sleep while requiring that the per-cpu
   resource remain stable, lock it down with mutex_lock() in the normal
   operating code and also lock it down with mutex_lock() in the
   subsystem's cpu hotplug notifier callback.

The precise handling of b) needs some thought and will depend upon how the
subsystem tells itself about the availability of each CPU's data.  A simple
implementation would be:

mainline_code()
{
	mutex_lock(lock);
	fiddle_with(data[some_cpu_id]);
	mutex_unlock(lock);
}

static int foo_cpu_callback(struct notifier_block *nfb, unsigned long action,
				void *hcpu)
{
	unsigned int cpu = (unsigned long)hcpu;

	switch (action) {
	case CPU_DOWN_PREPARE:
		mutex_lock(lock);
		break;
	case CPU_DOWN_FAILED:
		mutex_unlock(lock);
		break;
	case CPU_DOWN_DEAD:
		mutex_unlock(lock);
		break;
	}
	return NOTIFY_OK;
}

Leaving the lock held in this manner isn't nice IMO, but it should work OK.

Note that there is what appears to be a bug in cpu_down().  This:

	if (cpu_online(cpu))
		goto out_thread;

should do a CPU_DOWN_FAILED callout.  Or, better, it should go
BUG(), because this shouldn't happen.


