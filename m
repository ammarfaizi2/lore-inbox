Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751287AbWGJHyJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751287AbWGJHyJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 03:54:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751298AbWGJHyJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 03:54:09 -0400
Received: from ns.oss.ntt.co.jp ([222.151.198.98]:62441 "EHLO
	serv1.oss.ntt.co.jp") by vger.kernel.org with ESMTP
	id S1751287AbWGJHyI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 03:54:08 -0400
Subject: [PATCH 3/3] stack overflow safe kdump (2.6.18-rc1-i386) -
	ipi_use_safe_smp_processor_id
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
Date: Mon, 10 Jul 2006 16:54:01 +0900
Message-Id: <1152518041.2120.112.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Substitute "smp_processor_id" with the stack overflow-safe
"safe_smp_processor_id" in the send IPI functions, since
they are used after a crash to shutdown CPUs.

Signed-off-by: Fernando Vazquez <fernando@intellilink.co.jp>
---

diff -urNp linux-2.6.18-rc1/include/asm-i386/mach-bigsmp/mach_ipi.h linux-2.6.18-rc1-sof/include/asm-i386/mach-bigsmp/mach_ipi.h
--- linux-2.6.18-rc1/include/asm-i386/mach-bigsmp/mach_ipi.h	2006-06-18 10:49:35.000000000 +0900
+++ linux-2.6.18-rc1-sof/include/asm-i386/mach-bigsmp/mach_ipi.h	2006-07-10 16:13:33.000000000 +0900
@@ -11,7 +11,7 @@ static inline void send_IPI_mask(cpumask
 static inline void send_IPI_allbutself(int vector)
 {
 	cpumask_t mask = cpu_online_map;
-	cpu_clear(smp_processor_id(), mask);
+	cpu_clear(safe_smp_processor_id(), mask);
 
 	if (!cpus_empty(mask))
 		send_IPI_mask(mask, vector);
diff -urNp linux-2.6.18-rc1/include/asm-i386/mach-default/mach_ipi.h linux-2.6.18-rc1-sof/include/asm-i386/mach-default/mach_ipi.h
--- linux-2.6.18-rc1/include/asm-i386/mach-default/mach_ipi.h	2006-07-10 11:00:05.000000000 +0900
+++ linux-2.6.18-rc1-sof/include/asm-i386/mach-default/mach_ipi.h	2006-07-10 16:14:15.000000000 +0900
@@ -19,7 +19,7 @@ static inline void __local_send_IPI_allb
 	if (no_broadcast || vector == NMI_VECTOR) {
 		cpumask_t mask = cpu_online_map;
 
-		cpu_clear(smp_processor_id(), mask);
+		cpu_clear(safe_smp_processor_id(), mask);
 		send_IPI_mask(mask, vector);
 	} else
 		__send_IPI_shortcut(APIC_DEST_ALLBUT, vector);
diff -urNp linux-2.6.18-rc1/include/asm-i386/mach-es7000/mach_ipi.h linux-2.6.18-rc1-sof/include/asm-i386/mach-es7000/mach_ipi.h
--- linux-2.6.18-rc1/include/asm-i386/mach-es7000/mach_ipi.h	2006-06-18 10:49:35.000000000 +0900
+++ linux-2.6.18-rc1-sof/include/asm-i386/mach-es7000/mach_ipi.h	2006-07-10 16:14:51.000000000 +0900
@@ -11,7 +11,7 @@ static inline void send_IPI_mask(cpumask
 static inline void send_IPI_allbutself(int vector)
 {
 	cpumask_t mask = cpu_online_map;
-	cpu_clear(smp_processor_id(), mask);
+	cpu_clear(safe_smp_processor_id(), mask);
 	if (!cpus_empty(mask))
 		send_IPI_mask(mask, vector);
 }
diff -urNp linux-2.6.18-rc1/include/asm-i386/mach-numaq/mach_ipi.h linux-2.6.18-rc1-sof/include/asm-i386/mach-numaq/mach_ipi.h
--- linux-2.6.18-rc1/include/asm-i386/mach-numaq/mach_ipi.h	2006-06-18 10:49:35.000000000 +0900
+++ linux-2.6.18-rc1-sof/include/asm-i386/mach-numaq/mach_ipi.h	2006-07-10 16:15:26.000000000 +0900
@@ -11,7 +11,7 @@ static inline void send_IPI_mask(cpumask
 static inline void send_IPI_allbutself(int vector)
 {
 	cpumask_t mask = cpu_online_map;
-	cpu_clear(smp_processor_id(), mask);
+	cpu_clear(safe_smp_processor_id(), mask);
 
 	if (!cpus_empty(mask))
 		send_IPI_mask(mask, vector);
diff -urNp linux-2.6.18-rc1/include/asm-i386/mach-summit/mach_ipi.h linux-2.6.18-rc1-sof/include/asm-i386/mach-summit/mach_ipi.h
--- linux-2.6.18-rc1/include/asm-i386/mach-summit/mach_ipi.h	2006-06-18 10:49:35.000000000 +0900
+++ linux-2.6.18-rc1-sof/include/asm-i386/mach-summit/mach_ipi.h	2006-07-10 16:16:06.000000000 +0900
@@ -11,7 +11,7 @@ static inline void send_IPI_mask(cpumask
 static inline void send_IPI_allbutself(int vector)
 {
 	cpumask_t mask = cpu_online_map;
-	cpu_clear(smp_processor_id(), mask);
+	cpu_clear(safe_smp_processor_id(), mask);
 
 	if (!cpus_empty(mask))
 		send_IPI_mask(mask, vector);


