Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265444AbUAAUqq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jan 2004 15:46:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264568AbUAAUEk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jan 2004 15:04:40 -0500
Received: from amsfep13-int.chello.nl ([213.46.243.24]:11305 "EHLO
	amsfep13-int.chello.nl") by vger.kernel.org with ESMTP
	id S264575AbUAAUBx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jan 2004 15:01:53 -0500
Date: Thu, 1 Jan 2004 21:01:50 +0100
Message-Id: <200401012001.i01K1oZM031721@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 346] M68k RMW accesses
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

M68k: Avoid bus fault for certain RMW accesses (from Roman Zippel)

--- linux-2.6.0/arch/m68k/kernel/traps.c	8 Oct 2003 20:34:14 -0000	1.1.1.12
+++ linux-m68k-2.6.0/arch/m68k/kernel/traps.c	16 Oct 2003 21:13:34 -0000
@@ -583,12 +583,9 @@
 	unsigned short mmusr;
 	unsigned long addr, errorcode;
 	unsigned short ssw = fp->un.fmtb.ssw;
-	int user_space_fault = 1;
 #if DEBUG
 	unsigned long desc;
-#endif
 
-#if DEBUG
 	printk ("pid = %x  ", current->pid);
 	printk ("SSW=%#06x  ", ssw);
 
@@ -605,128 +602,116 @@
 			space_names[ssw & DFC], fp->ptregs.pc);
 #endif
 
-	if (fp->ptregs.sr & PS_S) {
-		/* kernel fault must be a data fault to user space */
-		if (! ((ssw & DF) && ((ssw & DFC) == USER_DATA))) {
-			/* instruction fault or kernel data fault! */
-			if (ssw & (FC | FB))
-				printk ("Instruction fault at %#010lx\n",
-					fp->ptregs.pc);
-			if (ssw & DF) {
-				printk ("Data %s fault at %#010lx in %s (pc=%#lx)\n",
-					ssw & RW ? "read" : "write",
-					fp->un.fmtb.daddr,
-					space_names[ssw & DFC], fp->ptregs.pc);
-			}
-			printk ("BAD KERNEL BUSERR\n");
-			die_if_kernel("Oops",&fp->ptregs,0);
-			force_sig(SIGKILL, current);
-			return;
-		}
-	} else {
-		/* user fault */
-		if (!(ssw & (FC | FB)) && !(ssw & DF))
-			/* not an instruction fault or data fault! BAD */
-			panic ("USER BUSERR w/o instruction or data fault");
-		user_space_fault = 1;
-#if DEBUG
-		printk("User space bus-error\n");
-#endif
-	}
-
 	/* ++andreas: If a data fault and an instruction fault happen
 	   at the same time map in both pages.  */
 
 	/* First handle the data fault, if any.  */
