Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268163AbTBNDOL>; Thu, 13 Feb 2003 22:14:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268165AbTBNDOJ>; Thu, 13 Feb 2003 22:14:09 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.104]:15035 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S268163AbTBNDOE>;
	Thu, 13 Feb 2003 22:14:04 -0500
Date: Fri, 14 Feb 2003 08:59:15 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: fastboot@osdl.org, linux-kernel@vger.kernel.org, mbligh@aracnet.com
Subject: Re: [KEXEC][PATCH] Modified (smaller) x86 kexec hwfixes patch
Message-ID: <20030214085915.A1466@in.ibm.com>
Reply-To: suparna@in.ibm.com
References: <20030213161014.A14361@in.ibm.com> <m1heb8w737.fsf@frodo.biederman.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <m1heb8w737.fsf@frodo.biederman.org>; from ebiederm@xmission.com on Thu, Feb 13, 2003 at 08:09:16AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 13, 2003 at 08:09:16AM -0700, Eric W. Biederman wrote:
> Suparna Bhattacharya <suparna@in.ibm.com> writes:
> 
> > This simplifies the the kexec-hwfixes patch, since we
> > no longer need to move to the boot cpu before stopping
> > other processors. Which removes a lot of the unconditional
> > patching of reboot.c and makes it less invasive, thanks to 
> > Martin. Also, at panic time, cpu migration is something 
> > that is best avoided.
> 
> I will agree with that, at least conditionally.  
> 
> I figure stop_apics can be removed from the panic path.
> 
> However stopping all of the cpus does seem to be something
> that is needed on the panic path.  And if we stop cpus
> what is wrong with cpu migration.  Or can we move the halt
> of the cpus into the panic kernel?  That would be my real 
> preference.

We still are stopping all cpus on a panic.
The difference is that we don't need to move to the boot cpu
and do this from there, since the new kernel can deal with
starting from any CPU.

The problem with cpu migration using set_cpus_allowed ?
My main concern is that it appears to wait for the migration 
thread to wakeup and do the needful .. goes through the scheduler 
etc.  

void set_cpus_allowed(task_t *p, unsigned long new_mask)
{
	..
	..
        wake_up_process(rq->migration_thread);

        wait_for_completion(&req.done);
}

We normally try to avoid this in the panic path -- we
don't know what state the system is in so try to depend on
as little functioning of the system as possible.

The approach that the current machine_restart uses for 
migration to the reboot cpu (i.e. issue and smp_call_function 
ipi, and let each cpu decided for itself what it needs to 
do) seems a little safer.

One of the things to try out in the crash dump
code is using an NMI to bring other cpus to a halt
in case one or more cpus are stuck/deadlocked in 
tight loop in an interrupt handler smp_call_function 
waits forever, and also to make sure we stop activity in
the system as early as possible. (This of course is for 
archs that have NMI support). Have to make sure we can
still kexec sucessfully after that.

> 
> > It would be good if someone could test this out (on SMP)
> > and confirm it works fine (I tried it on a 4way).
> > 
> > Eric, Do these changes look OK to you ? Did you have
> > something similar in mind, when you were talking about
> > enabling the kexec'd kernel to not care about which cpu
> > it was running on ?
> 
> 50%.  The normal case needs to shutdown the way it is currently doing.
> So we need to audit the code a little more.

It still is doing exactly what the regular kernel was doing 
before. If you look closely at this patch, notice that it simply 
backs out most of the changes to reboot.c (so machine_restart
is very close to what it was before).

> 
> Basically the way I see it, in the normal case the kernel is responsible
> for a clean shutdown of the kernel and all it's devices.   No one else
> knows better how to accomplish those tasks then the drivers running the kernel.

Yes, and that's what is happening AFAICT. None of that
should have changed (at least I didn't intend it to change,
so let me know if I missed something).

> 
> On the other hand during a panic the recovery kernel is responsible for
> everything it possibly can handle.  Because we know something is broken
> in the kernel calling kexec.

As far as possible, yes.

Regards
Suparna


-- 
Suparna Bhattacharya (suparna@in.ibm.com)
Linux Technology Center
IBM Software Labs, India

