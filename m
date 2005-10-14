Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750914AbVJNTZJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750914AbVJNTZJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Oct 2005 15:25:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750917AbVJNTZJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Oct 2005 15:25:09 -0400
Received: from qproxy.gmail.com ([72.14.204.202]:38626 "EHLO qproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750897AbVJNTZH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Oct 2005 15:25:07 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:subject:from:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:x-mailer:content-transfer-encoding;
        b=sLQvrBapOQWFf8VcWfWNc3P/RpXJuXgMIgYl/r3ccYyaRh9rlXsuGaKCnbNvoi9Mr8tApxtEbFFUZayVI+vFRu0y/RjZ1lzVlex56SWUMvUbMbcNOoVM+1KuOJzJZLdOrZUtQBKMM+tkdKJQom/cGvvdekkq5n2gV5CkbJ7mRRA=
Subject: Re: 2.6.14-rc4-rt1
From: Badari Pulavarty <pbadari@gmail.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Andi Kleen <ak@suse.de>, lkml <linux-kernel@vger.kernel.org>,
       Thomas Gleixner <tglx@linutronix.de>,
       Steven Rostedt <rostedt@goodmis.org>, dwalker@mvista.com,
       david singleton <dsingleton@mvista.com>
In-Reply-To: <20051014131250.GA25466@elte.hu>
References: <20051011111454.GA15504@elte.hu>
	 <1129135337.21743.11.camel@localhost.localdomain>
	 <20051014062212.GA30874@elte.hu> <p73r7aos9ox.fsf@verdi.suse.de>
	 <20051014131250.GA25466@elte.hu>
Content-Type: text/plain
Date: Fri, 14 Oct 2005 12:24:25 -0700
Message-Id: <1129317865.6266.15.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-10-14 at 15:12 +0200, Ingo Molnar wrote:
> * Andi Kleen <ak@suse.de> wrote:
> 
> > > > I am getting similar segfault on boot problem on 2.6.14-rc4-rt1 on my 
> > > > x86-64 box (with LATENCY_TRACE).
> > > 
> > > > INIT: version 2.86 booting
> > > > hotplug[877]: segfault at ffffffff8010f588 rip ffffffff8010f588 rsp
> > > > 00007fffff8bee68 error 15
> > > 
> > > what does the ffffffff8010f588 RIP address map to? You can find out by 
> > 
> > It could be any kernel address that someone injected into user space.  
> > Most likely some problem with the vsyscall page with either signal 
> > handling or gettimeofday. vsyscall code is tricky to hack because you 
> > cannot add any new functions there, just inlines, otherwise the code 
> > won't end up the right section.
> 
> ah, indeed - i completely forgot about vsyscalls - they must not be 
> traced. Badari, does the patch below help?
> 
> 	Ingo
> 
> Index: linux/arch/x86_64/kernel/vsyscall.c
> ===================================================================
> --- linux.orig/arch/x86_64/kernel/vsyscall.c
> +++ linux/arch/x86_64/kernel/vsyscall.c
> @@ -34,7 +34,7 @@
>  #include <asm/errno.h>
>  #include <asm/io.h>
>  
> -#define __vsyscall(nr) __attribute__ ((unused,__section__(".vsyscall_" #nr)))
> +#define __vsyscall(nr) __attribute__ ((unused,__section__(".vsyscall_" #nr))) notrace
>  #define force_inline __attribute__((always_inline)) inline
>  
>  int __sysctl_vsyscall __section_sysctl_vsyscall = 1;

The patch fixed my problem. Machine boots fine.

My next problem. I can't seem to compile the kernel on -rc4-rt1

elm3a242:/usr/src/linux-2.6.14-rc4 # make
  CHK     include/linux/version.h
  SPLIT   include/linux/autoconf.h -> include/config/*
  CC      arch/x86_64/kernel/asm-offsets.s
  GEN     include/asm-x86_64/asm-offsets.h
Trace/breakpoint trap
elm3a242:/usr/src/linux-2.6.14-rc4 # uname -a
Linux elm3a242 2.6.14-rc4-rt1 #4 SMP PREEMPT Fri Oct 14 05:16:35 PDT
2005 x86_64 x86_64 x86_64 GNU/Linux


Thanks,
Badari

