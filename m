Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319009AbSIJA5N>; Mon, 9 Sep 2002 20:57:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319014AbSIJA5N>; Mon, 9 Sep 2002 20:57:13 -0400
Received: from packet.digeo.com ([12.110.80.53]:987 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S319009AbSIJA5K>;
	Mon, 9 Sep 2002 20:57:10 -0400
Message-ID: <3D7D447B.D7BD1C33@digeo.com>
Date: Mon, 09 Sep 2002 18:01:47 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.34 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Nicholas Miell <nmiell@attbi.com>
CC: Linus Torvalds <torvalds@transmeta.com>, Greg KH <greg@kroah.com>,
       linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [patch] dump_stack(): arch-neutral stack trace
References: <Pine.LNX.4.33.0209091714330.2069-100000@penguin.transmeta.com> <1031618129.1403.12.camel@entropy>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 10 Sep 2002 01:01:47.0410 (UTC) FILETIME=[A3475F20:01C25865]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nicholas Miell wrote:
> 
> ...
> show_trace isn't exported for modules, and (even worse) isn't even
> implemented on all architectures, IIRC.

That's right.



>From Christoph Hellwig, also present in 2.4.

Create an arch-independent `dump_stack()' function.  So we don't need to do

#ifdef CONFIG_X86
	show_stack(0);		/* No prototype in scope! */
#endif

any more.

The whole dump_stack() implementation is delegated to the architecture.
If it doesn't provide one, there is a default do-nothing library
function.




 arch/alpha/kernel/traps.c |    5 +++++
 arch/cris/kernel/traps.c  |    6 +++++-
 arch/i386/kernel/traps.c  |    8 ++++++++
 fs/buffer.c               |    4 +---
 include/linux/kernel.h    |    2 ++
 kernel/ksyms.c            |    3 +++
 lib/Makefile              |    2 +-
 lib/dump_stack.c          |   13 +++++++++++++
 8 files changed, 38 insertions(+), 5 deletions(-)

--- 2.5.34/arch/alpha/kernel/traps.c~dump-stack	Mon Sep  9 12:24:43 2002
+++ 2.5.34-akpm/arch/alpha/kernel/traps.c	Mon Sep  9 12:24:43 2002
@@ -171,6 +171,11 @@ void show_stack(unsigned long *sp)
 	dik_show_trace(sp);
 }
 
+void dump_stack(void)
+{
+	show_stack(NULL);
+}
+
 void
 die_if_kernel(char * str, struct pt_regs *regs, long err, unsigned long *r9_15)
 {
--- 2.5.34/arch/cris/kernel/traps.c~dump-stack	Mon Sep  9 12:24:43 2002
+++ 2.5.34-akpm/arch/cris/kernel/traps.c	Mon Sep  9 12:24:43 2002
@@ -230,8 +230,12 @@ watchdog_bite_hook(struct pt_regs *regs)
 #endif	
 }
 
-/* This is normally the 'Oops' routine */
+void dump_stack(void)
+{
+	show_stack(NULL);
+}
 
+/* This is normally the 'Oops' routine */
 void 
 die_if_kernel(const char * str, struct pt_regs * regs, long err)
 {
--- 2.5.34/arch/i386/kernel/traps.c~dump-stack	Mon Sep  9 12:24:43 2002
+++ 2.5.34-akpm/arch/i386/kernel/traps.c	Mon Sep  9 12:24:43 2002
@@ -207,6 +207,14 @@ void show_stack(unsigned long * esp)
 	show_trace(esp);
 }
 
+/*
+ * The architecture-independent backtrace generator
+ */
+void dump_stack(void)
+{
+	show_stack(0);
+}
+
 void show_registers(struct pt_regs *regs)
 {
 	int i;
--- 2.5.34/fs/buffer.c~dump-stack	Mon Sep  9 12:24:43 2002
+++ 2.5.34-akpm/fs/buffer.c	Mon Sep  9 12:24:43 2002
@@ -61,10 +61,8 @@ void __buffer_error(char *file, int line
 		return;
 	enough++;
 	printk("buffer layer error at %s:%d\n", file, line);
-#ifdef CONFIG_X86
 	printk("Pass this trace through ksymoops for reporting\n");
-	show_stack(0);
-#endif
+	dump_stack();
 }
 EXPORT_SYMBOL(__buffer_error);
 
--- 2.5.34/include/linux/kernel.h~dump-stack	Mon Sep  9 12:24:43 2002
+++ 2.5.34-akpm/include/linux/kernel.h	Mon Sep  9 12:24:43 2002
@@ -96,6 +96,8 @@ extern const char *print_tainted(void);
 #define TAINT_FORCED_MODULE		(1<<1)
 #define TAINT_UNSAFE_SMP		(1<<2)
 
+extern void dump_stack(void);
+
 #if DEBUG
 #define pr_debug(fmt,arg...) \
 	printk(KERN_DEBUG fmt,##arg)
--- 2.5.34/kernel/ksyms.c~dump-stack	Mon Sep  9 12:24:43 2002
+++ 2.5.34-akpm/kernel/ksyms.c	Mon Sep  9 12:24:43 2002
@@ -609,3 +609,6 @@ EXPORT_SYMBOL(pidhash);
 #if defined(CONFIG_SMP) && defined(__GENERIC_PER_CPU)
 EXPORT_SYMBOL(__per_cpu_offset);
 #endif
+
+/* debug */
+EXPORT_SYMBOL(dump_stack);
--- /dev/null	Thu Aug 30 13:30:55 2001
+++ 2.5.34-akpm/lib/dump_stack.c	Mon Sep  9 12:24:43 2002
@@ -0,0 +1,13 @@
+/*
+ * Provide a default dump_stack() function for architectures
+ * which don't implement their own.
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+
+void dump_stack(void)
+{
+	printk(KERN_NOTICE
+		"This architecture does not implement dump_stack()\n");
+}
--- 2.5.34/lib/Makefile~dump-stack	Mon Sep  9 12:24:43 2002
+++ 2.5.34-akpm/lib/Makefile	Mon Sep  9 12:24:43 2002
@@ -12,7 +12,7 @@ export-objs := cmdline.o dec_and_lock.o 
 	       crc32.o rbtree.o radix-tree.o
 
 obj-y := errno.o ctype.o string.o vsprintf.o brlock.o cmdline.o \
-	 bust_spinlocks.o rbtree.o radix-tree.o
+	 bust_spinlocks.o rbtree.o radix-tree.o dump_stack.o
 
 obj-$(CONFIG_RWSEM_GENERIC_SPINLOCK) += rwsem-spinlock.o
 obj-$(CONFIG_RWSEM_XCHGADD_ALGORITHM) += rwsem.o

.
