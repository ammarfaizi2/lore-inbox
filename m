Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268574AbUGXNBy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268574AbUGXNBy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jul 2004 09:01:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268575AbUGXNBy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jul 2004 09:01:54 -0400
Received: from ozlabs.org ([203.10.76.45]:38088 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S268574AbUGXNBv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jul 2004 09:01:51 -0400
Date: Sat, 24 Jul 2004 22:59:37 +1000
From: Anton Blanchard <anton@samba.org>
To: torvalds@osdl.org
Cc: paulus@samba.org, torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] [ppc64] Exception path optimisations
Message-ID: <20040724125937.GH4556@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


- We were statically predicting syscalls would be 32bit which meant every
  64bit syscall was guaranteed to be mispredicted. Just let the hardware
  predict this one.

- We shouldnt use blrl for indirect function calls, it is unlikely to be
  predicted correctly and corrupts the link prediction stack. We should
  use bctrl instead.

- Statically predict a branch in the system call path, favouring calls from
  userspace.

- Remove static prediction in pagefault path, hardware prediction should do
  a better job here.

Signed-off-by: Anton Blanchard <anton@samba.org>

===== arch/ppc64/kernel/entry.S 1.41 vs edited =====
--- 1.41/arch/ppc64/kernel/entry.S	Thu Jun 17 15:48:02 2004
+++ edited/arch/ppc64/kernel/entry.S	Sat Jul 24 22:47:03 2004
@@ -132,7 +132,7 @@
  */
 	ld	r11,.SYS_CALL_TABLE@toc(2)
 	andi.	r10,r10,_TIF_32BIT
-	beq-	15f
+	beq	15f
 	ld	r11,.SYS_CALL_TABLE32@toc(2)
 	clrldi	r3,r3,32
 	clrldi	r4,r4,32
@@ -143,8 +143,8 @@
 15:
 	slwi	r0,r0,3
 	ldx	r10,r11,r0	/* Fetch system call handler [ptr] */
-	mtlr	r10
-	blrl			/* Call handler */
+	mtctr   r10
+	bctrl			/* Call handler */
 
 syscall_exit:
 #ifdef SHOW_SYSCALLS
@@ -182,7 +182,7 @@
 	stdcx.	r0,0,r1			/* to clear the reservation */
 	andi.	r6,r8,MSR_PR
 	ld	r4,_LINK(r1)
-	beq	1f			/* only restore r13 if */
+	beq-	1f			/* only restore r13 if */
 	ld	r13,GPR13(r1)		/* returning to usermode */
 1:	ld	r2,GPR2(r1)
 	ld	r1,GPR1(r1)
===== arch/ppc64/kernel/head.S 1.67 vs edited =====
--- 1.67/arch/ppc64/kernel/head.S	Mon Jul  5 20:27:11 2004
+++ edited/arch/ppc64/kernel/head.S	Sat Jul 24 22:47:03 2004
@@ -1028,7 +1028,7 @@
 	bl	.local_irq_restore
 	b	11f
 #else
-	beq+	fast_exception_return   /* Return from exception on success */
+	beq	fast_exception_return   /* Return from exception on success */
 	/* fall through */
 #endif
 

