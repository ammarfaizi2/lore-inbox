Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750749AbWGLGrU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750749AbWGLGrU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 02:47:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750755AbWGLGrU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 02:47:20 -0400
Received: from smtp.osdl.org ([65.172.181.4]:25270 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750749AbWGLGrU convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 02:47:20 -0400
Date: Tue, 11 Jul 2006 23:46:05 -0700
From: Andrew Morton <akpm@osdl.org>
To: Fernando Luis =?ISO-8859-1?B?VuF6cXVleg==?= Cao 
	<fernando@oss.ntt.co.jp>
Cc: vgoyal@in.ibm.com, ebiederm@xmission.com, ak@suse.de,
       James.Bottomley@steeleye.com, linux-kernel@vger.kernel.org,
       fastboot@lists.osdl.org
Subject: Re: [PATCH 1/4] stack overflow safe kdump (2.6.18-rc1-i386) -
 safe_smp_processor_id
Message-Id: <20060711234605.86fd8c98.akpm@osdl.org>
In-Reply-To: <1152597918.2414.54.camel@localhost.localdomain>
References: <1152597918.2414.54.camel@localhost.localdomain>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Jul 2006 15:05:18 +0900
Fernando Luis Vázquez Cao <fernando@oss.ntt.co.jp> wrote:
> ...

With CONFIG_SMP=n:

arch/i386/kernel/crash.c: In function 'crash_save_self':
arch/i386/kernel/crash.c:91: warning: implicit declaration of function 'safe_smp_processor_id'

And it fails to link.


> --- linux-2.6.18-rc1/include/asm-i386/smp.h	2006-07-11 10:11:44.000000000 +0900
> +++ linux-2.6.18-rc1-sof/include/asm-i386/smp.h	2006-07-11 14:05:28.000000000 +0900
> @@ -89,12 +89,14 @@ static __inline int logical_smp_processo
>  
>  #endif
>  
> +extern int safe_smp_processor_id(void);
>  extern int __cpu_disable(void);
>  extern void __cpu_die(unsigned int cpu);
>  #endif /* !__ASSEMBLY__ */
>  
>  #else /* CONFIG_SMP */
>  
> +#define safe_smp_processor_id()		0
>  #define cpu_physical_id(cpu)		boot_cpu_physical_apicid
>  
>  #define NO_PROC_ID		0xFF		/* No processor magic marker */

The reason for this is that include/linux/smp.h only includes asm/smp.h if
CONFIG_SMP=y.  This is not the cleverest thing we've ever done.

I fixed that in cowardly fashion:


--- a/arch/i386/kernel/crash.c~stack-overflow-safe-kdump-crash_use_safe_smp_processor_id-fix
+++ a/arch/i386/kernel/crash.c
@@ -23,6 +23,7 @@
 #include <asm/hw_irq.h>
 #include <asm/apic.h>
 #include <asm/kdebug.h>
+#include <asm/smp.h>
 
 #include <mach_ipi.h>
 
_

