Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288595AbSBIIMA>; Sat, 9 Feb 2002 03:12:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288622AbSBIILv>; Sat, 9 Feb 2002 03:11:51 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:42851 "EHLO
	svldns02.veritas.com") by vger.kernel.org with ESMTP
	id <S288595AbSBIILq>; Sat, 9 Feb 2002 03:11:46 -0500
Date: Sat, 9 Feb 2002 08:13:12 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
To: Andrew Morton <akpm@zip.com.au>
cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        Linus Torvalds <torvalds@transmeta.com>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] BUG preserve registers
Message-ID: <Pine.LNX.4.21.0202090808390.872-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It's frustrating that when Verbose BUG() reporting is configured,
info gets lost: fix for i386 below.  This is your area, Andrew:
please confirm to Marcelo if you'd like him to apply this.

Example: in hpa's recent prune_dcache crash, %eax showed the length of
the kernel BUG printk, when we'd have liked to see the invalid d_count:
off-by-one or obviously corrupted?

Hugh

--- 2.4.18-pre9/arch/i386/kernel/entry.S	Thu Feb  7 14:38:06 2002
+++ linux/arch/i386/kernel/entry.S	Fri Feb  8 21:47:39 2002
@@ -132,6 +132,30 @@
 	movl $-8192, reg; \
 	andl %esp, reg
 
+#ifdef CONFIG_DEBUG_BUGVERBOSE
+BUG_format:
+	.asciz "kernel BUG at %s:%d!\n"
+ENTRY(do_BUG)
+	pushfl			# Save flags and registers changed in C
+	pushl %eax
+	pushl %ecx
+	pushl %edx
+	pushl $1
+	call SYMBOL_NAME(bust_spinlocks)
+	movl 28(%esp),%eax
+	movl 24(%esp),%ecx
+	pushl %eax
+	pushl %ecx
+	pushl $BUG_format
+	call SYMBOL_NAME(printk)
+	addl $16,%esp
+	popl %edx		# Restore registers and flags for display
+	popl %ecx
+	popl %eax
+	popfl
+	ret
+#endif /* CONFIG_DEBUG_BUGVERBOSE */
+
 ENTRY(lcall7)
 	pushfl			# We get a different stack layout with call gates,
 	pushl %eax		# which has to be cleaned up later..
--- 2.4.18-pre9/arch/i386/mm/fault.c	Thu Feb  7 14:38:07 2002
+++ linux/arch/i386/mm/fault.c	Fri Feb  8 19:06:45 2002
@@ -125,12 +125,6 @@
 	}
 }
 
-void do_BUG(const char *file, int line)
-{
-	bust_spinlocks(1);
-	printk("kernel BUG at %s:%d!\n", file, line);
-}
-
 asmlinkage void do_invalid_op(struct pt_regs *, unsigned long);
 extern unsigned long idt;
 

