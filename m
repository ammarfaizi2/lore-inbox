Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266460AbUF3Emp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266460AbUF3Emp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 00:42:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266463AbUF3Emo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 00:42:44 -0400
Received: from ozlabs.org ([203.10.76.45]:982 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S266460AbUF3El1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 00:41:27 -0400
Date: Wed, 30 Jun 2004 14:37:04 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Andrew Morton <akpm@osdl.org>
Cc: Anton Blanchard <anton@samba.org>, Paul Mackerras <paulus@samba.org>,
       linuxppc64-dev@lists.linuxppc.org, linux-kernel@vger.kernel.org
Subject: [PPC64] 2/2 - PACA cleanup
Message-ID: <20040630043704.GC15526@zax>
Mail-Followup-To: David Gibson <david@gibson.dropbear.id.au>,
	Andrew Morton <akpm@osdl.org>, Anton Blanchard <anton@samba.org>,
	Paul Mackerras <paulus@samba.org>, linuxppc64-dev@lists.linuxppc.org,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew, please apply:

Cleanup the PPC64 PACA structure.  It was previously a big mess of
unecessary fields, overengineered cache layout and uninformative
comments.  This is essentially a rewrite of include/asm-pp64/paca.h
with associated changes elsewhere.  The patch:
	- Removes unused PACA fields
	- Removes uneeded #includes
	- Uses gcc attributes instead of explicit padding to get the
	  desired cacheline layout, also rethinks the layout and
	  comments accordingly.
	- Better comments where asm or firmware dependencies apply
	  non-obvious layout constraints.
	- Splits up the pointless STAB structure, letting us move its
	  elements independently.
	- Uses offsetof instead of hardcoded offset in spinlocks.
	- Eradicates xStudlyCaps identifiers
	- Replaces PACA guard page with an explicitly defined
	  emergency stack (removing more than NR_CPUS pages from the
	  initialized data segment).

Index: working-2.6/include/asm-ppc64/paca.h
===================================================================
--- working-2.6.orig/include/asm-ppc64/paca.h	2004-06-29 15:27:05.576147440 +1000
+++ working-2.6/include/asm-ppc64/paca.h	2004-06-29 15:30:39.794189104 +1000
@@ -1,11 +1,8 @@
 #ifndef _PPC64_PACA_H
 #define _PPC64_PACA_H
 
-/*============================================================================
- *                                                         Header File Id
- * Name______________:	paca.h
- *
- * Description_______:
+/*
+ * include/asm-ppc64/paca.h
  *
  * This control block defines the PACA which defines the processor 
  * specific data for each logical processor on the system.  
@@ -18,137 +15,105 @@
  * as published by the Free Software Foundation; either version
  * 2 of the License, or (at your option) any later version.
  */    
-#include	<asm/types.h>
-
-#define N_EXC_STACK    2
 
-/*-----------------------------------------------------------------------------
- * Other Includes
- *-----------------------------------------------------------------------------
- */
+#include	<asm/types.h>
 #include	<asm/iSeries/ItLpPaca.h>
 #include	<asm/iSeries/ItLpRegSave.h>
-#include	<asm/iSeries/ItLpQueue.h>
 #include	<asm/mmu.h>
-#include	<asm/processor.h>
 
 extern struct paca_struct paca[];
 register struct paca_struct *local_paca asm("r13");
 #define get_paca()	local_paca
 
 struct task_struct;
+struct ItLpQueue;
 
-/*============================================================================
- * Name_______:	paca
+/*
+ * Defines the layout of the paca.  
  *
- * Description:
- *
- *	Defines the layout of the paca.  
- *
- *	This structure is not directly accessed by PLIC or the SP except
- *	for the first two pointers that point to the ItLpPaca area and the
- *	ItLpRegSave area for this processor.  Both the ItLpPaca and
- *	ItLpRegSave objects are currently contained within the
- *	PACA but they do not need to be.
- *
- *============================================================================
+ * This structure is not directly accessed by firmware or the service
+ * processor except for the first two pointers that point to the
+ * ItLpPaca area and the ItLpRegSave area for this CPU.  Both the
+ * ItLpPaca and ItLpRegSave objects are currently contained within the
+ * PACA but they do not need to be.
  */
 struct paca_struct {
-/*=====================================================================================
- * CACHE_LINE_1 0x0000 - 0x007F
- *=====================================================================================
- */
-	struct ItLpPaca *xLpPacaPtr;	/* Pointer to LpPaca for PLIC		0x00 */
-	struct ItLpRegSave *xLpRegSavePtr; /* Pointer to LpRegSave for PLIC	0x08 */
-	struct task_struct *xCurrent;	/* Pointer to current			0x10 */
-	/* Note: the spinlock functions in arch/ppc64/lib/locks.c load lock_token and
-	   xPacaIndex with a single lwz instruction, using the constant offset 24.
-	   If you move either field, fix the spinlocks and rwlocks. */
-	u16 lock_token;			/* Constant 0x8000, used in spinlocks	0x18 */
-	u16 xPacaIndex;			/* Logical processor number		0x1A */
-	u32 default_decr;		/* Default decrementer value		0x1c */	
-	u64 xKsave;			/* Saved Kernel stack addr or zero	0x20 */
-	struct ItLpQueue *lpQueuePtr;	/* LpQueue handled by this processor    0x28 */
-	u64  xTOC;			/* Kernel TOC address			0x30 */
-	STAB xStab_data;		/* Segment table information		0x38,0x40,0x48 */
-	u8 *exception_sp;		/*                                      0x50 */
-	u8 xProcEnabled;		/*                                      0x58 */
-	u8 prof_enabled;		/* 1=iSeries profiling enabled          0x59 */
-	u16 xHwProcNum;			/* Physical processor number		0x5a */
-	u8 resv1[36];			/*					0x5c */
-
-/*=====================================================================================
- * CACHE_LINE_2 0x0080 - 0x00FF
- *=====================================================================================
- */
-	u64 spare1;			/*					0x00 */
-	u64 spare2;			/*					0x08 */
-	u64 spare3;			/*					0x10 */
-	u64 spare4;		/*					0x18 */
-	u64 next_jiffy_update_tb;	/* TB value for next jiffy update	0x20 */
-	u32 lpEvent_count;		/* lpEvents processed			0x28 */
-	u32 prof_multiplier;		/*					0x2C */
-	u32 prof_counter;		/*					0x30 */
-	u32 prof_shift;			/* iSeries shift for profile bucket size0x34 */
-	u32 *prof_buffer;		/* iSeries profiling buffer		0x38 */
-	u32 *prof_stext;		/* iSeries start of kernel text		0x40 */
-	u32 prof_len;			/* iSeries length of profile buffer -1	0x48 */
-	u8  yielded;                    /* 0 = this processor is running        0x4c */
-	                                /* 1 = this processor is yielded             */
-	u8  rsvd2[128-77];		/*					0x49 */
-
-/*=====================================================================================
- * CACHE_LINE_3 0x0100 - 0x017F
- *=====================================================================================
- */
-	u8		xProcStart;	/* At startup, processor spins until	0x100 */
-  					/* xProcStart becomes non-zero. */
-	u8		rsvd3[127];
-
-/*=====================================================================================
- * CACHE_LINE_4-8  0x0180 - 0x03FF Contains ItLpPaca
- *=====================================================================================
- */
-	struct ItLpPaca xLpPaca;	/* Space for ItLpPaca */
-
-/*=====================================================================================
- * CACHE_LINE_9-16 0x0400 - 0x07FF Contains ItLpRegSave
- *=====================================================================================
- */
-	struct ItLpRegSave xRegSav;	/* Register save for proc */
-
-/*=====================================================================================
- * CACHE_LINE_17-18 0x0800 - 0x08FF Reserved
- *=====================================================================================
- */
-	u64 xR1;			/* r1 save for RTAS calls */
-	u64 xSavedMsr;			/* Old msr saved here by HvCall */
-	u8 rsvd5[256-16];
-
-/*=====================================================================================
- * CACHE_LINE_19-30 0x0900 - 0x0EFF Reserved
- *=====================================================================================
- */
-	u64 slb_shadow[0x20];
-	u64 dispatch_log;
-	u8  rsvd6[0x500 - 0x8];
-
-/*=====================================================================================
- * CACHE_LINE_31-32 0x0F00 - 0x0FFF Exception register save areas
- *=====================================================================================
- */
-	u64 exgen[8];		/* used for most interrupts/exceptions */
+	/*
+	 * Because hw_cpu_id, unlike other paca fields, is accessed
+	 * routinely from other CPUs (from the IRQ code), we stick to
+	 * read-only (after boot) fields in the first cacheline to
+	 * avoid cacheline bouncing.
+	 */
+
+	/*
+	 * MAGIC: These first two pointers can't be moved - they're
+	 * accessed by the firmware
+	 */
+	struct ItLpPaca *lppaca_ptr;	/* Pointer to LpPaca for PLIC */
+	struct ItLpRegSave *reg_save_ptr; /* Pointer to LpRegSave for PLIC */
+
+	/*
+	 * MAGIC: the spinlock functions in arch/ppc64/lib/locks.c
+	 * load lock_token and paca_index with a single lwz
+	 * instruction.  They must travel together and be properly
+	 * aligned.
+	 */
+	u16 lock_token;			/* Constant 0x8000, used in locks */
+	u16 paca_index;			/* Logical processor number */
+
+	u32 default_decr;		/* Default decrementer value */
+	struct ItLpQueue *lpqueue_ptr;	/* LpQueue handled by this CPU */
+	u64 kernel_toc;			/* Kernel TOC address */
+	u64 stab_real;			/* Absolute address of segment table */
+	u64 stab_addr;			/* Virtual address of segment table */
+	void *emergency_sp;		/* pointer to emergency stack */
+	u16 hw_cpu_id;			/* Physical processor number */
+	u8 cpu_start;			/* At startup, processor spins until */
+					/* this becomes non-zero. */
+
+	/*
+	 * Now, starting in cacheline 2, the exception save areas
+	 */
+	u64 exgen[8] __attribute__((aligned(0x80))); /* used for most interrupts/exceptions */
 	u64 exmc[8];		/* used for machine checks */
 	u64 exslb[8];		/* used for SLB/segment table misses
 				 * on the linear mapping */
 	u64 exdsi[8];		/* used for linear mapping hash table misses */
 
-/*=====================================================================================
- * Page 2 used as a stack when we detect a bad kernel stack pointer,
- * and early in SMP boots before relocation is enabled.
- *=====================================================================================
- */
-	u8 guard[0x1000];
+	/*
+	 * then miscellaneous read-write fields
+	 */
+	struct task_struct *__current;	/* Pointer to current */
+	u64 kstack;			/* Saved Kernel stack addr */
+	u64 stab_next_rr;		/* stab/slb round-robin counter */
+	u64 next_jiffy_update_tb;	/* TB value for next jiffy update */
+	u64 saved_r1;			/* r1 save for RTAS calls */
+	u64 saved_msr;			/* MSR saved here by enter_rtas */
+	u32 lpevent_count;		/* lpevents processed  */
+	u8 proc_enabled;		/* irq soft-enable flag */
+
+	/*
+	 * iSeries structues which the hypervisor knows about - Not
+	 * sure if these particularly need to be cacheline aligned.
+	 * The lppaca is also used on POWER5 pSeries boxes.
+	 */
+	struct ItLpPaca lppaca __attribute__((aligned(0x80)));
+	struct ItLpRegSave reg_save;
+
+	/*
+	 * iSeries profiling support
+	 * 
+	 * FIXME: do we still want this, or can we ditch it in favour
+	 * of oprofile?
+	 */
+	u32 *prof_buffer;		/* iSeries profiling buffer */
+	u32 *prof_stext;		/* iSeries start of kernel text */
+	u32 prof_multiplier;
+	u32 prof_counter;
+	u32 prof_shift;			/* iSeries shift for profile
+					 * bucket size */
+	u32 prof_len;			/* iSeries length of profile */
+	u8 prof_enabled;		/* 1=iSeries profiling enabled */
 };
 
 #endif /* _PPC64_PACA_H */
Index: working-2.6/include/asm-ppc64/mmu.h
===================================================================
--- working-2.6.orig/include/asm-ppc64/mmu.h	2004-05-27 10:50:23.000000000 +1000
+++ working-2.6/include/asm-ppc64/mmu.h	2004-06-29 15:30:39.794189104 +1000
@@ -100,16 +100,6 @@
 	} dw1;
 } SLBE;
 
