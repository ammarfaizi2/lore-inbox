Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261842AbUKHOgp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261842AbUKHOgp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 09:36:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261885AbUKHOg1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 09:36:27 -0500
Received: from mx1.redhat.com ([66.187.233.31]:29377 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261842AbUKHOdX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 09:33:23 -0500
Date: Mon, 8 Nov 2004 14:32:41 GMT
Message-Id: <200411081432.iA8EWfHx023419@warthog.cambridge.redhat.com>
From: dhowells@redhat.com
To: torvalds@osdl.org, akpm@osdl.org, davidm@snapgear.com
cc: linux-kernel@vger.kernel.org, uclinux-dev@uclinux.org
Subject: [PATCH] GP-REL data support
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The attached patch makes it possible to support gp-rel addressing for small
variables. Since the FR-V cpu's have fixed-length instructions and plenty of
general-purpose registers, one register is nominated as a base for the small
data area. This makes it possible to use single-insn accesses to access global
and static variables instead of having to use multiple instructions.

This, however, causes problems with small variables used to pinpoint the
beginning and end of sections. The compiler assumes it can use gp-rel
addressing for these, but the linker then complains because the displacement is
out of range.

By declaring certain variables as arrays or by forcing them into named
sections, the compiler is persuaded to access them as if they can be outside
the displacement range. Declaring the variables as "const void" type also
works.

Signed-Off-By: dhowells@redhat.com
---
diffstat gprel-2610rc1mm3.diff
 drivers/char/tty_io.c   |    4 ++--
 fs/proc/proc_misc.c     |    1 -
 include/linux/init.h    |    4 ++--
 include/linux/jiffies.h |   10 ++++++++--
 include/linux/kernel.h  |    2 ++
 init/initramfs.c        |    6 +++---
 init/main.c             |   16 +++++++---------
 init/version.c          |    2 +-
 kernel/kallsyms.c       |    6 ++----
 kernel/power/swsusp.c   |    2 +-
 security/security.c     |    4 ++--
 11 files changed, 30 insertions(+), 27 deletions(-)

diff -uNrp /warthog/kernels/linux-2.6.10-rc1-mm3/drivers/char/tty_io.c linux-2.6.10-rc1-mm3-frv/drivers/char/tty_io.c
--- /warthog/kernels/linux-2.6.10-rc1-mm3/drivers/char/tty_io.c	2004-11-05 13:15:27.000000000 +0000
+++ linux-2.6.10-rc1-mm3-frv/drivers/char/tty_io.c	2004-11-05 14:13:03.681514522 +0000
@@ -2903,8 +2903,8 @@ void __init console_init(void)
 	   So I haven't moved it. dwmw2 */
         rs_360_init();
 #endif
-	call = &__con_initcall_start;
-	while (call < &__con_initcall_end) {
+	call = __con_initcall_start;
+	while (call < __con_initcall_end) {
 		(*call)();
 		call++;
 	}
diff -uNrp /warthog/kernels/linux-2.6.10-rc1-mm3/fs/proc/proc_misc.c linux-2.6.10-rc1-mm3-frv/fs/proc/proc_misc.c
--- /warthog/kernels/linux-2.6.10-rc1-mm3/fs/proc/proc_misc.c	2004-11-05 13:15:43.000000000 +0000
+++ linux-2.6.10-rc1-mm3-frv/fs/proc/proc_misc.c	2004-11-05 14:13:03.865498982 +0000
@@ -257,7 +219,6 @@ static struct file_operations fragmentat
 static int version_read_proc(char *page, char **start, off_t off,
 				 int count, int *eof, void *data)
 {
-	extern char *linux_banner;
 	int len;
 
 	strcpy(page, linux_banner);
diff -uNrp /warthog/kernels/linux-2.6.10-rc1-mm3/include/linux/init.h linux-2.6.10-rc1-mm3-frv/include/linux/init.h
--- /warthog/kernels/linux-2.6.10-rc1-mm3/include/linux/init.h	2004-09-16 12:06:21.000000000 +0100
+++ linux-2.6.10-rc1-mm3-frv/include/linux/init.h	2004-11-05 14:13:04.392454474 +0000
@@ -64,8 +64,8 @@
 typedef int (*initcall_t)(void);
 typedef void (*exitcall_t)(void);
 
-extern initcall_t __con_initcall_start, __con_initcall_end;
-extern initcall_t __security_initcall_start, __security_initcall_end;
+extern initcall_t __con_initcall_start[], __con_initcall_end[];
+extern initcall_t __security_initcall_start[], __security_initcall_end[];
 
 /* Defined in init/main.c */
 extern char saved_command_line[];
diff -uNrp /warthog/kernels/linux-2.6.10-rc1-mm3/include/linux/jiffies.h linux-2.6.10-rc1-mm3-frv/include/linux/jiffies.h
--- /warthog/kernels/linux-2.6.10-rc1-mm3/include/linux/jiffies.h	2004-10-27 17:32:36.000000000 +0100
+++ linux-2.6.10-rc1-mm3-frv/include/linux/jiffies.h	2004-11-05 14:13:04.397454052 +0000
@@ -70,13 +70,19 @@
 /* a value TUSEC for TICK_USEC (can be set bij adjtimex)		*/
 #define TICK_USEC_TO_NSEC(TUSEC) (SH_DIV (TUSEC * USER_HZ * 1000, ACTHZ, 8))
 
+/* some arch's have a small-data section that can be accessed register-relative
+ * but that can only take up to, say, 4-byte variables. jiffies being part of
+ * an 8-byte variable may not be correctly accessed unless we force the issue
+ */
+#define __jiffy_data  __attribute__((section(".data")))
+
 /*
  * The 64-bit value is not volatile - you MUST NOT read it
  * without sampling the sequence number in xtime_lock.
  * get_jiffies_64() will do this for you as appropriate.
  */
-extern u64 jiffies_64;
-extern unsigned long volatile jiffies;
+extern u64 __jiffy_data jiffies_64;
+extern unsigned long volatile __jiffy_data jiffies;
 
 #if (BITS_PER_LONG < 64)
 u64 get_jiffies_64(void);
diff -uNrp /warthog/kernels/linux-2.6.10-rc1-mm3/include/linux/kernel.h linux-2.6.10-rc1-mm3-frv/include/linux/kernel.h
--- /warthog/kernels/linux-2.6.10-rc1-mm3/include/linux/kernel.h	2004-11-05 13:15:50.000000000 +0000
+++ linux-2.6.10-rc1-mm3-frv/include/linux/kernel.h	2004-11-05 14:13:04.401453714 +0000
@@ -16,6 +16,8 @@
 #include <asm/byteorder.h>
 #include <asm/bug.h>
 
+extern const char linux_banner[];
+
 #define INT_MAX		((int)(~0U>>1))
 #define INT_MIN		(-INT_MAX - 1)
 #define UINT_MAX	(~0U)
diff -uNrp /warthog/kernels/linux-2.6.10-rc1-mm3/init/initramfs.c linux-2.6.10-rc1-mm3-frv/init/initramfs.c
--- /warthog/kernels/linux-2.6.10-rc1-mm3/init/initramfs.c	2004-11-05 13:15:51.000000000 +0000
+++ linux-2.6.10-rc1-mm3-frv/init/initramfs.c	2004-11-05 14:13:04.473447633 +0000
@@ -459,15 +459,15 @@ char * __init unpack_to_rootfs(char *buf
 	return message;
 }
 
-extern char __initramfs_start, __initramfs_end;
+extern char __initramfs_start[], __initramfs_end[];
 #ifdef CONFIG_BLK_DEV_INITRD
 #include <linux/initrd.h>
 #endif
 
 void __init populate_rootfs(void)
 {
-	char *err = unpack_to_rootfs(&__initramfs_start,
-			 &__initramfs_end - &__initramfs_start, 0);
+	char *err = unpack_to_rootfs(__initramfs_start,
+			 __initramfs_end - __initramfs_start, 0);
 	if (err)
 		panic(err);
 #ifdef CONFIG_BLK_DEV_INITRD
diff -uNrp /warthog/kernels/linux-2.6.10-rc1-mm3/init/main.c linux-2.6.10-rc1-mm3-frv/init/main.c
--- /warthog/kernels/linux-2.6.10-rc1-mm3/init/main.c	2004-11-05 13:15:51.000000000 +0000
+++ linux-2.6.10-rc1-mm3-frv/init/main.c	2004-11-05 14:13:04.499445437 +0000
@@ -76,8 +76,6 @@
 #error Sorry, your GCC is too old. It builds incorrect kernels.
 #endif
 
-extern char *linux_banner;
-
 static int init(void *);
 
 extern void init_IRQ(void);
@@ -158,12 +156,13 @@ static char * argv_init[MAX_INIT_ARGS+2]
 char * envp_init[MAX_INIT_ENVS+2] = { "HOME=/", "TERM=linux", NULL, };
 static const char *panic_later, *panic_param;
 
+extern struct obs_kernel_param __setup_start[], __setup_end[];
+
 static int __init obsolete_checksetup(char *line)
 {
 	struct obs_kernel_param *p;
-	extern struct obs_kernel_param __setup_start, __setup_end;
 
-	p = &__setup_start;
+	p = __setup_start;
 	do {
 		int n = strlen(p->str);
 		if (!strncmp(line, p->str, n)) {
@@ -180,7 +179,7 @@ static int __init obsolete_checksetup(ch
 				return 1;
 		}
 		p++;
-	} while (p < &__setup_end);
+	} while (p < __setup_end);
 	return 0;
 }
 
@@ -460,9 +389,8 @@ static void noinline rest_init(void)
 static int __init do_early_param(char *param, char *val)
 {
 	struct obs_kernel_param *p;
-	extern struct obs_kernel_param __setup_start, __setup_end;
 
-	for (p = &__setup_start; p < &__setup_end; p++) {
+	for (p = __setup_start; p < __setup_end; p++) {
 		if (p->early && strcmp(param, p->str) == 0) {
 			if (p->setup_func(val) != 0)
 				printk(KERN_WARNING
@@ -606,14 +534,14 @@ __setup("initcall_debug", initcall_debug
 
 struct task_struct *child_reaper = &init_task;
 
-extern initcall_t __initcall_start, __initcall_end;
+extern initcall_t __initcall_start[], __initcall_end[];
 
 static void __init do_initcalls(void)
 {
 	initcall_t *call;
 	int count = preempt_count();
 
-	for (call = &__initcall_start; call < &__initcall_end; call++) {
+	for (call = __initcall_start; call < __initcall_end; call++) {
 		char *msg;
 
 		if (initcall_debug) {
diff -uNrp /warthog/kernels/linux-2.6.10-rc1-mm3/init/version.c linux-2.6.10-rc1-mm3-frv/init/version.c
--- /warthog/kernels/linux-2.6.10-rc1-mm3/init/version.c	2004-06-18 13:42:40.000000000 +0100
+++ linux-2.6.10-rc1-mm3-frv/init/version.c	2004-11-05 14:13:04.508444677 +0000
@@ -28,6 +28,6 @@ struct new_utsname system_utsname = {
 
 EXPORT_SYMBOL(system_utsname);
 
-const char *linux_banner = 
+const char linux_banner[] = 
 	"Linux version " UTS_RELEASE " (" LINUX_COMPILE_BY "@"
 	LINUX_COMPILE_HOST ") (" LINUX_COMPILER ") " UTS_VERSION "\n";
diff -uNrp /warthog/kernels/linux-2.6.10-rc1-mm3/kernel/kallsyms.c linux-2.6.10-rc1-mm3-frv/kernel/kallsyms.c
--- /warthog/kernels/linux-2.6.10-rc1-mm3/kernel/kallsyms.c	2004-10-27 17:32:38.000000000 +0100
+++ linux-2.6.10-rc1-mm3-frv/kernel/kallsyms.c	2004-11-05 14:13:04.000000000 +0000
@@ -18,10 +18,11 @@
 #include <linux/fs.h>
 #include <linux/err.h>
 #include <linux/proc_fs.h>
+#include <asm/sections.h>
 
 /* These will be re-linked against their real values during the second link stage */
 extern unsigned long kallsyms_addresses[] __attribute__((weak));
-extern unsigned long kallsyms_num_syms __attribute__((weak));
+extern unsigned long kallsyms_num_syms __attribute__((weak,section("data")));
 extern u8 kallsyms_names[] __attribute__((weak));
 
 extern u8 kallsyms_token_table[] __attribute__((weak));
@@ -29,9 +30,6 @@ extern u16 kallsyms_token_index[] __attr
 
 extern unsigned long kallsyms_markers[] __attribute__((weak));
 
-/* Defined by the linker script. */
-extern char _stext[], _etext[], _sinittext[], _einittext[];
-
 static inline int is_kernel_inittext(unsigned long addr)
 {
 	if (addr >= (unsigned long)_sinittext
diff -uNrp /warthog/kernels/linux-2.6.10-rc1-mm3/kernel/power/swsusp.c linux-2.6.10-rc1-mm3-frv/kernel/power/swsusp.c
--- /warthog/kernels/linux-2.6.10-rc1-mm3/kernel/power/swsusp.c	2004-11-05 13:15:51.000000000 +0000
+++ linux-2.6.10-rc1-mm3-frv/kernel/power/swsusp.c	2004-11-05 14:13:04.000000000 +0000
@@ -72,7 +72,7 @@
 #include "power.h"
 
 /* References to section boundaries */
-extern char __nosave_begin, __nosave_end;
+extern const void __nosave_begin, __nosave_end;
 
 extern int is_head_of_free_region(struct page *);
 
diff -uNrp /warthog/kernels/linux-2.6.10-rc1-mm3/security/security.c linux-2.6.10-rc1-mm3-frv/security/security.c
--- /warthog/kernels/linux-2.6.10-rc1-mm3/security/security.c	2004-10-27 17:32:39.000000000 +0100
+++ linux-2.6.10-rc1-mm3-frv/security/security.c	2004-11-05 14:13:05.000000000 +0000
@@ -38,8 +38,8 @@ static inline int verify(struct security
 static void __init do_security_initcalls(void)
 {
 	initcall_t *call;
-	call = &__security_initcall_start;
-	while (call < &__security_initcall_end) {
+	call = __security_initcall_start;
+	while (call < __security_initcall_end) {
 		(*call) ();
 		call++;
 	}