-	if (ssw & DF)
-	  {
-	    addr = fp->un.fmtb.daddr;
+	if (ssw & DF) {
+		addr = fp->un.fmtb.daddr;
 
-	    mmusr = MMU_I;
-	    if (user_space_fault) {
 #if DEBUG
-		    asm volatile ("ptestr #1,%2@,#7,%0\n\t"
-				  "pmove %/psr,%1@"
-				  : "=a&" (desc)
-				  : "a" (&temp), "a" (addr));
+		asm volatile ("ptestr %3,%2@,#7,%0\n\t"
+			      "pmove %%psr,%1@"
+			      : "=a&" (desc)
+			      : "a" (&temp), "a" (addr), "d" (ssw));
 #else
-		    asm volatile ("ptestr #1,%1@,#7\n\t"
-				  "pmove %/psr,%0@"
-				  : : "a" (&temp), "a" (addr));
-#endif
-		    mmusr = temp;
-	    }
-      
-#if DEBUG
-	    printk ("mmusr is %#x for addr %#lx in task %p\n",
-		    mmusr, addr, current);
-	    printk ("descriptor address is %#lx, contents %#lx\n",
-		    __va(desc), *(unsigned long *)__va(desc));
+		asm volatile ("ptestr %2,%1@,#7\n\t"
+			      "pmove %%psr,%0@"
+			      : : "a" (&temp), "a" (addr), "d" (ssw));
 #endif
+		mmusr = temp;
 
-	    errorcode = (mmusr & MMU_I) ? 0 : 1;
-	    if (!(ssw & RW) || (ssw & RM))
-		    errorcode |= 2;
-
-	    if (mmusr & (MMU_I | MMU_WP)) {
-		/* Don't try to do anything further if an exception was
-		   handled. */
-		if (do_page_fault (&fp->ptregs, addr, errorcode) < 0)
+#if DEBUG
+		printk("mmusr is %#x for addr %#lx in task %p\n",
+		       mmusr, addr, current);
+		printk("descriptor address is %#lx, contents %#lx\n",
+		       __va(desc), *(unsigned long *)__va(desc));
+#endif
+
+		errorcode = (mmusr & MMU_I) ? 0 : 1;
+		if (!(ssw & RW) || (ssw & RM))
+			errorcode |= 2;
+
+		if (mmusr & (MMU_I | MMU_WP)) {
+			if (ssw & 4) {
+				printk("Data %s fault at %#010lx in %s (pc=%#lx)\n",
+				       ssw & RW ? "read" : "write",
+				       fp->un.fmtb.daddr,
+				       space_names[ssw & DFC], fp->ptregs.pc);
+				goto buserr;
+			}
+			/* Don't try to do anything further if an exception was
+			   handled. */
+			if (do_page_fault (&fp->ptregs, addr, errorcode) < 0)
+				return;
+		} else if (!(mmusr & MMU_I)) {
+			/* propably a 020 cas fault */
+			if (!(ssw & RM))
+				printk("unexpected bus error (%#x,%#x)\n", ssw, mmusr);
+		} else if (mmusr & (MMU_B|MMU_L|MMU_S)) {
+			printk("invalid %s access at %#lx from pc %#lx\n",
+			       !(ssw & RW) ? "write" : "read", addr,
+			       fp->ptregs.pc);
+			die_if_kernel("Oops",&fp->ptregs,mmusr);
+			force_sig(SIGSEGV, current);
 			return;
-	    } else if (mmusr & (MMU_B|MMU_L|MMU_S)) {
-		    printk ("invalid %s access at %#lx from pc %#lx\n",
-			    !(ssw & RW) ? "write" : "read", addr,
-			    fp->ptregs.pc);
-		    die_if_kernel("Oops",&fp->ptregs,mmusr);
-		    force_sig(SIGSEGV, current);
-		    return;
-	    } else {
+		} else {
 #if 0
-		    static volatile long tlong;
+			static volatile long tlong;
 #endif
 
-		    printk ("weird %s access at %#lx from pc %#lx (ssw is %#x)\n",
-			    !(ssw & RW) ? "write" : "read", addr,
-			    fp->ptregs.pc, ssw);
-		    asm volatile ("ptestr #1,%1@,#0\n\t"
-				  "pmove %/psr,%0@"
-				  : /* no outputs */
-				  : "a" (&temp), "a" (addr));
-		    mmusr = temp;
+			printk("weird %s access at %#lx from pc %#lx (ssw is %#x)\n",
+			       !(ssw & RW) ? "write" : "read", addr,
+			       fp->ptregs.pc, ssw);
+			asm volatile ("ptestr #1,%1@,#0\n\t"
+				      "pmove %%psr,%0@"
+				      : /* no outputs */
+				      : "a" (&temp), "a" (addr));
+			mmusr = temp;
 
-		    printk ("level 0 mmusr is %#x\n", mmusr);
+			printk ("level 0 mmusr is %#x\n", mmusr);
 #if 0
-		    asm volatile ("pmove %/tt0,%0@"
-				  : /* no outputs */
-				  : "a" (&tlong));
-		    printk ("tt0 is %#lx, ", tlong);
-		    asm volatile ("pmove %/tt1,%0@"
-				  : /* no outputs */
-				  : "a" (&tlong));
-		    printk ("tt1 is %#lx\n", tlong);
+			asm volatile ("pmove %%tt0,%0@"
+				      : /* no outputs */
+				      : "a" (&tlong));
+			printk("tt0 is %#lx, ", tlong);
+			asm volatile ("pmove %%tt1,%0@"
+				      : /* no outputs */
+				      : "a" (&tlong));
+			printk("tt1 is %#lx\n", tlong);
 #endif
 #if DEBUG
-		    printk("Unknown SIGSEGV - 1\n");
+			printk("Unknown SIGSEGV - 1\n");
 #endif
-		    die_if_kernel("Oops",&fp->ptregs,mmusr);
-		    force_sig(SIGSEGV, current);
-		    return;
-	    }
-
-	    /* setup an ATC entry for the access about to be retried */
-	    if (!(ssw & RW))
-		    asm volatile ("ploadw %1,%0@" : /* no outputs */
-				  : "a" (addr), "d" (ssw));
-	    else
-		    asm volatile ("ploadr %1,%0@" : /* no outputs */
-				  : "a" (addr), "d" (ssw));
-	  }
+			die_if_kernel("Oops",&fp->ptregs,mmusr);
+			force_sig(SIGSEGV, current);
+			return;
+		}
+
+		/* setup an ATC entry for the access about to be retried */
+		if (!(ssw & RW) || (ssw & RM))
+			asm volatile ("ploadw %1,%0@" : /* no outputs */
+				      : "a" (addr), "d" (ssw));
+		else
+			asm volatile ("ploadr %1,%0@" : /* no outputs */
+				      : "a" (addr), "d" (ssw));
+	}
 
 	/* Now handle the instruction fault. */
 
 	if (!(ssw & (FC|FB)))
 		return;
 
+	if (fp->ptregs.sr & PS_S) {
+		printk("Instruction fault at %#010lx\n",
+			fp->ptregs.pc);
+	buserr:
+		printk ("BAD KERNEL BUSERR\n");
+		die_if_kernel("Oops",&fp->ptregs,0);
+		force_sig(SIGKILL, current);
+		return;
+	}
+
 	/* get the fault address */
 	if (fp->ptregs.format == 10)
 		addr = fp->ptregs.pc + 4;
@@ -740,21 +725,18 @@
 		   should still create the ATC entry.  */
 		goto create_atc_entry;
 
-	mmusr = MMU_I;
-	if (user_space_fault) {
 #if DEBUG
-		asm volatile ("ptestr #1,%2@,#7,%0\n\t"
-			      "pmove %/psr,%1@"
-			      : "=a&" (desc)
-			      : "a" (&temp), "a" (addr));
+	asm volatile ("ptestr #1,%2@,#7,%0\n\t"
+		      "pmove %%psr,%1@"
+		      : "=a&" (desc)
+		      : "a" (&temp), "a" (addr));
 #else
-		asm volatile ("ptestr #1,%1@,#7\n\t"
-			      "pmove %/psr,%0@"
-			      : : "a" (&temp), "a" (addr));
+	asm volatile ("ptestr #1,%1@,#7\n\t"
+		      "pmove %%psr,%0@"
+		      : : "a" (&temp), "a" (addr));
 #endif
-		mmusr = temp;
-	}
-      
+	mmusr = temp;
+
 #ifdef DEBUG
 	printk ("mmusr is %#x for addr %#lx in task %p\n",
 		mmusr, addr, current);

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
