Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751536AbWDYCfT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751536AbWDYCfT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 22:35:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751539AbWDYCfT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 22:35:19 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:51865 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751536AbWDYCfR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 22:35:17 -0400
From: sekharan@us.ibm.com
To: akpm@osdl.org, torvalds@osdl.org
Cc: sekharan@us.ibm.com, linux-kernel@vger.kernel.org, herbert@13thfloor.at,
       linux-xfs@oss.sgi.com, xfs-masters@oss.sgi.com,
       stern@rowland.harvard.edu
Date: Mon, 24 Apr 2006 19:35:15 -0700
Message-Id: <20060425023515.7529.2994.sendpatchset@localhost.localdomain>
In-Reply-To: <20060425023509.7529.84752.sendpatchset@localhost.localdomain>
References: <20060425023509.7529.84752.sendpatchset@localhost.localdomain>
Subject: [PATCH 1/3] Remove __devinitdata from notifier block definitions
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Few of the notifier_chain_register() callers use __initdata in
the definition of notifier_block data structure.  It is incorrect as 
the data structure should be available after the initializations (they
do not unregister them during initializations).

This was leading to oops when notifier_chain_register() call is invoked
for those callback chains after initialization.

This patch fixes all such usages to _not_ have the notifier_block data
structure in the init data section.
--
Signed-Off-By: Chandra Seetharaman <sekharan@us.ibm.com>

 arch/powerpc/kernel/sysfs.c        |    2 +-
 arch/s390/appldata/appldata_base.c |    2 +-
 block/ll_rw_blk.c                  |    2 +-
 kernel/hrtimer.c                   |    2 +-
 kernel/rcupdate.c                  |    2 +-
 kernel/sched.c                     |    2 +-
 kernel/softirq.c                   |    2 +-
 kernel/softlockup.c                |    2 +-
 kernel/timer.c                     |    2 +-
 9 files changed, 9 insertions(+), 9 deletions(-)

Index: linux-2617-rc2/arch/powerpc/kernel/sysfs.c
===================================================================
--- linux-2617-rc2.orig/arch/powerpc/kernel/sysfs.c	2006-04-24 06:56:50.000000000 -0700
+++ linux-2617-rc2/arch/powerpc/kernel/sysfs.c	2006-04-24 07:11:37.000000000 -0700
@@ -297,7 +297,7 @@ static int __devinit sysfs_cpu_notify(st
 	return NOTIFY_OK;
 }
 
