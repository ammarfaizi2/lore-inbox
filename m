Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268446AbUHYFCx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268446AbUHYFCx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 01:02:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268464AbUHYFCx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 01:02:53 -0400
Received: from ozlabs.org ([203.10.76.45]:5297 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S268446AbUHYFAq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 01:00:46 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16684.7416.264685.967941@cargo.ozlabs.ibm.com>
Date: Wed, 25 Aug 2004 15:00:40 +1000
From: Paul Mackerras <paulus@samba.org>
To: akpm@osdl.org, torvalds@osdl.org
Cc: benh@kernel.crashing.org, anton@samba.org, linux-kernel@vger.kernel.org
Subject: [PATCH] PPC64 Better handling of H_ENTER failures
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch changes the hash insertion routines to return an error 
instead of calling panic() when HV refuses to insert a HPTE (the
hypervisor call to set up a hashtable PTE is H_ENTER).

The error is now propagated upstream, and either bad_page_fault() is
called (kernel mode) or a SIGBUS signal is forced (user mode). Some
other panic() cases are also turned into BUG_ON.

Overall, this should provide us with better debugging data if the
problem happens, and avoids errors from userland mapping /dev/mem and
trying to use forbidden IOs (XFree ?) to bring the whole kernel down.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Paul Mackerras <paulus@samba.org>

diff -urN linux-2.5/arch/ppc64/kernel/head.S akpm/arch/ppc64/kernel/head.S
--- linux-2.5/arch/ppc64/kernel/head.S	2004-08-24 07:22:47.000000000 +1000
+++ akpm/arch/ppc64/kernel/head.S	2004-08-24 16:51:40.000000000 +1000
@@ -1037,6 +1037,9 @@
 	 * interrupts if necessary.
 	 */
 	beq	.ret_from_except_lite
+	/* For a hash failure, we don't bother re-enabling interrupts */
+	ble-	12f
+
 	/*
 	 * hash_page couldn't handle it, set soft interrupt enable back
 	 * to what it was before the trap.  Note that .local_irq_restore
@@ -1047,6 +1050,8 @@
 	b	11f
 #else
 	beq	fast_exception_return   /* Return from exception on success */
+	ble-	12f			/* Failure return from hash_page */
+
 	/* fall through */
 #endif
 
@@ -1066,6 +1071,15 @@
 	bl	.bad_page_fault
 	b	.ret_from_except
 
+/* We have a page fault that hash_page could handle but HV refused
+ * the PTE insertion
+ */
+12:	bl	.save_nvgprs
+	addi	r3,r1,STACK_FRAME_OVERHEAD
+	lwz	r4,_DAR(r1)
+	bl	.low_hash_fault
+	b	.ret_from_except
+
 	/* here we have a segment miss */
 _GLOBAL(do_ste_alloc)
 	bl	.ste_allocate		/* try to insert stab entry */
diff -urN linux-2.5/arch/ppc64/kernel/pSeries_lpar.c akpm/arch/ppc64/kernel/pSeries_lpar.c
--- linux-2.5/arch/ppc64/kernel/pSeries_lpar.c	2004-07-26 05:20:35.000000000 +1000
+++ akpm/arch/ppc64/kernel/pSeries_lpar.c	2004-08-24 17:29:18.000000000 +1000
@@ -377,7 +377,7 @@
 	lpar_rc = plpar_hcall(H_ENTER, flags, hpte_group, lhpte.dw0.dword0,
 			      lhpte.dw1.dword1, &slot, &dummy0, &dummy1);
 
-	if (lpar_rc == H_PTEG_Full)
+	if (unlikely(lpar_rc == H_PTEG_Full))
 		return -1;
 
 	/*
@@ -385,7 +385,7 @@
 	 * will fail. However we must catch the failure in hash_page
 	 * or we will loop forever, so return -2 in this case.
 	 */
-	if (lpar_rc != H_Success)
+	if (unlikely(lpar_rc != H_Success))
 		return -2;
 
 	/* Because of iSeries, we have to pass down the secondary
@@ -415,9 +415,7 @@
 		if (lpar_rc == H_Success)
 			return i;
 
-		if (lpar_rc != H_Not_Found)
-			panic("Bad return code from pte remove rc = %lx\n",
-			      lpar_rc);
+		BUG_ON(lpar_rc != H_Not_Found);
 
 		slot_offset++;
 		slot_offset &= 0x7;
@@ -447,8 +445,7 @@
 	if (lpar_rc == H_Not_Found)
 		return -1;
 
-	if (lpar_rc != H_Success)
-		panic("bad return code from pte protect rc = %lx\n", lpar_rc);
+	BUG_ON(lpar_rc != H_Success);
 
 	return 0;
 }
@@ -467,8 +464,7 @@
 	
 	lpar_rc = plpar_pte_read(flags, slot, &dword0, &dummy_word1);
 
-	if (lpar_rc != H_Success)
-		panic("Error on pte read in get_hpte0 rc = %lx\n", lpar_rc);
+	BUG_ON(lpar_rc != H_Success);
 
 	return dword0;
 }
@@ -519,15 +515,12 @@
 	vpn = va >> PAGE_SHIFT;
 
 	slot = pSeries_lpar_hpte_find(vpn);
-	if (slot == -1)
-		panic("updateboltedpp: Could not find page to bolt\n");
+	BUG_ON(slot == -1);
 
 	flags = newpp & 3;
 	lpar_rc = plpar_pte_protect(flags, slot, 0);
 
-	if (lpar_rc != H_Success)
-		panic("Bad return code from pte bolted protect rc = %lx\n",
-		      lpar_rc); 
+	BUG_ON(lpar_rc != H_Success);
 }
 
 static void pSeries_lpar_hpte_invalidate(unsigned long slot, unsigned long va,
@@ -546,8 +539,7 @@
 	if (lpar_rc == H_Not_Found)
 		return;
 
-	if (lpar_rc != H_Success)
-		panic("Bad return code from invalidate rc = %lx\n", lpar_rc);
+	BUG_ON(lpar_rc != H_Success);
 }
 
 /*
diff -urN linux-2.5/arch/ppc64/mm/hash_low.S akpm/arch/ppc64/mm/hash_low.S
--- linux-2.5/arch/ppc64/mm/hash_low.S	2004-04-13 09:25:09.000000000 +1000
+++ akpm/arch/ppc64/mm/hash_low.S	2004-08-24 16:49:57.000000000 +1000
@@ -278,6 +278,10 @@
 	b	bail
 
 htab_pte_insert_failure:
-	b	.htab_insert_failure
+	/* Bail out restoring old PTE */
+	ld	r6,STK_PARM(r6)(r1)
+	std	r31,0(r6)
+	li	r3,-1
+	b	bail
 
 
diff -urN linux-2.5/arch/ppc64/mm/hash_utils.c akpm/arch/ppc64/mm/hash_utils.c
--- linux-2.5/arch/ppc64/mm/hash_utils.c	2004-07-31 00:40:05.000000000 +1000
+++ akpm/arch/ppc64/mm/hash_utils.c	2004-08-24 16:49:57.000000000 +1000
@@ -28,6 +28,7 @@
 #include <linux/ctype.h>
 #include <linux/cache.h>
 #include <linux/init.h>
+#include <linux/signal.h>
 
 #include <asm/ppcdebug.h>
 #include <asm/processor.h>
@@ -236,14 +237,11 @@
 	return pp;
 }
 
