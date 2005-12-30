Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750927AbVL3V2m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750927AbVL3V2m (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Dec 2005 16:28:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751028AbVL3V2m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Dec 2005 16:28:42 -0500
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:18344 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1750925AbVL3V2l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Dec 2005 16:28:41 -0500
Subject: [PATCH] protect remove_proc_entry
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <1135973075.6039.63.camel@localhost.localdomain>
References: <1135973075.6039.63.camel@localhost.localdomain>
Content-Type: text/plain
Date: Fri, 30 Dec 2005 16:28:30 -0500
Message-Id: <1135978110.6039.81.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Working on a custom kernel that adds and removes proc entries quite a
bit, I discovered that remove_proc_entry is not protected against
multiple threads removing entries belonging to the same parent.  At
first I thought that this is only a problem with my changes, but after
inspecting the vanilla kernel, I see that there's several places that
calls remove_proc_entry with the same parent (most noticeably
/proc/drivers).

I've added a global remove_proc_lock to protect this section of code.  I
was going to add a lock to proc_dir_entry so that the locking is only
cut down to the same parent, but since this function is called so
infrequently, why waste more memory then is needed.  One global lock
should not cause too much of a headache here.

I'm not sure if remove_proc_entry is called from interrupt context, so I
did a irqsave just in case.

-- Steve


Index: linux-2.6.15-rc7/fs/proc/generic.c
===================================================================
--- linux-2.6.15-rc7.orig/fs/proc/generic.c	2005-12-30 14:19:39.000000000 -0500
+++ linux-2.6.15-rc7/fs/proc/generic.c	2005-12-30 16:18:42.000000000 -0500
@@ -19,6 +19,7 @@
 #include <linux/idr.h>
 #include <linux/namei.h>
 #include <linux/bitops.h>
+#include <linux/spinlock.h>
 #include <asm/uaccess.h>
 
 static ssize_t proc_file_read(struct file *file, char __user *buf,
@@ -27,6 +28,8 @@
 			       size_t count, loff_t *ppos);
 static loff_t proc_file_lseek(struct file *, loff_t, int);
 
+static DEFINE_SPINLOCK(remove_proc_lock);
+
 int proc_match(int len, const char *name, struct proc_dir_entry *de)
 {
 	if (de->namelen != len)
@@ -689,10 +692,13 @@
 	struct proc_dir_entry *de;
 	const char *fn = name;
 	int len;
+	unsigned long flags;
 
 	if (!parent && xlate_proc_name(name, &parent, &fn) != 0)
 		goto out;
 	len = strlen(fn);
+
+	spin_lock_irqsave(&remove_proc_lock, flags);
 	for (p = &parent->subdir; *p; p=&(*p)->next ) {
 		if (!proc_match(len, fn, *p))
 			continue;
@@ -713,6 +719,7 @@
 		}
 		break;
 	}
+	spin_unlock_irqrestore(&remove_proc_lock, flags);
 out:
 	return;
 }


