Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262293AbUKQM36@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262293AbUKQM36 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 07:29:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262297AbUKQM35
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 07:29:57 -0500
Received: from mail.sf-mail.de ([62.27.20.61]:5824 "EHLO mail.sf-mail.de")
	by vger.kernel.org with ESMTP id S262293AbUKQM34 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 07:29:56 -0500
From: Rolf Eike Beer <eike-kernel@sf-tec.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PPC] Missing pci_dev_put in arch/ppc/platforms/chrp_pci.c ?
Date: Wed, 17 Nov 2004 13:29:51 +0100
User-Agent: KMail/1.7.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411171329.51687@bilbo.math.uni-mannheim.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is how it is:

chrp_pcibios_fixup(void)
{
        struct pci_dev *dev = NULL;
        struct device_node *np;

        /* PCI interrupts are controlled by the OpenPIC */
        for_each_pci_dev(dev) {
                np = pci_device_to_OF_node(dev);
                if ((np != 0) && (np->n_intrs > 0) && (np->intrs[0].line != 0))
                        dev->irq = np->intrs[0].line;
                pci_write_config_byte(dev, PCI_INTERRUPT_LINE, dev->irq);
        }
}

for_each_pci_dev is defined to use pci_get_device in include/linux/pci.h,
which uses pci_dev_get. So every PCI devices use count will be incremented
if chrp_pcibios_fixup is called. Do I miss something or should we add a
pci_dev_put(dev) at the end of the loop?

Eike
