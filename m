Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289119AbSA1GBz>; Mon, 28 Jan 2002 01:01:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289120AbSA1GBl>; Mon, 28 Jan 2002 01:01:41 -0500
Received: from 207-172-216-88.s596.apx1.sbo.ma.dialup.rcn.com ([207.172.216.88]:14976
	"EHLO linux.local") by vger.kernel.org with ESMTP
	id <S289119AbSA1GBX>; Mon, 28 Jan 2002 01:01:23 -0500
Date: Sun, 27 Jan 2002 19:58:23 -0500
Message-Id: <200201280058.g0S0wNs01102@linux.local>
From: Jim Houston <jhouston@ma.ultranet.com>
To: linux-kernel@vger.kernel.org
Subject: PATCH - kernel trace mechanism for KDB
Reply-to: jhouston@ma.ultranet.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi!

The attached patch implements a kernel trace mechanism as an addition to
kdb.  It's set up to build a kernel with the -finstrument-functions compiler
option. By default it gathers data on every function call and return.
It also includes logic to filter the data collected, capturing data only
for selected functions or all but selected functions.

Each entry in the trace includes a timestamp, the called function and the
calling address.  Function calls also include the frame pointer and
3 words from the stack that might be arguments. 


Here is a sample of the output:

 63 ret  6.803 us 0xc0121140 (spin_lock)  0xc012011c (__wake_up+0x2c)
 64 call 6.899 us 0xc0121140 (spin_lock)  0xc012011c (__wake_up+0x2c)
         fp=c045de84 args = c044d560 00000003 00000045
 65 call 6.970 us 0xc01200f0 (__wake_up)  0xc0225176 (put_queue+0x26)
         fp=c045dea0 args = c045dec4 c0224eab 00000045
 66 call 7.072 us 0xc0225150 (put_queue)  0xc0224eab (handle_scancode+0xab)
         fp=c045dea8 args = 00000045 c00001c8 00000000

INSTALL

   Install kernel and kdb:
      linux-2.4.17 kernel
      kdb-v2.1-2.4.17-common-2.bz2
      kdb-v2.1-2.4.17-i386-1.bz2.

   Apply this patch.

   Run the script "scripts/inline-fix.pl" included in this patch.  This
   changes "extern inline" to "static inline" globally.

   Install modutils-2.4.12.tar, and patch it using the file "patch_kallsyms"
   which was dropped in the kernel tree.  Build kallsyms and install.

   Enable the "Trace kernel function calls" configuration option.


How to use it.

   At the kdb prompt:

   tr <offset>		Displays the contents of the trace buffer.

   trd			Default to not collecting trace data
   tre <function list>  Add functions which should be traced.

   tre			Default to trace everything
   trd <function list>	Add function to exception list not to be traced

   trp			Display trace enable/disable status list of
			exceptions.

   trc			Clear list of functions with tracing explictly
			enabled or disabled.

Why change kallsyms?

   The symbol table that kallsyms creates doesn't include information
   for symbols which have several static definitions.  This change 
   preserves these local definitions.  Using -finstrument-functions
   means that inline functions get a static version created in every
   file that calls them.

Multiple symbols with the same name, eh?

   With the patch the symbol table now has multiple entries for the same
   name.  It does the right thing for address to name translations but 
   just picks the first entry when it is asked to find an address from
   a name.  It would be nice if kdb could warn when there are multiple
   defintions for the same symbol.

Oh no not the stupid extern inline thread again...

   The -finstrument-functions option generates calls to the functions
   __cyg_profile_func_enter and __cyg_profile_func_exit for each function
   passing the address of the function and the caller.
   This is done even for inline functions.  This results in taking the
   address of inline functions which would normally always be inlined.
   For functions declared "extern inline" this results in undefined 
   symbol errors.  For "static inline" it causes a static version to be
   compiled in each object file that uses the inline function.
   Given this choice, multiple copies beats link errors so the inline-fix.pl
   script make the global change from extern to static inline.

Why defeat inlining?

   With functions inlined and compiled with -finstrument-functions
   the return address gets confusing.  If function 'A' calls 'B'
   which has 'C' inlined, the trace shows 'C' called by 'A'.
   I turned of inlining by adding "-fno-inline" in the toplevel
   makefile.  If your are tracing every function call you probably
   don't get much performance benifit out of inlining anyway.

Why did I do this?

   I wrote this code while chasing a bug on an old off-brand laptop which
   locks up with a combination of X and PCMCIA network cards.  I was able
   to reproduce the problem with the trace running sending the trace data
   to an unused corner of the video ram (which survives reset).  Now I know
   that the lockup happens in the Xserver sigh:-)

What is the performance impact?

   On a 1 GHz. Athlon it doesn't seem slow.  I have been running it
   as my normal kernel for a few weeks.  On average it takes 70 cycles
   per call or return with a trace buffer which fits in cache.  
   E.g. getpid() takes 422 cycle instead of 280.  It is painfully 
   slow running on an old pentium with the trace going to real
   memory.
   
   
I hope that others will find this trace mechanism useful.  I'm sending
this to both the SGI kdb mailing list and the linux kernel mailing list.
I hope that it might become a standard part of kdb. 

Jim Houston
jhouston@ma.ultranet.com

diff -urN -X /home/jim/dontdiff linux.orig/Documentation/Configure.help linux/Documentation/Configure.help
--- linux.orig/Documentation/Configure.help	Sun Jan 27 06:42:49 2002
+++ linux/Documentation/Configure.help	Sun Jan 27 09:03:59 2002
@@ -18976,6 +18976,11 @@
   this option. See "man kallsyms" for the data format, it adds 10-20%
   to the size of the kernel and the loaded modules. If unsure, say N.
 
