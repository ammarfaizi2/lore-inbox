Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268448AbUJVXSb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268448AbUJVXSb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 19:18:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268710AbUJVXST
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 19:18:19 -0400
Received: from mail.kroah.org ([69.55.234.183]:13731 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S268448AbUJVXKN convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 19:10:13 -0400
X-Donotread: and you are reading this why?
Subject: Re: [PATCH] Driver Core patches for 2.6.10-rc1
In-Reply-To: <10984865712455@kroah.com>
X-Patch: quite boring stuff, it's just source code...
Date: Fri, 22 Oct 2004 16:09:32 -0700
Message-Id: <1098486572164@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2021, 2004/10/22 14:29:57-07:00, akpm@osdl.org

[PATCH] remove cpu_run_sbin_hotplug()

From: Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>

Remove cpu_run_sbin_hotplug() - use kobject_hotplug() instead.

Signed-off-by: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/base/cpu.c             |    2 ++
 include/linux/kobject_uevent.h |    1 +
 kernel/cpu.c                   |   35 -----------------------------------
 lib/kobject_uevent.c           |    2 ++
 4 files changed, 5 insertions(+), 35 deletions(-)


diff -Nru a/drivers/base/cpu.c b/drivers/base/cpu.c
--- a/drivers/base/cpu.c	2004-10-22 15:59:52 -07:00
+++ b/drivers/base/cpu.c	2004-10-22 15:59:52 -07:00
@@ -32,6 +32,8 @@
 	switch (buf[0]) {
 	case '0':
 		ret = cpu_down(cpu->sysdev.id);
+		if (!ret)
+			kobject_hotplug(&dev->kobj, KOBJ_OFFLINE);
 		break;
 	case '1':
 		ret = cpu_up(cpu->sysdev.id);
diff -Nru a/include/linux/kobject_uevent.h b/include/linux/kobject_uevent.h
--- a/include/linux/kobject_uevent.h	2004-10-22 15:59:52 -07:00
+++ b/include/linux/kobject_uevent.h	2004-10-22 15:59:52 -07:00
@@ -22,6 +22,7 @@
 	KOBJ_CHANGE	= (__force kobject_action_t) 0x03,	/* a sysfs attribute file has changed */
 	KOBJ_MOUNT	= (__force kobject_action_t) 0x04,	/* mount event for block devices */
 	KOBJ_UMOUNT	= (__force kobject_action_t) 0x05,	/* umount event for block devices */
+	KOBJ_OFFLINE	= (__force kobject_action_t) 0x06,	/* offline event for hotplug devices */
 };
 
 
diff -Nru a/kernel/cpu.c b/kernel/cpu.c
--- a/kernel/cpu.c	2004-10-22 15:59:52 -07:00
+++ b/kernel/cpu.c	2004-10-22 15:59:52 -07:00
@@ -57,34 +57,6 @@
 	write_unlock_irq(&tasklist_lock);
 }
 
-/* Notify userspace when a cpu event occurs, by running '/sbin/hotplug
- * cpu' with certain environment variables set.  */
-static int cpu_run_sbin_hotplug(unsigned int cpu, const char *action)
-{
-	char *argv[3], *envp[6], cpu_str[12], action_str[32], devpath_str[40];
-	int i;
-
-	sprintf(cpu_str, "CPU=%d", cpu);
-	sprintf(action_str, "ACTION=%s", action);
-	sprintf(devpath_str, "DEVPATH=devices/system/cpu/cpu%d", cpu);
-	
-	i = 0;
-	argv[i++] = hotplug_path;
-	argv[i++] = "cpu";
-	argv[i] = NULL;
-
-	i = 0;
-	/* minimal command environment */
-	envp[i++] = "HOME=/";
-	envp[i++] = "PATH=/sbin:/bin:/usr/sbin:/usr/bin";
-	envp[i++] = cpu_str;
-	envp[i++] = action_str;
-	envp[i++] = devpath_str;
-	envp[i] = NULL;
-
-	return call_usermodehelper(argv[0], argv, envp, 0);
-}
-
 /* Take this CPU down. */
 static int take_cpu_down(void *unused)
 {
@@ -170,8 +142,6 @@
 
 	check_for_tasks(cpu);
 
-	cpu_run_sbin_hotplug(cpu, "offline");
-
 out_thread:
 	err = kthread_stop(p);
 out_allowed:
@@ -179,11 +149,6 @@
 out:
 	unlock_cpu_hotplug();
 	return err;
-}
-#else
-static inline int cpu_run_sbin_hotplug(unsigned int cpu, const char *action)
-{
-	return 0;
 }
 #endif /*CONFIG_HOTPLUG_CPU*/
 
diff -Nru a/lib/kobject_uevent.c b/lib/kobject_uevent.c
--- a/lib/kobject_uevent.c	2004-10-22 15:59:52 -07:00
+++ b/lib/kobject_uevent.c	2004-10-22 15:59:52 -07:00
@@ -36,6 +36,8 @@
 		return "mount";
 	case KOBJ_UMOUNT:
 		return "umount";
+	case KOBJ_OFFLINE:
+		return "offline";
 	default:
 		return NULL;
 	}

