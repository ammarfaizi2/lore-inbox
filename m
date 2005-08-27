Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030267AbVH0ALA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030267AbVH0ALA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Aug 2005 20:11:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030268AbVH0ALA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Aug 2005 20:11:00 -0400
Received: from fmr23.intel.com ([143.183.121.15]:18667 "EHLO
	scsfmr003.sc.intel.com") by vger.kernel.org with ESMTP
	id S1030267AbVH0AK7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Aug 2005 20:10:59 -0400
Date: Fri, 26 Aug 2005 17:10:52 -0700
From: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Len Brown <len.brown@intel.com>
Subject: [PATCH] acpi-cpufreq: Remove P-state read after a P-state write in normal path
Message-ID: <20050826171052.B27226@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Remove P-state read status after a P-state write in normal case. As 
that operation is expensive. There are no known failures of a set and we can 
assume success in the common case. acpi_pstate_strict parameter can be used 
to force it back on any systems that is known to have errors.

Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>

Index: linux-2.6.12/arch/i386/kernel/cpu/cpufreq/acpi-cpufreq.c
===================================================================
--- linux-2.6.12.orig/arch/i386/kernel/cpu/cpufreq/acpi-cpufreq.c	2005-08-16 09:41:52.977456128 -0700
+++ linux-2.6.12/arch/i386/kernel/cpu/cpufreq/acpi-cpufreq.c	2005-08-17 13:32:33.034651136 -0700
@@ -31,6 +31,7 @@
 #include <linux/cpufreq.h>
 #include <linux/proc_fs.h>
 #include <linux/seq_file.h>
+#include <linux/compiler.h>
 #include <asm/io.h>
 #include <asm/delay.h>
 #include <asm/uaccess.h>
@@ -57,6 +58,8 @@
 
 static struct cpufreq_driver acpi_cpufreq_driver;
 
+static unsigned int acpi_pstate_strict;
+
 static int
 acpi_processor_write_port(
 	u16	port,
@@ -163,34 +166,44 @@
 	}
 
 	/*
-	 * Then we read the 'status_register' and compare the value with the
-	 * target state's 'status' to make sure the transition was successful.
-	 * Note that we'll poll for up to 1ms (100 cycles of 10us) before
-	 * giving up.
+	 * Assume the write went through when acpi_pstate_strict is not used.
+	 * As read status_register is an expensive operation and there 
+	 * are no specific error cases where an IO port write will fail.
 	 */
-
-	port = data->acpi_data.status_register.address;
-	bit_width = data->acpi_data.status_register.bit_width;
-
-	dprintk("Looking for 0x%08x from port 0x%04x\n",
-		(u32) data->acpi_data.states[state].status, port);
-
-	for (i=0; i<100; i++) {
-		ret = acpi_processor_read_port(port, bit_width, &value);
-		if (ret) {	
-			dprintk("Invalid port width 0x%04x\n", bit_width);
-			retval = ret;
-			goto migrate_end;
+	if (acpi_pstate_strict) {
+		/* Then we read the 'status_register' and compare the value 
+		 * with the target state's 'status' to make sure the 
+		 * transition was successful.
+		 * Note that we'll poll for up to 1ms (100 cycles of 10us) 
+		 * before giving up.
+		 */
+
+		port = data->acpi_data.status_register.address;
+		bit_width = data->acpi_data.status_register.bit_width;
+
+		dprintk("Looking for 0x%08x from port 0x%04x\n",
+			(u32) data->acpi_data.states[state].status, port);
+
+		for (i=0; i<100; i++) {
+			ret = acpi_processor_read_port(port, bit_width, &value);
+			if (ret) {	
+				dprintk("Invalid port width 0x%04x\n", bit_width);
+				retval = ret;
+				goto migrate_end;
+			}
+			if (value == (u32) data->acpi_data.states[state].status)
+				break;
+			udelay(10);
 		}
-		if (value == (u32) data->acpi_data.states[state].status)
-			break;
-		udelay(10);
+	} else {
+		i = 0;
+		value = (u32) data->acpi_data.states[state].status;
 	}
 
 	/* notify cpufreq */
 	cpufreq_notify_transition(&cpufreq_freqs, CPUFREQ_POSTCHANGE);
 
-	if (value != (u32) data->acpi_data.states[state].status) {
+	if (unlikely(value != (u32) data->acpi_data.states[state].status)) {
 		unsigned int tmp = cpufreq_freqs.new;
 		cpufreq_freqs.new = cpufreq_freqs.old;
 		cpufreq_freqs.old = tmp;
@@ -537,6 +550,8 @@
 	return;
 }
 
+module_param(acpi_pstate_strict, uint, 0644);
+MODULE_PARM_DESC(acpi_pstate_strict, "value 0 or non-zero. non-zero -> strict ACPI checks are performed during frequency changes.");
 
 late_initcall(acpi_cpufreq_init);
 module_exit(acpi_cpufreq_exit);
