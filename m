Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262321AbUCHCpw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Mar 2004 21:45:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262374AbUCHCpv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Mar 2004 21:45:51 -0500
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:18869 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S262321AbUCHCpm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Mar 2004 21:45:42 -0500
Date: Mon, 08 Mar 2004 11:49:10 +0900
From: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Subject: [PATCH] fix PCI interrupt setting for ia64
To: linux-ia64@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Message-id: <MDEEKOKJPMPMKGHIFAMAKECGDGAA.kaneshige.kenji@jp.fujitsu.com>
MIME-version: 1.0
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
Content-type: text/plain;	charset="iso-2022-jp"
Content-transfer-encoding: 7bit
Importance: Normal
X-Priority: 3 (Normal)
X-MSMail-priority: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

In ia64 kernel, IOSAPIC's RTEs for PCI interrupts are unmasked at the
boot time before installing device drivers. I think it is very dangerous.
If some PCI devices without device driver generate interrupts, interrupts
are generated repeatedly because these interrupt requests are never
cleared. I think RTEs for PCI interrupts should be unmasked by device
driver.

A following patch fixes this issue.

Regards,
Kenji Kaneshige


diff -Naur linux-2.6.4-rc2/arch/ia64/kernel/iosapic.c
linux-2.6.4-rc2-changed/arch/ia64/kernel/iosapic.c
--- linux-2.6.4-rc2/arch/ia64/kernel/iosapic.c  2004-03-05
15:13:53.155237277 +0900
+++ linux-2.6.4-rc2-changed/arch/ia64/kernel/iosapic.c  2004-03-05
16:48:31.856142526 +0900
@@ -170,7 +170,7 @@
 }

 static void
-set_rte (unsigned int vector, unsigned int dest)
+set_rte (unsigned int vector, unsigned int dest, int mask)
 {
        unsigned long pol, trigger, dmode;
        u32 low32, high32;
@@ -205,6 +205,7 @@
        low32 = ((pol << IOSAPIC_POLARITY_SHIFT) |
                 (trigger << IOSAPIC_TRIGGER_SHIFT) |
                 (dmode << IOSAPIC_DELIVERY_SHIFT) |
+                ((mask ? 1 : 0) << IOSAPIC_MASK_SHIFT) |
                 vector);

        /* dest contains both id and eid */
@@ -509,7 +510,7 @@
               (trigger == IOSAPIC_EDGE ? "edge" : "level"), dest, vector);

        /* program the IOSAPIC routing table */
-       set_rte(vector, dest);
+       set_rte(vector, dest, 0);
        return vector;
 }

@@ -557,7 +558,7 @@
               (trigger == IOSAPIC_EDGE ? "edge" : "level"), dest, vector);

        /* program the IOSAPIC routing table */
-       set_rte(vector, dest);
+       set_rte(vector, dest, 0);
        return vector;
 }

@@ -583,7 +584,7 @@
            trigger == IOSAPIC_EDGE ? "edge" : "level", dest, vector);

        /* program the IOSAPIC routing table */
-       set_rte(vector, dest);
+       set_rte(vector, dest, 0);
 }

 void __init
@@ -669,7 +670,7 @@
        /* direct the interrupt vector to the running cpu id */
        dest = (ia64_getreg(_IA64_REG_CR_LID) >> 16) & 0xffff;
 #endif
-       set_rte(vector, dest);
+       set_rte(vector, dest, 1);

        printk(KERN_INFO "IOSAPIC: vector %d -> CPU 0x%04x, enabled\n",
               vector, dest);

