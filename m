Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262190AbUE1Vc2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262190AbUE1Vc2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 May 2004 17:32:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261865AbUE1V3u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 May 2004 17:29:50 -0400
Received: from mail.kroah.org ([65.200.24.183]:22189 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262190AbUE1V0r convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 May 2004 17:26:47 -0400
X-Donotread: and you are reading this why?
Subject: Re: [PATCH] Driver Core fixes for 2.6.7-rc1
In-Reply-To: <1085779555955@kroah.com>
X-Patch: quite boring stuff, it's just source code...
Date: Fri, 28 May 2004 14:25:55 -0700
Message-Id: <10857795553193@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1758, 2004/05/28 13:13:30-07:00, tpoynor@mvista.com

[PATCH] Fix for leave-runtime-suspended-devices-off-at-system-resume.patch

A patch to fix my previous
leave-runtime-suspended-devices-off-at-system-resume patch; the new
changes save a copy of power.power_state in order to know whether to
resume a device, independently of mods to that field by a driver suspend
routine.  This fixes 2.6.7-rc1-mm1 in the same fashion as the updated
2.6.6 patch sent previously.

Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/base/power/resume.c  |    2 +-
 drivers/base/power/suspend.c |    2 ++
 include/linux/pm.h           |    1 +
 3 files changed, 4 insertions(+), 1 deletion(-)


diff -Nru a/drivers/base/power/resume.c b/drivers/base/power/resume.c
--- a/drivers/base/power/resume.c	Fri May 28 14:17:52 2004
+++ b/drivers/base/power/resume.c	Fri May 28 14:17:52 2004
@@ -36,7 +36,7 @@
 		struct device * dev = to_device(entry);
 		list_del_init(entry);
 
-		if (!dev->power.power_state)
+		if (!dev->power.prev_state)
 			resume_device(dev);
 
 		list_add_tail(entry,&dpm_active);
diff -Nru a/drivers/base/power/suspend.c b/drivers/base/power/suspend.c
--- a/drivers/base/power/suspend.c	Fri May 28 14:17:52 2004
+++ b/drivers/base/power/suspend.c	Fri May 28 14:17:52 2004
@@ -41,6 +41,8 @@
 
 	dev_dbg(dev, "suspending\n");
 
+	dev->power.prev_state = dev->power.power_state;
+
 	if (dev->bus && dev->bus->suspend && !dev->power.power_state)
 		error = dev->bus->suspend(dev,state);
 
diff -Nru a/include/linux/pm.h b/include/linux/pm.h
--- a/include/linux/pm.h	Fri May 28 14:17:52 2004
+++ b/include/linux/pm.h	Fri May 28 14:17:52 2004
@@ -231,6 +231,7 @@
 struct dev_pm_info {
 	u32			power_state;
 #ifdef	CONFIG_PM
+	u32			prev_state;
 	u8			* saved_state;
 	atomic_t		pm_users;
 	struct device		* pm_parent;