-/*
- * Called by asm hashtable.S in case of critical insert failure
+/* Result code is:
+ *  0 - handled
+ *  1 - normal page fault
+ * -1 - critical hash insertion error
  */
-void htab_insert_failure(void)
-{
-	panic("hash_page: pte_insert failed\n");
-}
-
 int hash_page(unsigned long ea, unsigned long access, unsigned long trap)
 {
 	void *pgdir;
@@ -371,6 +369,25 @@
 			   (unsigned long)insn_addr);
 }
 
+/*
+ * low_hash_fault is called when we the low level hash code failed
+ * to instert a PTE due to an hypervisor error
+ */
+void low_hash_fault(struct pt_regs *regs, unsigned long address)
+{
+	if (user_mode(regs)) {
+		siginfo_t info;
+
+		info.si_signo = SIGBUS;
+		info.si_errno = 0;
+		info.si_code = BUS_ADRERR;
+		info.si_addr = (void *)address;
+		force_sig_info(SIGBUS, &info, current);
+		return;
+	}
+	bad_page_fault(regs, address, SIGBUS);
+}
+
 void __init htab_finish_init(void)
 {
 	extern unsigned int *htab_call_hpte_insert1;
diff -urN linux-2.5/include/asm-ppc64/system.h akpm/include/asm-ppc64/system.h
--- linux-2.5/include/asm-ppc64/system.h	2004-08-24 07:22:48.000000000 +1000
+++ akpm/include/asm-ppc64/system.h	2004-08-24 16:49:57.000000000 +1000
@@ -105,6 +105,7 @@
 extern void bad_page_fault(struct pt_regs *regs, unsigned long address,
 			   int sig);
 extern void show_regs(struct pt_regs * regs);
+extern void low_hash_fault(struct pt_regs *regs, unsigned long address);
 extern int die(const char *str, struct pt_regs *regs, long err);
 
 extern void flush_instruction_cache(void);
