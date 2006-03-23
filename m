Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751204AbWCWGU6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751204AbWCWGU6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 01:20:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751224AbWCWGU6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 01:20:58 -0500
Received: from fmr19.intel.com ([134.134.136.18]:18141 "EHLO
	orsfmr004.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751204AbWCWGU5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 01:20:57 -0500
Subject: Re: [trival patch]disable warning in cpu_init for cpu hotplug
From: Shaohua Li <shaohua.li@intel.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060322213240.6ab28346.akpm@osdl.org>
References: <1143091268.11430.49.camel@sli10-desk.sh.intel.com>
	 <20060322213240.6ab28346.akpm@osdl.org>
Content-Type: text/plain
Date: Thu, 23 Mar 2006 14:19:39 +0800
Message-Id: <1143094779.11430.55.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-03-22 at 21:32 -0800, Andrew Morton wrote:
> Shaohua Li <shaohua.li@intel.com> wrote:
> >
> > The patch seems missed.
> >  GFP_KERNEL isn't ok for runtime (cpu hotplug).
> > 
> >  Signed-off-by: Shaohua Li<shaohua.li@intel.com>
> >  ---
> > 
> >   linux-2.6.15-root/arch/i386/kernel/cpu/common.c |    2 +-
> >   1 files changed, 1 insertion(+), 1 deletion(-)
> > 
> >  diff -puN arch/i386/kernel/cpu/common.c~cpuhp arch/i386/kernel/cpu/common.c
> >  --- linux-2.6.15/arch/i386/kernel/cpu/common.c~cpuhp	2006-03-14 12:13:43.000000000 +0800
> >  +++ linux-2.6.15-root/arch/i386/kernel/cpu/common.c	2006-03-14 12:14:12.000000000 +0800
> >  @@ -605,7 +605,7 @@ void __devinit cpu_init(void)
> >   		/* alloc_bootmem_pages panics on failure, so no check */
> >   		memset(gdt, 0, PAGE_SIZE);
> >   	} else {
> >  -		gdt = (struct desc_struct *)get_zeroed_page(GFP_KERNEL);
> >  +		gdt = (struct desc_struct *)get_zeroed_page(GFP_ATOMIC);
> >   		if (unlikely(!gdt)) {
> >   			printk(KERN_CRIT "CPU%d failed to allocate GDT\n", cpu);
> >   			for (;;)
> 
> 
> This isn't good.  GFP_ATOMIC can fail, and if it does, we'll lose this CPU
> and probably the entire machine.  It's OK to do this during initial boot,
> but not so OK to do it during CPU hotplug.
> 
> So can we please fix it better?
> 
> You don't describe _why_ the CPU is running atomically here - I wish you had.
> 
> One approach would be to allocate the page earlier, before we enter the
> atomic region, and to pass that page down to cpu_init(), or to save a
> pointer to it in an array of page*'s somewhere.
Thanks for the suggestion. Here is the updated patch.
The patch fixes two issues:
1. cpu_init is called with interrupt disabled. Allocating gdt table
there isn't good at runtime.
2. gdt table page cause memory leak in CPU hotplug case.

Signed-off-by: Shaohua Li <shaohua.li@intel.com>
---

 linux-2.6.16-root/arch/i386/kernel/cpu/common.c |    8 +++++++-
 linux-2.6.16-root/arch/i386/kernel/smpboot.c    |   13 +++++++++++++
 2 files changed, 20 insertions(+), 1 deletion(-)

diff -puN arch/i386/kernel/cpu/common.c~gdt_table arch/i386/kernel/cpu/common.c
--- linux-2.6.16/arch/i386/kernel/cpu/common.c~gdt_table	2006-03-22 11:57:56.000000000 +0800
+++ linux-2.6.16-root/arch/i386/kernel/cpu/common.c	2006-03-22 12:10:04.000000000 +0800
@@ -594,6 +594,12 @@ void __devinit cpu_init(void)
 		set_in_cr4(X86_CR4_TSD);
 	}
 
+	/* The CPU hotplug case */
+	if (cpu_gdt_descr->address) {
+		gdt = (struct desc_struct *)cpu_gdt_descr->address;
+		memset(gdt, 0, PAGE_SIZE);
+		goto old_gdt;
+	}
 	/*
 	 * This is a horrible hack to allocate the GDT.  The problem
 	 * is that cpu_init() is called really early for the boot CPU
@@ -612,7 +618,7 @@ void __devinit cpu_init(void)
 				local_irq_enable();
 		}
 	}
-
+old_gdt:
 	/*
 	 * Initialize the per-CPU GDT with the boot GDT,
 	 * and set up the GDT descriptor:
diff -puN arch/i386/kernel/smpboot.c~gdt_table arch/i386/kernel/smpboot.c
--- linux-2.6.16/arch/i386/kernel/smpboot.c~gdt_table	2006-03-22 12:01:41.000000000 +0800
+++ linux-2.6.16-root/arch/i386/kernel/smpboot.c	2006-03-22 12:18:28.000000000 +0800
@@ -1027,6 +1027,7 @@ int __devinit smp_prepare_cpu(int cpu)
 	struct warm_boot_cpu_info info;
 	struct work_struct task;
 	int	apicid, ret;
+	struct Xgt_desc_struct *cpu_gdt_descr = &per_cpu(cpu_gdt_descr, cpu);
 
 	lock_cpu_hotplug();
 
@@ -1045,6 +1046,18 @@ int __devinit smp_prepare_cpu(int cpu)
 		goto exit;
 	}
 
+	/*
+	 * the CPU isn't initialized at boot time, allocate gdt table here.
+	 * cpu_init will initialize it
+	 */
+	if (!cpu_gdt_descr->address) {
+		cpu_gdt_descr->address = get_zeroed_page(GFP_KERNEL);
+		if (!cpu_gdt_descr->address)
+			printk(KERN_CRIT "CPU%d failed to allocate GDT\n", cpu);
+			ret = -ENOMEM;
+			goto exit;
+	}
+
 	info.complete = &done;
 	info.apicid = apicid;
 	info.cpu = cpu;
_



