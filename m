Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268312AbUJJP1S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268312AbUJJP1S (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Oct 2004 11:27:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268315AbUJJP1S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Oct 2004 11:27:18 -0400
Received: from mail.tv-sign.ru ([213.234.233.51]:2191 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S268312AbUJJP1Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Oct 2004 11:27:16 -0400
Message-ID: <416954D4.956AA617@tv-sign.ru>
Date: Sun, 10 Oct 2004 19:27:16 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@elte.hu>
Subject: BUG? nosmp and pcibios_fixup_irqs()
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

void smp_boot_cpus(unsigned int max_cpus)
{
	if (!max_cpus) {
		smpboot_clear_io_apic_irqs();
		// sets io_apic_irqs = 0;
		return;
	}

	setup_IO_APIC();
}

void pcibios_fixup_irqs(void)
{
	while (dev = pci_find_device())
		if (io_apic_assign_pci_irqs)
			dev->irq = IO_APIC_get_PCI_irq_vector();
}

It seems to me that this dev->irq assignment is wrong in case
when setup_IO_APIC() was not called, and this is the case for
'nosmp' parameter.

With this change:
-	if (io_apic_assign_pci_irqs)
+	if (io_apic_assign_pci_irqs && io_apic_irqs)

my netwok card works with nosmp, but i never looked in
arch/i386/pci/ before, so i am probably wrong.

Or nosmp does not make sense without noapic?

Oleg.