+Trace kernel function calls
+CONFIG_INSTRUMENT_FUNC
+  Compile kernel with -finstrument-functions.  This allows a function
+  level trace of kernel code.
+
 ISDN support
 CONFIG_ISDN
   ISDN ("Integrated Services Digital Networks", called RNIS in France)
diff -urN -X /home/jim/dontdiff linux.orig/Makefile linux/Makefile
--- linux.orig/Makefile	Sun Jan 27 06:42:49 2002
+++ linux/Makefile	Sun Jan 27 09:03:59 2002
@@ -97,6 +97,9 @@
 ifndef CONFIG_FRAME_POINTER
 CFLAGS += -fomit-frame-pointer
 endif
+ifeq ($(CONFIG_INSTRUMENT_FUNC),y)
+CFLAGS += -finstrument-functions -fno-inline
+endif
 AFLAGS := -D__ASSEMBLY__ $(CPPFLAGS)
 
 #
diff -urN -X /home/jim/dontdiff linux.orig/arch/i386/boot/compressed/misc.c linux/arch/i386/boot/compressed/misc.c
--- linux.orig/arch/i386/boot/compressed/misc.c	Wed Nov 28 08:12:08 2001
+++ linux/arch/i386/boot/compressed/misc.c	Sun Jan 27 09:03:59 2002
@@ -381,3 +381,18 @@
 	if (high_loaded) close_output_buffer_if_we_run_high(mv);
 	return high_loaded;
 }
+
+#ifdef CONFIG_INSTRUMENT_FUNC
+void __cyg_profile_func_enter(void *, void *)
+        __attribute__ ((no_instrument_function));
+void __cyg_profile_func_exit(void *, void *)
+        __attribute__ ((no_instrument_function));                               
+
+void __cyg_profile_func_enter(void *a1, void *a2)
+{
+}
+
+void __cyg_profile_func_exit(void *a1, void *a2)
+{
+}
+#endif
diff -urN -X /home/jim/dontdiff linux.orig/arch/i386/config.in linux/arch/i386/config.in
--- linux.orig/arch/i386/config.in	Sun Jan 27 06:46:02 2002
+++ linux/arch/i386/config.in	Sun Jan 27 09:03:59 2002
@@ -419,6 +419,7 @@
       bool '    KDB off by default' CONFIG_KDB_OFF
       comment '  Load all symbols for debugging is required for KDB'
       define_bool CONFIG_KALLSYMS y
+      bool '  Trace kernel function calls' CONFIG_INSTRUMENT_FUNC
    else
       bool '  Load all symbols for debugging' CONFIG_KALLSYMS
    fi
diff -urN -X /home/jim/dontdiff linux.orig/arch/i386/kdb/kdbasupport.c linux/arch/i386/kdb/kdbasupport.c
--- linux.orig/arch/i386/kdb/kdbasupport.c	Sun Jan 27 06:46:03 2002
+++ linux/arch/i386/kdb/kdbasupport.c	Sun Jan 27 09:03:59 2002
@@ -1030,6 +1030,8 @@
 }
 
 #ifdef KDB_HAVE_LONGJMP
+int kdba_setjmp(kdb_jmp_buf *jb)
+	__attribute__ ((no_instrument_function));
 int
 kdba_setjmp(kdb_jmp_buf *jb)
 {
@@ -1059,6 +1061,8 @@
 	return 0;
 }
 
+void kdba_longjmp(kdb_jmp_buf *jb, int reason)
+	__attribute__ ((no_instrument_function));
 void
 kdba_longjmp(kdb_jmp_buf *jb, int reason)
 {
diff -urN -X /home/jim/dontdiff linux.orig/drivers/parport/parport_pc.c linux/drivers/parport/parport_pc.c
--- linux.orig/drivers/parport/parport_pc.c	Sun Jan 27 06:29:54 2002
+++ linux/drivers/parport/parport_pc.c	Sun Jan 27 09:03:59 2002
@@ -256,6 +256,11 @@
 	parport_generic_irq(irq, (struct parport *) dev_id, regs);
 }
 
