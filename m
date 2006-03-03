Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751589AbWCCGNk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751589AbWCCGNk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 01:13:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751920AbWCCGNj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 01:13:39 -0500
Received: from gate.crashing.org ([63.228.1.57]:49308 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1751589AbWCCGNj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 01:13:39 -0500
Subject: [PATCH] powerpc: Fix windfarm_pm112 not starting all control loops
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Fri, 03 Mar 2006 17:13:30 +1100
Message-Id: <1141366411.3888.50.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.92 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This adds a couple of printk's to windfarm_pm112 to display which
control loops are actually starting and fixes a bug where it would not
start all loops.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Index: linux-work/drivers/macintosh/windfarm_pm112.c
===================================================================
--- linux-work.orig/drivers/macintosh/windfarm_pm112.c	2006-03-03 16:24:44.000000000 +1100
+++ linux-work/drivers/macintosh/windfarm_pm112.c	2006-03-03 17:04:53.000000000 +1100
@@ -358,6 +358,7 @@ static void backside_fan_tick(void)
 		return;
 	if (!backside_tick) {
 		/* first time; initialize things */
+		printk(KERN_INFO "windfarm: Backside control loop started.\n");
 		backside_param.min = backside_fan->ops->get_min(backside_fan);
 		backside_param.max = backside_fan->ops->get_max(backside_fan);
 		wf_pid_init(&backside_pid, &backside_param);
@@ -407,6 +408,7 @@ static void drive_bay_fan_tick(void)
 		return;
 	if (!drive_bay_tick) {
 		/* first time; initialize things */
+		printk(KERN_INFO "windfarm: Drive bay control loop started.\n");
 		drive_bay_prm.min = drive_bay_fan->ops->get_min(drive_bay_fan);
 		drive_bay_prm.max = drive_bay_fan->ops->get_max(drive_bay_fan);
 		wf_pid_init(&drive_bay_pid, &drive_bay_prm);
@@ -458,6 +460,7 @@ static void slots_fan_tick(void)
 		return;
 	if (!slots_started) {
 		/* first time; initialize things */
+		printk(KERN_INFO "windfarm: Slots control loop started.\n");
 		wf_pid_init(&slots_pid, &slots_param);
 		slots_started = 1;
 	}
@@ -504,6 +507,7 @@ static void pm112_tick(void)
 
 	if (!started) {
 		started = 1;
+		printk(KERN_INFO "windfarm: CPUs control loops started.\n");
 		for (i = 0; i < nr_cores; ++i) {
 			if (create_cpu_loop(i) < 0) {
 				failure_state = FAILURE_PERM;
@@ -594,8 +598,6 @@ static void pm112_new_sensor(struct wf_s
 {
 	unsigned int i;
 
-	if (have_all_sensors)
-		return;
 	if (!strncmp(sr->name, "cpu-temp-", 9)) {
 		i = sr->name[9] - '0';
 		if (sr->name[10] == 0 && i < NR_CORES &&


