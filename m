Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267495AbUBSTZl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 14:25:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267492AbUBSTZk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 14:25:40 -0500
Received: from ns.suse.de ([195.135.220.2]:49354 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S267495AbUBSTYt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 14:24:49 -0500
Date: Fri, 20 Feb 2004 17:13:37 +0100
From: Andi Kleen <ak@suse.de>
To: Tony Lindgren <tony@atomide.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Intel x86-64 support patch breaks amd64
Message-Id: <20040220171337.10cd1ae8.ak@suse.de>
In-Reply-To: <20040219183448.GB8960@atomide.com>
References: <20040219183448.GB8960@atomide.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Feb 2004 10:34:49 -0800
Tony Lindgren <tony@atomide.com> wrote:

> I guess you probably already know about this, but the recent changeset
> 1.1561.1.1 breaks compiling and booting for amd64.

You need the appended patch to build on Uni Processor again. I already
submitted it to Linus, but he doesn't seem to have merged it yet
(or alternatively compile for SMP) 

> After #if 0 out some parts to make it compile, it fails to boot with no
> output at all. Sorry, don't have low level debugging or serial console on 
> this machine configured, let me know if you need further information.

It works for me with this patch both UP and SMP. Maybe you commented out 
too much? 

-Andi

diff -u linux-2.6.3/arch/x86_64/kernel/setup.c-o linux-2.6.3/arch/x86_64/kernel/setup.c
--- linux-2.6.3/arch/x86_64/kernel/setup.c-o	2004-02-19 09:01:09.000000000 +0100
+++ linux-2.6.3/arch/x86_64/kernel/setup.c	2004-02-19 09:09:27.000000000 +0100
@@ -588,6 +588,7 @@
 
 static void __init detect_ht(void)
 {
+#ifdef CONFIG_SMP
 	extern	int phys_proc_id[NR_CPUS];
 	
 	u32 	eax, ebx, ecx, edx;
@@ -631,6 +632,7 @@
 		printk(KERN_INFO  "CPU: Physical Processor ID: %d\n",
 		       phys_proc_id[cpu]);
 	}
+#endif
 }
 	
 #define LVL_1_INST	1
diff -u linux-2.6.3/arch/x86_64/kernel/Makefile-o linux-2.6.3/arch/x86_64/kernel/Makefile
--- linux-2.6.3/arch/x86_64/kernel/Makefile-o	2004-02-19 09:01:09.000000000 +0100
+++ linux-2.6.3/arch/x86_64/kernel/Makefile	2004-02-19 09:15:41.000000000 +0100
@@ -33,4 +33,4 @@
 cpuid-$(subst m,y,$(CONFIG_X86_CPUID))  += ../../i386/kernel/cpuid.o
 topology-y                     += ../../i386/mach-default/topology.o
 swiotlb-$(CONFIG_SWIOTLB)      += ../../ia64/lib/swiotlb.o
-microcode-$(CONFIG_MICROCODE)  += ../../i386/kernel/microcode.o
+microcode-$(subst m,y,$(CONFIG_X86_CPUID))  += ../../i386/kernel/microcode.o
diff -u linux-2.6.3/arch/x86_64/kernel/x8664_ksyms.c-o linux-2.6.3/arch/x86_64/kernel/x8664_ksyms.c
--- linux-2.6.3/arch/x86_64/kernel/x8664_ksyms.c-o	2004-02-19 09:01:09.000000000 +0100
+++ linux-2.6.3/arch/x86_64/kernel/x8664_ksyms.c	2004-02-19 09:08:04.000000000 +0100
@@ -194,7 +194,9 @@
 
 EXPORT_SYMBOL(die_chain);
 
+#ifdef CONFIG_SMP_
 EXPORT_SYMBOL(cpu_sibling_map);
+#endif
 
 extern void do_softirq_thunk(void);
 EXPORT_SYMBOL_NOVERS(do_softirq_thunk);
