Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262178AbVCHXc0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262178AbVCHXc0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 18:32:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262162AbVCHX3T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 18:29:19 -0500
Received: from mail.netilla.com ([63.97.64.130]:65059 "EHLO mail.netilla.com")
	by vger.kernel.org with ESMTP id S262166AbVCHXWb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 18:22:31 -0500
Subject: e1000 driver and interrupt registration
From: Devin Heitmueller <devin.heitmueller@aepnetworks.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: AEP Networks Inc.
Date: Tue, 08 Mar 2005 18:22:25 -0500
Message-Id: <1110324145.8711.63.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 08 Mar 2005 23:22:25.0612 (UTC) FILETIME=[B01770C0:01C52435]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I recently upgraded to 2.4.29 from 2.4.21 and see that the interrupt of
the e1000 device is not being shown when running /sbin/ifconfig.

It would appear that in version 1.56 of e1000_main.c, the e1000_probe
function was modified to store the IRQ of the device in pdev->irq
instead of netdev->irq.

http://linux.bkbits.net:8080/linux-2.4/diffs/drivers/net/e1000/e1000_main.c@1.56?nav=index.html|src/|src/drivers|src/drivers/net|src/drivers/net/e1000|hist/drivers/net/e1000/e1000_main.c

According to the log, this was done "in preparation for MSI support".
However, it would appear that no other Ethernet driver does this.  As a
result, the value is not present in the netdev->irq field, and hence the
SIOCGIFMAP ioctl call does not include the interrupt.

Is this expected behavior?  It would appear that this is a backport from
2.6, so perhaps it should not work this way in stable 2.4 kernels.

Is there any harm in also including the IRQ in the netdev struct, as I
have applications that expect this (such as ifconfig)?

The following patch appears to fix the issue.  I'm just not sure if it
breaks anything else:

--- linux-2.4.29/drivers/net/e1000/e1000_main.c Wed Jan 19 09:09:56 2005
+++ kernel/drivers/net/e1000/e1000_main.c       Tue Mar  8 16:13:46 2005
@@ -485,6 +485,9 @@
 #endif
        strcpy(netdev->name, pci_name(pdev));

+       netdev->irq = pdev->irq;
+
        netdev->mem_start = mmio_start;
        netdev->mem_end = mmio_start + mmio_len;
        netdev->base_addr = adapter->hw.io_base;

Thanks in advance,

-- 
Devin Heitmueller
Senior Software Engineer
AEP Networks, Inc. (formerly Netilla)

