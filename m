Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266777AbUF3RJQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266777AbUF3RJQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 13:09:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266787AbUF3RJP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 13:09:15 -0400
Received: from mtagate2.de.ibm.com ([195.212.29.151]:24556 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP id S266777AbUF3RG5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 13:06:57 -0400
Date: Wed, 30 Jun 2004 19:07:20 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] s390: core changes.
Message-ID: <20040630170720.GC3189@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] s390: core changes.

From: Arnd Bergmann <arndb@de.ibm.com>
From: Christian Bornträger <cborntra@de.ibm.com>
From: Michael Holzheu <holzheu@de.ibm.com>
From: Martin Schwidefsky <schwidefsky@de.ibm.com>

s390 core changes:
 - Fix cpu_idle loop if /proc/sys/kernel/hz_timer is set.
 - Store correct trap indication on 64 bit for call to do_debugger_trap
   in the single stepped svc code.
 - Avoid the use of alloca in the debug feature.
 - Remove extraneous includes of linux/version.h.
 - Regenerate default configuration.
 - Mention eServer z890 in Kconfig help text.
 - Prevent gcc 3.4 from removing statically defined per cpu variables.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

diffstat:
 arch/s390/Kconfig          |    6 +-
 arch/s390/defconfig        |   19 +++++--
 arch/s390/kernel/debug.c   |  120 ++++++++++++++++++++++++---------------------
 arch/s390/kernel/entry64.S |    3 -
 arch/s390/kernel/time.c    |   11 +---
 include/asm-s390/debug.h   |    1 
 include/asm-s390/percpu.h  |   68 ++++++++++++++++++++-----
 include/asm-s390/vtoc.h    |    1 
 8 files changed, 144 insertions(+), 85 deletions(-)

diff -urN linux-2.6/arch/s390/Kconfig linux-2.6-s390/arch/s390/Kconfig
--- linux-2.6/arch/s390/Kconfig	Wed Jun 16 07:19:13 2004
+++ linux-2.6-s390/arch/s390/Kconfig	Wed Jun 30 17:06:34 2004
@@ -67,9 +67,9 @@
 	  on older 31 bit only CPUs.
 
 config MARCH_Z990
-	bool "IBM eServer zSeries model z990"
+	bool "IBM eServer zSeries model z890 and z990"
 	help
-	  Select this enable optimizations for model z990.
+	  Select this enable optimizations for model z890/z990.
 	  This will be slightly faster but does not work on
 	  older machines such as the z900.
 
@@ -154,7 +154,7 @@
 	tristate "QDIO support"
 	---help---
 	  This driver provides the Queued Direct I/O base support for the
-	  IBM S/390 (G5 and G6) and eServer zSeries (z800, z900 and z990).
+	  IBM S/390 (G5 and G6) and eServer zSeries (z800, z890, z900 and z990).
 
 	  For details please refer to the documentation provided by IBM at
 	  <http://www10.software.ibm.com/developerworks/opensource/linux390>
diff -urN linux-2.6/arch/s390/defconfig linux-2.6-s390/arch/s390/defconfig
--- linux-2.6/arch/s390/defconfig	Wed Jun 30 17:06:11 2004
+++ linux-2.6-s390/arch/s390/defconfig	Wed Jun 30 17:06:34 2004
@@ -29,6 +29,7 @@
 # CONFIG_EMBEDDED is not set
 CONFIG_KALLSYMS=y
 # CONFIG_KALLSYMS_ALL is not set
+# CONFIG_KALLSYMS_EXTRA_PASS is not set
 CONFIG_FUTEX=y
 CONFIG_EPOLL=y
 CONFIG_IOSCHED_NOOP=y
@@ -45,6 +46,7 @@
 CONFIG_OBSOLETE_MODPARM=y
 # CONFIG_MODVERSIONS is not set
 CONFIG_KMOD=y
+CONFIG_STOP_MACHINE=y
 
 #
 # Base setup
@@ -84,12 +86,14 @@
 # CONFIG_SHARED_KERNEL is not set
 # CONFIG_CMM is not set
 # CONFIG_VIRT_TIMER is not set
-# CONFIG_NO_IDLE_HZ is not set
+CONFIG_NO_IDLE_HZ=y
+CONFIG_NO_IDLE_HZ_INIT=y
 # CONFIG_PCMCIA is not set
 
 #
 # Generic Driver Options
 #
