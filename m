Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266023AbSIRK73>; Wed, 18 Sep 2002 06:59:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266027AbSIRK72>; Wed, 18 Sep 2002 06:59:28 -0400
Received: from penguin.cohaesio.net ([212.97.129.34]:49570 "EHLO
	mail.cohaesio.net") by vger.kernel.org with ESMTP
	id <S266023AbSIRK70>; Wed, 18 Sep 2002 06:59:26 -0400
Subject: [PATCH] core file naming
From: Jes Rahbek Klinke <jes@bodi-klinke.dk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 18 Sep 2002 13:04:26 +0200
Message-Id: <1032347067.1581.7.camel@albatros>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan

In case you were planning on including my patch to allow core file names
to include the executable, hostname etc., I have ported it to apply
directly to 2.4.20-pre5-ac6.

Regards
Jes Klinke

diff -urN -X dontdiff linux-2.4.20-pre5-ac6/fs/exec.c linux-2.4.20-pre5-ac6-core/fs/exec.c
--- linux-2.4.20-pre5-ac6/fs/exec.c     Wed Sep 18 08:57:59 2002
+++ linux-2.4.20-pre5-ac6-core/fs/exec.c        Wed Sep 18 08:56:10 2002
@@ -36,6 +36,7 @@
 #include <linux/spinlock.h>
 #include <linux/personality.h>
 #include <linux/swap.h>
+#include <linux/utsname.h>
 #define __NO_VERSION__
 #include <linux/module.h>
 
@@ -48,6 +49,8 @@
 #endif
 
 int core_uses_pid;
+char core_pattern[65] = "core";
+/* The maximal length of core_pattern is also specified in sysctl.c */ 
 
 static struct linux_binfmt *formats;
 static rwlock_t binfmt_lock = RW_LOCK_UNLOCKED;
@@ -961,10 +964,126 @@
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
+       const char *pat_ptr = pattern;
+       char *out_ptr = corename;
+       char *const out_end = corename + CORENAME_MAX_SIZE;
+       int rc;
+       int pid_in_pattern = 0;
+
+       /* Repeat as long as we have more pattern to process and more output
+          space */
+       while (*pat_ptr) {
+               if (*pat_ptr != '%') {
+                       if (out_ptr == out_end)
+                               goto out;
+                       *out_ptr++ = *pat_ptr++;
+               } else {
+                       switch (*++pat_ptr) {
+                       case 0:
+                               goto out;
+                       /* Double percent, output one percent */
+                       case '%':
+                               if (out_ptr == out_end)
+                                       goto out;
+                               *out_ptr++ = '%';
+                               break;
+                       /* pid */
+                       case 'p':
+                               pid_in_pattern = 1;
+                               rc = snprintf(out_ptr, out_end - out_ptr,
+                                             "%d", current->pid);
+                               if (rc > out_end - out_ptr)
+                                       goto out;
+                               out_ptr += rc;
+                               break;
+                       /* uid */
+                       case 'u':
+                               rc = snprintf(out_ptr, out_end - out_ptr,
+                                             "%d", current->uid);
+                               if (rc > out_end - out_ptr)
+                                       goto out;
+                               out_ptr += rc;
+                               break;
+                       /* gid */
+                       case 'g':
+                               rc = snprintf(out_ptr, out_end - out_ptr,
+                                             "%d", current->gid);
+                               if (rc > out_end - out_ptr)
+                                       goto out;
+                               out_ptr += rc;
+                               break;
+                       /* signal that caused the coredump */
+                       case 's':
+                               rc = snprintf(out_ptr, out_end - out_ptr,
+                                             "%ld", signr);
+                               if (rc > out_end - out_ptr)
+                                       goto out;
+                               out_ptr += rc;
+                               break;
+                       /* UNIX time of coredump */
+                       case 't': {
+                               struct timeval tv;
+                               do_gettimeofday(&tv);
+                               rc = snprintf(out_ptr, out_end - out_ptr,
+                                             "%d", tv.tv_sec);
+                               if (rc > out_end - out_ptr)
+                                       goto out;
+                               out_ptr += rc;
+                               break;
+                       }
+                       /* hostname */
+                       case 'h':
+                               down_read(&uts_sem);
+                               rc = snprintf(out_ptr, out_end - out_ptr,
+                                             "%s", system_utsname.nodename);
+                               up_read(&uts_sem);
+                               if (rc > out_end - out_ptr)
+                                       goto out;
+                               out_ptr += rc;
+                               break;
+                       /* executable */
+                       case 'e':
+                               rc = snprintf(out_ptr, out_end - out_ptr,
+                                             "%s", current->comm);
+                               if (rc > out_end - out_ptr)
+                                       goto out;
+                               out_ptr += rc;
+                               break;
+                       default:
+                               break;
+                       }
+                       ++pat_ptr;
+               }
+       }
+       /* Backward compatibility with core_uses_pid:
+        *
+        * If core_pattern does not include a %p (as is the default)
+        * and core_uses_pid is set, then .%pid will be appended to
+        * the filename */
+       if (!pid_in_pattern
+            && (core_uses_pid || atomic_read(&current->mm->mm_users) != 1)) {
+               rc = snprintf(out_ptr, out_end - out_ptr,
+                             ".%d", current->pid);
+               if (rc > out_end - out_ptr)
+                       goto out;
+               out_ptr += rc;
+       }
+      out:
+       *out_ptr = 0;
+}
+
 int do_coredump(long signr, struct pt_regs * regs)
 {
        struct linux_binfmt * binfmt;
-       char corename[6+sizeof(current->comm)+10];
+       char corename[CORENAME_MAX_SIZE + 1];
        struct file * file;
        struct inode * inode;
        int retval = 0;
@@ -979,9 +1098,7 @@
        if (current->rlim[RLIMIT_CORE].rlim_cur < binfmt->min_coredump)
                goto fail;
 
-       memcpy(corename,"core", 5); /* include trailing \0 */
-       if (core_uses_pid || atomic_read(&current->mm->mm_users) != 1)
-               sprintf(&corename[4], ".%d", current->pid);
+       format_corename(corename, core_pattern, signr);
        file = filp_open(corename, O_CREAT | 2 | O_NOFOLLOW, 0600);
        if (IS_ERR(file))
                goto fail;
diff -urN -X dontdiff linux-2.4.20-pre5-ac6/include/linux/sysctl.h linux-2.4.20-pre5-ac6-core/include/linux/sysctl.h
--- linux-2.4.20-pre5-ac6/include/linux/sysctl.h        Wed Sep 18 08:58:01 2002
+++ linux-2.4.20-pre5-ac6-core/include/linux/sysctl.h   Wed Sep 18 08:53:30 2002
@@ -124,6 +124,7 @@
        KERN_CORE_USES_PID=52,          /* int: use core or core.%pid */
        KERN_TAINTED=53,        /* int: various kernel tainted flags */
        KERN_CADPID=54,         /* int: PID of the process to notify on CAD */
+       KERN_CORE_PATTERN=55,   /* string: pattern for core-files */
 };
 
 
