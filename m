Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269537AbUINRsY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269537AbUINRsY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 13:48:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269521AbUINRqE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 13:46:04 -0400
Received: from [12.177.129.25] ([12.177.129.25]:26307 "EHLO
	ccure.user-mode-linux.org") by vger.kernel.org with ESMTP
	id S269515AbUINRn4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 13:43:56 -0400
Message-Id: <200409141847.i8EIlS4W003417@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.1-RC1
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] UML - Convert the real-time clock to gettimeofday from rdtsc
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 14 Sep 2004 14:47:28 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There are a whole bunch of reasons to use gettimeofday rather than rdtsc,
so this patch does just that.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: 2.6.9-rc2/arch/um/include/os.h
===================================================================
--- 2.6.9-rc2.orig/arch/um/include/os.h	2004-09-14 13:30:30.000000000 -0400
+++ 2.6.9-rc2/arch/um/include/os.h	2004-09-14 13:30:33.000000000 -0400
@@ -166,6 +166,7 @@
 			     int r, int w, int x);
 extern int os_unmap_memory(void *addr, int len);
 extern void os_flush_stdout(void);
+extern unsigned long long os_usecs(void);
 
 #endif
 
Index: 2.6.9-rc2/arch/um/kernel/time.c
===================================================================
--- 2.6.9-rc2.orig/arch/um/kernel/time.c	2004-09-14 13:30:30.000000000 -0400
+++ 2.6.9-rc2/arch/um/kernel/time.c	2004-09-14 13:30:33.000000000 -0400
@@ -10,7 +10,6 @@
 #include <sys/time.h>
 #include <signal.h>
 #include <errno.h>
-#include <string.h>
 #include "user_util.h"
 #include "kern_util.h"
 #include "user.h"
@@ -95,49 +94,12 @@
 	set_interval(ITIMER_REAL);
 }
 
