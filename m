Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266344AbUJSQrT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266344AbUJSQrT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 12:47:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269820AbUJSQqU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 12:46:20 -0400
Received: from mail.kroah.org ([69.55.234.183]:57284 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S269799AbUJSQit convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 12:38:49 -0400
X-Donotread: and you are reading this why?
Subject: Re: [PATCH] Driver Core patches for 2.6.9
In-Reply-To: <10982037663778@kroah.com>
X-Patch: quite boring stuff, it's just source code...
Date: Tue, 19 Oct 2004 09:36:09 -0700
Message-Id: <1098203769206@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1832.55.9, 2004/09/08 21:25:19-07:00, greg@kroah.com

[PATCH] ksyms: don't implement /sys/kernel/hotplug_seqnum if CONFIG_HOTPLUG is not enabled.

Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 kernel/ksysfs.c |    8 ++++++--
 lib/kobject.c   |    2 +-
 2 files changed, 7 insertions(+), 3 deletions(-)


diff -Nru a/kernel/ksysfs.c b/kernel/ksysfs.c
--- a/kernel/ksysfs.c	2004-10-19 09:23:10 -07:00
+++ b/kernel/ksysfs.c	2004-10-19 09:23:10 -07:00
@@ -22,17 +22,20 @@
 static struct subsys_attribute _name##_attr = \
 	__ATTR(_name, 0644, _name##_show, _name##_store)
 
+#ifdef CONFIG_HOTPLUG
 static ssize_t hotplug_seqnum_show(struct subsystem *subsys, char *page)
 {
 	return sprintf(page, "%llu\n", hotplug_seqnum);
 }
 KERNEL_ATTR_RO(hotplug_seqnum);
-
+#endif
 
 static decl_subsys(kernel, NULL, NULL);
 
 static struct attribute * kernel_attrs[] = {
+#ifdef CONFIG_HOTPLUG
 	&hotplug_seqnum_attr.attr,
+#endif
 	NULL
 };
 
@@ -44,7 +47,8 @@
 {
 	int error = subsystem_register(&kernel_subsys);
 	if (!error)
-		error = sysfs_create_group(&kernel_subsys.kset.kobj, &kernel_attr_group);
+		error = sysfs_create_group(&kernel_subsys.kset.kobj,
+					   &kernel_attr_group);
 
 	return error;
 }
diff -Nru a/lib/kobject.c b/lib/kobject.c
--- a/lib/kobject.c	2004-10-19 09:23:10 -07:00
+++ b/lib/kobject.c	2004-10-19 09:23:10 -07:00
@@ -118,9 +118,9 @@
 	return path;
 }
 
-u64 hotplug_seqnum;
 #ifdef CONFIG_HOTPLUG
 
+u64 hotplug_seqnum;
 #define BUFFER_SIZE	1024	/* should be enough memory for the env */
 #define NUM_ENVP	32	/* number of env pointers */
 static spinlock_t sequence_lock = SPIN_LOCK_UNLOCKED;

