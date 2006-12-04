Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936950AbWLDOyc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936950AbWLDOyc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 09:54:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936929AbWLDOyT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 09:54:19 -0500
Received: from mtagate1.de.ibm.com ([195.212.29.150]:2208 "EHLO
	mtagate1.de.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936936AbWLDOxp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 09:53:45 -0500
Date: Mon, 4 Dec 2006 15:53:41 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, heiko.carstens@de.ibm.com
Subject: [S390] Reset infrastructure for re-IPL.
Message-ID: <20061204145341.GP32059@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Carstens <heiko.carstens@de.ibm.com>

[S390] Reset infrastructure for re-IPL.

In case of re-IPL and diag308 doesn't work we have to reset all devices
manually and wait synchronously that each reset finished.
This patch adds the necessary infrastucture and the first exploiter of it.

Subsystems that need to add a function that needs to be called at re-IPL
may register/unregister this function via

struct reset_call {
	struct reset_call *next;
	void (*fn)(void);
};

void register_reset_call(struct reset_call *reset);
void unregister_reset_call(struct reset_call *reset);

When the registered function get called the context is:

- all cpus beside the current one are stopped
- all machine checks and interrupts are disabled
- prefixing is disabled
- a default machine check handler is available for use

The registered functions may not take any locks are sleep.

For the common I/O layer part of this patch:

Introduce a reset_call css_reset that does the following:
- clear all subchannels
- perform a rchp on all channel paths and wait for the resulting
  machine checks
This replaces the calls to clear_all_subchannels() and
cio_reset_channel_paths() for kexec and ccw reipl. reipl_ccw_dev() now
uses reipl_find_schid() to determine the subchannel id for a given
device id.
Also remove cio_reset_channel_paths() and friends since they are not
needed anymore.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/kernel/Makefile            |    2 
 arch/s390/kernel/ipl.c               |   54 ++++++++++++++
 arch/s390/kernel/machine_kexec.c     |    9 --
 arch/s390/kernel/reipl.S             |   17 ----
 arch/s390/kernel/reipl64.S           |   16 +---
 arch/s390/kernel/relocate_kernel.S   |    5 -
 arch/s390/kernel/relocate_kernel64.S |    5 -
 arch/s390/kernel/reset.S             |   48 +++++++++++++
 drivers/s390/cio/chsc.c              |   35 ---------
 drivers/s390/cio/cio.c               |  128 +++++++++++++++++++++++++++--------
 include/asm-s390/cio.h               |    4 -
 include/asm-s390/lowcore.h           |    8 ++
 include/asm-s390/reset.h             |   23 ++++++
 13 files changed, 246 insertions(+), 108 deletions(-)

diff -urpN linux-2.6/arch/s390/kernel/ipl.c linux-2.6-patched/arch/s390/kernel/ipl.c
--- linux-2.6/arch/s390/kernel/ipl.c	2006-12-04 14:50:42.000000000 +0100
+++ linux-2.6-patched/arch/s390/kernel/ipl.c	2006-12-04 14:50:47.000000000 +0100
@@ -19,6 +19,7 @@
 #include <asm/cpcmd.h>
 #include <asm/cio.h>
 #include <asm/ebcdic.h>
+#include <asm/reset.h>
 
 #define IPL_PARM_BLOCK_VERSION 0
 #define LOADPARM_LEN 8
@@ -1024,3 +1025,56 @@ static int __init s390_ipl_init(void)
 }
 
 __initcall(s390_ipl_init);
