Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262021AbSJJTD5>; Thu, 10 Oct 2002 15:03:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262146AbSJJTD5>; Thu, 10 Oct 2002 15:03:57 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:30129 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S262021AbSJJTDz>;
	Thu, 10 Oct 2002 15:03:55 -0400
Subject: Re: Patch?: linux-2.5.41 multiprocessor vs. CONFIG_X86_TSC
From: john stultz <johnstul@us.ibm.com>
To: john stultz <johnstul@us.ibm.com>
Cc: William Lee Irwin III <wli@holomorphy.com>,
       "Adam J. Richter" <adam@yggdrasil.com>, mingo@redhat.com,
       James.Bottomley@HansenPartnership.com,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <1034274158.19093.28.camel@cog>
References: <20021010050212.A383@baldur.yggdrasil.com> 
	<20021010121757.GY12432@holomorphy.com>  <1034274158.19093.28.camel@cog>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 10 Oct 2002 12:01:52 -0700
Message-Id: <1034276513.19094.38.camel@cog>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-10-10 at 11:22, john stultz wrote:
> Alan has a good cleanup patch (included below) for 2.4. that folks might
> consider to for 2.5. It helps remove the #ifdefs and lets the compiler
> do the optimization. 

Whoops, forgot to inline this at the end. This is a bit old, for
2.4.20-pre2, but I don't think much has change here.



diff -Nru a/arch/i386/kernel/setup.c b/arch/i386/kernel/setup.c
--- a/arch/i386/kernel/setup.c	Thu Aug 15 17:10:44 2002
+++ b/arch/i386/kernel/setup.c	Thu Aug 15 17:10:44 2002
@@ -1145,6 +1145,8 @@
 }
 
 __setup("notsc", tsc_setup);
+#else
+#define tsc_disable 0
 #endif
 
 static int __init highio_setup(char *str)
@@ -2734,10 +2736,8 @@
 	 */
 
 	/* TSC disabled? */
-#ifndef CONFIG_X86_TSC
 	if ( tsc_disable )
 		clear_bit(X86_FEATURE_TSC, &c->x86_capability);
-#endif
 
 	/* HT disabled? */
 	if (disable_x86_ht)
@@ -2979,14 +2979,12 @@
 
 	if (cpu_has_vme || cpu_has_tsc || cpu_has_de)
 		clear_in_cr4(X86_CR4_VME|X86_CR4_PVI|X86_CR4_TSD|X86_CR4_DE);
-#ifndef CONFIG_X86_TSC
 	if (tsc_disable && cpu_has_tsc) {
 		printk(KERN_NOTICE "Disabling TSC...\n");
 		/**** FIX-HPA: DOES THIS REALLY BELONG HERE? ****/
 		clear_bit(X86_FEATURE_TSC, boot_cpu_data.x86_capability);
 		set_in_cr4(X86_CR4_TSD);
 	}
-#endif
 
 	__asm__ __volatile__("lgdt %0": "=m" (gdt_descr));
 	__asm__ __volatile__("lidt %0": "=m" (idt_descr));

