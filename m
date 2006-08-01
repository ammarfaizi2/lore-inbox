Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161009AbWHAOpG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161009AbWHAOpG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 10:45:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751344AbWHAOpF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 10:45:05 -0400
Received: from mx1.redhat.com ([66.187.233.31]:49116 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751343AbWHAOpD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 10:45:03 -0400
Message-ID: <44CF69F0.6040801@redhat.com>
Date: Tue, 01 Aug 2006 10:49:20 -0400
From: Amit Gud <agud@redhat.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060719)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [RFC] [PATCH] sysctl for the latecomers
Content-Type: multipart/mixed;
 boundary="------------040404050608010401060200"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040404050608010401060200
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

/etc/sysctl.conf values are of no use to kernel modules that are 
inserted after init scripts call sysctl for the values in /etc/sysctl.conf

For modules to use the values stored in the file /etc/sysctl.conf, 
sysctl kernel code can keep record of 'limited' values, for sysctl 
entries which haven't been registered yet. During registration, sysctl 
code can check against the stored values and call the appropriate 
strategy and proc_handler routines if a match is found.

Attached patch does just that. This patch is NOT tested and is just to 
get opinions, if something like this is a right way of addressing this 
problem.


Thanks,
AG
-- 
May the source be with you.
http://www.cis.ksu.edu/~gud


--------------040404050608010401060200
Content-Type: text/plain;
 name="sysctl-pending-values-v0.1.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sysctl-pending-values-v0.1.patch"

* Warning: This patch is a prototype and is NOT tested. *

Signed-off-by: Amit Gud <agud@redhat.com>
---

--- kernel/sysctl.c.orig	2006-07-20 16:56:09.000000000 -0400
+++ kernel/sysctl.c	2006-07-20 19:33:18.000000000 -0400
@@ -133,6 +133,9 @@ extern int no_unaligned_warning;
 
 static int parse_table(int __user *, int, void __user *, size_t __user *, void __user *, size_t,
 		       ctl_table *, void **);
+static void check_pending_values(ctl_table *);
+static void store_pending_val(int, void *, size_t);
+static void init_pending_value_table();
 static int proc_doutsstring(ctl_table *table, int write, struct file *filp,
 		  void __user *buffer, size_t *lenp, loff_t *ppos);
 
@@ -158,6 +161,23 @@ extern ctl_table inotify_table[];
 int sysctl_legacy_va_layout;
 #endif
 
+/* struct ctl_pending_values is used for temporarily storing data values
+   for the entries which are not found at the _sysctl(2) time. This is
+   useful for the modules which are required to use the values stored
+   in /etc/sysctl.conf. During regiter_sysctl_table() these ctl_names
+   are checked against the ctl_names that are being registered and
+   'strategy' and 'proc_handler' is called if previous entry is found. */
+#define NR_TEMP_VALUES 32       /* temporary storage for the data for unmatched ctl_names */
+
+struct ctl_pending_val_s {
+	int name;
+	void *data;
+	size_t len;
+} ctl_pending_values[NR_TEMP_VALUES];
+
+static int ctl_index = 0;
+spinlock_t ctl_pending_lock = SPIN_LOCK_UNLOCKED;
+
 /* /proc declarations: */
 
 #ifdef CONFIG_PROC_FS
@@ -1099,12 +1119,20 @@ static void start_unregistering(struct c
 	list_del_init(&p->ctl_entry);
 }
 
+static void init_pending_value_table()
+{
+	int i;
+	for(i = 0; i < NR_TEMP_VALUES; i++)
+		ctl_pending_values[i].name = 0;
+}
+
 void __init sysctl_init(void)
 {
 #ifdef CONFIG_PROC_FS
 	register_proc_table(root_table, proc_sys_root, &root_table_header);
 	init_irq_proc();
 #endif
+	init_pending_value_table();
 }
 
 int do_sysctl(int __user *name, int nlen, void __user *oldval, size_t __user *oldlenp,
@@ -1186,6 +1214,20 @@ static inline int ctl_perm(ctl_table *ta
 	return test_perm(table->mode, op);
 }
 
+static void store_pending_val(int n, void *newval, size_t newlen)
+{
+	spin_lock(&ctl_pending_lock);
+	kfree(ctl_pending_values[ctl_index].data);
+
+	ctl_pending_values[ctl_index].name = n;
+	ctl_pending_values[ctl_index].data = kmalloc(newlen, GFP_ATOMIC);
+	memcpy(ctl_pending_values[ctl_index].data, newval, newlen);
+	ctl_pending_values[ctl_index].len = newlen;
+
+	ctl_index = (++ctl_index % NR_TEMP_VALUES);
+	spin_unlock(&ctl_pending_lock);
+}
+
 static int parse_table(int __user *name, int nlen,
 		       void __user *oldval, size_t __user *oldlenp,
 		       void __user *newval, size_t newlen,
@@ -1222,9 +1264,26 @@ repeat:
 			return error;
 		}
 	}
+	store_pending_val(n, newval, newlen);
 	return -ENOTDIR;
 }
 
+static void check_pending_values(ctl_table *table)
+{
+	int i;
+	spin_lock(&ctl_pending_lock);
+	for(i = 0; i < NR_TEMP_VALUES; i++) {
+		int error;
+		void *context = NULL;
+		error = parse_table(&ctl_pending_values[i].name, 1, 0, 0, ctl_pending_values[i].data,
+					ctl_pending_values[i].len, table, &context);
+		kfree(context);
+		if(!error)
+			ctl_pending_values[i].name = 0;
+	}
+	spin_unlock(&ctl_pending_lock);
+}
+
 /* Perform the actual read/write of a sysctl table entry. */
 int do_sysctl_strategy (ctl_table *table, 
 			int __user *name, int nlen,
@@ -1365,6 +1424,7 @@ struct ctl_table_header *register_sysctl
 #ifdef CONFIG_PROC_FS
 	register_proc_table(table, proc_sys_root, tmp);
 #endif
+	check_pending_values(table);
 	return tmp;
 }
 

--------------040404050608010401060200--
