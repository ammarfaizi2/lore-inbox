Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261545AbVGCVtd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261545AbVGCVtd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Jul 2005 17:49:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261548AbVGCVtd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Jul 2005 17:49:33 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:33249 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261545AbVGCVt3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Jul 2005 17:49:29 -0400
Date: Sun, 3 Jul 2005 23:49:29 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@zip.com.au>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: [patch] call device_shutdown with interrupts enabled
Message-ID: <20050703214929.GA9214@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Do not call device_shutdown with interrupts disabled. It is wrong and
produces ugly warnings.

Signed-off-by: Pavel Machek <pavel@suse.cz>

---
commit 325107c7d4a5a28dee6eecce1ee8fa01753414c7
tree ea824a39656ae9da70f6738e9452b1ac7b561ab3
parent b61ea835309d0fb87cf1c7a2d83d5832ae8eb116
author <pavel@amd.(none)> Sun, 03 Jul 2005 23:48:35 +0200
committer <pavel@amd.(none)> Sun, 03 Jul 2005 23:48:35 +0200

 kernel/power/disk.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/power/disk.c b/kernel/power/disk.c
--- a/kernel/power/disk.c
+++ b/kernel/power/disk.c
@@ -50,19 +50,21 @@ static void power_down(suspend_disk_meth
 	unsigned long flags;
 	int error = 0;
 
-	local_irq_save(flags);
 	switch(mode) {
 	case PM_DISK_PLATFORM:
- 		device_shutdown();
+		device_shutdown();
+		local_irq_save(flags);
 		error = pm_ops->enter(PM_SUSPEND_DISK);
 		break;
 	case PM_DISK_SHUTDOWN:
 		printk("Powering off system\n");
 		device_shutdown();
+		local_irq_save(flags);
 		machine_power_off();
 		break;
 	case PM_DISK_REBOOT:
 		device_shutdown();
+		local_irq_save(flags);
 		machine_restart(NULL);
 		break;
 	}

-- 
teflon -- maybe it is a trademark, but it should not be.
