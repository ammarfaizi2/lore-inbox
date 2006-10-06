Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422998AbWJFXLj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422998AbWJFXLj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 19:11:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423000AbWJFXLi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 19:11:38 -0400
Received: from smtp.osdl.org ([65.172.181.4]:15753 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1422998AbWJFXLh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 19:11:37 -0400
Date: Fri, 6 Oct 2006 16:10:12 -0700
From: Bryce Harrington <bryce@osdl.org>
To: Andrew Morton <akpm@osdl.org>
Cc: vatsa@in.ibm.com, torvalds@osdl.org, linux-kernel@vger.kernel.org,
       shaohua.li@intel.com, hotplug_sig@osdl.org,
       lhcs-devel@lists.sourceforge.net
Subject: Status on CPU hotplug issues
Message-ID: <20061006231012.GH22139@osdl.org>
References: <20060316174447.GA8184@in.ibm.com> <20060316170814.02fa55a1.akpm@osdl.org> <20060317084653.GA4515@in.ibm.com> <20060317010412.3243364c.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060317010412.3243364c.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 17, 2006 at 01:04:12AM -0800, Andrew Morton wrote:
> Srivatsa Vaddagiri <vatsa@in.ibm.com> wrote:
> > Well ..other arch-es need to have a similar check if they get around to
> > implement physical hot-add (even if they allow offlining of all CPUs). This is 
> > required since a user can (by mistake maybe) try to bring up an already online 
> > CPU by writing a '1' to it's sysfs 'online' file. 'store_online' 
> > (drivers/base/cpu.c) unconditionally calls 'smp_prepare_cpu' w/o checking for 
> > this error condition. The check added in the patch catches such error 
> > conditions as well.
> 
> OK..  I guess we should fix those architectures while we're thinking about it.
>
> > +	/* Check if CPU is already online. This can happen if user tries to 
> > +	 * bringup an already online CPU or a previous offline attempt
> > +	 * on this CPU has failed.
> > +	 */
> > +	if (cpu_online(cpu)) {
> > +		ret = -EINVAL;
> > +		goto exit;
> > +	}
> 
> How well tested is this?  From my reading, this will cause
> enable_nonboot_cpus() to panic.  Is that intended?

Andrew,

I wanted to give you an update on results of cpu testing I've done on
recent kernels and several architectures.  Since -rc1 is out, I wanted
to give added visibility to the few issues that remain.

The full results are available here:

    http://crucible.osdl.org/runs/hotplug_report.html

This is actually a report for cpu hotplug tests generated hourly,
however we run it against all of the kernel -git snapshots posted to
kernel.org.  Whereever you see a blank square, it indicates the kernel
either failed to build or boot.


Issues were found in four areas: General kernel, cpu hotplug, sysstat,
and the test harness itself.  I've reported the general kernel issues
here, and they have been addressed (thanks).  The issues in the test
harness were also addressed.  Of the two sysstat issues, one is fixed in
recent releases, and the other has been reported and may simply be a
sysstat design decision.

So, focusing just on the remaining open CPU hotplug issues:

1.  Oops offlining cpu twice on AMD64 (but not on EM64t)
    with the 2.6.18-git22 kernel

    Reported to hotplug lists 10/05:
      http://lists.osdl.org/pipermail/hotplug_sig/2006-October/000680.html

    To recreate: offline, online, and then offline a CPU, then oopses
      http://crucible.osdl.org/runs/2397/sysinfo/amd01.console
      http://crucible.osdl.org/runs/2397/sysinfo/amd01.2/proc/config

    Here's a snippet of the oops:

# echo 0 > /sys/devices/system/cpu/cpu1/online

 Unable to handle kernel NULL pointer dereference at 0000000000000000 RIP:
 [<ffffffff80255287>] __drain_pages+0x29/0x5f
PGD 7e56d067 PUD 7ee80067 PMD 0
Oops: 0000 [1] PREEMPT SMP
CPU 0
Modules linked in:
Pid: 7203, comm: bash Tainted: G   M  2.6.18-git22 #1
RIP: 0010:[<ffffffff80255287>]  [<ffffffff80255287>] __drain_pages+0x29/0x5f
RSP: 0018:ffff81003f1b3dd8  EFLAGS: 00010082
RAX: 0000000000000001 RBX: 0000000000000082 RCX: 0000000000000000
RDX: ffff81000000c580 RSI: 00000000fffffffe RDI: ffff81000000c000
RBP: 0000000000000000 R08: 00000000fffffffe R09: ffff81007f1e63f0
R10: 0000000000000000 R11: 0000000000000000 R12: ffff81000000c580
R13: 0000000000000001 R14: 0000000000000001 R15: ffff81003f1b3f50
FS:  00002ab3e8a136d0(0000) GS:ffffffff806e3000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 0000000000000000 CR3: 000000007eea1000 CR4: 00000000000006e0
Process bash (pid: 7203, threadinfo ffff81003f1b2000, task ffff81003f1c07c0)
Stack:  0000000000000001 0000000000000001 0000000000000007 0000000000000007
 0000000000000003 ffffffff802564b6 ffffffff8060d320 ffffffff805644a7
 ffffffff8060dbe0 0000000000000001 0000000000000001 ffffffff8023c49d
Call Trace:
 [<ffffffff802564b6>] page_alloc_cpu_notify+0x12/0x28
 [<ffffffff805644a7>] notifier_call_chain+0x23/0x32
 [<ffffffff8023c49d>] blocking_notifier_call_chain+0x22/0x36
 [<ffffffff80248ff9>] _cpu_down+0x17f/0x23d
 [<ffffffff802490de>] cpu_down+0x27/0x3c
 [<ffffffff804419c7>] store_online+0x0/0x6b
 [<ffffffff804419ec>] store_online+0x25/0x6b
 [<ffffffff802ac4b7>] sysfs_write_file+0xad/0xd7
 [<ffffffff80273ff7>] vfs_write+0xaf/0x14e
 [<ffffffff80274149>] sys_write+0x45/0x6e
 [<ffffffff8020965e>] system_call+0x7e/0x83



2.  Oops during SMP bootup on AMD64 and EM64t

    Reported to hotplug and LKML lists 10/6:
      http://marc.theaimsgroup.com/?l=linux-kernel&m=116017427617557&w=2

    Appears to have entered codebase between 2.6.19-rc1 and
    2.6.19-rc1-git2.  Seems ok on x86_32 and ia32.


3.  Inconsistent error message when onlining already-onlined cpu

    Reported to hotplug lists 09/29:
      http://lists.osdl.org/pipermail/hotplug_sig/2006-September/000672.html

    Bugzilla ID 7249:
      http://bugzilla.kernel.org/show_bug.cgi?id=7249

    This only appears on EM64t (I haven't been able to check AMD64 due
    to the aforementioned issues.)

    If you attempt to online an already onlined CPU on most
    architectures, the command simply exits with an error code of 1 and
    no error message to stderr.  However, EM64t prints the following:

    # echo 1 > /sys/devices/system/cpu/cpu1/online
    # echo 1 > /sys/devices/system/cpu/cpu1/online
    -bash: echo: write error: Invalid argument

    Andi Kleen took at look at the report and says it looks like a bug
    to him.

Thanks,
Bryce