+/*
+ * Actually it cause problems to have both static inline and a
+ * global version.
+ */
+#if 0
 void parport_pc_write_data(struct parport *p, unsigned char d)
 {
 	outb (d, DATA (p));
@@ -343,6 +348,7 @@
 {
 	__parport_pc_frob_control (p, 0x20, 0x20);
 }
+#endif
 
 void parport_pc_init_state(struct pardevice *dev, struct parport_state *s)
 {
diff -urN -X /home/jim/dontdiff linux.orig/include/asm-i386/current.h linux/include/asm-i386/current.h
--- linux.orig/include/asm-i386/current.h	Fri Aug 14 19:35:22 1998
+++ linux/include/asm-i386/current.h	Sun Jan 27 09:03:59 2002
@@ -4,6 +4,8 @@
 struct task_struct;
 
 static inline struct task_struct * get_current(void)
+	__attribute__ ((no_instrument_function));
+static inline struct task_struct * get_current(void)
 {
 	struct task_struct *current;
 	__asm__("andl %%esp,%0; ":"=r" (current) : "0" (~8191UL));
diff -urN -X /home/jim/dontdiff linux.orig/kdb/Makefile linux/kdb/Makefile
--- linux.orig/kdb/Makefile	Sun Jan 27 06:42:49 2002
+++ linux/kdb/Makefile	Sun Jan 27 09:03:59 2002
@@ -2,6 +2,9 @@
 export-objs	:= kdbmain.o kdb_io.o
 obj-y		:= kdb_bt.o kdb_bp.o kdb_id.o kdbsupport.o gen-kdb_cmds.o kdbmain.o kdb_io.o
 
+obj-$(CONFIG_INSTRUMENT_FUNC) += kdb_tr.o
+CFLAGS_kdb_tr.o += -finline
+
 subdir-$(CONFIG_KDB_MODULES) := modules
 obj-y += $(addsuffix /vmlinux-obj.o, $(subdir-y))
 
diff -urN -X /home/jim/dontdiff linux.orig/kdb/kdb_tr.c linux/kdb/kdb_tr.c
--- linux.orig/kdb/kdb_tr.c	Wed Dec 31 19:00:00 1969
+++ linux/kdb/kdb_tr.c	Sun Jan 27 17:31:24 2002
@@ -0,0 +1,601 @@
+/*
+ * Copyright (C)  2002 Jim Houston jhouston@ma.ultranet.com
+ *
+ * This software may be used and distributed according to the terms
+ * of the GNU General Public License (GPL), incorporated herein by
+ * reference.
+ *
+ * Its a quick hack to trace the kernel at the function call level
+ * using the -finstrument-functions compiler option.  The trace is
+ * stored in a circular buffer.
+ * 
+ * Here is a summary of the new commands it adds to kdb:
+ *
+ * 	tr <trace buffer offset>
+ * 		Display content of trace buffer.
+ *	tre
+ *	tre <functions>
+ * 		Enable tracing of all function calls, or the
+ *		specified functions.  
+ *	trd 
+ *	tre <functions>
+ * 		Disable tracing all functions, or the specifed
+ *		functions.
+ *	trc
+ *	trc <function>
+ *		Clear list of per function trace requests, or remove
+ *		the 'trd' or 'tre' entry for the specified function.
+ *	trp
+ *		Print list of functions which have been explicity
+ * 		enabled or disabled for tracing.
+ *	trstop
+ *	trstart
+ *		Global control to disable/re-enable tracing.  You 
+ *		might use trstop to stop tracing so that the trace
+ *		could be read with a user level tool.
+ * 
+ */
+
+#include <linux/string.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/kdb.h>
+#include <linux/kdbprivate.h>
+#include <linux/smp.h>
+#include <linux/sched.h>
+#include <asm/system.h>
+#include <asm/div64.h>
+#include "kdb_tr.h"
+
+char *trc_tname[] = { "call", "ret ", "user " };
+
+struct trce trc_buf[TRC_SZ];
+struct trc trc = { TRC_ENABLE, TRC_ENABLE, trc_buf, TRC_SZ-1, 0, 0 };
+struct trc *trcp = &trc;
+
+void
+kdb_trc_init()
+{
+	kdb_register_repeat("tr", kdb_tr, "<range>",	
+		"Display kernel trace", 0, KDB_REPEAT_NONE);
+	kdb_register_repeat("trp", kdb_trp, "",	
+		"Display trace enable/disable status", 0, KDB_REPEAT_NONE);
+	kdb_register_repeat("tre", kdb_tre, "<func>",
+		"Enable trace for function", 0, KDB_REPEAT_NONE);
+	kdb_register_repeat("trd", kdb_trd, "<func>",
+		"Disable trace for function", 0, KDB_REPEAT_NONE);
+	kdb_register_repeat("trc", kdb_trc, "<func>",
+		"Clear per function trace enable/disble", 0, KDB_REPEAT_NONE);
+	kdb_register_repeat("trstop", kdb_trstop, "",
+		"Disable kernel trace", 0, KDB_REPEAT_NONE);
+	kdb_register_repeat("trstart", kdb_trstart, "",
+		"Enable kernel trace", 0, KDB_REPEAT_NONE);
+}
+/*
+ * Simple hash table to control the trace.  Each function entry
+ * and exit goes through here so it has to be quick.  Its a fixed
+ * sized hash table with the data store directly in the hash table.
+ */
+struct trc_hash trc_hash[TRC_HASH_SZ];
+int trc_hash_cnt = 0;
+
+inline int trc_hashfn(kdb_machreg_t addr)
+{
+	unsigned int i = (unsigned int) addr;
+
+	return((i ^ (i >> 5) ^ (i >> 10) ^ (i >> 15)) % TRC_HASH_SZ);
+}
+
+
+inline int trc_get_flags(kdb_machreg_t addr)
+{
+	unsigned int i, flags;
+
+	i = trc_hashfn(addr);
+	for ( ; (flags = trc_hash[i].flags) ; i = (i+1) % TRC_HASH_SZ)
+		if (trc_hash[i].addr == addr)
+			return(flags);
+	return(0);
+}
+
+
+/*
+ * Create or update a hash table entry.
+ */
+
+void
+trc_set_flags(kdb_machreg_t addr, int flags)
+{
+	int i;
+
+	if (!flags)
+		return;
+	i = trc_hashfn(addr);
+	for ( ; trc_hash[i].flags ; i = (i+1) % TRC_HASH_SZ)
+		if (trc_hash[i].addr == addr) {
+			trc_hash[i].flags = flags;
+			return;
+		}
+	/*
+	 * Seaches take literally forever if the table is completly full.
+	 * Warn and fail if the table is more than half full.
+	 */
+	if (trc_hash_cnt >= TRC_HASH_SZ/2) {
+		kdb_printf("no more entries\n");
+		return;
+	}
+	trc_hash_cnt++;
+	trc_hash[i].addr = addr;
+	trc_hash[i].flags = flags;
+}
+
+void
+trc_clr_flags(kdb_machreg_t addr)
+{
+	int i, flags;
+
+	i = trc_hashfn(addr);
+	for ( ; ; i = (i+1) % TRC_HASH_SZ) {
+		if (!(flags = trc_hash[i].flags))
+			return;
+		if (trc_hash[i].addr == addr)
+			break;
+	}
+
+	/*
+	 * Found it. Take it out.
+	 */
+	trc_hash[i].addr = 0;
+	trc_hash[i].flags = 0;
+	trc_hash_cnt--;
+	/*
+	 * Now check that adjacent entries don't get lost.
+	 */
+	i = (i+1) % TRC_HASH_SZ;
+	for ( ; (flags  = trc_hash[i].flags); i = (i+1) % TRC_HASH_SZ) {
+		if (i != trc_hashfn(trc_hash[i].addr)) {
+			/*
+			 * This entry might want the slot we just
+			 * cleared, take it out and put it back in.
+			 */
+			addr = trc_hash[i].addr;
+			trc_hash[i].addr = 0;
+			trc_hash[i].flags = 0;
+			trc_set_flags(addr, flags);
+		}
+	}
+}
+
+void
+trc_clr_all_flags( void )
+{
+	int i;
+
+	for (i = 0; i < TRC_HASH_SZ; i++) {
+		trc_hash[i].addr = 0;
+		trc_hash[i].flags = 0;
+	}
+	trc_hash_cnt = 0;
+}
+void
+
+trc_print_hash( void )
+{
+	int i;
+
+	for (i = 0; i < TRC_HASH_SZ; i++) {
+		if (trc_hash[i].flags) {
+			if (trc_hash[i].flags & TRC_ENABLE)
+				kdb_printf("ENABLE  ");
+			if (trc_hash[i].flags & TRC_DISABLE)
+				kdb_printf("DISABLE ");
+			kdb_symbol_print(trc_hash[i].addr, NULL, KDB_SP_DEFAULT);
+			kdb_printf("\n");
+		}
+
+	}
+}
+
+/*
+ * Functions to disable/re-enable the trace on entry to kdb.  
+ */ 
+void kdb_trc_disable( void )
+{
+	struct trc *tp;
+
+	tp = trcp;
+	if (!tp)
+		return;
+	tp->enable_save = tp->enable;
+	tp->enable = 0;
+}
+
+void kdb_trc_continue( void )
+{
+	struct trc *tp;
+
+	tp = trcp;
+	if (!tp)
+		return;
+	tp->enable = tp->enable_save;
+}
+
+
+static inline struct trce *next_t(struct trc *tp)
+{
+	unsigned int i;
+
+	/* It would be nice if this was atomic */
+	if ((i = tp->offset++) == ~0)
+		tp->offsetu++;
+	return(&(tp->buf[i & tp->mask]));
+}
+
+void __cyg_profile_func_enter(kdb_machreg_t this_fn, kdb_machreg_t call_site)
+{
+	register unsigned int t1, t2;
+	struct trc *tp;
+	struct trce *t;
+	kdb_machreg_t *fp = __builtin_frame_address(1);
+
+	tp = trcp;
+	if (!tp || tp->enable & TRC_STOP)
+		return;
+	t1 = trc_get_flags((kdb_machreg_t)this_fn);
+	if ((tp->enable | t1) != TRC_ENABLE)
+		return;
+	rdtsc(t1,t2);
+	t = next_t(tp);
+	t->time = t1;
+	t->timeu = t2;
+	t->type = T_ENTER;
+	t->a1 = this_fn;
+	t->a2 = call_site;
+	/*
+	 * Save the frame ptr and first 3 args
+	 */
+	t->a3 = (kdb_machreg_t)fp;
+	t->a4 = fp[2];
+	t->a5 = fp[3];
+	t->a6 = fp[4];
+}
+
+void __cyg_profile_func_exit(kdb_machreg_t this_fn, kdb_machreg_t call_site)
+{
+	register unsigned int t1, t2;
+	struct trc *tp;
+	struct trce *t;
+
+	tp = trcp;
+	if (!tp || tp->enable & TRC_STOP)
+		return;
+	t1 = trc_get_flags((kdb_machreg_t)this_fn);
+	if ((tp->enable | t1) != TRC_ENABLE)
+		return;
+	rdtsc(t1,t2);
+	t = next_t(tp);
+	t->time = t1;
+	t->timeu = t2;
+	t->type = T_EXIT;
+	t->a1 = this_fn;
+	t->a2 = call_site;
+}
+
+void __trace_user(kdb_machreg_t a1, kdb_machreg_t a2)
+{
+	register unsigned int t1, t2;
+	struct trc *tp;
+	struct trce *t;
+
+	tp = trcp;
+	if (!tp || tp->enable & TRC_STOP)
+		return;
+	rdtsc(t1,t2);
+	t = next_t(tp);
+	t->time = t1;
+	t->timeu = t2;
+	t->type = T_USER;
+	t->a1 = a1;
+	t->a2 = a2;
+}
+
+
+void __trace_stop()
+{
+	struct trc *tp;
+
+	tp = trcp;
+	tp->enable |= TRC_STOP;
+}
+
+/*
+ * Choose format for time, absolute cycles, delta from previous line
+ * or relative to most recent sample.
+ */
+enum tm_format { absolute, delta, relative };
+char *tfname[] = {"absolute", "delta", "relative", 0 };
+
+enum tm_format
+get_time_format(void)
+{
+	enum tm_format i;
+	char *s;
+
+	if ((s = kdbgetenv("TIME_FORMAT")))
+		for (i = absolute; ; i++) {
+			if (tfname[i] && strcmp(tfname[i], s) == 0) 
+				return(i);
+		}
+	return(relative);
+}
+
+
+extern unsigned long fast_gettimeoffset_quotient;
+
+char *frac_format[] = { " ", ".%01d ", ".%02d ", ".%03d ", ".%04d ",
+	".%05d ", ".%06d ", ".%07d ", ".%08d "};
+
+void
+display_time(unsigned long long dt)
+{
+	int n;
+	unsigned int de, frac;
+	char *unit;
+	int n_digits, min_frac;
+	unsigned int cycles;
+	unsigned long long ll;
+
+	ll = 1LL << 32;
+	do_div(ll, fast_gettimeoffset_quotient);
+	cycles = (unsigned int)ll;
+	
+	/* guess how many significant digits we have, count the bits */
+	/* and multiply by log10(2) */
+	for (n = 0; n < 63 && dt > (1LL << n);  n++) ;
+	n_digits = (n * 1233) >> 12;
+
+	min_frac = 0;
+	if (dt < 1000*cycles) {
+		de = cycles;
+		unit = "us";
+		min_frac = 2;
+	} else if (dt < 1000000*cycles) {
+		de = cycles * 1000;
+		unit = "ms";
+		min_frac = 3;
+	} else {
+		de =  cycles * 1000000;
+		unit = "s";
+	}
+	frac = do_div(dt, de);
+	/* Pick number of digits for fraction */
+	for (n = 0; n < 63 && dt > (1LL << n);  n++) ;
+	n_digits -= (n * 1233) >> 12;
+	if (n_digits < min_frac)
+		n_digits = min_frac;
+
+	if (n_digits > 7)
+		n_digits = 7;
+	kdb_printf("%d", (unsigned int)dt);
+	dt = frac;
+	for (n = 0; n < n_digits; n++)
+		dt *= 10;
+	dt += de/2;
+	frac = do_div(dt, de);
+	kdb_printf(frac_format[n_digits], (unsigned int)dt);
+	kdb_printf("%s ", unit);
+}
+
+void
+kdb_tr_display(unsigned int from,  unsigned int to)
+{
+	unsigned int i;
+	struct trc *tp;
+	struct trce *t;
+	enum tm_format tf;
+	long long t0, t1;
+
+	tp = trcp;
+	if (!tp) {
+		kdb_printf("No trace buffer?\n");
+		return;
+	}
+	if ((from & ~tp->mask) || (to  & ~tp->mask)) {
+		kdb_printf("Offset larger than trace buffer?\n");
+		return;
+	}
+	tf =get_time_format();
+
+	if (tf == relative)
+		t = &(tp->buf[(tp->offset-1) & tp->mask]);
+	else
+		t = &(tp->buf[(tp->offset-from-1) & tp->mask]);
+	t0 = (unsigned long long)t->timeu << 32;
+	t0 |= t->time;
+	for (i = from; i <= to; i++) {
+		t = &(tp->buf[(tp->offset-i-1) & tp->mask]);
+		kdb_printf("%3d %s ", i, trc_tname[t->type]);
+		if (tf == absolute)
+			kdb_printf("%6x%08x ", t->timeu, t->time);
+		else {
+			t1 = (unsigned long long)t->timeu << 32;
+			t1 |= t->time;
+			display_time(t0 - t1);
+			if (tf == delta)
+				t0  =  t1;
+		}
+		kdb_symbol_print((kdb_machreg_t)t->a1, NULL, KDB_SP_DEFAULT);
+		kdb_printf("  ");
+		kdb_symbol_print((kdb_machreg_t)t->a2, NULL, KDB_SP_DEFAULT);
+		kdb_printf("\n");
+		if (t->type == T_ENTER) {
+			kdb_printf("         fp=%08lx args = %08lx %08lx %08lx\n",
+				t->a3, t->a4, t->a5, t->a6);
+		}
+	}
+}
+
+
+int
+kdb_tr(int argc, const char **argv, const char **envp, struct pt_regs *regs)
+{                                                                               
+	unsigned int from, to;
+	struct trc *tp;
+
+	tp = trcp;
+	/*
+	 * default to display the whole buffer.
+	 */
+	from = 0;
+	to = tp->mask;
+	if (argc >= 1)
+		from = simple_strtoul(argv[1], NULL, 10);
+	if (argc >= 2)
+		to = simple_strtoul(argv[2], NULL, 10);
+	kdb_tr_display(from, to);
+	return(0);
+}
+
+int
+kdb_trstop(int argc, const char **argv, const char **envp, struct pt_regs *regs)
+{                                                                               
+	struct trc *tp;
+
+	tp = trcp;
+	tp->enable_save |= TRC_STOP;
+	return(0);
+}
+
+int
+kdb_trstart(int argc, const char **argv, const char **envp, struct pt_regs *regs)
+{                                                                               
+	struct trc *tp;
+
+	tp = trcp;
+	tp->enable_save &= ~TRC_STOP;
+	return(0);
+}
+
+int
+kdb_trd(int argc, const char **argv, const char **envp, struct pt_regs *regs)
+{                                                                               
+	int diag, nextarg;
+	kdb_machreg_t addr;
+	long offset;
+	struct trc *tp;
+
+	tp = trcp;
+	if (argc == 0) {
+		tp->enable_save &= ~TRC_ENABLE;
+	} else {
+		nextarg = 1;
+		while (argc >= nextarg) {
+			diag = kdbgetaddrarg(argc, argv, &nextarg,
+				 &addr, &offset, NULL, regs); 
+			if (diag)
+				return(diag);
+			trc_set_flags(addr, TRC_DISABLE);
+		}
+	}
+	return(0);
+}
+
+int
+kdb_tre(int argc, const char **argv, const char **envp, struct pt_regs *regs)
+{                                                                               
+	int diag, nextarg;
+	kdb_machreg_t addr;
+	long offset;
+	struct trc *tp;
+
+	tp = trcp;
+	if (argc == 0) {
+		tp->enable_save |= TRC_ENABLE;
+	} else {
+		nextarg = 1;
+		while (argc >= nextarg) {
+			diag = kdbgetaddrarg(argc, argv, &nextarg,
+				 &addr, &offset, NULL, regs); 
+			if (diag)
+				return(diag);
+			trc_set_flags(addr, TRC_ENABLE);
+		}
+	}
+	return(0);
+} 
+
+int
+kdb_trc(int argc, const char **argv, const char **envp, struct pt_regs *regs)
+{                                                                               
+	int diag, nextarg;
+	kdb_machreg_t addr;
+	long offset;
+	struct trc *tp;
+
+	tp = trcp;
+	if (argc == 0) {
+		trc_clr_all_flags();
+	} else {
+		nextarg = 1;
+		while (argc >= nextarg) {
+			diag = kdbgetaddrarg(argc, argv, &nextarg,
+				 &addr, &offset, NULL, regs); 
+			if (diag)
+				return(diag);
+			trc_clr_flags(addr);
+		}
+	}
+	return(0);
+} 
+
+int
+kdb_trp(int argc, const char **argv, const char **envp, struct pt_regs *regs)
+{                                                                               
+	struct trc *tp;
+
+	tp = trcp;
+	kdb_printf("Tracing %s by default.\n",
+		tp->enable_save&TRC_ENABLE?"enabled":"disabled");
+	trc_print_hash();
+	return(0);
+}
+
+/*
+ * The calls for these functions are normally not generated because 
+ * in the inlined version the compiler eliminates the call as dead
+ * code.  When instrument-functions takes the address of the function
+ * forcing a non-inlined version the code is nolonger dead.
+ */
+
+void __br_lock_usage_bug(void)
+{
+	printk(KERN_WARNING "__br_lock_usage_bug called\n");
+}
+
+void __this_fixmap_does_not_exist(void)
+{
+	printk(KERN_WARNING "__this_fixmap_does_not_exist called\n");
+}
+
+void
+kdb_print_trace(void)
+{
+
+	struct trce *t;
+	struct trc *tp;
+	int from, to, i;
+
+	tp = trcp;
+	tp->enable = 0;
+	from = 0;
+	to = 20;
+
+	for (i = from; i <= to; i++) {
+		t = &(tp->buf[(tp->offset-i-1) & tp->mask]);
+		printk("%s %08x ", trc_tname[t->type],
+			t->time);
+		printk("%08lx ", (kdb_machreg_t)t->a1);
+		printk("%08lx ", (kdb_machreg_t)t->a2);
+		printk("\n");
+	}
+}
diff -urN -X /home/jim/dontdiff linux.orig/kdb/kdb_tr.h linux/kdb/kdb_tr.h
--- linux.orig/kdb/kdb_tr.h	Wed Dec 31 19:00:00 1969
+++ linux/kdb/kdb_tr.h	Sun Jan 27 09:03:59 2002
@@ -0,0 +1,89 @@
+/*
+ * Quick hack to trace the linux kernel at the function call level
+ * using the -finstrument-functions compiler option.
+ * 
+ * Copyright (C)  2002 Jim Houston jhouston@ma.ultranet.com
+ *
+ * This software may be used and distributed according to the terms  of the
+ * GNU General Public License (GPL), incorporated herein by reference.
+ */
+
+
+#define rdtsc(low,high) \
+     __asm__ __volatile__("rdtsc" : "=a" (low), "=d" (high))                    
+
+#define TRC_ENABLE	1
+#define TRC_DISABLE	2
+#define TRC_STOP	4
+
+#define TRC_SZ		0x1000
+#define TRC_HASH_SZ	0x100
+
+#define T_ENTER	0
+#define T_EXIT  1
+#define T_USER	2
+
+struct trce {
+	unsigned int	type: 8 ;
+	unsigned int	timeu : 24 ;
+	unsigned int	time;
+	kdb_machreg_t	a1, a2, a3, a4, a5, a6;
+};
+
+struct trc {
+	int		enable;
+	int		enable_save;
+	struct trce	*buf;
+	unsigned int	mask;
+	unsigned int	offset;
+	unsigned int	offsetu;
+};
+
+/*
+ * The data collected by the trace is filtered by looking the
+ * called function address up in a simple hash table.  The flags
+ * currently only two bits provide explicit enable/disable of
+ * tracing on a per function basis.  
+ */
+
+struct trc_hash {
+	kdb_machreg_t	addr;
+	int		flags;
+};
+
+int trc_hashfn(kdb_machreg_t addr)
+	__attribute__ ((no_instrument_function));
+int trc_get_flags(kdb_machreg_t addr)
+	__attribute__ ((no_instrument_function));
+
+void __cyg_profile_func_enter(kdb_machreg_t , kdb_machreg_t )
+	__attribute__ ((no_instrument_function));
+
+void __cyg_profile_func_exit(kdb_machreg_t , kdb_machreg_t )
+	__attribute__ ((no_instrument_function));
+
+void __trace_user(kdb_machreg_t , kdb_machreg_t )
+	__attribute__ ((no_instrument_function));
+
+void __trace_stop( void )
+	__attribute__ ((no_instrument_function));
+
+void kdb_trc_disable( void )
+	__attribute__ ((no_instrument_function));
+
+void kdb_trc_continue( void )
+	__attribute__ ((no_instrument_function));
+
+static struct trce *next_t(struct trc *)
+	__attribute__ ((no_instrument_function));
+
+void kdb_trc_init(void);
+void kdb_trc_disable(void);
+void kdb_trc_continue(void);
+int kdb_tr(int , const char **, const char **, struct pt_regs *);
+int kdb_trstop(int , const char **, const char **, struct pt_regs *);
+int kdb_trstart(int , const char **, const char **, struct pt_regs *);
+int kdb_trd(int , const char **, const char **, struct pt_regs *);
+int kdb_tre(int , const char **, const char **, struct pt_regs *);
+int kdb_trc(int , const char **, const char **, struct pt_regs *);
+int kdb_trp(int , const char **, const char **, struct pt_regs *);
diff -urN -X /home/jim/dontdiff linux.orig/kdb/kdbmain.c linux/kdb/kdbmain.c
--- linux.orig/kdb/kdbmain.c	Sun Jan 27 06:42:49 2002
+++ linux/kdb/kdbmain.c	Sun Jan 27 09:03:59 2002
@@ -91,6 +91,13 @@
 kdb_jmp_buf	kdbjmpbuf[NR_CPUS];
 #endif	/* KDB_HAVE_LONGJMP */
 
+#if defined(CONFIG_INSTRUMENT_FUNC)
+/* Hooks to automaticly disable kernel trace on entry to kdb */
+extern void kdb_trc_disable(void);
+extern void kdb_trc_continue(void);
+extern void kdb_trc_init(void);
+#endif /* CONFIG_INSTRUMENT_FUNC */
+
 	/*
 	 * kdb_commands describes the available commands.
 	 */
@@ -1212,6 +1219,11 @@
 	if (!kdb_on)
 		return 0;
 
+#if defined(CONFIG_INSTRUMENT_FUNC)
+	/* disable kernel trace while in kdb */
+	kdb_trc_disable();
+#endif
+
 	KDB_DEBUG_STATE("kdb 1", reason);
 	KDB_STATE_CLEAR(SUPPRESS);
 
@@ -1228,6 +1240,10 @@
 	if ((reason == KDB_REASON_BREAK || reason == KDB_REASON_DEBUG)
 	 && db_result == KDB_DB_NOBPT) {
 		KDB_DEBUG_STATE("kdb 2", reason);
+		/* re-enable kernel trace */
+#if defined(CONFIG_INSTRUMENT_FUNC)
+		kdb_trc_continue();
+#endif
 		return 0;	/* Not one of mine */
 	}
 
@@ -1305,11 +1321,19 @@
 			}
 			if (!recover) {
 				kdb_printf("     Cannot recover, allowing event to proceed\n");
+				/* re-enable kernel trace */
+#if defined(CONFIG_INSTRUMENT_FUNC)
+				kdb_trc_continue();
+#endif
 				return(0);
 			}
 		}
 	} else if (!KDB_IS_RUNNING()) {
 		kdb_printf("kdb: CPU switch without kdb running, I'm confused\n");
+		/* re-enable kernel trace */
+#if defined(CONFIG_INSTRUMENT_FUNC)
+		kdb_trc_continue();
+#endif
 		return(0);
 	}
 
