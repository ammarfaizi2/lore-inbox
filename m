Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268813AbRIJNgg>; Mon, 10 Sep 2001 09:36:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269274AbRIJNgb>; Mon, 10 Sep 2001 09:36:31 -0400
Received: from ns.caldera.de ([212.34.180.1]:53477 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S268813AbRIJNgN>;
	Mon, 10 Sep 2001 09:36:13 -0400
Date: Mon, 10 Sep 2001 15:35:55 +0200
From: Christoph Hellwig <hch@caldera.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] personality handling update
Message-ID: <20010910153555.A7522@caldera.de>
Mail-Followup-To: Christoph Hellwig <hch@caldera.de>,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

the appended patch updates the personality handling in 2.4.0-pre7:

  o adds new members to struct exec_domain for error and networking
    mappings.
  o adds support for loading personality modules on demand
  o adds new personalities (Solaris, UW7, OSR5)
  o adds some systctls to control the personality subsystem and linux-abi
    (not yet actually used by this patch)
  o and last but ot least cleans this area of code up.  a lot.

This patch has been tested for a few month in Linux-ABI CVS and I got some
feedback for i386 and arm I incoorparated.  That means on other arches some
#include <linux/personality.h> may be missing, it's trivially fixable, though.

	Christoph

-- 
Of course it doesn't work. We've performed a software upgrade.

