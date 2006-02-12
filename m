Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751474AbWBLWAE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751474AbWBLWAE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Feb 2006 17:00:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751475AbWBLWAE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Feb 2006 17:00:04 -0500
Received: from fsmlabs.com ([168.103.115.128]:6857 "EHLO spamalot.fsmlabs.com")
	by vger.kernel.org with ESMTP id S1751474AbWBLWAC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Feb 2006 17:00:02 -0500
X-ASG-Debug-ID: 1139781598-21235-137-0
X-Barracuda-URL: http://10.0.1.244:8000/cgi-bin/mark.cgi
Date: Sun, 12 Feb 2006 14:04:36 -0800 (PST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Linux Kernel <linux-kernel@vger.kernel.org>
cc: Andrew Morton <akpm@osdl.org>, Nathan Lynch <nathanl@austin.ibm.com>,
       John Stultz <johnstul@us.ibm.com>
X-ASG-Orig-Subj: [PATCH] Fix CPU hotplug with new time infrastructure
Subject: [PATCH] Fix CPU hotplug with new time infrastructure
Message-ID: <Pine.LNX.4.64.0602121351400.1579@montezuma.fsmlabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=5.0 KILL_LEVEL=5.0 tests=
X-Barracuda-Spam-Report: Code version 3.02, rules version 3.0.8637
	Rule breakdown below pts rule name              description
	---- ---------------------- --------------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

tsc_disable was marked __initdata so we were accessing random data (which 
happened to have a set bit) so upon warm cpu online we would disable the 
TSC, resulting in the following. Nathan does this fix your triple fault?

root@arusha cpu1 {0:0} echo 1 > online
Booting processor 1/1 eip 3000
Disabling TSC...
Calibrating delay using timer specific routine.. 797.62 BogoMIPS 
(lpj=3988115)
CPU1: Intel Pentium II (Deschutes) stepping 02
migration_cost=2595
root@arusha cpu1 {0:0} ps
  PID TTY          TIME CMD
 2432 ttyS0    00:00:00 tcsh
 2490 ttyS0    00:00:00 ps
root@arusha cpu1 {0:0} ps
Segmentation fault
root@arusha cpu1 {0:139}

<signed-off-by> Zwane Mwaikambo <zwane@arm.linux.org.uk>

Index: linux-2.6.16-rc2-mm1/arch/i386/kernel/tsc.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.16-rc2-mm1/arch/i386/kernel/tsc.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 tsc.c
--- linux-2.6.16-rc2-mm1/arch/i386/kernel/tsc.c	11 Feb 2006 16:55:15 -0000	1.1.1.1
+++ linux-2.6.16-rc2-mm1/arch/i386/kernel/tsc.c	12 Feb 2006 22:00:12 -0000
@@ -25,7 +25,7 @@
  */
 unsigned int tsc_khz;
 
-int tsc_disable __initdata = 0;
+int tsc_disable __cpuinitdata = 0;
 
 #ifdef CONFIG_X86_TSC
 static int __init tsc_setup(char *str)
