Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263188AbUFJWvf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263188AbUFJWvf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jun 2004 18:51:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263184AbUFJWvb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jun 2004 18:51:31 -0400
Received: from atlrel7.hp.com ([156.153.255.213]:23705 "EHLO atlrel7.hp.com")
	by vger.kernel.org with ESMTP id S263167AbUFJWv2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jun 2004 18:51:28 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: sboyce@blueyonder.co.uk
Subject: Re: 2.6.7-rc2-mm1 (nforce2 lockup)
Date: Thu, 10 Jun 2004 16:51:23 -0600
User-Agent: KMail/1.6.2
Cc: Len Brown <len.brown@intel.com>, linux-kernel@vger.kernel.org
References: <A6974D8E5F98D511BB910002A50A6647615FD33E@hdsmsx403.hd.intel.com> <200406050937.29163.bjorn.helgaas@hp.com> <40C2444B.4080403@blueyonder.co.uk>
In-Reply-To: <40C2444B.4080403@blueyonder.co.uk>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200406101651.23895.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sid,

Can you try the attached patch, please?  I reproduced the problem on
my Proliant DL360, and this patch fixes it for me.

The problem was that drivers/serial/8250_acpi.c found COM1 in the
ACPI namespace and called acpi_register_gsi() to set up its IRQ.
ACPI tells us that the COM1 IRQ is edge triggered, active high,
but acpi_register_gsi() was ignoring the edge_level argument,
so it blindly set the COM1 IRQ to be level-triggered.

This is against 2.6.7-rc3-mm1.

diff -u -Nur linux-2.6.7-rc3-mm1.orig/arch/i386/kernel/acpi/boot.c linux-2.6.7-rc3-mm1/arch/i386/kernel/acpi/boot.c
--- linux-2.6.7-rc3-mm1.orig/arch/i386/kernel/acpi/boot.c	2004-06-10 16:26:55.000000000 -0600
+++ linux-2.6.7-rc3-mm1/arch/i386/kernel/acpi/boot.c	2004-06-10 16:30:22.000000000 -0600
@@ -451,10 +451,12 @@
 		static u16 irq_mask;
 		extern void eisa_set_level_irq(unsigned int irq);
 
-		if ((gsi < 16) && !((1 << gsi) & irq_mask)) {
-			Dprintk(KERN_DEBUG PREFIX "Setting GSI %u as level-triggered\n", gsi);
-			irq_mask |= (1 << gsi);
-			eisa_set_level_irq(gsi);
+		if (edge_level == ACPI_LEVEL_SENSITIVE) {
+			if ((gsi < 16) && !((1 << gsi) & irq_mask)) {
+				Dprintk(KERN_DEBUG PREFIX "Setting GSI %u as level-triggered\n", gsi);
+				irq_mask |= (1 << gsi);
+				eisa_set_level_irq(gsi);
+			}
 		}
 	}
 #endif
