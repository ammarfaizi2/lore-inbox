Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261451AbVAaXsA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261451AbVAaXsA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 18:48:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261464AbVAaXqx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 18:46:53 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:62725 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261452AbVAaXmE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 18:42:04 -0500
Date: Tue, 1 Feb 2005 00:42:02 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] kernel/sysctl.c: misc cleanups
Message-ID: <20050131234202.GJ21437@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes some needlessly global code static and removes the 
unneeded EXPORT_SYMBOL(proc_doulonglongvec_minmax).

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 include/linux/sysctl.h |    7 --
 kernel/sysctl.c        |   96 ++++++++++++++++++++---------------------
 2 files changed, 49 insertions(+), 54 deletions(-)

This patch was already sent on:
- 12 Dec 2004

--- linux-2.6.10-rc2-mm4-full/include/linux/sysctl.h.old	2004-12-12 03:19:59.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/include/linux/sysctl.h	2004-12-12 03:21:40.000000000 +0100
@@ -787,8 +787,6 @@
 			 void __user *, size_t *, loff_t *);
 extern int proc_dointvec(ctl_table *, int, struct file *,
 			 void __user *, size_t *, loff_t *);
-extern int proc_dointvec_bset(ctl_table *, int, struct file *,
-			      void __user *, size_t *, loff_t *);
 extern int proc_dointvec_minmax(ctl_table *, int, struct file *,
 				void __user *, size_t *, loff_t *);
 extern int proc_dointvec_jiffies(ctl_table *, int, struct file *,
@@ -806,11 +804,6 @@
 		      void __user *oldval, size_t __user *oldlenp,
 		      void __user *newval, size_t newlen);
 
-extern int do_sysctl_strategy (ctl_table *table, 
-			       int __user *name, int nlen,
-			       void __user *oldval, size_t __user *oldlenp,
-			       void __user *newval, size_t newlen, void ** context);
-
 extern ctl_handler sysctl_string;
 extern ctl_handler sysctl_intvec;
 extern ctl_handler sysctl_jiffies;
--- linux-2.6.10-rc2-mm4-full/kernel/sysctl.c.old	2004-12-12 03:20:14.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/kernel/sysctl.c	2004-12-12 03:24:58.000000000 +0100
@@ -157,8 +157,10 @@
 static ssize_t proc_readsys(struct file *, char __user *, size_t, loff_t *);
 static ssize_t proc_writesys(struct file *, const char __user *, size_t, loff_t *);
 static int proc_opensys(struct inode *, struct file *);
+static int proc_dointvec_bset(ctl_table *table, int write, struct file *filp,
+			      void __user *buffer, size_t *lenp, loff_t *ppos);
 
-struct file_operations proc_sys_file_operations = {
+static struct file_operations proc_sys_file_operations = {
 	.open		= proc_opensys,
 	.read		= proc_readsys,
 	.write		= proc_writesys,
@@ -1030,50 +1032,12 @@
 	return test_perm(table->mode, op);
 }
 
-static int parse_table(int __user *name, int nlen,
-		       void __user *oldval, size_t __user *oldlenp,
-		       void __user *newval, size_t newlen,
-		       ctl_table *table, void **context)
-{
-	int n;
-repeat:
-	if (!nlen)
-		return -ENOTDIR;
-	if (get_user(n, name))
-		return -EFAULT;
-	for ( ; table->ctl_name; table++) {
-		if (n == table->ctl_name || table->ctl_name == CTL_ANY) {
-			int error;
-			if (table->child) {
-				if (ctl_perm(table, 001))
-					return -EPERM;
-				if (table->strategy) {
-					error = table->strategy(
-						table, name, nlen,
-						oldval, oldlenp,
-						newval, newlen, context);
-					if (error)
-						return error;
-				}
-				name++;
-				nlen--;
-				table = table->child;
-				goto repeat;
-			}
-			error = do_sysctl_strategy(table, name, nlen,
-						   oldval, oldlenp,
-						   newval, newlen, context);
-			return error;
-		}
-	}
-	return -ENOTDIR;
-}
-
 /* Perform the actual read/write of a sysctl table entry. */
-int do_sysctl_strategy (ctl_table *table, 
-			int __user *name, int nlen,
-			void __user *oldval, size_t __user *oldlenp,
-			void __user *newval, size_t newlen, void **context)
+static int do_sysctl_strategy (ctl_table *table, 
+			       int __user *name, int nlen,
+			       void __user *oldval, size_t __user *oldlenp,
+			       void __user *newval, size_t newlen,
+			       void **context)
 {
 	int op = 0, rc;
 	size_t len;
@@ -1120,6 +1084,45 @@
 	return 0;
 }
 
+static int parse_table(int __user *name, int nlen,
+		       void __user *oldval, size_t __user *oldlenp,
+		       void __user *newval, size_t newlen,
+		       ctl_table *table, void **context)
+{
+	int n;
+repeat:
+	if (!nlen)
+		return -ENOTDIR;
+	if (get_user(n, name))
+		return -EFAULT;
+	for ( ; table->ctl_name; table++) {
+		if (n == table->ctl_name || table->ctl_name == CTL_ANY) {
+			int error;
+			if (table->child) {
+				if (ctl_perm(table, 001))
+					return -EPERM;
+				if (table->strategy) {
+					error = table->strategy(
+						table, name, nlen,
+						oldval, oldlenp,
+						newval, newlen, context);
+					if (error)
+						return error;
+				}
+				name++;
+				nlen--;
+				table = table->child;
+				goto repeat;
+			}
+			error = do_sysctl_strategy(table, name, nlen,
+						   oldval, oldlenp,
+						   newval, newlen, context);
+			return error;
+		}
+	}
+	return -ENOTDIR;
+}
+
 /**
  * register_sysctl_table - register a sysctl hierarchy
  * @table: the top-level table structure
@@ -1637,8 +1640,8 @@
  *	init may raise the set.
  */
  
-int proc_dointvec_bset(ctl_table *table, int write, struct file *filp,
-			void __user *buffer, size_t *lenp, loff_t *ppos)
+static int proc_dointvec_bset(ctl_table *table, int write, struct file *filp,
+			      void __user *buffer, size_t *lenp, loff_t *ppos)
 {
 	int op;
 
@@ -2349,7 +2352,6 @@
 EXPORT_SYMBOL(proc_dointvec_userhz_jiffies);
 EXPORT_SYMBOL(proc_dostring);
 EXPORT_SYMBOL(proc_doulongvec_minmax);
-EXPORT_SYMBOL(proc_doulonglongvec_minmax);
 EXPORT_SYMBOL(proc_doulongvec_ms_jiffies_minmax);
 EXPORT_SYMBOL(register_sysctl_table);
 EXPORT_SYMBOL(sysctl_intvec);

