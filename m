Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262553AbUKLPkd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262553AbUKLPkd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 10:40:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262556AbUKLPkd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 10:40:33 -0500
Received: from gprs212-224.eurotel.cz ([160.218.212.224]:384 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262553AbUKLPkW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 10:40:22 -0500
Date: Fri, 12 Nov 2004 16:35:30 +0100
From: Pavel Machek <pavel@ucw.cz>
To: David Brownell <david-b@pacbell.net>
Cc: linux-pm@lists.osdl.org, Patrick Mochel <mochel@digitalimplant.org>,
       Greg KH <greg@kroah.com>, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [linux-pm] Adapt drivers to type-safe pci
Message-ID: <20041112153530.GA1091@elf.ucw.cz>
References: <20041101202640.GA24855@elf.ucw.cz> <200411011700.46493.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200411011700.46493.david-b@pacbell.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > This adapts few drivers to type-safe pci powermanagment. I introduced
> > device_to_pci_state helper that will be usefull to few drivers... Does
> > it look okay? 
> 
> I'd rather have something like the attached patch.
> Fixed policy mappings are generically broken; what
> about devices that don't support PCI_D2?

Point taken, this function is probably too big to be in header. 

> This should I guess use the new "pci_power_t", but
> I'm not that current yet.  

I'd still like this function to return suitable state (and do nothing
else), to make converting drivers easier.

For now suspend() only gets 0 or 3; I'd rather not change code for
now. Do we really enter PCI_D1 on standby? I believe PCI transitions
are fast enough to enter PCI_D3hot even for standby / suspend-to-ram.

								Pavel

> +void
> +pci_choose_state(struct pci_dev *pdev, suspend_state_t sleepstate)
> +{
> +	int pm, state;
> +	u16 pmc;
> +
> +	/* nothing to do for legacy PCI devices */
> +	pm = pci_find_capability(pdev, PCI_CAP_ID_PM);
> +	if (!pm)
> +		return;
> +
> +	/* map to a PCI PM state this device supports
> +	 * FIXME ACPI may know what states to use; we should probably
> +	 * prefer that policy to this one.
> +	 */
> +	state = 3;
> +	switch (sleepstate) {
> +	case PM_SUSPEND_ON:
> +		state = 0;
> +		break;
> +	case PM_SUSPEND_STANDBY:
> +	case PM_SUSPEND_MEM:
> +		pci_read_config_word(pdev, pm + PCI_PM_PMC, &pmc);
> +		if (sleepstate == PM_SUSPEND_STANDBY
> +				&& (pmc & PCI_PM_CAP_D1) != 0)
> +			state = 1;
> +		else if ((pmc & PCI_PM_CAP_D2) != 0)
> +			state = 2;
> +		break;
> +	}
> +
> +	/* maybe go to a deeper power state */
> +	if (pdev->current_state < state)
> +		pci_set_power_state(pdev, state);
> +}
> +EXPORT_SYMBOL(pci_choose_state);
>  
>  /**
>   * pci_save_state - save the PCI configuration space of a device before suspending


-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
