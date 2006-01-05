Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751082AbWAEA7r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751082AbWAEA7r (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 19:59:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750993AbWAEAuR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 19:50:17 -0500
Received: from mail.kroah.org ([69.55.234.183]:3002 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1750990AbWAEAt4 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 19:49:56 -0500
Cc: akpm@osdl.org
Subject: [PATCH] kobject_uevent CONFIG_NET=n fix
In-Reply-To: <11364221703195@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 4 Jan 2006 16:49:30 -0800
Message-Id: <11364221702087@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] kobject_uevent CONFIG_NET=n fix

lib/lib.a(kobject_uevent.o)(.text+0x25f): In function `kobject_uevent':
: undefined reference to `__alloc_skb'
lib/lib.a(kobject_uevent.o)(.text+0x2a1): In function `kobject_uevent':
: undefined reference to `skb_over_panic'
lib/lib.a(kobject_uevent.o)(.text+0x31d): In function `kobject_uevent':
: undefined reference to `skb_over_panic'
lib/lib.a(kobject_uevent.o)(.text+0x356): In function `kobject_uevent':
: undefined reference to `netlink_broadcast'
lib/lib.a(kobject_uevent.o)(.init.text+0x9): In function `kobject_uevent_init':
: undefined reference to `netlink_kernel_create'
make: *** [.tmp_vmlinux1] Error 1

Netlink is unconditionally enabled if CONFIG_NET, so that's OK.

kobject_uevent.o is compiled even if !CONFIG_HOTPLUG, which is lazy.

Let's compound the sin.

Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit f743ca5e10f4145e0b3e6d11b9b46171e16af7ce
tree e21e900b2400d66a6da37492951e80c6f4cf4230
parent d960bb4db9f422b5c3c82e0dfd6c8213a4fc430d
author akpm@osdl.org <akpm@osdl.org> Tue, 22 Nov 2005 23:36:13 -0800
committer Greg Kroah-Hartman <gregkh@suse.de> Wed, 04 Jan 2006 16:18:08 -0800

 include/linux/kobject.h |    2 +-
 kernel/ksysfs.c         |    3 +++
 lib/kobject_uevent.c    |    4 +---
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/include/linux/kobject.h b/include/linux/kobject.h
index 8eb21f2..2a8d8da 100644
--- a/include/linux/kobject.h
+++ b/include/linux/kobject.h
@@ -253,7 +253,7 @@ struct subsys_attribute {
 extern int subsys_create_file(struct subsystem * , struct subsys_attribute *);
 extern void subsys_remove_file(struct subsystem * , struct subsys_attribute *);
 
-#ifdef CONFIG_HOTPLUG
+#if defined(CONFIG_HOTPLUG) & defined(CONFIG_NET)
 void kobject_uevent(struct kobject *kobj, enum kobject_action action);
 
 int add_uevent_var(char **envp, int num_envp, int *cur_index,
diff --git a/kernel/ksysfs.c b/kernel/ksysfs.c
index bfb4a7a..99af8b0 100644
--- a/kernel/ksysfs.c
+++ b/kernel/ksysfs.c
@@ -15,6 +15,9 @@
 #include <linux/module.h>
 #include <linux/init.h>
 
+u64 uevent_seqnum;
+char uevent_helper[UEVENT_HELPER_PATH_LEN] = "/sbin/hotplug";
+
 #define KERNEL_ATTR_RO(_name) \
 static struct subsys_attribute _name##_attr = __ATTR_RO(_name)
 
diff --git a/lib/kobject_uevent.c b/lib/kobject_uevent.c
index 01479e5..f56e27a 100644
--- a/lib/kobject_uevent.c
+++ b/lib/kobject_uevent.c
@@ -25,9 +25,7 @@
 #define BUFFER_SIZE	1024	/* buffer for the variables */
 #define NUM_ENVP	32	/* number of env pointers */
 
-#if defined(CONFIG_HOTPLUG)
-char uevent_helper[UEVENT_HELPER_PATH_LEN] = "/sbin/hotplug";
-u64 uevent_seqnum;
+#if defined(CONFIG_HOTPLUG) && defined(CONFIG_NET)
 static DEFINE_SPINLOCK(sequence_lock);
 static struct sock *uevent_sock;
 

