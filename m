Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262063AbVCTKRf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262063AbVCTKRf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Mar 2005 05:17:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262107AbVCTKQb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Mar 2005 05:16:31 -0500
Received: from neapel230.server4you.de ([217.172.187.230]:35759 "EHLO
	neapel230.server4you.de") by vger.kernel.org with ESMTP
	id S262077AbVCTKOo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Mar 2005 05:14:44 -0500
Subject: [PATCH][1/5] Introduce proc_domode
In-Reply-To: <1111278162.22BA.5209@neapel230.server4you.de>
Date: Sun, 20 Mar 2005 11:14:43 +0100
Message-Id: <1111313683.EA21f.17773@neapel230.server4you.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[The patches seem to not have made it to the list the first time,
I'm retrying without CC:s.]

Add a new sysctl proc handler , proc_domode.  It can be used to implement
sysctls for setting and/or displaying file mode or file mask values.

diff -pur l1/include/linux/sysctl.h l2/include/linux/sysctl.h
--- l1/include/linux/sysctl.h	2005-03-19 01:28:48.000000000 +0100
+++ l2/include/linux/sysctl.h	2005-03-19 08:08:43.000000000 +0100
@@ -812,6 +812,8 @@ extern int proc_doulonglongvec_minmax(ct
 				  void __user *, size_t *, loff_t *);
 extern int proc_doulongvec_ms_jiffies_minmax(ctl_table *table, int,
 				      struct file *, void __user *, size_t *, loff_t *);
+extern int proc_domode(ctl_table *, int, struct file *,
+                       void __user *, size_t *, loff_t *);
 
 extern int do_sysctl (int __user *name, int nlen,
 		      void __user *oldval, size_t __user *oldlenp,
diff -pur l1/kernel/sysctl.c l2/kernel/sysctl.c
--- l1/kernel/sysctl.c	2005-03-19 01:28:49.000000000 +0100
+++ l2/kernel/sysctl.c	2005-03-19 08:16:41.000000000 +0100
@@ -2120,6 +2120,81 @@ int proc_dointvec_ms_jiffies(ctl_table *
 				do_proc_dointvec_ms_jiffies_conv, NULL);
 }
 
+/**
+ * proc_domode - read a file mode value
+ * @table: the sysctl table
+ * @write: %TRUE if this is a write to the sysctl file
+ * @filp: the file structure
+ * @buffer: the user buffer
+ * @lenp: the size of the user buffer
+ * @ppos: file position
+ *
+ * Reads/writes one file mode value (data type mode_t) 
+ * from/to the user buffer, treated as an ASCII string. 
+ * Optionally checks that the value fits within the mask
+ * specified with *table->extra1.  That mask cannot be
+ * bigger than 07777.
+ *
+ * Returns 0 on success.
+ */
+int proc_domode(ctl_table *table, int write, struct file *filp,
+		void __user *buffer, size_t *lenp, loff_t *ppos)
+{
+#define TMPBUFLEN	6
+#define MAXMODE		07777
+	size_t len;
+	char __user *p;
+	char c;
+	char buf[TMPBUFLEN];
+	char *endp;
+	mode_t maxmask = MAXMODE;
+	unsigned long mode;
+	
+	if (!table->data || !*lenp || (*ppos && !write)) {
+		*lenp = 0;
+		return 0;
+	}
+	
+	if (write) {
+		if (table->extra1)
+			maxmask &= *((mode_t *)table->extra1);
+		len = 0;
+		p = buffer;
+		while (len < *lenp) {
+			if (get_user(c, p++))
+				return -EFAULT;
+			if (c == 0 || c == '\n')
+				break;
+			len++;
+		}
+		if (len > TMPBUFLEN)
+			return -EINVAL;
+		if (copy_from_user(buf, buffer, len))
+			return -EFAULT;
+		buf[len] = '\0';
+		mode = simple_strtoul(buf, &endp, 0);
+		if (mode & ~maxmask)
+			return -EPERM;
+		*((mode_t *)table->data) = mode;
+		*ppos += *lenp;
+	} else {
+		if (*((mode_t *)table->data) > MAXMODE)
+			return -EINVAL;
+		mode = *((mode_t *)table->data);
+		len = sprintf(buf, "0%03o\n", (mode_t)mode);
+		if (len > *lenp)
+			len = *lenp;
+		if (len)
+			if (copy_to_user(buffer, buf, len))
+				return -EFAULT;
+		*lenp = len;
+		*ppos += len;
+	}
+	return 0;
+#undef TMPBUFLEN
+#undef MAXMODE
+}
+
 #else /* CONFIG_PROC_FS */
 
 int proc_dostring(ctl_table *table, int write, struct file *filp,
@@ -2191,6 +2266,12 @@ int proc_doulongvec_ms_jiffies_minmax(ct
     return -ENOSYS;
 }
 
+int proc_domode(ctl_table *table, int write, struct file *filp,
+		void __user *buffer, size_t *lenp, loff_t *ppos)
+{
+	return -ENOSYS;
+}
+
 
 #endif /* CONFIG_PROC_FS */
 
@@ -2432,6 +2513,12 @@ int proc_doulongvec_ms_jiffies_minmax(ct
     return -ENOSYS;
 }
 
+int proc_domode(ctl_table *table, int write, struct file *filp,
+		void __user *buffer, size_t *lenp, loff_t *ppos)
+{
+	return -ENOSYS;
+}
+
 struct ctl_table_header * register_sysctl_table(ctl_table * table, 
 						int insert_at_head)
 {
@@ -2453,6 +2540,7 @@ EXPORT_SYMBOL(proc_dointvec_jiffies);
 EXPORT_SYMBOL(proc_dointvec_minmax);
 EXPORT_SYMBOL(proc_dointvec_userhz_jiffies);
 EXPORT_SYMBOL(proc_dointvec_ms_jiffies);
+EXPORT_SYMBOL(proc_domode);
 EXPORT_SYMBOL(proc_dostring);
 EXPORT_SYMBOL(proc_doulongvec_minmax);
 EXPORT_SYMBOL(proc_doulonglongvec_minmax);

