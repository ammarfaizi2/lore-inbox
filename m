Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261384AbVD3UBR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261384AbVD3UBR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Apr 2005 16:01:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261386AbVD3UBR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Apr 2005 16:01:17 -0400
Received: from rproxy.gmail.com ([64.233.170.194]:5689 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261384AbVD3UBM convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Apr 2005 16:01:12 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=qiMvEMdZxNjl1uZxouFW1+/6Ry7SKG1gZX48vGAvT+m5Cey95+KHM8dttE6JGBn2IU+GL65hWTQYFOclNr8KDZOZP7gegf+NMXopf/XWhezd7mG6CsMt+DtfD3mmh6XHpyVknRq6JWPtp8VVHRJqKhOwFGOafae7DBseSfMyQ6g=
Message-ID: <2cd57c9005043013017ecd8a5d@mail.gmail.com>
Date: Sun, 1 May 2005 04:01:11 +0800
From: Coywolf Qi Hunt <coywolf@gmail.com>
Reply-To: coywolf@lovecn.org
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.12-rc3-mm1
Cc: zwane@arm.linux.org.uk, linux-kernel@vger.kernel.org, ak@muc.de,
       bunk@stusta.de, Li Shaohua <shaohua.li@intel.com>
In-Reply-To: <20050430124611.54b5ab15.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050429231653.32d2f091.akpm@osdl.org>
	 <20050430142035.GB3571@stusta.de>
	 <Pine.LNX.4.61.0504300940560.12903@montezuma.fsmlabs.com>
	 <2cd57c9005043010051c6455fb@mail.gmail.com>
	 <20050430180823.GA14922@lovecn.org>
	 <20050430124611.54b5ab15.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/1/05, Andrew Morton <akpm@osdl.org> wrote:
> 
> Thanks, guys.  I seem to have it limping along on UP now, partly with the
> below.
> 
> Li, it's a bit awkward to be calling things by hand on SMP and with an
> initcall on UP.  Maybe something neater can be done there.
> 
> I quickly tested suspend/resume on UP.  Appears to work.

Yes, this seems also fixe the compile warning:

  CC      arch/i386/power/cpu.o
/home/coywolf/2.6.12-rc3-mm1-cy2/arch/i386/power/cpu.c: In function
`__restore_processor_state':
/home/coywolf/2.6.12-rc3-mm1-cy2/arch/i386/power/cpu.c:137: warning:
implicit declaration of function `enable_sep_cpu'
  LD      arch/i386/power/built-in.o

I was trying to fix it too. You are quicker and better than me.


> 
>  arch/i386/kernel/sysenter.c  |   10 ++++++++++
>  arch/i386/power/cpu.c        |    2 ++
>  include/asm-i386/processor.h |    1 +
>  include/asm-i386/smp.h       |    1 -
>  4 files changed, 13 insertions(+), 1 deletion(-)
> 
> diff -puN arch/i386/kernel/sysenter.c~sep-initializing-rework-fix arch/i386/kernel/sysenter.c
> --- 25/arch/i386/kernel/sysenter.c~sep-initializing-rework-fix  2005-04-30 12:20:20.370077048 -0700
> +++ 25-akpm/arch/i386/kernel/sysenter.c 2005-04-30 12:20:20.375076288 -0700
> @@ -65,3 +65,13 @@ int __init sysenter_setup(void)
> 
>         return 0;
>  }
> +
> +#ifndef CONFIG_SMP
> +static int __init sysenter_sep_setup(void)
> +{
> +       sysenter_setup();
> +       enable_sep_cpu();
> +       return 0;
> +}
> +module_init(sysenter_sep_setup);
> +#endif
> diff -puN arch/i386/power/cpu.c~sep-initializing-rework-fix arch/i386/power/cpu.c
> --- 25/arch/i386/power/cpu.c~sep-initializing-rework-fix        2005-04-30 12:20:20.371076896 -0700
> +++ 25-akpm/arch/i386/power/cpu.c       2005-04-30 12:20:35.890717552 -0700
> @@ -22,9 +22,11 @@
>  #include <linux/device.h>
>  #include <linux/suspend.h>
>  #include <linux/acpi.h>
> +
>  #include <asm/uaccess.h>
>  #include <asm/acpi.h>
>  #include <asm/tlbflush.h>
> +#include <asm/processor.h>
> 
>  static struct saved_context saved_context;
> 
> diff -puN include/asm-i386/processor.h~sep-initializing-rework-fix include/asm-i386/processor.h
> --- 25/include/asm-i386/processor.h~sep-initializing-rework-fix 2005-04-30 12:20:41.633844464 -0700
> +++ 25-akpm/include/asm-i386/processor.h        2005-04-30 12:21:04.316396192 -0700
> @@ -691,5 +691,6 @@ extern void select_idle_routine(const st
>  #define cache_line_size() (boot_cpu_data.x86_cache_alignment)
> 
>  extern unsigned long boot_option_idle_override;
> +extern void enable_sep_cpu(void);
> 
>  #endif /* __ASM_I386_PROCESSOR_H */
> diff -puN include/asm-i386/smp.h~sep-initializing-rework-fix include/asm-i386/smp.h
> --- 25/include/asm-i386/smp.h~sep-initializing-rework-fix       2005-04-30 12:20:45.463262304 -0700
> +++ 25-akpm/include/asm-i386/smp.h      2005-04-30 12:20:53.140095248 -0700
> @@ -38,7 +38,6 @@ extern cpumask_t cpu_sibling_map[];
>  extern cpumask_t cpu_core_map[];
> 
>  extern int sysenter_setup(void);
> -extern void enable_sep_cpu(void);
> 
>  extern void smp_flush_tlb(void);
>  extern void smp_message_irq(int cpl, void *dev_id, struct pt_regs *regs);
> _
> 
> 


-- 
Coywolf Qi Hunt
http://sosdg.org/~coywolf/