+CONFIG_PREVENT_FIRMWARE_BUILD=y
 # CONFIG_FW_LOADER is not set
 # CONFIG_DEBUG_DRIVER is not set
 
@@ -126,7 +130,6 @@
 # SCSI low-level drivers
 #
 # CONFIG_SCSI_AIC7XXX_OLD is not set
-# CONFIG_SCSI_DPT_I2O is not set
 # CONFIG_SCSI_SATA is not set
 # CONFIG_SCSI_EATA_PIO is not set
 # CONFIG_SCSI_DEBUG is not set
@@ -277,6 +280,7 @@
 CONFIG_NET_SCH_GRED=m
 CONFIG_NET_SCH_DSMARK=m
 # CONFIG_NET_SCH_DELAY is not set
+# CONFIG_NET_SCH_INGRESS is not set
 CONFIG_NET_QOS=y
 CONFIG_NET_ESTIMATOR=y
 CONFIG_NET_CLS=y
@@ -285,8 +289,11 @@
 CONFIG_NET_CLS_ROUTE=y
 CONFIG_NET_CLS_FW=m
 CONFIG_NET_CLS_U32=m
+# CONFIG_CLS_U32_PERF is not set
+# CONFIG_NET_CLS_IND is not set
 CONFIG_NET_CLS_RSVP=m
 CONFIG_NET_CLS_RSVP6=m
+# CONFIG_NET_CLS_ACT is not set
 CONFIG_NET_CLS_POLICE=y
 
 #
@@ -311,7 +318,11 @@
 # CONFIG_MII is not set
 
 #
-# Gigabit Ethernet (1000/10000 Mbit)
+# Ethernet (1000 Mbit)
+#
+
+#
+# Ethernet (10000 Mbit)
 #
 
 #
@@ -450,7 +461,6 @@
 # CONFIG_SOLARIS_X86_PARTITION is not set
 # CONFIG_UNIXWARE_DISKLABEL is not set
 # CONFIG_LDM_PARTITION is not set
-# CONFIG_NEC98_PARTITION is not set
 # CONFIG_SGI_PARTITION is not set
 # CONFIG_ULTRIX_PARTITION is not set
 # CONFIG_SUN_PARTITION is not set
@@ -509,5 +519,6 @@
 #
 # Library routines
 #
+# CONFIG_CRC16 is not set
 # CONFIG_CRC32 is not set
 # CONFIG_LIBCRC32C is not set
diff -urN linux-2.6/arch/s390/kernel/debug.c linux-2.6-s390/arch/s390/kernel/debug.c
--- linux-2.6/arch/s390/kernel/debug.c	Wed Jun 16 07:18:58 2004
+++ linux-2.6-s390/arch/s390/kernel/debug.c	Wed Jun 30 17:06:34 2004
@@ -54,7 +54,7 @@
          *
          */
 	long args[0];
-} debug_sprintf_entry;
+} debug_sprintf_entry_t;
 
 
 extern void tod_to_timeval(uint64_t todval, struct timeval *xtime);
@@ -88,7 +88,7 @@
                          int area, debug_entry_t * entry, char *out_buf);
 
 static int debug_sprintf_format_fn(debug_info_t * id, struct debug_view *view,
-				   char *out_buf, debug_sprintf_entry *curr_event);
+				   char *out_buf, debug_sprintf_entry_t *curr_event);
 
 /* globals */
 
@@ -692,31 +692,21 @@
 }
 
 /*
- * debug_common:
+ * debug_finish_entry:
  * - set timestamp, caller address, cpu number etc.
  */
 
