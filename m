Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269357AbUJWD2a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269357AbUJWD2a (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 23:28:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268278AbUJVXRZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 19:17:25 -0400
Received: from mail.kroah.org ([69.55.234.183]:18595 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S268265AbUJVXKQ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 19:10:16 -0400
X-Donotread: and you are reading this why?
Subject: Re: [PATCH] Driver Core patches for 2.6.10-rc1
In-Reply-To: <10984865713952@kroah.com>
X-Patch: quite boring stuff, it's just source code...
Date: Fri, 22 Oct 2004 16:09:31 -0700
Message-Id: <10984865712455@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2020, 2004/10/22 14:29:19-07:00, akpm@osdl.org

[PATCH] kobject_hotplug: permit no hotplug_ops

Make kobject_hotplug() work even if the kobject's kset doesn't implement any
hotplug_ops.

Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 lib/kobject_uevent.c |   19 ++++++++++++-------
 1 files changed, 12 insertions(+), 7 deletions(-)


diff -Nru a/lib/kobject_uevent.c b/lib/kobject_uevent.c
--- a/lib/kobject_uevent.c	2004-10-22 16:00:04 -07:00
+++ b/lib/kobject_uevent.c	2004-10-22 16:00:04 -07:00
@@ -187,6 +187,8 @@
 	u64 seq;
 	struct kobject *top_kobj = kobj;
 	struct kset *kset;
+	static struct kset_hotplug_ops null_hotplug_ops;
+	struct kset_hotplug_ops *hotplug_ops = &null_hotplug_ops;
 
 	if (!top_kobj->kset && top_kobj->parent) {
 		do {
@@ -194,15 +196,18 @@
 		} while (!top_kobj->kset && top_kobj->parent);
 	}
 
-	if (top_kobj->kset && top_kobj->kset->hotplug_ops)
+	if (top_kobj->kset)
 		kset = top_kobj->kset;
 	else
 		return;
 
+	if (kset->hotplug_ops)
+		hotplug_ops = kset->hotplug_ops;
+
 	/* If the kset has a filter operation, call it.
 	   Skip the event, if the filter returns zero. */
-	if (kset->hotplug_ops->filter) {
-		if (!kset->hotplug_ops->filter(kset, kobj))
+	if (hotplug_ops->filter) {
+		if (!hotplug_ops->filter(kset, kobj))
 			return;
 	}
 
@@ -221,8 +226,8 @@
 	if (!buffer)
 		goto exit;
 
-	if (kset->hotplug_ops->name)
-		name = kset->hotplug_ops->name(kset, kobj);
+	if (hotplug_ops->name)
+		name = hotplug_ops->name(kset, kobj);
 	if (name == NULL)
 		name = kset->kobj.name;
 
@@ -256,9 +261,9 @@
 	envp [i++] = scratch;
 	scratch += sprintf(scratch, "SUBSYSTEM=%s", name) + 1;
 
-	if (kset->hotplug_ops->hotplug) {
+	if (hotplug_ops->hotplug) {
 		/* have the kset specific function add its stuff */
-		retval = kset->hotplug_ops->hotplug (kset, kobj,
+		retval = hotplug_ops->hotplug (kset, kobj,
 				  &envp[i], NUM_ENVP - i, scratch,
 				  BUFFER_SIZE - (scratch - buffer));
 		if (retval) {

