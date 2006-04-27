Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965075AbWD0UUU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965075AbWD0UUU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 16:20:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964928AbWD0UUU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 16:20:20 -0400
Received: from mail.kroah.org ([69.55.234.183]:18583 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S965072AbWD0UUS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 16:20:18 -0400
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: Kay Sievers <kay.sievers@vrfy.org>, Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 2/5] Kobject: fix build error
Reply-To: Greg KH <greg@kroah.com>
Date: Thu, 27 Apr 2006 13:18:42 -0700
Message-Id: <11461691262921-git-send-email-greg@kroah.com>
X-Mailer: git-send-email 1.3.1
In-Reply-To: <11461691251083-git-send-email-greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kay Sievers <kay.sievers@vrfy.org>

This fixes a build error for various odd combinations of CONFIG_HOTPLUG
and CONFIG_NET.

Signed-off-by: Kay Sievers <kay.sievers@vrfy.org>
Cc: Nigel Cunningham <ncunningham@cyclades.com>
Cc: Andrew Morton <akpm@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---

 include/linux/kobject.h |    2 +-
 lib/kobject_uevent.c    |    8 +++++++-
 2 files changed, 8 insertions(+), 2 deletions(-)

4d17ffda331ba6030bb8c233c73d6a87954d8ea7
diff --git a/include/linux/kobject.h b/include/linux/kobject.h
index dcd0623..e38bb35 100644
--- a/include/linux/kobject.h
+++ b/include/linux/kobject.h
@@ -259,7 +259,7 @@ struct subsys_attribute {
 extern int subsys_create_file(struct subsystem * , struct subsys_attribute *);
 extern void subsys_remove_file(struct subsystem * , struct subsys_attribute *);
 
-#if defined(CONFIG_HOTPLUG) && defined(CONFIG_NET)
+#if defined(CONFIG_HOTPLUG)
 void kobject_uevent(struct kobject *kobj, enum kobject_action action);
 
 int add_uevent_var(char **envp, int num_envp, int *cur_index,
diff --git a/lib/kobject_uevent.c b/lib/kobject_uevent.c
index 982226d..7f20e7b 100644
--- a/lib/kobject_uevent.c
+++ b/lib/kobject_uevent.c
@@ -25,11 +25,13 @@ #include <net/sock.h>
 #define BUFFER_SIZE	2048	/* buffer for the variables */
 #define NUM_ENVP	32	/* number of env pointers */
 
-#if defined(CONFIG_HOTPLUG) && defined(CONFIG_NET)
+#if defined(CONFIG_HOTPLUG)
 u64 uevent_seqnum;
 char uevent_helper[UEVENT_HELPER_PATH_LEN] = "/sbin/hotplug";
 static DEFINE_SPINLOCK(sequence_lock);
+#if defined(CONFIG_NET)
 static struct sock *uevent_sock;
+#endif
 
 static char *action_to_string(enum kobject_action action)
 {
@@ -155,6 +157,7 @@ void kobject_uevent(struct kobject *kobj
 	spin_unlock(&sequence_lock);
 	sprintf(seq_buff, "SEQNUM=%llu", (unsigned long long)seq);
 
+#if defined(CONFIG_NET)
 	/* send netlink message */
 	if (uevent_sock) {
 		struct sk_buff *skb;
@@ -179,6 +182,7 @@ void kobject_uevent(struct kobject *kobj
 			netlink_broadcast(uevent_sock, skb, 0, 1, GFP_KERNEL);
 		}
 	}
+#endif
 
 	/* call uevent_helper, usually only enabled during early boot */
 	if (uevent_helper[0]) {
@@ -249,6 +253,7 @@ int add_uevent_var(char **envp, int num_
 }
 EXPORT_SYMBOL_GPL(add_uevent_var);
 
+#if defined(CONFIG_NET)
 static int __init kobject_uevent_init(void)
 {
 	uevent_sock = netlink_kernel_create(NETLINK_KOBJECT_UEVENT, 1, NULL,
@@ -264,5 +269,6 @@ static int __init kobject_uevent_init(vo
 }
 
 postcore_initcall(kobject_uevent_init);
+#endif
 
 #endif /* CONFIG_HOTPLUG */
-- 
1.3.1

