Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265705AbSKAS4p>; Fri, 1 Nov 2002 13:56:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265706AbSKAS4p>; Fri, 1 Nov 2002 13:56:45 -0500
Received: from fmr02.intel.com ([192.55.52.25]:17346 "EHLO
	caduceus.fm.intel.com") by vger.kernel.org with ESMTP
	id <S265705AbSKAS4m>; Fri, 1 Nov 2002 13:56:42 -0500
Message-ID: <10C8636AE359D4119118009027AE99871E606C42@fmsmsx34.fm.intel.com>
From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
To: "'torvalds@transmeta.com'" <torvalds@transmeta.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "Nakajima, Jun" <jun.nakajima@intel.com>,
       "Mallick, Asit K" <asit.k.mallick@intel.com>
Subject: [PATCH] 2.5.45 - i386 MCA update
Date: Fri, 1 Nov 2002 11:02:55 -0800 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

   Attached is the patch with few i386 MCA updates. Summary of changes:
- Logging of corrected (non critical) MCA errors on P4.
- Don't clear the MCA status info. in case of a non-recoverable error. If OS
has failed in logging those, 
  BIOS can still have a look at that info.
- Minor bug fix in do_mce_timer(). Check current cpu registers too, while
calling smp_call_function().

Thanks,
-Venkatesh

--- linux-2.5.45/arch/i386/kernel/bluesmoke.c.org	Tue Oct 29 14:16:48
2002
+++ linux-2.5.45/arch/i386/kernel/bluesmoke.c	Tue Oct 29 14:48:50 2002
@@ -209,10 +209,6 @@
 				printk(" at %08x%08x", ahigh, alow);
 			}
 			printk("\n");
-			/* Clear it */
-			wrmsr(MSR_IA32_MC0_STATUS+i*4, 0UL, 0UL);
-			/* Serialize */
-			wmb();
 		}
 	}
 
@@ -220,7 +216,24 @@
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
@@ -300,6 +313,7 @@
 
 static void do_mce_timer(void *data)
 { 
+	mce_checkregs(NULL);
 	smp_call_function (mce_checkregs, NULL, 1, 1);
 } 
 
@@ -471,6 +485,20 @@
 
 		case X86_VENDOR_INTEL:
 			intel_mcheck_init(c);
+#ifdef CONFIG_X86_MCE_NONFATAL
+#define CPU_PENTIUM4 15
+			if (c->x86 == CPU_PENTIUM4 && timerset == 0) {
+				/* Set the timer to check for non-fatal
+				   errors every MCE_RATE seconds */
+				init_timer (&mce_timer);
+				mce_timer.expires = jiffies + MCE_RATE;
+				mce_timer.data = 0;
+				mce_timer.function = &mce_timerfunc;
+				add_timer (&mce_timer);
+				timerset = 1;
+				printk(KERN_INFO "Machine check exception
polling timer started.\n");
+			}
+#endif
 			break;
 
 		case X86_VENDOR_CENTAUR:
--- linux-2.5.45/arch/i386/Kconfig.org	Thu Oct 31 14:25:19 2002
+++ linux-2.5.45/arch/i386/Kconfig	Thu Oct 31 14:25:48 2002
@@ -439,7 +439,7 @@
 	  the 386 and 486, so nearly everyone can say Y here.
 
 config X86_MCE_NONFATAL
-	bool "Check for non-fatal errors on Athlon/Duron"
+	bool "Check for non-fatal errors on Athlon/Duron/Pentium-4"
 	depends on X86_MCE
 	help
 	  Enabling this feature starts a timer that triggers every 5 seconds
which


