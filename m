Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932393AbVIMW5L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932393AbVIMW5L (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 18:57:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932459AbVIMW5L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 18:57:11 -0400
Received: from wproxy.gmail.com ([64.233.184.200]:26212 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932393AbVIMW5J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 18:57:09 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=dfxHz38tvnp3R5noCS+otbg+koBbwdiLvpgh6NxTKq2C16trmI+LvvO1xV/e9YNRT+Brm2Xg4ZKZVTVBejaG5Vt6V3PcTNgmxRv3U02AgOh/dMc0uJV37Hz76VRb0oC1fHHcIdTn7YYaWyWwzb1okipVhXzf+XWDWneFmy7BwEE=
Date: Wed, 14 Sep 2005 03:07:18 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Separate tainted code from panic code
Message-ID: <20050913230718.GA14867@mipter.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Create kernel/tainted.c and include/linux/tainted.h
* Move all tainted-related stuff from kernel/panic.c and
  include/linux/kernel.h there.
* #include <linux/tainted.h> where needed.
* Switch #include <linux/kernel.h> to #include <linux/tainted.h> in
  kernel/module.c and mm/page_alloc.c . Said includes were added during
  add_taint() propagation and tainted stuff was in kernel.h back then.

Tested by faking Oops and reading HTML documentation for kernel API.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 Documentation/DocBook/kernel-api.tmpl   |    1 
 arch/alpha/kernel/traps.c               |    1 
 arch/arm/kernel/process.c               |    1 
 arch/arm26/kernel/process.c             |    1 
 arch/i386/kernel/cpu/mcheck/k7.c        |    1 
 arch/i386/kernel/cpu/mcheck/non-fatal.c |    1 
 arch/i386/kernel/cpu/mcheck/p4.c        |    1 
 arch/i386/kernel/cpu/mcheck/p5.c        |    1 
 arch/i386/kernel/cpu/mcheck/p6.c        |    1 
 arch/i386/kernel/cpu/mcheck/winchip.c   |    1 
 arch/i386/kernel/process.c              |    1 
 arch/i386/kernel/smpboot.c              |    1 
 arch/i386/kernel/traps.c                |    1 
 arch/ia64/kernel/process.c              |    1 
 arch/m68k/kernel/process.c              |    1 
 arch/m68knommu/kernel/process.c         |    1 
 arch/mips/kernel/traps.c                |    1 
 arch/mips/sgi-ip27/ip27-nmi.c           |    1 
 arch/parisc/kernel/traps.c              |    1 
 arch/ppc/kernel/process.c               |    1 
 arch/ppc/kernel/traps.c                 |    1 
 arch/ppc64/kernel/process.c             |    1 
 arch/s390/kernel/process.c              |    1 
 arch/sh/kernel/process.c                |    1 
 arch/sparc/kernel/process.c             |    1 
 arch/sparc64/kernel/process.c           |    1 
 arch/sparc64/kernel/setup.c             |    1 
 arch/um/sys-i386/sysrq.c                |    1 
 arch/um/sys-x86_64/sysrq.c              |    1 
 arch/x86_64/kernel/mce.c                |    1 
 arch/x86_64/kernel/mce_intel.c          |    1 
 arch/x86_64/kernel/process.c            |    1 
 include/linux/kernel.h                  |   10 -------
 include/linux/tainted.h                 |   15 +++++++++++
 kernel/Makefile                         |    2 -
 kernel/module.c                         |    2 -
 kernel/panic.c                          |   37 ----------------------------
 kernel/sysctl.c                         |    1 
 kernel/tainted.c                        |   41 ++++++++++++++++++++++++++++++++
 mm/page_alloc.c                         |    2 -
 40 files changed, 92 insertions(+), 50 deletions(-)

--- a/Documentation/DocBook/kernel-api.tmpl
+++ b/Documentation/DocBook/kernel-api.tmpl
@@ -72,6 +72,7 @@ X!Iinclude/linux/kobject.h
 X!Ekernel/printk.c
  -->
 !Ekernel/panic.c
+!Ikernel/tainted.c
 !Ekernel/sys.c
 !Ekernel/rcupdate.c
      </sect1>
--- a/arch/alpha/kernel/traps.c
+++ b/arch/alpha/kernel/traps.c
@@ -17,6 +17,7 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/kallsyms.h>
+#include <linux/tainted.h>
 
 #include <asm/gentrap.h>
 #include <asm/uaccess.h>
--- a/arch/arm/kernel/process.c
+++ b/arch/arm/kernel/process.c
@@ -26,6 +26,7 @@
 #include <linux/interrupt.h>
 #include <linux/kallsyms.h>
 #include <linux/init.h>
+#include <linux/tainted.h>
 
 #include <asm/system.h>
 #include <asm/io.h>
--- a/arch/arm26/kernel/process.c
+++ b/arch/arm26/kernel/process.c
@@ -26,6 +26,7 @@
 #include <linux/reboot.h>
 #include <linux/interrupt.h>
 #include <linux/init.h>
+#include <linux/tainted.h>
 
 #include <asm/system.h>
 #include <asm/io.h>
--- a/arch/i386/kernel/cpu/mcheck/k7.c
+++ b/arch/i386/kernel/cpu/mcheck/k7.c
@@ -10,6 +10,7 @@
 #include <linux/irq.h>
 #include <linux/interrupt.h>
 #include <linux/smp.h>
+#include <linux/tainted.h>
 
 #include <asm/processor.h> 
 #include <asm/system.h>
--- a/arch/i386/kernel/cpu/mcheck/non-fatal.c
+++ b/arch/i386/kernel/cpu/mcheck/non-fatal.c
@@ -17,6 +17,7 @@
 #include <linux/interrupt.h>
 #include <linux/smp.h>
 #include <linux/module.h>
+#include <linux/tainted.h>
 
 #include <asm/processor.h> 
 #include <asm/system.h>
--- a/arch/i386/kernel/cpu/mcheck/p4.c
+++ b/arch/i386/kernel/cpu/mcheck/p4.c
@@ -9,6 +9,7 @@
 #include <linux/irq.h>
 #include <linux/interrupt.h>
 #include <linux/smp.h>
+#include <linux/tainted.h>
 
 #include <asm/processor.h> 
 #include <asm/system.h>
--- a/arch/i386/kernel/cpu/mcheck/p5.c
+++ b/arch/i386/kernel/cpu/mcheck/p5.c
@@ -9,6 +9,7 @@
 #include <linux/irq.h>
 #include <linux/interrupt.h>
 #include <linux/smp.h>
+#include <linux/tainted.h>
 
 #include <asm/processor.h> 
 #include <asm/system.h>
--- a/arch/i386/kernel/cpu/mcheck/p6.c
+++ b/arch/i386/kernel/cpu/mcheck/p6.c
@@ -9,6 +9,7 @@
 #include <linux/irq.h>
 #include <linux/interrupt.h>
 #include <linux/smp.h>
+#include <linux/tainted.h>
 
 #include <asm/processor.h> 
 #include <asm/system.h>
--- a/arch/i386/kernel/cpu/mcheck/winchip.c
+++ b/arch/i386/kernel/cpu/mcheck/winchip.c
@@ -8,6 +8,7 @@
 #include <linux/kernel.h>
 #include <linux/irq.h>
 #include <linux/interrupt.h>
+#include <linux/tainted.h>
 
 #include <asm/processor.h> 
 #include <asm/system.h>
--- a/arch/i386/kernel/process.c
+++ b/arch/i386/kernel/process.c
@@ -39,6 +39,7 @@
 #include <linux/ptrace.h>
 #include <linux/random.h>
 #include <linux/kprobes.h>
+#include <linux/tainted.h>
 
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
--- a/arch/i386/kernel/smpboot.c
+++ b/arch/i386/kernel/smpboot.c
@@ -37,6 +37,7 @@
 #include <linux/config.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
+#include <linux/tainted.h>
 
 #include <linux/mm.h>
 #include <linux/sched.h>
--- a/arch/i386/kernel/traps.c
+++ b/arch/i386/kernel/traps.c
@@ -28,6 +28,7 @@
 #include <linux/utsname.h>
 #include <linux/kprobes.h>
 #include <linux/kexec.h>
+#include <linux/tainted.h>
 
 #ifdef CONFIG_EISA
 #include <linux/ioport.h>
--- a/arch/ia64/kernel/process.c
+++ b/arch/ia64/kernel/process.c
@@ -28,6 +28,7 @@
 #include <linux/interrupt.h>
 #include <linux/delay.h>
 #include <linux/kprobes.h>
+#include <linux/tainted.h>
 
 #include <asm/cpu.h>
 #include <asm/delay.h>
--- a/arch/m68k/kernel/process.c
+++ b/arch/m68k/kernel/process.c
@@ -27,6 +27,7 @@
 #include <linux/reboot.h>
 #include <linux/init_task.h>
 #include <linux/mqueue.h>
+#include <linux/tainted.h>
 
 #include <asm/uaccess.h>
 #include <asm/system.h>
--- a/arch/m68knommu/kernel/process.c
+++ b/arch/m68knommu/kernel/process.c
@@ -29,6 +29,7 @@
 #include <linux/a.out.h>
 #include <linux/interrupt.h>
 #include <linux/reboot.h>
+#include <linux/tainted.h>
 
 #include <asm/uaccess.h>
 #include <asm/system.h>
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -20,6 +20,7 @@
 #include <linux/smp_lock.h>
 #include <linux/spinlock.h>
 #include <linux/kallsyms.h>
+#include <linux/tainted.h>
 
 #include <asm/bootinfo.h>
 #include <asm/branch.h>
--- a/arch/mips/sgi-ip27/ip27-nmi.c
+++ b/arch/mips/sgi-ip27/ip27-nmi.c
@@ -4,6 +4,7 @@
 #include <linux/nodemask.h>
 #include <linux/spinlock.h>
 #include <linux/smp.h>
+#include <linux/tainted.h>
 #include <asm/atomic.h>
 #include <asm/sn/types.h>
 #include <asm/sn/addrs.h>
--- a/arch/parisc/kernel/traps.c
+++ b/arch/parisc/kernel/traps.c
@@ -26,6 +26,7 @@
 #include <linux/interrupt.h>
 #include <linux/console.h>
 #include <linux/kallsyms.h>
+#include <linux/tainted.h>
 
 #include <asm/assembly.h>
 #include <asm/system.h>
--- a/arch/ppc/kernel/process.c
+++ b/arch/ppc/kernel/process.c
@@ -37,6 +37,7 @@
 #include <linux/kallsyms.h>
 #include <linux/mqueue.h>
 #include <linux/hardirq.h>
+#include <linux/tainted.h>
 
 #include <asm/pgtable.h>
 #include <asm/uaccess.h>
--- a/arch/ppc/kernel/traps.c
+++ b/arch/ppc/kernel/traps.c
@@ -31,6 +31,7 @@
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/prctl.h>
+#include <linux/tainted.h>
 
 #include <asm/pgtable.h>
 #include <asm/uaccess.h>
--- a/arch/ppc64/kernel/process.c
+++ b/arch/ppc64/kernel/process.c
@@ -37,6 +37,7 @@
 #include <linux/interrupt.h>
 #include <linux/utsname.h>
 #include <linux/kprobes.h>
+#include <linux/tainted.h>
 
 #include <asm/pgtable.h>
 #include <asm/uaccess.h>
--- a/arch/s390/kernel/process.c
+++ b/arch/s390/kernel/process.c
@@ -37,6 +37,7 @@
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/notifier.h>
+#include <linux/tainted.h>
 
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
--- a/arch/sh/kernel/process.c
+++ b/arch/sh/kernel/process.c
@@ -20,6 +20,7 @@
 #include <linux/ptrace.h>
 #include <linux/platform.h>
 #include <linux/kallsyms.h>
+#include <linux/tainted.h>
 
 #include <asm/io.h>
 #include <asm/uaccess.h>
--- a/arch/sparc/kernel/process.c
+++ b/arch/sparc/kernel/process.c
@@ -29,6 +29,7 @@
 #include <linux/delay.h>
 #include <linux/pm.h>
 #include <linux/init.h>
+#include <linux/tainted.h>
 
 #include <asm/auxio.h>
 #include <asm/oplib.h>
--- a/arch/sparc64/kernel/process.c
+++ b/arch/sparc64/kernel/process.c
@@ -31,6 +31,7 @@
 #include <linux/delay.h>
 #include <linux/compat.h>
 #include <linux/init.h>
+#include <linux/tainted.h>
 
 #include <asm/oplib.h>
 #include <asm/uaccess.h>
--- a/arch/sparc64/kernel/setup.c
+++ b/arch/sparc64/kernel/setup.c
@@ -32,6 +32,7 @@
 #include <linux/interrupt.h>
 #include <linux/cpu.h>
 #include <linux/initrd.h>
+#include <linux/tainted.h>
 
 #include <asm/system.h>
 #include <asm/io.h>
--- a/arch/um/sys-i386/sysrq.c
+++ b/arch/um/sys-i386/sysrq.c
@@ -8,6 +8,7 @@
 #include "linux/smp.h"
 #include "linux/sched.h"
 #include "linux/kallsyms.h"
+#include "linux/tainted.h"
 #include "asm/ptrace.h"
 #include "sysrq.h"
 
--- a/arch/um/sys-x86_64/sysrq.c
+++ b/arch/um/sys-x86_64/sysrq.c
@@ -7,6 +7,7 @@
 #include "linux/kernel.h"
 #include "linux/utsname.h"
 #include "linux/module.h"
+#include "linux/tainted.h"
 #include "asm/current.h"
 #include "asm/ptrace.h"
 #include "sysrq.h"
--- a/arch/x86_64/kernel/mce.c
+++ b/arch/x86_64/kernel/mce.c
@@ -18,6 +18,7 @@
 #include <linux/cpu.h>
 #include <linux/percpu.h>
 #include <linux/ctype.h>
+#include <linux/tainted.h>
 #include <asm/processor.h> 
 #include <asm/msr.h>
 #include <asm/mce.h>
--- a/arch/x86_64/kernel/mce_intel.c
+++ b/arch/x86_64/kernel/mce_intel.c
@@ -6,6 +6,7 @@
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/percpu.h>
+#include <linux/tainted.h>
 #include <asm/processor.h>
 #include <asm/msr.h>
 #include <asm/mce.h>
--- a/arch/x86_64/kernel/process.c
+++ b/arch/x86_64/kernel/process.c
@@ -36,6 +36,7 @@
 #include <linux/utsname.h>
 #include <linux/random.h>
 #include <linux/kprobes.h>
+#include <linux/tainted.h>
 
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -170,9 +170,6 @@ extern void bust_spinlocks(int yes);
 extern int oops_in_progress;		/* If set, an oops, panic(), BUG() or die() is in progress */
 extern int panic_timeout;
 extern int panic_on_oops;
-extern int tainted;
-extern const char *print_tainted(void);
-extern void add_taint(unsigned);
 
 /* Values used for system_state */
 extern enum system_states {
@@ -183,13 +180,6 @@ extern enum system_states {
 	SYSTEM_RESTART,
 } system_state;
 
-#define TAINT_PROPRIETARY_MODULE	(1<<0)
-#define TAINT_FORCED_MODULE		(1<<1)
-#define TAINT_UNSAFE_SMP		(1<<2)
-#define TAINT_FORCED_RMMOD		(1<<3)
-#define TAINT_MACHINE_CHECK		(1<<4)
-#define TAINT_BAD_PAGE			(1<<5)
-
 extern void dump_stack(void);
 
 #ifdef DEBUG
--- a/include/linux/tainted.h	1970-01-01 03:00:00.000000000 +0300
+++ b/include/linux/tainted.h	2005-09-14 01:29:18.000000000 +0400
@@ -0,0 +1,15 @@
+#ifndef __TAINTED_H__
+#define __TAINTED_H__
+
+#define TAINT_PROPRIETARY_MODULE	(1<<0)
+#define TAINT_FORCED_MODULE		(1<<1)
+#define TAINT_UNSAFE_SMP		(1<<2)
+#define TAINT_FORCED_RMMOD		(1<<3)
+#define TAINT_MACHINE_CHECK		(1<<4)
+#define TAINT_BAD_PAGE			(1<<5)
+
+extern int tainted;
+const char * print_tainted(void);
+void add_taint(unsigned);
+
+#endif
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -5,7 +5,7 @@
 obj-y     = sched.o fork.o exec_domain.o panic.o printk.o profile.o \
 	    exit.o itimer.o time.o softirq.o resource.o \
 	    sysctl.o capability.o ptrace.o timer.o user.o \
-	    signal.o sys.o kmod.o workqueue.o pid.o \
+	    signal.o sys.o kmod.o workqueue.o pid.o tainted.o \
 	    rcupdate.o intermodule.o extable.o params.o posix-timers.o \
 	    kthread.o wait.o kfifo.o sys_ni.o posix-cpu-timers.o
 
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -20,7 +20,7 @@
 #include <linux/module.h>
 #include <linux/moduleloader.h>
 #include <linux/init.h>
-#include <linux/kernel.h>
+#include <linux/tainted.h>
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
 #include <linux/elf.h>
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -22,7 +22,6 @@
 
 int panic_timeout;
 int panic_on_oops;
-int tainted;
 
 EXPORT_SYMBOL(panic_timeout);
 
@@ -137,39 +136,3 @@ NORET_TYPE void panic(const char * fmt, 
 }
 
 EXPORT_SYMBOL(panic);
-
-/**
- *	print_tainted - return a string to represent the kernel taint state.
- *
- *  'P' - Proprietary module has been loaded.
- *  'F' - Module has been forcibly loaded.
- *  'S' - SMP with CPUs not designed for SMP.
- *  'R' - User forced a module unload.
- *  'M' - Machine had a machine check experience.
- *  'B' - System has hit bad_page.
- *
- *	The string is overwritten by the next call to print_taint().
- */
- 
-const char *print_tainted(void)
-{
-	static char buf[20];
-	if (tainted) {
-		snprintf(buf, sizeof(buf), "Tainted: %c%c%c%c%c%c",
-			tainted & TAINT_PROPRIETARY_MODULE ? 'P' : 'G',
-			tainted & TAINT_FORCED_MODULE ? 'F' : ' ',
-			tainted & TAINT_UNSAFE_SMP ? 'S' : ' ',
-			tainted & TAINT_FORCED_RMMOD ? 'R' : ' ',
- 			tainted & TAINT_MACHINE_CHECK ? 'M' : ' ',
-			tainted & TAINT_BAD_PAGE ? 'B' : ' ');
-	}
-	else
-		snprintf(buf, sizeof(buf), "Not tainted");
-	return(buf);
-}
-
-void add_taint(unsigned flag)
-{
-	tainted |= flag;
-}
-EXPORT_SYMBOL(add_taint);
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -31,6 +31,7 @@
 #include <linux/smp_lock.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
+#include <linux/tainted.h>
 #include <linux/net.h>
 #include <linux/sysrq.h>
 #include <linux/highuid.h>
--- a/kernel/tainted.c	1970-01-01 03:00:00.000000000 +0300
+++ b/kernel/tainted.c	2005-09-14 01:29:18.000000000 +0400
@@ -0,0 +1,41 @@
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/tainted.h>
+
+int tainted;
+
+/**
+ * print_tainted - return a string to represent the kernel taint state.
+ *
+ * 'P' - Proprietary module has been loaded.
+ * 'F' - Module has been forcibly loaded.
+ * 'S' - SMP with CPUs not designed for SMP.
+ * 'R' - User forced a module unload.
+ * 'M' - Machine had a machine check experience.
+ * 'B' - System has hit bad_page.
+ *
+ * The string is overwritten by the next call to print_tainted().
+ */
+
+const char * print_tainted(void)
+{
+	static char buf[20];
+
+	if (tainted)
+		snprintf(buf, sizeof(buf), "Tainted: %c%c%c%c%c%c",
+			 tainted & TAINT_PROPRIETARY_MODULE ? 'P' : 'G',
+			 tainted & TAINT_FORCED_MODULE	    ? 'F' : ' ',
+			 tainted & TAINT_UNSAFE_SMP	    ? 'S' : ' ',
+			 tainted & TAINT_FORCED_RMMOD	    ? 'R' : ' ',
+			 tainted & TAINT_MACHINE_CHECK	    ? 'M' : ' ',
+			 tainted & TAINT_BAD_PAGE	    ? 'B' : ' ');
+	else
+		snprintf(buf, sizeof(buf), "Not tainted");
+	return buf;
+}
+
+void add_taint(unsigned flag)
+{
+	tainted |= flag;
+}
+EXPORT_SYMBOL(add_taint);
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -22,7 +22,7 @@
 #include <linux/pagemap.h>
 #include <linux/bootmem.h>
 #include <linux/compiler.h>
-#include <linux/kernel.h>
+#include <linux/tainted.h>
 #include <linux/module.h>
 #include <linux/suspend.h>
 #include <linux/pagevec.h>

