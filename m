Return-Path: <linux-kernel-owner+w=401wt.eu-S965161AbWL2VNY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965161AbWL2VNY (ORCPT <rfc822;w@1wt.eu>);
	Fri, 29 Dec 2006 16:13:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965163AbWL2VNY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Dec 2006 16:13:24 -0500
Received: from gateway-1237.mvista.com ([63.81.120.158]:56108 "EHLO
	dwalker1.mvista.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S965161AbWL2VNX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Dec 2006 16:13:23 -0500
Message-Id: <20061229211237.690413000@mvista.com>
User-Agent: quilt/0.45-1
Date: Fri, 29 Dec 2006 13:12:37 -0800
From: Daniel Walker <dwalker@mvista.com>
To: mingo@elte.hu
CC: linux-kernel@vger.kernel.org
CC: a.p.zijlstra@chello.nl
Subject: [PATCH -rt] scheduling while atomic in remove_proc_entry()
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Found this in 2.6.20-rc2-rt3 w/ PREEMPT_RT off on x86_64,

BUG: scheduling while atomic: swapper/0x00000001/1, CPU#0

Call Trace:
 [<ffffffff813470c0>] __sched_text_start+0xb0/0x85a
 [<ffffffff8102e9ec>] try_to_wake_up+0x3fc/0x420
 [<ffffffff81062ebb>] add_preempt_count+0x2b/0x130
 [<ffffffff81347b75>] schedule+0xe5/0x110
 [<ffffffff81047ced>] flush_cpu_workqueue+0x8d/0xd0
 [<ffffffff8104b8a0>] autoremove_wake_function+0x0/0x40
 [<ffffffff8108b670>] filevec_add_drain_per_cpu+0x0/0x80
 [<ffffffff81047da3>] flush_workqueue+0x73/0xa0
 [<ffffffff8104871a>] schedule_on_each_cpu_wq+0xea/0x110
 [<ffffffff81062ebb>] add_preempt_count+0x2b/0x130
 [<ffffffff8108ba07>] filevec_add_drain_all+0x17/0x20
 [<ffffffff810c8da0>] remove_proc_entry+0xb0/0x230
 [<ffffffff810659cd>] unregister_handler_proc+0x2d/0x60
 [<ffffffff81063f2c>] free_irq+0xfc/0x150
 [<ffffffff81274b3d>] i8042_probe+0x30d/0x610
 [<ffffffff811cff82>] platform_drv_probe+0x12/0x20
 [<ffffffff811ce1db>] really_probe+0x9b/0x140
 [<ffffffff811ce338>] driver_probe_device+0xb8/0xd0
 [<ffffffff811ce350>] __device_attach+0x0/0x10
 [<ffffffff811ce359>] __device_attach+0x9/0x10
 [<ffffffff811cd35c>] bus_for_each_drv+0x4c/0x90
 [<ffffffff811ce3ef>] device_attach+0x6f/0x90
 [<ffffffff811cd26e>] bus_attach_device+0x2e/0x70
 [<ffffffff811cbe38>] device_add+0x3d8/0x5b0
 [<ffffffff811d042f>] platform_device_add+0x13f/0x180
 [<ffffffff81597fb2>] i8042_init+0x72/0xb0
 [<ffffffff81007192>] init+0x172/0x3c0
 [<ffffffff8100add8>] child_rip+0xa/0x12
 [<ffffffff81007020>] init+0x0/0x3c0
 [<ffffffff8100adce>] child_rip+0x0/0x12

---------------------------
| preempt count: 00000001 ]
| 1-level deep critical section nesting:
----------------------------------------
. [<ffffffff8134a0a6>] .... __spin_lock+0x16/0x80
....[<ffffffff810c8d3b>] ..   ( <= remove_proc_entry+0x4b/0x230)


Signed-Off-By: Daniel Walker <dwalker@mvista.com>

---
 fs/proc/generic.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)

Index: linux-2.6.19/fs/proc/generic.c
===================================================================
--- linux-2.6.19.orig/fs/proc/generic.c
+++ linux-2.6.19/fs/proc/generic.c
@@ -555,7 +555,6 @@ static void proc_kill_inodes(struct proc
 	/*
 	 * Actually it's a partial revoke().
 	 */
-	filevec_add_drain_all();
 	lock_list_for_each_entry(filp, &sb->s_files, f_u.fu_llist) {
 		struct dentry * dentry = filp->f_path.dentry;
 		struct inode * inode;
@@ -738,6 +737,8 @@ void remove_proc_entry(const char *name,
 		break;
 	}
 	spin_unlock(&proc_subdir_lock);
+
+	filevec_add_drain_all();
 out:
 	return;
 }
--
