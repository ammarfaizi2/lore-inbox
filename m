Return-Path: <linux-kernel-owner+w=401wt.eu-S1947476AbWLHW6Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1947476AbWLHW6Q (ORCPT <rfc822;w@1wt.eu>);
	Fri, 8 Dec 2006 17:58:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1947477AbWLHW6Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 17:58:16 -0500
Received: from mga02.intel.com ([134.134.136.20]:12765 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1947476AbWLHW6P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 17:58:15 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,515,1157353200"; 
   d="scan'208"; a="172343142:sNHT23349368"
Message-ID: <4579EE04.9030409@intel.com>
Date: Fri, 08 Dec 2006 14:58:12 -0800
From: Auke Kok <auke-jan.h.kok@intel.com>
User-Agent: Mail/News 1.5.0.7 (X11/20060918)
MIME-Version: 1.0
To: Stephen Hemminger <shemminger@osdl.org>
CC: Roland Dreier <rdreier@cisco.com>, Greg Kroah-Hartman <gregkh@suse.de>,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       "Cramer, Jeb J" <jeb.j.cramer@intel.com>
Subject: Re: [PATCH 2/6] e1000: use pcix_set_mmrbc
References: <20061208182241.786324000@osdl.org>	<20061208182500.478856000@osdl.org>	<adalkli6p0e.fsf@cisco.com> <20061208144332.33497a98@freekitty>
In-Reply-To: <20061208144332.33497a98@freekitty>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 08 Dec 2006 22:58:13.0134 (UTC) FILETIME=[56B8E2E0:01C71B1C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Hemminger wrote:
> On Fri, 08 Dec 2006 13:45:05 -0800
> Roland Dreier <rdreier@cisco.com> wrote:
> 
>>  > -        if (hw->bus_type == e1000_bus_type_pcix) {
>>  > -            e1000_read_pci_cfg(hw, PCIX_COMMAND_REGISTER, &pcix_cmd_word);
>>  > -            e1000_read_pci_cfg(hw, PCIX_STATUS_REGISTER_HI,
>>  > -                &pcix_stat_hi_word);
>>  > -            cmd_mmrbc = (pcix_cmd_word & PCIX_COMMAND_MMRBC_MASK) >>
>>  > -                PCIX_COMMAND_MMRBC_SHIFT;
>>  > -            stat_mmrbc = (pcix_stat_hi_word & PCIX_STATUS_HI_MMRBC_MASK) >>
>>  > -                PCIX_STATUS_HI_MMRBC_SHIFT;
>>  > -            if (stat_mmrbc == PCIX_STATUS_HI_MMRBC_4K)
>>  > -                stat_mmrbc = PCIX_STATUS_HI_MMRBC_2K;
>>  > -            if (cmd_mmrbc > stat_mmrbc) {
>>  > -                pcix_cmd_word &= ~PCIX_COMMAND_MMRBC_MASK;
>>  > -                pcix_cmd_word |= stat_mmrbc << PCIX_COMMAND_MMRBC_SHIFT;
>>  > -                e1000_write_pci_cfg(hw, PCIX_COMMAND_REGISTER,
>>  > -                    &pcix_cmd_word);
>>  > -            }
>>  > -        }
>>  > +        if (hw->bus_type == e1000_bus_type_pcix)
>>  > +		e1000_pcix_set_mmrbc(hw, 2048);
>>
>> This changes the behavior of the driver.  The existing driver only
>> sets MMRBC if it's bigger than min(2048, value in the status register).
>> You're setting MMRBC to 2048 even if it starts out at a smaller value.
>>
>>  - R.
> 
> Hmm.. looks like all that code should really be moved off to PCI bus
> quirk/setup.  None of it is E1000 specific.  Something like this (untested):

This is not true, and I have to NAK the original patch. Part of the code Stephan is 
removing fixes a BUG in one of our *e1000 parts* that has the wrong size.

It would be nice to fix generix pci-x issues qith quirks for platforms but the 
adjustment needs to stay for this specific e1000 case.

Perhaps we can accomodate that specific case so that it is apparent from our code, as is 
not the case right now.

Auke

PS Thanks to Jeb for fishing this out ;)


> 
> ---
>  drivers/pci/quirks.c |   30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
> 
> --- pci-x.orig/drivers/pci/quirks.c
> +++ pci-x/drivers/pci/quirks.c
> @@ -1719,6 +1719,36 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_NV
>  #endif /* CONFIG_PCI_MSI */
>  
>  EXPORT_SYMBOL(pcie_mch_quirk);
> +
> +/* Check that BIOS has not set PCI-X MMRBC to value bigger than board allows */
> +static void __devinit quirk_pcix_mmrbc(struct pci_dev *dev)
> +{
> +	int cap;
> +	u32 stat;
> +	u16 cmd, m, c;
> +
> +	cap = pci_find_capability(dev, PCI_CAP_ID_PCIX);
> +	if (cap <= 0)
> +		return;
> +
> +	if (pci_read_config_dword(dev, cap + PCI_X_STATUS, &stat) ||
> +	    pci_read_config_word(dev, cap + PCI_X_CMD, &cmd))
> +		return;
> +
> +	m = (stat & PCI_X_STATUS_MAX_READ) >> 21;	/* max possible MRRBC*/
> +	c = (cmd & PCI_X_CMD_MAX_READ) >> 2;		/* current MMRBC */
> +	if (c > m) {
> +		printk(KERN_INFO "PCIX: %s resetting MMRBC to %d\n",
> +		       pci_name(dev), 512 << m);
> +
> +		cmd &= ~PCI_X_CMD_MAX_READ;
> +		cmd |= m << 2;
> +		pci_write_config_dword(dev, cap + PCI_X_CMD, cmd);
> +	}
> +}
> +DECLARE_PCI_FIXUP_FINAL(PCI_ANY_ID, PCI_ANY_ID, quirk_pcix_mmrbc);
> +
> +
>  #ifdef CONFIG_HOTPLUG
>  EXPORT_SYMBOL(pci_fixup_device);
>  #endif
> 
> 
