Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932130AbWCWUkV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932130AbWCWUkV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 15:40:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751503AbWCWUkV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 15:40:21 -0500
Received: from moutng.kundenserver.de ([212.227.126.183]:46564 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1750922AbWCWUkU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 15:40:20 -0500
Message-Id: <20060323203521.975925000@dyn-9-152-242-103.boeblingen.de.ibm.com>
References: <20060323203423.620978000@dyn-9-152-242-103.boeblingen.de.ibm.com>
User-Agent: quilt/0.44-1
Date: Thu, 23 Mar 2006 00:00:07 +0100
From: Arnd Bergmann <abergman@de.ibm.com>
To: Paul Mackerras <paulus@samba.org>
Cc: cbe-oss-dev@ozlabs.org, linux-kernel@vger.kernel.org,
       linuxppc-dev@ozlabs.org, Arnd Bergmann <arnd.bergmann@de.ibm.com>
Subject: [patch 07/13] powerpc: work around a cell interrupt HW bug
Content-Disposition: inline; filename=irq-debug-2.diff
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Apparently we have found a bug in the CPU that causes
external interrupts to sometimes get disabled indefinitely.
This adds a workaround for the problem.

Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>

Index: linux-2.6.15.4/arch/powerpc/platforms/cell/interrupt.c
===================================================================
--- linux-2.6.15.4.orig/arch/powerpc/platforms/cell/interrupt.c
+++ linux-2.6.15.4/arch/powerpc/platforms/cell/interrupt.c
@@ -63,7 +63,24 @@ static DEFINE_PER_CPU(struct iic, iic);
 
 void iic_local_enable(void)
 {
-	out_be64(&__get_cpu_var(iic).regs->prio, 0xff);
+	struct iic *iic = &__get_cpu_var(iic);
+	u64 tmp;
+
+	/*
+	 * There seems to be a bug that is present in DD2.x CPUs
+	 * and still only partially fixed in DD3.1.
+	 * This bug causes a value written to the priority register
+	 * not to make it there, resulting in a system hang unless we
+	 * write it again.
+	 * Masking with 0xf0 is done because the Cell BE does not
+	 * implement the lower four bits of the interrupt priority,
+	 * they always read back as zeroes, although future CPUs
+	 * might implement different bits.
+	 */
+	do {
+		out_be64(&iic->regs->prio, 0xff);
+		tmp = in_be64(&iic->regs->prio);
+	} while ((tmp & 0xf0) != 0xf0);
 }
 
 void iic_local_disable(void)

--

