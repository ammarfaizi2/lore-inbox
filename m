Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270012AbUIDB6Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270012AbUIDB6Y (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 21:58:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270014AbUIDB6Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 21:58:24 -0400
Received: from mx1.magmacom.com ([206.191.0.217]:59578 "EHLO mx1.magmacom.com")
	by vger.kernel.org with ESMTP id S270012AbUIDB6U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 21:58:20 -0400
Message-ID: <41392139.6010700@magma.ca>
Date: Fri, 03 Sep 2004 21:58:17 -0400
From: Nicholas Reilly <nreilly@magma.ca>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040819)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Fix for NForce2 secondary IDE getting wrong IRQ
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am not on the list so please cc me on replies.

I have a Shuttle SN41G2 and the secondary IDE channel alternates between 
IRQ 15 (correct) and IRQ 7 (causing failures accessing the DVD+-RW which 
is master, no slave and also messing with the parallel port if it is 
enabled) on each boot. This is running ACPI and APIC on 2.6.5, 2.6.7 and 
2.6.8. dmesg, dmidecode and /proc/acpi/dsdt are all identical (apart 
from dmesg printing of IRQ and errors it causes) regardless of whether 
it decides to go on 7 or 15. It is now running the latest BIOS, earlier 
BIOS did the same.

Comparing the amd74xx.c with piix.c suggests the following diff which 
works for me. MAINTAINERS doesn't list anyone for this driver and the 
file lists Vojtech Pavlik with no email address.

Regards,
Nick.

diff -u drivers/ide/pci/amd74xx.c ~/ide/amd74xx.c
--- drivers/ide/pci/amd74xx.c   2004-08-28 02:11:57.000000000 -0400
+++ /home/nreilly/ide/amd74xx.c 2004-09-03 21:21:30.000000000 -0400
@@ -443,6 +443,10 @@
                  hwif->autodma = 1;
          hwif->drives[0].autodma = hwif->autodma;
          hwif->drives[1].autodma = hwif->autodma;
+#ifndef CONFIG_IA64
+        if (!hwif->irq)
+                hwif->irq = hwif->channel ? 15 : 14;
+#endif /* CONFIG_IA64 */
  }

  #define DECLARE_AMD_DEV(name_str)                                      \
