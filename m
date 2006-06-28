Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422742AbWF1AB3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422742AbWF1AB3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 20:01:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422743AbWF1AB3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 20:01:29 -0400
Received: from smtp.osdl.org ([65.172.181.4]:36481 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1422742AbWF1AB2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 20:01:28 -0400
Date: Tue, 27 Jun 2006 17:04:46 -0700
From: Andrew Morton <akpm@osdl.org>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: stsp@aknet.ru, linux-kernel@vger.kernel.org
Subject: Re: the creation of boot_cpu_init() is wrong and accessing
 uninitialised data
Message-Id: <20060627170446.30392b00.akpm@osdl.org>
In-Reply-To: <1151419746.3340.13.camel@mulgrave.il.steeleye.com>
References: <1151376313.3443.12.camel@mulgrave.il.steeleye.com>
	<20060626200433.bf0292af.akpm@osdl.org>
	<1151379392.3443.20.camel@mulgrave.il.steeleye.com>
	<20060626220337.06014184.akpm@osdl.org>
	<1151419746.3340.13.camel@mulgrave.il.steeleye.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Bottomley <James.Bottomley@SteelEye.com> wrote:
>
> > > However, introducing setup_smp_processor_id() will also work ... I'll
> > > see if I can do it in an easy way.
> > 
> > It's a bit odd - I think non-zero BSPs happen a bit more often than
> > only-on-voyager.
> 
> OK, here's the patch that adds this API then.
> 
> James
> 
> Index: voyager-init-2.6/include/linux/smp.h
> ===================================================================
> --- voyager-init-2.6.orig/include/linux/smp.h	2006-06-27 09:20:42.000000000 -0500
> +++ voyager-init-2.6/include/linux/smp.h	2006-06-27 09:23:23.000000000 -0500
> @@ -74,6 +74,15 @@
>   */
>  void smp_prepare_boot_cpu(void);
>  
> +/*
> + * Some architectures use current_thread_info()->cpu to get the
> + * CPU, so for the boot CPU this has to be set up really early.  Thus
> + * this hook is used to initialise the value if necessary
> + */
> +#ifndef ARCH_HAS_SMP_SETUP_PROCESSOR_ID
> +void smp_setup_processor_id(void) { }
> +#endif

That wants to be `static inline'.


But still.  __attribute__((weak)) is wonderful for this sort of thing. 
Methinks it's much neater to do:


diff -puN init/main.c~add-smp_setup_processor_id init/main.c
--- a/init/main.c~add-smp_setup_processor_id
+++ a/init/main.c
@@ -454,10 +454,17 @@ static void __init boot_cpu_init(void)
 	cpu_set(cpu, cpu_possible_map);
 }
 
+static void __init __attribute__((weak)) smp_setup_processor_id(void)
+{
+}
+
 asmlinkage void __init start_kernel(void)
 {
 	char * command_line;
 	extern struct kernel_param __start___param[], __stop___param[];
+
+	smp_setup_processor_id();
+
 /*
  * Interrupts are still disabled. Do necessary setups, then
  * enable them
diff -puN arch/i386/mach-voyager/voyager_smp.c~add-smp_setup_processor_id arch/i386/mach-voyager/voyager_smp.c
--- a/arch/i386/mach-voyager/voyager_smp.c~add-smp_setup_processor_id
+++ a/arch/i386/mach-voyager/voyager_smp.c
@@ -1938,3 +1938,9 @@ smp_cpus_done(unsigned int max_cpus)
 {
 	zap_low_mappings();
 }
+
+void __init
+smp_setup_processor_id(void)
+{
+	current_thread_info()->cpu = hard_smp_processor_id();
+}
diff -puN include/linux/smp.h~add-smp_setup_processor_id include/linux/smp.h
--- a/include/linux/smp.h~add-smp_setup_processor_id
+++ a/include/linux/smp.h
@@ -125,4 +125,6 @@ static inline void smp_send_reschedule(i
 #define put_cpu()		preempt_enable()
 #define put_cpu_no_resched()	preempt_enable_no_resched()
 
+void smp_setup_processor_id(void);
+
 #endif /* __LINUX_SMP_H */
_


Note that I moved the call to smp_setup_processor_id() to be super-early. 
Before the lock_kernel(), before everything.  It seems better that way. 
And there's lockdep init stuff in -mm which is called immediately on entry
to start_kernel() which might want to use smp_processor_id().

Is that all OK?
