Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317597AbSGVRQI>; Mon, 22 Jul 2002 13:16:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317705AbSGVRQI>; Mon, 22 Jul 2002 13:16:08 -0400
Received: from penguin.cohaesio.net ([212.97.129.34]:46281 "EHLO
	mail.cohaesio.net") by vger.kernel.org with ESMTP
	id <S317597AbSGVRQD>; Mon, 22 Jul 2002 13:16:03 -0400
Subject: [PATCH] core file names
From: Jes Rahbek Klinke <jrk@evalesco.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 22 Jul 2002 19:19:11 +0200
Message-Id: <1027358351.12656.24.camel@albatros>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch agains linux-2.4.18 will allow you to configure the way core
files are named through the /proc filesystem.

You can specify patterns, e.g. "core.%p" to get pid appended, "%e.core"
to get the name of the executable, or "/var/core/core.%h" to get all yor
core files in /var/core and have the hostname appended.

I think this patch is useful, because we are developing a cluster
application. It happens that multiple nodes crash simultineously, and
dump core, but as we use NFS these dumps ends up overwriting each other
if they are all just named "core".

I have tested this patch on two systems, trying many different patterns
that will expand to strings longer than the buffer, but have not seen
any bugs.

	Jes Rahbek Klinke

diff -urN -X dontdiff linux/fs/exec.c linux-corename/fs/exec.c
--- linux/fs/exec.c	Fri Dec 21 18:41:55 2001
+++ linux-corename/fs/exec.c	Mon Jul 22 18:44:18 2002
@@ -20,6 +20,9 @@
  * table to check for several different types  of binary formats.  We keep
  * trying until we recognize the file or we run out of supported binary
  * formats. 
+ *
+ * Added option of specifying format of core file name July 22. 2002
+ * by Jes Rahbek Klinke, jrk@evalesco.com, www.evalesco.com
  */
 
 #include <linux/config.h>
@@ -35,6 +38,7 @@
 #include <linux/highmem.h>
 #include <linux/spinlock.h>
 #include <linux/personality.h>
+#include <linux/utsname.h>
 #define __NO_VERSION__
 #include <linux/module.h>
 
@@ -47,6 +51,8 @@
 #endif
 
 int core_uses_pid;
+char core_pattern[65] = "core";
+/* The maximal length of core_pattern is also specified in sysctl.c */ 
 
 static struct linux_binfmt *formats;
 static rwlock_t binfmt_lock = RW_LOCK_UNLOCKED;
@@ -933,10 +939,126 @@
 		__MOD_DEC_USE_COUNT(old->module);
 }
 
