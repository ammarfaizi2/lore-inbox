Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751180AbWJMKTy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751180AbWJMKTy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 06:19:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751183AbWJMKTy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 06:19:54 -0400
Received: from ausmtp04.au.ibm.com ([202.81.18.152]:39079 "EHLO
	ausmtp04.au.ibm.com") by vger.kernel.org with ESMTP
	id S1751180AbWJMKTy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 06:19:54 -0400
Message-ID: <452F6838.6090605@in.ibm.com>
Date: Fri, 13 Oct 2006 15:49:36 +0530
From: Srinivasa Ds <srinivasa@in.ibm.com>
Organization: IBM
User-Agent: Thunderbird 1.5.0.7 (X11/20060911)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, akpm@osdl.org, torvalds@osdl.org
Subject: [PATCH] 2.6.19-rc1: Fix build breakage with CONFIG_PPC32
Content-Type: multipart/mixed;
 boundary="------------030207050103020005060301"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030207050103020005060301
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Linus
2.6.19-rc1 gives below error while compiling with CONFIG_PPC32.
 ===================================================================

 LD      fs/built-in.o
 GEN     .version
 CHK     include/linux/compile.h
 UPD     include/linux/compile.h
 CC      init/version.o
 LD      init/built-in.o
 LD      .tmp_vmlinux1
arch/powerpc/platforms/built-in.o: In function `flush_disable_caches':
(.text+0x96d4): undefined reference to `low_cpu_die'
======================================================
low_cpu_die() is defined under  CONFIG_PM || CONFIG_CPU_FREQ_PMAC  
options ,but while calling this function ,no care has been to taken to 
check these options. So please apply this fix,which solves the problem.

Signed-off-by: Srinivasa DS <srinivasa@in.ibm.com>





 



--------------030207050103020005060301
Content-Type: text/plain;
 name="low_cpu_die.fix"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="low_cpu_die.fix"

---
 arch/powerpc/platforms/powermac/smp.c |    7 +++++++
 1 file changed, 7 insertions(+)

Index: linux-2.6.19-rc1/arch/powerpc/platforms/powermac/smp.c
===================================================================
--- linux-2.6.19-rc1.orig/arch/powerpc/platforms/powermac/smp.c
+++ linux-2.6.19-rc1/arch/powerpc/platforms/powermac/smp.c
@@ -867,7 +867,14 @@ int smp_core99_cpu_disable(void)
 	return 0;
 }
 
+#if defined(CONFIG_PM) || defined(CONFIG_CPU_FREQ_PMAC)
 extern void low_cpu_die(void) __attribute__((noreturn)); /* in sleep.S */
+#else
+void low_cpu_die(void)
+{
+}
+#endif
+
 static int cpu_dead[NR_CPUS];
 
 void cpu_die(void)

--------------030207050103020005060301--
