Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265852AbSKBA35>; Fri, 1 Nov 2002 19:29:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265854AbSKBA35>; Fri, 1 Nov 2002 19:29:57 -0500
Received: from fmr02.intel.com ([192.55.52.25]:22778 "EHLO
	caduceus.fm.intel.com") by vger.kernel.org with ESMTP
	id <S265852AbSKBA3l>; Fri, 1 Nov 2002 19:29:41 -0500
Message-ID: <10C8636AE359D4119118009027AE99871E606C49@fmsmsx34.fm.intel.com>
From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
To: "'Dave Jones'" <davej@codemonkey.org.uk>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "Nakajima, Jun" <jun.nakajima@intel.com>,
       "Mallick, Asit K" <asit.k.mallick@intel.com>
Subject: [PATCH] 2.5.44-ac5  - i386 MCA update
Date: Fri, 1 Nov 2002 16:35:50 -0800 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave,
Attached is the patch against 2.5.44-ac5.
Thanks,
-Venkatesh
 > Hi,
 >
 >    Attached is the patch with few i386 MCA updates. Summary of changes:
 > - Logging of corrected (non critical) MCA errors on P4.
 > - Don't clear the MCA status info. in case of a non-recoverable error. If
OS
 > has failed in logging those,
 >   BIOS can still have a look at that info.
 > - Minor bug fix in do_mce_timer(). Check current cpu registers too, while
 > calling smp_call_function().

I've a lot of pending patches to bluesmoke (splitting it all up
into per-vendor files). This patch will make that a real PITA to
rework. Can you take a look at the work in 2.5-ac and diff against
that instead ?

                Dave

--- linux-2.5.44-ac/arch/i386/kernel/cpu/mcheck/p4.c.org	2002-11-01
15:57:09.000000000 -0800
+++ linux-2.5.44-ac/arch/i386/kernel/cpu/mcheck/p4.c	2002-11-01
19:45:34.000000000 -0800
@@ -5,8 +5,10 @@
 #include <linux/init.h>
 #include <linux/types.h>
 #include <linux/kernel.h>
+#include <linux/jiffies.h>
 #include <linux/config.h>
 #include <linux/irq.h>
+#include <linux/workqueue.h>
 #include <linux/interrupt.h>
 #include <linux/smp.h>
 
@@ -190,10 +192,6 @@
 				printk(" at %08x%08x", ahigh, alow);
 			}
 			printk("\n");
-			/* Clear it */
-			wrmsr(MSR_IA32_MC0_STATUS+i*4, 0UL, 0UL);
-			/* Serialize */
-			wmb();
 		}
 	}
 
@@ -201,11 +199,78 @@
 		panic("CPU context corrupt");
 	if(recover&1)
 		panic("Unable to continue");
+
 	printk(KERN_EMERG "Attempting to continue.\n");
+	/* 
+	 * Do not clear the MSR_IA32_MCi_STATUS if the error is not 
+	 * recoverable/continuable.This will allow BIOS to look at the MSRs
+	 * for errors if the OS could not log the error.
+	 */
+	for (i=0;i<banks;i++) {
+		unsigned int msr;
+		msr = MSR_IA32_MC0_STATUS+i*4;
+		rdmsr(msr,low, high);
+		if(high&(1<<31)) {
+			/* Clear it */
+			wrmsr(msr, 0UL, 0UL);
+			/* Serialize */
+			wmb();
+		}
+	}
 	mcgstl&=~(1<<2);
 	wrmsr(MSR_IA32_MCG_STATUS,mcgstl, mcgsth);
 }
 