+#define CORENAME_MAX_SIZE 64
+
+/* format_corename will inspect the pattern parameter, and output a
+ * name into corename, which must have space for at least
+ * CORENAME_MAX_SIZE bytes plus one byte for the zero terminator.
+ */
+void format_corename(char *corename, const char *pattern, long signr)
+{
+	const char *pat_ptr = pattern;
+	char *out_ptr = corename;
+	char *const out_end = corename + CORENAME_MAX_SIZE;
+	int rc;
+	int pid_in_pattern = 0;
+
+	/* Repeat as long as we have more pattern to process and more output
+	   space */
+	while (*pat_ptr) {
+		if (*pat_ptr != '%') {
+			if (out_ptr == out_end)
+				goto out;
+			*out_ptr++ = *pat_ptr++;
+		} else {
+			switch (*++pat_ptr) {
+			case 0:
+				goto out;
+			/* Double percent, output one percent */
+			case '%':
+				if (out_ptr == out_end)
+					goto out;
+				*out_ptr++ = '%';
+				break;
+			/* pid */
+			case 'p':
+				pid_in_pattern = 1;
+				rc = snprintf(out_ptr, out_end - out_ptr,
+					      "%d", current->pid);
+				if (rc > out_end - out_ptr)
+					goto out;
+				out_ptr += rc;
+				break;
+			/* uid */
+			case 'u':
+				rc = snprintf(out_ptr, out_end - out_ptr,
+					      "%d", current->uid);
+				if (rc > out_end - out_ptr)
+					goto out;
+				out_ptr += rc;
+				break;
+			/* gid */
+			case 'g':
+				rc = snprintf(out_ptr, out_end - out_ptr,
+					      "%d", current->gid);
+				if (rc > out_end - out_ptr)
+					goto out;
+				out_ptr += rc;
+				break;
+			/* signal that caused the coredump */
+			case 's':
+				rc = snprintf(out_ptr, out_end - out_ptr,
+					      "%ld", signr);
+				if (rc > out_end - out_ptr)
+					goto out;
+				out_ptr += rc;
+				break;
+			/* UNIX time of coredump */
+			case 't': {
+				struct timeval tv;
+				do_gettimeofday(&tv);
+				rc = snprintf(out_ptr, out_end - out_ptr,
+					      "%d", tv.tv_sec);
+				if (rc > out_end - out_ptr)
+					goto out;
+				out_ptr += rc;
+				break;
+			}
+			/* hostname */
+			case 'h':
+				down_read(&uts_sem);
+				rc = snprintf(out_ptr, out_end - out_ptr,
+					      "%s", system_utsname.nodename);
+				up_read(&uts_sem);
+				if (rc > out_end - out_ptr)
+					goto out;
+				out_ptr += rc;
+				break;
+			/* executable */
+			case 'e':
+				rc = snprintf(out_ptr, out_end - out_ptr,
+					      "%s", current->comm);
+				if (rc > out_end - out_ptr)
+					goto out;
+				out_ptr += rc;
+				break;
+			default:
+				break;
+			}
+			++pat_ptr;
+		}
+	}
+	/* Backward compatibility with core_uses_pid:
+	 *
+	 * If core_pattern does not include a %p (as is the default)
+	 * and core_uses_pid is set, then .%pid will be appended to
+	 * the filename */
+	if (!pid_in_pattern
+            && (core_uses_pid || atomic_read(&current->mm->mm_users) != 1)) {
+		rc = snprintf(out_ptr, out_end - out_ptr,
+			      ".%d", current->pid);
+		if (rc > out_end - out_ptr)
+			goto out;
+		out_ptr += rc;
+	}
+      out:
+	*out_ptr = 0;
+}
+
 int do_coredump(long signr, struct pt_regs * regs)
 {
 	struct linux_binfmt * binfmt;
-	char corename[6+sizeof(current->comm)+10];
+	char corename[CORENAME_MAX_SIZE + 1];
 	struct file * file;
 	struct inode * inode;
 	int retval = 0;
@@ -951,10 +1073,7 @@
 	if (current->rlim[RLIMIT_CORE].rlim_cur < binfmt->min_coredump)
 		goto fail;
 
-	memcpy(corename,"core.", 5);
-	corename[4] = '\0';
- 	if (core_uses_pid || atomic_read(&current->mm->mm_users) != 1)
- 		sprintf(&corename[4], ".%d", current->pid);
+	format_corename(corename, core_pattern, signr);
 	file = filp_open(corename, O_CREAT | 2 | O_NOFOLLOW, 0600);
 	if (IS_ERR(file))
 		goto fail;
diff -urN -X dontdiff linux/include/linux/sysctl.h linux-corename/include/linux/sysctl.h
--- linux/include/linux/sysctl.h	Mon Nov 26 14:29:17 2001
+++ linux-corename/include/linux/sysctl.h	Mon Jul 22 16:50:06 2002
@@ -124,6 +124,7 @@
 	KERN_CORE_USES_PID=52,		/* int: use core or core.%pid */
 	KERN_TAINTED=53,	/* int: various kernel tainted flags */
 	KERN_CADPID=54,		/* int: PID of the process to notify on CAD */
+ 	KERN_CORE_PATTERN=55,	/* string: pattern for core-files */
 };
 

diff -urN -X dontdiff linux/kernel/sysctl.c linux-corename/kernel/sysctl.c
--- linux/kernel/sysctl.c	Fri Dec 21 18:42:04 2001
+++ linux-corename/kernel/sysctl.c	Mon Jul 22 16:45:01 2002
@@ -49,6 +49,7 @@
 extern int max_queued_signals;
 extern int sysrq_enabled;
 extern int core_uses_pid;
+extern char core_pattern[];
 extern int cad_pid;
 
 /* this is needed for the proc_dointvec_minmax for [fs_]overflow UID and GID */
@@ -171,6 +172,8 @@
 	 0644, NULL, &proc_dointvec},
 	{KERN_CORE_USES_PID, "core_uses_pid", &core_uses_pid, sizeof(int),
 	 0644, NULL, &proc_dointvec},
+	{KERN_CORE_PATTERN, "core_pattern", core_pattern, 64,
+	 0644, NULL, &proc_dostring, &sysctl_string},
 	{KERN_TAINTED, "tainted", &tainted, sizeof(int),
 	 0644, NULL, &proc_dointvec},
 	{KERN_CAP_BSET, "cap-bound", &cap_bset, sizeof(kernel_cap_t),



