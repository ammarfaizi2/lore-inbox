Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751153AbWFPHzc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751153AbWFPHzc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jun 2006 03:55:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751155AbWFPHzc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jun 2006 03:55:32 -0400
Received: from tayrelbas03.tay.hp.com ([161.114.80.246]:20684 "EHLO
	tayrelbas03.tay.hp.com") by vger.kernel.org with ESMTP
	id S1751153AbWFPHzc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jun 2006 03:55:32 -0400
Date: Fri, 16 Jun 2006 00:47:56 -0700
From: Stephane Eranian <eranian@hpl.hp.com>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 12/16] 2.6.17-rc6 perfmon2 patch for review: modified i386 files
Message-ID: <20060616074756.GB10034@frankl.hpl.hp.com>
Reply-To: eranian@hpl.hp.com
References: <200606152301_MC3-1-C28E-ADE0@compuserve.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200606152301_MC3-1-C28E-ADE0@compuserve.com>
User-Agent: Mutt/1.4.1i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: eranian@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chuck,

On Thu, Jun 15, 2006 at 11:00:01PM -0400, Chuck Ebbert wrote:
> >
> > diff -ur linux-2.6.17-rc6.orig/arch/i386/kernel/apic.c linux-2.6.17-rc6/arch/i386/kernel/apic.c
> > --- linux-2.6.17-rc6.orig/arch/i386/kernel/apic.c     2006-06-08 01:42:30.000000000 -0700
> > +++ linux-2.6.17-rc6/arch/i386/kernel/apic.c  2006-06-08 01:49:22.000000000 -0700
> > @@ -27,6 +27,7 @@
> >  #include <linux/sysdev.h>
> >  #include <linux/cpu.h>
> >  #include <linux/module.h>
> > +#include <linux/perfmon.h>
> >  
> >  #include <asm/atomic.h>
> >  #include <asm/smp.h>
> > @@ -1179,6 +1180,8 @@
> >       update_process_times(user_mode_vm(regs));
> >  #endif
> >  
> > +     pfm_handle_switch_timeout();
> > +
> >       /*
> >        * We take the 'long' return path, and there every subsystem
> >        * grabs the apropriate locks (kernel lock/ irq lock).
> 
> Please add '-p' to your diff options.  It makes it easier to see what is
> happening.
> 
Will do for next patch. This is indeed a very useful option I did not know about.

> > diff -ur linux-2.6.17-rc6.orig/arch/i386/kernel/syscall_table.S linux-2.6.17-rc6/arch/i386/kernel/syscall_table.S
> > --- linux-2.6.17-rc6.orig/arch/i386/kernel/syscall_table.S    2006-06-08 01:42:30.000000000 -0700
> > +++ linux-2.6.17-rc6/arch/i386/kernel/syscall_table.S 2006-06-08 01:50:27.000000000 -0700
> > @@ -316,3 +316,15 @@
> >       .long sys_sync_file_range
> >       .long sys_tee                   /* 315 */
> >       .long sys_vmsplice
> > +             .long sys_pfm_create_context
> > +             .long sys_pfm_write_pmcs
> > +             .long sys_pfm_write_pmds
> > +             .long sys_pfm_read_pmds         /* 320 */
> > +             .long sys_pfm_load_context
> > +             .long sys_pfm_start
> > +             .long sys_pfm_stop
> > +             .long sys_pfm_restart
> > +             .long sys_pfm_create_evtsets    /* 325 */
> > +             .long sys_pfm_getinfo_evtsets
> > +             .long sys_pfm_delete_evtsets
> > +     .long sys_pfm_unload_context
> 
> I think there are seven spaces plus a tab here for the first 11 new
> syscalls? (You won't be able to tell from my quote because my mail
> program mangles quoted text.)
> 
I fixed that now.

> >
> > <...>
> >
> > --- linux-2.6.17-rc6.orig/include/asm-i386/unistd.h   2006-06-08 01:42:35.000000000 -0700
> > +++ linux-2.6.17-rc6/include/asm-i386/unistd.h        2006-06-08 01:49:22.000000000 -0700
> > @@ -322,8 +322,19 @@
> >  #define __NR_sync_file_range 314
> >  #define __NR_tee             315
> >  #define __NR_vmsplice                316
> > +#define __NR_pfm_create_context      317
> > +#define __NR_pfm_write_pmcs  (__NR_pfm_create_context+1)
> > +#define __NR_pfm_write_pmds  (__NR_pfm_create_context+2)
> > +#define __NR_pfm_read_pmds   (__NR_pfm_create_context+3)
> > +#define __NR_pfm_load_context        (__NR_pfm_create_context+4)
> > +#define __NR_pfm_start               (__NR_pfm_create_context+5)
> > +#define __NR_pfm_stop                (__NR_pfm_create_context+6)
> > +#define __NR_pfm_restart     (__NR_pfm_create_context+7)
> > +#define __NR_pfm_create_evtsets      (__NR_pfm_create_context+8)
> > +#define __NR_pfm_getinfo_evtsets (__NR_pfm_create_context+9)
> > +#define __NR_pfm_delete_evtsets (__NR_pfm_create_context+10)
> >  
> > -#define NR_syscalls 317
> > +#define NR_syscalls 329
> >  
> >  /*
> >   * user-visible error numbers are in the range -1 - -128: see
> 
> You missed __NR_pfm_unload_context.
> 
I think, I dropped the line when I edit the patch to make it fit lkml limitations. The line
is there is the actual patch.

Thanks for your review.

-- 
-Stephane
