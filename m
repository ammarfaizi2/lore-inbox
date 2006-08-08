Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030338AbWHHXnP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030338AbWHHXnP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 19:43:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030339AbWHHXnO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 19:43:14 -0400
Received: from smtp.osdl.org ([65.172.181.4]:27074 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030338AbWHHXnO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 19:43:14 -0400
Date: Tue, 8 Aug 2006 16:42:10 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
Cc: linux-kernel@vger.kernel.org, "Andi Kleen" <ak@muc.de>,
       "Jan Beulich" <jbeulich@novell.com>,
       Ravikiran G Thirumalai <kiran@scalex86.org>
Subject: Re: mm snapshot broken-out-2006-08-08-00-59.tar.gz uploaded
Message-Id: <20060808164210.edb10cdc.akpm@osdl.org>
In-Reply-To: <6bffcb0e0608081511x17508f89j60705bf74e09e820@mail.gmail.com>
References: <200608080800.k7880noU028915@shell0.pdx.osdl.net>
	<6bffcb0e0608081329r732e191dsec0f391ea70f7d28@mail.gmail.com>
	<20060808140511.def9b13c.akpm@osdl.org>
	<6bffcb0e0608081419p4430b5cei7b4aa990cd0d4422@mail.gmail.com>
	<20060808143751.42f8d87c.akpm@osdl.org>
	<6bffcb0e0608081511x17508f89j60705bf74e09e820@mail.gmail.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Aug 2006 00:11:38 +0200
"Michal Piotrowski" <michal.k.k.piotrowski@gmail.com> wrote:

> On 08/08/06, Andrew Morton <akpm@osdl.org> wrote:
> > On Tue, 8 Aug 2006 23:19:09 +0200
> > "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com> wrote:
> >
> > > >  You
> > > > can look these things up in gdb or using addr2line, provided you have
> > > > CONFIG_DEBUG_INFO=y.
> > > >
> > > >
> > >
> > > (gdb) list *0xc047d609
> > > 0xc047d609 is in start_kernel (/usr/src/linux-work1/init/main.c:577).
> > > 572             cpuset_init_early();
> > > 573             mem_init();
> > > 574             kmem_cache_init();
> > > 575             setup_per_cpu_pageset();
> > > 576             numa_policy_init();
> > > 577             if (late_time_init)
> > > 578                     late_time_init();
> > > 579             calibrate_delay();
> > > 580             pidmap_init();
> > > 581             pgtable_cache_init();
> >
> > hm.
> >
> > - Try to get the full oops record,
> 
> BUG: unable to handle kernel paging request at virtual address 01020304
> printing eip:
> c041b95c
> *pde= 00000000
> Oops: 0000 [#1]
> 4K_STACK PREEMPT SMP
> last sysfs file:
> Modules linked in:
> CPU 0
> EIP: 0060: [<c041b95c>] Not tainted VLI
> EFLAGS: 00010202
> EIP is at kmem_cache_init+0x389/0x3f0
> [..]
> Call Trace:
> [<c0104063>] show_stack_log_lvl+0x8c/0x97
> [<c010422b>] show_registers+0x181/0x215
> [<c0104481>] die+0x1c2/0x2dd
> [<c0117419>] do_page_fault+0x410/0x4f3
> [<c02f40a1>] error_code+0x39/0x40
> [<c040b604>] start_kernel+0x21f/0x39d
> [<c0100210>] 0xc0100210
> [..]
> EIP: [<c041b95c>] kmem_cache_init+0x389/0x3f0 SS:ESP0068:c0409fc4
> <0> Kernel panic - not syncing: Attempted to kill idle task!
> 
> (gdb) list *0xc041b95c
> 0xc041b95c is in kmem_cache_init (/usr/src/linux-work1/mm/slab.c:714).
> 709                             lockdep_set_class(&l3->list_lock,
> &on_slab_l3_key);
> 710                             alc = l3->alien;
> 711                             if (!alc)
> 712                                     continue;
> 713                             for_each_node(r) {
> 714                                     if (alc[r])
> 715                                             lockdep_set_class(&alc[r]->lock,
> 716                                                  &on_slab_alc_key);
> 717                             }
> 718                     }

ah-hah, thanks.  The oopsing statement was added by
slab-fix-lockdep-warnings.patch.

I guess we can fix this by whacking another #ifdef CONFIG_NUMA in there but
I don't think that's how we want to address this.

We've been moving towards making the NUMA slab code work OK in a non-NUMA
build by setting the NUMA-specific fields to NULL and simply blowing a few
cycles at runtime to avoid many tens of ifdefs (it's that bad).

Here, we should have had either l3==NULL or l3->alien==NULL, but that has
been violated, hence the crash.

Kiran, could you take a look please?  The 0x01020304 is interesting...