diff -uNr -Xdontdiff ../master/linux-2.4.10-pre7/arch/arm/kernel/arthur.c linux-2.4.10-pre7/arch/arm/kernel/arthur.c
--- ../master/linux-2.4.10-pre7/arch/arm/kernel/arthur.c	Mon Sep 10 14:45:56 2001
+++ linux-2.4.10-pre7/arch/arm/kernel/arthur.c	Mon Sep 10 15:08:40 2001
@@ -65,7 +65,7 @@
 
 static struct exec_domain arthur_exec_domain = {
 	"Arthur",	/* name */
-	(lcall7_func)arthur_lcall7,
+	arthur_lcall7,
 	PER_RISCOS, PER_RISCOS,
 	arthur_to_linux_signals,
 	linux_to_arthur_signals,
diff -uNr -Xdontdiff ../master/linux-2.4.10-pre7/arch/arm/kernel/traps.c linux-2.4.10-pre7/arch/arm/kernel/traps.c
--- ../master/linux-2.4.10-pre7/arch/arm/kernel/traps.c	Thu Aug 30 10:35:24 2001
+++ linux-2.4.10-pre7/arch/arm/kernel/traps.c	Mon Sep 10 15:09:31 2001
@@ -19,6 +19,7 @@
 #include <linux/sched.h>
 #include <linux/mm.h>
 #include <linux/spinlock.h>
+#include <linux/personality.h>
 #include <linux/ptrace.h>
 #include <linux/elf.h>
 #include <linux/init.h>
diff -uNr -Xdontdiff ../master/linux-2.4.10-pre7/arch/i386/kernel/signal.c linux-2.4.10-pre7/arch/i386/kernel/signal.c
--- ../master/linux-2.4.10-pre7/arch/i386/kernel/signal.c	Wed Jul  4 23:41:33 2001
+++ linux-2.4.10-pre7/arch/i386/kernel/signal.c	Mon Sep 10 15:08:40 2001
@@ -19,6 +19,7 @@
 #include <linux/unistd.h>
 #include <linux/stddef.h>
 #include <linux/tty.h>
+#include <linux/personality.h>
 #include <asm/ucontext.h>
 #include <asm/uaccess.h>
 #include <asm/i387.h>
diff -uNr -Xdontdiff ../master/linux-2.4.10-pre7/arch/sparc64/solaris/misc.c linux-2.4.10-pre7/arch/sparc64/solaris/misc.c
--- ../master/linux-2.4.10-pre7/arch/sparc64/solaris/misc.c	Mon Mar 26 04:14:21 2001
+++ linux-2.4.10-pre7/arch/sparc64/solaris/misc.c	Mon Sep 10 15:08:40 2001
@@ -709,7 +709,7 @@
 
 struct exec_domain solaris_exec_domain = {
 	"Solaris",
-	(lcall7_func)NULL,
+	NULL,
 	1, 1,	/* PER_SVR4 personality */
 	solaris_to_linux_signals,
 	linux_to_solaris_signals,
diff -uNr -Xdontdiff ../master/linux-2.4.10-pre7/fs/namei.c linux-2.4.10-pre7/fs/namei.c
--- ../master/linux-2.4.10-pre7/fs/namei.c	Mon Sep 10 14:46:05 2001
+++ linux-2.4.10-pre7/fs/namei.c	Mon Sep 10 15:08:40 2001
@@ -21,6 +21,7 @@
 #include <linux/pagemap.h>
 #include <linux/dnotify.h>
 #include <linux/smp_lock.h>
+#include <linux/personality.h>
 
 #include <asm/namei.h>
 #include <asm/uaccess.h>
diff -uNr -Xdontdiff ../master/linux-2.4.10-pre7/fs/select.c linux-2.4.10-pre7/fs/select.c
--- ../master/linux-2.4.10-pre7/fs/select.c	Thu Aug 30 10:35:30 2001
+++ linux-2.4.10-pre7/fs/select.c	Mon Sep 10 15:16:07 2001
@@ -17,6 +17,7 @@
 #include <linux/slab.h>
 #include <linux/smp_lock.h>
 #include <linux/poll.h>
+#include <linux/personality.h> /* for STICKY_TIMEOUTS */
 #include <linux/file.h>
 
 #include <asm/uaccess.h>
diff -uNr -Xdontdiff ../master/linux-2.4.10-pre7/include/linux/personality.h linux-2.4.10-pre7/include/linux/personality.h
--- ../master/linux-2.4.10-pre7/include/linux/personality.h	Mon Dec 11 21:49:54 2000
+++ linux-2.4.10-pre7/include/linux/personality.h	Mon Sep 10 15:08:40 2001
@@ -1,68 +1,126 @@
-#ifndef _PERSONALITY_H
-#define _PERSONALITY_H
+#ifndef _LINUX_PERSONALITY_H
+#define _LINUX_PERSONALITY_H
 
-#include <linux/linkage.h>
-#include <linux/ptrace.h>
-#include <asm/current.h>
-
-/* Flags for bug emulation. These occupy the top three bytes. */
-#define STICKY_TIMEOUTS		0x4000000
-#define WHOLE_SECONDS		0x2000000
-#define ADDR_LIMIT_32BIT	0x0800000
-
-/* Personality types. These go in the low byte. Avoid using the top bit,
- * it will conflict with error returns.
- */
-#define PER_MASK		(0x00ff)
-#define PER_LINUX		(0x0000)
-#define PER_LINUX_32BIT		(0x0000 | ADDR_LIMIT_32BIT)
-#define PER_SVR4		(0x0001 | STICKY_TIMEOUTS)
-#define PER_SVR3		(0x0002 | STICKY_TIMEOUTS)
-#define PER_SCOSVR3		(0x0003 | STICKY_TIMEOUTS | WHOLE_SECONDS)
-#define PER_WYSEV386		(0x0004 | STICKY_TIMEOUTS)
-#define PER_ISCR4		(0x0005 | STICKY_TIMEOUTS)
-#define PER_BSD			(0x0006)
-#define PER_SUNOS		(PER_BSD | STICKY_TIMEOUTS)
-#define PER_XENIX		(0x0007 | STICKY_TIMEOUTS)
-#define PER_LINUX32		(0x0008)
-#define PER_IRIX32              (0x0009 | STICKY_TIMEOUTS) /* IRIX5 32-bit     */
-#define PER_IRIXN32             (0x000a | STICKY_TIMEOUTS) /* IRIX6 new 32-bit */
-#define PER_IRIX64              (0x000b | STICKY_TIMEOUTS) /* IRIX6 64-bit     */
-#define PER_RISCOS		(0x000c)
-#define PER_SOLARIS		(0x000d | STICKY_TIMEOUTS)
-
-/* Prototype for an lcall7 syscall handler. */
-typedef void (*lcall7_func)(int, struct pt_regs *);
-
-
-/* Description of an execution domain - personality range supported,
- * lcall7 syscall handler, start up / shut down functions etc.
- * N.B. The name and lcall7 handler must be where they are since the
- * offset of the handler is hard coded in kernel/sys_call.S.
+/*
+ * Handling of different ABIs (personalities).
  */
+
+struct exec_domain;
+struct pt_regs;
+
+extern int		register_exec_domain(struct exec_domain *);
+extern int		unregister_exec_domain(struct exec_domain *);
+extern int		__set_personality(unsigned long);
+
+
+/*
+ * Sysctl variables related to binary emulation.
+ */
+extern unsigned long abi_defhandler_coff;
+extern unsigned long abi_defhandler_elf;
+extern unsigned long abi_defhandler_lcall7;
+extern unsigned long abi_defhandler_libcso;
+extern int abi_fake_utsname;
+
+
+/*
+ * Flags for bug emulation.
+ *
+ * These occupy the top three bytes.
+ */
+enum {
+	MMAP_PAGE_ZERO =	0x0100000,
+	ADDR_LIMIT_32BIT =	0x0800000,
+	SHORT_INODE =		0x1000000,
+	WHOLE_SECONDS =		0x2000000,
+	STICKY_TIMEOUTS	=	0x4000000,
+};
+
+/*
+ * Personality types.
+ *
+ * These go in the low byte.  Avoid using the top bit, it will
+ * conflict with error returns.
+ */
+enum {
+	PER_LINUX =		0x0000,
+	PER_LINUX_32BIT =	0x0000 | ADDR_LIMIT_32BIT,
+	PER_SVR4 =		0x0001 | STICKY_TIMEOUTS | MMAP_PAGE_ZERO,
+	PER_SVR3 =		0x0002 | STICKY_TIMEOUTS | SHORT_INODE,
+	PER_SCOSVR3 =		0x0003 | STICKY_TIMEOUTS |
+					 WHOLE_SECONDS | SHORT_INODE,
+	PER_OSR5 =		0x0003 | STICKY_TIMEOUTS | WHOLE_SECONDS,
+	PER_WYSEV386 =		0x0004 | STICKY_TIMEOUTS | SHORT_INODE,
+	PER_ISCR4 =		0x0005 | STICKY_TIMEOUTS,
+	PER_BSD =		0x0006,
+	PER_SUNOS =		0x0006 | STICKY_TIMEOUTS,
+	PER_XENIX =		0x0007 | STICKY_TIMEOUTS | SHORT_INODE,
+	PER_LINUX32 =		0x0008,
+	PER_IRIX32 =		0x0009 | STICKY_TIMEOUTS,/* IRIX5 32-bit */
+	PER_IRIXN32 =		0x000a | STICKY_TIMEOUTS,/* IRIX6 new 32-bit */
+	PER_IRIX64 =		0x000b | STICKY_TIMEOUTS,/* IRIX6 64-bit */
+	PER_RISCOS =		0x000c,
+	PER_SOLARIS =		0x000d | STICKY_TIMEOUTS,
+	PER_UW7 =		0x000e | STICKY_TIMEOUTS | MMAP_PAGE_ZERO,
+	PER_MASK =		0x00ff,
+};
+
+
+/*
+ * Description of an execution domain.
+ * 
+ * The first two members are refernced from assembly source
+ * and should stay where they are unless explicitly needed.
+ */
+typedef void (*handler_t)(int, struct pt_regs *);
+
 struct exec_domain {
-	const char *name;
-	lcall7_func handler;
-	unsigned char pers_low, pers_high;
-	unsigned long * signal_map;
-	unsigned long * signal_invmap;
-	struct module * module;
-	struct exec_domain *next;
+	const char		*name;		/* name of the execdomain */
+	handler_t		handler;	/* handler for syscalls */
+	unsigned char		pers_low;	/* lowest personality */
+	unsigned char		pers_high;	/* highest personality */
+	unsigned long		*signal_map;	/* signal mapping */
+	unsigned long		*signal_invmap;	/* reverse signal mapping */
+	struct map_segment	*err_map;	/* error mapping */
+	struct map_segment	*socktype_map;	/* socket type mapping */
+	struct map_segment	*sockopt_map;	/* socket option mapping */
+	struct map_segment	*af_map;	/* address family mapping */
+	struct module		*module;	/* module context of the ed. */
+	struct exec_domain	*next;		/* linked list (internal) */
 };
 
-extern struct exec_domain default_exec_domain;
+/*
+ * Return the base personality without flags.
+ */
+#define personality(pers)	(pers & PER_MASK)
+
+/*
+ * Personality of the currently running process.
+ */
+#define get_personality		(current->personality)
+
+/*
+ * Change personality of the currently running process.
+ */
+#define set_personality(pers) \
+	((current->personality == pers) ? 0 : __set_personality(pers))
+
+/*
+ * Load an execution domain.
+ */
+#define get_exec_domain(ep)				\
+do {							\
+	if (ep != NULL && ep->module != NULL)		\
+		__MOD_INC_USE_COUNT(ep->module);	\
+} while (0)
 
-extern int register_exec_domain(struct exec_domain *it);
-extern int unregister_exec_domain(struct exec_domain *it);
-#define put_exec_domain(it) \
-	if (it && it->module) __MOD_DEC_USE_COUNT(it->module);
-#define get_exec_domain(it) \
-	if (it && it->module) __MOD_INC_USE_COUNT(it->module);
-extern void __set_personality(unsigned long personality);
-#define set_personality(pers) do {	\
-	if (current->personality != pers) \
-		__set_personality(pers); \
+/*
+ * Unload an execution domain.
+ */
+#define put_exec_domain(ep)				\
+do {							\
+	if (ep != NULL && ep->module != NULL)		\
+		__MOD_DEC_USE_COUNT(ep->module);	\
 } while (0)
-asmlinkage long sys_personality(unsigned long personality);
 
-#endif /* _PERSONALITY_H */
+#endif /* _LINUX_PERSONALITY_H */
diff -uNr -Xdontdiff ../master/linux-2.4.10-pre7/include/linux/sched.h linux-2.4.10-pre7/include/linux/sched.h
--- ../master/linux-2.4.10-pre7/include/linux/sched.h	Mon Sep 10 14:46:08 2001
+++ linux-2.4.10-pre7/include/linux/sched.h	Mon Sep 10 15:11:30 2001
@@ -7,7 +7,6 @@
 
 #include <linux/config.h>
 #include <linux/binfmts.h>
-#include <linux/personality.h>
 #include <linux/threads.h>
 #include <linux/kernel.h>
 #include <linux/types.h>
@@ -27,6 +26,8 @@
 #include <linux/securebits.h>
 #include <linux/fs_struct.h>
 
+struct exec_domain;
+
 /*
  * cloning flags:
  */
@@ -437,6 +438,12 @@
 #define MAX_COUNTER	(20*HZ/100)
 #define DEF_NICE	(0)
 
+
+/*
+ * The default (Linux) execution domain.
+ */
+extern struct exec_domain	default_exec_domain;
+
 /*
  *  INIT_TASK is used to set up the first task table, touch at
  * your own risk!. Base=0, limit=0x1fffff (=2MB)
diff -uNr -Xdontdiff ../master/linux-2.4.10-pre7/include/linux/sysctl.h linux-2.4.10-pre7/include/linux/sysctl.h
--- ../master/linux-2.4.10-pre7/include/linux/sysctl.h	Mon Sep 10 14:46:08 2001
+++ linux-2.4.10-pre7/include/linux/sysctl.h	Mon Sep 10 15:11:32 2001
@@ -61,7 +61,8 @@
 	CTL_FS=5,		/* Filesystems */
 	CTL_DEBUG=6,		/* Debugging */
 	CTL_DEV=7,		/* Devices */
-	CTL_BUS=8		/* Buses */
+	CTL_BUS=8,		/* Buses */
+	CTL_ABI=9		/* Binary emulation */
 };
 
 /* CTL_BUS names: */
@@ -606,6 +607,17 @@
 	DEV_MAC_HID_ADB_MOUSE_SENDS_KEYCODES=6
 };
 
