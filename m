Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262285AbUCAIvq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Mar 2004 03:51:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262287AbUCAIvq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Mar 2004 03:51:46 -0500
Received: from mtagate5.de.ibm.com ([195.212.29.154]:56549 "EHLO
	mtagate5.de.ibm.com") by vger.kernel.org with ESMTP id S262285AbUCAIv2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Mar 2004 03:51:28 -0500
Date: Mon, 1 Mar 2004 09:51:17 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] s390 (1/5): core s390.
Message-ID: <20040301085117.GB675@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

s390 bug fixes:
  - Add missing i/o controls to compat ioctl translation table.
  - Fix some gcc 3.4 warnings.
  - Export _sb_findmap.
  - Export smp_call_function_on only if CONFIG_SMP=y.
  - Add safe-guard to diag10.
  - Add type definition for compat_timer_t.
  - Fix first argument of signal_processor_ps.

diffstat:
 arch/s390/kernel/compat_ioctl.c  |    9 +++++++++
 arch/s390/kernel/compat_linux.c  |    3 +--
 arch/s390/kernel/compat_ptrace.h |   17 +++++++----------
 arch/s390/kernel/s390_ksyms.c    |    2 +-
 arch/s390/kernel/smp.c           |    7 ++++---
 arch/s390/kernel/traps.c         |    2 --
 arch/s390/mm/cmm.c               |    3 +--
 arch/s390/mm/init.c              |    4 ++--
 include/asm-s390/compat.h        |    1 +
 include/asm-s390/sigp.h          |    2 +-
 10 files changed, 27 insertions(+), 23 deletions(-)

diff -urN linux-2.6/arch/s390/kernel/compat_ioctl.c linux-2.6-s390/arch/s390/kernel/compat_ioctl.c
--- linux-2.6/arch/s390/kernel/compat_ioctl.c	Wed Feb 18 04:58:39 2004
+++ linux-2.6-s390/arch/s390/kernel/compat_ioctl.c	Fri Feb 27 20:04:59 2004
@@ -49,7 +49,16 @@
 COMPATIBLE_IOCTL(BIODASDRLSE)
 COMPATIBLE_IOCTL(BIODASDSLCK)
 COMPATIBLE_IOCTL(BIODASDINFO)
+COMPATIBLE_IOCTL(BIODASDINFO2)
 COMPATIBLE_IOCTL(BIODASDFMT)
+COMPATIBLE_IOCTL(BIODASDPRRST)
+COMPATIBLE_IOCTL(BIODASDQUIESCE)
+COMPATIBLE_IOCTL(BIODASDRESUME)
+COMPATIBLE_IOCTL(BIODASDPRRD)
+COMPATIBLE_IOCTL(BIODASDPSRD)
+COMPATIBLE_IOCTL(BIODASDGATTR)
+COMPATIBLE_IOCTL(BIODASDSATTR)
+
 #endif
 
 #if defined(CONFIG_S390_TAPE) || defined(CONFIG_S390_TAPE_MODULE)
diff -urN linux-2.6/arch/s390/kernel/compat_linux.c linux-2.6-s390/arch/s390/kernel/compat_linux.c
--- linux-2.6/arch/s390/kernel/compat_linux.c	Fri Feb 27 20:04:31 2004
+++ linux-2.6-s390/arch/s390/kernel/compat_linux.c	Fri Feb 27 20:04:59 2004
@@ -1161,8 +1161,7 @@
 	put_user(reclen, &dirent->d_reclen);
 	copy_to_user(dirent->d_name, name, namlen);
 	put_user(0, dirent->d_name + namlen);
-	((char *) dirent) += reclen;
-	buf->current_dir = dirent;
+	buf->current_dir = ((void *)dirent) + reclen;
 	buf->count -= reclen;
 	return 0;
 }
