Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965157AbWGKGFX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965157AbWGKGFX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 02:05:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965151AbWGKGFX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 02:05:23 -0400
Received: from ns.oss.ntt.co.jp ([222.151.198.98]:49797 "EHLO
	serv1.oss.ntt.co.jp") by vger.kernel.org with ESMTP id S965163AbWGKGFV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 02:05:21 -0400
Subject: [PATCH 1/4] stack overflow safe kdump (2.6.18-rc1-i386) -
	safe_smp_processor_id
From: Fernando Luis =?ISO-8859-1?Q?V=E1zquez?= Cao 
	<fernando@oss.ntt.co.jp>
To: vgoyal@in.ibm.com
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, akpm@osdl.org, ak@suse.de,
       James.Bottomley@steeleye.com, linux-kernel@vger.kernel.org,
       fastboot@lists.osdl.org
Content-Type: text/plain
Organization: =?UTF-8?Q?NTT=E3=82=AA=E3=83=BC=E3=83=97=E3=83=B3=E3=82=BD=E3=83=BC?=
	=?UTF-8?Q?=E3=82=B9=E3=82=BD=E3=83=95=E3=83=88=E3=82=A6=E3=82=A7?=
	=?UTF-8?Q?=E3=82=A2=E3=82=BB=E3=83=B3=E3=82=BF?=
Date: Tue, 11 Jul 2006 15:05:18 +0900
Message-Id: <1152597918.2414.54.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
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

Signed-off-by: Fernando Vazquez <fernando@intellilink.co.jp>
---

diff -urNp linux-2.6.18-rc1/arch/i386/kernel/smp.c linux-2.6.18-rc1-sof/arch/i386/kernel/smp.c
--- linux-2.6.18-rc1/arch/i386/kernel/smp.c	2006-07-11 10:11:38.000000000 +0900
+++ linux-2.6.18-rc1-sof/arch/i386/kernel/smp.c	2006-07-11 14:05:28.000000000 +0900
@@ -634,3 +634,29 @@ fastcall void smp_call_function_interrup
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
+int safe_smp_processor_id(void)
+{
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
diff -urNp linux-2.6.18-rc1/include/asm-i386/smp.h linux-2.6.18-rc1-sof/include/asm-i386/smp.h
--- linux-2.6.18-rc1/include/asm-i386/smp.h	2006-07-11 10:11:44.000000000 +0900
+++ linux-2.6.18-rc1-sof/include/asm-i386/smp.h	2006-07-11 14:05:28.000000000 +0900
@@ -89,12 +89,14 @@ static __inline int logical_smp_processo
 
 #endif
 
+extern int safe_smp_processor_id(void);
 extern int __cpu_disable(void);
 extern void __cpu_die(unsigned int cpu);
 #endif /* !__ASSEMBLY__ */
 
 #else /* CONFIG_SMP */
 
+#define safe_smp_processor_id()		0
 #define cpu_physical_id(cpu)		boot_cpu_physical_apicid
 
 #define NO_PROC_ID		0xFF		/* No processor magic marker */


