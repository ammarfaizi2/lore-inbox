Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751942AbWFWSnv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751942AbWFWSnv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 14:43:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751917AbWFWSl5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 14:41:57 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:17359 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1751914AbWFWSlu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 14:41:50 -0400
Message-Id: <20060623183911.475146000@linux-m68k.org>
References: <20060623183056.479024000@linux-m68k.org>
User-Agent: quilt/0.44-1
Date: Fri, 23 Jun 2006 20:31:03 +0200
From: zippel@linux-m68k.org
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 07/21] fix show_registers()
Content-Disposition: inline; filename=0007-M68K-fix-show_registers.txt
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Move some of the prints in die_if_kernel() to show_registers() and call
that instead of show_stack(), so show_registers() prints now similiar
info as other archs. Clean up the function a little.

Signed-off-by: Roman Zippel <zippel@linux-m68k.org>

---

 arch/m68k/kernel/traps.c |  126 +++++++++++++++++++++++++---------------------
 1 files changed, 68 insertions(+), 58 deletions(-)

6288752cb5d99b7f532d9231248637ccad4b447f
diff --git a/arch/m68k/kernel/traps.c b/arch/m68k/kernel/traps.c
index 837a887..9adf378 100644
--- a/arch/m68k/kernel/traps.c
+++ b/arch/m68k/kernel/traps.c
@@ -927,66 +927,88 @@ #endif
 void show_registers(struct pt_regs *regs)
 {
 	struct frame *fp = (struct frame *)regs;
+	mm_segment_t old_fs = get_fs();
+	u16 c, *cp;
 	unsigned long addr;
 	int i;
 
+	print_modules();
+	printk("PC: [<%08lx>]",regs->pc);
+	print_symbol(" %s", regs->pc);
+	printk("\nSR: %04x  SP: %p  a2: %08lx\n",
+	       regs->sr, regs, regs->a2);
+	printk("d0: %08lx    d1: %08lx    d2: %08lx    d3: %08lx\n",
+	       regs->d0, regs->d1, regs->d2, regs->d3);
+	printk("d4: %08lx    d5: %08lx    a0: %08lx    a1: %08lx\n",
+	       regs->d4, regs->d5, regs->a0, regs->a1);
+
+	printk("Process %s (pid: %d, task=%p)\n",
+		current->comm, current->pid, current);
 	addr = (unsigned long)&fp->un;
-	printk("Frame format=%X ", fp->ptregs.format);
-	switch (fp->ptregs.format) {
+	printk("Frame format=%X ", regs->format);
+	switch (regs->format) {
 	case 0x2:
-	    printk("instr addr=%08lx\n", fp->un.fmt2.iaddr);
-	    addr += sizeof(fp->un.fmt2);
-	    break;
+		printk("instr addr=%08lx\n", fp->un.fmt2.iaddr);
+		addr += sizeof(fp->un.fmt2);
+		break;
 	case 0x3:
-	    printk("eff addr=%08lx\n", fp->un.fmt3.effaddr);
-	    addr += sizeof(fp->un.fmt3);
-	    break;
+		printk("eff addr=%08lx\n", fp->un.fmt3.effaddr);
+		addr += sizeof(fp->un.fmt3);
+		break;
 	case 0x4:
-	    printk((CPU_IS_060 ? "fault addr=%08lx fslw=%08lx\n"
-		    : "eff addr=%08lx pc=%08lx\n"),
-		   fp->un.fmt4.effaddr, fp->un.fmt4.pc);
-	    addr += sizeof(fp->un.fmt4);
-	    break;
+		printk((CPU_IS_060 ? "fault addr=%08lx fslw=%08lx\n"
+			: "eff addr=%08lx pc=%08lx\n"),
+			fp->un.fmt4.effaddr, fp->un.fmt4.pc);
+		addr += sizeof(fp->un.fmt4);
+		break;
 	case 0x7:
-	    printk("eff addr=%08lx ssw=%04x faddr=%08lx\n",
-		   fp->un.fmt7.effaddr, fp->un.fmt7.ssw, fp->un.fmt7.faddr);
-	    printk("wb 1 stat/addr/data: %04x %08lx %08lx\n",
-		   fp->un.fmt7.wb1s, fp->un.fmt7.wb1a, fp->un.fmt7.wb1dpd0);
-	    printk("wb 2 stat/addr/data: %04x %08lx %08lx\n",
-		   fp->un.fmt7.wb2s, fp->un.fmt7.wb2a, fp->un.fmt7.wb2d);
-	    printk("wb 3 stat/addr/data: %04x %08lx %08lx\n",
-		   fp->un.fmt7.wb3s, fp->un.fmt7.wb3a, fp->un.fmt7.wb3d);
-	    printk("push data: %08lx %08lx %08lx %08lx\n",
-		   fp->un.fmt7.wb1dpd0, fp->un.fmt7.pd1, fp->un.fmt7.pd2,
-		   fp->un.fmt7.pd3);
-	    addr += sizeof(fp->un.fmt7);
-	    break;
+		printk("eff addr=%08lx ssw=%04x faddr=%08lx\n",
+			fp->un.fmt7.effaddr, fp->un.fmt7.ssw, fp->un.fmt7.faddr);
+		printk("wb 1 stat/addr/data: %04x %08lx %08lx\n",
+			fp->un.fmt7.wb1s, fp->un.fmt7.wb1a, fp->un.fmt7.wb1dpd0);
+		printk("wb 2 stat/addr/data: %04x %08lx %08lx\n",
+			fp->un.fmt7.wb2s, fp->un.fmt7.wb2a, fp->un.fmt7.wb2d);
+		printk("wb 3 stat/addr/data: %04x %08lx %08lx\n",
+			fp->un.fmt7.wb3s, fp->un.fmt7.wb3a, fp->un.fmt7.wb3d);
+		printk("push data: %08lx %08lx %08lx %08lx\n",
+			fp->un.fmt7.wb1dpd0, fp->un.fmt7.pd1, fp->un.fmt7.pd2,
+			fp->un.fmt7.pd3);
+		addr += sizeof(fp->un.fmt7);
+		break;
 	case 0x9:
-	    printk("instr addr=%08lx\n", fp->un.fmt9.iaddr);
-	    addr += sizeof(fp->un.fmt9);
-	    break;
+		printk("instr addr=%08lx\n", fp->un.fmt9.iaddr);
+		addr += sizeof(fp->un.fmt9);
+		break;
 	case 0xa:
-	    printk("ssw=%04x isc=%04x isb=%04x daddr=%08lx dobuf=%08lx\n",
-		   fp->un.fmta.ssw, fp->un.fmta.isc, fp->un.fmta.isb,
-		   fp->un.fmta.daddr, fp->un.fmta.dobuf);
-	    addr += sizeof(fp->un.fmta);
-	    break;
+		printk("ssw=%04x isc=%04x isb=%04x daddr=%08lx dobuf=%08lx\n",
+			fp->un.fmta.ssw, fp->un.fmta.isc, fp->un.fmta.isb,
+			fp->un.fmta.daddr, fp->un.fmta.dobuf);
+		addr += sizeof(fp->un.fmta);
+		break;
 	case 0xb:
-	    printk("ssw=%04x isc=%04x isb=%04x daddr=%08lx dobuf=%08lx\n",
-		   fp->un.fmtb.ssw, fp->un.fmtb.isc, fp->un.fmtb.isb,
-		   fp->un.fmtb.daddr, fp->un.fmtb.dobuf);
-	    printk("baddr=%08lx dibuf=%08lx ver=%x\n",
-		   fp->un.fmtb.baddr, fp->un.fmtb.dibuf, fp->un.fmtb.ver);
-	    addr += sizeof(fp->un.fmtb);
-	    break;
+		printk("ssw=%04x isc=%04x isb=%04x daddr=%08lx dobuf=%08lx\n",
+			fp->un.fmtb.ssw, fp->un.fmtb.isc, fp->un.fmtb.isb,
+			fp->un.fmtb.daddr, fp->un.fmtb.dobuf);
+		printk("baddr=%08lx dibuf=%08lx ver=%x\n",
+			fp->un.fmtb.baddr, fp->un.fmtb.dibuf, fp->un.fmtb.ver);
+		addr += sizeof(fp->un.fmtb);
+		break;
 	default:
-	    printk("\n");
+		printk("\n");
 	}
 	show_stack(NULL, (unsigned long *)addr);
 
-	printk("Code: ");
-	for (i = 0; i < 10; i++)
-		printk("%04x ", 0xffff & ((short *) fp->ptregs.pc)[i]);
+	printk("Code:");
+	set_fs(KERNEL_DS);
+	cp = (u16 *)regs->pc;
+	for (i = -8; i < 16; i++) {
+		if (get_user(c, cp + i) && i >= 0) {
+			printk(" Bad PC value.");
+			break;
+		}
+		printk(i ? " %04x" : " <%04x>", c);
+	}
+	set_fs(old_fs);
 	printk ("\n");
 }
 
@@ -1190,19 +1212,7 @@ void die_if_kernel (char *str, struct pt
 
 	console_verbose();
 	printk("%s: %08x\n",str,nr);
-	print_modules();
-	printk("PC: [<%08lx>]",fp->pc);
-	print_symbol(" %s\n", fp->pc);
-	printk("\nSR: %04x  SP: %p  a2: %08lx\n",
-	       fp->sr, fp, fp->a2);
-	printk("d0: %08lx    d1: %08lx    d2: %08lx    d3: %08lx\n",
-	       fp->d0, fp->d1, fp->d2, fp->d3);
-	printk("d4: %08lx    d5: %08lx    a0: %08lx    a1: %08lx\n",
-	       fp->d4, fp->d5, fp->a0, fp->a1);
-
-	printk("Process %s (pid: %d, stackpage=%08lx)\n",
-		current->comm, current->pid, PAGE_SIZE+(unsigned long)current);
-	show_stack(NULL, (unsigned long *)fp);
+	show_registers(fp);
 	do_exit(SIGSEGV);
 }
 
-- 
1.3.3

--

