Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261454AbVBNPjE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261454AbVBNPjE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Feb 2005 10:39:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261451AbVBNPjE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Feb 2005 10:39:04 -0500
Received: from RT-soft-2.Moscow.itn.ru ([80.240.96.70]:51627 "HELO
	mail.dev.rtsoft.ru") by vger.kernel.org with SMTP id S261457AbVBNPhj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Feb 2005 10:37:39 -0500
Message-ID: <4210C801.2000204@ru.mvista.com>
Date: Mon, 14 Feb 2005 18:47:13 +0300
From: Andrei Konovalov <akonovalov@ru.mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: mporter@kernel.crashing.org
CC: linuxppc-embedded@ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH][PPC32] Move irq_desc[].status, IRQ_LEVEL bit setup to xilinx_pic.c
Content-Type: multipart/mixed;
 boundary="------------030809020300080903070107"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030809020300080903070107
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

This patch applies to the kernel 2.6.11-rc3.
It moves the code that informs the kernel if the particular interrupt is edge triggered
or level sensitive from the board specific file to a "CONFIG_VIRTEX_II_PRO-specific" file.
Using old IRQ numbering in that code is also fixed.

Signed-off-by: Andrei Konovalov <akonovalov@ru.mvista.com>


--------------030809020300080903070107
Content-Type: text/plain;
 name="xilinx_pic.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="xilinx_pic.diff"

diff -uprN linux-2.5.base/arch/ppc/platforms/4xx/xilinx_ml300.c linux-2.5.cur/arch/ppc/platforms/4xx/xilinx_ml300.c
--- linux-2.5.base/arch/ppc/platforms/4xx/xilinx_ml300.c	2005-02-11 17:19:08.000000000 +0300
+++ linux-2.5.cur/arch/ppc/platforms/4xx/xilinx_ml300.c	2005-02-14 18:37:26.000000000 +0300
@@ -122,25 +122,7 @@ ml300_setup_arch(void)
 void __init
 ml300_init_irq(void)
 {
-	unsigned int i;
-
 	ppc4xx_init_IRQ();
-
-	/*
-	 * For PowerPC 405 cores the default value for NR_IRQS is 32.
-	 * See include/asm-ppc/irq.h for details.
-	 * This is just fine for ML300.
-	 */
-#if (NR_IRQS != 32)
-#error NR_IRQS must be 32 for ML300
-#endif
-
-	for (i = 0; i < NR_IRQS; i++) {
-		if (XPAR_INTC_0_KIND_OF_INTR & (0x80000000 >> i))
-			irq_desc[i].status &= ~IRQ_LEVEL;
-		else
-			irq_desc[i].status |= IRQ_LEVEL;
-	}
 }
 
 void __init
diff -uprN linux-2.5.base/arch/ppc/syslib/xilinx_pic.c linux-2.5.cur/arch/ppc/syslib/xilinx_pic.c
--- linux-2.5.base/arch/ppc/syslib/xilinx_pic.c	2005-02-11 17:20:49.000000000 +0300
+++ linux-2.5.cur/arch/ppc/syslib/xilinx_pic.c	2005-02-14 16:57:40.000000000 +0300
@@ -114,6 +114,14 @@ ppc4xx_pic_init(void)
 {
 	int i;
 
+	/*
+	 * NOTE: The assumption here is that NR_IRQS is 32 or less
+	 * (NR_IRQS is 32 for PowerPC 405 cores by default).
+	 */
+#if (NR_IRQS > 32)
+#error NR_IRQS > 32 not supported
+#endif
+
 #if XPAR_XINTC_USE_DCR == 0
 	intc = ioremap(XPAR_INTC_0_BASEADDR, 32);
 
@@ -138,6 +146,12 @@ ppc4xx_pic_init(void)
 
 	ppc_md.get_irq = xilinx_pic_get_irq;
 
-	for (i = 0; i < NR_IRQS; ++i)
+	for (i = 0; i < NR_IRQS; ++i) {
 		irq_desc[i].handler = &xilinx_intc;
+
+		if (XPAR_INTC_0_KIND_OF_INTR & (0x00000001 << i))
+			irq_desc[i].status &= ~IRQ_LEVEL;
+		else
+			irq_desc[i].status |= IRQ_LEVEL;
+	}
 }

--------------030809020300080903070107--

