Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266258AbUANA1T (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jan 2004 19:27:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266268AbUANA1T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jan 2004 19:27:19 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:50859 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S266258AbUANA1M
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jan 2004 19:27:12 -0500
From: James Cleverdon <jamesclv@us.ibm.com>
Reply-To: jamesclv@us.ibm.com
Organization: IBM LTC
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH] 2.6.1-mm2: Get irq_vector size right for generic subarch UP installer kernels
Date: Tue, 13 Jan 2004 16:26:59 -0800
User-Agent: KMail/1.5
Cc: Chris McDermott <lcm@us.ibm.com>, "Martin J. Bligh" <mbligh@aracnet.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_WzIBAILudZL8oQ+"
Message-Id: <200401131627.02138.jamesclv@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_WzIBAILudZL8oQ+
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Problem:  Earlier I didn't consider the case of the generic sub-arch and 
uni-proc installer kernels used by a number of distros.  It currently is 
scaled by NR_CPUS.  The correct values should be big for summit and generic, 
and can stay the same for all others.


diff -pru 2.6.1-mm2/include/asm-i386/mach-default/irq_vectors.h 
t1mm2/include/asm-i386/mach-default/irq_vectors.h
--- 2.6.1-mm2/include/asm-i386/mach-default/irq_vectors.h	2004-01-08 
22:59:19.000000000 -0800
+++ t1mm2/include/asm-i386/mach-default/irq_vectors.h	2004-01-13 
13:43:56.000000000 -0800
@@ -90,8 +90,12 @@
 #else
 #ifdef CONFIG_X86_IO_APIC
 #define NR_IRQS 224
-# if (224 >= 32 * NR_CPUS)
-# define NR_IRQ_VECTORS NR_IRQS
+/*
+ * For Summit or generic (i.e. installer) kernels, we have lots of I/O APICs,
+ * even with uni-proc kernels, so use a big array.
+ */
+# if defined(CONFIG_X86_SUMMIT) || defined(CONFIG_X86_GENERICARCH)
+# define NR_IRQ_VECTORS 1024
 # else
 # define NR_IRQ_VECTORS (32 * NR_CPUS)
 # endif

--Boundary-00=_WzIBAILudZL8oQ+
Content-Type: text/x-diff;
  charset="us-ascii";
  name="irq_vector_2004-01-13_2.6.1-mm2"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="irq_vector_2004-01-13_2.6.1-mm2"

diff -pru 2.6.1-mm2/include/asm-i386/mach-default/irq_vectors.h t1mm2/include/asm-i386/mach-default/irq_vectors.h
--- 2.6.1-mm2/include/asm-i386/mach-default/irq_vectors.h	2004-01-08 22:59:19.000000000 -0800
+++ t1mm2/include/asm-i386/mach-default/irq_vectors.h	2004-01-13 13:43:56.000000000 -0800
@@ -90,8 +90,12 @@
 #else
 #ifdef CONFIG_X86_IO_APIC
 #define NR_IRQS 224
-# if (224 >= 32 * NR_CPUS)
-# define NR_IRQ_VECTORS NR_IRQS
+/*
+ * For Summit or generic (i.e. installer) kernels, we have lots of I/O APICs,
+ * even with uni-proc kernels, so use a big array.
+ */
+# if defined(CONFIG_X86_SUMMIT) || defined(CONFIG_X86_GENERICARCH)
+# define NR_IRQ_VECTORS 1024
 # else
 # define NR_IRQ_VECTORS (32 * NR_CPUS)
 # endif

--Boundary-00=_WzIBAILudZL8oQ+--

