Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262296AbUKKRRa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262296AbUKKRRa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Nov 2004 12:17:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262307AbUKKRRa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Nov 2004 12:17:30 -0500
Received: from mtagate1.de.ibm.com ([195.212.29.150]:49582 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP id S262296AbUKKROx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Nov 2004 12:14:53 -0500
Date: Thu, 11 Nov 2004 18:14:39 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [patch] cputime: microsecond based cputime for s390.
Message-ID: <20041111171439.GA4900@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,
I got no more complaints about the cputime patch, only the one
about konqueror. Weelll, in this case here is the patch (against
2.6.10-rc1-mm5) that introduces micro-second based cpu accounting
for s390. Perhaps one of the gurus for the other architectures
wants to implement better accouting as well. Who knows?

There are a couple of other patches on their way to you. One is
for 2.6.10-rc1-mm5 to correct the s390 mm defines for 4 level
page tables and a set of 10 update patches against -bk.

blue skies,
  Martin.

---

[patch] cputime: microsecond based cputime for s390.

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

This patch adds the architecture magic to replace the jiffies based
cputime with microsecond based cputime and it adds code to calculate
involuntary wait time. With this patch the numbers reported by top and
ps when running on LPAR or z/VM are finally not junk anymore.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

diffstat:
 arch/s390/Kconfig               |    7 +
 arch/s390/kernel/binfmt_elf32.c |    5 -
 arch/s390/kernel/entry.S        |  135 ++++++++++++++++++++++++++++++-
 arch/s390/kernel/entry64.S      |  128 ++++++++++++++++++++++++++++--
 arch/s390/kernel/irq.c          |    8 +
 arch/s390/kernel/time.c         |   42 ++-------
 arch/s390/kernel/vtime.c        |  111 ++++++++++++++++++++++----
 include/asm-s390/cputime.h      |  170 +++++++++++++++++++++++++++++++++++++++-
 include/asm-s390/hardirq.h      |    3 
 include/asm-s390/lowcore.h      |   47 +++++++++--
 include/asm-s390/system.h       |   18 ++++
 include/asm-s390/timer.h        |    2 
 12 files changed, 604 insertions(+), 72 deletions(-)

diff -urN linux-2.6/arch/s390/Kconfig linux-2.6-cputime/arch/s390/Kconfig
--- linux-2.6/arch/s390/Kconfig	2004-11-11 15:37:16.000000000 +0100
+++ linux-2.6-cputime/arch/s390/Kconfig	2004-11-11 15:37:44.000000000 +0100
@@ -366,6 +366,13 @@
 	  This provides a kernel interface for virtual CPU timers.
 	  Default is disabled.
 
+config VIRT_CPU_ACCOUNTING
+	bool "Base user process accounting on virtual cpu timer"
+	depends on VIRT_TIMER
+	help
+	  Select this option to use CPU timer deltas to do user
+	  process accounting.
+
 config APPLDATA_BASE
 	bool "Linux - VM Monitor Stream, base infrastructure"
 	depends on PROC_FS && VIRT_TIMER=y
diff -urN linux-2.6/arch/s390/kernel/binfmt_elf32.c linux-2.6-cputime/arch/s390/kernel/binfmt_elf32.c
--- linux-2.6/arch/s390/kernel/binfmt_elf32.c	2004-11-11 15:37:16.000000000 +0100
+++ linux-2.6-cputime/arch/s390/kernel/binfmt_elf32.c	2004-11-11 15:37:44.000000000 +0100
@@ -178,9 +178,8 @@
 static __inline__ void
 cputime_to_compat_timeval(const cputime_t cputime, struct compat_timeval *value)
 {
-	unsigned long jiffies = cputime_to_jiffies(cputime);
-	value->tv_usec = (jiffies % HZ) * (1000000L / HZ);
-	value->tv_sec = jiffies / HZ;
+	value->tv_usec = cputime % 1000000;
+	value->tv_sec = cputime / 1000000;
 }
 
 #include "../../../fs/binfmt_elf.c"
diff -urN linux-2.6/arch/s390/kernel/entry64.S linux-2.6-cputime/arch/s390/kernel/entry64.S
--- linux-2.6/arch/s390/kernel/entry64.S	2004-11-11 15:37:16.000000000 +0100
+++ linux-2.6-cputime/arch/s390/kernel/entry64.S	2004-11-11 15:37:44.000000000 +0100
@@ -58,6 +58,21 @@
 
 #define BASED(name) name-system_call(%r13)
 
+	.macro  STORE_TIMER lc_offset
+#ifdef CONFIG_VIRT_CPU_ACCOUNTING
+	stpt	\lc_offset
+#endif
+	.endm
+
+#ifdef CONFIG_VIRT_CPU_ACCOUNTING
+	.macro  UPDATE_VTIME lc_from,lc_to,lc_sum
+	lg	%r10,\lc_from
+	slg	%r10,\lc_to
+	alg	%r10,\lc_sum
+	stg	%r10,\lc_sum
+	.endm
+#endif
+
 /*
  * Register usage in interrupt handlers:
  *    R9  - pointer to current task structure
@@ -117,6 +132,7 @@
 	ni	__LC_RETURN_PSW+1,0xfd	# clear wait state bit
 	.endif
 	lmg	%r0,%r15,SP_R0(%r15)	# load gprs 0-15 of user
+	STORE_TIMER __LC_EXIT_TIMER
 	lpswe	__LC_RETURN_PSW		# back to caller
 	.endm
 
@@ -156,9 +172,21 @@
 
 	.globl  system_call
 system_call:
+	STORE_TIMER __LC_SYNC_ENTER_TIMER
+sysc_saveall:
 	SAVE_ALL_BASE __LC_SAVE_AREA
         SAVE_ALL __LC_SVC_OLD_PSW,__LC_SAVE_AREA,1
 	llgh    %r7,__LC_SVC_INT_CODE # get svc number from lowcore
+#ifdef CONFIG_VIRT_CPU_ACCOUNTING
+sysc_vtime:
+	tm	SP_PSW+1(%r15),0x01	# interrupting from user ?
+	jz	sysc_do_svc
+	UPDATE_VTIME __LC_EXIT_TIMER,__LC_SYNC_ENTER_TIMER,__LC_USER_TIMER
+sysc_stime:
+	UPDATE_VTIME __LC_LAST_UPDATE_TIMER,__LC_EXIT_TIMER,__LC_SYSTEM_TIMER
+sysc_update:
+	mvc	__LC_LAST_UPDATE_TIMER(8),__LC_SYNC_ENTER_TIMER
+#endif
 sysc_do_svc:
 	lg	%r9,__LC_THREAD_INFO	# load pointer to thread_info struct
         slag    %r7,%r7,2         # *4 and test for svc 0
@@ -439,10 +467,19 @@
  * we just ignore the PER event (FIXME: is there anything we have to do
  * for LPSW?).
  */
+	STORE_TIMER __LC_SYNC_ENTER_TIMER
 	SAVE_ALL_BASE __LC_SAVE_AREA
         tm      __LC_PGM_INT_CODE+1,0x80 # check whether we got a per exception
         jnz     pgm_per                  # got per exception -> special case
 	SAVE_ALL __LC_PGM_OLD_PSW,__LC_SAVE_AREA,1
+#ifdef CONFIG_VIRT_CPU_ACCOUNTING
+	tm	SP_PSW+1(%r15),0x01	# interrupting from user ?
+	jz	pgm_no_vtime
+	UPDATE_VTIME __LC_EXIT_TIMER,__LC_SYNC_ENTER_TIMER,__LC_USER_TIMER
+	UPDATE_VTIME __LC_LAST_UPDATE_TIMER,__LC_EXIT_TIMER,__LC_SYSTEM_TIMER
+	mvc	__LC_LAST_UPDATE_TIMER(8),__LC_SYNC_ENTER_TIMER
+pgm_no_vtime:
+#endif
 	lg	%r9,__LC_THREAD_INFO	# load pointer to thread_info struct
 	lgf     %r3,__LC_PGM_ILC	 # load program interruption code
 	lghi	%r8,0x7f
@@ -473,6 +510,14 @@
 #
 pgm_per_std:
 	SAVE_ALL __LC_PGM_OLD_PSW,__LC_SAVE_AREA,1
+#ifdef CONFIG_VIRT_CPU_ACCOUNTING
+	tm	SP_PSW+1(%r15),0x01	# interrupting from user ?
+	jz	pgm_no_vtime2
+	UPDATE_VTIME __LC_EXIT_TIMER,__LC_SYNC_ENTER_TIMER,__LC_USER_TIMER
+	UPDATE_VTIME __LC_LAST_UPDATE_TIMER,__LC_EXIT_TIMER,__LC_SYSTEM_TIMER
+	mvc	__LC_LAST_UPDATE_TIMER(8),__LC_SYNC_ENTER_TIMER
+pgm_no_vtime2:
+#endif
 	lg	%r9,__LC_THREAD_INFO	# load pointer to thread_info struct
 	lg	%r1,__TI_task(%r9)
 	mvc	__THREAD_per+__PER_atmid(2,%r1),__LC_PER_ATMID
@@ -490,6 +535,14 @@
 #
 pgm_svcper:
 	SAVE_ALL __LC_SVC_OLD_PSW,__LC_SAVE_AREA,1
+#ifdef CONFIG_VIRT_CPU_ACCOUNTING
+	tm	SP_PSW+1(%r15),0x01	# interrupting from user ?
+	jz	pgm_no_vtime3
+	UPDATE_VTIME __LC_EXIT_TIMER,__LC_SYNC_ENTER_TIMER,__LC_USER_TIMER
+	UPDATE_VTIME __LC_LAST_UPDATE_TIMER,__LC_EXIT_TIMER,__LC_SYSTEM_TIMER
+	mvc	__LC_LAST_UPDATE_TIMER(8),__LC_SYNC_ENTER_TIMER
+pgm_no_vtime3:
+#endif
 	llgh    %r7,__LC_SVC_INT_CODE	# get svc number from lowcore
 	lg	%r9,__LC_THREAD_INFO	# load pointer to thread_info struct
 	lg	%r1,__TI_task(%r9)
@@ -505,9 +558,18 @@
  */
         .globl io_int_handler
 io_int_handler:
+	STORE_TIMER __LC_ASYNC_ENTER_TIMER
 	stck	__LC_INT_CLOCK
 	SAVE_ALL_BASE __LC_SAVE_AREA+32
         SAVE_ALL __LC_IO_OLD_PSW,__LC_SAVE_AREA+32,0
+#ifdef CONFIG_VIRT_CPU_ACCOUNTING
+	tm	SP_PSW+1(%r15),0x01	# interrupting from user ?
+	jz	io_no_vtime
+	UPDATE_VTIME __LC_EXIT_TIMER,__LC_ASYNC_ENTER_TIMER,__LC_USER_TIMER
+	UPDATE_VTIME __LC_LAST_UPDATE_TIMER,__LC_EXIT_TIMER,__LC_SYSTEM_TIMER
+	mvc	__LC_LAST_UPDATE_TIMER(8),__LC_ASYNC_ENTER_TIMER
+io_no_vtime:
+#endif
 	lg	%r9,__LC_THREAD_INFO	# load pointer to thread_info struct
         la      %r2,SP_PTREGS(%r15)    # address of register-save area
 	brasl   %r14,do_IRQ            # call standard irq handler
@@ -593,9 +655,18 @@
  */
         .globl  ext_int_handler
 ext_int_handler:
+	STORE_TIMER __LC_ASYNC_ENTER_TIMER
 	stck	__LC_INT_CLOCK
 	SAVE_ALL_BASE __LC_SAVE_AREA+32
         SAVE_ALL __LC_EXT_OLD_PSW,__LC_SAVE_AREA+32,0
+#ifdef CONFIG_VIRT_CPU_ACCOUNTING
+	tm	SP_PSW+1(%r15),0x01	# interrupting from user ?
+	jz	ext_no_vtime
+	UPDATE_VTIME __LC_EXIT_TIMER,__LC_ASYNC_ENTER_TIMER,__LC_USER_TIMER
+	UPDATE_VTIME __LC_LAST_UPDATE_TIMER,__LC_EXIT_TIMER,__LC_SYSTEM_TIMER
+	mvc	__LC_LAST_UPDATE_TIMER(8),__LC_ASYNC_ENTER_TIMER
+ext_no_vtime:
+#endif
 	lg	%r9,__LC_THREAD_INFO	# load pointer to thread_info struct
 	la	%r2,SP_PTREGS(%r15)    # address of register-save area
 	llgh	%r3,__LC_EXT_INT_CODE  # get interruption code
@@ -607,8 +678,17 @@
  */
         .globl mcck_int_handler
 mcck_int_handler:
+	STORE_TIMER __LC_ASYNC_ENTER_TIMER
 	SAVE_ALL_BASE __LC_SAVE_AREA+64
         SAVE_ALL __LC_MCK_OLD_PSW,__LC_SAVE_AREA+64,0
+#ifdef CONFIG_VIRT_CPU_ACCOUNTING
+	tm	SP_PSW+1(%r15),0x01	# interrupting from user ?
+	jz	mcck_no_vtime
+	UPDATE_VTIME __LC_EXIT_TIMER,__LC_ASYNC_ENTER_TIMER,__LC_USER_TIMER
+	UPDATE_VTIME __LC_LAST_UPDATE_TIMER,__LC_EXIT_TIMER,__LC_SYSTEM_TIMER
+	mvc	__LC_LAST_UPDATE_TIMER(8),__LC_ASYNC_ENTER_TIMER
+mcck_no_vtime:
+#endif
 	brasl   %r14,s390_do_machine_check
 mcck_return:
         RESTORE_ALL 0
@@ -698,17 +778,47 @@
 	br	%r14
 
 cleanup_system_call:
-	mvc	__LC_RETURN_PSW(8),0(%r12)
-	clc	8(8,%r12),BASED(cleanup_table_system_call)
-	jne	0f
+	mvc	__LC_RETURN_PSW(16),0(%r12)
+#ifdef CONFIG_VIRT_CPU_ACCOUNTING
+	clc	__LC_RETURN_PSW+8(8),BASED(cleanup_system_call_insn+8)
+	jh	0f
+	mvc	__LC_SYNC_ENTER_TIMER(8),__LC_ASYNC_ENTER_TIMER
+0:	clc	__LC_RETURN_PSW+8(8),BASED(cleanup_system_call_insn+16)
+	jhe	cleanup_vtime
+#endif
+	clc	__LC_RETURN_PSW+8(8),BASED(cleanup_system_call_insn)
+	jh	0f
 	mvc	__LC_SAVE_AREA(32),__LC_SAVE_AREA+32
 0:	stg	%r13,__LC_SAVE_AREA+40
 	SAVE_ALL __LC_SVC_OLD_PSW,__LC_SAVE_AREA,1
 	stg	%r15,__LC_SAVE_AREA+56
 	llgh	%r7,__LC_SVC_INT_CODE
+#ifdef CONFIG_VIRT_CPU_ACCOUNTING
+cleanup_vtime:
+	clc	__LC_RETURN_PSW+8(8),BASED(cleanup_system_call_insn+24)
+	jhe	cleanup_stime
+	tm	SP_PSW+1(%r15),0x01	# interrupting from user ?
+	jz	cleanup_novtime
+	UPDATE_VTIME __LC_EXIT_TIMER,__LC_SYNC_ENTER_TIMER,__LC_USER_TIMER
+cleanup_stime:
+	clc	__LC_RETURN_PSW+8(8),BASED(cleanup_system_call_insn+32)
+	jh	cleanup_update
+	UPDATE_VTIME __LC_LAST_UPDATE_TIMER,__LC_EXIT_TIMER,__LC_SYSTEM_TIMER
+cleanup_update:
+	mvc	__LC_LAST_UPDATE_TIMER(8),__LC_SYNC_ENTER_TIMER
+cleanup_novtime:
+#endif
 	mvc	__LC_RETURN_PSW+8(8),BASED(cleanup_table_system_call+8)
 	la	%r12,__LC_RETURN_PSW
 	br	%r14
+cleanup_system_call_insn:
+	.quad	sysc_saveall
+#ifdef CONFIG_VIRT_CPU_ACCOUNTING
+	.quad   system_call
+	.quad   sysc_vtime
+	.quad   sysc_stime
+	.quad   sysc_update
+#endif
 
 cleanup_sysc_return:
 	mvc	__LC_RETURN_PSW(8),0(%r12)
@@ -717,15 +827,23 @@
 	br	%r14
 
 cleanup_sysc_leave:
-	clc	8(8,%r12),BASED(cleanup_sysc_leave_lpsw)
+	clc	8(8,%r12),BASED(cleanup_sysc_leave_insn)
+	je	0f
+#ifdef CONFIG_VIRT_CPU_ACCOUNTING
+	mvc	__LC_EXIT_TIMER(8),__LC_ASYNC_ENTER_TIMER
+	clc	8(8,%r12),BASED(cleanup_sysc_leave_insn+8)
 	je	0f
+#endif
 	mvc	__LC_RETURN_PSW(16),SP_PSW(%r15)
 	mvc	__LC_SAVE_AREA+32(32),SP_R12(%r15)
 	lmg	%r0,%r11,SP_R0(%r15)
 	lg	%r15,SP_R15(%r15)
 0:	la	%r12,__LC_RETURN_PSW
 	br	%r14
-cleanup_sysc_leave_lpsw:
+cleanup_sysc_leave_insn:
+#ifdef CONFIG_VIRT_CPU_ACCOUNTING
+	.quad	sysc_leave + 16
+#endif
 	.quad	sysc_leave + 12
 
 /*
diff -urN linux-2.6/arch/s390/kernel/entry.S linux-2.6-cputime/arch/s390/kernel/entry.S
--- linux-2.6/arch/s390/kernel/entry.S	2004-11-11 15:37:16.000000000 +0100
+++ linux-2.6-cputime/arch/s390/kernel/entry.S	2004-11-11 15:37:44.000000000 +0100
@@ -66,6 +66,27 @@
  *    R15 - kernel stack pointer
  */
 
+	.macro  STORE_TIMER lc_offset
+#ifdef CONFIG_VIRT_CPU_ACCOUNTING
+	stpt	\lc_offset
+#endif
+	.endm
+
+#ifdef CONFIG_VIRT_CPU_ACCOUNTING
+	.macro  UPDATE_VTIME lc_from,lc_to,lc_sum
+	lm	%r10,%r11,\lc_from
+	sl	%r10,\lc_to
+	sl	%r11,\lc_to+4
+	bc	3,BASED(0f)
+	sl	%r10,BASED(.Lc_1)
+0:	al	%r10,\lc_sum
+	al	%r11,\lc_sum+4
+	bc	12,BASED(1f)
+	al	%r10,BASED(.Lc_1)
+1:	stm	%r10,%r11,\lc_sum
+	.endm
+#endif
+
 	.macro	SAVE_ALL_BASE savearea
 	stm	%r12,%r15,\savearea
 	l	%r13,__LC_SVC_NEW_PSW+4	# load &system_call to %r13
@@ -118,6 +139,7 @@
 	ni	__LC_RETURN_PSW+1,0xfd	# clear wait state bit
 	.endif
 	lm	%r0,%r15,SP_R0(%r15)	# load gprs 0-15 of user
+	STORE_TIMER __LC_EXIT_TIMER
 	lpsw	__LC_RETURN_PSW		# back to caller
 	.endm
 
@@ -159,9 +181,21 @@
 
 	.globl  system_call
 system_call:
+	STORE_TIMER __LC_SYNC_ENTER_TIMER
+sysc_saveall:
 	SAVE_ALL_BASE __LC_SAVE_AREA
         SAVE_ALL __LC_SVC_OLD_PSW,__LC_SAVE_AREA,1
 	lh	%r7,0x8a	  # get svc number from lowcore
+#ifdef CONFIG_VIRT_CPU_ACCOUNTING
+sysc_vtime:
+	tm	SP_PSW+1(%r15),0x01	# interrupting from user ?
+	bz	BASED(sysc_do_svc)
+	UPDATE_VTIME __LC_EXIT_TIMER,__LC_SYNC_ENTER_TIMER,__LC_USER_TIMER
+sysc_stime:
+	UPDATE_VTIME __LC_LAST_UPDATE_TIMER,__LC_EXIT_TIMER,__LC_SYSTEM_TIMER
+sysc_update:
+	mvc	__LC_LAST_UPDATE_TIMER(8),__LC_SYNC_ENTER_TIMER
+#endif
 sysc_do_svc:
 	l	%r9,__LC_THREAD_INFO	# load pointer to thread_info struct
 	sla	%r7,2             # *4 and test for svc 0
@@ -389,10 +423,19 @@
  * we just ignore the PER event (FIXME: is there anything we have to do
  * for LPSW?).
  */
+	STORE_TIMER __LC_SYNC_ENTER_TIMER
 	SAVE_ALL_BASE __LC_SAVE_AREA
         tm      __LC_PGM_INT_CODE+1,0x80 # check whether we got a per exception
         bnz     BASED(pgm_per)           # got per exception -> special case
 	SAVE_ALL __LC_PGM_OLD_PSW,__LC_SAVE_AREA,1
+#ifdef CONFIG_VIRT_CPU_ACCOUNTING
+	tm	SP_PSW+1(%r15),0x01	# interrupting from user ?
+	bz	BASED(pgm_no_vtime)
+	UPDATE_VTIME __LC_EXIT_TIMER,__LC_SYNC_ENTER_TIMER,__LC_USER_TIMER
+	UPDATE_VTIME __LC_LAST_UPDATE_TIMER,__LC_EXIT_TIMER,__LC_SYSTEM_TIMER
+	mvc	__LC_LAST_UPDATE_TIMER(8),__LC_SYNC_ENTER_TIMER
+pgm_no_vtime:
+#endif
 	l	%r9,__LC_THREAD_INFO	# load pointer to thread_info struct
         l       %r3,__LC_PGM_ILC         # load program interruption code
 	la	%r8,0x7f
@@ -423,6 +466,14 @@
 #
 pgm_per_std:
 	SAVE_ALL __LC_PGM_OLD_PSW,__LC_SAVE_AREA,1
+#ifdef CONFIG_VIRT_CPU_ACCOUNTING
+	tm	SP_PSW+1(%r15),0x01	# interrupting from user ?
+	bz	BASED(pgm_no_vtime2)
+	UPDATE_VTIME __LC_EXIT_TIMER,__LC_SYNC_ENTER_TIMER,__LC_USER_TIMER
+	UPDATE_VTIME __LC_LAST_UPDATE_TIMER,__LC_EXIT_TIMER,__LC_SYSTEM_TIMER
+	mvc	__LC_LAST_UPDATE_TIMER(8),__LC_SYNC_ENTER_TIMER
+pgm_no_vtime2:
+#endif
 	l	%r9,__LC_THREAD_INFO	# load pointer to thread_info struct
 	l	%r1,__TI_task(%r9)
 	mvc	__THREAD_per+__PER_atmid(2,%r1),__LC_PER_ATMID
@@ -440,6 +491,14 @@
 #
 pgm_svcper:
 	SAVE_ALL __LC_SVC_OLD_PSW,__LC_SAVE_AREA,1
+#ifdef CONFIG_VIRT_CPU_ACCOUNTING
+	tm	SP_PSW+1(%r15),0x01	# interrupting from user ?
+	bz	BASED(pgm_no_vtime3)
+	UPDATE_VTIME __LC_EXIT_TIMER,__LC_SYNC_ENTER_TIMER,__LC_USER_TIMER
+	UPDATE_VTIME __LC_LAST_UPDATE_TIMER,__LC_EXIT_TIMER,__LC_SYSTEM_TIMER
+	mvc	__LC_LAST_UPDATE_TIMER(8),__LC_SYNC_ENTER_TIMER
+pgm_no_vtime3:
+#endif
 	lh	%r7,0x8a		# get svc number from lowcore
 	l	%r9,__LC_THREAD_INFO	# load pointer to thread_info struct
 	l	%r1,__TI_task(%r9)
@@ -456,9 +515,18 @@
 
         .globl io_int_handler
 io_int_handler:
+	STORE_TIMER __LC_ASYNC_ENTER_TIMER
 	stck	__LC_INT_CLOCK
 	SAVE_ALL_BASE __LC_SAVE_AREA+16
         SAVE_ALL __LC_IO_OLD_PSW,__LC_SAVE_AREA+16,0
+#ifdef CONFIG_VIRT_CPU_ACCOUNTING
+	tm	SP_PSW+1(%r15),0x01	# interrupting from user ?
+	bz	BASED(io_no_vtime)
+	UPDATE_VTIME __LC_EXIT_TIMER,__LC_ASYNC_ENTER_TIMER,__LC_USER_TIMER
+	UPDATE_VTIME __LC_LAST_UPDATE_TIMER,__LC_EXIT_TIMER,__LC_SYSTEM_TIMER
+	mvc	__LC_LAST_UPDATE_TIMER(8),__LC_ASYNC_ENTER_TIMER
+io_no_vtime:
+#endif
 	l	%r9,__LC_THREAD_INFO	# load pointer to thread_info struct
         l       %r1,BASED(.Ldo_IRQ)        # load address of do_IRQ
         la      %r2,SP_PTREGS(%r15) # address of register-save area
@@ -547,9 +615,18 @@
 
         .globl  ext_int_handler
 ext_int_handler:
+	STORE_TIMER __LC_ASYNC_ENTER_TIMER
 	stck	__LC_INT_CLOCK
 	SAVE_ALL_BASE __LC_SAVE_AREA+16
         SAVE_ALL __LC_EXT_OLD_PSW,__LC_SAVE_AREA+16,0
+#ifdef CONFIG_VIRT_CPU_ACCOUNTING
+	tm	SP_PSW+1(%r15),0x01	# interrupting from user ?
+	bz	BASED(ext_no_vtime)
+	UPDATE_VTIME __LC_EXIT_TIMER,__LC_ASYNC_ENTER_TIMER,__LC_USER_TIMER
+	UPDATE_VTIME __LC_LAST_UPDATE_TIMER,__LC_EXIT_TIMER,__LC_SYSTEM_TIMER
+	mvc	__LC_LAST_UPDATE_TIMER(8),__LC_ASYNC_ENTER_TIMER
+ext_no_vtime:
+#endif
 	l	%r9,__LC_THREAD_INFO	# load pointer to thread_info struct
 	la	%r2,SP_PTREGS(%r15)    # address of register-save area
 	lh	%r3,__LC_EXT_INT_CODE  # get interruption code
@@ -563,8 +640,17 @@
 
         .globl mcck_int_handler
 mcck_int_handler:
+	STORE_TIMER __LC_ASYNC_ENTER_TIMER
 	SAVE_ALL_BASE __LC_SAVE_AREA+32
         SAVE_ALL __LC_MCK_OLD_PSW,__LC_SAVE_AREA+32,0
+#ifdef CONFIG_VIRT_CPU_ACCOUNTING
+	tm	SP_PSW+1(%r15),0x01	# interrupting from user ?
+	bz	BASED(mcck_no_vtime)
+	UPDATE_VTIME __LC_EXIT_TIMER,__LC_ASYNC_ENTER_TIMER,__LC_USER_TIMER
+	UPDATE_VTIME __LC_LAST_UPDATE_TIMER,__LC_EXIT_TIMER,__LC_SYSTEM_TIMER
+	mvc	__LC_LAST_UPDATE_TIMER(8),__LC_ASYNC_ENTER_TIMER
+mcck_no_vtime:
+#endif
 	l       %r1,BASED(.Ls390_mcck)
 	basr    %r14,%r1	  # call machine check handler
 mcck_return:
@@ -659,17 +745,47 @@
 	br	%r14
 
 cleanup_system_call:
-	mvc	__LC_RETURN_PSW(4),0(%r12)
-	clc	4(4,%r12),BASED(cleanup_table_system_call)
-	bne	BASED(0f)
+	mvc	__LC_RETURN_PSW(8),0(%r12)
+#ifdef CONFIG_VIRT_CPU_ACCOUNTING
+	clc	__LC_RETURN_PSW+4(4),BASED(cleanup_system_call_insn+4)
+	bh	BASED(0f)
+	mvc	__LC_SYNC_ENTER_TIMER(8),__LC_ASYNC_ENTER_TIMER
+0:	clc	__LC_RETURN_PSW+4(4),BASED(cleanup_system_call_insn+8)
+	bhe	BASED(cleanup_vtime)
+#endif
+	clc	__LC_RETURN_PSW+4(4),BASED(cleanup_system_call_insn)
+	bh	BASED(0f)
 	mvc	__LC_SAVE_AREA(16),__LC_SAVE_AREA+16
 0:	st	%r13,__LC_SAVE_AREA+20
 	SAVE_ALL __LC_SVC_OLD_PSW,__LC_SAVE_AREA,1
 	st	%r15,__LC_SAVE_AREA+28
 	lh	%r7,0x8a
+#ifdef CONFIG_VIRT_CPU_ACCOUNTING
+cleanup_vtime:
+	clc	__LC_RETURN_PSW+4(4),BASED(cleanup_system_call_insn+12)
+	bhe	BASED(cleanup_stime)
+	tm	SP_PSW+1(%r15),0x01	# interrupting from user ?
+	bz	BASED(cleanup_novtime)
+	UPDATE_VTIME __LC_EXIT_TIMER,__LC_SYNC_ENTER_TIMER,__LC_USER_TIMER
+cleanup_stime:
+	clc	__LC_RETURN_PSW+4(4),BASED(cleanup_system_call_insn+16)
+	bh	BASED(cleanup_update)
+	UPDATE_VTIME __LC_LAST_UPDATE_TIMER,__LC_EXIT_TIMER,__LC_SYSTEM_TIMER
+cleanup_update:
+	mvc	__LC_LAST_UPDATE_TIMER(8),__LC_SYNC_ENTER_TIMER
+cleanup_novtime:
+#endif
 	mvc	__LC_RETURN_PSW+4(4),BASED(cleanup_table_system_call+4)
 	la	%r12,__LC_RETURN_PSW
 	br	%r14
+cleanup_system_call_insn:
+	.long	sysc_saveall + 0x80000000
+#ifdef CONFIG_VIRT_CPU_ACCOUNTING
+	.long   system_call + 0x80000000
+	.long   sysc_vtime + 0x80000000
+	.long   sysc_stime + 0x80000000
+	.long   sysc_update + 0x80000000
+#endif
 
 cleanup_sysc_return:
 	mvc	__LC_RETURN_PSW(4),0(%r12)
@@ -678,15 +794,23 @@
 	br	%r14
 
 cleanup_sysc_leave:
-	clc	4(4,%r12),BASED(cleanup_sysc_leave_lpsw)
+	clc	4(4,%r12),BASED(cleanup_sysc_leave_insn)
+	be	BASED(0f)
+#ifdef CONFIG_VIRT_CPU_ACCOUNTING
+	mvc	__LC_EXIT_TIMER(8),__LC_ASYNC_ENTER_TIMER
+	clc	4(4,%r12),BASED(cleanup_sysc_leave_insn+4)
 	be	BASED(0f)
+#endif
 	mvc	__LC_RETURN_PSW(8),SP_PSW(%r15)
 	mvc	__LC_SAVE_AREA+16(16),SP_R12(%r15)
 	lm	%r0,%r11,SP_R0(%r15)
 	l	%r15,SP_R15(%r15)
 0:	la	%r12,__LC_RETURN_PSW
 	br	%r14
-cleanup_sysc_leave_lpsw:
+cleanup_sysc_leave_insn:
+#ifdef CONFIG_VIRT_CPU_ACCOUNTING
+	.long	sysc_leave + 14 + 0x80000000
+#endif
 	.long	sysc_leave + 10 + 0x80000000
 
 /*
@@ -702,6 +826,7 @@
 .L0x028:       .short 0x028
 .L0x030:       .short 0x030
 .L0x038:       .short 0x038
+.Lc_1:         .long  1
 
 /*
  * Symbol constants
diff -urN linux-2.6/arch/s390/kernel/irq.c linux-2.6-cputime/arch/s390/kernel/irq.c
--- linux-2.6/arch/s390/kernel/irq.c	2004-11-11 15:37:16.000000000 +0100
+++ linux-2.6-cputime/arch/s390/kernel/irq.c	2004-11-11 15:37:44.000000000 +0100
@@ -71,6 +71,10 @@
 
 	local_irq_save(flags);
 
+	account_system_vtime(current);
+
+	local_bh_disable();
+
 	if (local_softirq_pending()) {
 		/* Get current stack pointer. */
 		asm volatile("la %0,0(15)" : "=a" (old));
@@ -93,6 +97,10 @@
 			__do_softirq();
 	}
 