-/*
- * This structure is used in paca.h where the layout depends on the 
- * size being 24B.
- */
-typedef struct {
-        unsigned long   real;
-        unsigned long   virt;
-        unsigned long   next_round_robin;
-} STAB;
-
 /* Hardware Page Table Entry */
 
 #define HPTES_PER_GROUP 8
Index: working-2.6/include/asm-ppc64/spinlock.h
===================================================================
--- working-2.6.orig/include/asm-ppc64/spinlock.h	2004-05-26 11:12:58.000000000 +1000
+++ working-2.6/include/asm-ppc64/spinlock.h	2004-06-29 15:30:39.795188952 +1000
@@ -15,6 +15,7 @@
  * 2 of the License, or (at your option) any later version.
  */
 #include <linux/config.h>
+#include <asm/paca.h>
 
 typedef struct {
 	volatile unsigned int lock;
@@ -57,12 +58,12 @@
 "1:	lwarx		%0,0,%2		# spin_trylock\n\
 	cmpwi		0,%0,0\n\
 	bne-		2f\n\
-	lwz		%1,24(13)\n\
+	lwz		%1,%3(13)\n\
 	stwcx.		%1,0,%2\n\
 	bne-		1b\n\
 	isync\n\
 2:"	: "=&r"(tmp), "=&r"(tmp2)
-	: "r"(&lock->lock)
+	: "r"(&lock->lock), "i"(offsetof(struct paca_struct, lock_token))
 	: "cr0", "memory");
 
 	return tmp == 0;
@@ -83,12 +84,12 @@
 "2:	lwarx		%0,0,%1\n\
 	cmpwi		0,%0,0\n\
 	bne-		1b\n\
-	lwz		%0,24(13)\n\
+	lwz		%0,%2(13)\n\
 	stwcx.		%0,0,%1\n\
 	bne-		2b\n\
 	isync"
 	: "=&r"(tmp)
-	: "r"(&lock->lock)
+	: "r"(&lock->lock), "i"(offsetof(struct paca_struct, lock_token))
 	: "cr0", "memory");
 }
 
@@ -115,12 +116,13 @@
 3:	lwarx		%0,0,%2\n\
 	cmpwi		0,%0,0\n\
 	bne-		1b\n\
-	lwz		%1,24(13)\n\
+	lwz		%1,%4(13)\n\
 	stwcx.		%1,0,%2\n\
 	bne-		3b\n\
 	isync"
 	: "=&r"(tmp), "=&r"(tmp2)
-	: "r"(&lock->lock), "r"(flags)
+	: "r"(&lock->lock), "r"(flags),
+	  "i" (offsetof(struct paca_struct, lock_token))
 	: "cr0", "memory");
 }
 
Index: working-2.6/include/asm-ppc64/iSeries/HvCall.h
===================================================================
--- working-2.6.orig/include/asm-ppc64/iSeries/HvCall.h	2004-05-20 12:58:51.000000000 +1000
+++ working-2.6/include/asm-ppc64/iSeries/HvCall.h	2004-06-29 15:30:39.795188952 +1000
@@ -183,7 +183,7 @@
 //=====================================================================
 static inline void		HvCall_sendIPI(struct paca_struct * targetPaca)
 {
-	HvCall1( HvCallBaseSendIPI, targetPaca->xPacaIndex );
+	HvCall1( HvCallBaseSendIPI, targetPaca->paca_index );
 }
 
 //=====================================================================
