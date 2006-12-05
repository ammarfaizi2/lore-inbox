Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1759808AbWLEILY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759808AbWLEILY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 03:11:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759821AbWLEILY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 03:11:24 -0500
Received: from server99.tchmachines.com ([72.9.230.178]:58584 "EHLO
	server99.tchmachines.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759801AbWLEILY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 03:11:24 -0500
Date: Tue, 5 Dec 2006 00:10:56 -0800
From: Ravikiran G Thirumalai <kiran@scalex86.org>
To: Andi Kleen <ak@suse.de>, greg@kroah.com, chrisw@sous-sol.org
Cc: linux-kernel@vger.kernel.org, stable@kernel.org,
       "Shai Fultheim (Shai@scalex86.org)" <shai@scalex86.org>,
       "Benzi Galili (Benzi@ScaleMP.com)" <benzi@scalemp.com>
Subject: [patch] x86_64: Fix boot hang due to nmi watchdog init code
Message-ID: <20061205081056.GA3730@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - server99.tchmachines.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - scalex86.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.6.19  stopped booting (or booted based on build/config) on our x86_64
systems due to a bug introduced in 2.6.19.  check_nmi_watchdog schedules an
IPI on all cpus to  busy wait on a flag, but fails to set the busywait
flag if NMI functionality is disabled.  This causes the secondary cpus
to spin in an endless loop, causing the kernel bootup to hang.
Depending upon the build, the  busywait flag got overwritten (stack variable)
and caused  the kernel to bootup on certain builds.  Following patch fixes
the bug by setting the busywait flag before returning from check_nmi_watchdog.
I guess using a stack variable is not good here as the calling function could
potentially return while the busy wait loop is still spinning on the flag.
I would think this is a good candidate for 2.6.19 stable as well.

Signed-off-by: Ravikiran Thirumalai <kiran@scalex86.org>
Signed-off-by: Shai Fultheim <shai@scalex86.org>

Index: linux-2.6.19/arch/x86_64/kernel/nmi.c
===================================================================
--- linux-2.6.19.orig/arch/x86_64/kernel/nmi.c	2006-11-29 13:57:37.000000000 -0800
+++ linux-2.6.19/arch/x86_64/kernel/nmi.c	2006-12-04 18:02:42.462737000 -0800
@@ -210,9 +210,10 @@ static __init void nmi_cpu_busy(void *da
 }
 #endif
 
+static int endflag = 0;
+
 int __init check_nmi_watchdog (void)
 {
-	volatile int endflag = 0;
 	int *counts;
 	int cpu;
 
@@ -253,6 +254,7 @@ int __init check_nmi_watchdog (void)
 	if (!atomic_read(&nmi_active)) {
 		kfree(counts);
 		atomic_set(&nmi_active, -1);
+		endflag = 1;
 		return -1;
 	}
 	endflag = 1;
