Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750900AbWCNX6j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750900AbWCNX6j (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 18:58:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752044AbWCNX6j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 18:58:39 -0500
Received: from mx1.redhat.com ([66.187.233.31]:1669 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750900AbWCNX6i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 18:58:38 -0500
Message-ID: <44175911.1010400@ce.jp.nec.com>
Date: Tue, 14 Mar 2006 19:00:17 -0500
From: "Jun'ichi Nomura" <j-nomura@ce.jp.nec.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <gregkh@suse.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kobject_uevent CONFIG_SYSFS=n build fix
References: <4416EB14.50306@ce.jp.nec.com> <20060314220130.GB12257@suse.de>
In-Reply-To: <20060314220130.GB12257@suse.de>
Content-Type: multipart/mixed;
 boundary="------------070600030704050600060503"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070600030704050600060503
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi Greg,

Greg KH wrote:
>> #if defined(CONFIG_HOTPLUG) && defined(CONFIG_NET)
>>+u64 uevent_seqnum;
>>+char uevent_helper[UEVENT_HELPER_PATH_LEN] = "/sbin/hotplug";
> 
> No, the seqnum and helper can be called even if we have not defined
> CONFIG_NET.  Please redo the patch based on this.

OK, thanks for the comment.
I thought it could be conditional on CONFIG_NET because
it's used only from kobject_uevent() except for
kernel/ksysfs.c which just exports them to sysfs.
Are there other users? Or do you mean we have to keep
sysfs files for user space?

Attached patch makes them conditional on CONFIG_HOTPLUG only.
Build tested with both (!CONFIG_NET && CONFIG_SYSFS) and
(CONFIG_NET && !CONFIG_SYSFS).
Does this look correct?

Thanks,
-- 
Jun'ichi Nomura, NEC Solutions (America), Inc.

--------------070600030704050600060503
Content-Type: text/x-patch;
 name="kobject_uevent-config_sysfs_n-build-fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="kobject_uevent-config_sysfs_n-build-fix.patch"

--- linux-2.6.16-rc6-mm1.orig/lib/kobject_uevent.c	2006-03-14 22:57:23.000000000 +0900
+++ linux-2.6.16-rc6-mm1/lib/kobject_uevent.c	2006-03-15 08:39:33.000000000 +0900
@@ -25,6 +25,11 @@
 #define BUFFER_SIZE	2048	/* buffer for the variables */
 #define NUM_ENVP	32	/* number of env pointers */
 
+#ifdef CONFIG_HOTPLUG
+u64 uevent_seqnum;
+char uevent_helper[UEVENT_HELPER_PATH_LEN] = "/sbin/hotplug";
+#endif
+
 #if defined(CONFIG_HOTPLUG) && defined(CONFIG_NET)
 static DEFINE_SPINLOCK(sequence_lock);
 static struct sock *uevent_sock;
--- linux-2.6.16-rc6-mm1.orig/kernel/ksysfs.c	2006-03-14 22:57:31.000000000 +0900
+++ linux-2.6.16-rc6-mm1/kernel/ksysfs.c	2006-03-15 08:41:11.000000000 +0900
@@ -15,9 +15,6 @@
 #include <linux/module.h>
 #include <linux/init.h>
 
-u64 uevent_seqnum;
-char uevent_helper[UEVENT_HELPER_PATH_LEN] = "/sbin/hotplug";
-
 #define KERNEL_ATTR_RO(_name) \
 static struct subsys_attribute _name##_attr = __ATTR_RO(_name)
 
--- linux-2.6.16-rc6-mm1.orig/include/linux/kobject.h	2006-03-15 00:00:20.000000000 +0900
+++ linux-2.6.16-rc6-mm1/include/linux/kobject.h	2006-03-15 08:38:45.000000000 +0900
@@ -27,6 +27,8 @@
 #include <asm/atomic.h>
 
 #define KOBJ_NAME_LEN			20
+
+#ifdef CONFIG_HOTPLUG
 #define UEVENT_HELPER_PATH_LEN		256
 
 /* path to the userspace helper executed on an event */
@@ -34,6 +36,7 @@ extern char uevent_helper[];
 
 /* counter to tag the uevent, read only except for the kobject core */
 extern u64 uevent_seqnum;
+#endif
 
 /* the actions here must match the proper string in lib/kobject_uevent.c */
 typedef int __bitwise kobject_action_t;

--------------070600030704050600060503--
