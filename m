Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267913AbTAMGU6>; Mon, 13 Jan 2003 01:20:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267915AbTAMGU5>; Mon, 13 Jan 2003 01:20:57 -0500
Received: from rwcrmhc53.attbi.com ([204.127.198.39]:20715 "EHLO
	rwcrmhc53.attbi.com") by vger.kernel.org with ESMTP
	id <S267913AbTAMGUu>; Mon, 13 Jan 2003 01:20:50 -0500
Message-ID: <3E225CDF.40903@quark.didntduck.org>
Date: Mon, 13 Jan 2003 01:29:51 -0500
From: Brian Gerst <bgerst@quark.didntduck.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021203
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] Fix PnP BIOS fault handling
Content-Type: multipart/mixed;
 boundary="------------020408030909050809090300"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020408030909050809090300
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Check for PnP BIOS in all fault paths, not just in do_trap().

--
				Brian Gerst

--------------020408030909050809090300
Content-Type: text/plain;
 name="traps-a1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="traps-a1"

diff -urN linux-2.5.56-bk1/arch/i386/kernel/traps.c linux-a1/arch/i386/kernel/traps.c
--- linux-2.5.56-bk1/arch/i386/kernel/traps.c	Sat Jan 11 03:24:59 2003
+++ linux-a1/arch/i386/kernel/traps.c	Sat Jan 11 03:29:47 2003
@@ -297,26 +297,7 @@
 	}
 
 	kernel_trap: {
-		const struct exception_table_entry *fixup;
-#ifdef CONFIG_PNPBIOS
-		if (unlikely((regs->xcs | 8) == 0x88)) /* 0x80 or 0x88 */
-		{
-			extern u32 pnp_bios_fault_eip, pnp_bios_fault_esp;
-			extern u32 pnp_bios_is_utter_crap;
-			pnp_bios_is_utter_crap = 1;
-			printk(KERN_CRIT "PNPBIOS fault.. attempting recovery.\n");
-			__asm__ volatile(
-				"movl %0, %%esp\n\t"
-				"jmp *%1\n\t"
-				: "=a" (pnp_bios_fault_esp), "=b" (pnp_bios_fault_eip));
-			panic("do_trap: can't hit this");
-		}
-#endif	
-		
-		fixup = search_exception_tables(regs->eip);
-		if (fixup)
-			regs->eip = fixup->fixup;
-		else	
+		if (!fixup_exception(regs))
 			die(str, regs, error_code);
 		return;
 	}
@@ -393,15 +374,8 @@
 	return;
 
 gp_in_kernel:
-	{
-		const struct exception_table_entry *fixup;
-		fixup = search_exception_tables(regs->eip);
-		if (fixup) {
-			regs->eip = fixup->fixup;
-			return;
-		}
+	if (!fixup_exception(regs))
 		die("general protection fault", regs, error_code);
-	}
 }
 
 static void mem_parity_error(unsigned char reason, struct pt_regs * regs)
diff -urN linux-2.5.56-bk1/arch/i386/mm/extable.c linux-a1/arch/i386/mm/extable.c
--- linux-2.5.56-bk1/arch/i386/mm/extable.c	Sat Jan 11 03:24:59 2003
+++ linux-a1/arch/i386/mm/extable.c	Sat Jan 11 03:29:47 2003
@@ -28,3 +28,31 @@
         }
         return NULL;
 }
+
+int fixup_exception(struct pt_regs *regs)
+{
+	const struct exception_table_entry *fixup;
+
+#ifdef CONFIG_PNPBIOS
+	if (unlikely((regs->xcs | 8) == 0x88)) /* 0x80 or 0x88 */
+	{
+		extern u32 pnp_bios_fault_eip, pnp_bios_fault_esp;
+		extern u32 pnp_bios_is_utter_crap;
+		pnp_bios_is_utter_crap = 1;
+		printk(KERN_CRIT "PNPBIOS fault.. attempting recovery.\n");
+		__asm__ volatile(
+			"movl %0, %%esp\n\t"
+			"jmp *%1\n\t"
+			: "=a" (pnp_bios_fault_esp), "=b" (pnp_bios_fault_eip));
+		panic("do_trap: can't hit this");
+	}
+#endif
+
+	fixup = search_exception_tables(regs->eip);
+	if (fixup) {
+		regs->eip = fixup->fixup;
+		return 1;
+	}
+
+	return 0;
+}
diff -urN linux-2.5.56-bk1/arch/i386/mm/fault.c linux-a1/arch/i386/mm/fault.c
--- linux-2.5.56-bk1/arch/i386/mm/fault.c	Sat Jan 11 03:24:59 2003
+++ linux-a1/arch/i386/mm/fault.c	Sat Jan 11 03:29:47 2003
@@ -155,7 +155,6 @@
 	struct vm_area_struct * vma;
 	unsigned long address;
 	unsigned long page;
-	const struct exception_table_entry *fixup;
 	int write;
 	siginfo_t info;
 
@@ -311,10 +310,8 @@
 
 no_context:
 	/* Are we prepared to handle this kernel fault?  */
-	if ((fixup = search_exception_tables(regs->eip)) != NULL) {
-		regs->eip = fixup->fixup;
+	if (fixup_exception(regs))
 		return;
-	}
 
 /*
  * Oops. The kernel tried to access some bad page. We'll have to
diff -urN linux-2.5.56-bk1/include/asm-i386/uaccess.h linux-a1/include/asm-i386/uaccess.h
--- linux-2.5.56-bk1/include/asm-i386/uaccess.h	Sat Jan 11 03:25:00 2003
+++ linux-a1/include/asm-i386/uaccess.h	Sat Jan 11 03:29:47 2003
@@ -92,6 +92,8 @@
 	unsigned long insn, fixup;
 };
 
+extern int fixup_exception(struct pt_regs *regs);
+
 /*
  * These are the main single-value transfer routines.  They automatically
  * use the right size if we just have the right pointer type.

--------------020408030909050809090300--

