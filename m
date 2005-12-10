Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964926AbVLJHC3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964926AbVLJHC3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Dec 2005 02:02:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964927AbVLJHC3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Dec 2005 02:02:29 -0500
Received: from mx1.redhat.com ([66.187.233.31]:21691 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S964926AbVLJHC3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Dec 2005 02:02:29 -0500
Date: Sat, 10 Dec 2005 02:02:12 -0500
From: Dave Jones <davej@redhat.com>
To: acpi-devel@lists.sourceforge.net
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: ACPI sleeping whilst atomic warnings on resume.
Message-ID: <20051210070212.GA28005@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	acpi-devel@lists.sourceforge.net,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This has been broken for months.  On resume, we call acpi_pci_link_set()
with interrupts off, so we get a warning when we try to do a kmalloc
of non atomic memory.  The actual allocation is just 2 long's
(plus extra byte for some reason I can't fathom), so a simple conversion
to GFP_ATOMIC is probably the safest way to fix this.

The error looks like this..

Debug: sleeping function called from invalid context at mm/slab.c:2486
in_atomic():0, irqs_disabled():1
 [<c0143f6c>] kmem_cache_alloc+0x40/0x56
 [<c0206a2e>] acpi_pci_link_set+0x3f/0x17f
 [<c0206f96>] irqrouter_resume+0x1e/0x3c
 [<c0239bca>] __sysdev_resume+0x11/0x6b
 [<c0239e88>] sysdev_resume+0x34/0x52
 [<c023de21>] device_power_up+0x5/0xa

Signed-off-by: Dave Jones <davej@redhat.com>

--- linux-2.6.14/drivers/acpi/pci_link.c~	2005-12-10 01:58:17.000000000 -0500
+++ linux-2.6.14/drivers/acpi/pci_link.c	2005-12-10 01:58:36.000000000 -0500
@@ -316,7 +316,7 @@ static int acpi_pci_link_set(struct acpi
 	if (!link || !irq)
 		return_VALUE(-EINVAL);
 
-	resource = kmalloc(sizeof(*resource) + 1, GFP_KERNEL);
+	resource = kmalloc(sizeof(*resource) + 1, GFP_ATOMIC);
 	if (!resource)
 		return_VALUE(-ENOMEM);
 