+
+static LIST_HEAD(rcall);
+static DEFINE_MUTEX(rcall_mutex);
+
+void register_reset_call(struct reset_call *reset)
+{
+	mutex_lock(&rcall_mutex);
+	list_add(&reset->list, &rcall);
+	mutex_unlock(&rcall_mutex);
+}
+EXPORT_SYMBOL_GPL(register_reset_call);
+
+void unregister_reset_call(struct reset_call *reset)
+{
+	mutex_lock(&rcall_mutex);
+	list_del(&reset->list);
+	mutex_unlock(&rcall_mutex);
+}
+EXPORT_SYMBOL_GPL(unregister_reset_call);
+
+static void do_reset_calls(void)
+{
+	struct reset_call *reset;
+
+	list_for_each_entry(reset, &rcall, list)
+		reset->fn();
+}
+
+extern void reset_mcck_handler(void);
+
+void s390_reset_system(void)
+{
+	struct _lowcore *lc;
+
+	/* Disable all interrupts/machine checks */
+	__load_psw_mask(PSW_KERNEL_BITS & ~PSW_MASK_MCHECK);
+
+	/* Stack for interrupt/machine check handler */
+	lc = (struct _lowcore *)(unsigned long) store_prefix();
+	lc->panic_stack = S390_lowcore.panic_stack;
+
+	/* Disable prefixing */
+	set_prefix(0);
+
+	/* Disable lowcore protection */
+	__ctl_clear_bit(0,28);
+
+	/* Set new machine check handler */
+	S390_lowcore.mcck_new_psw.mask = PSW_KERNEL_BITS & ~PSW_MASK_MCHECK;
+	S390_lowcore.mcck_new_psw.addr =
+		PSW_ADDR_AMODE | (unsigned long) &reset_mcck_handler;
+	do_reset_calls();
+}
diff -urpN linux-2.6/arch/s390/kernel/machine_kexec.c linux-2.6-patched/arch/s390/kernel/machine_kexec.c
--- linux-2.6/arch/s390/kernel/machine_kexec.c	2006-11-29 22:57:37.000000000 +0100
+++ linux-2.6-patched/arch/s390/kernel/machine_kexec.c	2006-12-04 14:50:47.000000000 +0100
@@ -22,6 +22,7 @@
 #include <asm/pgalloc.h>
 #include <asm/system.h>
 #include <asm/smp.h>
+#include <asm/reset.h>
 
 static void kexec_halt_all_cpus(void *);
 
@@ -62,12 +63,6 @@ machine_shutdown(void)
 NORET_TYPE void
 machine_kexec(struct kimage *image)
 {
-	clear_all_subchannels();
-	cio_reset_channel_paths();
-
-	/* Disable lowcore protection */
-	ctl_clear_bit(0,28);
-
 	on_each_cpu(kexec_halt_all_cpus, image, 0, 0);
 	for (;;);
 }
@@ -98,6 +93,8 @@ kexec_halt_all_cpus(void *kernel_image)
 			cpu_relax();
 	}
 
+	s390_reset_system();
+
 	image = (struct kimage *) kernel_image;
 	data_mover = (relocate_kernel_t)
 		(page_to_pfn(image->control_code_page) << PAGE_SHIFT);
diff -urpN linux-2.6/arch/s390/kernel/Makefile linux-2.6-patched/arch/s390/kernel/Makefile
--- linux-2.6/arch/s390/kernel/Makefile	2006-11-29 22:57:37.000000000 +0100
+++ linux-2.6-patched/arch/s390/kernel/Makefile	2006-12-04 14:50:47.000000000 +0100
@@ -4,7 +4,7 @@
 
 EXTRA_AFLAGS	:= -traditional
 
-obj-y	:=  bitmap.o traps.o time.o process.o \
+obj-y	:=  bitmap.o traps.o time.o process.o reset.o \
             setup.o sys_s390.o ptrace.o signal.o cpcmd.o ebcdic.o \
 	    semaphore.o s390_ext.o debug.o profile.o irq.o ipl.o
 
diff -urpN linux-2.6/arch/s390/kernel/reipl64.S linux-2.6-patched/arch/s390/kernel/reipl64.S
--- linux-2.6/arch/s390/kernel/reipl64.S	2006-11-29 22:57:37.000000000 +0100
+++ linux-2.6-patched/arch/s390/kernel/reipl64.S	2006-12-04 14:50:47.000000000 +0100
@@ -10,10 +10,10 @@
 #include <asm/lowcore.h>
 		.globl	do_reipl_asm
 do_reipl_asm:	basr	%r13,0
