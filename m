Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263200AbVAFXpb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263200AbVAFXpb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 18:45:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263127AbVAFXpQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 18:45:16 -0500
Received: from fw.osdl.org ([65.172.181.6]:1212 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261196AbVAFXm3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 18:42:29 -0500
Date: Thu, 6 Jan 2005 15:46:50 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Prakash K. Cheemplavam" <prakashkc@gmx.de>
Cc: bzolnier@gmail.com, drab@kepler.fjfi.cvut.cz, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: APIC/LAPIC hanging problems on nForce2 system.
Message-Id: <20050106154650.33c3b11c.akpm@osdl.org>
In-Reply-To: <41DD537B.9030304@gmx.de>
References: <Pine.LNX.4.60.0501051604200.24191@kepler.fjfi.cvut.cz>
	<41DC1AD7.7000705@gmx.de>
	<Pine.LNX.4.60.0501051757300.25946@kepler.fjfi.cvut.cz>
	<41DC2113.8080604@gmx.de>
	<Pine.LNX.4.60.0501051821430.25946@kepler.fjfi.cvut.cz>
	<41DC2353.7010206@gmx.de>
	<Pine.LNX.4.60.0501060046450.26952@kepler.fjfi.cvut.cz>
	<41DCFEF0.5050105@gmx.de>
	<58cb370e05010605527f87297e@mail.gmail.com>
	<41DD537B.9030304@gmx.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Prakash K. Cheemplavam" <prakashkc@gmx.de> wrote:
>
> This patch applies the Nforce2 C1 halt disconnect fix, no matter if
> disconnect is enabled of not. I don't know whether checking the whole
> affected byte is necessary or the nibble would be enough (I am no Nvidia
> engineer).

The patch doesn't apply to the current tree.  Here's what we currently have:

static void __init pci_fixup_nforce2(struct pci_dev *dev)
{
	u32 val, fixed_val;
	u8 rev;

	pci_read_config_byte(dev, PCI_REVISION_ID, &rev);

	/*
	 * Chip  Old value   New value
	 * C17   0x1F0FFF01  0x1F01FF01
	 * C18D  0x9F0FFF01  0x9F01FF01
	 *
	 * Northbridge chip version may be determined by
	 * reading the PCI revision ID (0xC1 or greater is C18D).
	 */
	fixed_val = rev < 0xC1 ? 0x1F01FF01 : 0x9F01FF01;

	pci_read_config_dword(dev, 0x6c, &val);

	/*
	 * Apply fixup only if C1 Halt Disconnect is enabled
	 * (bit28) because it is not supported on some boards.
	 */
	if ((val & (1 << 28)) && val != fixed_val) {
		printk(KERN_WARNING "PCI: nForce2 C1 Halt Disconnect fixup\n");
		pci_write_config_dword(dev, 0x6c, fixed_val);
	}
}
DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE2, pci_fixup_nforce2);

If you think this still needs fixing, please submit a new patch.  I think
we'd need to see a better explanation of the rationale for the change as
well, please.  What it does, why, how, etc.