Index: working-2.6/include/asm-ppc64/smp.h
===================================================================
--- working-2.6.orig/include/asm-ppc64/smp.h	2004-06-29 11:47:03.000000000 +1000
+++ working-2.6/include/asm-ppc64/smp.h	2004-06-29 15:30:39.796188800 +1000
@@ -33,8 +33,8 @@
 extern void smp_message_recv(int, struct pt_regs *);
 
 
-#define smp_processor_id() (get_paca()->xPacaIndex)
-#define hard_smp_processor_id() (get_paca()->xHwProcNum)
+#define smp_processor_id() (get_paca()->paca_index)
+#define hard_smp_processor_id() (get_paca()->hw_cpu_id)
 
 /*
  * Retrieve the state of a CPU:
@@ -75,9 +75,9 @@
 extern void cpu_die(void) __attribute__((noreturn));
 #endif /* !(CONFIG_SMP) */
 
-#define get_hard_smp_processor_id(CPU) (paca[(CPU)].xHwProcNum)
+#define get_hard_smp_processor_id(CPU) (paca[(CPU)].hw_cpu_id)
 #define set_hard_smp_processor_id(CPU, VAL) \
-	do { (paca[(CPU)].xHwProcNum = VAL); } while (0)
+	do { (paca[(CPU)].hw_proc_num = (VAL)); } while (0)
 
 #endif /* __ASSEMBLY__ */
 
Index: working-2.6/include/asm-ppc64/current.h
===================================================================
--- working-2.6.orig/include/asm-ppc64/current.h	2004-06-29 15:27:05.577147288 +1000
+++ working-2.6/include/asm-ppc64/current.h	2004-06-29 15:30:39.796188800 +1000
@@ -10,7 +10,7 @@
  * 2 of the License, or (at your option) any later version.
  */
 
-#define get_current()   (get_paca()->xCurrent)
+#define get_current()   (get_paca()->__current)
 #define current         get_current()
 
 #endif /* !(_PPC64_CURRENT_H) */
Index: working-2.6/include/asm-ppc64/time.h
===================================================================
--- working-2.6.orig/include/asm-ppc64/time.h	2004-05-20 12:58:51.000000000 +1000
+++ working-2.6/include/asm-ppc64/time.h	2004-06-29 15:30:39.797188648 +1000
@@ -78,8 +78,8 @@
 	struct paca_struct *lpaca = get_paca();
 	int cur_dec;
 
