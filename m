Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751674AbWCBTMU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751674AbWCBTMU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 14:12:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752040AbWCBTMU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 14:12:20 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:19650 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751674AbWCBTMT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 14:12:19 -0500
Date: Thu, 2 Mar 2006 11:12:01 -0800
From: Paul Jackson <pj@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: greg@kroah.com, ebiederm@xmission.com, linux-kernel@vger.kernel.org,
       yanmin.zhang@intel.com, neilb@cse.unsw.edu.au, steiner@sgi.com,
       hawkes@sgi.com
Subject: Re: + proc-dont-lock-task_structs-indefinitely-cpuset-fix-2.patch
 added to -mm tree
Message-Id: <20060302111201.cf61552f.pj@sgi.com>
In-Reply-To: <20060301234215.62010fec.akpm@osdl.org>
References: <20060228183610.5253feb9.akpm@osdl.org>
	<20060228194525.0faebaaa.pj@sgi.com>
	<20060228201040.34a1e8f5.pj@sgi.com>
	<m1irqypxf5.fsf@ebiederm.dsl.xmission.com>
	<20060228212501.25464659.pj@sgi.com>
	<20060228234807.55f1b25f.pj@sgi.com>
	<20060301002631.48e3800e.akpm@osdl.org>
	<20060301015338.b296b7ad.pj@sgi.com>
	<20060301192103.GA14320@kroah.com>
	<20060301125802.cce9ef51.pj@sgi.com>
	<20060301213048.GA17251@kroah.com>
	<20060301142631.22738f2d.akpm@osdl.org>
	<20060301151000.5fff8ec5.pj@sgi.com>
	<20060301154040.a7cb2afd.pj@sgi.com>
	<20060301202058.42975408.akpm@osdl.org>
	<20060301221429.c61b4ae6.pj@sgi.com>
	<20060301234215.62010fec.akpm@osdl.org>
Organization: SGI
X-Mailer: Sylpheed version 2.1.7 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John, Jack,

  Adding you to this one.  We've seen this before, and
  I wasted Andrew's and others time chasing it again.

  I speculate at the bottom of this message that I
  should add a panic on the kzalloc that fails if one
  has 1024 CPUS, SPINLOCK debug, and just slightly larger
  data structures with a new patch than we had before.

  Feel free to comment on whether such a panic, or other
  remedy would be desirable or not.

===

Andrew wrote:
> OK.   This is awful.   I cannot see it.

Crap - I should have recognized this problem a day ago.

I wasted your time.  Sorry.

The extra data pushed the size of our (big SN2) sysfs_cpus[] array
past the point that it could be kzalloc'd.

The initial failure is in the file:

    arch/ia64/kernel/topology.c

function:

    topology_init

line:

    sysfs_cpus = kzalloc(sizeof(struct ia64_cpu) * NR_CPUS, GFP_KERNEL);

With our large NR_CPUS of 1024, and the additional cost of
the CONFIG_DEBUG_SPINLOCK* debug stuff, and the little bit of
additional data added by this patch, that kzalloc() fails.

The final collapse occurs in the file:

    fs/sysfs/group.c

function:

    sysfs_create_group

line:

    BUG_ON(!kobj || !kobj->dentry);

where kobj->dentry points to 0x58.

The offset of dentry in struct kobject is 0x50, and the offset of that
kobj in the containing struct sys_dev is another 0x8 bytes, resulting
in the failed reference:

    Unable to handle kernel NULL pointer dereference (address 0000000000000058)

The drivers/base/cpu.c array:

    static struct sys_device *cpu_sys_devices[NR_CPUS];

is never filled in, as a result of the above kzalloc() failure, causing
the routine get_cpu_sysdev() in drivers/base/cpu.c to return a NULL
pointer (unknowingly).

I should stare at the code between this point of initial failure and
the point that the house of cards finally collapsed and see if
something should have squeaked sooner.

Though I'm not a guru in this code, so I'm saying a little prayer that
someone else will have a more useful suggestion.

I've added a couple of SGI wizards in this area to the cc list.

I suspect that the short term solution is to proceed without
prejudice to the patch that triggered this:

  gregkh-driver-allow-sysfs-attribute-files-to-be-pollable.patch

while I look at some way, if just a stop gap measure, to complain
earlier in the boot, closer to the scene of the original crime,
so that others hitting this won't waste more time.

Perhaps failing that first kzalloc should cause a complaint,
if not a panic.  It would seem that the system is beyond repair
if that kzalloc fails.  And since the system hasn't even finished
booting yet, and is for sure trying to boot some larger than tried
before configuration, might just as well announce ones death boldly.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
