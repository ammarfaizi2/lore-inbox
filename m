Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030275AbVH0C1Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030275AbVH0C1Y (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Aug 2005 22:27:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030276AbVH0C1Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Aug 2005 22:27:24 -0400
Received: from fmr13.intel.com ([192.55.52.67]:4483 "EHLO
	fmsfmr001.fm.intel.com") by vger.kernel.org with ESMTP
	id S1030275AbVH0C1X convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Aug 2005 22:27:23 -0400
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Subject: RE: [PATCH] acpi-cpufreq: Remove P-state read after a P-state write in normal path
Date: Fri, 26 Aug 2005 22:27:13 -0400
Message-ID: <F7DC2337C7631D4386A2DF6E8FB22B30047241D6@hdsmsx401.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] acpi-cpufreq: Remove P-state read after a P-state write in normal path
Thread-Index: AcWqm8qp5wshCcgmSbyDuTVuzAVP+gAEwEdg
From: "Brown, Len" <len.brown@intel.com>
To: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
       "Andrew Morton" <akpm@osdl.org>
Cc: "linux-kernel" <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 27 Aug 2005 02:27:16.0209 (UTC) FILETIME=[D73D7E10:01C5AAAE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

applied to acpi test tree.

thanks,
-Len 

>-----Original Message-----
>From: Venkatesh Pallipadi [mailto:venkatesh.pallipadi@intel.com] 
>Sent: Friday, August 26, 2005 8:11 PM
>To: Andrew Morton
>Cc: linux-kernel; Brown, Len
>Subject: [PATCH] acpi-cpufreq: Remove P-state read after a 
>P-state write in normal path
>
>
>
>Remove P-state read status after a P-state write in normal case. As 
>that operation is expensive. There are no known failures of a 
>set and we can 
>assume success in the common case. acpi_pstate_strict 
>parameter can be used 
>to force it back on any systems that is known to have errors.
>
>Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
>
>Index: linux-2.6.12/arch/i386/kernel/cpu/cpufreq/acpi-cpufreq.c
>===================================================================
>--- 
>linux-2.6.12.orig/arch/i386/kernel/cpu/cpufreq/acpi-cpufreq.c	
>2005-08-16 09:41:52.977456128 -0700
>+++ linux-2.6.12/arch/i386/kernel/cpu/cpufreq/acpi-cpufreq.c	
>2005-08-17 13:32:33.034651136 -0700
>@@ -31,6 +31,7 @@
> #include <linux/cpufreq.h>
> #include <linux/proc_fs.h>
> #include <linux/seq_file.h>
>+#include <linux/compiler.h>
> #include <asm/io.h>
> #include <asm/delay.h>
> #include <asm/uaccess.h>
>@@ -57,6 +58,8 @@
> 
> static struct cpufreq_driver acpi_cpufreq_driver;
> 
>+static unsigned int acpi_pstate_strict;
>+
> static int
> acpi_processor_write_port(
> 	u16	port,
>@@ -163,34 +166,44 @@
> 	}
> 
> 	/*
>-	 * Then we read the 'status_register' and compare the 
>value with the
>-	 * target state's 'status' to make sure the transition 
>was successful.
>-	 * Note that we'll poll for up to 1ms (100 cycles of 
>10us) before
>-	 * giving up.
>+	 * Assume the write went through when 
>acpi_pstate_strict is not used.
>+	 * As read status_register is an expensive operation and there 
>+	 * are no specific error cases where an IO port write will fail.
> 	 */
>-
>-	port = data->acpi_data.status_register.address;
>-	bit_width = data->acpi_data.status_register.bit_width;
>-
>-	dprintk("Looking for 0x%08x from port 0x%04x\n",
>-		(u32) data->acpi_data.states[state].status, port);
>-
>-	for (i=0; i<100; i++) {
>-		ret = acpi_processor_read_port(port, bit_width, &value);
>-		if (ret) {	
>-			dprintk("Invalid port width 0x%04x\n", 
>bit_width);
>-			retval = ret;
>-			goto migrate_end;
>+	if (acpi_pstate_strict) {
>+		/* Then we read the 'status_register' and 
>compare the value 
>+		 * with the target state's 'status' to make sure the 
>+		 * transition was successful.
>+		 * Note that we'll poll for up to 1ms (100 
>cycles of 10us) 
>+		 * before giving up.
>+		 */
>+
>+		port = data->acpi_data.status_register.address;
>+		bit_width = data->acpi_data.status_register.bit_width;
>+
>+		dprintk("Looking for 0x%08x from port 0x%04x\n",
>+			(u32) 
>data->acpi_data.states[state].status, port);
>+
>+		for (i=0; i<100; i++) {
>+			ret = acpi_processor_read_port(port, 
>bit_width, &value);
>+			if (ret) {	
>+				dprintk("Invalid port width 
>0x%04x\n", bit_width);
>+				retval = ret;
>+				goto migrate_end;
>+			}
>+			if (value == (u32) 
>data->acpi_data.states[state].status)
>+				break;
>+			udelay(10);
> 		}
>-		if (value == (u32) data->acpi_data.states[state].status)
>-			break;
>-		udelay(10);
>+	} else {
>+		i = 0;
>+		value = (u32) data->acpi_data.states[state].status;
> 	}
> 
> 	/* notify cpufreq */
> 	cpufreq_notify_transition(&cpufreq_freqs, CPUFREQ_POSTCHANGE);
> 
>-	if (value != (u32) data->acpi_data.states[state].status) {
>+	if (unlikely(value != (u32) 
>data->acpi_data.states[state].status)) {
> 		unsigned int tmp = cpufreq_freqs.new;
> 		cpufreq_freqs.new = cpufreq_freqs.old;
> 		cpufreq_freqs.old = tmp;
>@@ -537,6 +550,8 @@
> 	return;
> }
> 
>+module_param(acpi_pstate_strict, uint, 0644);
>+MODULE_PARM_DESC(acpi_pstate_strict, "value 0 or non-zero. 
>non-zero -> strict ACPI checks are performed during frequency 
>changes.");
> 
> late_initcall(acpi_cpufreq_init);
> module_exit(acpi_cpufreq_exit);
>