diff -urN -X dontdiff linux-2.4.20-pre5-ac6/kernel/sysctl.c linux-2.4.20-pre5-ac6-core/kernel/sysctl.c
--- linux-2.4.20-pre5-ac6/kernel/sysctl.c       Wed Sep 18 08:58:01 2002
+++ linux-2.4.20-pre5-ac6-core/kernel/sysctl.c  Wed Sep 18 08:53:30 2002
@@ -49,6 +49,7 @@
 extern int max_queued_signals;
 extern int sysrq_enabled;
 extern int core_uses_pid;
+extern char core_pattern[];
 extern int cad_pid;
 
 /* this is needed for the proc_dointvec_minmax for [fs_]overflow UID and GID */
@@ -191,6 +192,8 @@
         0644, NULL, &proc_dointvec},
        {KERN_CORE_USES_PID, "core_uses_pid", &core_uses_pid, sizeof(int),
         0644, NULL, &proc_dointvec},
+       {KERN_CORE_PATTERN, "core_pattern", core_pattern, 64,
+        0644, NULL, &proc_dostring, &sysctl_string},
        {KERN_TAINTED, "tainted", &tainted, sizeof(int),
         0644, NULL, &proc_dointvec},
        {KERN_CAP_BSET, "cap-bound", &cap_bset, sizeof(kernel_cap_t),






