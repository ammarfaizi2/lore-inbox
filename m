Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316951AbSG1Qlq>; Sun, 28 Jul 2002 12:41:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316961AbSG1Qlq>; Sun, 28 Jul 2002 12:41:46 -0400
Received: from ppp77-4-71.miem.edu.ru ([194.226.32.71]:13440 "EHLO null.ru")
	by vger.kernel.org with ESMTP id <S316951AbSG1Qlm>;
	Sun, 28 Jul 2002 12:41:42 -0400
Message-ID: <3D441832.10506@yahoo.com>
Date: Sun, 28 Jul 2002 20:13:38 +0400
From: Stas Sergeev <stssppnn@yahoo.com>
Reply-To: stas.orel@mailcity.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.2.1) Gecko/20010901
X-Accept-Language: ru, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [patch] vm86: Handle multiply prefixes
Content-Type: multipart/mixed;
 boundary="------------040401070707020306080609"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040401070707020306080609
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit

Hello.

Problem:
Currently v86 monitor doesn't
handle multiply prefixes.
For example, pushfd can be coded
as 66 9c which is handled correctly,
but also as 67 66 9c
(winnt.exe does this) which is not
handled.

The attached patch is intended to
fix the problem. With it applied,
dosemu can run winnt.exe (Windows NT
Setup), otherwise it crashes.
The patch is against the latest
2.4.19-pre-ac kernels.

--------------040401070707020306080609
Content-Type: text/plain;
 name="vm86_pref.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="vm86_pref.diff"

