Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264271AbUFVPnF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264271AbUFVPnF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 11:43:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264923AbUFVPcl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 11:32:41 -0400
Received: from holomorphy.com ([207.189.100.168]:33923 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S264271AbUFVPQZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 11:16:25 -0400
To: linux-kernel@vger.kernel.org
From: William Lee Irwin III <wli@holomorphy.com>
Subject: [profile]: [1/23] move proc_profile_operations to profile.c
Message-ID: <0406220816.XaKbZa2a2aXa4a2aLbIb3aHbJbIbWaYa5a5aKb1a2aHbIb0aHb3a4aHb1a0aLbWa15250@holomorphy.com>
In-Reply-To: <0406220816.1a3aYaLbLbXaKbKb1aWa4a1a3a2a3aIb2a0aZaWaHb4aXaXaZa1aKbZaWa5aHb3a15250@holomorphy.com>
CC: rddunlap@osdl.org
Date: Tue, 22 Jun 2004 08:16:14 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Move proc_profile_operations into kernel/profile.c

Index: prof-2.6.7/fs/proc/proc_misc.c
===================================================================
--- prof-2.6.7.orig/fs/proc/proc_misc.c	2004-06-15 22:18:58.000000000 -0700
+++ prof-2.6.7/fs/proc/proc_misc.c	2004-06-22 07:25:43.255587320 -0700
@@ -555,70 +555,6 @@
 	return proc_calc_metrics(page, start, off, count, eof, len);
 }
 