-extern inline debug_entry_t *debug_common(debug_info_t * id, int level, 
-                                    const void *buf, int len, int exception)
+extern inline void debug_finish_entry(debug_info_t * id, debug_entry_t* active,
+		int level, int exception)
 {
-	unsigned long flags;
-	debug_entry_t *active;
-
-	spin_lock_irqsave(&id->lock, flags);
-	active = get_active_entry(id);
 	STCK(active->id.stck);
 	active->id.fields.cpuid = smp_processor_id();
 	active->caller = __builtin_return_address(0);
 	active->id.fields.exception = exception;
 	active->id.fields.level     = level;
-	memset(DEBUG_DATA(active), 0, id->buf_size);
-	memcpy(DEBUG_DATA(active), buf, MIN(len, id->buf_size));
 	proceed_active_entry(id);
 	if(exception)
 		proceed_active_area(id);
-	spin_unlock_irqrestore(&id->lock, flags);
-
-	return active;
 }
 
 /*
@@ -727,7 +717,17 @@
 debug_entry_t *debug_event_common(debug_info_t * id, int level, const void *buf,
 			          int len)
 {
-	return debug_common(id, level, buf, len, 0);
+	unsigned long flags;
+	debug_entry_t *active;
+
+	spin_lock_irqsave(&id->lock, flags);
+	active = get_active_entry(id);
+	memset(DEBUG_DATA(active), 0, id->buf_size);
+	memcpy(DEBUG_DATA(active), buf, MIN(len, id->buf_size));
+	debug_finish_entry(id, active, level, 0);
+	spin_unlock_irqrestore(&id->lock, flags);
+
+	return active;
 }
 
 /*
@@ -738,7 +738,17 @@
 debug_entry_t *debug_exception_common(debug_info_t * id, int level, 
                                       const void *buf, int len)
 {
-	return debug_common(id, level, buf, len, 1);
+	unsigned long flags;
+	debug_entry_t *active;
+
+	spin_lock_irqsave(&id->lock, flags);
+	active = get_active_entry(id);
+	memset(DEBUG_DATA(active), 0, id->buf_size);
+	memcpy(DEBUG_DATA(active), buf, MIN(len, id->buf_size));
+	debug_finish_entry(id, active, level, 1);
+	spin_unlock_irqrestore(&id->lock, flags);
+
+	return active;
 }
 
 /*
@@ -764,27 +774,28 @@
                                    int level,char *string,...)
 {
 	va_list   ap;
-	int numargs,alloc_size,idx;
-	debug_sprintf_entry *curr_event;
-	debug_entry_t *retval = NULL;
+	int numargs,idx;
+	unsigned long flags;
+	debug_sprintf_entry_t *curr_event;
+	debug_entry_t *active;
 
 	if((!id) || (level > id->level))
 		return NULL;
-	else {
-		numargs=debug_count_numargs(string);
-		alloc_size=offsetof(debug_sprintf_entry,args[numargs]);
-		curr_event=alloca(alloc_size);
-
-		if(curr_event){
-			va_start(ap,string);
-			curr_event->string=string;
-			for(idx=0;idx<numargs;idx++)
-				curr_event->args[idx]=va_arg(ap,long);
-			retval=debug_common(id,level, curr_event,alloc_size,0);
-			va_end(ap);
-		}
-		return retval;
-	}
+
+	numargs=debug_count_numargs(string);
+
+	spin_lock_irqsave(&id->lock, flags);
+	active = get_active_entry(id);
+	curr_event=(debug_sprintf_entry_t *) DEBUG_DATA(active);
+	va_start(ap,string);
+	curr_event->string=string;
+	for(idx=0;idx<MIN(numargs,((id->buf_size / sizeof(long))-1));idx++)
+		curr_event->args[idx]=va_arg(ap,long);
+	va_end(ap);
+	debug_finish_entry(id, active, level, 0);
+	spin_unlock_irqrestore(&id->lock, flags);
+
+	return active;
 }
 
 /*
@@ -795,27 +806,28 @@
                                        int level,char *string,...)
 {
 	va_list   ap;
-	int numargs,alloc_size,idx;
-	debug_sprintf_entry *curr_event;
-	debug_entry_t *retval = NULL;
+	int numargs,idx;
+	unsigned long flags;
+	debug_sprintf_entry_t *curr_event;
+	debug_entry_t *active;
 
 	if((!id) || (level > id->level))
 		return NULL;
-	else {
-		numargs=debug_count_numargs(string);
-		alloc_size=offsetof(debug_sprintf_entry,args[numargs]);
-		curr_event=alloca(alloc_size);
-
-		if(curr_event){
-			va_start(ap,string);
-			curr_event->string=string;
-			for(idx=0;idx<numargs;idx++)
-				curr_event->args[idx]=va_arg(ap,long);
-			retval=debug_common(id,level, curr_event,alloc_size,1);
-			va_end(ap);
-		}
-		return retval;
-	}
+
+	numargs=debug_count_numargs(string);
+
+	spin_lock_irqsave(&id->lock, flags);
+	active = get_active_entry(id);
+	curr_event=(debug_sprintf_entry_t *)DEBUG_DATA(active);
+	va_start(ap,string);
+	curr_event->string=string;
+	for(idx=0;idx<MIN(numargs,((id->buf_size / sizeof(long))-1));idx++)
+		curr_event->args[idx]=va_arg(ap,long);
+	va_end(ap);
+	debug_finish_entry(id, active, level, 1);
+	spin_unlock_irqrestore(&id->lock, flags);
+
+	return active;
 }
 
 /*
@@ -1127,7 +1139,7 @@
 #define DEBUG_SPRINTF_MAX_ARGS 10
 
 int debug_sprintf_format_fn(debug_info_t * id, struct debug_view *view,
-                            char *out_buf, debug_sprintf_entry *curr_event)
+                            char *out_buf, debug_sprintf_entry_t *curr_event)
 {
 	int num_longs, num_used_args = 0,i, rc = 0;
 	int index[DEBUG_SPRINTF_MAX_ARGS];
diff -urN linux-2.6/arch/s390/kernel/entry64.S linux-2.6-s390/arch/s390/kernel/entry64.S
--- linux-2.6/arch/s390/kernel/entry64.S	Wed Jun 16 07:19:01 2004
+++ linux-2.6-s390/arch/s390/kernel/entry64.S	Wed Jun 30 17:06:34 2004
@@ -305,7 +305,8 @@
 #
 sysc_singlestep:
 	ni	__TI_flags+7(%r9),255-_TIF_SINGLE_STEP # clear TIF_SINGLE_STEP
-	mvi	SP_TRAP+1(%r15),0x28	# set trap indication to pgm check
+	lhi	%r0,__LC_PGM_OLD_PSW
+	sth	%r0,SP_TRAP(%r15)	# set trap indication to pgm check
 	la	%r2,SP_PTREGS(%r15)	# address of register-save area
 	larl	%r14,sysc_return	# load adr. of system return
 	jg	do_debugger_trap	# branch to do_debugger_trap
diff -urN linux-2.6/arch/s390/kernel/time.c linux-2.6-s390/arch/s390/kernel/time.c
--- linux-2.6/arch/s390/kernel/time.c	Wed Jun 16 07:18:38 2004
+++ linux-2.6-s390/arch/s390/kernel/time.c	Wed Jun 30 17:06:34 2004
@@ -518,19 +518,19 @@
  * Stop the HZ tick on the current CPU.
  * Only cpu_idle may call this function.
  */