--- linux/arch/i386/kernel/vm86.c	Sat Jun 15 19:46:46 2002
+++ linux/arch/i386/kernel/vm86.c	Fri Jul 26 14:25:35 2002
@@ -502,8 +508,9 @@
 
 void handle_vm86_fault(struct kernel_vm86_regs * regs, long error_code)
 {
-	unsigned char *csp, *ssp;
+	unsigned char *csp, *ssp, opcode;
 	unsigned short ip, sp;
+	int data32, pref_done;
 
 #define CHECK_IF_IN_TRAP \
 	if (VMPI.vm86dbg_active && VMPI.vm86dbg_TFpendig) \
@@ -518,70 +525,63 @@
 	sp = SP(regs);
 	ip = IP(regs);
 
-	switch (popb(csp, ip, simulate_sigsegv)) {
+	data32 = 0;
+	pref_done = 0;
+	do {
+		switch (opcode = popb(csp, ip, simulate_sigsegv)) {
+			case 0x66:      /* 32-bit data */     data32=1; break;
+			case 0x67:      /* 32-bit address */  break;
+			case 0x2e:      /* CS */              break;
+			case 0x3e:      /* DS */              break;
+			case 0x26:      /* ES */              break;
+			case 0x36:      /* SS */              break;
+			case 0x65:      /* GS */              break;
+			case 0x64:      /* FS */              break;
+			case 0xf2:      /* repnz */	      break;
+			case 0xf3:      /* rep */             break;
+			default: pref_done = 1;
+		}
+	} while (!pref_done);
 
-	/* operand size override */
-	case 0x66:
-		switch (popb(csp, ip, simulate_sigsegv)) {
+	switch (opcode) {
 
-		/* pushfd */
-		case 0x9c:
+	/* pushf */
+	case 0x9c:
+		if (data32) {
 			pushl(ssp, sp, get_vflags(regs), simulate_sigsegv);
 			SP(regs) -= 4;
-			IP(regs) += 2;
-			VM86_FAULT_RETURN;
-
-		/* popfd */
-		case 0x9d:
-			{
-			unsigned long newflags=popl(ssp, sp, simulate_sigsegv);
-			SP(regs) += 4;
-			IP(regs) += 2;
-			CHECK_IF_IN_TRAP;
-			set_vflags_long(newflags, regs);
-			VM86_FAULT_RETURN;
-			}
-
-		/* iretd */
-		case 0xcf:
-			{
-			unsigned long newip=popl(ssp, sp, simulate_sigsegv);
-			unsigned long newcs=popl(ssp, sp, simulate_sigsegv);
-			unsigned long newflags=popl(ssp, sp, simulate_sigsegv);
-			SP(regs) += 12;
-			IP(regs) = (unsigned short)newip;
-			regs->cs = (unsigned short)newcs;
-			CHECK_IF_IN_TRAP;
-			set_vflags_long(newflags, regs);
-			VM86_FAULT_RETURN;
-			}
-		/* need this to avoid a fallthrough */
-		default:
-			return_to_32bit(regs, VM86_UNKNOWN);
+		} else {
+			pushw(ssp, sp, get_vflags(regs), simulate_sigsegv);
+			SP(regs) -= 2;
 		}
-
-	/* pushf */
-	case 0x9c:
-		pushw(ssp, sp, get_vflags(regs), simulate_sigsegv);
-		SP(regs) -= 2;
-		IP(regs)++;
+		IP(regs) = ip;
 		VM86_FAULT_RETURN;
 
 	/* popf */
 	case 0x9d:
 		{
-		unsigned short newflags=popw(ssp, sp, simulate_sigsegv);
-		SP(regs) += 2;
-		IP(regs)++;
+		unsigned long newflags;
+		if (data32) {
+			newflags=popl(ssp, sp, simulate_sigsegv);
+			SP(regs) += 4;
+		} else {
+			newflags = popw(ssp, sp, simulate_sigsegv);
+			SP(regs) += 2;
+		}
+		IP(regs) = ip;
 		CHECK_IF_IN_TRAP;
-		set_vflags_short(newflags, regs);
+		if (data32) {
+			set_vflags_long(newflags, regs);
+		} else {
+			set_vflags_short(newflags, regs);
+		}
 		VM86_FAULT_RETURN;
 		}
 
 	/* int xx */
 	case 0xcd: {
 	        int intno=popb(csp, ip, simulate_sigsegv);
-		IP(regs) += 2;
+		IP(regs) = ip;
 		if (VMPI.vm86dbg_active) {
 			if ( (1 << (intno &7)) & VMPI.vm86dbg_intxxtab[intno >> 3] )
 				return_to_32bit(regs, VM86_INTx + (intno << 8));
@@ -593,20 +593,34 @@
 	/* iret */
 	case 0xcf:
 		{
-		unsigned short newip=popw(ssp, sp, simulate_sigsegv);
-		unsigned short newcs=popw(ssp, sp, simulate_sigsegv);
-		unsigned short newflags=popw(ssp, sp, simulate_sigsegv);
-		SP(regs) += 6;
+		unsigned long newip;
+		unsigned long newcs;
+		unsigned long newflags;
+		if (data32) {
+			newip=popl(ssp, sp, simulate_sigsegv);
+			newcs=popl(ssp, sp, simulate_sigsegv);
+			newflags=popl(ssp, sp, simulate_sigsegv);
+			SP(regs) += 12;
+		} else {
+			newip = popw(ssp, sp, simulate_sigsegv);
+			newcs = popw(ssp, sp, simulate_sigsegv);
+			newflags = popw(ssp, sp, simulate_sigsegv);
+			SP(regs) += 6;
+		}
 		IP(regs) = newip;
 		regs->cs = newcs;
 		CHECK_IF_IN_TRAP;
-		set_vflags_short(newflags, regs);
+		if (data32) {
+			set_vflags_long(newflags, regs);
+		} else {
+			set_vflags_short(newflags, regs);
+		}
 		VM86_FAULT_RETURN;
 		}
 
 	/* cli */
 	case 0xfa:
-		IP(regs)++;
+		IP(regs) = ip;
 		clear_IF(regs);
 		VM86_FAULT_RETURN;
 
@@ -618,7 +632,7 @@
 	 * Probably needs some horsing around with the TF flag. Aiee..
 	 */
 	case 0xfb:
-		IP(regs)++;
+		IP(regs) = ip;
 		set_IF(regs);
 		VM86_FAULT_RETURN;
 

--------------040401070707020306080609--

