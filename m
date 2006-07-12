Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750737AbWGLG7T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750737AbWGLG7T (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 02:59:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750747AbWGLG7S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 02:59:18 -0400
Received: from serv1.oss.ntt.co.jp ([222.151.198.98]:53397 "EHLO
	serv1.oss.ntt.co.jp") by vger.kernel.org with ESMTP
	id S1750737AbWGLG7S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 02:59:18 -0400
Subject: Re: [PATCH 1/4] stack overflow safe kdump (2.6.18-rc1-i386) -
	safe_smp_processor_id
From: Fernando Luis =?ISO-8859-1?Q?V=E1zquez?= Cao 
	<fernando@oss.ntt.co.jp>
To: Andrew Morton <akpm@osdl.org>
Cc: vgoyal@in.ibm.com, ebiederm@xmission.com, ak@suse.de,
       James.Bottomley@steeleye.com, linux-kernel@vger.kernel.org,
       fastboot@lists.osdl.org
In-Reply-To: <20060711234605.86fd8c98.akpm@osdl.org>
References: <1152597918.2414.54.camel@localhost.localdomain>
	 <20060711234605.86fd8c98.akpm@osdl.org>
Content-Type: text/plain; charset=utf-8
Organization: =?UTF-8?Q?NTT=E3=82=AA=E3=83=BC=E3=83=97=E3=83=B3=E3=82=BD=E3=83=BC?=
	=?UTF-8?Q?=E3=82=B9=E3=82=BD=E3=83=95=E3=83=88=E3=82=A6=E3=82=A7?=
	=?UTF-8?Q?=E3=82=A2=E3=82=BB=E3=83=B3=E3=82=BF?=
Date: Wed, 12 Jul 2006 15:59:12 +0900
Message-Id: <1152687552.3699.5.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-07-11 at 23:46 -0700, Andrew Morton wrote:
> On Tue, 11 Jul 2006 15:05:18 +0900
> Fernando Luis Vázquez Cao <fernando@oss.ntt.co.jp> wrote:
> > ...
> 
> With CONFIG_SMP=n:
> 
> arch/i386/kernel/crash.c: In function 'crash_save_self':
> arch/i386/kernel/crash.c:91: warning: implicit declaration of function 'safe_smp_processor_id'
> 
> And it fails to link.
Thank you for catching this! I had only tried i386-SMP and voyager-SMP
configurations. I will try several UP configurations and see if it
compiles properly.

Sorry for the trouble.

 - Fernando

> > --- linux-2.6.18-rc1/include/asm-i386/smp.h	2006-07-11 10:11:44.000000000 +0900
> > +++ linux-2.6.18-rc1-sof/include/asm-i386/smp.h	2006-07-11 14:05:28.000000000 +0900
> > @@ -89,12 +89,14 @@ static __inline int logical_smp_processo
> >  
> >  #endif
> >  
> > +extern int safe_smp_processor_id(void);
> >  extern int __cpu_disable(void);
> >  extern void __cpu_die(unsigned int cpu);
> >  #endif /* !__ASSEMBLY__ */
> >  
> >  #else /* CONFIG_SMP */
> >  
> > +#define safe_smp_processor_id()		0
> >  #define cpu_physical_id(cpu)		boot_cpu_physical_apicid
> >  
> >  #define NO_PROC_ID		0xFF		/* No processor magic marker */
> 
> The reason for this is that include/linux/smp.h only includes asm/smp.h if
> CONFIG_SMP=y.  This is not the cleverest thing we've ever done.
> 
> I fixed that in cowardly fashion:
> 
> 
> --- a/arch/i386/kernel/crash.c~stack-overflow-safe-kdump-crash_use_safe_smp_processor_id-fix
> +++ a/arch/i386/kernel/crash.c
> @@ -23,6 +23,7 @@
>  #include <asm/hw_irq.h>
>  #include <asm/apic.h>
>  #include <asm/kdebug.h>
> +#include <asm/smp.h>
>  
>  #include <mach_ipi.h>
>  
> _
> 