diff -urN linux-2.6/arch/s390/kernel/compat_ptrace.h linux-2.6-s390/arch/s390/kernel/compat_ptrace.h
--- linux-2.6/arch/s390/kernel/compat_ptrace.h	Wed Feb 18 04:57:25 2004
+++ linux-2.6-s390/arch/s390/kernel/compat_ptrace.h	Fri Feb 27 20:04:59 2004
@@ -3,23 +3,20 @@
 
 #include "compat_linux.h"  /* needed for _psw_t32 */
 
-typedef struct
-{
+typedef struct {
 	__u32 cr[3];
-} per_cr_words32  __attribute__((packed));
+} per_cr_words32;
 
-typedef struct
-{
+typedef struct {
 	__u16          perc_atmid;          /* 0x096 */
 	__u32          address;             /* 0x098 */
 	__u8           access_id;           /* 0x0a1 */
-} per_lowcore_words32  __attribute__((packed));
+} per_lowcore_words32;
 
-typedef struct
-{
+typedef struct {
 	union {
 		per_cr_words32   words;
-	} control_regs  __attribute__((packed));
+	} control_regs;
 	/*
 	 * Use these flags instead of setting em_instruction_fetch
 	 * directly they are used so that single stepping can be
@@ -37,7 +34,7 @@
 	union {
 		per_lowcore_words32 words;
 	} lowcore; 
-} per_struct32 __attribute__((packed));
+} per_struct32;
 
 struct user_regs_struct32
 {
diff -urN linux-2.6/arch/s390/kernel/s390_ksyms.c linux-2.6-s390/arch/s390/kernel/s390_ksyms.c
--- linux-2.6/arch/s390/kernel/s390_ksyms.c	Fri Feb 27 20:04:31 2004
+++ linux-2.6-s390/arch/s390/kernel/s390_ksyms.c	Fri Feb 27 20:04:59 2004
@@ -29,6 +29,7 @@
 EXPORT_SYMBOL_NOVERS(_oi_bitmap);
 EXPORT_SYMBOL_NOVERS(_ni_bitmap);
 EXPORT_SYMBOL_NOVERS(_zb_findmap);
+EXPORT_SYMBOL_NOVERS(_sb_findmap);
 EXPORT_SYMBOL_NOVERS(__copy_from_user_asm);
 EXPORT_SYMBOL_NOVERS(__copy_to_user_asm);
 EXPORT_SYMBOL_NOVERS(__clear_user_asm);
@@ -92,5 +93,4 @@
 EXPORT_SYMBOL_NOVERS(do_call_softirq);
 EXPORT_SYMBOL(sys_wait4);
 EXPORT_SYMBOL(cpcmd);
-EXPORT_SYMBOL(smp_call_function_on);
 EXPORT_SYMBOL(sys_ioctl);
diff -urN linux-2.6/arch/s390/kernel/smp.c linux-2.6-s390/arch/s390/kernel/smp.c
--- linux-2.6/arch/s390/kernel/smp.c	Fri Feb 27 20:04:31 2004
+++ linux-2.6-s390/arch/s390/kernel/smp.c	Fri Feb 27 20:04:59 2004
@@ -203,10 +203,11 @@
 	put_cpu();
 	return 0;
 }
+EXPORT_SYMBOL(smp_call_function_on);
 
 static inline void do_send_stop(void)
 {
-        u32 dummy;
+        unsigned long dummy;
         int i, rc;
 
         /* stop all processors */
@@ -222,7 +223,7 @@
 static inline void do_store_status(void)
 {
         unsigned long low_core_addr;
-        u32 dummy;
+        unsigned long dummy;
         int i, rc;
 
         /* store status of all processors in their lowcores (real 0) */
@@ -619,7 +620,7 @@
 		if (lowcore_ptr[i] == NULL || async_stack == 0ULL)
 			panic("smp_boot_cpus failed to allocate memory\n");
 
-                memcpy(lowcore_ptr[i], &S390_lowcore, sizeof(struct _lowcore));
+		*(lowcore_ptr[i]) = S390_lowcore;
 		lowcore_ptr[i]->async_stack = async_stack + (ASYNC_SIZE);
 	}
 	set_prefix((u32)(unsigned long) lowcore_ptr[smp_processor_id()]);
diff -urN linux-2.6/arch/s390/kernel/traps.c linux-2.6-s390/arch/s390/kernel/traps.c
--- linux-2.6/arch/s390/kernel/traps.c	Fri Feb 27 20:04:31 2004
+++ linux-2.6-s390/arch/s390/kernel/traps.c	Fri Feb 27 20:04:59 2004
@@ -616,8 +616,6 @@
         pgm_check_table[9] = &divide_exception;
         pgm_check_table[0x10] = &do_segment_exception;
         pgm_check_table[0x11] = &do_page_exception;
-        pgm_check_table[0x10] = &do_segment_exception;
-        pgm_check_table[0x11] = &do_page_exception;
         pgm_check_table[0x12] = &translation_exception;
         pgm_check_table[0x13] = &special_op_exception;
 #ifndef CONFIG_ARCH_S390X
diff -urN linux-2.6/arch/s390/mm/cmm.c linux-2.6-s390/arch/s390/mm/cmm.c
--- linux-2.6/arch/s390/mm/cmm.c	Fri Feb 27 20:04:31 2004
+++ linux-2.6-s390/arch/s390/mm/cmm.c	Fri Feb 27 20:04:59 2004
@@ -87,8 +87,7 @@
 			pa->index = 0;
 			*list = pa;
 		}
