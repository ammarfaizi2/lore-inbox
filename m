Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268393AbTBNMzZ>; Fri, 14 Feb 2003 07:55:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268423AbTBNMxc>; Fri, 14 Feb 2003 07:53:32 -0500
Received: from cs-ats40.donpac.ru ([217.107.128.161]:23822 "EHLO pazke")
	by vger.kernel.org with ESMTP id <S268412AbTBNMw5>;
	Fri, 14 Feb 2003 07:52:57 -0500
Date: Fri, 14 Feb 2003 15:58:10 +0300
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH] visws: boot changes (5/13)
Message-ID: <20030214125810.GE8230@pazke>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@transmeta.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Y1L3PTX8QE8cb2T+"
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Uname: Linux 2.4.20aa1 i686 unknown
From: Andrey Panin <pazke@orbita1.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Y1L3PTX8QE8cb2T+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi.

This simple patch adds some additional code into head.S. 

On visws bootup cpu starts in protected mode (so we don't need 
setup.S), but setting up pagetables and gdt is required before 
running rest of head.S.

Please consider applying.

Best regards.

-- 
Andrey Panin		| Embedded systems software developer
pazke@orbita1.ru	| PGP key: wwwkeys.pgp.net

--Y1L3PTX8QE8cb2T+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-visws-head

diff -urN -X /usr/share/dontdiff linux-2.5.60.vanilla/arch/i386/kernel/head.S linux-2.5.60/arch/i386/kernel/head.S
--- linux-2.5.60.vanilla/arch/i386/kernel/head.S	Fri Feb 14 15:22:36 2003
+++ linux-2.5.60/arch/i386/kernel/head.S	Fri Feb 14 15:27:47 2003
@@ -38,11 +38,37 @@
 #define X86_VENDOR_ID	CPU_PARAMS+28
 
 /*
+ * Initialize page tables
+ */
+#define INIT_PAGE_TABLES \
+	movl $pg0 - __PAGE_OFFSET, %edi; \
+	/* "007" doesn't mean with license to kill, but	PRESENT+RW+USER */ \
+	movl $007, %eax; \
+2:	stosl; \
+	add $0x1000, %eax; \
+	cmp $empty_zero_page - __PAGE_OFFSET, %edi; \
+	jne 2b;
+
+/*
  * swapper_pg_dir is the main page directory, address 0x00101000
  *
  * On entry, %esi points to the real-mode code as a 32-bit pointer.
  */
 ENTRY(startup_32)
+
+#ifdef CONFIG_X86_VISWS
+/*
+ * On SGI Visual Workstations boot CPU starts in protected mode.
+ */
+	orw %bx, %bx
+	jnz 1f
+	INIT_PAGE_TABLES
+	movl $swapper_pg_dir - __PAGE_OFFSET, %eax
+	movl %eax, %cr3
+	lgdt boot_gdt
+1:
+#endif
+
 /*
  * Set segments to known values
  */
@@ -79,17 +105,7 @@
 	jmp 3f
 1:
 #endif
-/*
- * Initialize page tables
- */
-	movl $pg0-__PAGE_OFFSET,%edi /* initialize page tables */
-	movl $007,%eax		/* "007" doesn't mean with license to kill, but
-				   PRESENT+RW+USER */
-2:	stosl
-	add $0x1000,%eax
-	cmp $empty_zero_page-__PAGE_OFFSET,%edi
-	jne 2b
-
+	INIT_PAGE_TABLES
 /*
  * Enable paging
  */
@@ -412,7 +428,7 @@
 /*
  * The Global Descriptor Table contains 28 quadwords, per-CPU.
  */
-#ifdef CONFIG_SMP
+#if defined(CONFIG_SMP) || defined(CONFIG_X86_VISWS)
 /*
  * The boot_gdt_table must mirror the equivalent in setup.S and is
  * used only by the trampoline for booting other CPUs

--Y1L3PTX8QE8cb2T+--