-/*
- * This function accesses profiling information. The returned data is
- * binary: the sampling step and the actual contents of the profile
- * buffer. Use of the program readprofile is recommended in order to
- * get meaningful info out of these data.
- */
-static ssize_t
-read_profile(struct file *file, char __user *buf, size_t count, loff_t *ppos)
-{
-	unsigned long p = *ppos;
-	ssize_t read;
-	char * pnt;
-	unsigned int sample_step = 1 << prof_shift;
-
-	if (p >= (prof_len+1)*sizeof(unsigned int))
-		return 0;
-	if (count > (prof_len+1)*sizeof(unsigned int) - p)
-		count = (prof_len+1)*sizeof(unsigned int) - p;
-	read = 0;
-
-	while (p < sizeof(unsigned int) && count > 0) {
-		put_user(*((char *)(&sample_step)+p),buf);
-		buf++; p++; count--; read++;
-	}
-	pnt = (char *)prof_buffer + p - sizeof(unsigned int);
-	if (copy_to_user(buf,(void *)pnt,count))
-		return -EFAULT;
-	read += count;
-	*ppos += read;
-	return read;
-}
-
-/*
- * Writing to /proc/profile resets the counters
- *
- * Writing a 'profiling multiplier' value into it also re-sets the profiling
- * interrupt frequency, on architectures that support this.
- */
-static ssize_t write_profile(struct file *file, const char __user *buf,
-			     size_t count, loff_t *ppos)
-{
-#ifdef CONFIG_SMP
-	extern int setup_profiling_timer (unsigned int multiplier);
-
-	if (count == sizeof(int)) {
-		unsigned int multiplier;
-
-		if (copy_from_user(&multiplier, buf, sizeof(int)))
-			return -EFAULT;
-
-		if (setup_profiling_timer(multiplier))
-			return -EINVAL;
-	}
-#endif
-
-	memset(prof_buffer, 0, prof_len * sizeof(*prof_buffer));
-	return count;
-}
-
-static struct file_operations proc_profile_operations = {
-	.read		= read_profile,
-	.write		= write_profile,
-};
-
 #ifdef CONFIG_MAGIC_SYSRQ
 /*
  * writing 'C' to /proc/sysrq-trigger is like sysrq-C
@@ -706,13 +642,7 @@
 				(size_t)high_memory - PAGE_OFFSET + PAGE_SIZE;
 	}
 #endif
-	if (prof_on) {
-		entry = create_proc_entry("profile", S_IWUSR | S_IRUGO, NULL);
-		if (entry) {
-			entry->proc_fops = &proc_profile_operations;
-			entry->size = (1+prof_len) * sizeof(unsigned int);
-		}
-	}
+	create_proc_profile();
 #ifdef CONFIG_MAGIC_SYSRQ
 	entry = create_proc_entry("sysrq-trigger", S_IWUSR, NULL);
 	if (entry)
Index: prof-2.6.7/kernel/profile.c
===================================================================
--- prof-2.6.7.orig/kernel/profile.c	2004-06-15 22:20:04.000000000 -0700
+++ prof-2.6.7/kernel/profile.c	2004-06-22 07:25:43.258586864 -0700
@@ -155,3 +155,82 @@
 
 EXPORT_SYMBOL_GPL(profile_event_register);
 EXPORT_SYMBOL_GPL(profile_event_unregister);
+
+#ifdef CONFIG_PROC_FS
+/*
+ * This function accesses profiling information. The returned data is
+ * binary: the sampling step and the actual contents of the profile
+ * buffer. Use of the program readprofile is recommended in order to
+ * get meaningful info out of these data.
+ */
+static ssize_t
+read_profile(struct file *file, char __user *buf, size_t count, loff_t *ppos)
+{
+	unsigned long p = *ppos;
+	ssize_t read;
+	char * pnt;
+	unsigned int sample_step = 1 << prof_shift;
+
+	if (p >= (prof_len+1)*sizeof(unsigned int))
+		return 0;
+	if (count > (prof_len+1)*sizeof(unsigned int) - p)
+		count = (prof_len+1)*sizeof(unsigned int) - p;
+	read = 0;
+
+	while (p < sizeof(unsigned int) && count > 0) {
+		put_user(*((char *)(&sample_step)+p),buf);
+		buf++; p++; count--; read++;
+	}
+	pnt = (char *)prof_buffer + p - sizeof(unsigned int);
+	if (copy_to_user(buf,(void *)pnt,count))
+		return -EFAULT;
+	read += count;
+	*ppos += read;
+	return read;
+}
+
+/*
+ * Writing to /proc/profile resets the counters
+ *
+ * Writing a 'profiling multiplier' value into it also re-sets the profiling
+ * interrupt frequency, on architectures that support this.
+ */
+static ssize_t write_profile(struct file *file, const char __user *buf,
+			     size_t count, loff_t *ppos)
+{
+#ifdef CONFIG_SMP
+	extern int setup_profiling_timer (unsigned int multiplier);
+
+	if (count == sizeof(int)) {
+		unsigned int multiplier;
+
+		if (copy_from_user(&multiplier, buf, sizeof(int)))
+			return -EFAULT;
+
+		if (setup_profiling_timer(multiplier))
+			return -EINVAL;
+	}
+#endif
+
+	memset(prof_buffer, 0, prof_len * sizeof(*prof_buffer));
+	return count;
+}
+
+static struct file_operations proc_profile_operations = {
+	.read		= read_profile,
+	.write		= write_profile,
+};
+
+void create_proc_profile(void)
+{
+	struct proc_dir_entry *entry;
+
+	if (!prof_on)
+		return;
+	entry = create_proc_entry("profile", S_IWUSR | S_IRUGO, NULL);
+	if (!entry)
+		return;
+	entry->proc_fops = &proc_profile_operations;
+	entry->size = (1+prof_len) * sizeof(unsigned int);
+}
+#endif /* CONFIG_PROC_FS */
Index: prof-2.6.7/include/linux/profile.h
===================================================================
--- prof-2.6.7.orig/include/linux/profile.h	2004-06-15 22:19:22.000000000 -0700
+++ prof-2.6.7/include/linux/profile.h	2004-06-22 07:25:43.260586560 -0700
@@ -13,6 +13,7 @@
 
 /* init basic kernel profiler */
 void __init profile_init(void);
+void create_proc_profile(void);
 
 extern unsigned int * prof_buffer;
 extern unsigned long prof_len;