-int stop_hz_timer(void)
+void stop_hz_timer(void)
 {
 	__u64 timer;
 
 	if (sysctl_hz_timer != 0)
-		return 1;
+		return;
 
 	/*
 	 * Leave the clock comparator set up for the next timer
 	 * tick if either rcu or a softirq is pending.
 	 */
 	if (rcu_pending(smp_processor_id()) || local_softirq_pending())
-		return 1;
+		return;
 
 	/*
 	 * This cpu is going really idle. Set up the clock comparator
@@ -540,8 +540,6 @@
 	timer = (__u64) (next_timer_interrupt() - jiffies) + jiffies_64;
 	timer = jiffies_timer_cc + timer * CLK_TICKS_PER_JIFFY;
 	asm volatile ("SCKC %0" : : "m" (timer));
-
-	return 0;
 }
 #endif
 
@@ -572,8 +570,7 @@
 #endif
 
 #ifdef CONFIG_NO_IDLE_HZ
-	if (stop_hz_timer())
-		return 1;
+	stop_hz_timer();
 #endif
 
 	/* enable monitor call class 0 */
diff -urN linux-2.6/include/asm-s390/debug.h linux-2.6-s390/include/asm-s390/debug.h
--- linux-2.6/include/asm-s390/debug.h	Wed Jun 16 07:19:23 2004
+++ linux-2.6-s390/include/asm-s390/debug.h	Wed Jun 30 17:06:34 2004
@@ -34,7 +34,6 @@
 #define __DEBUG_FEATURE_VERSION      1  /* version of debug feature */
 
 #ifdef __KERNEL__
-#include <linux/version.h>
 #include <linux/spinlock.h>
 #include <linux/kernel.h>
 #include <linux/time.h>
diff -urN linux-2.6/include/asm-s390/percpu.h linux-2.6-s390/include/asm-s390/percpu.h
--- linux-2.6/include/asm-s390/percpu.h	Wed Jun 16 07:20:04 2004
+++ linux-2.6-s390/include/asm-s390/percpu.h	Wed Jun 30 17:06:34 2004
@@ -1,30 +1,70 @@
 #ifndef __ARCH_S390_PERCPU__
 #define __ARCH_S390_PERCPU__
 
-#include <asm-generic/percpu.h>
+#include <linux/compiler.h>
 #include <asm/lowcore.h>
 
+#define __GENERIC_PER_CPU
+
 /*
- * For builtin kernel code s390 uses the generic implementation for
- * per cpu data, with the exception that the offset of the cpu local
- * data area is cached in the cpu's lowcore memory
+ * s390 uses its own implementation for per cpu data, the offset of
+ * the cpu local data area is cached in the cpu's lowcore memory.
  * For 64 bit module code s390 forces the use of a GOT slot for the
  * address of the per cpu variable. This is needed because the module
  * may be more than 4G above the per cpu area.
  */
 #if defined(__s390x__) && defined(MODULE)
-#define __get_got_cpu_var(var,offset) \
+
+#define __reloc_hide(var,offset) \
   (*({ unsigned long *__ptr; \
-       asm ( "larl %0,per_cpu__"#var"@GOTENT" : "=a" (__ptr) ); \
-       ((typeof(&per_cpu__##var))((*__ptr) + offset)); \
-    }))
-#undef __get_cpu_var
-#define __get_cpu_var(var) __get_got_cpu_var(var,S390_lowcore.percpu_offset)
-#undef per_cpu
-#define per_cpu(var,cpu) __get_got_cpu_var(var,__per_cpu_offset[cpu])
+       asm ( "larl %0,per_cpu__"#var"@GOTENT" \
+             : "=a" (__ptr) : "X" (per_cpu__##var) ); \
+       (typeof(&per_cpu__##var))((*__ptr) + (offset)); }))
+
 #else
-#undef __get_cpu_var
-#define __get_cpu_var(var) (*RELOC_HIDE(&per_cpu__##var, S390_lowcore.percpu_offset))
+
+#define __reloc_hide(var, offset) \
+  (*({ unsigned long __ptr; \
+       asm ( "" : "=a" (__ptr) : "0" (&per_cpu__##var) ); \
+       (typeof(&per_cpu__##var)) (__ptr + (offset)); }))
+
 #endif
 
+#ifdef CONFIG_SMP
+
+extern unsigned long __per_cpu_offset[NR_CPUS];
+
+/* Separate out the type, so (int[3], foo) works. */
+#define DEFINE_PER_CPU(type, name) \
+    __attribute__((__section__(".data.percpu"))) \
+    __typeof__(type) per_cpu__##name
+
+#define __get_cpu_var(var) __reloc_hide(var,S390_lowcore.percpu_offset)
+#define per_cpu(var,cpu) __reloc_hide(var,__per_cpu_offset[cpu])
+
+/* A macro to avoid #include hell... */
+#define percpu_modcopy(pcpudst, src, size)			\
+do {								\
+	unsigned int __i;					\
+	for (__i = 0; __i < NR_CPUS; __i++)			\
+		if (cpu_possible(__i))				\
+			memcpy((pcpudst)+__per_cpu_offset[__i],	\
+			       (src), (size));			\
+} while (0)
+
+#else /* ! SMP */
+
+#define DEFINE_PER_CPU(type, name) \
+    __typeof__(type) per_cpu__##name
+
+#define __get_cpu_var(var) __reloc_hide(var,0)
+#define per_cpu(var,cpu) __reloc_hide(var,0)
+
+#endif /* SMP */
+
+#define DECLARE_PER_CPU(type, name) extern __typeof__(type) per_cpu__##name
+
+#define EXPORT_PER_CPU_SYMBOL(var) EXPORT_SYMBOL(per_cpu__##var)
+#define EXPORT_PER_CPU_SYMBOL_GPL(var) EXPORT_SYMBOL_GPL(per_cpu__##var)
+
 #endif /* __ARCH_S390_PERCPU__ */
diff -urN linux-2.6/include/asm-s390/vtoc.h linux-2.6-s390/include/asm-s390/vtoc.h
--- linux-2.6/include/asm-s390/vtoc.h	Wed Jun 16 07:19:37 2004
+++ linux-2.6-s390/include/asm-s390/vtoc.h	Wed Jun 30 17:06:34 2004
@@ -14,7 +14,6 @@
 #include <linux/fs.h>
 #include <linux/types.h>
 #include <linux/hdreg.h>
-#include <linux/version.h>
 #include <asm/dasd.h>
 #endif
 