+/* /proc/sys/abi */
+enum
+{
+	ABI_DEFHANDLER_COFF=1,	/* default handler for coff binaries */
+	ABI_DEFHANDLER_ELF=2, 	/* default handler for ELF binaries */
+	ABI_DEFHANDLER_LCALL7=3,/* default handler for procs using lcall7 */
+	ABI_DEFHANDLER_LIBCSO=4,/* default handler for an libc.so ELF interp */
+	ABI_TRACE=5,		/* tracing flags */
+	ABI_FAKE_UTSNAME=6,	/* fake target utsname information */
+};
+
 #ifdef __KERNEL__
 
 extern asmlinkage long sys_sysctl(struct __sysctl_args *);
diff -uNr -Xdontdiff ../master/linux-2.4.10-pre7/kernel/Makefile linux-2.4.10-pre7/kernel/Makefile
--- ../master/linux-2.4.10-pre7/kernel/Makefile	Fri Dec 29 23:07:24 2000
+++ linux-2.4.10-pre7/kernel/Makefile	Mon Sep 10 15:08:40 2001
@@ -9,7 +9,7 @@
 
 O_TARGET := kernel.o
 
-export-objs = signal.o sys.o kmod.o context.o ksyms.o pm.o
+export-objs = signal.o sys.o kmod.o context.o ksyms.o pm.o exec_domain.o
 
 obj-y     = sched.o dma.o fork.o exec_domain.o panic.o printk.o \
 	    module.o exit.o itimer.o info.o time.o softirq.o resource.o \
