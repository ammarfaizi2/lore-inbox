Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262166AbULQV7d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262166AbULQV7d (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Dec 2004 16:59:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262178AbULQV5e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Dec 2004 16:57:34 -0500
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:56453 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S262175AbULQVwl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Dec 2004 16:52:41 -0500
Subject: Re: 2.6.10-rc3-mm1-V0.7.33-03 and NVidia wierdness, with
	workaround...
From: Steven Rostedt <rostedt@goodmis.org>
To: Valdis.Kletnieks@vt.edu
Cc: Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1103313861.12664.71.camel@localhost.localdomain>
References: <200412161626.iBGGQ5CI020770@turing-police.cc.vt.edu>
	 <1103300362.12664.53.camel@localhost.localdomain>
	 <1103303011.12664.58.camel@localhost.localdomain>
	 <200412171810.iBHIAQP3026387@turing-police.cc.vt.edu>
	 <1103313861.12664.71.camel@localhost.localdomain>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Fri, 17 Dec 2004 16:52:34 -0500
Message-Id: <1103320354.3538.11.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-12-17 at 15:04 -0500, Steven Rostedt wrote:
> On Fri, 2004-12-17 at 13:10 -0500, Valdis.Kletnieks@vt.edu wrote:
> > On Fri, 17 Dec 2004 12:03:31 EST, Steven Rostedt said:
> > 
> > > Update: I just tried some of my fixes to the rc3-mm1 kernel, and that
> > > worked without a problem.  But I still didn't get by the sleep problem
> > > in Ingo's RT patch.  Did you get further, and did you make fixes to both
> > > the nvidia module as well as the kernel?
> > 
> > I have to admit I haven't *hit* a sleep problem specific to Ingo's code, unless
> > you have a different config/hardware and my BKL wierdness and your sleep are
> > 2 different manifestations of the same problem.  Or maybe they're 2 different
> > bugs... ;)
> > 
> > I'm running Ingo's patch and the nvidia 6629 drivers as I'm typing this. Given
> > you had to fool with pgd_offset_k and friends, you're probably trying an older
> > driver (6111?) and should upgrade - the 6629 picked up a *bunch* of 2.6-related
> > fixes.  Maybe 6629 fixed your sleep issue?
> > 
> 
> Nope! I have the 6629. Actually, the patch you have for NV solved the
> pgd_offset problem. But I'm amazed that you didn't get into the
> may_sleep calls.  In the nvidia code os-interface.c, would call hooks
> into the kernel with interrupts turned off and hit the may_sleep.  But
> looking into it further now, one of the crashes came from
> ioremap_nocache and the sleep happened in kmem_cache_alloc. So maybe
> Ingo fixed this.  I lied earlier (not intentionally), the last kernel I
> tried with the NVidia was V0.7.32-18, so let me try again.
> 

I just tried it again, but this time with V0.7.33-04 and it still has
the same problems.  I also forced the nv.c not use the class_simple
code. But it still breaks on start-up.  Do you have either
CONFIG_DEBUG_SPINLOCK_SLEEP or CONFIG_DEBUG_PREEMPT defined?  If not,
you won't see the dump I see with the might_sleep. This is only tested
if you have either of the two configure.

But just to let you know, here's the dump when it happens.

BUG: sleeping function called from invalid context XFree86(5029) at
kernel/rt.c:1443
in_atomic():0 [00000000], irqs_disabled():1
 [<c01041ae>] dump_stack+0x1e/0x20 (20)
 [<c011af04>] __might_sleep+0xd4/0xf0 (36)
 [<c0137893>] __spin_lock+0x33/0x50 (24)
 [<c0137928>] _spin_lock_irqsave+0x18/0x20 (16)
 [<c01dfc8e>] pci_bus_write_config_word+0x2e/0x80 (40)
 [<f93c4ca3>] os_pci_write_word+0x3b/0x3d [nvidia] (24)
 [<f91d910c>] _nv001740rm+0x1c/0x20 [nvidia] (32)
 [<f91d481d>] _nv002409rm+0x99/0x110 [nvidia] (80)
 [<f91d53e7>] _nv002398rm+0xc7/0x328 [nvidia] (80)
 [<f91df93c>] rm_init_agp+0x48/0x50 [nvidia] (48)
 [<f93c2edb>] nv_agp_init+0x13d/0x192 [nvidia] (36)
 [<f91db522>] _nv001779rm+0xda/0x110 [nvidia] (64)
 [<f91dbefd>] _nv004480rm+0x131/0x158 [nvidia] (64)
 [<f91dbda9>] _nv004434rm+0xf9/0x11c [nvidia] (64)
 [<f934e1fb>] _nv002078rm+0x73/0x94 [nvidia] (64)
 [<f92e5e5a>] _nv002236rm+0x1e6/0x1f4 [nvidia] (64)
 [<f92e5a9e>] _nv002163rm+0x9e/0xb8 [nvidia] (64)
 [<f91dbbde>] _nv001315rm+0x5e/0xc0 [nvidia] (48)  [<f91dc392>]
_nv001320rm+0x1de/0x2bc [nvidia] (80)
 [<f91df08b>] rm_init_adapter+0x5f/0x8c [nvidia] (48)
              ^^^^^^^^^^^^^^^^
Here's your rm_init_adapter call. 

 [<f93c09dd>] nv_kern_open+0x288/0x31d [nvidia] (56)
 [<c0169b09>] chrdev_open+0xf9/0x1e0 (40)
 [<c015f614>] dentry_open+0x164/0x290 (36)
 [<c015f4ab>] filp_open+0x5b/0x60 (92)
 [<c015f926>] sys_open+0x46/0x90 (32)
 [<c0103297>] syscall_call+0x7/0xb (-8124)
---------------------------
| preempt count: 00000001 ]
| 1-level deep critical section nesting:
----------------------------------------
.. [<c01382d8>] .... print_traces+0x18/0x50
.....[<c01041ae>] ..   ( <= dump_stack+0x1e/0x20)


Anyway, I don't have CONFIG_SPINLOCK_BLK set, it's not even in
my .config file, and I can't get past the NVidia logo. But I haven't
tried the kernel patch you had, I'll try that now.

-- Steve