+	account_system_vtime(current);
+
+	__local_bh_enable();
+
 	local_irq_restore(flags);
 }
 
diff -urN linux-2.6/arch/s390/kernel/time.c linux-2.6-cputime/arch/s390/kernel/time.c
--- linux-2.6/arch/s390/kernel/time.c	2004-11-11 15:37:16.000000000 +0100
+++ linux-2.6-cputime/arch/s390/kernel/time.c	2004-11-11 15:37:44.000000000 +0100
@@ -150,28 +150,6 @@
 
 EXPORT_SYMBOL(do_settimeofday);
 
-#ifndef CONFIG_ARCH_S390X
-
-static inline __u32
-__calculate_ticks(__u64 elapsed)
-{
-	register_pair rp;
-
-	rp.pair = elapsed >> 1;
-	asm ("dr %0,%1" : "+d" (rp) : "d" (CLK_TICKS_PER_JIFFY >> 1));
-	return rp.subreg.odd;
-}
-
-#else /* CONFIG_ARCH_S390X */
-
-static inline __u32
-__calculate_ticks(__u64 elapsed)
-{
-	return elapsed / CLK_TICKS_PER_JIFFY;
-}
-
-#endif /* CONFIG_ARCH_S390X */
-
 
 #ifdef CONFIG_PROFILING
 #define s390_do_profile(regs)	profile_tick(CPU_PROFILING, regs)
