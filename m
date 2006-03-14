Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751177AbWCNQJ3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751177AbWCNQJ3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 11:09:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751026AbWCNQJ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 11:09:29 -0500
Received: from mx1.redhat.com ([66.187.233.31]:39899 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751114AbWCNQJ2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 11:09:28 -0500
Message-ID: <4416EB14.50306@ce.jp.nec.com>
Date: Tue, 14 Mar 2006 11:11:00 -0500
From: "Jun'ichi Nomura" <j-nomura@ce.jp.nec.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <gregkh@suse.de>
CC: linux-kernel@vger.kernel.org
Subject: [PATCH] kobject_uevent CONFIG_SYSFS=n build fix
Content-Type: multipart/mixed;
 boundary="------------040109090100080709050901"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040109090100080709050901
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit

Hello,

In 2.6.16-rc6 (probably in earlier rc as well),
following build error occurs with CONFIG_SYSFS=n.

kernel/built-in.o(.data+0x1d40): undefined reference to `uevent_helper'
lib/lib.a(kobject_uevent.o)(.text+0x5c1): In function `kobject_uevent':
/build/rc6/source/lib/kobject_uevent.c:152: undefined reference to `uevent_seqnum'
lib/lib.a(kobject_uevent.o)(.text+0x5d0):/build/rc6/source/lib/kobject_uevent.c:152: undefined reference to `uevent_seqnum'
lib/lib.a(kobject_uevent.o)(.text+0x901):/build/rc6/source/lib/kobject_uevent.c:182: undefined reference to `uevent_helper'
lib/lib.a(kobject_uevent.o)(.text+0x910):/build/rc6/source/lib/kobject_uevent.c:182: undefined reference to `uevent_helper'

This seems to be caused by mismatch of build condition.
uevent_seqnum and uevent_helper are conditional to CONFIG_SYSFS.
While they are referenced if CONFIG_HOTPLUG (and CONFIG_NET) is enabled.

Attached patch consolidates them to CONFIG_HOTPLUG && CONFIG_NET.

I tried with (!CONFIG_NET && CONFIG_SYSFS) and
(CONFIG_NET && !CONFIG_SYSFS).
Both built ok.
So I think it doesn't conflict with "[PATCH] kobject_uevent CONFIG_NET=n
fix" which is in 2.6.16-rc6.

Thanks,
-- 
Jun'ichi Nomura, NEC Solutions (America), Inc.

--------------040109090100080709050901
Content-Type: text/x-patch;
 name="nosysfs-build.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="nosysfs-build.patch"

CONFIG_SYSFS=n fails to build due to mismatch of conditions
for uevent_seqnum and uevent_helper.

kernel/built-in.o(.data+0x1d40): undefined reference to `uevent_helper'
lib/lib.a(kobject_uevent.o)(.text+0x5c1): In function `kobject_uevent':
/build/rc6/source/lib/kobject_uevent.c:152: undefined reference to `uevent_seqnum'
lib/lib.a(kobject_uevent.o)(.text+0x5d0):/build/rc6/source/lib/kobject_uevent.c:152: undefined reference to `uevent_seqnum'
lib/lib.a(kobject_uevent.o)(.text+0x901):/build/rc6/source/lib/kobject_uevent.c:182: undefined reference to `uevent_helper'
lib/lib.a(kobject_uevent.o)(.text+0x910):/build/rc6/source/lib/kobject_uevent.c:182: undefined reference to `uevent_helper'

Signed-off-by: Jun'ichi Nomura <j-nomura@ce.jp.nec.com>


--- linux-2.6.16-rc6.orig/lib/kobject_uevent.c	2006-03-14 08:57:23.000000000 -0500
+++ linux-2.6.16-rc6/lib/kobject_uevent.c	2006-03-14 08:52:57.000000000 -0500
@@ -26,6 +26,9 @@
 #define NUM_ENVP	32	/* number of env pointers */
 
 #if defined(CONFIG_HOTPLUG) && defined(CONFIG_NET)
+u64 uevent_seqnum;
+char uevent_helper[UEVENT_HELPER_PATH_LEN] = "/sbin/hotplug";
+
 static DEFINE_SPINLOCK(sequence_lock);
 static struct sock *uevent_sock;
 
--- linux-2.6.16-rc6.orig/kernel/sysctl.c	2006-03-14 09:17:09.000000000 -0500
+++ linux-2.6.16-rc6/kernel/sysctl.c	2006-03-14 09:24:32.000000000 -0500
@@ -399,7 +399,7 @@ static ctl_table kern_table[] = {
 		.strategy	= &sysctl_string,
 	},
 #endif
-#ifdef CONFIG_HOTPLUG
+#if defined(CONFIG_HOTPLUG) && defined(CONFIG_NET)
 	{
 		.ctl_name	= KERN_HOTPLUG,
 		.procname	= "hotplug",
--- linux-2.6.16-rc6.orig/kernel/ksysfs.c	2006-03-14 08:57:31.000000000 -0500
+++ linux-2.6.16-rc6/kernel/ksysfs.c	2006-03-14 09:38:44.000000000 -0500
@@ -15,9 +15,6 @@
 #include <linux/module.h>
 #include <linux/init.h>
 
-u64 uevent_seqnum;
-char uevent_helper[UEVENT_HELPER_PATH_LEN] = "/sbin/hotplug";
-
 #define KERNEL_ATTR_RO(_name) \
 static struct subsys_attribute _name##_attr = __ATTR_RO(_name)
 
@@ -25,7 +22,7 @@ static struct subsys_attribute _name##_a
 static struct subsys_attribute _name##_attr = \
 	__ATTR(_name, 0644, _name##_show, _name##_store)
 
-#ifdef CONFIG_HOTPLUG
+#if defined(CONFIG_HOTPLUG) && defined(CONFIG_NET)
 /* current uevent sequence number */
 static ssize_t uevent_seqnum_show(struct subsystem *subsys, char *page)
 {
@@ -55,7 +52,7 @@ decl_subsys(kernel, NULL, NULL);
 EXPORT_SYMBOL_GPL(kernel_subsys);
 
 static struct attribute * kernel_attrs[] = {
-#ifdef CONFIG_HOTPLUG
+#if defined(CONFIG_HOTPLUG) && defined(CONFIG_NET)
 	&uevent_seqnum_attr.attr,
 	&uevent_helper_attr.attr,
 #endif
--- linux-2.6.16-rc6.orig/include/linux/kobject.h	2006-03-14 10:00:20.000000000 -0500
+++ linux-2.6.16-rc6/include/linux/kobject.h	2006-03-14 09:59:52.000000000 -0500
@@ -27,6 +27,8 @@
 #include <asm/atomic.h>
 
 #define KOBJ_NAME_LEN			20
+
+#if defined(CONFIG_HOTPLUG) && defined(CONFIG_NET)
 #define UEVENT_HELPER_PATH_LEN		256
 
 /* path to the userspace helper executed on an event */
@@ -34,6 +36,7 @@ extern char uevent_helper[];
 
 /* counter to tag the uevent, read only except for the kobject core */
 extern u64 uevent_seqnum;
+#endif
 
 /* the actions here must match the proper string in lib/kobject_uevent.c */
 typedef int __bitwise kobject_action_t;

--------------040109090100080709050901--
