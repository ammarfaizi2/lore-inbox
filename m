Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261202AbVARBxJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261202AbVARBxJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 20:53:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261182AbVARBmx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 20:42:53 -0500
Received: from fmr20.intel.com ([134.134.136.19]:22763 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S261153AbVARBVy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 20:21:54 -0500
Subject: Re: [PATCH 0/4]Bind physical devices with ACPI devices - take 2
From: Li Shaohua <shaohua.li@intel.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: ACPI-DEV <acpi-devel@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>, Len Brown <len.brown@intel.com>,
       Greg <greg@kroah.com>, Patrick Mochel <mochel@digitalimplant.org>
In-Reply-To: <20050117112822.GA1354@elf.ucw.cz>
References: <1104893444.5550.127.camel@sli10-desk.sh.intel.com>
	 <1105948622.17633.6.camel@sli10-desk.sh.intel.com>
	 <20050117112822.GA1354@elf.ucw.cz>
Content-Type: text/plain
Message-Id: <1106011250.20958.6.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 18 Jan 2005 09:20:50 +0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-01-17 at 19:28, Pavel Machek wrote:
> Hi!
> 
> > > The series of patches implement binding physical devices with ACPI
> > > devices. With it, device drivers can utilize methods provided by
> > > firmware (ACPI). These patches are against 2.6.10, please give your
> > > comments.
> 
> > This is updated patches according to latest discussion.
> > Changes from last one:
> > 1. introduce new field 'firmware_data' in 'struct device', since people
> > complain rename 'platform_data. Greg, could you please check if the
> > comments I added in 'struct device' are correct?
> > 2. align to Pavel's latest PCI state convention work.
> > 3. Some cleanups and add more comments.
> > One issue is 'platform_pci_choose_state' doesn't get called, it should
> > be after Pavel updates the parameter of 'pci_choose_state'
> 
> diff -puN drivers/pci/pci.c~acpi-pci-get-suspend-state-callback
> drivers/pci/pci.c
> --- 2.5/drivers/pci/pci.c~acpi-pci-get-suspend-state-callback
> 2005-01-17 12:54:05.357547072 +0800
> +++ 2.5-root/drivers/pci/pci.c  2005-01-17 13:08:50.835933896 +0800
> @@ -317,6 +317,7 @@ pci_set_power_state(struct pci_dev *dev,
>   * Returns PCI power state suitable for given device and given system
>   * message.
>   */
> +int (*platform_pci_choose_state)(struct pci_dev *, pm_message_t) = 0;
> 
>  pci_power_t pci_choose_state(struct pci_dev *dev, u32 state)
>  {
> 
> Perhaps you want this to be "= NULL"?
I must be in sleep :). I will fix it soon.
> 
> 
> > @@ -208,6 +209,25 @@ acpi_status pci_osc_control_set(u32 flag
> >  }
> >  EXPORT_SYMBOL(pci_osc_control_set);
> >  
> > +static int acpi_pci_choose_state(struct pci_dev *pdev,
> > +	pm_message_t state)
> > +{
> > +	char dstate_str[] = "_S0D";
> > +	acpi_status status;
> > +	unsigned long val;
> > +	struct device *dev = &pdev->dev;
> > +
> > +	/* state is PM_SUSPEND_* */
> > +	if ((state >= PM_SUSPEND_MAX) || !DEVICE_ACPI_HANDLE(dev))
> > +		return -EINVAL;
> > +	dstate_str[2] += (int __force)state;
> 
> When I'm done, you will not be able to just retype state to
> integer... Perhaps you want to do pci_choose_state first; that gets
> you pci_power_t and that one *is* okay to retype to int?
Firmware possibly will can't return a useful suspend state (Either
firmware doesn't define such device or evaluation failed), that's why I
return an int. I suppose pci_choose_state will do something:
	ret = firmware_pci_choose_state(dev, state);
	if (ret >= 0)
		pci_state = ret;
	switch(pci_state) {
	case 0: return PCI_D0;
	.....
	}

Thanks,
Shaohua

