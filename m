Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932554AbWADWHs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932554AbWADWHs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 17:07:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030298AbWADV7z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 16:59:55 -0500
Received: from a34-mta01.direcpc.com ([66.82.4.90]:51954 "EHLO
	a34-mta01.direcway.com") by vger.kernel.org with ESMTP
	id S1030296AbWADV7x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 16:59:53 -0500
Date: Wed, 04 Jan 2006 16:59:31 -0500
From: Ben Collins <bcollins@ubuntu.com>
Subject: [PATCH 03/15] powernow-k7: Work when kernel is compiled for SMP
To: linux-kernel@vger.kernel.org
Message-id: <0ISL00NU693O1L@a34-mta01.direcway.com>
Content-transfer-encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On a UP system with SMP compiled kernel, the powernow-k7 module would not
initialize (returned -ENODEV). Not sure why policy->cpu != 0 for UP
systems, but since policy->cpu isn't used anywhere, just check for
num_cpus in the system, and fail of it's > 1.

Signed-off-by: Ben Collins <bcollins@ubuntu.com>

---

 arch/i386/kernel/cpu/cpufreq/powernow-k7.c |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

a1418b50daac86ff02e0d7a4cba6185a452ca393
diff --git a/arch/i386/kernel/cpu/cpufreq/powernow-k7.c b/arch/i386/kernel/cpu/cpufreq/powernow-k7.c
index edcd626..a9c4970 100644
--- a/arch/i386/kernel/cpu/cpufreq/powernow-k7.c
+++ b/arch/i386/kernel/cpu/cpufreq/powernow-k7.c
@@ -576,9 +576,6 @@ static int __init powernow_cpu_init (str
 	union msr_fidvidstatus fidvidstatus;
 	int result;
 
-	if (policy->cpu != 0)
-		return -ENODEV;
-
 	rdmsrl (MSR_K7_FID_VID_STATUS, fidvidstatus.val);
 
 	/* recalibrate cpu_khz */
@@ -664,8 +661,13 @@ static struct cpufreq_driver powernow_dr
 
 static int __init powernow_init (void)
 {
-	if (check_powernow()==0)
+	/* Does not support multi-cpu systems */
+	if (num_online_cpus() != 1 || num_possible_cpus() != 1)
 		return -ENODEV;
+
+	if (check_powernow() == 0)
+		return -ENODEV;
+
 	return cpufreq_register_driver(&powernow_driver);
 }
 
-- 
1.0.5
