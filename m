Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263134AbUFCKhN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263134AbUFCKhN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 06:37:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263162AbUFCKhN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 06:37:13 -0400
Received: from ozlabs.org ([203.10.76.45]:12693 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S263134AbUFCKhM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 06:37:12 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16574.65100.200483.993848@cargo.ozlabs.ibm.com>
Date: Thu, 3 Jun 2004 20:32:44 +1000
From: Paul Mackerras <paulus@samba.org>
To: akpm@osdl.org, torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, benh@kernel.crashing.org,
       trini@kernel.crashing.org
Subject: [PATCH][PPC32] Don't synchronize in disable_irq() if no handler
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is the ppc32 counterpart to a fix that went into
arch/i386/kernel/irq.c last October.  The bug was noted by Al Viro: if
no handler exists, and we have IRQ_INPROGRESS set because of an
earlier irq that got through, synchronize_irq() will end up waiting
forever.

Signed-off-by: Paul Mackerras <paulus@samba.org>

diff -urN linux-2.5/arch/ppc/kernel/irq.c pmac-2.5/arch/ppc/kernel/irq.c
--- linux-2.5/arch/ppc/kernel/irq.c	2004-02-23 12:05:11.000000000 +1100
+++ pmac-2.5/arch/ppc/kernel/irq.c	2004-03-11 16:49:24.000000000 +1100
@@ -304,8 +304,10 @@
 
 void disable_irq(unsigned int irq)
 {
+	irq_desc_t *desc = irq_desc + irq;
 	disable_irq_nosync(irq);
-	synchronize_irq(irq);
+	if (desc->action)
+		synchronize_irq(irq);
 }
 
 /**