-		if (page < 0x80000000UL)
-			diag10(page);
+		diag10(page);
 		pa->pages[pa->index++] = page;
 		(*counter)++;
 		pages--;
diff -urN linux-2.6/arch/s390/mm/init.c linux-2.6-s390/arch/s390/mm/init.c
--- linux-2.6/arch/s390/mm/init.c	Fri Feb 27 20:04:31 2004
+++ linux-2.6-s390/arch/s390/mm/init.c	Fri Feb 27 20:04:59 2004
@@ -42,9 +42,9 @@
 
 void diag10(unsigned long addr)
 {
-#ifdef __s390x__
-        if (addr >= 0x80000000)
+        if (addr >= 0x7ff00000)
                 return;
+#ifdef __s390x__
         asm volatile ("sam31\n\t"
                       "diag %0,%0,0x10\n\t"
                       "sam64" : : "a" (addr) );
diff -urN linux-2.6/include/asm-s390/compat.h linux-2.6-s390/include/asm-s390/compat.h
--- linux-2.6/include/asm-s390/compat.h	Wed Feb 18 04:57:17 2004
+++ linux-2.6-s390/include/asm-s390/compat.h	Fri Feb 27 20:04:59 2004
@@ -25,6 +25,7 @@
 typedef s32		compat_daddr_t;
 typedef u32		compat_caddr_t;
 typedef __kernel_fsid_t	compat_fsid_t;
+typedef s32		compat_timer_t;
 
 typedef s32		compat_int_t;
 typedef s32		compat_long_t;
diff -urN linux-2.6/include/asm-s390/sigp.h linux-2.6-s390/include/asm-s390/sigp.h
--- linux-2.6/include/asm-s390/sigp.h	Wed Feb 18 04:58:00 2004
+++ linux-2.6-s390/include/asm-s390/sigp.h	Fri Feb 27 20:04:59 2004
@@ -121,7 +121,7 @@
  * Signal processor with parameter and return status
  */
 extern __inline__ sigp_ccode
-signal_processor_ps(__u32 *statusptr, unsigned long parameter,
+signal_processor_ps(unsigned long *statusptr, unsigned long parameter,
 		    __u16 cpu_addr, sigp_order_code order_code)
 {
 	sigp_ccode ccode;
