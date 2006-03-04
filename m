Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932114AbWCDEKc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932114AbWCDEKc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 23:10:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751784AbWCDEKc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 23:10:32 -0500
Received: from e34.co.us.ibm.com ([32.97.110.152]:62169 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751783AbWCDEKb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 23:10:31 -0500
Subject: [-mm PATCH] time: i386 clocksource drivers - drop acpi_pm_buggy
	paranoia
From: john stultz <johnstul@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Adrian Bunk <bunk@stusta.de>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <1141444927.9727.110.camel@cog.beaverton.ibm.com>
References: <1141444689.9727.105.camel@cog.beaverton.ibm.com>
	 <1141444927.9727.110.camel@cog.beaverton.ibm.com>
Content-Type: text/plain
Date: Fri, 03 Mar 2006 20:10:29 -0800
Message-Id: <1141445429.9727.120.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	As pointed out by Adrian Bunk, I was a bit paranoid with the acpi_pm.c
code and included code to work around buggy chipset's acpi pm
implementations. Andi Kleen convinced me that its not worth punishing
all systems for it, so I left the code disabled thinking I'd re-enable
it via a DMI blacklist when problematic systems surfaced. However, since
the code is not enabled, this removes it from the patch, as it can be
easily re-added if such a system does show up.

thanks
-john

Signed-off-by: John Stultz <johnstul@us.ibm.com>

diff -ru mmmerge/drivers/clocksource/acpi_pm.c mytree/drivers/clocksource/acpi_pm.c
--- mmmerge/drivers/clocksource/acpi_pm.c	2006-03-03 19:44:22.000000000 -0800
+++ mytree/drivers/clocksource/acpi_pm.c	2006-03-03 19:44:45.000000000 -0800
@@ -30,7 +30,6 @@
  * in arch/i386/acpi/boot.c
  */
 u32 pmtmr_ioport;
-int acpi_pmtmr_buggy;
 
 #define ACPI_PM_MASK 0xFFFFFF /* limit it to 24 bits */
 
@@ -40,26 +39,6 @@
 	return inl(pmtmr_ioport) & ACPI_PM_MASK;
 }
 
-static cycle_t acpi_pm_read_verified(void)
-{
-	u32 v1 = 0, v2 = 0, v3 = 0;
-
-	/*
-	 * It has been reported that because of various broken
-	 * chipsets (ICH4, PIIX4 and PIIX4E) where the ACPI PM clock
-	 * source is not latched, so you must read it multiple
-	 * times to ensure a safe value is read:
-	 */
-	do {
-		v1 = read_pmtmr();
-		v2 = read_pmtmr();
-		v3 = read_pmtmr();
-	} while ((v1 > v2 && v1 < v3) || (v2 > v3 && v2 < v1)
-			|| (v3 > v1 && v3 < v2));
-
-	return (cycle_t)v2;
-}
-
 static cycle_t acpi_pm_read(void)
 {
 	return (cycle_t)read_pmtmr();
@@ -104,12 +83,6 @@
 
 pm_good:
 
-	/* check to see if pmtmr is known buggy: */
-	if (acpi_pmtmr_buggy) {
-		clocksource_acpi_pm.read = acpi_pm_read_verified;
-		clocksource_acpi_pm.rating = 110;
-	}
-
 	return register_clocksource(&clocksource_acpi_pm);
 }
 





