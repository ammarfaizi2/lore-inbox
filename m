Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267720AbTAaITS>; Fri, 31 Jan 2003 03:19:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267721AbTAaITS>; Fri, 31 Jan 2003 03:19:18 -0500
Received: from cs-ats40.donpac.ru ([217.107.128.161]:7428 "EHLO pazke")
	by vger.kernel.org with ESMTP id <S267720AbTAaITR>;
	Fri, 31 Jan 2003 03:19:17 -0500
Date: Fri, 31 Jan 2003 11:23:54 +0300
To: linux-kernel@vger.kernel.org
Subject: [PATCH] export boottime gdt from i386/kernel/trampoline.S
Message-ID: <20030131082354.GA9682@pazke>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="vkogqOf2sHV7VnPd"
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Uname: Linux 2.4.20aa1 i686 unknown
From: Andrey Panin <pazke@orbita1.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--vkogqOf2sHV7VnPd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

this trivial patch (against 2.5.59) renames gdt_48 to boot_gdt and 
makes it global, idt_48 is renamed to for consistency sake.

This patch allows visws subarch to use boottime gdt for starting boot cpu.

Please consider applying.

Best regards.

-- 
Andrey Panin		| Embedded systems software developer
pazke@orbita1.ru	| PGP key: wwwkeys.pgp.net

--vkogqOf2sHV7VnPd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-boot_gdt

diff -urN -X /usr/share/dontdiff linux-2.5.59.vanilla/arch/i386/kernel/trampoline.S linux-2.5.59/arch/i386/kernel/trampoline.S
--- linux-2.5.59.vanilla/arch/i386/kernel/trampoline.S	Wed Jan 15 20:37:20 2003
+++ linux-2.5.59/arch/i386/kernel/trampoline.S	Sun Jan 19 18:43:10 2003
@@ -46,8 +46,8 @@
 	movl	$0xA5A5A5A5, trampoline_data - r_base
 				# write marker for master knows we're running
 
-	lidt	idt_48 - r_base	# load idt with 0, 0
-	lgdt	gdt_48 - r_base	# load gdt with whatever is appropriate
+	lidt	boot_idt - r_base	# load idt with 0, 0
+	lgdt	boot_gdt - r_base	# load gdt with whatever is appropriate
 
 	xor	%ax, %ax
 	inc	%ax		# protected mode (PE) bit
@@ -57,7 +57,7 @@
 	ljmpl	$__BOOT_CS, $0x00100000
 			# jump to startup_32 in arch/i386/kernel/head.S
 
-idt_48:
+boot_idt:
 	.word	0			# idt limit = 0
 	.word	0, 0			# idt base = 0L
 
@@ -65,8 +65,8 @@
 # NOTE: here we actually use CPU#0's GDT - but that is OK, we reload
 # the proper GDT shortly after booting up the secondary CPUs.
 #
-
-gdt_48:
+	.globl boot_gdt
+boot_gdt:
 	.word	__BOOT_DS + 7			# gdt limit
 	.long	boot_gdt_table-__PAGE_OFFSET	# gdt base = gdt (first SMP CPU)
 

--vkogqOf2sHV7VnPd--
