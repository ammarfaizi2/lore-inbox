Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129359AbQKJFCO>; Fri, 10 Nov 2000 00:02:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129786AbQKJFBz>; Fri, 10 Nov 2000 00:01:55 -0500
Received: from deliverator.sgi.com ([204.94.214.10]:3338 "EHLO
	deliverator.sgi.com") by vger.kernel.org with ESMTP
	id <S129359AbQKJFBv>; Fri, 10 Nov 2000 00:01:51 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: 2.4.0 console_loglevel cleanup
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 10 Nov 2000 16:01:41 +1100
Message-ID: <23405.973832501@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

25 separate source files declare extern int console_loglevel, many of
them define console_silent() and console_verbose() - unclean, unclean!

The patch against 2.4.0-test11-pre2 removes all the duplicate
declarations and adds console_loglevel, console_silent() and
console_verbose() to include/linux/kernel.h.  This is not important and
can wait for 2.4.[12], the only reason I am sending this out now is
because the patch hits multiple architectures.

Index: 0-test11-pre2.1/include/linux/kernel.h
--- 0-test11-pre2.1/include/linux/kernel.h Sat, 23 Sep 2000 11:16:56 +1100 kaos (linux-2.4/Z/50_kernel.h 1.1.1.2 644)
+++ 0-test11-pre2.1(w)/include/linux/kernel.h Fri, 10 Nov 2000 15:19:40 +1100 kaos (linux-2.4/Z/50_kernel.h 1.1.1.2 644)
@@ -63,6 +63,19 @@ extern int session_of_pgrp(int pgrp);
 asmlinkage int printk(const char * fmt, ...)
 	__attribute__ ((format (printf, 1, 2)));
 
+extern int console_loglevel;
+
+extern inline void console_silent(void)
+{
+	console_loglevel = 0;
+}
+
+extern inline void console_verbose(void)
+{
+	if (console_loglevel)
+		console_loglevel = 15;
+}
+
 #if DEBUG
 #define pr_debug(fmt,arg...) \
 	printk(KERN_DEBUG fmt,##arg)
Index: 0-test11-pre2.1/kernel/sysctl.c
--- 0-test11-pre2.1/kernel/sysctl.c Wed, 08 Nov 2000 11:52:15 +1100 kaos (linux-2.4/j/21_sysctl.c 1.1.1.4.1.2.1.2 644)
+++ 0-test11-pre2.1(w)/kernel/sysctl.c Fri, 10 Nov 2000 15:02:08 +1100 kaos (linux-2.4/j/21_sysctl.c 1.1.1.4.1.2.1.2 644)
@@ -41,7 +41,7 @@
 
 /* External variables not in a header file. */
 extern int panic_timeout;
-extern int console_loglevel, C_A_D;
+extern int C_A_D;
 extern int bdf_prm[], bdflush_min[], bdflush_max[];
 extern int sysctl_overcommit_memory;
 extern int max_threads;
Index: 0-test11-pre2.1/kernel/ksyms.c
--- 0-test11-pre2.1/kernel/ksyms.c Wed, 08 Nov 2000 11:52:15 +1100 kaos (linux-2.4/j/29_ksyms.c 1.1.2.5.2.3.1.7.1.8.2.2 644)
+++ 0-test11-pre2.1(w)/kernel/ksyms.c Fri, 10 Nov 2000 15:02:47 +1100 kaos (linux-2.4/j/29_ksyms.c 1.1.2.5.2.3.1.7.1.8.2.2 644)
@@ -53,7 +53,6 @@
 #include <linux/kmod.h>
 #endif
 
-extern int console_loglevel;
 extern void set_device_ro(kdev_t dev,int flag);
 
 extern void *sys_call_table;
Index: 0-test11-pre2.1/init/main.c
--- 0-test11-pre2.1/init/main.c Fri, 27 Oct 2000 22:11:48 +1100 kaos (linux-2.4/j/46_main.c 1.1.2.2.1.1.2.5.1.2.1.1.2.1.3.1 644)
+++ 0-test11-pre2.1(w)/init/main.c Fri, 10 Nov 2000 15:03:06 +1100 kaos (linux-2.4/j/46_main.c 1.1.2.2.1.1.2.5.1.2.1.1.2.1.3.1 644)
@@ -80,8 +80,6 @@ extern void nubus_init(void);
 extern char _stext, _etext;
 extern char *linux_banner;
 
-extern int console_loglevel;
-
 static int init(void *);
 
 extern void init_IRQ(void);
Index: 0-test11-pre2.1/include/asm-sh/page.h
--- 0-test11-pre2.1/include/asm-sh/page.h Tue, 03 Oct 2000 12:24:51 +1100 kaos (linux-2.4/r/11_page.h 1.3 644)
+++ 0-test11-pre2.1(w)/include/asm-sh/page.h Fri, 10 Nov 2000 15:03:21 +1100 kaos (linux-2.4/r/11_page.h 1.3 644)
@@ -76,8 +76,6 @@ typedef struct { unsigned long pgprot; }
 
 #ifndef __ASSEMBLY__
 
-extern int console_loglevel;
-
 /*
  * Tell the user there is some problem.
  */
Index: 0-test11-pre2.1/include/asm-i386/page.h
--- 0-test11-pre2.1/include/asm-i386/page.h Thu, 19 Oct 2000 11:08:42 +1100 kaos (linux-2.4/P/20_page.h 1.4 644)
+++ 0-test11-pre2.1(w)/include/asm-i386/page.h Fri, 10 Nov 2000 15:23:18 +1100 kaos (linux-2.4/P/20_page.h 1.4 644)
@@ -82,8 +82,6 @@ typedef struct { unsigned long pgprot; }
 
 #ifndef __ASSEMBLY__
 
-extern int console_loglevel;
-
 /*
  * Tell the user there is some problem. Beep too, so we can
  * see^H^H^Hhear bugs in early bootup as well!
Index: 0-test11-pre2.1/fs/ntfs/fs.c
--- 0-test11-pre2.1/fs/ntfs/fs.c Thu, 19 Oct 2000 11:08:42 +1100 kaos (linux-2.4/c/b/13_fs.c 1.1.1.1.1.7 644)
+++ 0-test11-pre2.1(w)/fs/ntfs/fs.c Fri, 10 Nov 2000 15:16:55 +1100 kaos (linux-2.4/c/b/13_fs.c 1.1.1.1.1.7 644)
@@ -935,8 +935,7 @@ static int __init init_ntfs_fs(void)
 	/* Comment this if you trust klogd. There are reasons not to trust it
 	 */
 #if defined(DEBUG) && !defined(MODULE)
-	extern int console_loglevel;
-	console_loglevel=15;
+	console_verbose();
 #endif
 	printk(KERN_NOTICE "NTFS version " NTFS_VERSION "\n");
 	SYSCTL(1);
Index: 0-test11-pre2.1/drivers/nubus/nubus.c
--- 0-test11-pre2.1/drivers/nubus/nubus.c Fri, 26 May 2000 13:10:01 +1000 kaos (linux-2.4/o/b/27_nubus.c 1.1 644)
+++ 0-test11-pre2.1(w)/drivers/nubus/nubus.c Fri, 10 Nov 2000 15:04:09 +1100 kaos (linux-2.4/o/b/27_nubus.c 1.1 644)
@@ -27,8 +27,6 @@
 extern void via_nubus_init(void);
 extern void oss_nubus_init(void);
 
-extern int console_loglevel;
-
 /* Constants */
 
 /* This is, of course, the size in bytelanes, rather than the size in
Index: 0-test11-pre2.1/drivers/macintosh/via-macii.c
--- 0-test11-pre2.1/drivers/macintosh/via-macii.c Fri, 26 May 2000 13:10:01 +1000 kaos (linux-2.4/p/b/9_via-macii. 1.1 644)
+++ 0-test11-pre2.1(w)/drivers/macintosh/via-macii.c Fri, 10 Nov 2000 15:04:46 +1100 kaos (linux-2.4/p/b/9_via-macii. 1.1 644)
@@ -125,7 +125,6 @@ static int last_status;
 static int driver_running = 0;
 
 /* debug level 10 required for ADB logging (should be && debug_adb, ideally) */
-extern int console_loglevel;
 
 /* Check for MacII style ADB */
 static int macii_probe(void)
Index: 0-test11-pre2.1/drivers/macintosh/mac_keyb.c
--- 0-test11-pre2.1/drivers/macintosh/mac_keyb.c Tue, 19 Sep 2000 10:21:53 +1100 kaos (linux-2.4/p/b/17_mac_keyb.c 1.1.1.2 644)
+++ 0-test11-pre2.1(w)/drivers/macintosh/mac_keyb.c Fri, 10 Nov 2000 15:04:53 +1100 kaos (linux-2.4/p/b/17_mac_keyb.c 1.1.1.2 644)
@@ -255,8 +255,6 @@ int adb_button2_keycode = 0x7d;	/* right
 int adb_button3_keycode = 0x7c; /* right option key */
 #endif
 
-extern int console_loglevel;
-
 extern struct kbd_struct kbd_table[];
 extern wait_queue_head_t keypress_wait;
 
Index: 0-test11-pre2.1/drivers/char/adbmouse.c
--- 0-test11-pre2.1/drivers/char/adbmouse.c Wed, 21 Jun 2000 12:29:46 +1000 kaos (linux-2.4/L/b/51_adbmouse.c 1.1.1.1 644)
+++ 0-test11-pre2.1(w)/drivers/char/adbmouse.c Fri, 10 Nov 2000 15:05:01 +1100 kaos (linux-2.4/L/b/51_adbmouse.c 1.1.1.1 644)
@@ -53,7 +53,6 @@ extern void (*adb_mouse_interrupt_hook)(
 extern int adb_emulate_buttons;
 extern int adb_button2_keycode;
 extern int adb_button3_keycode;
-extern int console_loglevel;
 
 /*
  *    XXX: need to figure out what ADB mouse packets mean ... 
Index: 0-test11-pre2.1/drivers/char/sysrq.c
--- 0-test11-pre2.1/drivers/char/sysrq.c Thu, 19 Oct 2000 11:08:42 +1100 kaos (linux-2.4/N/b/19_sysrq.c 1.3 644)
+++ 0-test11-pre2.1(w)/drivers/char/sysrq.c Fri, 10 Nov 2000 15:05:09 +1100 kaos (linux-2.4/N/b/19_sysrq.c 1.3 644)
@@ -27,7 +27,6 @@
 
 extern void wakeup_bdflush(int);
 extern void reset_vc(unsigned int);
-extern int console_loglevel;
 extern struct list_head super_blocks;
 
 /* Whether we react on sysrq keys or just ignore them */
Index: 0-test11-pre2.1/drivers/net/daynaport.c
--- 0-test11-pre2.1/drivers/net/daynaport.c Thu, 19 Oct 2000 11:08:42 +1100 kaos (linux-2.4/R/b/50_daynaport. 1.1.1.2 644)
+++ 0-test11-pre2.1(w)/drivers/net/daynaport.c Fri, 10 Nov 2000 15:05:14 +1100 kaos (linux-2.4/R/b/50_daynaport. 1.1.1.2 644)
@@ -44,8 +44,6 @@ static int version_printed;
 #include <linux/etherdevice.h>
 #include "8390.h"
 
-extern int console_loglevel;
-
 int ns8390_probe1(struct net_device *dev, int word16, char *name, int id,
 				  int prom, struct nubus_dev *ndev);
 
Index: 0-test11-pre2.1/arch/s390/kernel/traps.c
--- 0-test11-pre2.1/arch/s390/kernel/traps.c Wed, 21 Jun 2000 12:18:25 +1000 kaos (linux-2.4/Y/b/21_traps.c 1.1.1.1 644)
+++ 0-test11-pre2.1(w)/arch/s390/kernel/traps.c Fri, 10 Nov 2000 15:17:36 +1100 kaos (linux-2.4/Y/b/21_traps.c 1.1.1.1 644)
@@ -47,12 +47,6 @@ extern pgm_check_handler_t do_page_fault
 
 asmlinkage int system_call(void);
 
-static inline void console_verbose(void)
-{
-        extern int console_loglevel;
-        console_loglevel = 15;
-}
-
 #define DO_ERROR(trapnr, signr, str, name, tsk) \
 asmlinkage void name(struct pt_regs * regs, long error_code) \
 { \
Index: 0-test11-pre2.1/arch/mips64/kernel/traps.c
--- 0-test11-pre2.1/arch/mips64/kernel/traps.c Tue, 11 Jul 2000 00:21:05 +1000 kaos (linux-2.4/a/c/15_traps.c 1.2 644)
+++ 0-test11-pre2.1(w)/arch/mips64/kernel/traps.c Fri, 10 Nov 2000 15:17:46 +1100 kaos (linux-2.4/a/c/15_traps.c 1.2 644)
@@ -27,19 +27,6 @@
 #include <asm/uaccess.h>
 #include <asm/mmu_context.h>
 
-extern int console_loglevel;
-
-static inline void console_silent(void)
-{
-	console_loglevel = 0;
-}
-
-static inline void console_verbose(void)
-{
-	if (console_loglevel)
-		console_loglevel = 15;
-}
-
 extern asmlinkage void __xtlb_mod(void);
 extern asmlinkage void __xtlb_tlbl(void);
 extern asmlinkage void __xtlb_tlbs(void);
Index: 0-test11-pre2.1/arch/sh/kernel/traps.c
--- 0-test11-pre2.1/arch/sh/kernel/traps.c Tue, 03 Oct 2000 12:24:51 +1100 kaos (linux-2.4/d/c/13_traps.c 1.1.1.1 644)
+++ 0-test11-pre2.1(w)/arch/sh/kernel/traps.c Fri, 10 Nov 2000 15:17:52 +1100 kaos (linux-2.4/d/c/13_traps.c 1.1.1.1 644)
@@ -28,12 +28,6 @@
 #include <asm/atomic.h>
 #include <asm/processor.h>
 
-static inline void console_verbose(void)
-{
-	extern int console_loglevel;
-	console_loglevel = 15;
-}
-
 #define DO_ERROR(trapnr, signr, str, name, tsk) \
 asmlinkage void do_##name(unsigned long r4, unsigned long r5, \
 			  unsigned long r6, unsigned long r7, \
Index: 0-test11-pre2.1/arch/arm/kernel/traps.c
--- 0-test11-pre2.1/arch/arm/kernel/traps.c Tue, 19 Sep 2000 10:36:07 +1100 kaos (linux-2.4/f/c/46_traps.c 1.3.1.2 644)
+++ 0-test11-pre2.1(w)/arch/arm/kernel/traps.c Fri, 10 Nov 2000 15:18:00 +1100 kaos (linux-2.4/f/c/46_traps.c 1.3.1.2 644)
@@ -41,12 +41,6 @@ const char *processor_modes[]=
 
 static const char *handler[]= { "prefetch abort", "data abort", "address exception", "interrupt" };
 
-static inline void console_verbose(void)
-{
-	extern int console_loglevel;
-	console_loglevel = 15;
-}
-
 /*
  * Stack pointers should always be within the kernels view of
  * physical memory.  If it is not there, then we can't dump
Index: 0-test11-pre2.1/arch/m68k/mac/via.c
--- 0-test11-pre2.1/arch/m68k/mac/via.c Fri, 26 May 2000 13:10:01 +1000 kaos (linux-2.4/j/c/36_via.c 1.1 644)
+++ 0-test11-pre2.1(w)/arch/m68k/mac/via.c Fri, 10 Nov 2000 15:05:50 +1100 kaos (linux-2.4/j/c/36_via.c 1.1 644)
@@ -74,7 +74,6 @@ void via_irq_clear(int irq);
 
 extern void mac_bang(int, void *, struct pt_regs *);
 extern void mac_scc_dispatch(int, void *, struct pt_regs *);
-extern int console_loglevel;
 extern int oss_present;
 
 /*
Index: 0-test11-pre2.1/arch/m68k/mac/psc.c
--- 0-test11-pre2.1/arch/m68k/mac/psc.c Fri, 26 May 2000 13:10:01 +1000 kaos (linux-2.4/j/c/37_psc.c 1.1 644)
+++ 0-test11-pre2.1(w)/arch/m68k/mac/psc.c Fri, 10 Nov 2000 15:05:54 +1100 kaos (linux-2.4/j/c/37_psc.c 1.1 644)
@@ -32,8 +32,6 @@ volatile __u8 *psc;
 
 void psc_irq(int, void *, struct pt_regs *);
 
-extern int console_loglevel;
-
 /*
  * Debugging dump, used in various places to see what's going on.
  */
Index: 0-test11-pre2.1/arch/m68k/mac/oss.c
--- 0-test11-pre2.1/arch/m68k/mac/oss.c Fri, 26 May 2000 13:10:01 +1000 kaos (linux-2.4/j/c/38_oss.c 1.1 644)
+++ 0-test11-pre2.1(w)/arch/m68k/mac/oss.c Fri, 10 Nov 2000 15:06:00 +1100 kaos (linux-2.4/j/c/38_oss.c 1.1 644)
@@ -35,7 +35,6 @@ void oss_nubus_irq(int, void *, struct p
 
 extern void via1_irq(int, void *, struct pt_regs *);
 extern void mac_scc_dispatch(int, void *, struct pt_regs *);
-extern int console_loglevel;
 
 /*
  * Initialize the OSS
Index: 0-test11-pre2.1/arch/m68k/mac/macints.c
--- 0-test11-pre2.1/arch/m68k/mac/macints.c Fri, 26 May 2000 13:10:01 +1000 kaos (linux-2.4/j/c/44_macints.c 1.1 644)
+++ 0-test11-pre2.1(w)/arch/m68k/mac/macints.c Fri, 10 Nov 2000 15:06:13 +1100 kaos (linux-2.4/j/c/44_macints.c 1.1 644)
@@ -211,8 +211,6 @@ static void scc_irq_disable(int);
  * console_loglevel determines NMI handler function
  */
 
-extern int console_loglevel;
-
 extern void mac_bang(int, void *, struct pt_regs *);
 
 void mac_nmi_handler(int, void *, struct pt_regs *);
Index: 0-test11-pre2.1/arch/m68k/mac/baboon.c
--- 0-test11-pre2.1/arch/m68k/mac/baboon.c Fri, 26 May 2000 13:10:01 +1000 kaos (linux-2.4/j/c/47_baboon.c 1.1 644)
+++ 0-test11-pre2.1(w)/arch/m68k/mac/baboon.c Fri, 10 Nov 2000 15:06:17 +1100 kaos (linux-2.4/j/c/47_baboon.c 1.1 644)
@@ -27,8 +27,6 @@ volatile struct baboon *baboon;
 
 void baboon_irq(int, void *, struct pt_regs *);
 
-extern int console_loglevel;
-
 extern int macide_ack_intr(ide_hwif_t *);
 
 /*
Index: 0-test11-pre2.1/arch/m68k/mac/config.c
--- 0-test11-pre2.1/arch/m68k/mac/config.c Thu, 19 Oct 2000 11:08:42 +1100 kaos (linux-2.4/j/c/48_config.c 1.2 644)
+++ 0-test11-pre2.1(w)/arch/m68k/mac/config.c Fri, 10 Nov 2000 15:06:21 +1100 kaos (linux-2.4/j/c/48_config.c 1.2 644)
@@ -118,8 +118,6 @@ static void mac_sched_init(void (*vector
 	via_init_clock(vector);
 }
 
-extern int console_loglevel;
-
 #if 0
 void mac_waitbut (void)
 {
Index: 0-test11-pre2.1/arch/m68k/kernel/traps.c
--- 0-test11-pre2.1/arch/m68k/kernel/traps.c Fri, 26 May 2000 13:10:01 +1000 kaos (linux-2.4/l/c/37_traps.c 1.1 644)
+++ 0-test11-pre2.1(w)/arch/m68k/kernel/traps.c Fri, 10 Nov 2000 15:18:19 +1100 kaos (linux-2.4/l/c/37_traps.c 1.1 644)
@@ -151,12 +151,6 @@ void __init trap_init (void)
 }
 
 
-static inline void console_verbose(void)
-{
-	extern int console_loglevel;
-	console_loglevel = 15;
-}
-
 
 static char *vec_names[] = {
 	"RESET SP", "RESET PC", "BUS ERROR", "ADDRESS ERROR",
Index: 0-test11-pre2.1/arch/mips/kernel/traps.c
--- 0-test11-pre2.1/arch/mips/kernel/traps.c Tue, 11 Jul 2000 00:21:05 +1000 kaos (linux-2.4/u/c/27_traps.c 1.2 644)
+++ 0-test11-pre2.1(w)/arch/mips/kernel/traps.c Fri, 10 Nov 2000 15:18:36 +1100 kaos (linux-2.4/u/c/27_traps.c 1.2 644)
@@ -27,19 +27,6 @@
 #include <asm/uaccess.h>
 #include <asm/mmu_context.h>
 
-extern int console_loglevel;
-
-static inline void console_silent(void)
-{
-	console_loglevel = 0;
-}
-
-static inline void console_verbose(void)
-{
-	if (console_loglevel)
-		console_loglevel = 15;
-}
-
 /*
  * Machine specific interrupt handlers
  */
Index: 0-test11-pre2.1/arch/i386/kernel/traps.c
--- 0-test11-pre2.1/arch/i386/kernel/traps.c Fri, 10 Nov 2000 13:10:37 +1100 kaos (linux-2.4/A/c/1_traps.c 1.1.2.2.1.1.2.1.2.3.1.2.3.1.1.2 644)
+++ 0-test11-pre2.1(w)/arch/i386/kernel/traps.c Fri, 10 Nov 2000 15:59:22 +1100 kaos (linux-2.4/A/c/1_traps.c 1.1.2.2.1.1.2.1.2.3.1.2.3.1.1.2 644)
@@ -62,19 +62,6 @@ struct desc_struct default_ldt[] = { { 0
  */
 struct desc_struct idt_table[256] __attribute__((__section__(".data.idt"))) = { {0, 0}, };
 
-extern int console_loglevel;
-
-static inline void console_silent(void)
-{
-	console_loglevel = 0;
-}
-
-static inline void console_verbose(void)
-{
-	if (console_loglevel)
-		console_loglevel = 15;
-}
-
 asmlinkage void divide_error(void);
 asmlinkage void debug(void);
 asmlinkage void nmi(void);

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
