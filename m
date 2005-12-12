Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932122AbVLLWMl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932122AbVLLWMl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 17:12:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932128AbVLLWMl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 17:12:41 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:53889 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S932122AbVLLWMl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 17:12:41 -0500
Subject: Re: 2.6.15-rc5-rt1 will not compile (was Re: 2.6.14-rt15: cannot
	build with !PREEMPT_RT)
From: Lee Revell <rlrevell@joe-job.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: david singleton <dsingleton@mvista.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>
In-Reply-To: <1134424143.24145.6.camel@localhost.localdomain>
References: <1133031912.5904.12.camel@mindpipe>
	 <1133034406.32542.308.camel@tglx.tec.linutronix.de>
	 <20051127123052.GA22807@elte.hu> <1133141224.4909.1.camel@mindpipe>
	 <20051128114852.GA3391@elte.hu> <1133189789.5228.7.camel@mindpipe>
	 <20051128160052.GA29540@elte.hu> <1133217651.4678.2.camel@mindpipe>
	 <1133230103.5640.0.camel@mindpipe> <20051129072922.GA21696@elte.hu>
	 <20051129093231.GA5028@elte.hu>  <1134090316.11053.3.camel@mindpipe>
	 <1134174330.18432.46.camel@mindpipe>  <1134409469.15074.1.camel@mindpipe>
	 <1134424143.24145.6.camel@localhost.localdomain>
Content-Type: text/plain
Date: Mon, 12 Dec 2005 17:14:48 -0500
Message-Id: <1134425688.17058.5.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-12-12 at 16:49 -0500, Steven Rostedt wrote:
> On Mon, 2005-12-12 at 12:44 -0500, Lee Revell wrote:
> > On Fri, 2005-12-09 at 19:25 -0500, Lee Revell wrote:
> > > > We are unable to build a similar .config (PREEMPT_DESKTOP with soft and
> > > > hardirq preemption disabled) on x86-64:
> > > 
> > > Here is the build output, .config attached.
> > 
> > Similar problem with 2.6.15-rc5-rt1:
> > 
> > $ make
> >   CHK     include/linux/version.h
> >   UPD     include/linux/version.h
> >   SYMLINK include/asm -> include/asm-x86_64
> >   SPLIT   include/linux/autoconf.h -> include/config/*
> >   CC      arch/x86_64/kernel/asm-offsets.s
> > In file included from include/asm/semaphore.h:48,
> >                  from include/linux/sched.h:20,
> >                  from arch/x86_64/kernel/asm-offsets.c:7:
> > include/linux/rwsem.h:43:66: error: asm/rwsem.h: No such file or
> > directory
> > In file included from include/asm/semaphore.h:48,
> >                  from include/linux/sched.h:20,
> >                  from arch/x86_64/kernel/asm-offsets.c:7:
> 
> Looks like Ingo has a generic rwsem to work with, but if your arch turns
> on CONFIG_RWSEM_XCHGADD_ALGORITHM, it will compile lib/rwsem.c which
> won't compile as you've seen.
> 
> Try out this patch:  I changed the Makefile, instead of going to each
> and every arch and change its Kconfig to do it properly.

The patch had no effect.

In fact x86-64 does not set CONFIG_RWSEM_XCHGADD_ALGORITHM so this test
in include/linux/rwsem.h causes asm/rwsem.h to be included which does
not exist on x86-64:

36 #ifdef CONFIG_RWSEM_GENERIC_SPINLOCK
37 # include <linux/rwsem-spinlock.h> /* use a generic implementation */
38 #  ifndef CONFIG_PREEMPT_RT
39 #  define __RWSEM_INITIALIZER __COMPAT_RWSEM_INITIALIZER
40 #  define DECLARE_RWSEM COMPAT_DECLARE_RWSEM
41 # endif
42 #else
43 # include <asm/rwsem.h> /* use an arch-specific implementation */
44 #endif

If I change that code to always include <linux/rwsem-spinlock.h>, I get
the exact same failures I did with 2.6.14-rt22:

$ make
  CHK     include/linux/version.h
  CC      arch/x86_64/kernel/asm-offsets.s
  GEN     include/asm-x86_64/asm-offsets.h
  CC      init/main.o
In file included from include/linux/proc_fs.h:6,
                 from init/main.c:17:
include/linux/fs.h: In function 'lock_super':
include/linux/fs.h:867: warning: implicit declaration of function 'down'
include/linux/fs.h: In function 'unlock_super':
include/linux/fs.h:873: warning: implicit declaration of function 'up'
  CHK     include/linux/compile.h
  CC      init/version.o
  CC      init/do_mounts.o
In file included from include/linux/tty.h:20,
                 from init/do_mounts.c:5:
include/linux/fs.h: In function 'lock_super':
include/linux/fs.h:867: warning: implicit declaration of function 'down'
include/linux/fs.h: In function 'unlock_super':
include/linux/fs.h:873: warning: implicit declaration of function 'up'

etc.

Lee



