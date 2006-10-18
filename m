Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161116AbWJRTGJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161116AbWJRTGJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 15:06:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161091AbWJRTGJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 15:06:09 -0400
Received: from smtp.osdl.org ([65.172.181.4]:52367 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161116AbWJRTGI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 15:06:08 -0400
Date: Wed, 18 Oct 2006 12:05:25 -0700
From: Andrew Morton <akpm@osdl.org>
To: michael@ellerman.id.au
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, linux-kernel@vger.kernel.org,
       Paul Mackerras <paulus@samba.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: 2.6.19-rc2-mm1
Message-Id: <20061018120525.5cd9e6f1.akpm@osdl.org>
In-Reply-To: <1161165948.7906.33.camel@localhost.localdomain>
References: <20061016230645.fed53c5b.akpm@osdl.org>
	<4535310C.40708@goop.org>
	<20061017132245.12499c1d.akpm@osdl.org>
	<1161165948.7906.33.camel@localhost.localdomain>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Oct 2006 20:05:48 +1000
Michael Ellerman <michael@ellerman.id.au> wrote:

> On Tue, 2006-10-17 at 13:22 -0700, Andrew Morton wrote:
> > On Tue, 17 Oct 2006 12:37:48 -0700
> > Jeremy Fitzhardinge <jeremy@goop.org> wrote:
> > 
> > > Andrew Morton wrote:
> > > > -generic-implementatation-of-bug.patch
> > > > -generic-implementatation-of-bug-fix.patch
> > > > +generic-bug-implementation.patch
> > > >  generic-bug-for-i386.patch
> > > >  generic-bug-for-x86-64.patch
> > > >  uml-add-generic-bug-support.patch
> > > >  use-generic-bug-for-ppc.patch
> > > >  bug-test-1.patch
> > > >
> > > >  Updated generic-BUG-handling patches
> > > >   
> > > I thought the powerpc patch had been given a clean bill of health?  Or 
> > > was there still a problem with it?
> > 
> > No, last time I tested it the machine still froze after "returning from
> > prom_init".  ie: before it had done any WARNs or BUGs.  It's rather
> > mysterious.
> 
> Works for me:
> 
> Diego5:~# uname -a
> Linux Diego5 2.6.19-rc2-mm1-git #9 SMP Wed Oct 18 19:30:38 EST 2006 ppc64 GNU/Linux

Yeah, weird.  I'll test it a third time.

> Diego5:~# echo 4 > /proc/sys/vm/drop_caches
> Badness in drop_caches_sysctl_handler at /home/michael/src/auto/git/fs/drop_caches.c:67
> Call Trace:
> [C0000000431F7760] [C00000000000F8E4] .show_stack+0x6c/0x1a0 (unreliable)
> [C0000000431F7800] [C000000000447B8C] .program_check_exception+0x19c/0x5cc
> [C0000000431F78A0] [C00000000000446C] program_check_common+0xec/0x100
> --- Exception: 700 at .drop_caches_sysctl_handler+0x5c/0x88
>     LR = .drop_caches_sysctl_handler+0x20/0x88
> [C0000000431F7C20] [C00000000005725C] .do_rw_proc+0x168/0x230
> [C0000000431F7CF0] [C0000000000BC76C] .vfs_write+0xd0/0x1b4
> [C0000000431F7D90] [C0000000000BD134] .sys_write+0x4c/0x8c
> [C0000000431F7E30] [C00000000000861C] syscall_exit+0x0/0x40
> Diego5:~# echo 8 > /proc/sys/vm/drop_caches
> kernel BUG in drop_caches_sysctl_handler at /home/michael/src/auto/git/fs/drop_caches.c:69!
> cpu 0xd: Vector: 700 (Program Check) at [c0000000431f7910]
>     pc: c0000000000e3a5c: .drop_caches_sysctl_handler+0x68/0x88
>     lr: c0000000000e3a14: .drop_caches_sysctl_handler+0x20/0x88
>     sp: c0000000431f7b90
>    msr: 8000000000029032
>   current = 0xc00000000fc8c810
>   paca    = 0xc000000000564e00
>     pid   = 1465, comm = bash
> kernel BUG in drop_caches_sysctl_handler at /home/michael/src/auto/git/fs/drop_caches.c:69!
> enter ? for help
> [c0000000431f7c20] c00000000005725c .do_rw_proc+0x168/0x230
> [c0000000431f7cf0] c0000000000bc76c .vfs_write+0xd0/0x1b4
> [c0000000431f7d90] c0000000000bd134 .sys_write+0x4c/0x8c
> [c0000000431f7e30] c00000000000861c syscall_exit+0x0/0x40
> --- Exception: c01 (System Call) at 000000000fec9aac
> SP (ff8416f0) is in userspace
> d:mon> 
> 
> There's some NUMA badness going around that you might be hitting.

I don't set CONFIG_NUMA on the g5.
