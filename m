Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423031AbWJQEaB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423031AbWJQEaB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 00:30:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423028AbWJQEaA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 00:30:00 -0400
Received: from mail01.verismonetworks.com ([164.164.99.228]:12726 "EHLO
	mail01.verismonetworks.com") by vger.kernel.org with ESMTP
	id S1423031AbWJQE3i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 00:29:38 -0400
Subject: [PATCH 1/2] arch/i386/kernel/hpet.c: ioremap balanced with iounmap
From: Amol Lad <amol@verismonetworks.com>
To: venkatesh.pallipadi@intel.com
Cc: linux kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Tue, 17 Oct 2006 10:02:52 +0530
Message-Id: <1161059572.20400.28.camel@amol.verismonetworks.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ioremap must be balanced by an iounmap and failing to do so can result
in a memory leak.

Tested (compilation only):
- using allmodconfig
- making sure the files are compiling without any warning/error due to
new changes

Signed-off-by: Amol Lad <amol@verismonetworks.com>
---
diff -uprN -X linux-2.6.19-rc1-orig/Documentation/dontdiff linux-2.6.19-rc1-orig/arch/i386/kernel/hpet.c linux-2.6.19-rc1/arch/i386/kernel/hpet.c
--- linux-2.6.19-rc1-orig/arch/i386/kernel/hpet.c	2006-09-21 10:15:25.000000000 +0530
+++ linux-2.6.19-rc1/arch/i386/kernel/hpet.c	2006-10-05 18:32:34.000000000 +0530
@@ -34,6 +34,7 @@ static int __init init_hpet_clocksource(
 	unsigned long hpet_period;
 	void __iomem* hpet_base;
 	u64 tmp;
+	int err;
 
 	if (!is_hpet_enabled())
 		return -ENODEV;
@@ -61,7 +62,11 @@ static int __init init_hpet_clocksource(
 	do_div(tmp, FSEC_PER_NSEC);
 	clocksource_hpet.mult = (u32)tmp;
 
-	return clocksource_register(&clocksource_hpet);
+	err = clocksource_register(&clocksource_hpet);
+	if (err)
+		iounmap(hpet_base);
+
+	return err;
 }
 
 module_init(init_hpet_clocksource);


