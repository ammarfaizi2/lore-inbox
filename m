Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964857AbWC2ADH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964857AbWC2ADH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 19:03:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964863AbWC2ABo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 19:01:44 -0500
Received: from [151.97.230.9] ([151.97.230.9]:28097 "EHLO ssc.unict.it")
	by vger.kernel.org with ESMTP id S964860AbWC2ABj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 19:01:39 -0500
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Subject: [PATCH 7/7] uml: check for differences in host support
Date: Wed, 29 Mar 2006 01:57:05 +0200
To: Andrew Morton <akpm@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Message-Id: <20060328235705.13838.53116.stgit@zion.home.lan>
In-Reply-To: <20060328235442.13838.26861.stgit@zion.home.lan>
References: <20060328235442.13838.26861.stgit@zion.home.lan>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

If running on an host not supporting TLS (for instance 2.4) we should report
that cleanly to the user, instead of printing not comprehensible "error 5" for
that.

Additionally, i386 and x86_64 support different ranges for
user_desc->entry_number, and we must account for that; we couldn't pass
ourselves -1 because we need to override previously existing TLS descriptors
which glibc has possibly set, so test at startup the range to use.

x86 and x86_64 existing ranges are hardcoded.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/um/include/os.h               |    1 +
 arch/um/include/sysdep-i386/tls.h  |    4 +++
 arch/um/include/user_util.h        |    3 ++
 arch/um/os-Linux/sys-i386/Makefile |    2 +
 arch/um/os-Linux/sys-i386/tls.c    |   33 ++++++++++++++++++++++
 arch/um/os-Linux/tls.c             |    4 +--
 arch/um/sys-i386/tls.c             |   55 +++++++++++++++++++++++++++++++++++-
 include/asm-um/segment.h           |    6 +++-
 8 files changed, 102 insertions(+), 6 deletions(-)

diff --git a/arch/um/include/os.h b/arch/um/include/os.h
index b14d403..88abc4b 100644
--- a/arch/um/include/os.h
+++ b/arch/um/include/os.h
@@ -173,6 +173,7 @@ extern int os_fchange_dir(int fd);
 extern void os_early_checks(void);
 extern int can_do_skas(void);
 extern void os_check_bugs(void);
+extern void check_host_supports_tls(int *supports_tls, int *tls_min);
 
 /* Make sure they are clear when running in TT mode. Required by
  * SEGV_MAYBE_FIXABLE */