@@ -187,14 +165,14 @@
 void account_ticks(struct pt_regs *regs)
 {
 	__u64 tmp;
-	__u32 ticks;
+	__u32 ticks, xticks;
 
 	/* Calculate how many ticks have passed. */
 	if (S390_lowcore.int_clock < S390_lowcore.jiffy_timer)
 		return;
 	tmp = S390_lowcore.int_clock - S390_lowcore.jiffy_timer;
 	if (tmp >= 2*CLK_TICKS_PER_JIFFY) {  /* more than two ticks ? */
-		ticks = __calculate_ticks(tmp) + 1;
+		ticks = __div(tmp, CLK_TICKS_PER_JIFFY) + 1;
 		S390_lowcore.jiffy_timer +=
 			CLK_TICKS_PER_JIFFY * (__u64) ticks;
 	} else if (tmp >= CLK_TICKS_PER_JIFFY) {
@@ -216,11 +194,9 @@
 	 */
 	write_seqlock(&xtime_lock);
 	if (S390_lowcore.jiffy_timer > xtime_cc) {
-		__u32 xticks;
-
 		tmp = S390_lowcore.jiffy_timer - xtime_cc;
 		if (tmp >= 2*CLK_TICKS_PER_JIFFY) {
-			xticks = __calculate_ticks(tmp);
+			xticks = __div(tmp, CLK_TICKS_PER_JIFFY);
 			xtime_cc += (__u64) xticks * CLK_TICKS_PER_JIFFY;
 		} else {
 			xticks = 1;
@@ -230,14 +206,18 @@
 			do_timer(regs);
 	}
 	write_sequnlock(&xtime_lock);
-	while (ticks--)
-		update_process_times(user_mode(regs));
 #else
-	while (ticks--) {
+	for (xticks = ticks; xticks > 0; xticks--)
 		do_timer(regs);
+#endif
+
+#ifdef CONFIG_VIRT_CPU_ACCOUNTING
+	account_user_vtime(current);
+#else
+	while (ticks--)
 		update_process_times(user_mode(regs));
-	}
 #endif
+
 	s390_do_profile(regs);
 }
 
diff -urN linux-2.6/arch/s390/kernel/vtime.c linux-2.6-cputime/arch/s390/kernel/vtime.c
--- linux-2.6/arch/s390/kernel/vtime.c	2004-11-11 15:37:16.000000000 +0100
+++ linux-2.6-cputime/arch/s390/kernel/vtime.c	2004-11-11 15:37:44.000000000 +0100
@@ -17,6 +17,8 @@
 #include <linux/types.h>
 #include <linux/timex.h>
 #include <linux/notifier.h>
+#include <linux/kernel_stat.h>
+#include <linux/rcupdate.h>
 
 #include <asm/s390_ext.h>
 #include <asm/timer.h>
@@ -25,7 +27,95 @@
 static ext_int_info_t ext_int_info_timer;
 DEFINE_PER_CPU(struct vtimer_queue, virt_cpu_timer);
 
-void start_cpu_timer(void)
+#ifdef CONFIG_VIRT_CPU_ACCOUNTING
+/*
+ * Update process times based on virtual cpu times stored by entry.S
+ * to the lowcore fields user_timer, system_timer & steal_clock.
+ */
+void account_user_vtime(struct task_struct *tsk)
+{
+	cputime_t cputime;
+	__u64 timer, clock;
+	int rcu_user_flag;
+
+	timer = S390_lowcore.last_update_timer;
+	clock = S390_lowcore.last_update_clock;
+	asm volatile ("  STPT %0\n"    /* Store current cpu timer value */
+		      "  STCK %1"      /* Store current tod clock value */
+		      : "=m" (S390_lowcore.last_update_timer),
+		        "=m" (S390_lowcore.last_update_clock) );
+	S390_lowcore.system_timer += timer - S390_lowcore.last_update_timer;
+	S390_lowcore.steal_clock += S390_lowcore.last_update_clock - clock;
+
+	cputime = S390_lowcore.user_timer >> 12;
+	rcu_user_flag = cputime != 0;
+	S390_lowcore.user_timer -= cputime << 12;
+	S390_lowcore.steal_clock -= cputime << 12;
+	account_user_time(tsk, cputime);
+
+	cputime =  S390_lowcore.system_timer >> 12;
+	S390_lowcore.system_timer -= cputime << 12;
+	S390_lowcore.steal_clock -= cputime << 12;
+	account_system_time(tsk, HARDIRQ_OFFSET, cputime);
+
+	cputime = S390_lowcore.steal_clock;
+	if ((__s64) cputime > 0) {
+		cputime >>= 12;
+		S390_lowcore.steal_clock -= cputime << 12;
+		account_steal_time(tsk, cputime);
+	}
+
+	run_local_timers();
+	if (rcu_pending(smp_processor_id()))
+		rcu_check_callbacks(smp_processor_id(), rcu_user_flag);
+	scheduler_tick();
+}
+
+/*
+ * Update process times based on virtual cpu times stored by entry.S
+ * to the lowcore fields user_timer, system_timer & steal_clock.
+ */
+void account_system_vtime(struct task_struct *tsk)
+{
+	cputime_t cputime;
+	__u64 timer;
+
+	timer = S390_lowcore.last_update_timer;
+	asm volatile ("  STPT %0"    /* Store current cpu timer value */
+		      : "=m" (S390_lowcore.last_update_timer) );
+	S390_lowcore.system_timer += timer - S390_lowcore.last_update_timer;
+
+	cputime =  S390_lowcore.system_timer >> 12;
+	S390_lowcore.system_timer -= cputime << 12;
+	S390_lowcore.steal_clock -= cputime << 12;
+	account_system_time(tsk, 0, cputime);
+}
+
+static inline void set_vtimer(__u64 expires)
+{
+	__u64 timer;
+
+	asm volatile ("  STPT %0\n"  /* Store current cpu timer value */
+		      "  SPT %1"     /* Set new value immediatly afterwards */
+		      : "=m" (timer) : "m" (expires) );
+	S390_lowcore.system_timer += S390_lowcore.last_update_timer - timer;
+	S390_lowcore.last_update_timer = expires;
+
+	/* store expire time for this CPU timer */
+	per_cpu(virt_cpu_timer, smp_processor_id()).to_expire = expires;
+}
+#else
+static inline void set_vtimer(__u64 expires)
+{
+	S390_lowcore.last_update_timer = expires;
+	asm volatile ("SPT %0" : : "m" (S390_lowcore.last_update_timer));
+
+	/* store expire time for this CPU timer */
+	per_cpu(virt_cpu_timer, smp_processor_id()).to_expire = expires;
+}
+#endif
+
+static void start_cpu_timer(void)
 {
 	struct vtimer_queue *vt_list;
 
@@ -33,7 +123,7 @@
 	set_vtimer(vt_list->idle);
 }
 
-void stop_cpu_timer(void)
+static void stop_cpu_timer(void)
 {
 	__u64 done;
 	struct vtimer_queue *vt_list;
@@ -71,19 +161,11 @@
 	set_vtimer(VTIMER_MAX_SLICE);
 }
 
-void set_vtimer(__u64 expires)
-{
-	asm volatile ("SPT %0" : : "m" (expires));
-
-	/* store expire time for this CPU timer */
-	per_cpu(virt_cpu_timer, smp_processor_id()).to_expire = expires;
-}
-
 /*
  * Sorted add to a list. List is linear searched until first bigger
  * element is found.
  */
-void list_add_sorted(struct vtimer_list *timer, struct list_head *head)
+static void list_add_sorted(struct vtimer_list *timer, struct list_head *head)
 {
 	struct vtimer_list *event;
 
@@ -429,11 +511,12 @@
 {
 	struct vtimer_queue *vt_list;
 	unsigned long cr0;
-	__u64 timer;
 
 	/* kick the virtual timer */
-	timer = VTIMER_MAX_SLICE;
-	asm volatile ("SPT %0" : : "m" (timer));
+	S390_lowcore.exit_timer = VTIMER_MAX_SLICE;
+	S390_lowcore.last_update_timer = VTIMER_MAX_SLICE;
+	asm volatile ("SPT %0" : : "m" (S390_lowcore.last_update_timer));
+	asm volatile ("STCK %0" : "=m" (S390_lowcore.last_update_clock));
 	__ctl_store(cr0, 0, 0);
 	cr0 |= 0x400;
 	__ctl_load(cr0, 0, 0);
diff -urN linux-2.6/include/asm-s390/cputime.h linux-2.6-cputime/include/asm-s390/cputime.h
--- linux-2.6/include/asm-s390/cputime.h	2004-11-11 15:37:16.000000000 +0100
+++ linux-2.6-cputime/include/asm-s390/cputime.h	2004-11-11 15:37:44.000000000 +0100
@@ -1,6 +1,168 @@
-#ifndef __S390_CPUTIME_H
-#define __S390_CPUTIME_H
+/*
+ *  include/asm-s390/cputime.h
+ *
+ *  (C) Copyright IBM Corp. 2004
+ *
+ *  Author: Martin Schwidefsky <schwidefsky@de.ibm.com>
+ */
 
-#include <asm-generic/cputime.h>
+#ifndef _S390_CPUTIME_H
+#define _S390_CPUTIME_H
 
-#endif /* __S390_CPUTIME_H */
+/* We want to use micro-second resolution. */
+
+typedef unsigned long long cputime_t;
+typedef unsigned long long cputime64_t;
+
+#ifndef __s390x__
+
+static inline unsigned int
+__div(unsigned long long n, unsigned int base)
+{
+	register_pair rp;
+
+	rp.pair = n >> 1;
+	asm ("dr %0,%1" : "+d" (rp) : "d" (base >> 1));
+	return rp.subreg.odd;
+}
+
+#else /* __s390x__ */
+
+static inline unsigned int
+__div(unsigned long long n, unsigned int base)
+{
+	return n / base;
+}
+
+#endif /* __s390x__ */
+
+#define cputime_zero			(0ULL)
+#define cputime_max			((~0UL >> 1) - 1)
+#define cputime_add(__a, __b)		((__a) +  (__b))
+#define cputime_sub(__a, __b)		((__a) -  (__b))
+#define cputime_eq(__a, __b)		((__a) == (__b))
+#define cputime_gt(__a, __b)		((__a) >  (__b))
+#define cputime_ge(__a, __b)		((__a) >= (__b))
+#define cputime_lt(__a, __b)		((__a) <  (__b))
+#define cputime_le(__a, __b)		((__a) <= (__b))
+#define cputime_to_jiffies(__ct)	(__div((__ct), 1000000 / HZ))
+#define jiffies_to_cputime(__hz)	((cputime_t)(__hz) * (1000000 / HZ))
+
+#define cputime64_zero			(0ULL)
+#define cputime64_add(__a, __b)		((__a) + (__b))
+#define cputime_to_cputime64(__ct)	(__ct)
+
+static inline u64
+cputime64_to_jiffies64(cputime64_t cputime)
+{
+	do_div(cputime, 1000000 / HZ);
+	return cputime;
+}
+
+/*
+ * Convert cputime to milliseconds and back.
+ */
+static inline unsigned int
+cputime_to_msecs(const cputime_t cputime)
+{
+	return __div(cputime, 1000);
+}
+
+static inline cputime_t
+msecs_to_cputime(const unsigned int m)
+{
+	return (cputime_t) m * 1000;
+}
+
+/*
+ * Convert cputime to milliseconds and back.
+ */
+static inline unsigned int
+cputime_to_secs(const cputime_t cputime)
+{
+	return __div(cputime, 1000000);
+}
+
+static inline cputime_t
+secs_to_cputime(const unsigned int s)
+{
+	return (cputime_t) s * 1000000;
+}
+
+/*
+ * Convert cputime to timespec and back.
+ */
+static inline cputime_t
+timespec_to_cputime(const struct timespec *value)
+{
+        return value->tv_nsec / 1000 + (u64) value->tv_sec * 1000000;
+}
+
+static inline void
+cputime_to_timespec(const cputime_t cputime, struct timespec *value)
+{
+#ifndef __s390x__
+	register_pair rp;
+
+	rp.pair = cputime >> 1;
+	asm ("dr %0,%1" : "+d" (rp) : "d" (1000000 >> 1));
+	value->tv_nsec = rp.subreg.even * 1000;
+	value->tv_sec = rp.subreg.odd;
+#else
+	value->tv_nsec = (cputime % 1000000) * 1000;
+	value->tv_sec = cputime / 1000000;
+#endif
+}
+
+/*
+ * Convert cputime to timeval and back.
+ * Since cputime and timeval have the same resolution (microseconds)
+ * this is easy.
+ */
+static inline cputime_t
+timeval_to_cputime(const struct timeval *value)
+{
+        return value->tv_usec + (u64) value->tv_sec * 1000000;
+}
+
+static inline void
+cputime_to_timeval(const cputime_t cputime, struct timeval *value)
+{
+#ifndef __s390x__
+	register_pair rp;
+
+	rp.pair = cputime >> 1;
+	asm ("dr %0,%1" : "+d" (rp) : "d" (1000000 >> 1));
+	value->tv_usec = rp.subreg.even;
+	value->tv_sec = rp.subreg.odd;
+#else
+	value->tv_usec = cputime % 1000000;
+	value->tv_sec = cputime / 1000000;
+#endif
+}
+
+/*
+ * Convert cputime to clock and back.
+ */
+static inline clock_t
+cputime_to_clock_t(cputime_t cputime)
+{
+	return __div(cputime, 1000000 / USER_HZ);
+}
+
+static inline cputime_t
+clock_t_to_cputime(unsigned long x)
+{
+	return (cputime_t) x * (1000000 / USER_HZ);
+}
+
+/*
+ * Convert cputime64 to clock.
+ */
+static inline clock_t
+cputime64_to_clock_t(cputime64_t cputime)
+{
+       return __div(cputime, 1000000 / USER_HZ);
+}
+
+#endif /* _S390_CPUTIME_H */
diff -urN linux-2.6/include/asm-s390/hardirq.h linux-2.6-cputime/include/asm-s390/hardirq.h
--- linux-2.6/include/asm-s390/hardirq.h	2004-11-11 15:37:16.000000000 +0100
+++ linux-2.6-cputime/include/asm-s390/hardirq.h	2004-11-11 15:37:44.000000000 +0100
@@ -16,6 +16,7 @@
 #include <linux/threads.h>
 #include <linux/sched.h>
 #include <linux/cache.h>
+#include <linux/interrupt.h>
 #include <asm/lowcore.h>
 
 /* irq_cpustat_t is unused currently, but could be converted
@@ -46,10 +47,12 @@
 
 #define irq_enter()							\
 do {									\
+	account_system_vtime(current);					\
 	(preempt_count() += HARDIRQ_OFFSET);				\
 } while(0)
 #define irq_exit()							\
 do {									\
+	account_system_vtime(current);					\
 	preempt_count() -= IRQ_EXIT_OFFSET;				\
 	if (!in_interrupt() && local_softirq_pending())			\
 		/* Use the async. stack for softirq */			\
diff -urN linux-2.6/include/asm-s390/lowcore.h linux-2.6-cputime/include/asm-s390/lowcore.h
--- linux-2.6/include/asm-s390/lowcore.h	2004-11-11 15:37:16.000000000 +0100
+++ linux-2.6-cputime/include/asm-s390/lowcore.h	2004-11-11 15:37:44.000000000 +0100
@@ -56,13 +56,18 @@
 
 #define __LC_RETURN_PSW                 0x200
 
-#define __LC_IRB			0x210
-
-#define __LC_DIAG44_OPCODE		0x250
-
 #define __LC_SAVE_AREA                  0xC00
 
 #ifndef __s390x__
+#define __LC_IRB			0x208
+#define __LC_SYNC_ENTER_TIMER		0x248
+#define __LC_ASYNC_ENTER_TIMER		0x250
+#define __LC_EXIT_TIMER			0x258
+#define __LC_LAST_UPDATE_TIMER		0x260
+#define __LC_USER_TIMER			0x268
+#define __LC_SYSTEM_TIMER		0x270
+#define __LC_LAST_UPDATE_CLOCK		0x278
+#define __LC_STEAL_CLOCK		0x280
 #define __LC_KERNEL_STACK               0xC40
 #define __LC_THREAD_INFO		0xC44
 #define __LC_ASYNC_STACK                0xC48
@@ -76,6 +81,16 @@
 #define __LC_CURRENT			0xC90
 #define __LC_INT_CLOCK			0xC98
 #else /* __s390x__ */
+#define __LC_IRB			0x210
+#define __LC_SYNC_ENTER_TIMER		0x250
+#define __LC_ASYNC_ENTER_TIMER		0x258
+#define __LC_EXIT_TIMER			0x260
+#define __LC_LAST_UPDATE_TIMER		0x268
+#define __LC_USER_TIMER			0x270
+#define __LC_SYSTEM_TIMER		0x278
+#define __LC_LAST_UPDATE_CLOCK		0x280
+#define __LC_STEAL_CLOCK		0x288
+#define __LC_DIAG44_OPCODE		0x290
 #define __LC_KERNEL_STACK               0xD40
 #define __LC_THREAD_INFO		0xD48
 #define __LC_ASYNC_STACK                0xD50
@@ -87,7 +102,7 @@
 #define __LC_IPLDEV                     0xDB8
 #define __LC_JIFFY_TIMER		0xDC0
 #define __LC_CURRENT			0xDD8
-#define __LC_INT_CLOCK			0xDe8
+#define __LC_INT_CLOCK			0xDE8
 #endif /* __s390x__ */
 
 #define __LC_PANIC_MAGIC                0xE00
@@ -169,7 +184,15 @@
 
         psw_t        return_psw;               /* 0x200 */
 	__u8	     irb[64];		       /* 0x208 */
-	__u8         pad8[0xc00-0x248];        /* 0x248 */
+	__u64        sync_enter_timer;         /* 0x248 */
+	__u64        async_enter_timer;        /* 0x250 */
+	__u64        exit_timer;               /* 0x258 */
+	__u64        last_update_timer;        /* 0x260 */
+	__u64        user_timer;               /* 0x268 */
+	__u64        system_timer;             /* 0x270 */
+	__u64        last_update_clock;        /* 0x278 */
+	__u64        steal_clock;              /* 0x280 */
+	__u8         pad8[0xc00-0x288];        /* 0x288 */
 
         /* System info area */
 	__u32        save_area[16];            /* 0xc00 */
@@ -250,8 +273,16 @@
 	psw_t        io_new_psw;               /* 0x1f0 */
         psw_t        return_psw;               /* 0x200 */
 	__u8	     irb[64];		       /* 0x210 */
-	__u32        diag44_opcode;            /* 0x250 */
-        __u8         pad8[0xc00-0x254];        /* 0x254 */
+	__u64        sync_enter_timer;         /* 0x250 */
+	__u64        async_enter_timer;        /* 0x258 */
+	__u64        exit_timer;               /* 0x260 */
+	__u64        last_update_timer;        /* 0x268 */
+	__u64        user_timer;               /* 0x270 */
+	__u64        system_timer;             /* 0x278 */
+	__u64        last_update_clock;        /* 0x280 */
+	__u64        steal_clock;              /* 0x288 */
+	__u32        diag44_opcode;            /* 0x290 */
+        __u8         pad8[0xc00-0x294];        /* 0x294 */
         /* System info area */
 	__u64        save_area[16];            /* 0xc00 */
         __u8         pad9[0xd40-0xc80];        /* 0xc80 */
diff -urN linux-2.6/include/asm-s390/system.h linux-2.6-cputime/include/asm-s390/system.h
--- linux-2.6/include/asm-s390/system.h	2004-11-11 15:37:16.000000000 +0100
+++ linux-2.6-cputime/include/asm-s390/system.h	2004-11-11 15:37:44.000000000 +0100
@@ -105,11 +105,29 @@
 
 #define prepare_arch_switch(rq, next)	do { } while(0)
 #define task_running(rq, p)		((rq)->curr == (p))
+
+#ifdef CONFIG_VIRT_CPU_ACCOUNTING
+extern void account_user_vtime(struct task_struct *);
+extern void account_system_vtime(struct task_struct *);
+
+#define finish_arch_switch(rq, prev) do {				     \
+	set_fs(current->thread.mm_segment);				     \
+	spin_unlock(&(rq)->lock);					     \
+	account_system_vtime(prev);					     \
+	local_irq_enable();						     \
+} while (0)
+
+#else
+
+#define account_system_vtime(prev)
+
 #define finish_arch_switch(rq, prev) do {				     \
 	set_fs(current->thread.mm_segment);				     \
 	spin_unlock_irq(&(rq)->lock);					     \
 } while (0)
 
+#endif
+
 #define nop() __asm__ __volatile__ ("nop")
 
 #define xchg(ptr,x) \
diff -urN linux-2.6/include/asm-s390/timer.h linux-2.6-cputime/include/asm-s390/timer.h
--- linux-2.6/include/asm-s390/timer.h	2004-11-11 15:37:16.000000000 +0100
+++ linux-2.6-cputime/include/asm-s390/timer.h	2004-11-11 15:37:44.000000000 +0100
@@ -37,8 +37,6 @@
 	__u64 idle;		  /* temp var for idle */
 };
 
-void set_vtimer(__u64 expires);
-
 extern void init_virt_timer(struct vtimer_list *timer);
 extern void add_virt_timer(void *new);
 extern void add_virt_timer_periodic(void *new);
