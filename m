Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262252AbUKKO6q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262252AbUKKO6q (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Nov 2004 09:58:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262248AbUKKO6p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Nov 2004 09:58:45 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:1997 "EHLO e33.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S262245AbUKKO6I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Nov 2004 09:58:08 -0500
Message-ID: <41937DFB.8030700@vnet.ibm.com>
Date: Thu, 11 Nov 2004 08:58:03 -0600
From: Jeff Scheel <scheel@vnet.ibm.com>
User-Agent: Mozilla Thunderbird 0.9 (Windows/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: akpm@osdl.org
CC: sfr@canb.auug.org.au, paulus@samba.org, linux-kernel@vger.kernel.org,
       linuxppc64-dev@ozlabs.org
Subject: [PATCH] iSeries legacy model emulation of PURR
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

Here's a patch to extend the current Linux on Power support for PURR to 
legacy IBM iSeries servers (pre-Power5 processor models).  This patch 
enables the reporting of timebase metrics to reflect physical processor 
utilization in a system running multiple logical partitions which share 
the same physical processors.

The patch simply uses existing user interfaces for Linux IBM Power5 
based servers to report data already collected by the hypervisor.  The 
values reported with each call are running values in units of the system 
timebase.  The calculation of physical processor utilization results 
from two samples (purr1 and purr2) differing by a know interval (time) 
such that:
    physical utilization = (purr2 - purr1) / (time * number of procs * 
timebase)
where the number of procs and timebase can be obtained from /proc/cpuinfo.

Applications have been written to the interface already defined and 
these applications have value back on the legacy iSeries models.

Please consider this patch for inclusion.  It has been reviewed by Stephen.
-Jeff

Signed-off by: Jeff Scheel (scheel at vnet.ibm.com)

--- linuxppc-2.6.10_rc1.orig/arch/ppc64/kernel/lparcfg.c	2004-11-09 07:03:43.354383000 -0600
+++ linuxppc-2.6.10_rc1/arch/ppc64/kernel/lparcfg.c	2004-11-10 10:38:47.904484533 -0600
@@ -34,7 +34,7 @@
 #include <asm/rtas.h>
 #include <asm/system.h>
 
-#define MODULE_VERS "1.4"
+#define MODULE_VERS "1.5"
 #define MODULE_NAME "lparcfg"
 
 /* #define LPARCFG_DEBUG */
@@ -70,6 +70,28 @@
 
 #ifdef CONFIG_PPC_ISERIES
 
+/*
+ * For iSeries legacy systems, the PPA purr function is available from the
+ * xEmulatedTimeBase field in the paca.
+ */
+static unsigned long get_purr(void)
+{
+	unsigned long sum_purr = 0;
+	int cpu;
+	struct paca_struct *lpaca;
+
+	for_each_cpu(cpu) {
+		lpaca = paca + cpu;
+		sum_purr += lpaca->xLpPaca.xEmulatedTimeBase;
+
+#ifdef PURR_DEBUG
+		printk(KERN_INFO "get_purr for cpu (%d) has value (%ld) \n",
+			cpu, lpaca->xLpPaca.xEmulatedTimeBase);
+#endif
+	}
+	return sum_purr;
+}
+
 #define lparcfg_write NULL
 
 /* 
@@ -81,6 +103,9 @@
 	int shared, entitled_capacity, max_entitled_capacity;
 	int processors, max_processors;
 	struct paca_struct *lpaca = get_paca();
+	unsigned long purr = get_purr();
+
+	seq_printf(m, "%s %s \n", MODULE_NAME, MODULE_VERS);
 
 	shared = (int)(lpaca->lppaca_ptr->xSharedProc);
 	seq_printf(m, "serial_number=%c%c%c%c%c%c%c\n",
@@ -131,6 +156,7 @@
 		seq_printf(m, "pool_capacity=%d\n",
 			   (int)(HvLpConfig_getNumProcsInSharedPool(pool_id) *
 				 100));
+		seq_printf(m, "purr=%ld\n", purr);
 	}
 
 	seq_printf(m, "shared_processor_mode=%d\n", shared);