-static struct notifier_block __devinitdata sysfs_cpu_nb = {
+static struct notifier_block sysfs_cpu_nb = {
 	.notifier_call	= sysfs_cpu_notify,
 };
 
Index: linux-2617-rc2/arch/s390/appldata/appldata_base.c
===================================================================
--- linux-2617-rc2.orig/arch/s390/appldata/appldata_base.c	2006-04-24 06:56:50.000000000 -0700
+++ linux-2617-rc2/arch/s390/appldata/appldata_base.c	2006-04-24 06:57:34.000000000 -0700
@@ -652,7 +652,7 @@ appldata_cpu_notify(struct notifier_bloc
 	return NOTIFY_OK;
 }
 
-static struct notifier_block __devinitdata appldata_nb = {
+static struct notifier_block appldata_nb = {
 	.notifier_call = appldata_cpu_notify,
 };
 
Index: linux-2617-rc2/block/ll_rw_blk.c
===================================================================
--- linux-2617-rc2.orig/block/ll_rw_blk.c	2006-04-19 10:17:08.000000000 -0700
+++ linux-2617-rc2/block/ll_rw_blk.c	2006-04-24 06:58:19.000000000 -0700
@@ -3385,7 +3385,7 @@ static int blk_cpu_notify(struct notifie
 }
 
 
-static struct notifier_block __devinitdata blk_cpu_notifier = {
+static struct notifier_block blk_cpu_notifier = {
 	.notifier_call	= blk_cpu_notify,
 };
 
Index: linux-2617-rc2/kernel/hrtimer.c
===================================================================
--- linux-2617-rc2.orig/kernel/hrtimer.c	2006-04-19 10:17:15.000000000 -0700
+++ linux-2617-rc2/kernel/hrtimer.c	2006-04-24 07:11:37.000000000 -0700
@@ -860,7 +860,7 @@ static int __devinit hrtimer_cpu_notify(
 	return NOTIFY_OK;
 }
 
-static struct notifier_block __devinitdata hrtimers_nb = {
+static struct notifier_block hrtimers_nb = {
 	.notifier_call = hrtimer_cpu_notify,
 };
 
Index: linux-2617-rc2/kernel/softirq.c
===================================================================
--- linux-2617-rc2.orig/kernel/softirq.c	2006-04-19 10:17:15.000000000 -0700
+++ linux-2617-rc2/kernel/softirq.c	2006-04-24 07:11:37.000000000 -0700
@@ -484,7 +484,7 @@ static int __devinit cpu_callback(struct
 	return NOTIFY_OK;
 }
 
-static struct notifier_block __devinitdata cpu_nfb = {
+static struct notifier_block cpu_nfb = {
 	.notifier_call = cpu_callback
 };
 
Index: linux-2617-rc2/kernel/rcupdate.c
===================================================================
--- linux-2617-rc2.orig/kernel/rcupdate.c	2006-04-24 06:58:55.000000000 -0700
+++ linux-2617-rc2/kernel/rcupdate.c	2006-04-24 07:11:37.000000000 -0700
@@ -537,7 +537,7 @@ static int __devinit rcu_cpu_notify(stru
 	return NOTIFY_OK;
 }
 
-static struct notifier_block __devinitdata rcu_nb = {
+static struct notifier_block rcu_nb = {
 	.notifier_call	= rcu_cpu_notify,
 };
 
Index: linux-2617-rc2/kernel/softlockup.c
===================================================================
--- linux-2617-rc2.orig/kernel/softlockup.c	2006-04-19 10:17:15.000000000 -0700
+++ linux-2617-rc2/kernel/softlockup.c	2006-04-24 07:00:06.000000000 -0700
@@ -140,7 +140,7 @@ cpu_callback(struct notifier_block *nfb,
 	return NOTIFY_OK;
 }
 
-static struct notifier_block __devinitdata cpu_nfb = {
+static struct notifier_block cpu_nfb = {
 	.notifier_call = cpu_callback
 };
 
Index: linux-2617-rc2/kernel/timer.c
===================================================================
--- linux-2617-rc2.orig/kernel/timer.c	2006-04-24 06:54:40.000000000 -0700
+++ linux-2617-rc2/kernel/timer.c	2006-04-24 07:11:37.000000000 -0700
@@ -1334,7 +1334,7 @@ static int __devinit timer_cpu_notify(st
 	return NOTIFY_OK;
 }
 
-static struct notifier_block __devinitdata timers_nb = {
+static struct notifier_block timers_nb = {
 	.notifier_call	= timer_cpu_notify,
 };
 
Index: linux-2617-rc2/kernel/sched.c
===================================================================
--- linux-2617-rc2.orig/kernel/sched.c	2006-04-24 06:54:41.000000000 -0700
+++ linux-2617-rc2/kernel/sched.c	2006-04-24 07:11:45.000000000 -0700
@@ -4814,7 +4814,7 @@ static int migration_call(struct notifie
 /* Register at highest priority so that task migration (migrate_all_tasks)
  * happens before everything else.
  */
-static struct notifier_block __devinitdata migration_notifier = {
+static struct notifier_block migration_notifier = {
 	.notifier_call = migration_call,
 	.priority = 10
 };

-- 

----------------------------------------------------------------------
    Chandra Seetharaman               | Be careful what you choose....
              - sekharan@us.ibm.com   |      .......you may get it.
----------------------------------------------------------------------
