Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261567AbTLNMQh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Dec 2003 07:16:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262750AbTLNMQg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Dec 2003 07:16:36 -0500
Received: from mail.mppmu.mpg.de ([134.107.24.11]:50823 "EHLO
	mail.mppmu.mpg.de") by vger.kernel.org with ESMTP id S261567AbTLNMQa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Dec 2003 07:16:30 -0500
Date: Sun, 14 Dec 2003 13:16:29 +0100 (CET)
From: Peter Breitenlohner <peb@mppmu.mpg.de>
To: linux-kernel@vger.kernel.org
Subject: linux-2.4.23 dual Xeon detection problem + patch (fwd)
Message-ID: <Pine.LNX.4.58.0312141309280.1027@pcl321.mppmu.mpg.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-ID: <Pine.LNX.4.58.0312141309282.1027@pcl321.mppmu.mpg.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

originally I sent this to the maintainer (Ingo Molnar), but since I didn't
get any response for about two weeks I am now sending this to the
developer's list (with the patch -- originally as attachement -- now
inlined).

regards
Peter Breitenlohner <peb@mppmu.mpg.de>

-------------------- start of patch ------------------
--- linux-2.4.23/include/asm-i386/smpboot.h.orig	2003-08-25 13:44:43.000000000 +0200
+++ linux-2.4.23/include/asm-i386/smpboot.h	2003-12-02 16:49:46.000000000 +0100
@@ -73,11 +73,9 @@
  */
 static inline int cpu_present_to_apicid(int mps_cpu)
 {
-	if (clustered_apic_mode == CLUSTERED_APIC_XAPIC)
-		return raw_phys_apicid[mps_cpu];
 	if(clustered_apic_mode == CLUSTERED_APIC_NUMAQ)
 		return (mps_cpu/4)*16 + (1<<(mps_cpu%4));
-	return mps_cpu;
+	return raw_phys_apicid[mps_cpu];
 }

 static inline unsigned long apicid_to_phys_cpu_present(int apicid)
--------------------- end of patch -------------------

---------- Forwarded message ----------
Date: Tue, 2 Dec 2003 17:45:40 +0100 (CET)
From: Peter Breitenlohner <peb@mppmu.mpg.de>
To: Ingo Molnar <mingo@redhat.com>
Subject: linux-2.4.23 dual Xeon detection problem + patch

Hi Ingo,

here my bug report with patch, following the REPORTING-BUGS guidelines

1. linux-2.4.23 Intel E7505 dual Xeon detection failure

2. the linux-2.4.23 kernel detects but fails to boot the second physical
processor on our ASUS PP-DLW dual Xeon boards with Intel 7505 chipset.
(There were no such problems with the 2.4.21 kernel.)

3. keywords: kernel, smp, apic

4. kernel version: 2.4.23

7.2. extract from /proc/cpuinfo (with patch)

	processor: 0, 1, 2, 3
	vendor_id: GenuineIntel
	cpu family: 15
	model: 2
	model name: Intel(R) Xeon(TM) CPU 2.66GHz
	stepping: 5

8. The relevant early kernel messages (without patch) were:

	Processor #0 Pentium 4(tm) XEON(tm) APIC version 20
	Processor #6 Pentium 4(tm) XEON(tm) APIC version 20
	Processor #1 Pentium 4(tm) XEON(tm) APIC version 20
	Processor #7 Pentium 4(tm) XEON(tm) APIC version 20
	........
	Total of 2 processors activated (10616.83 BogoMIPS).

After adding some printk's into linux-2.4.23/arch/i386/kernel/smpboot.c
I found out that in the function smp_boot_cpus in the
	for (bit = 0; bit < NR_CPUS; bit++)
loop (line 1109)

	bit=0	=>	apicid=0	= boot CPU
	bit=1	=>	apicid=1	sibling of boot CPU
	bit=2	=>	apicid=2	bad
	bit=3	=>	apicid=3	bad

with the attached patch I got

	bit=0	=>	apicid=0	= boot CPU
	bit=1	=>	apicid=6	second CPU
	bit=2	=>	apicid=1	sibling of boot CPU
	bit=3	=>	apicid=7	sibling of second CPU

and a final

	Total of 4 processors activated (21233.66 BogoMIPS).

I know quite well, that the attached patch is a raw fix and probably solves
only some of the problems caused by the difference between physical and
logical CPU ids, but it seems to work quite well in our case.

regards
Peter Breitenlohner <peb@mppmu.mpg.de>