+.Lpg0:		lpswe	.Lnewpsw-.Lpg0(%r13)
+.Lpg1:		# do store status of all registers
 
-		# do store status of all registers
-
-.Lpg0:		stg	%r1,.Lregsave-.Lpg0(%r13)
+		stg	%r1,.Lregsave-.Lpg0(%r13)
 		lghi	%r1,0x1000
 		stmg	%r0,%r15,__LC_GPREGS_SAVE_AREA-0x1000(%r1)
 		lg	%r0,.Lregsave-.Lpg0(%r13)
@@ -27,11 +27,7 @@ do_reipl_asm:	basr	%r13,0
 		stpt	__LC_CPU_TIMER_SAVE_AREA-0x1000(%r1)
 		stg	%r13, __LC_PSW_SAVE_AREA-0x1000+8(%r1)
 
-		lpswe	.Lnewpsw-.Lpg0(%r13)
-.Lpg1:		lctlg	%c6,%c6,.Lall-.Lpg0(%r13)
-		stctg	%c0,%c0,.Lregsave-.Lpg0(%r13)
-		ni	.Lregsave+4-.Lpg0(%r13),0xef
-		lctlg	%c0,%c0,.Lregsave-.Lpg0(%r13)
+		lctlg	%c6,%c6,.Lall-.Lpg0(%r13)
 		lgr	%r1,%r2
 		mvc	__LC_PGM_NEW_PSW(16),.Lpcnew-.Lpg0(%r13)
 		stsch	.Lschib-.Lpg0(%r13)
@@ -56,8 +52,7 @@ do_reipl_asm:	basr	%r13,0
 .L002:		tm	.Liplirb+8-.Lpg0(%r13),0xf3
 		jz	.L003
 		bas	%r14,.Ldisab-.Lpg0(%r13)
-.L003:		spx	.Lnull-.Lpg0(%r13)
-		st	%r1,__LC_SUBCHANNEL_ID
+.L003:		st	%r1,__LC_SUBCHANNEL_ID
 		lhi	%r1,0		 # mode 0 = esa
 		slr	%r0,%r0 	 # set cpuid to zero
 		sigp	%r1,%r0,0x12	 # switch to esa mode
@@ -70,7 +65,6 @@ do_reipl_asm:	basr	%r13,0
 .Lclkcmp:	.quad	0x0000000000000000
 .Lall:		.quad	0x00000000ff000000
 .Lregsave:	.quad	0x0000000000000000
