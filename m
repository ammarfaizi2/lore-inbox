Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263205AbUC3Fns (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 00:43:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263212AbUC3Fns
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 00:43:48 -0500
Received: from gate.crashing.org ([63.228.1.57]:56213 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S263205AbUC3FnW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 00:43:22 -0500
Subject: [PATCH] ppc64: Add a sync in context switch on SMP
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1080625392.1213.14.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 30 Mar 2004 15:43:13 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

For the same reason as ppc32, we need to ensure that all stores
done on a CPU has reached the coherency domain and are visible
to loads done by another CPU when context switching as the same
thread may be rescheduled almost right away there.

Ben.

diff -urN linux-2.5/arch/ppc64/kernel/entry.S linuxppc-2.5-benh/arch/ppc64/kernel/entry.S
--- linux-2.5/arch/ppc64/kernel/entry.S	2004-03-30 15:15:17.000000000 +1000
+++ linuxppc-2.5-benh/arch/ppc64/kernel/entry.S	2004-03-30 14:55:47.000000000 +1000
@@ -289,6 +289,14 @@
 	std	r23,_CCR(r1)
 	std	r1,KSP(r3)	/* Set old stack pointer */
 
+#ifdef CONFIG_SMP
+	/* We need a sync somewhere here to make sure that if the
+	 * previous task gets rescheduled on another CPU, it sees all
+	 * stores it has performed on this one.
+	 */
+	sync
+#endif /* CONFIG_SMP */
+
 	addi	r6,r4,-THREAD	/* Convert THREAD to 'current' */
 	std	r6,PACACURRENT(r13)	/* Set new 'current' */
 