diff -uNr -Xdontdiff ../master/linux-2.4.10-pre7/kernel/exec_domain.c linux-2.4.10-pre7/kernel/exec_domain.c
--- ../master/linux-2.4.10-pre7/kernel/exec_domain.c	Mon Jun 26 20:36:43 2000
+++ linux-2.4.10-pre7/kernel/exec_domain.c	Mon Sep 10 15:08:40 2001
@@ -1,11 +1,30 @@
-#include <linux/mm.h>
-#include <linux/smp_lock.h>
+/*
+ * Handling of different ABIs (personalities).
+ *
+ * We group personalities into execution domains which have their
+ * own handlers for kernel entry points, signal mapping, etc...
+ *
+ * 2001-05-06	Complete rewrite,  Christoph Hellwig (hch@caldera.de)
+ */
+
+#include <linux/config.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/kmod.h>
 #include <linux/module.h>
+#include <linux/personality.h>
+#include <linux/sched.h>
+#include <linux/sysctl.h>
+#include <linux/types.h>
 
-static asmlinkage void no_lcall7(int segment, struct pt_regs * regs);
 
+static void default_handler(int, struct pt_regs *);
 
-static unsigned long ident_map[32] = {
+static struct exec_domain *exec_domains = &default_exec_domain;
+static rwlock_t exec_domains_lock = RW_LOCK_UNLOCKED;
+
+
+static u_long ident_map[32] = {
 	0,	1,	2,	3,	4,	5,	6,	7,
 	8,	9,	10,	11,	12,	13,	14,	15,
 	16,	17,	18,	19,	20,	21,	22,	23,
@@ -13,151 +32,260 @@
 };
 
 struct exec_domain default_exec_domain = {
-	"Linux",	/* name */
-	no_lcall7,	/* lcall7 causes a seg fault. */
-	0, 0xff,	/* All personalities. */
-	ident_map,	/* Identity map signals. */
-	ident_map,	/*  - both ways. */
-	NULL,		/* No usage counter. */
-	NULL		/* Nothing after this in the list. */
+	"Linux",		/* name */
+	default_handler,	/* lcall7 causes a seg fault. */
+	0, 0,			/* PER_LINUX personality. */
+	ident_map,		/* Identity map signals. */
+	ident_map,		/*  - both ways. */
 };
 
-static struct exec_domain *exec_domains = &default_exec_domain;
-static rwlock_t exec_domains_lock = RW_LOCK_UNLOCKED;
 
-static asmlinkage void no_lcall7(int segment, struct pt_regs * regs)
+static void
+default_handler(int segment, struct pt_regs *regp)
 {
-  /*
-   * This may have been a static linked SVr4 binary, so we would have the
-   * personality set incorrectly.  Check to see whether SVr4 is available,
-   * and use it, otherwise give the user a SEGV.
-   */
-	set_personality(PER_SVR4);
+	u_long			pers = 0;
 
-	if (current->exec_domain && current->exec_domain->handler
-	&& current->exec_domain->handler != no_lcall7) {
-		current->exec_domain->handler(segment, regs);
-		return;
+	/*
+	 * This may have been a static linked SVr4 binary, so we would
+	 * have the personality set incorrectly. Or it might have been
+	 * a Solaris/x86 binary. We can tell which because the former
+	 * uses lcall7, while the latter used lcall 0x27.
+	 * Try to find or load the appropriate personality, and fall back
+	 * to just forcing a SEGV.
+	 *
+	 * XXX: this is IA32-specific and should be moved to the MD-tree.
+	 */
+	switch (segment) {
+#ifdef __i386__
+	case 0x07:
+		pers = abi_defhandler_lcall7;
+		break;
+	case 0x27:
+		pers = PER_SOLARIS;
+		break;
+#endif
 	}
+	set_personality(pers);
 
-	send_sig(SIGSEGV, current, 1);
+	if (current->exec_domain->handler != default_handler)
+		current->exec_domain->handler(segment, regp);
+	else
+		send_sig(SIGSEGV, current, 1);
 }
 
-static struct exec_domain *lookup_exec_domain(unsigned long personality)
+static struct exec_domain *
+lookup_exec_domain(u_long personality)
 {
-	unsigned long pers = personality & PER_MASK;
-	struct exec_domain *it;
+	struct exec_domain *	ep;
+	char			buffer[30];
+	u_long			pers = personality(personality);
+		
+	read_lock(&exec_domains_lock);
+	for (ep = exec_domains; ep; ep = ep->next) {
+		if (pers >= ep->pers_low && pers <= ep->pers_high)
+			if (try_inc_mod_count(ep->module))
+				goto out;
+	}
+	read_unlock(&exec_domains_lock);
+
+#ifdef CONFIG_KMOD
+	sprintf(buffer, "personality-%ld", pers);
+	request_module(buffer);
 
 	read_lock(&exec_domains_lock);
-	for (it=exec_domains; it; it=it->next)
-		if (pers >= it->pers_low && pers <= it->pers_high) {
-			if (!try_inc_mod_count(it->module))
-				continue;
-			read_unlock(&exec_domains_lock);
-			return it;
-		}
+	for (ep = exec_domains; ep; ep = ep->next) {
+		if (pers >= ep->pers_low && pers <= ep->pers_high)
+			if (try_inc_mod_count(ep->module))
+				goto out;
+	}
 	read_unlock(&exec_domains_lock);
+#endif
 
-	/* Should never get this far. */
-	printk(KERN_ERR "No execution domain for personality 0x%02lx\n", pers);
-	return NULL;
+	ep = &default_exec_domain;
+out:
+	read_unlock(&exec_domains_lock);
+	return (ep);
 }
 
-int register_exec_domain(struct exec_domain *it)
+int
+register_exec_domain(struct exec_domain *ep)
 {
-	struct exec_domain *tmp;
+	struct exec_domain	*tmp;
+	int			err = -EBUSY;
 
-	if (!it)
+	if (ep == NULL)
 		return -EINVAL;
-	if (it->next)
+
+	if (ep->next != NULL)
 		return -EBUSY;
+
 	write_lock(&exec_domains_lock);
-	for (tmp=exec_domains; tmp; tmp=tmp->next)
-		if (tmp == it) {
-			write_unlock(&exec_domains_lock);
-			return -EBUSY;
-		}
-	it->next = exec_domains;
-	exec_domains = it;
+	for (tmp = exec_domains; tmp; tmp = tmp->next) {
+		if (tmp == ep)
+			goto out;
+	}
+
+	ep->next = exec_domains;
+	exec_domains = ep;
+	err = 0;
+
+out:
 	write_unlock(&exec_domains_lock);
-	return 0;
+	return (err);
 }
 
-int unregister_exec_domain(struct exec_domain *it)
+int
+unregister_exec_domain(struct exec_domain *ep)
 {
-	struct exec_domain ** tmp;
+	struct exec_domain	**epp;
 
-	tmp = &exec_domains;
+	epp = &exec_domains;
 	write_lock(&exec_domains_lock);
-	while (*tmp) {
-		if (it == *tmp) {
-			*tmp = it->next;
-			it->next = NULL;
-			write_unlock(&exec_domains_lock);
-			return 0;
-		}
-		tmp = &(*tmp)->next;
+	for (epp = &exec_domains; *epp; epp = &(*epp)->next) {
+		if (ep == *epp)
+			goto unregister;
 	}
 	write_unlock(&exec_domains_lock);
 	return -EINVAL;
+
+unregister:
+	*epp = ep->next;
+	ep->next = NULL;
+	write_unlock(&exec_domains_lock);
+	return 0;
 }
 
-void __set_personality(unsigned long personality)
+int
+__set_personality(u_long personality)
 {
-	struct exec_domain *it, *prev;
+	struct exec_domain	*ep, *oep;
 
-	it = lookup_exec_domain(personality);
-	if (it == current->exec_domain) {
+	ep = lookup_exec_domain(personality);
+	if (ep == NULL)
+		return -EINVAL;
+	if (ep == current->exec_domain) {
 		current->personality = personality;
-		return;
+		return 0;
 	}
-	if (!it)
-		return;
+
 	if (atomic_read(&current->fs->count) != 1) {
-		struct fs_struct *new = copy_fs_struct(current->fs);
-		struct fs_struct *old;
-		if (!new) {
-			put_exec_domain(it);
-			return;
+		struct fs_struct *fsp, *ofsp;
+
+		fsp = copy_fs_struct(current->fs);
+		if (fsp == NULL) {
+			put_exec_domain(ep);
+			return -ENOMEM;;
 		}
+
 		task_lock(current);
-		old = current->fs;
-		current->fs = new;
+		ofsp = current->fs;
+		current->fs = fsp;
 		task_unlock(current);
-		put_fs_struct(old);
+
+		put_fs_struct(ofsp);
 	}
+
 	/*
 	 * At that point we are guaranteed to be the sole owner of
 	 * current->fs.
 	 */
+
 	current->personality = personality;
-	prev = current->exec_domain;
-	current->exec_domain = it;
+	oep = current->exec_domain;
+	current->exec_domain = ep;
 	set_fs_altroot();
-	put_exec_domain(prev);
-}
 
-asmlinkage long sys_personality(unsigned long personality)
-{
-	int ret = current->personality;
-	if (personality != 0xffffffff) {
-		set_personality(personality);
-		if (current->personality != personality)
-			ret = -EINVAL;
-	}
-	return ret;
+	put_exec_domain(oep);
+
+	printk(KERN_DEBUG "[%s:%d]: set personality to %lx\n",
+			current->comm, current->pid, personality);
+	return 0;
 }
 
-int get_exec_domain_list(char * page)
+int
+get_exec_domain_list(char *page)
 {
-	int len = 0;
-	struct exec_domain * e;
+	struct exec_domain	*ep;
+	int			len = 0;
 
 	read_lock(&exec_domains_lock);
-	for (e=exec_domains; e && len < PAGE_SIZE - 80; e=e->next)
-		len += sprintf(page+len, "%d-%d\t%-16s\t[%s]\n",
-			e->pers_low, e->pers_high, e->name,
-			e->module ? e->module->name : "kernel");
+	for (ep = exec_domains; ep && len < PAGE_SIZE - 80; ep = ep->next)
+		len += sprintf(page + len, "%d-%d\t%-16s\t[%s]\n",
+			ep->pers_low, ep->pers_high, ep->name,
+			ep->module ? ep->module->name : "kernel");
 	read_unlock(&exec_domains_lock);
-	return len;
+	return (len);
 }
+
+asmlinkage long
+sys_personality(u_long personality)
+{
+	if (personality == 0xffffffff)
+		goto ret;
+	set_personality(personality);
+	if (current->personality != personality)
+		return -EINVAL;
+ret:
+	return (current->personality);
+}
+
+
+EXPORT_SYMBOL(register_exec_domain);
+EXPORT_SYMBOL(unregister_exec_domain);
+EXPORT_SYMBOL(__set_personality);
+
+/*
+ * We have to have all sysctl handling for the Linux-ABI
+ * in one place as the dynamic registration of sysctls is
+ * horribly crufty in Linux <= 2.4.
+ *
+ * I hope the new sysctl schemes discussed for future versions
+ * will obsolete this.
+ *
+ * 				--hch
+ */
+
+u_long abi_defhandler_coff = PER_SCOSVR3;
+u_long abi_defhandler_elf = PER_LINUX;
+u_long abi_defhandler_lcall7 = PER_SVR4;
+u_long abi_defhandler_libcso = PER_SVR4;
+u_int abi_traceflg;
+int abi_fake_utsname;
+
+static struct ctl_table abi_table[] = {
+	{ABI_DEFHANDLER_COFF, "defhandler_coff", &abi_defhandler_coff,
+		sizeof(int), 0644, NULL, &proc_doulongvec_minmax},
+	{ABI_DEFHANDLER_ELF, "defhandler_elf", &abi_defhandler_elf,
+		sizeof(int), 0644, NULL, &proc_doulongvec_minmax},
+	{ABI_DEFHANDLER_LCALL7, "defhandler_lcall7", &abi_defhandler_lcall7,
+		sizeof(int), 0644, NULL, &proc_doulongvec_minmax},
+	{ABI_DEFHANDLER_LIBCSO, "defhandler_libcso", &abi_defhandler_libcso,
+		sizeof(int), 0644, NULL, &proc_doulongvec_minmax},
+	{ABI_TRACE, "trace", &abi_traceflg,
+		sizeof(u_int), 0644, NULL, &proc_dointvec},
+	{ABI_FAKE_UTSNAME, "fake_utsname", &abi_fake_utsname,
+		sizeof(int), 0644, NULL, &proc_dointvec},
+	{0}
+};
+
+static struct ctl_table abi_root_table[] = {
+	{CTL_ABI, "abi", NULL, 0, 0555, abi_table},
+	{0}
+};
+
+static int __init
+abi_register_sysctl(void)
+{
+	register_sysctl_table(abi_root_table, 1);
+	return 0;
+}
+
+__initcall(abi_register_sysctl);
+
+
+EXPORT_SYMBOL(abi_defhandler_coff);
+EXPORT_SYMBOL(abi_defhandler_elf);
+EXPORT_SYMBOL(abi_defhandler_lcall7);
+EXPORT_SYMBOL(abi_defhandler_libcso);
+EXPORT_SYMBOL(abi_traceflg);
+EXPORT_SYMBOL(abi_fake_utsname);
diff -uNr -Xdontdiff ../master/linux-2.4.10-pre7/kernel/exit.c linux-2.4.10-pre7/kernel/exit.c
--- ../master/linux-2.4.10-pre7/kernel/exit.c	Thu Aug 30 10:35:31 2001
+++ linux-2.4.10-pre7/kernel/exit.c	Mon Sep 10 15:08:40 2001
@@ -10,6 +10,7 @@
 #include <linux/smp_lock.h>
 #include <linux/module.h>
 #include <linux/completion.h>
+#include <linux/personality.h>
 #include <linux/tty.h>
 #ifdef CONFIG_BSD_PROCESS_ACCT
 #include <linux/acct.h>
diff -uNr -Xdontdiff ../master/linux-2.4.10-pre7/kernel/fork.c linux-2.4.10-pre7/kernel/fork.c
--- ../master/linux-2.4.10-pre7/kernel/fork.c	Mon Sep 10 14:46:08 2001
+++ linux-2.4.10-pre7/kernel/fork.c	Mon Sep 10 15:08:40 2001
@@ -19,6 +19,7 @@
 #include <linux/module.h>
 #include <linux/vmalloc.h>
 #include <linux/completion.h>
+#include <linux/personality.h>
 
 #include <asm/pgtable.h>
 #include <asm/pgalloc.h>
diff -uNr -Xdontdiff ../master/linux-2.4.10-pre7/kernel/ksyms.c linux-2.4.10-pre7/kernel/ksyms.c
--- ../master/linux-2.4.10-pre7/kernel/ksyms.c	Mon Sep 10 14:46:08 2001
+++ linux-2.4.10-pre7/kernel/ksyms.c	Mon Sep 10 15:08:40 2001
@@ -334,11 +334,6 @@
 EXPORT_SYMBOL(remove_arg_zero);
 EXPORT_SYMBOL(set_binfmt);
 
-/* execution environment registration */
-EXPORT_SYMBOL(register_exec_domain);
-EXPORT_SYMBOL(unregister_exec_domain);
-EXPORT_SYMBOL(__set_personality);
-
 /* sysctl table registration */
 EXPORT_SYMBOL(register_sysctl_table);
 EXPORT_SYMBOL(unregister_sysctl_table);
