Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261422AbUDIP5D (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Apr 2004 11:57:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261426AbUDIP5D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Apr 2004 11:57:03 -0400
Received: from zero.aec.at ([193.170.194.10]:54282 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S261422AbUDIP47 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Apr 2004 11:56:59 -0400
To: Christoph Terhechte <ct@fdk-berlin.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: powernow-k8: broken PSB
References: <1Gyjw-2iM-9@gated-at.bofh.it>
From: Andi Kleen <ak@muc.de>
Date: Fri, 09 Apr 2004 17:57:00 +0200
In-Reply-To: <1Gyjw-2iM-9@gated-at.bofh.it> (Christoph Terhechte's message
 of "Fri, 02 Apr 2004 17:00:18 +0200")
Message-ID: <m33c7dw3eb.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Terhechte <ct@fdk-berlin.de> writes:

> I'm running Gentoo Linux on an Athlon 64 system (board is Asus 8KV SE
> Deluxe). I was getting the "BIOS error - no PSB" message when trying to
> "modprobe powernow-k8", so I upgraded to 2.6.5-rc3-mm4 which includes
> Pavel Machek's new powernow-k8 driver. Theoretically, it should be
> getting tables through ACPI and ignore the legacy PST/PSB tables, but
> I'm still getting the same error as before and inserting powernow-k8
> fails with this message:
>
> FATAL: Error inserting powernow_k8
> (/lib/modules/2.6.5-rc3-mm4/kernel/arch/x86_64/cpufreq/powernow-k8.ko):
> No such device

You have ACPI disabled right? 

If yes this patch will fix it.

But you should enable it, otherwise the powernow driver works just like 
the old one.

-Andi

diff -u linux/drivers/acpi/processor.c-o linux/drivers/acpi/processor.c
--- linux/drivers/acpi/processor.c-o	2004-04-04 23:35:32.000000000 +0200
+++ linux/drivers/acpi/processor.c	2004-04-05 21:39:37.000000000 +0200
@@ -2372,6 +2372,10 @@
 }
 
 
+/* We keep the driver loaded even when ACPI is not running. 
+   This is needed for the powernow-k8 driver, that works even without
+   ACPI, but needs symbols from this driver */
+
 static int __init
 acpi_processor_init (void)
 {
@@ -2384,12 +2388,12 @@
 
 	acpi_processor_dir = proc_mkdir(ACPI_PROCESSOR_CLASS, acpi_root_dir);
 	if (!acpi_processor_dir)
-		return_VALUE(-ENODEV);
+		return_VALUE(0);
 
 	result = acpi_bus_register_driver(&acpi_processor_driver);
 	if (result < 0) {
 		remove_proc_entry(ACPI_PROCESSOR_CLASS, acpi_root_dir);
-		return_VALUE(-ENODEV);
+		return_VALUE(0);
 	}
 
 	acpi_thermal_cpufreq_init();




