Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266115AbUFXQ3v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266115AbUFXQ3v (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 12:29:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266117AbUFXQ3v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 12:29:51 -0400
Received: from gate.crashing.org ([63.228.1.57]:11707 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S266115AbUFXQ3t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 12:29:49 -0400
Subject: [PATCH] ppc64: Fix booting on LPAR machines with more than 1 CPU
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Paul Mackerras <paulus@samba.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1088094518.10281.11.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 24 Jun 2004 11:28:39 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

The exception rewrite contains a small bug that prevents bring up of CPUs
on logically partitioned machines. The kernel is trying to zero the backlink
on the new stack while running with relocation disabled, which potentially
cause it to try to access an address outside of the region allowed in
real mode. This seem to be a leftover from previous code as we also zero
the backlink later after turning off the MMU. This patch removes the
offending bit.

===== arch/ppc64/kernel/head.S 1.61 vs edited =====
--- 1.61/arch/ppc64/kernel/head.S	2004-06-17 00:46:06 -05:00
+++ edited/arch/ppc64/kernel/head.S	2004-06-24 11:25:41 -05:00
@@ -1833,8 +1833,6 @@
 	sldi	r28,r24,3		/* get current_set[cpu#] */
 	ldx	r1,r3,r28
 	addi	r1,r1,THREAD_SIZE-STACK_FRAME_OVERHEAD
-	li	r0,0
-	std	r0,0(r1)
 	std	r1,PACAKSAVE(r13)
 
 	ld	r3,PACASTABREAL(r13)    /* get raddr of segment table       */


