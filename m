Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263366AbTBNRQ5>; Fri, 14 Feb 2003 12:16:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263215AbTBNRPS>; Fri, 14 Feb 2003 12:15:18 -0500
Received: from atlrel7.hp.com ([156.153.255.213]:9452 "EHLO atlrel7.hp.com")
	by vger.kernel.org with ESMTP id <S262089AbTBNROo>;
	Fri, 14 Feb 2003 12:14:44 -0500
Content-Type: text/plain; charset=US-ASCII
From: Bjorn Helgaas <bjorn_helgaas@hp.com>
To: "David S. Miller" <davem@redhat.com>
Subject: Re: tg3: back-to-back register write bug workaround causes MCA
Date: Fri, 14 Feb 2003 10:24:27 -0700
User-Agent: KMail/1.4.3
Cc: linux-kernel@vger.kernel.org, Grant Grundler <grundler@cup.hp.com>
References: <200302121730.53701.bjorn_helgaas@hp.com> <20030212.193217.27086083.davem@redhat.com>
In-Reply-To: <20030212.193217.27086083.davem@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200302141024.27005.bjorn_helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 12 February 2003 8:32 pm, David S. Miller wrote:
> This sounds like either a bug in your ia64's PCI chipset or
> in the tigon3 device.

We haven't captured a PCI trace yet, but I think we have a good
lead.  The MCA occurs in tg3_chip_reset(), which does:

	tw32(GRC_MISC_CFG, GRC_MISC_CFG_CORECLK_RESET);

The comment immediately after the reset:

        /* Flush PCI posted writes.  The normal MMIO registers
         * are inaccessible at this time so this is the only
         * way to make this reliably.  I tried to use indirect
         * register read/write but this upset some 5701 variants.
         */
        pci_read_config_dword(tp->pdev, PCI_COMMAND, &val);

says that the MMIO registers are inaccessible at this time.
Presumably they became inaccessible when tg3_write_indirect_reg32()
did the write to GRC_MISC_CFG, so the read-after-write for the
TG3_FLAG_5701_REG_WRITE_BUG is then reading an inaccessible register.

One unusual thing about our ia64 chipset (and our parisc chipset)
is that it's typically configured so PCI master aborts cause an MCA.
My understanding is that most other PCI controllers basically ignore
master aborts, so the aborted read would just return -1 instead of
causing an MCA.

The following change (though not correct because it ignores
TG3_FLAG_PCIX_TARGET_HWBUG) avoids the MCA:

--- 1.57/drivers/net/tg3.c      Fri Feb 14 09:24:48 2003
+++ edited/drivers/net/tg3.c    Fri Feb 14 09:26:49 2003
@@ -3059,7 +3059,7 @@
                }
        }
 
-       tw32(GRC_MISC_CFG, GRC_MISC_CFG_CORECLK_RESET);
+       writel(GRC_MISC_CFG_CORECLK_RESET, tp->regs + GRC_MISC_CFG);
 
        /* Flush PCI posted writes.  The normal MMIO registers
         * are inaccessible at this time so this is the only

So perhaps we need a special-case path for resetting, so we don't
try to access the registers while they're disabled.

Bjorn