+#ifdef CONFIG_X86_MCE_NONFATAL
+static struct timer_list mce_timer;
+static int timerset = 0;
+
+#define MCE_RATE	15*HZ	/* timer rate is 15s */
+
+static void mce_checkregs (void *info)
+{
+	u32 low, high;
+	int i;
+
+	preempt_disable(); 
+	for (i=0; i<banks; i++) {
+		rdmsr(MSR_IA32_MC0_STATUS+i*4, low, high);
+
+		if (high&(1<<31)) {
+			printk (KERN_EMERG "MCE: The hardware reports a non
fatal, correctable incident occured on CPU %d.\n", smp_processor_id());
+			printk (KERN_EMERG "Bank %d: %08x%08x\n", i, high,
low);
+
+			/* Scrub the error so we don't pick it up in
MCE_RATE seconds time. */
+			wrmsr(MSR_IA32_MC0_STATUS+i*4, 0UL, 0UL);
+
+			/* Serialize */
+			wmb();
+		}
+	}
+	preempt_enable();
+}
+
+static void do_mce_timer(void *data)
+{ 
+	mce_checkregs(NULL);
+	smp_call_function (mce_checkregs, NULL, 1, 1);
+} 
+
+static DECLARE_WORK(mce_work, do_mce_timer, NULL);
+
+static void mce_timerfunc (unsigned long data)
+{
+#ifdef CONFIG_SMP
+	if (num_online_cpus() > 1) 
+		schedule_work(&mce_work); 
+#else
+	mce_checkregs(NULL);
+#endif	/* SMP */
+	mce_timer.expires = jiffies + MCE_RATE;
+	add_timer (&mce_timer);
+}	
+#endif	/* NON_FATAL */
+
 void __init intel_p4_mcheck_init(struct cpuinfo_x86 *c)
 {
 	u32 l, h;
@@ -241,4 +306,17 @@
 		intel_init_thermal(c);
 #endif
 	}
+#ifdef CONFIG_X86_MCE_NONFATAL
+	if (timerset == 0) {
+		/* Set the timer to check for non-fatal
+		   errors every MCE_RATE seconds */
+		init_timer (&mce_timer);
+		mce_timer.expires = jiffies + MCE_RATE;
+		mce_timer.data = 0;
+		mce_timer.function = &mce_timerfunc;
+		add_timer (&mce_timer);
+		timerset = 1;
+		printk(KERN_INFO "Machine check exception polling timer
started.\n");
+	}
+#endif
 }
--- linux-2.5.44-ac/arch/i386/kernel/cpu/mcheck/p6.c.org	2002-11-01
15:57:28.000000000 -0800
+++ linux-2.5.44-ac/arch/i386/kernel/cpu/mcheck/p6.c	2002-11-01
19:24:07.000000000 -0800
@@ -49,10 +49,6 @@
 				printk(" at %08x%08x", ahigh, alow);
 			}
 			printk("\n");
-			/* Clear it */
-			wrmsr(MSR_IA32_MC0_STATUS+i*4, 0UL, 0UL);
-			/* Serialize */
-			wmb();
 		}
 	}
 
@@ -60,7 +56,24 @@
 		panic("CPU context corrupt");
 	if(recover&1)
 		panic("Unable to continue");
+
 	printk(KERN_EMERG "Attempting to continue.\n");
+	/* 
+	 * Do not clear the MSR_IA32_MCi_STATUS if the error is not 
+	 * recoverable/continuable.This will allow BIOS to look at the MSRs
+	 * for errors if the OS could not log the error.
+	 */
+	for (i=0;i<banks;i++) {
+		unsigned int msr;
+		msr = MSR_IA32_MC0_STATUS+i*4;
+		rdmsr(msr,low, high);
+		if(high&(1<<31)) {
+			/* Clear it */
+			wrmsr(msr, 0UL, 0UL);
+			/* Serialize */
+			wmb();
+		}
+	}
 	mcgstl&=~(1<<2);
 	wrmsr(MSR_IA32_MCG_STATUS,mcgstl, mcgsth);
 }
--- linux-2.5.44-ac/arch/i386/config.in.org	2002-11-01
19:06:54.000000000 -0800
+++ linux-2.5.44-ac/arch/i386/config.in	2002-11-01 18:38:49.000000000 -0800
@@ -212,7 +212,7 @@
 fi
 
 bool 'Machine Check Exception' CONFIG_X86_MCE
-dep_bool '  Check for non-fatal errors on Athlon/Duron'
CONFIG_X86_MCE_NONFATAL $CONFIG_X86_MCE
+dep_bool '  Check for non-fatal errors on Athlon/Duron/Pentium-4'
CONFIG_X86_MCE_NONFATAL $CONFIG_X86_MCE
 if [ "$CONFIG_SMP" = "y" ]; then
     dep_bool '  Check for P4 thermal throttling interrupt.'
CONFIG_X86_MCE_P4THERMAL $CONFIG_X86_MCE
 else


 
