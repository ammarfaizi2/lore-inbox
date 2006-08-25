Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932371AbWHYJ0o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932371AbWHYJ0o (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 05:26:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932377AbWHYJ0o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 05:26:44 -0400
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:40941 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S932371AbWHYJ0m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 05:26:42 -0400
Date: Fri, 25 Aug 2006 18:29:43 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: ebiederm@xmission.com, kamezawa.hiroyu@jp.fujitsu.com,
       Andrew Morton <akpm@osdl.org>, saito.tadashi@soft.fujitsu.com,
       ak@suse.de
Subject: [RFC][PATCH] ps command race fix take 4 [4/4] proc root
 open/release/llseek
Message-Id: <20060825182943.697d9d81.kamezawa.hiroyu@jp.fujitsu.com>
Organization: Fujitsu
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

implements open/release/llseek ops are needed by new proc_pid_readdir()

llseek()'s offset is specified by 'bytes' but /proc root doesn't handle
file->f_pos as bytes. So I disabled llseek for /proc for now.

Signed-Off-By: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>

 fs/proc/root.c |   34 ++++++++++++++++++++++++++++++++++
 1 files changed, 34 insertions(+)

Index: linux-2.6.18-rc4/fs/proc/root.c
===================================================================
--- linux-2.6.18-rc4.orig/fs/proc/root.c
+++ linux-2.6.18-rc4/fs/proc/root.c
@@ -16,6 +16,7 @@
 #include <linux/module.h>
 #include <linux/bitops.h>
 #include <linux/smp_lock.h>
+#include <linux/adaptive_pointer.h>
 
 #include "internal.h"
 
@@ -118,14 +119,47 @@ static int proc_root_readdir(struct file
 	return ret;
 }
 
+static int proc_root_open(struct inode *inode, struct file *filp)
+{
+	struct adaptive_pointer *ap;
+	ap = kzalloc(sizeof(*ap), GFP_KERNEL);
+	init_adaptive_pointer(ap);
+	if (ap) {
+		filp->private_data = ap;
+		return 0;
+	}
+	return -ENOMEM;
+}
+
+static int proc_root_release(struct inode *inode, struct file *filp)
+{
+	struct adaptive_pointer *ap;
+	ap = filp->private_data;
+	rcu_read_lock();
+	__ap_get_remove_pointer(ap);
+	rcu_read_unlock();
+	kfree(ap);
+	filp->private_data = NULL;
+	return 0;
+}
+
+static loff_t proc_root_llseek(struct file *file, loff_t off, int pos)
+{
+	/* pos is bytes...but we don't use fp->f_pos as bytes... */
+	return -ENOTSUPP;
+}
+
 /*
  * The root /proc directory is special, as it has the
  * <pid> directories. Thus we don't use the generic
  * directory handling functions for that..
  */
 static struct file_operations proc_root_operations = {
+	.open		 = proc_root_open,
 	.read		 = generic_read_dir,
 	.readdir	 = proc_root_readdir,
+	.release	= proc_root_release,
+	.llseek		= proc_root_llseek,
 };
 
 /*

