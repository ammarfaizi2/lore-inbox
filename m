Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267619AbTBNI3X>; Fri, 14 Feb 2003 03:29:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268240AbTBNI3X>; Fri, 14 Feb 2003 03:29:23 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:809 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S267619AbTBNI3V>; Fri, 14 Feb 2003 03:29:21 -0500
To: suparna@in.ibm.com
Cc: fastboot@osdl.org, linux-kernel@vger.kernel.org, mbligh@aracnet.com
Subject: Re: [KEXEC][PATCH] Modified (smaller) x86 kexec hwfixes patch
References: <20030213161014.A14361@in.ibm.com>
	<m1heb8w737.fsf@frodo.biederman.org> <20030214085915.A1466@in.ibm.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 14 Feb 2003 01:39:14 -0700
In-Reply-To: <20030214085915.A1466@in.ibm.com>
Message-ID: <m11y2b8de5.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Suparna Bhattacharya <suparna@in.ibm.com> writes:

> On Thu, Feb 13, 2003 at 08:09:16AM -0700, Eric W. Biederman wrote:
> 
> We still are stopping all cpus on a panic.
> The difference is that we don't need to move to the boot cpu
> and do this from there, since the new kernel can deal with
> starting from any CPU.

I think I would like to maintain one patch that is for
the recover kernel, and a second patch that is for the kernel
calling kexec.  So that we don't get things to confused.


> The problem with cpu migration using set_cpus_allowed ?
[snip]
> The approach that the current machine_restart uses for 
> migration to the reboot cpu (i.e. issue and smp_call_function 
> ipi, and let each cpu decided for itself what it needs to 
> do) seems a little safer.

I agree with this analysis for the panic path.

> One of the things to try out in the crash dump
> code is using an NMI to bring other cpus to a halt
> in case one or more cpus are stuck/deadlocked in 
> tight loop in an interrupt handler smp_call_function 
> waits forever, and also to make sure we stop activity in
> the system as early as possible. (This of course is for 
> archs that have NMI support). Have to make sure we can
> still kexec sucessfully after that.

Hmm.  As my memory serves you can send a startup ipi anytime you
want so it may be reasonable to just ignore the other cpus
and wait until we get to trusted recovery code to do something
about them.  Though that implies reserved some memory below 1MB
which I'm not terribly fond of. 

I guess the place to start is the current implementation of
smp_send_stop, and we can see how the code goes from there.

> > > It would be good if someone could test this out (on SMP)
> > > and confirm it works fine (I tried it on a 4way).
> > > 
> > > Eric, Do these changes look OK to you ? Did you have
> > > something similar in mind, when you were talking about
> > > enabling the kexec'd kernel to not care about which cpu
> > > it was running on ?
> > 
> > 50%.  The normal case needs to shutdown the way it is currently doing.
> > So we need to audit the code a little more.
> 
> It still is doing exactly what the regular kernel was doing 
> before. If you look closely at this patch, notice that it simply 
> backs out most of the changes to reboot.c (so machine_restart
> is very close to what it was before).

For kexec without panic it keeps us from running on the bootstrap
processor, unless I missed something.

> > Basically the way I see it, in the normal case the kernel is responsible
> > for a clean shutdown of the kernel and all it's devices.   No one else
> > knows better how to accomplish those tasks then the drivers running the
> kernel.
> 
> 
> Yes, and that's what is happening AFAICT. None of that
> should have changed (at least I didn't intend it to change,
> so let me know if I missed something).
> 
> > 
> > On the other hand during a panic the recovery kernel is responsible for
> > everything it possibly can handle.  Because we know something is broken
> > in the kernel calling kexec.
> 
> As far as possible, yes.

Good we agree on philosophy if not all of the little technical details.


Eric