@@ -1434,6 +1458,10 @@
 
 	KDB_STATE_CLEAR(RECURSE);
 	KDB_DEBUG_STATE("kdb 17", reason);
+	/* re-enable kernel trace */
+#if defined(CONFIG_INSTRUMENT_FUNC)
+	kdb_trc_continue();
+#endif
 	return(result != 0);
 }
 
@@ -2711,6 +2739,9 @@
 #endif
 #if defined(CONFIG_MAGIC_SYSRQ)
 	kdb_register_repeat("sr", kdb_sr, "<key>",	"Magic SysRq key", 0, KDB_REPEAT_NONE);
+#endif
+#if defined(CONFIG_INSTRUMENT_FUNC)
+	kdb_trc_init();
 #endif
 }
 
diff -urN -X /home/jim/dontdiff linux.orig/kernel/ksyms.c linux/kernel/ksyms.c
--- linux.orig/kernel/ksyms.c	Sun Jan 27 06:42:49 2002
+++ linux/kernel/ksyms.c	Sun Jan 27 09:03:59 2002
@@ -571,3 +571,21 @@
 
 EXPORT_SYMBOL(tasklist_lock);
 EXPORT_SYMBOL(pidhash);
+
+#ifdef CONFIG_INSTRUMENT_FUNC
+extern void __br_lock_usage_bug(void);
+extern void __this_fixmap_does_not_exist(void);
+extern void __cyg_profile_func_enter(void *, void *);
+extern void __cyg_profile_func_exit(void *, void *);
+extern void __trace_user(void *, void *);
+extern void __trace_stop();
+extern void *trcp;
+
+EXPORT_SYMBOL(__br_lock_usage_bug);
+EXPORT_SYMBOL(__this_fixmap_does_not_exist);
+EXPORT_SYMBOL_NOVERS(__cyg_profile_func_enter);
+EXPORT_SYMBOL_NOVERS(__cyg_profile_func_exit);
+EXPORT_SYMBOL(__trace_user);
+EXPORT_SYMBOL(__trace_stop);
+EXPORT_SYMBOL(trcp);
+#endif
diff -urN -X /home/jim/dontdiff linux.orig/patch_kallsyms linux/patch_kallsyms
--- linux.orig/patch_kallsyms	Wed Dec 31 19:00:00 1969
+++ linux/patch_kallsyms	Sun Jan 27 09:03:59 2002
@@ -0,0 +1,35 @@
+--- modutils-2.4.12/obj/obj_kallsyms.c.orig	Thu Jan  4 20:45:19 2001
++++ modutils-2.4.12/obj/obj_kallsyms.c	Tue Jan 15 05:17:43 2002
+@@ -250,6 +250,8 @@
+ 	for (sym = fin->symtab[i]; sym ; sym = sym->next) {
+ 	    if (!sym || sym->secidx >= fin->header.e_shnum)
+ 		continue;
++	    if (ELFW(ST_BIND)(sym->info) == STB_LOCAL)
++		continue;
+ 	    if ((a_sym.section_off = fin_to_allsym_map[sym->secidx]) == -1)
+ 		continue;
+ 	    if (strcmp(sym->name, "gcc2_compiled.") == 0 ||
+@@ -263,6 +265,23 @@
+ 	    append_string(sym->name, &strings, &strings_size, &strings_left);
+ 	    ++a_hdr->symbols;
+ 	}
++    }
++    for (i = 0; i < fin->local_symtab_size; ++i) {
++	struct obj_symbol *sym = fin->local_symtab[i];
++	    if (!sym || sym->secidx >= fin->header.e_shnum)
++		continue;
++	    if ((a_sym.section_off = fin_to_allsym_map[sym->secidx]) == -1)
++		continue;
++	    if (strcmp(sym->name, "gcc2_compiled.") == 0 ||
++		strncmp(sym->name, "__insmod_", 9) == 0)
++		continue;
++	    a_sym.symbol_addr = sym->value;
++	    if (fin->header.e_type == ET_REL)
++		a_sym.symbol_addr += fin->sections[sym->secidx]->header.sh_addr;
++	    a_sym.name_off = strings_size - strings_left;
++	    append_symbol(&a_sym, &symbols, &symbols_size, &symbols_left);
++	    append_string(sym->name, &strings, &strings_size, &strings_left);
++	    ++a_hdr->symbols;
+     }
+     free(fin_to_allsym_map);
+ 
diff -urN -X /home/jim/dontdiff linux.orig/scripts/inline-fix.pl linux/scripts/inline-fix.pl
--- linux.orig/scripts/inline-fix.pl	Wed Dec 31 19:00:00 1969
+++ linux/scripts/inline-fix.pl	Sun Jan 27 09:03:59 2002
@@ -0,0 +1,91 @@
+#!/usr/bin/perl
+#
+# This script changes "extern inline" to "static inline" in header
+# files.  I did this so that I could use -finstrument-functions to
+# trace Linux kernel code.  The script is pretty stupid if it finds
+# extern and inline togther its likely to make a change.  It removes
+# the inline from forward references and changes extern to static
+# for definitions.
+
+open(FIND, "find . -name \*.[ch] |") || die "couldn't run find on *.[ch]\n";
+while ($f = <FIND>) {
+	chop $f;
+	if (!open(FILE, $f)) {
+		print STDERR "Can't open $f\n";
+		next;
+	}
+#	print STDERR "scanning $f\n";
+	undef $file_content;
+	$file_content = "";
+	$modified = 0;
+OUT:
+	while ($line = <FILE>) {
+		# check for comment, ignore lines that start with 
+		# a comment.  Ignore block comments
+		if ($line =~ /^\s*\/\*.*\*\//) {
+			$file_content .= $line;
+			next;
+		}
+		if ($line =~ /^\s*\/\*/) {
+			$file_content .= $line;
+			while ($line = <FILE>) {
+				$file_content .= $line;
+				if ($line =~ /\*\//) { 
+					next OUT;
+				}
+			}
+			print STDERR "??? $f: end of file in comment?";
+			
+		}
+		if ($line  =~ /extern\s+(.*)(inline|__inline|__inline__)\s/) {
+			$extra = 0;
+			if ($line =~ /^#define/) {
+				# Alpha & ARM have defines
+				# for extern inline which I'm
+				#ignoring for now.
+				$file_content .= $line;
+				next;
+			}
+			while (!($line =~ /;|{/)) {
+				if (!($nl = <FILE>)) {
+					die "hit EOF... file=$f\n";
+				}
+				if (++$extra > 8) {
+					print STDERR "??? $f: $line";
+					last;
+				}
+				$line .= $nl;
+			}
+			if ($line =~ /{/) {
+				$line =~ s/extern/static/;
+				$modified = 1;
+			} elsif ($line =~ /;/) {
+				$line =~ s/[ 	]*__inline__[ 	]*/ /;
+				$line =~ s/[ 	]*__inline[ 	]*/ /;
+				$line =~ s/[ 	]*inline[ 	]*/ /;
+				$modified = 1;
+			}
+		}
+		$file_content .= $line;
+	}
+	close(FILE);
+	$name = $f . ".orig";
+	if ($modified && -e $name) {
+		print STDERR "$name already exists - no changes made\n";
+		next;
+	}
+	if ($modified) {
+		if (link($f, $name)) {
+			unlink($f);
+		} else {
+			print STDERR "Can't move $f to $name\n";
+			next;
+		}
+		if (!open(FILE, ">$f")) {
+			prinf STDERR "Can't open $f for output\n";
+			next;
+		}
+		print FILE $file_content;
+		close(FILE);
+	}
+}
