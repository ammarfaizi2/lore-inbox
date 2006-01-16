Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750743AbWAPNXx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750743AbWAPNXx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 08:23:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750749AbWAPNXx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 08:23:53 -0500
Received: from ns.intellilink.co.jp ([61.115.5.249]:1220 "EHLO
	mail.intellilink.co.jp") by vger.kernel.org with ESMTP
	id S1750743AbWAPNXw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 08:23:52 -0500
Subject: [PATCH 1/5] stack overflow safe kdump (2.6.15-i386) -
	safe_smp_processor_id
From: Fernando Luis Vazquez Cao <fernando@intellilink.co.jp>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: ak@suse.de, vgoyal@in.ibm.com, linux-kernel@vger.kernel.org,
       fastboot@lists.osdl.org
Content-Type: text/plain
Organization: =?UTF-8?Q?NTT=E3=83=87=E3=83=BC=E3=82=BF=E5=85=88=E7=AB=AF=E6=8A=80?=
	=?UTF-8?Q?=E8=A1=93=E6=A0=AA=E5=BC=8F=E4=BC=9A=E7=A4=BE?=
Date: Mon, 16 Jan 2006 22:23:44 +0900
Message-Id: <1137417824.2256.85.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On the event of a stack overflow critical data that usually resides at
the bottom of the stack is likely to be stomped and, consequently, its
use should be avoided.

In particular, in the i386 and IA64 architectures the macro
smp_processor_id ultimately makes use of the "cpu" member of struct
thread_info which resides at the bottom of the stack. x86_64, on the
other hand, is not affected by this problem because it benefits from
the use of the PDA infrastructure.

To circumvent this problem I suggest implementing
"safe_smp_processor_id()" (it already exists in x86_64) for i386 and
IA64 and use it as a replacement for smp_processor_id in the reboot path
to the dump capture kernel. This is a possible implementation for i386.

---
diff -urNp linux-2.6.15/arch/i386/kernel/smp.c
linux-2.6.15-sov/arch/i386/kernel/smp.c
--- linux-2.6.15/arch/i386/kernel/smp.c	2006-01-03 12:21:10.000000000
+0900
+++ linux-2.6.15-sov/arch/i386/kernel/smp.c	2006-01-16
20:25:50.000000000 +0900
@@ -628,3 +628,28 @@ fastcall void smp_call_function_interrup
 	}
 }
 
+static int convert_apicid_to_cpu(int apic_id)
+{
+	int i;
+
+	for (i = 0; i < NR_CPUS; i++) {
+		if (x86_cpu_to_apicid[i] == apic_id)
+		return i;
+	}
+	return -1;
+}
+
+int safe_smp_processor_id(void) {
+	int apicid, cpuid;
+
+	if (!boot_cpu_has(X86_FEATURE_APIC))
+		return 0;
+
+	apicid = hard_smp_processor_id();
+	if (apicid == BAD_APICID)
+		return 0;
+
+	cpuid = convert_apicid_to_cpu(apicid);
+
+	return cpuid >= 0 ? cpuid : 0;
+}
diff -urNp linux-2.6.15/include/asm-i386/smp.h
linux-2.6.15-sov/include/asm-i386/smp.h
--- linux-2.6.15/include/asm-i386/smp.h	2006-01-03 12:21:10.000000000
+0900
+++ linux-2.6.15-sov/include/asm-i386/smp.h	2006-01-16
20:25:50.000000000 +0900
@@ -90,12 +90,14 @@ static __inline int logical_smp_processo
 
 #endif
 
+extern int safe_smp_processor_id(void);
 extern int __cpu_disable(void);
 extern void __cpu_die(unsigned int cpu);
 #endif /* !__ASSEMBLY__ */
 
 #else /* CONFIG_SMP */
 
+#define safe_smp_processor_id() 0
 #define cpu_physical_id(cpu)		boot_cpu_physical_apicid
 
 #define NO_PROC_ID		0xFF		/* No processor magic marker */


