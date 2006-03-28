Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964862AbWC2ACT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964862AbWC2ACT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 19:02:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964864AbWC2ABu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 19:01:50 -0500
Received: from [151.97.230.9] ([151.97.230.9]:32705 "EHLO ssc.unict.it")
	by vger.kernel.org with ESMTP id S964862AbWC2ABj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 19:01:39 -0500
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Subject: [PATCH 5/7] uml - tls support: hack to make it compile on any host
Date: Wed, 29 Mar 2006 01:57:00 +0200
To: Andrew Morton <akpm@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Message-Id: <20060328235700.13838.39297.stgit@zion.home.lan>
In-Reply-To: <20060328235442.13838.26861.stgit@zion.home.lan>
References: <20060328235442.13838.26861.stgit@zion.home.lan>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

Copy the definition of struct user_desc (with another name) for use by userspace
sources (where we use the host headers, and we can't be sure about their
content) to make sure UML compiles.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/um/include/os.h                |    7 ++++---
 arch/um/include/sysdep-i386/tls.h   |   28 ++++++++++++++++++++++++++++
 arch/um/include/sysdep-x86_64/tls.h |   29 +++++++++++++++++++++++++++++
 arch/um/os-Linux/tls.c              |   15 +++++++--------
 4 files changed, 68 insertions(+), 11 deletions(-)

diff --git a/arch/um/include/os.h b/arch/um/include/os.h
index 90869a7..b14d403 100644
--- a/arch/um/include/os.h
+++ b/arch/um/include/os.h
@@ -13,6 +13,7 @@
 #include "kern_util.h"
 #include "skas/mm_id.h"
 #include "irq_user.h"
+#include "sysdep/tls.h"
 
 #define OS_TYPE_FILE 1 
 #define OS_TYPE_DIR 2 
@@ -236,10 +237,10 @@ extern int helper_wait(int pid);
 
 
 /* tls.c */
-extern int os_set_thread_area(void *data, int pid);
-extern int os_get_thread_area(void *data, int pid);
-/* umid.c */
+extern int os_set_thread_area(user_desc_t *info, int pid);
+extern int os_get_thread_area(user_desc_t *info, int pid);
 
+/* umid.c */
 extern int umid_file_name(char *name, char *buf, int len);
 extern int set_umid(char *name);
 extern char *get_umid(void);
diff --git a/arch/um/include/sysdep-i386/tls.h b/arch/um/include/sysdep-i386/tls.h
new file mode 100644
index 0000000..938f953
--- /dev/null
+++ b/arch/um/include/sysdep-i386/tls.h
@@ -0,0 +1,28 @@
+#ifndef _SYSDEP_TLS_H
+#define _SYSDEP_TLS_H
+
+# ifndef __KERNEL__
+
+/* Change name to avoid conflicts with the original one from <asm/ldt.h>, which
+ * may be named user_desc (but in 2.4 and in header matching its API was named
+ * modify_ldt_ldt_s). */
+
+typedef struct um_dup_user_desc {
+	unsigned int  entry_number;
+	unsigned int  base_addr;
+	unsigned int  limit;
+	unsigned int  seg_32bit:1;
+	unsigned int  contents:2;
+	unsigned int  read_exec_only:1;
+	unsigned int  limit_in_pages:1;
+	unsigned int  seg_not_present:1;
+	unsigned int  useable:1;
+} user_desc_t;
+
+# else /* __KERNEL__ */
+
+#  include <asm/ldt.h>
+typedef struct user_desc user_desc_t;
+
+# endif /* __KERNEL__ */
+#endif /* _SYSDEP_TLS_H */
diff --git a/arch/um/include/sysdep-x86_64/tls.h b/arch/um/include/sysdep-x86_64/tls.h
new file mode 100644
index 0000000..35f19f2
--- /dev/null
+++ b/arch/um/include/sysdep-x86_64/tls.h
@@ -0,0 +1,29 @@
+#ifndef _SYSDEP_TLS_H
+#define _SYSDEP_TLS_H
+
+# ifndef __KERNEL__
+
+/* Change name to avoid conflicts with the original one from <asm/ldt.h>, which
+ * may be named user_desc (but in 2.4 and in header matching its API was named
+ * modify_ldt_ldt_s). */
+
+typedef struct um_dup_user_desc {
+	unsigned int  entry_number;
+	unsigned int  base_addr;
+	unsigned int  limit;
+	unsigned int  seg_32bit:1;
+	unsigned int  contents:2;
+	unsigned int  read_exec_only:1;
+	unsigned int  limit_in_pages:1;
+	unsigned int  seg_not_present:1;
+	unsigned int  useable:1;
+	unsigned int  lm:1;
+} user_desc_t;
+
+# else /* __KERNEL__ */
+
+#  include <asm/ldt.h>
+typedef struct user_desc user_desc_t;
+
+# endif /* __KERNEL__ */
+#endif /* _SYSDEP_TLS_H */
diff --git a/arch/um/os-Linux/tls.c b/arch/um/os-Linux/tls.c
index 63dfcf7..642db55 100644
--- a/arch/um/os-Linux/tls.c
+++ b/arch/um/os-Linux/tls.c
@@ -1,6 +1,7 @@
 #include <errno.h>
 #include <sys/ptrace.h>
 #include <asm/ldt.h>
+#include "sysdep/tls.h"
 #include "uml-config.h"
 
 /* TLS support - we basically rely on the host's one.*/
@@ -18,9 +19,8 @@
 #define PTRACE_SET_THREAD_AREA 26
 #endif
 
-int os_set_thread_area(void *data, int pid)
+int os_set_thread_area(user_desc_t *info, int pid)
 {
-	struct user_desc *info = data;
 	int ret;
 
 	ret = ptrace(PTRACE_SET_THREAD_AREA, pid, info->entry_number,
@@ -32,9 +32,8 @@ int os_set_thread_area(void *data, int p
 
 #ifdef UML_CONFIG_MODE_SKAS
 
-int os_get_thread_area(void *data, int pid)
+int os_get_thread_area(user_desc_t *info, int pid)
 {
-	struct user_desc *info = data;
 	int ret;
 
 	ret = ptrace(PTRACE_GET_THREAD_AREA, pid, info->entry_number,
@@ -49,10 +48,10 @@ int os_get_thread_area(void *data, int p
 #ifdef UML_CONFIG_MODE_TT
 #include "linux/unistd.h"
 
-_syscall1(int, get_thread_area, struct user_desc *, u_info);
-_syscall1(int, set_thread_area, struct user_desc *, u_info);
+_syscall1(int, get_thread_area, user_desc_t *, u_info);
+_syscall1(int, set_thread_area, user_desc_t *, u_info);
 
-int do_set_thread_area_tt(struct user_desc *info)
+int do_set_thread_area_tt(user_desc_t *info)
 {
 	int ret;
 
@@ -63,7 +62,7 @@ int do_set_thread_area_tt(struct user_de
 	return ret;
 }
 
-int do_get_thread_area_tt(struct user_desc *info)
+int do_get_thread_area_tt(user_desc_t *info)
 {
 	int ret;
 