-	if (lpaca->xLpPaca.xSharedProc) {
-		lpaca->xLpPaca.xVirtualDecr = val;
+	if (lpaca->lppaca.xSharedProc) {
+		lpaca->lppaca.xVirtualDecr = val;
 		cur_dec = get_dec();
 		if (cur_dec > val)
 			HvCall_setVirtualDecr();
Index: working-2.6/arch/ppc64/kernel/asm-offsets.c
===================================================================
--- working-2.6.orig/arch/ppc64/kernel/asm-offsets.c	2004-06-21 11:29:19.000000000 +1000
+++ working-2.6/arch/ppc64/kernel/asm-offsets.c	2004-06-29 15:30:39.798188496 +1000
@@ -79,33 +79,29 @@
 
 	/* paca */
         DEFINE(PACA_SIZE, sizeof(struct paca_struct));
-        DEFINE(PACAPACAINDEX, offsetof(struct paca_struct, xPacaIndex));
-        DEFINE(PACAPROCSTART, offsetof(struct paca_struct, xProcStart));
-        DEFINE(PACAKSAVE, offsetof(struct paca_struct, xKsave));
-	DEFINE(PACACURRENT, offsetof(struct paca_struct, xCurrent));
-        DEFINE(PACASAVEDMSR, offsetof(struct paca_struct, xSavedMsr));
-        DEFINE(PACASTABREAL, offsetof(struct paca_struct, xStab_data.real));
-        DEFINE(PACASTABVIRT, offsetof(struct paca_struct, xStab_data.virt));
-	DEFINE(PACASTABRR, offsetof(struct paca_struct, xStab_data.next_round_robin));
-        DEFINE(PACAR1, offsetof(struct paca_struct, xR1));
-        DEFINE(PACALPQUEUE, offsetof(struct paca_struct, lpQueuePtr));
-	DEFINE(PACATOC, offsetof(struct paca_struct, xTOC));
-	DEFINE(PACAEXCSP, offsetof(struct paca_struct, exception_sp));
-	DEFINE(PACAPROCENABLED, offsetof(struct paca_struct, xProcEnabled));
+        DEFINE(PACAPACAINDEX, offsetof(struct paca_struct, paca_index));
+        DEFINE(PACAPROCSTART, offsetof(struct paca_struct, cpu_start));
+        DEFINE(PACAKSAVE, offsetof(struct paca_struct, kstack));
+	DEFINE(PACACURRENT, offsetof(struct paca_struct, __current));
+        DEFINE(PACASAVEDMSR, offsetof(struct paca_struct, saved_msr));
+        DEFINE(PACASTABREAL, offsetof(struct paca_struct, stab_real));
+        DEFINE(PACASTABVIRT, offsetof(struct paca_struct, stab_addr));
+	DEFINE(PACASTABRR, offsetof(struct paca_struct, stab_next_rr));
+        DEFINE(PACAR1, offsetof(struct paca_struct, saved_r1));
+	DEFINE(PACATOC, offsetof(struct paca_struct, kernel_toc));
+	DEFINE(PACAPROCENABLED, offsetof(struct paca_struct, proc_enabled));
 	DEFINE(PACADEFAULTDECR, offsetof(struct paca_struct, default_decr));
 	DEFINE(PACAPROFENABLED, offsetof(struct paca_struct, prof_enabled));
 	DEFINE(PACAPROFLEN, offsetof(struct paca_struct, prof_len));
 	DEFINE(PACAPROFSHIFT, offsetof(struct paca_struct, prof_shift));
 	DEFINE(PACAPROFBUFFER, offsetof(struct paca_struct, prof_buffer));
 	DEFINE(PACAPROFSTEXT, offsetof(struct paca_struct, prof_stext));
-	DEFINE(PACALPPACA, offsetof(struct paca_struct, xLpPaca));
-        DEFINE(LPPACA, offsetof(struct paca_struct, xLpPaca));
-        DEFINE(PACAREGSAV, offsetof(struct paca_struct, xRegSav));
         DEFINE(PACA_EXGEN, offsetof(struct paca_struct, exgen));
         DEFINE(PACA_EXMC, offsetof(struct paca_struct, exmc));
         DEFINE(PACA_EXSLB, offsetof(struct paca_struct, exslb));
         DEFINE(PACA_EXDSI, offsetof(struct paca_struct, exdsi));
-        DEFINE(PACAGUARD, offsetof(struct paca_struct, guard));
+        DEFINE(PACAEMERGSP, offsetof(struct paca_struct, emergency_sp));
+	DEFINE(PACALPPACA, offsetof(struct paca_struct, lppaca));
         DEFINE(LPPACASRR0, offsetof(struct ItLpPaca, xSavedSrr0));
         DEFINE(LPPACASRR1, offsetof(struct ItLpPaca, xSavedSrr1));
 	DEFINE(LPPACAANYINT, offsetof(struct ItLpPaca, xIntDword.xAnyInt));
Index: working-2.6/arch/ppc64/kernel/pacaData.c
===================================================================
--- working-2.6.orig/arch/ppc64/kernel/pacaData.c	2004-06-21 11:29:19.000000000 +1000
+++ working-2.6/arch/ppc64/kernel/pacaData.c	2004-06-29 15:30:39.798188496 +1000
@@ -16,12 +16,22 @@
 #include <asm/ptrace.h>
 
 #include <asm/iSeries/ItLpPaca.h>
+#include <asm/iSeries/ItLpQueue.h>
 #include <asm/naca.h>
 #include <asm/paca.h>
 
 struct naca_struct *naca;
 struct systemcfg *systemcfg;
 
+/* This symbol is provided by the linker - let it fill in the paca
+ * field correctly */
+extern unsigned long __toc_start;
+
+/* Stack space used when we detect a bad kernel stack pointer, and
+ * early in SMP boots before relocation is enabled.
+ */
+char emergency_stack[PAGE_SIZE * NR_CPUS];
+
 /* The Paca is an array with one entry per processor.  Each contains an 
  * ItLpPaca, which contains the information shared between the 
  * hypervisor and Linux.  Each also contains an ItLpRegSave area which
@@ -34,22 +44,19 @@
  */
 #define PACAINITDATA(number,start,lpq,asrr,asrv)			    \
 {									    \
-	.xLpPacaPtr = &paca[number].xLpPaca,				    \
-	.xLpRegSavePtr = &paca[number].xRegSav,				    \
+	.lppaca_ptr = &paca[number].lppaca,				    \
+	.reg_save_ptr = &paca[number].reg_save,				    \
 	.lock_token = 0x8000,						    \
-	.xPacaIndex = (number),		/* Paca Index */		    \
+	.paca_index = (number),		/* Paca Index */		    \
+	.lpqueue_ptr = (lpq),		/* &xItLpQueue, */		    \
 	.default_decr = 0x00ff0000,	/* Initial Decr */		    \
-	.xStab_data = {							    \
-		.real = (asrr),		/* Real pointer to segment table */ \
-		.virt = (asrv),		/* Virt pointer to segment table */ \
-		.next_round_robin = 1,					    \
-	},								    \
-	.lpQueuePtr = (lpq),		/* &xItLpQueue, */		    \
-	/* .xRtas = {							    \
-		.lock = SPIN_LOCK_UNLOCKED				    \
-	}, */								    \
-	.xProcStart = (start),		/* Processor start */		    \
-	.xLpPaca = {							    \
+	.kernel_toc = (unsigned long)(&__toc_start) + 0x8000UL,		    \
+	.stab_real = (asrr), 		/* Real pointer to segment table */ \
+	.stab_addr = (asrv),		/* Virt pointer to segment table */ \
+	.emergency_sp = &emergency_stack[((number)+1) * PAGE_SIZE],	    \
+	.cpu_start = (start),		/* Processor start */		    \
+	.stab_next_rr = 1,						    \
+	.lppaca = {							    \
 		.xDesc = 0xd397d781,	/* "LpPa" */			    \
 		.xSize = sizeof(struct ItLpPaca),			    \
 		.xFPRegsInUse = 1,					    \
@@ -58,7 +65,7 @@
 		.xEndOfQuantum = 0xfffffffffffffffful,			    \
 		.xSLBCount = 64,					    \
 	},								    \
-	.xRegSav = {							    \
+	.reg_save = {							    \
 		.xDesc = 0xd397d9e2,	/* "LpRS" */			    \
 		.xSize = sizeof(struct ItLpRegSave)			    \
 	},								    \
Index: working-2.6/arch/ppc64/kernel/head.S
===================================================================
--- working-2.6.orig/arch/ppc64/kernel/head.S	2004-06-29 11:47:02.000000000 +1000
+++ working-2.6/arch/ppc64/kernel/head.S	2004-06-29 15:30:39.800188192 +1000
@@ -238,8 +238,8 @@
 
 #define EXCEPTION_PROLOG_ISERIES_2					\
 	mfmsr	r10;							\
-	ld	r11,LPPACA+LPPACASRR0(r13);				\
-	ld	r12,LPPACA+LPPACASRR1(r13);				\
+	ld	r11,PACALPPACA+LPPACASRR0(r13);				\
+	ld	r12,PACALPPACA+LPPACASRR1(r13);				\
 	ori	r10,r10,MSR_RI;						\
 	mtmsrd	r10,1
 
@@ -327,10 +327,10 @@
 	EXCEPTION_PROLOG_ISERIES_2;					\
 	b	label##_common;						\
 label##_Iseries_profile:						\
-	ld	r12,LPPACA+LPPACASRR1(r13);				\
+	ld	r12,PACALPPACA+LPPACASRR1(r13);				\
 	andi.	r12,r12,MSR_PR;		/* Test if in kernel */		\
 	bne	label##_Iseries_prof_ret;				\
-	ld	r11,LPPACA+LPPACASRR0(r13);				\
+	ld	r11,PACALPPACA+LPPACASRR0(r13);				\
 	ld	r12,PACAPROFSTEXT(r13);	/* _stext */			\
 	subf	r11,r12,r11;		/* offset into kernel */	\
 	lwz	r12,PACAPROFSHIFT(r13);					\
@@ -690,8 +690,8 @@
 	.globl HardwareInterrupt_Iseries_masked
 HardwareInterrupt_Iseries_masked:
 	mtcrf	0x80,r9		/* Restore regs */
-	ld	r11,LPPACA+LPPACASRR0(r13)
-	ld	r12,LPPACA+LPPACASRR1(r13)
+	ld	r11,PACALPPACA+LPPACASRR0(r13)
+	ld	r12,PACALPPACA+LPPACASRR1(r13)
 	mtspr	SRR0,r11
 	mtspr	SRR1,r12
 	ld	r9,PACA_EXGEN+EX_R9(r13)
@@ -776,7 +776,8 @@
  * save the registers there, and call kernel_bad_stack(), which panics.
  */
 bad_stack:
-	addi	r1,r13,8192-64-INT_FRAME_SIZE
+	ld	r1,PACAEMERGSP(r13)
+	subi	r1,r1,64+INT_FRAME_SIZE
 	std	r9,_CCR(r1)
 	std	r10,GPR1(r1)
 	std	r11,_NIP(r1)
@@ -1319,9 +1320,7 @@
 	sync
 
 	/* Create a temp kernel stack for use before relocation is on.	*/
-	mr	r1,r13
-	addi	r1,r1,PACAGUARD
-	addi	r1,r1,0x1000
+	ld	r1,PACAEMERGSP(r13)
 	subi	r1,r1,STACK_FRAME_OVERHEAD
 
 	cmpwi	0,r23,0
@@ -1787,9 +1786,7 @@
 	mtspr	SPRG3,r13		 /* Save vaddr of paca in SPRG3	*/
 
 	/* Create a temp kernel stack for use before relocation is on.	*/
-	mr	r1,r13
-	addi	r1,r1,PACAGUARD
-	addi	r1,r1,0x1000
+	ld	r1,PACAEMERGSP(r13)
 	subi	r1,r1,STACK_FRAME_OVERHEAD
 
 	b	.__secondary_start
@@ -1813,12 +1810,7 @@
 
 	HMT_MEDIUM			/* Set thread priority to MEDIUM */
 
-	/* set up the TOC (virtual address) */
-	LOADADDR(r2,__toc_start)
-	addi	r2,r2,0x4000
-	addi	r2,r2,0x4000
-
-	std	r2,PACATOC(r13)
+	ld	r2,PACATOC(r13)
 	li	r6,0
 	stb	r6,PACAPROCENABLED(r13)
 
@@ -2060,11 +2052,6 @@
 	li	r0,0
 	stdu	r0,-STACK_FRAME_OVERHEAD(r1)
 
-	/* set up the TOC */
-	LOADADDR(r2,__toc_start)
-	addi	r2,r2,0x4000
-	addi	r2,r2,0x4000
-
 	/* Apply the CPUs-specific fixups (nop out sections not relevant
 	 * to this CPU
 	 */
@@ -2093,7 +2080,8 @@
 	LOADADDR(r4,init_task)
 	std	r4,PACACURRENT(r13)
 
-	std	r2,PACATOC(r13)
+	/* Load the TOC */
+	ld	r2,PACATOC(r13)
 	std	r1,PACAKSAVE(r13)
 
 	/* Restore the parms passed in from the bootloader. */
Index: working-2.6/arch/ppc64/kernel/idle.c
===================================================================
--- working-2.6.orig/arch/ppc64/kernel/idle.c	2004-05-20 12:57:52.000000000 +1000
+++ working-2.6/arch/ppc64/kernel/idle.c	2004-06-29 15:30:39.801188040 +1000
@@ -76,7 +76,7 @@
 	 * The decrementer stops during the yield.  Force a fake decrementer
 	 * here and let the timer_interrupt code sort out the actual time.
 	 */
-	get_paca()->xLpPaca.xIntDword.xFields.xDecrInt = 1;
+	get_paca()->lppaca.xIntDword.xFields.xDecrInt = 1;
 	process_iSeries_events();
 }
 
@@ -98,8 +98,8 @@
 	lpaca = get_paca();
 
 	for (;;) {
-		if (lpaca->xLpPaca.xSharedProc) {
-			if (ItLpQueue_isLpIntPending(lpaca->lpQueuePtr))
+		if (lpaca->lppaca.xSharedProc) {
+			if (ItLpQueue_isLpIntPending(lpaca->lpqueue_ptr))
 				process_iSeries_events();
 			if (!need_resched())
 				yield_shared_processor();
@@ -111,7 +111,7 @@
 
 				while (!need_resched()) {
 					HMT_medium();
-					if (ItLpQueue_isLpIntPending(lpaca->lpQueuePtr))
+					if (ItLpQueue_isLpIntPending(lpaca->lpqueue_ptr))
 						process_iSeries_events();
 					HMT_low();
 				}
@@ -175,7 +175,7 @@
 	while (1) {
 		/* Indicate to the HV that we are idle.  Now would be
 		 * a good time to find other work to dispatch. */
-		lpaca->xLpPaca.xIdle = 1;
+		lpaca->lppaca.xIdle = 1;
 
 		oldval = test_and_clear_thread_flag(TIF_NEED_RESCHED);
 		if (!oldval) {
@@ -201,7 +201,7 @@
 				 * ST mode.
 				 */
 				if((naca->smt_state == SMT_DYNAMIC) &&
-				   (!(ppaca->xLpPaca.xIdle))) {
+				   (!(ppaca->lppaca.xIdle))) {
 					/* Indicate we are no longer polling for
 					 * work, and then clear need_resched.  If
 					 * need_resched was 1, set it back to 1
@@ -216,7 +216,6 @@
 
 					/* DRENG: Go HMT_medium here ? */
 					local_irq_disable(); 
-					lpaca->yielded = 1;
 
 					/* SMT dynamic mode.  Cede will result 
 					 * in this thread going dormant, if the
@@ -227,8 +226,6 @@
 					 * enables external interrupts.
 					 */
 					cede_processor();
-
-					lpaca->yielded = 0;
 				} else {
 					/* Give the HV an opportunity at the
 					 * processor, since we are not doing
@@ -242,7 +239,7 @@
 		}
 
 		HMT_medium();
-		lpaca->xLpPaca.xIdle = 0;
+		lpaca->lppaca.xIdle = 0;
 		schedule();
 		if (cpu_is_offline(smp_processor_id()) &&
 				system_state == SYSTEM_RUNNING)
@@ -262,11 +259,10 @@
 
 		/* Indicate to the HV that we are idle.  Now would be
 		 * a good time to find other work to dispatch. */
-		lpaca->xLpPaca.xIdle = 1;
+		lpaca->lppaca.xIdle = 1;
 
 		if (!need_resched()) {
 			local_irq_disable(); 
-			lpaca->yielded = 1;
 			
 			/* 
 			 * Yield the processor to the hypervisor.  We return if
@@ -276,12 +272,10 @@
 			 * are enabled.
 			 */
 			cede_processor();
-			
-			lpaca->yielded = 0;
 		}
 
 		HMT_medium();
-		lpaca->xLpPaca.xIdle = 0;
+		lpaca->lppaca.xIdle = 0;
 		schedule();
 	}
 
@@ -313,7 +307,7 @@
 #else
 	if (systemcfg->platform & PLATFORM_PSERIES) {
 		if (cur_cpu_spec->firmware_features & FW_FEATURE_SPLPAR) {
-			if(get_paca()->xLpPaca.xSharedProc) {
+			if (get_paca()->lppaca.xSharedProc) {
 				printk("idle = shared_idle\n");
 				idle_loop = shared_idle;
 			} else {
Index: working-2.6/arch/ppc64/kernel/smp.c
===================================================================
--- working-2.6.orig/arch/ppc64/kernel/smp.c	2004-06-29 15:27:05.572148048 +1000
+++ working-2.6/arch/ppc64/kernel/smp.c	2004-06-29 15:30:39.802187888 +1000
@@ -120,12 +120,10 @@
 static int smp_iSeries_numProcs(void)
 {
 	unsigned np, i;
-	struct ItLpPaca * lpPaca;
 
 	np = 0;
         for (i=0; i < NR_CPUS; ++i) {
-                lpPaca = paca[i].xLpPacaPtr;
-                if ( lpPaca->xDynProcStatus < 2 ) {
+                if (paca[i].lppaca.xDynProcStatus < 2) {
 			cpu_set(i, cpu_available_map);
 			cpu_set(i, cpu_possible_map);
 			cpu_set(i, cpu_present_at_boot);
@@ -139,11 +137,9 @@
 {
 	unsigned i;
 	unsigned np = 0;
-	struct ItLpPaca *lpPaca;
 
 	for (i=0; i < NR_CPUS; ++i) {
-		lpPaca = paca[i].xLpPacaPtr;
-		if (lpPaca->xDynProcStatus < 2) {
+		if (paca[i].lppaca.xDynProcStatus < 2) {
 			/*paca[i].active = 1;*/
 			++np;
 		}
@@ -154,21 +150,18 @@
 
 static void smp_iSeries_kick_cpu(int nr)
 {
-	struct ItLpPaca *lpPaca;
-
 	BUG_ON(nr < 0 || nr >= NR_CPUS);
 
 	/* Verify that our partition has a processor nr */
-	lpPaca = paca[nr].xLpPacaPtr;
-	if (lpPaca->xDynProcStatus >= 2)
+	if (paca[nr].lppaca.xDynProcStatus >= 2)
 		return;
 
 	/* The processor is currently spinning, waiting
-	 * for the xProcStart field to become non-zero
-	 * After we set xProcStart, the processor will
+	 * for the cpu_start field to become non-zero
+	 * After we set cpu_start, the processor will
 	 * continue on to secondary_start in iSeries_head.S
 	 */
-	paca[nr].xProcStart = 1;
+	paca[nr].cpu_start = 1;
 }
 
 static void __devinit smp_iSeries_setup_cpu(int nr)
@@ -297,7 +290,7 @@
 	 * done here.  Change isolate state to Isolate and
 	 * change allocation-state to Unusable.
 	 */
-	paca[cpu].xProcStart = 0;
+	paca[cpu].cpu_start = 0;
 
 	/* So we can recognize if it fails to come up next time. */
 	cpu_callin_map[cpu] = 0;
@@ -391,12 +384,12 @@
 	}
 
 	/* Fixup atomic count: it exited inside IRQ handler. */
-	paca[lcpu].xCurrent->thread_info->preempt_count	= 0;
+	paca[lcpu].__current->thread_info->preempt_count	= 0;
 	/* Fixup SLB round-robin so next segment (kernel) goes in segment 0 */
-	paca[lcpu].xStab_data.next_round_robin = 0;
+	paca[lcpu].stab_next_rr = 0;
 
 	/* At boot this is done in prom.c. */
-	paca[lcpu].xHwProcNum = pcpu;
+	paca[lcpu].hw_cpu_id = pcpu;
 
 	status = rtas_call(rtas_token("start-cpu"), 3, 1, NULL,
 			   pcpu, start_here, lcpu);
@@ -461,12 +454,12 @@
 	if (!smp_startup_cpu(nr))
 		return;
 
-	/* The processor is currently spinning, waiting
-	 * for the xProcStart field to become non-zero
-	 * After we set xProcStart, the processor will
-	 * continue on to secondary_start
+	/*
+	 * The processor is currently spinning, waiting for the
+	 * cpu_start field to become non-zero After we set cpu_start,
+	 * the processor will continue on to secondary_start
 	 */
-	paca[nr].xProcStart = 1;
+	paca[nr].cpu_start = 1;
 }
 #endif /* CONFIG_PPC_PSERIES */
 
@@ -491,10 +484,8 @@
 	unsigned long flags;
 
 	/* Register the Virtual Processor Area (VPA) */
-	printk(KERN_INFO "register_vpa: cpu 0x%x\n", cpu);
 	flags = 1UL << (63 - 18);
-	paca[cpu].xLpPaca.xSLBCount = 64; /* SLB restore highwater mark */
-	register_vpa(flags, cpu, __pa((unsigned long)&(paca[cpu].xLpPaca))); 
+	register_vpa(flags, cpu, __pa((unsigned long)&(paca[cpu].lppaca)));
 }
 
 static inline void smp_xics_do_message(int cpu, int msg)
@@ -817,7 +808,7 @@
 	init_idle(p, cpu);
 	unhash_process(p);
 
-	paca[cpu].xCurrent = p;
+	paca[cpu].__current = p;
 	current_set[cpu] = p->thread_info;
 }
 
@@ -869,7 +860,7 @@
 	/* cpu_possible is set up in prom.c */
 	cpu_set(boot_cpuid, cpu_online_map);
 
-	paca[boot_cpuid].xCurrent = current;
+	paca[boot_cpuid].__current = current;
 	current_set[boot_cpuid] = current->thread_info;
 }
 
@@ -894,8 +885,8 @@
 
 		tmp = &stab_array[PAGE_SIZE * cpu];
 		memset(tmp, 0, PAGE_SIZE); 
-		paca[cpu].xStab_data.virt = (unsigned long)tmp;
-		paca[cpu].xStab_data.real = virt_to_abs(tmp);
+		paca[cpu].stab_addr = (unsigned long)tmp;
+		paca[cpu].stab_real = virt_to_abs(tmp);
 	}
 
 	/* The information for processor bringup must
@@ -957,8 +948,6 @@
 	if (smp_ops->take_timebase)
 		smp_ops->take_timebase();
 
-	get_paca()->yielded = 0;
-
 #ifdef CONFIG_PPC_PSERIES
 	if (cur_cpu_spec->firmware_features & FW_FEATURE_SPLPAR) {
 		vpa_init(cpu); 
Index: working-2.6/arch/ppc64/kernel/stab.c
===================================================================
--- working-2.6.orig/arch/ppc64/kernel/stab.c	2004-06-04 10:53:50.000000000 +1000
+++ working-2.6/arch/ppc64/kernel/stab.c	2004-06-29 15:30:39.803187736 +1000
@@ -36,7 +36,7 @@
 	 * Bolt in the first vmalloc segment. Since modules end
 	 * up there it gets hit very heavily.
 	 */
-	get_paca()->xStab_data.next_round_robin = 1;
+	get_paca()->stab_next_rr = 1;
 	make_slbe(esid, vsid, 0, 1);
 #endif
 }
@@ -65,7 +65,7 @@
 		asm volatile("isync":::"memory");
 		asm volatile("slbmte  %0,%0"::"r" (0) : "memory");
 		asm volatile("isync; slbia; isync":::"memory");
-		get_paca()->xStab_data.next_round_robin = 0;
+		get_paca()->stab_next_rr = 0;
 		make_slbe(esid, vsid, seg0_largepages, 1);
 		asm volatile("isync":::"memory");
 #endif
@@ -129,7 +129,7 @@
 	 * Could not find empty entry, pick one with a round robin selection.
 	 * Search all entries in the two groups.
 	 */
-	castout_entry = get_paca()->xStab_data.next_round_robin;
+	castout_entry = get_paca()->stab_next_rr;
 	for (i = 0; i < 16; i++) {
 		if (castout_entry < 8) {
 			global_entry = (esid & 0x1f) << 3;
@@ -148,7 +148,7 @@
 		castout_entry = (castout_entry + 1) & 0xf;
 	}
 
-	get_paca()->xStab_data.next_round_robin = (castout_entry + 1) & 0xf;
+	get_paca()->stab_next_rr = (castout_entry + 1) & 0xf;
 
 	/* Modify the old entry to the new value. */
 
@@ -181,7 +181,7 @@
 	unsigned long offset;
 	int region_id = REGION_ID(esid << SID_SHIFT);
 
-	stab_entry = make_ste(get_paca()->xStab_data.virt, esid, vsid);
+	stab_entry = make_ste(get_paca()->stab_addr, esid, vsid);
 
 	if (region_id != USER_REGION_ID)
 		return;
@@ -275,7 +275,7 @@
 /* Flush all user entries from the segment table of the current processor. */
 void flush_stab(struct task_struct *tsk, struct mm_struct *mm)
 {
-	STE *stab = (STE *) get_paca()->xStab_data.virt;
+	STE *stab = (STE *) get_paca()->stab_addr;
 	STE *ste;
 	unsigned long offset = __get_cpu_var(stab_cache_ptr);
 
@@ -355,7 +355,7 @@
 	 * paca Ksave is always valid (even when on the interrupt stack)
 	 * so we use that.
 	 */
-	castout_entry = lpaca->xStab_data.next_round_robin;
+	castout_entry = lpaca->stab_next_rr;
 	do {
 		entry = castout_entry;
 		castout_entry++; 
@@ -367,9 +367,9 @@
 			castout_entry = 2;
 		asm volatile("slbmfee  %0,%1" : "=r" (esid_data) : "r" (entry));
 	} while (esid_data.data.v &&
-		 esid_data.data.esid == GET_ESID(lpaca->xKsave));
+		 esid_data.data.esid == GET_ESID(lpaca->kstack));
 
-	lpaca->xStab_data.next_round_robin = castout_entry;
+	lpaca->stab_next_rr = castout_entry;
 
 	/* slbie not needed as the previous mapping is still valid. */
 
Index: working-2.6/arch/ppc64/kernel/prom.c
===================================================================
--- working-2.6.orig/arch/ppc64/kernel/prom.c	2004-06-29 11:47:02.000000000 +1000
+++ working-2.6/arch/ppc64/kernel/prom.c	2004-06-29 15:30:39.806187280 +1000
@@ -919,7 +919,7 @@
         unsigned long secondary_hold
 		= virt_to_abs(*PTRRELOC((unsigned long *)__secondary_hold));
         struct systemcfg *_systemcfg = RELOC(systemcfg);
-	struct paca_struct *_xPaca = PTRRELOC(&paca[0]);
+	struct paca_struct *lpaca = PTRRELOC(&paca[0]);
 	struct prom_t *_prom = PTRRELOC(&prom);
 #ifdef CONFIG_SMP
 	struct naca_struct *_naca = RELOC(naca);
@@ -937,7 +937,7 @@
 				continue;
 			reg = -1;
 			prom_getprop(node, "reg", &reg, sizeof(reg));
-			_xPaca[cpuid].xHwProcNum = reg;
+			lpaca[cpuid].hw_cpu_id = reg;
 
 #ifdef CONFIG_SMP
 			cpu_set(cpuid, RELOC(cpu_available_map));
@@ -997,7 +997,7 @@
 
 		prom_debug("\ncpuid        = 0x%x\n", cpuid);
 		prom_debug("cpu hw idx   = 0x%x\n", reg);
-		_xPaca[cpuid].xHwProcNum = reg;
+		lpaca[cpuid].hw_cpu_id = reg;
 
 		/* Init the acknowledge var which will be reset by
 		 * the secondary cpu when it awakens from its OF
@@ -1066,7 +1066,7 @@
 			cpuid++;
 			if (cpuid >= NR_CPUS)
 				continue;
-			_xPaca[cpuid].xHwProcNum = interrupt_server[i];
+			lpaca[cpuid].hw_cpu_id = interrupt_server[i];
 			prom_printf("%x : preparing thread ... ",
 				    interrupt_server[i]);
 			if (_naca->smt_state) {
@@ -1664,7 +1664,7 @@
 	unsigned long phys;
 	u32 getprop_rval;
 	struct systemcfg *_systemcfg;
-	struct paca_struct *_xPaca = PTRRELOC(&paca[0]);
+	struct paca_struct *lpaca = PTRRELOC(&paca[0]);
 	struct prom_t *_prom = PTRRELOC(&prom);
 
 	/* First zero the BSS -- use memset, some arches don't have
@@ -1735,7 +1735,7 @@
 	cpu_pkg = call_prom("instance-to-package", 1, 1, prom_cpu);
 	prom_getprop(cpu_pkg, "reg", &getprop_rval, sizeof(getprop_rval));
 	_prom->cpu = getprop_rval;
-	_xPaca[0].xHwProcNum = _prom->cpu;
+	lpaca[0].hw_cpu_id = _prom->cpu;
 
 	RELOC(boot_cpuid) = 0;
 
Index: working-2.6/arch/ppc64/kernel/pmac_smp.c
===================================================================
--- working-2.6.orig/arch/ppc64/kernel/pmac_smp.c	2004-05-20 12:57:53.000000000 +1000
+++ working-2.6/arch/ppc64/kernel/pmac_smp.c	2004-06-29 15:31:51.467209800 +1000
@@ -120,7 +120,7 @@
 
 	/* Put some life in our friend */
 	pmac_call_feature(PMAC_FTR_RESET_CPU, NULL, nr, 0);
-	paca[nr].xProcStart = 1;
+	paca[nr].cpu_start = 1;
 
 	/* FIXME: We wait a bit for the CPU to take the exception, I should
 	 * instead wait for the entry code to set something for me. Well,
Index: working-2.6/arch/ppc64/kernel/ItLpQueue.c
===================================================================
--- working-2.6.orig/arch/ppc64/kernel/ItLpQueue.c	2004-05-20 12:57:52.000000000 +1000
+++ working-2.6/arch/ppc64/kernel/ItLpQueue.c	2004-06-29 15:30:39.807187128 +1000
@@ -161,7 +161,7 @@
 	mb();
 	clear_inUse( lpQueue );
 
-	get_paca()->lpEvent_count += numIntsProcessed;
+	get_paca()->lpevent_count += numIntsProcessed;
 
 	return numIntsProcessed;
 }
Index: working-2.6/arch/ppc64/kernel/iSeries_proc.c
===================================================================
--- working-2.6.orig/arch/ppc64/kernel/iSeries_proc.c	2004-05-20 12:57:52.000000000 +1000
+++ working-2.6/arch/ppc64/kernel/iSeries_proc.c	2004-06-29 15:30:39.819185304 +1000
@@ -68,7 +68,7 @@
 	seq_printf(m, "\n  events processed by processor:\n");
 
 	for_each_online_cpu(i)
-		seq_printf(m, "    CPU%02d  %10u\n", i, paca[i].lpEvent_count);
+		seq_printf(m, "    CPU%02d  %10u\n", i, paca[i].lpevent_count);
 
 	return 0;
 }
Index: working-2.6/arch/ppc64/kernel/irq.c
===================================================================
--- working-2.6.orig/arch/ppc64/kernel/irq.c	2004-06-29 11:47:02.000000000 +1000
+++ working-2.6/arch/ppc64/kernel/irq.c	2004-06-29 15:30:39.821185000 +1000
@@ -68,8 +68,8 @@
 };
 
 int __irq_offset_value;
-int ppc_spurious_interrupts = 0;
-unsigned long lpEvent_count = 0;
+int ppc_spurious_interrupts;
+unsigned long lpevent_count;
 
 int
 setup_irq(unsigned int irq, struct irqaction * new)
@@ -613,19 +613,19 @@
 
 	lpaca = get_paca();
 #ifdef CONFIG_SMP
-	if (lpaca->xLpPaca.xIntDword.xFields.xIpiCnt) {
-		lpaca->xLpPaca.xIntDword.xFields.xIpiCnt = 0;
+	if (lpaca->lppaca.xIntDword.xFields.xIpiCnt) {
+		lpaca->lppaca.xIntDword.xFields.xIpiCnt = 0;
 		iSeries_smp_message_recv(regs);
 	}
 #endif /* CONFIG_SMP */
-	lpq = lpaca->lpQueuePtr;
+	lpq = lpaca->lpqueue_ptr;
 	if (lpq && ItLpQueue_isLpIntPending(lpq))
-		lpEvent_count += ItLpQueue_process(lpq, regs);
+		lpevent_count += ItLpQueue_process(lpq, regs);
 
 	irq_exit();
 
-	if (lpaca->xLpPaca.xIntDword.xFields.xDecrInt) {
-		lpaca->xLpPaca.xIntDword.xFields.xDecrInt = 0;
+	if (lpaca->lppaca.xIntDword.xFields.xDecrInt) {
+		lpaca->lppaca.xIntDword.xFields.xDecrInt = 0;
 		/* Signal a fake decrementer interrupt */
 		timer_interrupt(regs);
 	}
Index: working-2.6/arch/ppc64/kernel/time.c
===================================================================
--- working-2.6.orig/arch/ppc64/kernel/time.c	2004-06-01 10:37:38.000000000 +1000
+++ working-2.6/arch/ppc64/kernel/time.c	2004-06-29 15:30:39.822184848 +1000
@@ -56,6 +56,7 @@
 #include <asm/cache.h>
 #include <asm/machdep.h>
 #ifdef CONFIG_PPC_ISERIES
+#include <asm/iSeries/ItLpQueue.h>
 #include <asm/iSeries/HvCallXm.h>
 #endif
 #include <asm/uaccess.h>
@@ -97,7 +98,7 @@
 struct gettimeofday_struct do_gtod;
 
 extern unsigned long wall_jiffies;
-extern unsigned long lpEvent_count;
+extern unsigned long lpevent_count;
 extern int smp_tb_synchronized;
 
 void ppc_adjtimex(void);
@@ -275,7 +276,7 @@
 	ppc64_do_profile(regs);
 #endif
 
-	lpaca->xLpPaca.xIntDword.xFields.xDecrInt = 0;
+	lpaca->lppaca.xIntDword.xFields.xDecrInt = 0;
 
 	while (lpaca->next_jiffy_update_tb <= (cur_tb = get_tb())) {
 
@@ -302,9 +303,9 @@
 
 #ifdef CONFIG_PPC_ISERIES
 	{
-		struct ItLpQueue *lpq = lpaca->lpQueuePtr;
+		struct ItLpQueue *lpq = lpaca->lpqueue_ptr;
 		if (lpq && ItLpQueue_isLpIntPending(lpq))
-			lpEvent_count += ItLpQueue_process(lpq, regs);
+			lpevent_count += ItLpQueue_process(lpq, regs);
 	}
 #endif
 
Index: working-2.6/arch/ppc64/kernel/lparcfg.c
===================================================================
--- working-2.6.orig/arch/ppc64/kernel/lparcfg.c	2004-06-29 15:27:05.573147896 +1000
+++ working-2.6/arch/ppc64/kernel/lparcfg.c	2004-06-29 15:30:39.822184848 +1000
@@ -134,7 +134,7 @@
 	}
 	memset(buf, 0, size); 
 
-	shared = (int)(lpaca->xLpPacaPtr->xSharedProc);
+	shared = (int)(lpaca->lppaca.xSharedProc);
 	n += scnprintf(buf, LPARCFG_BUFF_SIZE - n,
 		      "serial_number=%c%c%c%c%c%c%c\n", 
 		      e2a(xItExtVpdPanel.mfgID[2]),
Index: working-2.6/arch/ppc64/kernel/iSeries_setup.c
===================================================================
--- working-2.6.orig/arch/ppc64/kernel/iSeries_setup.c	2004-06-21 11:29:19.000000000 +1000
+++ working-2.6/arch/ppc64/kernel/iSeries_setup.c	2004-06-29 15:30:39.823184696 +1000
@@ -571,7 +571,7 @@
 static void __init setup_iSeries_cache_sizes(void)
 {
 	unsigned int i, n;
-	unsigned int procIx = get_paca()->xLpPaca.xDynHvPhysicalProcIndex;
+	unsigned int procIx = get_paca()->lppaca.xDynHvPhysicalProcIndex;
 
 	systemcfg->iCacheL1Size =
 		xIoHriProcessorVpd[procIx].xInstCacheSize * 1024;
@@ -665,7 +665,7 @@
 void __init iSeries_setup_arch(void)
 {
 	void *eventStack;
-	unsigned procIx = get_paca()->xLpPaca.xDynHvPhysicalProcIndex;
+	unsigned procIx = get_paca()->lppaca.xDynHvPhysicalProcIndex;
 
 	/* Add an eye catcher and the systemcfg layout version number */
 	strcpy(systemcfg->eye_catcher, "SYSTEMCFG:PPC64");
Index: working-2.6/arch/ppc64/kernel/sysfs.c
===================================================================
--- working-2.6.orig/arch/ppc64/kernel/sysfs.c	2004-06-21 11:29:19.000000000 +1000
+++ working-2.6/arch/ppc64/kernel/sysfs.c	2004-06-29 15:30:39.824184544 +1000
@@ -156,7 +156,7 @@
 
 	/* instruct hypervisor to maintain PMCs */
 	if (cur_cpu_spec->firmware_features & FW_FEATURE_SPLPAR) {
-		char *ptr = (char *)&paca[smp_processor_id()].xLpPaca;
+		char *ptr = (char *)&paca[smp_processor_id()].lppaca;
 		ptr[0xBB] = 1;
 	}
 
Index: working-2.6/arch/ppc64/kernel/setup.c
===================================================================
--- working-2.6.orig/arch/ppc64/kernel/setup.c	2004-06-29 15:27:05.570148352 +1000
+++ working-2.6/arch/ppc64/kernel/setup.c	2004-06-29 15:30:39.825184392 +1000
@@ -703,7 +703,7 @@
 	unsigned long val = simple_strtoul( str, NULL, 0 );
 	if ( ( val > 0 ) && ( val <= NR_CPUS ) ) {
 		for ( i=1; i<val; ++i )
-			paca[i].lpQueuePtr = paca[0].lpQueuePtr;
+			paca[i].lpqueue_ptr = paca[0].lpqueue_ptr;
 		printk("lpevent processing spread over %ld processors\n", val);
 	}
 	else
Index: working-2.6/arch/ppc64/xmon/xmon.c
===================================================================
--- working-2.6.orig/arch/ppc64/xmon/xmon.c	2004-06-29 15:27:05.575147592 +1000
+++ working-2.6/arch/ppc64/xmon/xmon.c	2004-06-29 15:30:39.827184088 +1000
@@ -1612,7 +1612,7 @@
 		ptrPaca = get_paca();
     
 		printf("  Local Processor Control Area (LpPaca): \n");
-		ptrLpPaca = ptrPaca->xLpPacaPtr;
+		ptrLpPaca = ptrPaca->lppaca_ptr;
 		printf("    Saved Srr0=%.16lx  Saved Srr1=%.16lx \n",
 		       ptrLpPaca->xSavedSrr0, ptrLpPaca->xSavedSrr1);
 		printf("    Saved Gpr3=%.16lx  Saved Gpr4=%.16lx \n",
@@ -1620,7 +1620,7 @@
 		printf("    Saved Gpr5=%.16lx \n", ptrLpPaca->xSavedGpr5);
     
 		printf("  Local Processor Register Save Area (LpRegSave): \n");
-		ptrLpRegSave = ptrPaca->xLpRegSavePtr;
+		ptrLpRegSave = ptrPaca->reg_save_ptr;
 		printf("    Saved Sprg0=%.16lx  Saved Sprg1=%.16lx \n",
 		       ptrLpRegSave->xSPRG0, ptrLpRegSave->xSPRG0);
 		printf("    Saved Sprg2=%.16lx  Saved Sprg3=%.16lx \n",
@@ -2522,7 +2522,7 @@
 static void dump_stab(void)
 {
 	int i;
-	unsigned long *tmp = (unsigned long *)get_paca()->xStab_data.virt;
+	unsigned long *tmp = (unsigned long *)get_paca()->stab_addr;
 
 	printf("Segment table contents of cpu %x\n", smp_processor_id());
 
Index: working-2.6/arch/ppc64/lib/locks.c
===================================================================
--- working-2.6.orig/arch/ppc64/lib/locks.c	2004-05-20 12:57:53.000000000 +1000
+++ working-2.6/arch/ppc64/lib/locks.c	2004-06-29 15:30:39.827184088 +1000
@@ -16,6 +16,7 @@
 #include <linux/kernel.h>
 #include <linux/spinlock.h>
 #include <linux/module.h>
+#include <linux/stringify.h>
 #include <asm/hvcall.h>
 #include <asm/iSeries/HvCall.h>
 
@@ -48,7 +49,7 @@
 	holder_cpu = lock_value & 0xffff;
 	BUG_ON(holder_cpu >= NR_CPUS);
 	holder_paca = &paca[holder_cpu];
-	yield_count = holder_paca->xLpPaca.xYieldCount;
+	yield_count = holder_paca->lppaca.xYieldCount;
 	if ((yield_count & 1) == 0)
 		return;		/* virtual cpu is currently running */
 	rmb();
@@ -75,7 +76,7 @@
 	unsigned long tmp, tmp2;
 
 	__asm__ __volatile__(
-"	lwz		%1,24(13)		# __spin_trylock\n\
+"	lwz		%1,%3(13)		# __spin_trylock\n\
 1:	lwarx		%0,0,%2\n\
 	cmpwi		0,%0,0\n\
 	bne-		2f\n\
@@ -83,7 +84,7 @@
 	bne-		1b\n\
 	isync\n\
 2:"	: "=&r" (tmp), "=&r" (tmp2)
-	: "r" (&lock->lock)
+	: "r" (&lock->lock), "i" (offsetof(struct paca_struct, lock_token))
 	: "cr0", "memory");
 
 	return tmp;
@@ -157,7 +158,7 @@
 	holder_cpu = lock_value & 0xffff;
 	BUG_ON(holder_cpu >= NR_CPUS);
 	holder_paca = &paca[holder_cpu];
-	yield_count = holder_paca->xLpPaca.xYieldCount;
+	yield_count = holder_paca->lppaca.xYieldCount;
 	if ((yield_count & 1) == 0)
 		return;		/* virtual cpu is currently running */
 	rmb();
@@ -246,7 +247,7 @@
 	long tmp, tmp2;
 
 	__asm__ __volatile__(
-"	lwz		%1,24(13)		# write_trylock\n\
+"	lwz		%1,%3(13)	# write_trylock\n\
 1:	lwarx		%0,0,%2\n\
 	cmpwi		0,%0,0\n\
 	bne-		2f\n\
@@ -254,7 +255,7 @@
 	bne-		1b\n\
 	isync\n\
 2:"	: "=&r" (tmp), "=&r" (tmp2)
-	: "r" (&rw->lock)
+	: "r" (&rw->lock), "i" (offsetof(struct paca_struct, lock_token))
 	: "cr0", "memory");
 
 	return tmp;


-- 
David Gibson			| For every complex problem there is a
david AT gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson
