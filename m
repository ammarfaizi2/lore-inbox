Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750980AbWAEA5l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750980AbWAEA5l (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 19:57:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750974AbWAEAu0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 19:50:26 -0500
Received: from mail.kroah.org ([69.55.234.183]:2490 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1750988AbWAEAt4 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 19:49:56 -0500
Cc: kay.sievers@suse.de
Subject: [PATCH] add uevent_helper control in /sys/kernel/
In-Reply-To: <11364221691605@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 4 Jan 2006 16:49:29 -0800
Message-Id: <1136422169486@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] add uevent_helper control in /sys/kernel/

This deprecates the /proc/sys/kernel/hotplug file, as all
this stuff should be in /sys some day, right? :)
In /sys/kernel/ we have now uevent_seqnum and uevent_helper.
The seqnum is no longer used by udev, as the version for this
kernel depends on netlink which events will never get
out-of-order.

Recent udev versions disable the /sbin/hotplug helper with
an init script, cause it leads to OOM on big boxes by running
hundreds of shells in parallel. It should be done now by:
  echo "" > /sys/kernel/uevent_helper

(Note that "-n" does not work, cause neighter proc nor sysfs
support truncate().)

Signed-off-by: Kay Sievers <kay.sievers@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 0f76e5acf9dc788e664056dda1e461f0bec93948
tree fdb7db438cb03fb3e0508d582a7cc1321c62efed
parent 0296b2281352e4794e174b393c37f131502e09f0
author Kay Sievers <kay.sievers@suse.de> Fri, 11 Nov 2005 04:58:04 +0100
committer Greg Kroah-Hartman <gregkh@suse.de> Wed, 04 Jan 2006 16:18:07 -0800

 kernel/ksysfs.c |   25 ++++++++++++++++++++++---
 1 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/kernel/ksysfs.c b/kernel/ksysfs.c
index 015fb69..e975a76 100644
--- a/kernel/ksysfs.c
+++ b/kernel/ksysfs.c
@@ -23,11 +23,29 @@ static struct subsys_attribute _name##_a
 	__ATTR(_name, 0644, _name##_show, _name##_store)
 
 #ifdef CONFIG_HOTPLUG
-static ssize_t hotplug_seqnum_show(struct subsystem *subsys, char *page)
+/* current uevent sequence number */
+static ssize_t uevent_seqnum_show(struct subsystem *subsys, char *page)
 {
 	return sprintf(page, "%llu\n", (unsigned long long)hotplug_seqnum);
 }
-KERNEL_ATTR_RO(hotplug_seqnum);
+KERNEL_ATTR_RO(uevent_seqnum);
+
+/* uevent helper program, used during early boo */
+static ssize_t uevent_helper_show(struct subsystem *subsys, char *page)
+{
+	return sprintf(page, "%s\n", hotplug_path);
+}
+static ssize_t uevent_helper_store(struct subsystem *subsys, const char *page, size_t count)
+{
+	if (count+1 > HOTPLUG_PATH_LEN)
+		return -ENOENT;
+	memcpy(hotplug_path, page, count);
+	hotplug_path[count] = '\0';
+	if (count && hotplug_path[count-1] == '\n')
+		hotplug_path[count-1] = '\0';
+	return count;
+}
+KERNEL_ATTR_RW(uevent_helper);
 #endif
 
 #ifdef CONFIG_KEXEC
@@ -45,7 +63,8 @@ EXPORT_SYMBOL_GPL(kernel_subsys);
 
 static struct attribute * kernel_attrs[] = {
 #ifdef CONFIG_HOTPLUG
-	&hotplug_seqnum_attr.attr,
+	&uevent_seqnum_attr.attr,
+	&uevent_helper_attr.attr,
 #endif
 #ifdef CONFIG_KEXEC
 	&crash_notes_attr.attr,