-.Lnull:		.long	0x0000000000000000
 		.align	16
 /*
  * These addresses have to be 31 bit otherwise
diff -urpN linux-2.6/arch/s390/kernel/reipl.S linux-2.6-patched/arch/s390/kernel/reipl.S
--- linux-2.6/arch/s390/kernel/reipl.S	2006-11-29 22:57:37.000000000 +0100
+++ linux-2.6-patched/arch/s390/kernel/reipl.S	2006-12-04 14:50:47.000000000 +0100
@@ -11,19 +11,10 @@
 		.globl	do_reipl_asm
 do_reipl_asm:	basr	%r13,0
 .Lpg0:		lpsw	.Lnewpsw-.Lpg0(%r13)
-
-		# switch off lowcore protection
-
-.Lpg1:		stctl	%c0,%c0,.Lctlsave1-.Lpg0(%r13)
-		stctl	%c0,%c0,.Lctlsave2-.Lpg0(%r13)
-		ni	.Lctlsave1-.Lpg0(%r13),0xef
-		lctl	%c0,%c0,.Lctlsave1-.Lpg0(%r13)
-
-		# do store status of all registers
+.Lpg1:		# do store status of all registers
 
 		stm	%r0,%r15,__LC_GPREGS_SAVE_AREA
 		stctl	%c0,%c15,__LC_CREGS_SAVE_AREA
-		mvc	__LC_CREGS_SAVE_AREA(4),.Lctlsave2-.Lpg0(%r13)
 		stam	%a0,%a15,__LC_AREGS_SAVE_AREA
 		stpx	__LC_PREFIX_SAVE_AREA
 		stckc	.Lclkcmp-.Lpg0(%r13)
@@ -56,8 +47,7 @@ do_reipl_asm:	basr	%r13,0
 .L002:		tm	.Liplirb+8-.Lpg0(%r13),0xf3
 		jz	.L003
 		bas	%r14,.Ldisab-.Lpg0(%r13)
-.L003:		spx	.Lnull-.Lpg0(%r13)
-		st	%r1,__LC_SUBCHANNEL_ID
+.L003:		st	%r1,__LC_SUBCHANNEL_ID
 		lpsw	0
 		sigp	0,0,0(6)
 .Ldisab:	st	%r14,.Ldispsw+4-.Lpg0(%r13)
@@ -65,9 +55,6 @@ do_reipl_asm:	basr	%r13,0
 		.align	8
 .Lclkcmp:	.quad	0x0000000000000000
 .Lall:		.long	0xff000000
-.Lnull:		.long	0x00000000
-.Lctlsave1:	.long	0x00000000
-.Lctlsave2:	.long	0x00000000
 		.align	8
 .Lnewpsw:	.long	0x00080000,0x80000000+.Lpg1
 .Lpcnew:	.long	0x00080000,0x80000000+.Lecs
diff -urpN linux-2.6/arch/s390/kernel/relocate_kernel64.S linux-2.6-patched/arch/s390/kernel/relocate_kernel64.S
--- linux-2.6/arch/s390/kernel/relocate_kernel64.S	2006-11-29 22:57:37.000000000 +0100
+++ linux-2.6-patched/arch/s390/kernel/relocate_kernel64.S	2006-12-04 14:50:47.000000000 +0100
@@ -27,8 +27,7 @@
 	relocate_kernel:
 		basr	%r13,0		# base address
 	.base:
-		stnsm	sys_msk-.base(%r13),0xf8	# disable DAT and IRQs
-		spx	zero64-.base(%r13)	# absolute addressing mode
+		stnsm	sys_msk-.base(%r13),0xfb	# disable DAT
 		stctg	%c0,%c15,ctlregs-.base(%r13)
 		stmg	%r0,%r15,gprregs-.base(%r13)
 		lghi	%r0,3
@@ -100,8 +99,6 @@
 		lpsw	0		# hopefully start new kernel...
 
 		.align	8
-	zero64:
-		.quad	0
 	load_psw:
 		.long	0x00080000,0x80000000
 	sys_msk:
diff -urpN linux-2.6/arch/s390/kernel/relocate_kernel.S linux-2.6-patched/arch/s390/kernel/relocate_kernel.S
--- linux-2.6/arch/s390/kernel/relocate_kernel.S	2006-11-29 22:57:37.000000000 +0100
+++ linux-2.6-patched/arch/s390/kernel/relocate_kernel.S	2006-12-04 14:50:47.000000000 +0100
@@ -26,8 +26,7 @@
 	relocate_kernel:
 		basr	%r13,0		# base address
 	.base:
-		stnsm	sys_msk-.base(%r13),0xf8	# disable DAT and IRQ (external)
-		spx	zero64-.base(%r13)	# absolute addressing mode
+		stnsm	sys_msk-.base(%r13),0xfb	# disable DAT
 		stctl	%c0,%c15,ctlregs-.base(%r13)
 		stm	%r0,%r15,gprregs-.base(%r13)
 		la	%r1,load_psw-.base(%r13)
@@ -97,8 +96,6 @@
 		lpsw	0		# hopefully start new kernel...
 
 		.align	8
-	zero64:
-		.quad	0
 	load_psw:
 		.long	0x00080000,0x80000000
 	sys_msk:
diff -urpN linux-2.6/arch/s390/kernel/reset.S linux-2.6-patched/arch/s390/kernel/reset.S
--- linux-2.6/arch/s390/kernel/reset.S	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6-patched/arch/s390/kernel/reset.S	2006-12-04 14:50:47.000000000 +0100
@@ -0,0 +1,48 @@
+/*
+ *  arch/s390/kernel/reset.S
+ *
+ *    Copyright (C) IBM Corp. 2006
+ *    Author(s): Heiko Carstens <heiko.carstens@de.ibm.com>
+ */
+
+#include <asm/ptrace.h>
+#include <asm/lowcore.h>
+
+#ifdef CONFIG_64BIT
+
+	.globl	reset_mcck_handler
+reset_mcck_handler:
+	basr	%r13,0
+0:	lg	%r15,__LC_PANIC_STACK	# load panic stack
+	aghi	%r15,-STACK_FRAME_OVERHEAD
+	lg	%r1,s390_reset_mcck_handler-0b(%r13)
+	ltgr	%r1,%r1
+	jz	1f
+	basr	%r14,%r1
+1:	la	%r1,4095
+	lmg	%r0,%r15,__LC_GPREGS_SAVE_AREA-4095(%r1)
+	lpswe	__LC_MCK_OLD_PSW
+
+	.globl	s390_reset_mcck_handler
+s390_reset_mcck_handler:
+	.quad	0
+
+#else /* CONFIG_64BIT */
+
+	.globl	reset_mcck_handler
+reset_mcck_handler:
+	basr	%r13,0
+0:	l	%r15,__LC_PANIC_STACK	# load panic stack
+	ahi	%r15,-STACK_FRAME_OVERHEAD
+	l	%r1,s390_reset_mcck_handler-0b(%r13)
+	ltr	%r1,%r1
+	jz	1f
+	basr	%r14,%r1
+1:	lm	%r0,%r15,__LC_GPREGS_SAVE_AREA
+	lpsw	__LC_MCK_OLD_PSW
+
+	.globl	s390_reset_mcck_handler
+s390_reset_mcck_handler:
+	.long	0
+
+#endif /* CONFIG_64BIT */
diff -urpN linux-2.6/drivers/s390/cio/chsc.c linux-2.6-patched/drivers/s390/cio/chsc.c
--- linux-2.6/drivers/s390/cio/chsc.c	2006-11-29 22:57:37.000000000 +0100
+++ linux-2.6-patched/drivers/s390/cio/chsc.c	2006-12-04 14:50:47.000000000 +0100
@@ -1465,41 +1465,6 @@ chsc_get_chp_desc(struct subchannel *sch
 	return desc;
 }
 
