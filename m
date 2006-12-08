Return-Path: <linux-kernel-owner+w=401wt.eu-S1761233AbWLHWnp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761233AbWLHWnp (ORCPT <rfc822;w@1wt.eu>);
	Fri, 8 Dec 2006 17:43:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761236AbWLHWnp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 17:43:45 -0500
Received: from smtp.osdl.org ([65.172.181.25]:46784 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761233AbWLHWno (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 17:43:44 -0500
Date: Fri, 8 Dec 2006 14:43:32 -0800
From: Stephen Hemminger <shemminger@osdl.org>
To: Roland Dreier <rdreier@cisco.com>
Cc: Greg Kroah-Hartman <gregkh@suse.de>, linux-pci@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/6] e1000: use pcix_set_mmrbc
Message-ID: <20061208144332.33497a98@freekitty>
In-Reply-To: <adalkli6p0e.fsf@cisco.com>
References: <20061208182241.786324000@osdl.org>
	<20061208182500.478856000@osdl.org>
	<adalkli6p0e.fsf@cisco.com>
Organization: OSDL
X-Mailer: Sylpheed-Claws 2.5.0-rc3 (GTK+ 2.10.6; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 08 Dec 2006 13:45:05 -0800
Roland Dreier <rdreier@cisco.com> wrote:

>  > -        if (hw->bus_type == e1000_bus_type_pcix) {
>  > -            e1000_read_pci_cfg(hw, PCIX_COMMAND_REGISTER, &pcix_cmd_word);
>  > -            e1000_read_pci_cfg(hw, PCIX_STATUS_REGISTER_HI,
>  > -                &pcix_stat_hi_word);
>  > -            cmd_mmrbc = (pcix_cmd_word & PCIX_COMMAND_MMRBC_MASK) >>
>  > -                PCIX_COMMAND_MMRBC_SHIFT;
>  > -            stat_mmrbc = (pcix_stat_hi_word & PCIX_STATUS_HI_MMRBC_MASK) >>
>  > -                PCIX_STATUS_HI_MMRBC_SHIFT;
>  > -            if (stat_mmrbc == PCIX_STATUS_HI_MMRBC_4K)
>  > -                stat_mmrbc = PCIX_STATUS_HI_MMRBC_2K;
>  > -            if (cmd_mmrbc > stat_mmrbc) {
>  > -                pcix_cmd_word &= ~PCIX_COMMAND_MMRBC_MASK;
>  > -                pcix_cmd_word |= stat_mmrbc << PCIX_COMMAND_MMRBC_SHIFT;
>  > -                e1000_write_pci_cfg(hw, PCIX_COMMAND_REGISTER,
>  > -                    &pcix_cmd_word);
>  > -            }
>  > -        }
>  > +        if (hw->bus_type == e1000_bus_type_pcix)
>  > +		e1000_pcix_set_mmrbc(hw, 2048);
> 
> This changes the behavior of the driver.  The existing driver only
> sets MMRBC if it's bigger than min(2048, value in the status register).
> You're setting MMRBC to 2048 even if it starts out at a smaller value.
> 
>  - R.

Hmm.. looks like all that code should really be moved off to PCI bus
quirk/setup.  None of it is E1000 specific.  Something like this (untested):

---
 drivers/pci/quirks.c |   30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

--- pci-x.orig/drivers/pci/quirks.c
+++ pci-x/drivers/pci/quirks.c
@@ -1719,6 +1719,36 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_NV
 #endif /* CONFIG_PCI_MSI */
 
 EXPORT_SYMBOL(pcie_mch_quirk);
+
+/* Check that BIOS has not set PCI-X MMRBC to value bigger than board allows */
+static void __devinit quirk_pcix_mmrbc(struct pci_dev *dev)
+{
+	int cap;
+	u32 stat;
+	u16 cmd, m, c;
+
+	cap = pci_find_capability(dev, PCI_CAP_ID_PCIX);
+	if (cap <= 0)
+		return;
+
+	if (pci_read_config_dword(dev, cap + PCI_X_STATUS, &stat) ||
+	    pci_read_config_word(dev, cap + PCI_X_CMD, &cmd))
+		return;
+
+	m = (stat & PCI_X_STATUS_MAX_READ) >> 21;	/* max possible MRRBC*/
+	c = (cmd & PCI_X_CMD_MAX_READ) >> 2;		/* current MMRBC */
+	if (c > m) {
+		printk(KERN_INFO "PCIX: %s resetting MMRBC to %d\n",
+		       pci_name(dev), 512 << m);
+
+		cmd &= ~PCI_X_CMD_MAX_READ;
+		cmd |= m << 2;
+		pci_write_config_dword(dev, cap + PCI_X_CMD, cmd);
+	}
+}
+DECLARE_PCI_FIXUP_FINAL(PCI_ANY_ID, PCI_ANY_ID, quirk_pcix_mmrbc);
+
+
 #ifdef CONFIG_HOTPLUG
 EXPORT_SYMBOL(pci_fixup_device);
 #endif


-- 
Stephen Hemminger <shemminger@osdl.org>
