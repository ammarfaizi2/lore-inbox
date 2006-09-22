Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932321AbWIVL6c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932321AbWIVL6c (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 07:58:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932324AbWIVL6c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 07:58:32 -0400
Received: from ozlabs.org ([203.10.76.45]:32748 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S932321AbWIVL6b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 07:58:31 -0400
Subject: [PATCH 4/7] Fix places where using %gs changes the usermode ABI.
From: Rusty Russell <rusty@rustcorp.com.au>
To: Andi Kleen <ak@muc.de>
Cc: lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       virtualization <virtualization@lists.osdl.org>,
       Jeremy Fitzhardinge <jeremy@goop.org>
In-Reply-To: <1158926215.26261.11.camel@localhost.localdomain>
References: <1158925861.26261.3.camel@localhost.localdomain>
	 <1158925997.26261.6.camel@localhost.localdomain>
	 <1158926106.26261.8.camel@localhost.localdomain>
	 <1158926215.26261.11.camel@localhost.localdomain>
Content-Type: text/plain
Date: Fri, 22 Sep 2006 21:58:28 +1000
Message-Id: <1158926308.26261.14.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There are a few places where the change in struct pt_regs and the use
of %gs affect the userspace ABI.  These are primarily debugging
interfaces where thread state can be inspected or extracted.

Signed-off-by: Jeremy Fitzhardinge <jeremy@xensource.com>
Signed-off-by: Andi Kleen <ak@suse.de>
Cc: Chuck Ebbert <76306.1226@compuserve.com>
Cc: Zachary Amsden <zach@vmware.com>
Cc: Jan Beulich <jbeulich@novell.com>
Cc: Andi Kleen <ak@suse.de>
Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>

Index: ak-pda-gs/arch/i386/kernel/process.c
===================================================================
--- ak-pda-gs.orig/arch/i386/kernel/process.c	2006-09-20 16:40:18.000000000 +1000
+++ ak-pda-gs/arch/i386/kernel/process.c	2006-09-20 16:46:40.000000000 +1000
@@ -304,8 +304,8 @@
 		regs->eax,regs->ebx,regs->ecx,regs->edx);
 	printk("ESI: %08lx EDI: %08lx EBP: %08lx",
 		regs->esi, regs->edi, regs->ebp);
-	printk(" DS: %04x ES: %04x\n",
-		0xffff & regs->xds,0xffff & regs->xes);
+	printk(" DS: %04x ES: %04x GS: %04x\n",
+	       0xffff & regs->xds,0xffff & regs->xes, 0xffff & regs->xgs);
 
 	cr0 = read_cr0();
 	cr2 = read_cr2();
@@ -499,7 +499,7 @@
 	dump->regs.ds = regs->xds;
 	dump->regs.es = regs->xes;
 	savesegment(fs,dump->regs.fs);
-	savesegment(gs,dump->regs.gs);
+	dump->regs.gs = regs->xgs;
 	dump->regs.orig_eax = regs->orig_eax;
 	dump->regs.eip = regs->eip;
 	dump->regs.cs = regs->xcs;
Index: ak-pda-gs/arch/i386/kernel/ptrace.c
===================================================================
--- ak-pda-gs.orig/arch/i386/kernel/ptrace.c	2006-09-20 15:33:57.000000000 +1000
+++ ak-pda-gs/arch/i386/kernel/ptrace.c	2006-09-20 16:46:40.000000000 +1000
@@ -94,13 +94,9 @@
 				return -EIO;
 			child->thread.fs = value;
 			return 0;
-		case GS:
-			if (value && (value & 3) != 3)
-				return -EIO;
-			child->thread.gs = value;
-			return 0;
 		case DS:
 		case ES:
+		case GS:
 			if (value && (value & 3) != 3)
 				return -EIO;
 			value &= 0xffff;
@@ -116,8 +112,8 @@
 			value |= get_stack_long(child, EFL_OFFSET) & ~FLAG_MASK;
 			break;
 	}
-	if (regno > GS*4)
-		regno -= 2*4;
+	if (regno > ES*4)
+		regno -= 1*4;
 	put_stack_long(child, regno - sizeof(struct pt_regs), value);
 	return 0;
 }
@@ -131,18 +127,16 @@
 		case FS:
 			retval = child->thread.fs;
 			break;
-		case GS:
-			retval = child->thread.gs;
-			break;
 		case DS:
 		case ES:
+		case GS:
 		case SS:
 		case CS:
 			retval = 0xffff;
 			/* fall through */
 		default:
-			if (regno > GS*4)
-				regno -= 2*4;
+			if (regno > ES*4)
+				regno -= 1*4;
 			regno = regno - sizeof(struct pt_regs);
 			retval &= get_stack_long(child, regno);
 	}
Index: ak-pda-gs/include/asm-i386/elf.h
===================================================================
--- ak-pda-gs.orig/include/asm-i386/elf.h	2006-09-20 15:33:57.000000000 +1000
+++ ak-pda-gs/include/asm-i386/elf.h	2006-09-20 16:46:40.000000000 +1000
@@ -91,7 +91,7 @@
 	pr_reg[7] = regs->xds;				\
 	pr_reg[8] = regs->xes;				\
 	savesegment(fs,pr_reg[9]);			\
-	savesegment(gs,pr_reg[10]);			\
+	pr_reg[10] = regs->xgs;				\
 	pr_reg[11] = regs->orig_eax;			\
 	pr_reg[12] = regs->eip;				\
 	pr_reg[13] = regs->xcs;				\

-- 
Help! Save Australia from the worst of the DMCA: http://linux.org.au/law