-static unsigned long long get_host_hz(void)
-{
-	char mhzline[16], *end;
-	unsigned long long mhz;
-	int ret, mult, rest, len;
-
-	ret = cpu_feature("cpu MHz", mhzline,
-			  sizeof(mhzline) / sizeof(mhzline[0]));
-	if(!ret)
-		panic ("Could not get host MHZ");
-
-	mhz = strtoul(mhzline, &end, 10);
-
-	/* This business is to parse a floating point number without using
-	 * floating types.
-	 */
-
-	rest = 0;
-	mult = 0;
-	if(*end == '.'){
-		end++;
-		len = strlen(end);
-		if(len < 6)
-			mult = 6 - len;
-		else if(len > 6)
-			end[6] = '\0';
-		rest = strtoul(end, NULL, 10);
-		while(mult-- > 0)
-			rest *= 10;
-	}
-
-	return(1000000 * mhz + rest);
-}
-
-unsigned long long host_hz = 0;
-
 extern int do_posix_clock_monotonic_gettime(struct timespec *tp);
 
 void time_init(void)
 {
 	struct timespec now;
 
-	host_hz = get_host_hz();
 	if(signal(SIGVTALRM, boot_timer_handler) == SIG_ERR)
 		panic("Couldn't set SIGVTALRM handler");
 	set_interval(ITIMER_VIRTUAL);
Index: 2.6.9-rc2/arch/um/kernel/time_kern.c
===================================================================
--- 2.6.9-rc2.orig/arch/um/kernel/time_kern.c	2004-09-14 13:30:23.000000000 -0400
+++ 2.6.9-rc2/arch/um/kernel/time_kern.c	2004-09-14 13:30:33.000000000 -0400
@@ -20,6 +20,7 @@
 #include "user_util.h"
 #include "time_user.h"
 #include "mode.h"
+#include "os.h"
 
 u64 jiffies_64;
 
@@ -42,12 +43,10 @@
 int timer_irq_inited = 0;
 
 static int first_tick;
-static unsigned long long prev_tsc;
-#ifdef CONFIG_UML_REAL_TIME_CLOCK
+static unsigned long long prev_usecs;
 static long long delta;   		/* Deviation per interval */
-#endif
 
-extern unsigned long long host_hz;
+#define MILLION 1000000
 
 void timer_irq(union uml_pt_regs *regs)
 {
@@ -61,22 +60,25 @@
 	}
 
 	if(first_tick){
-#ifdef CONFIG_UML_REAL_TIME_CLOCK
-		unsigned long long tsc;
+#if defined(CONFIG_UML_REAL_TIME_CLOCK)
 		/* We've had 1 tick */
-		tsc = time_stamp();
+		unsigned long long usecs = os_usecs();
+
+		delta += usecs - prev_usecs;
+		prev_usecs = usecs;
 
-		delta += tsc - prev_tsc;
-		prev_tsc = tsc;
+		/* Protect against the host clock being set backwards */
+		if(delta < 0)
+			delta = 0;
 
-		ticks += (delta * HZ) / host_hz;
-		delta -= (ticks * host_hz) / HZ;
+		ticks += (delta * HZ) / MILLION;
+		delta -= (ticks * MILLION) / HZ;
 #else
 		ticks = 1;
 #endif
 	}
 	else {
-		prev_tsc = time_stamp();
+		prev_usecs = os_usecs();
 		first_tick = 1;
 	}
 
@@ -151,7 +153,7 @@
 {
 	int i, n;
 
-	n = (loops_per_jiffy * HZ * usecs) / 1000000;
+	n = (loops_per_jiffy * HZ * usecs) / MILLION;
 	for(i=0;i<n;i++) ;
 }
 
@@ -159,7 +161,7 @@
 {
 	int i, n;
 
-	n = (loops_per_jiffy * HZ * usecs) / 1000000;
+	n = (loops_per_jiffy * HZ * usecs) / MILLION;
 	for(i=0;i<n;i++) ;
 }
 
Index: 2.6.9-rc2/arch/um/os-Linux/Makefile
===================================================================
--- 2.6.9-rc2.orig/arch/um/os-Linux/Makefile	2004-09-14 13:30:23.000000000 -0400
+++ 2.6.9-rc2/arch/um/os-Linux/Makefile	2004-09-14 13:30:33.000000000 -0400
@@ -3,9 +3,9 @@
 # Licensed under the GPL
 #
 
-obj-y = file.o process.o tty.o user_syms.o drivers/
+obj-y = file.o process.o time.o tty.o user_syms.o drivers/
 
-USER_OBJS := $(foreach file,file.o process.o tty.o,$(obj)/$(file))
+USER_OBJS := $(foreach file,file.o process.o time.o tty.o,$(obj)/$(file))
 
 $(USER_OBJS) : %.o: %.c
 	$(CC) $(CFLAGS_$(notdir $@)) $(USER_CFLAGS) -c -o $@ $<
Index: 2.6.9-rc2/arch/um/os-Linux/time.c
===================================================================
--- 2.6.9-rc2.orig/arch/um/os-Linux/time.c	2003-09-15 09:40:47.000000000 -0400
+++ 2.6.9-rc2/arch/um/os-Linux/time.c	2004-09-14 13:30:33.000000000 -0400
@@ -0,0 +1,21 @@
+#include <stdlib.h>
+#include <sys/time.h>
+
+unsigned long long os_usecs(void)
+{
+	struct timeval tv;
+
+	gettimeofday(&tv, NULL);
+	return((unsigned long long) tv.tv_sec * 1000000 + tv.tv_usec);
+}
+
+/*
+ * Overrides for Emacs so that we follow Linus's tabbing style.
+ * Emacs will notice this stuff at the end of the file and automatically
+ * adjust the settings for this buffer only.  This must remain at the end
+ * of the file.
+ * ---------------------------------------------------------------------------
+ * Local variables:
+ * c-file-style: "linux"
+ * End:
+ */
Index: 2.6.9-rc2/arch/um/sys-i386/Makefile
===================================================================
--- 2.6.9-rc2.orig/arch/um/sys-i386/Makefile	2004-09-14 13:30:23.000000000 -0400
+++ 2.6.9-rc2/arch/um/sys-i386/Makefile	2004-09-14 13:30:33.000000000 -0400
@@ -1,5 +1,5 @@
 obj-y = bitops.o bugs.o checksum.o fault.o ksyms.o ldt.o ptrace.o \
-	ptrace_user.o semaphore.o sigcontext.o syscalls.o sysrq.o time.o
+	ptrace_user.o semaphore.o sigcontext.o syscalls.o sysrq.o
 
 obj-$(CONFIG_HIGHMEM) += highmem.o
 obj-$(CONFIG_MODULES) += module.o
Index: 2.6.9-rc2/arch/um/sys-i386/time.c
===================================================================
--- 2.6.9-rc2.orig/arch/um/sys-i386/time.c	2004-09-14 13:30:23.000000000 -0400
+++ 2.6.9-rc2/arch/um/sys-i386/time.c	2003-09-15 09:40:47.000000000 -0400
@@ -1,24 +0,0 @@
-/*
- * sys-i386/time.c
- * Created 		25.9.2002	Sapan Bhatia
- *
- */
-
-unsigned long long time_stamp(void)
-{
-	unsigned long low, high;
-
-	asm("rdtsc" : "=a" (low), "=d" (high));
-	return((((unsigned long long) high) << 32) + low);
-}
-
-/*
- * Overrides for Emacs so that we follow Linus's tabbing style.
- * Emacs will notice this stuff at the end of the file and automatically
- * adjust the settings for this buffer only.  This must remain at the end
- * of the file.
- * ---------------------------------------------------------------------------
- * Local variables:
- * c-file-style: "linux"
- * End:
- */