diff --git a/arch/um/include/sysdep-i386/tls.h b/arch/um/include/sysdep-i386/tls.h
index 938f953..918fd3c 100644
--- a/arch/um/include/sysdep-i386/tls.h
+++ b/arch/um/include/sysdep-i386/tls.h
@@ -25,4 +25,8 @@ typedef struct um_dup_user_desc {
 typedef struct user_desc user_desc_t;
 
 # endif /* __KERNEL__ */
+
+#define GDT_ENTRY_TLS_MIN_I386 6
+#define GDT_ENTRY_TLS_MIN_X86_64 12
+
 #endif /* _SYSDEP_TLS_H */
diff --git a/arch/um/include/user_util.h b/arch/um/include/user_util.h
index e654a20..2926fb7 100644
--- a/arch/um/include/user_util.h
+++ b/arch/um/include/user_util.h
@@ -8,6 +8,9 @@
 
 #include "sysdep/ptrace.h"
 
+/* Copied from kernel.h */
+#define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
+
 #define CATCH_EINTR(expr) while ((errno = 0, ((expr) < 0)) && (errno == EINTR))
 
 extern int mode_tt;
diff --git a/arch/um/os-Linux/sys-i386/Makefile b/arch/um/os-Linux/sys-i386/Makefile
index 340ef26..b321361 100644
--- a/arch/um/os-Linux/sys-i386/Makefile
+++ b/arch/um/os-Linux/sys-i386/Makefile
@@ -3,7 +3,7 @@
 # Licensed under the GPL
 #
 
-obj-$(CONFIG_MODE_SKAS) = registers.o
+obj-$(CONFIG_MODE_SKAS) = registers.o tls.o
 
 USER_OBJS := $(obj-y)
 
diff --git a/arch/um/os-Linux/sys-i386/tls.c b/arch/um/os-Linux/sys-i386/tls.c
new file mode 100644
index 0000000..ba21f0e
--- /dev/null
+++ b/arch/um/os-Linux/sys-i386/tls.c
@@ -0,0 +1,33 @@
+#include <linux/unistd.h>
+#include "sysdep/tls.h"
+#include "user_util.h"
+
+static _syscall1(int, get_thread_area, user_desc_t *, u_info);
+
+/* Checks whether host supports TLS, and sets *tls_min according to the value
+ * valid on the host.
+ * i386 host have it == 6; x86_64 host have it == 12, for i386 emulation. */
+void check_host_supports_tls(int *supports_tls, int *tls_min) {
+	/* Values for x86 and x86_64.*/
+	int val[] = {GDT_ENTRY_TLS_MIN_I386, GDT_ENTRY_TLS_MIN_X86_64};
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(val); i++) {
+		user_desc_t info;
+		info.entry_number = val[i];
+
+		if (get_thread_area(&info) == 0) {
+			*tls_min = val[i];
+			*supports_tls = 1;
+			return;
+		} else {
+			if (errno == EINVAL)
+				continue;
+			else if (errno == ENOSYS)
+				*supports_tls = 0;
+				return;
+		}
+	}
+
+	*supports_tls = 0;
+}
diff --git a/arch/um/os-Linux/tls.c b/arch/um/os-Linux/tls.c
index 642db55..9cb09a4 100644
--- a/arch/um/os-Linux/tls.c
+++ b/arch/um/os-Linux/tls.c
@@ -48,8 +48,8 @@ int os_get_thread_area(user_desc_t *info
 #ifdef UML_CONFIG_MODE_TT
 #include "linux/unistd.h"
 
-_syscall1(int, get_thread_area, user_desc_t *, u_info);
-_syscall1(int, set_thread_area, user_desc_t *, u_info);
+static _syscall1(int, get_thread_area, user_desc_t *, u_info);
+static _syscall1(int, set_thread_area, user_desc_t *, u_info);
 
 int do_set_thread_area_tt(user_desc_t *info)
 {
diff --git a/arch/um/sys-i386/tls.c b/arch/um/sys-i386/tls.c
index 2251654..a3188e8 100644
--- a/arch/um/sys-i386/tls.c
+++ b/arch/um/sys-i386/tls.c
@@ -24,6 +24,10 @@
 #include "skas.h"
 #endif
 
+/* If needed we can detect when it's uninitialized. */
+static int host_supports_tls = -1;
+int host_gdt_entry_tls_min = -1;
+
 #ifdef CONFIG_MODE_SKAS
 int do_set_thread_area_skas(struct user_desc *info)
 {
@@ -157,11 +161,20 @@ void clear_flushed_tls(struct task_struc
 	}
 }
 
-/* This in SKAS0 does not need to be used, since we have different host
- * processes. Nor will this need to be used when we'll add support to the host
+/* In SKAS0 mode, currently, multiple guest threads sharing the same ->mm have a
+ * common host process. So this is needed in SKAS0 too.
+ *
+ * However, if each thread had a different host process (and this was discussed
+ * for SMP support) this won't be needed.
+ *
+ * And this will not need be used when (and if) we'll add support to the host
  * SKAS patch. */
+
 int arch_switch_tls_skas(struct task_struct *from, struct task_struct *to)
 {
+	if (!host_supports_tls)
+		return 0;
+
 	/* We have no need whatsoever to switch TLS for kernel threads; beyond
 	 * that, that would also result in us calling os_set_thread_area with
 	 * userspace_pid[cpu] == 0, which gives an error. */
@@ -173,6 +186,9 @@ int arch_switch_tls_skas(struct task_str
 
 int arch_switch_tls_tt(struct task_struct *from, struct task_struct *to)
 {
+	if (!host_supports_tls)
+		return 0;
+
 	if (needs_TLS_update(to))
 		return load_TLS(0, to);
 
@@ -256,6 +272,9 @@ asmlinkage int sys_set_thread_area(struc
 	struct user_desc info;
 	int idx, ret;
 
+	if (!host_supports_tls)
+		return -ENOSYS;
+
 	if (copy_from_user(&info, user_desc, sizeof(info)))
 		return -EFAULT;
 
@@ -287,6 +306,9 @@ int ptrace_set_thread_area(struct task_s
 {
 	struct user_desc info;
 
+	if (!host_supports_tls)
+		return -EIO;
+
 	if (copy_from_user(&info, user_desc, sizeof(info)))
 		return -EFAULT;
 
@@ -298,6 +320,9 @@ asmlinkage int sys_get_thread_area(struc
 	struct user_desc info;
 	int idx, ret;
 
+	if (!host_supports_tls)
+		return -ENOSYS;
+
 	if (get_user(idx, &user_desc->entry_number))
 		return -EFAULT;
 
@@ -321,6 +346,9 @@ int ptrace_get_thread_area(struct task_s
 	struct user_desc info;
 	int ret;
 
+	if (!host_supports_tls)
+		return -EIO;
+
 	ret = get_tls_entry(child, &info, idx);
 	if (ret < 0)
 		goto out;
@@ -331,3 +359,26 @@ out:
 	return ret;
 }
 
+
+/* XXX: This part is probably common to i386 and x86-64. Don't create a common
+ * file for now, do that when implementing x86-64 support.*/
+static int __init __setup_host_supports_tls(void) {
+	check_host_supports_tls(&host_supports_tls, &host_gdt_entry_tls_min);
+	if (host_supports_tls) {
+		printk(KERN_INFO "Host TLS support detected\n");
+		printk(KERN_INFO "Detected host type: ");
+		switch (host_gdt_entry_tls_min) {
+			case GDT_ENTRY_TLS_MIN_I386:
+				printk("i386\n");
+				break;
+			case GDT_ENTRY_TLS_MIN_X86_64:
+				printk("x86_64\n");
+				break;
+		}
+	} else
+		printk(KERN_ERR "  Host TLS support NOT detected! "
+				"TLS support inside UML will not work\n");
+	return 1;
+}
+
+__initcall(__setup_host_supports_tls);
diff --git a/include/asm-um/segment.h b/include/asm-um/segment.h
index 4877545..45183fc 100644
--- a/include/asm-um/segment.h
+++ b/include/asm-um/segment.h
@@ -1,6 +1,10 @@
 #ifndef __UM_SEGMENT_H
 #define __UM_SEGMENT_H
 
-#include "asm/arch/segment.h"
+extern int host_gdt_entry_tls_min;
+
+#define GDT_ENTRY_TLS_ENTRIES 3
+#define GDT_ENTRY_TLS_MIN host_gdt_entry_tls_min
+#define GDT_ENTRY_TLS_MAX (GDT_ENTRY_TLS_MIN + GDT_ENTRY_TLS_ENTRIES - 1)
 
 #endif