-static int reset_channel_path(struct channel_path *chp)
-{
-	int cc;
-
-	cc = rchp(chp->id);
-	switch (cc) {
-	case 0:
-		return 0;
-	case 2:
-		return -EBUSY;
-	default:
-		return -ENODEV;
-	}
-}
-
-static void reset_channel_paths_css(struct channel_subsystem *css)
-{
-	int i;
-
-	for (i = 0; i <= __MAX_CHPID; i++) {
-		if (css->chps[i])
-			reset_channel_path(css->chps[i]);
-	}
-}
-
-void cio_reset_channel_paths(void)
-{
-	int i;
-
-	for (i = 0; i <= __MAX_CSSID; i++) {
-		if (css[i] && css[i]->valid)
-			reset_channel_paths_css(css[i]);
-	}
-}
-
 static int __init
 chsc_alloc_sei_area(void)
 {
diff -urpN linux-2.6/drivers/s390/cio/cio.c linux-2.6-patched/drivers/s390/cio/cio.c
--- linux-2.6/drivers/s390/cio/cio.c	2006-11-29 22:57:37.000000000 +0100
+++ linux-2.6-patched/drivers/s390/cio/cio.c	2006-12-04 14:50:47.000000000 +0100
@@ -21,6 +21,7 @@
 #include <asm/irq.h>
 #include <asm/irq_regs.h>
 #include <asm/setup.h>
+#include <asm/reset.h>
 #include "airq.h"
 #include "cio.h"
 #include "css.h"
@@ -28,6 +29,7 @@
 #include "ioasm.h"
 #include "blacklist.h"
 #include "cio_debug.h"
+#include "../s390mach.h"
 
 debug_info_t *cio_debug_msg_id;
 debug_info_t *cio_debug_trace_id;
@@ -841,26 +843,12 @@ __clear_subchannel_easy(struct subchanne
 	return -EBUSY;
 }
 
-struct sch_match_id {
-	struct subchannel_id schid;
-	struct ccw_dev_id devid;
-	int rc;
-};
-
-static int __shutdown_subchannel_easy_and_match(struct subchannel_id schid,
-	void *data)
+static int __shutdown_subchannel_easy(struct subchannel_id schid, void *data)
 {
 	struct schib schib;
-	struct sch_match_id *match_id = data;
 
 	if (stsch_err(schid, &schib))
 		return -ENXIO;
-	if (match_id && schib.pmcw.dnv &&
-		(schib.pmcw.dev == match_id->devid.devno) &&
-		(schid.ssid == match_id->devid.ssid)) {
-		match_id->schid = schid;
-		match_id->rc = 0;
-	}
 	if (!schib.pmcw.ena)
 		return 0;
 	switch(__disable_subchannel_easy(schid, &schib)) {
@@ -876,27 +864,111 @@ static int __shutdown_subchannel_easy_an
 	return 0;
 }
 
-static int clear_all_subchannels_and_match(struct ccw_dev_id *devid,
-	struct subchannel_id *schid)
+static atomic_t chpid_reset_count;
+
+static void s390_reset_chpids_mcck_handler(void)
+{
+	struct crw crw;
+	struct mci *mci;
+
+	/* Check for pending channel report word. */
+	mci = (struct mci *)&S390_lowcore.mcck_interruption_code;
+	if (!mci->cp)
+		return;
+	/* Process channel report words. */
+	while (stcrw(&crw) == 0) {
+		/* Check for responses to RCHP. */
+		if (crw.slct && crw.rsc == CRW_RSC_CPATH)
+			atomic_dec(&chpid_reset_count);
+	}
+}
+
+#define RCHP_TIMEOUT (30 * USEC_PER_SEC)
+static void css_reset(void)
+{
+	int i, ret;
+	unsigned long long timeout;
+
+	/* Reset subchannels. */
+	for_each_subchannel(__shutdown_subchannel_easy,  NULL);
+	/* Reset channel paths. */
+	s390_reset_mcck_handler = s390_reset_chpids_mcck_handler;
+	/* Enable channel report machine checks. */
+	__ctl_set_bit(14, 28);
+	/* Temporarily reenable machine checks. */
+	local_mcck_enable();
+	for (i = 0; i <= __MAX_CHPID; i++) {
+		ret = rchp(i);
+		if ((ret == 0) || (ret == 2))
+			/*
+			 * rchp either succeeded, or another rchp is already
+			 * in progress. In either case, we'll get a crw.
+			 */
+			atomic_inc(&chpid_reset_count);
+	}
+	/* Wait for machine check for all channel paths. */
+	timeout = get_clock() + (RCHP_TIMEOUT << 12);
+	while (atomic_read(&chpid_reset_count) != 0) {
+		if (get_clock() > timeout)
+			break;
+		cpu_relax();
+	}
+	/* Disable machine checks again. */
+	local_mcck_disable();
+	/* Disable channel report machine checks. */
+	__ctl_clear_bit(14, 28);
+	s390_reset_mcck_handler = NULL;
+}
+
+static struct reset_call css_reset_call = {
+	.fn = css_reset,
+};
+
+static int __init init_css_reset_call(void)
+{
+	atomic_set(&chpid_reset_count, 0);
+	register_reset_call(&css_reset_call);
+	return 0;
+}
+
+arch_initcall(init_css_reset_call);
+
+struct sch_match_id {
+	struct subchannel_id schid;
+	struct ccw_dev_id devid;
+	int rc;
+};
+
+static int __reipl_subchannel_match(struct subchannel_id schid, void *data)
+{
+	struct schib schib;
+	struct sch_match_id *match_id = data;
+
+	if (stsch_err(schid, &schib))
+		return -ENXIO;
+	if (schib.pmcw.dnv &&
+	    (schib.pmcw.dev == match_id->devid.devno) &&
+	    (schid.ssid == match_id->devid.ssid)) {
+		match_id->schid = schid;
+		match_id->rc = 0;
+		return 1;
+	}
+	return 0;
+}
+
+static int reipl_find_schid(struct ccw_dev_id *devid,
+			    struct subchannel_id *schid)
 {
 	struct sch_match_id match_id;
 
 	match_id.devid = *devid;
 	match_id.rc = -ENODEV;
-	local_irq_disable();
-	for_each_subchannel(__shutdown_subchannel_easy_and_match, &match_id);
+	for_each_subchannel(__reipl_subchannel_match, &match_id);
 	if (match_id.rc == 0)
 		*schid = match_id.schid;
 	return match_id.rc;
 }
 
-
-void clear_all_subchannels(void)
-{
-	local_irq_disable();
-	for_each_subchannel(__shutdown_subchannel_easy_and_match, NULL);
-}
-
 extern void do_reipl_asm(__u32 schid);
 
 /* Make sure all subchannels are quiet before we re-ipl an lpar. */
@@ -904,9 +976,9 @@ void reipl_ccw_dev(struct ccw_dev_id *de
 {
 	struct subchannel_id schid;
 
-	if (clear_all_subchannels_and_match(devid, &schid))
+	s390_reset_system();
+	if (reipl_find_schid(devid, &schid) != 0)
 		panic("IPL Device not found\n");
-	cio_reset_channel_paths();
 	do_reipl_asm(*((__u32*)&schid));
 }
 
diff -urpN linux-2.6/include/asm-s390/cio.h linux-2.6-patched/include/asm-s390/cio.h
--- linux-2.6/include/asm-s390/cio.h	2006-11-29 22:57:37.000000000 +0100
+++ linux-2.6-patched/include/asm-s390/cio.h	2006-12-04 14:50:47.000000000 +0100
@@ -285,10 +285,6 @@ extern int diag210(struct diag210 *addr)
 
 extern void wait_cons_dev(void);
 
-extern void clear_all_subchannels(void);
-
-extern void cio_reset_channel_paths(void);
-
 extern void css_schedule_reprobe(void);
 
 extern void reipl_ccw_dev(struct ccw_dev_id *id);
diff -urpN linux-2.6/include/asm-s390/lowcore.h linux-2.6-patched/include/asm-s390/lowcore.h
--- linux-2.6/include/asm-s390/lowcore.h	2006-11-29 22:57:37.000000000 +0100
+++ linux-2.6-patched/include/asm-s390/lowcore.h	2006-12-04 14:50:47.000000000 +0100
@@ -362,6 +362,14 @@ static inline void set_prefix(__u32 addr
 	asm volatile("spx %0" : : "m" (address) : "memory");
 }
 
+static inline __u32 store_prefix(void)
+{
+	__u32 address;
+
+	asm volatile("stpx %0" : "=m" (address));
+	return address;
+}
+
 #define __PANIC_MAGIC           0xDEADC0DE
 
 #endif
diff -urpN linux-2.6/include/asm-s390/reset.h linux-2.6-patched/include/asm-s390/reset.h
--- linux-2.6/include/asm-s390/reset.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6-patched/include/asm-s390/reset.h	2006-12-04 14:50:47.000000000 +0100
@@ -0,0 +1,23 @@
+/*
+ *  include/asm-s390/reset.h
+ *
+ *    Copyright IBM Corp. 2006
+ *    Author(s): Heiko Carstens <heiko.carstens@de.ibm.com>
+ */
+
+#ifndef _ASM_S390_RESET_H
+#define _ASM_S390_RESET_H
+
+#include <linux/list.h>
+
+struct reset_call {
+	struct list_head list;
+	void (*fn)(void);
+};
+
+extern void register_reset_call(struct reset_call *reset);
+extern void unregister_reset_call(struct reset_call *reset);
+extern void s390_reset_system(void);
+extern void (*s390_reset_mcck_handler)(void);
+
+#endif /* _ASM_S390_RESET_H */
