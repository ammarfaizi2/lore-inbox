Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261228AbVFCL4K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261228AbVFCL4K (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Jun 2005 07:56:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261232AbVFCL4K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Jun 2005 07:56:10 -0400
Received: from alog0271.analogic.com ([208.224.222.47]:56798 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261228AbVFCLzt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Jun 2005 07:55:49 -0400
Date: Fri, 3 Jun 2005 07:54:11 -0400 (EDT)
From: "Richard B. Johnson" <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: Vivek Goyal <vgoyal@in.ibm.com>
cc: linux kernel mailing list <linux-kernel@vger.kernel.org>, greg@kroah.com,
       Fastboot mailing list <fastboot@lists.osdl.org>,
       Morton Andrew Morton <akpm@osdl.org>,
       Alan Stern <stern@rowland.harvard.edu>,
       "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [RFC/PATCH] Kdump: Disabling PCI interrupts in capture kernel
In-Reply-To: <20050603112524.GB7022@in.ibm.com>
Message-ID: <Pine.LNX.4.61.0506030749310.11724@chaos.analogic.com>
References: <20050603112524.GB7022@in.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Yes. We need something like that since one must now 'enable' the
device to have its final IRQ routing established. This has created
dire consequences for existin drivers.

However, I have the following comments about the patch.

> +	if (!(pci_command & PCI_COMMAND_INTX_DISABLE)) {
         |
         |
         |___ This is never needed. Just read the register,
do your thing, then write it back.


On Fri, 3 Jun 2005, Vivek Goyal wrote:

> Hi,
>
> In kdump, sometimes, general driver initialization issues seems to be cropping
> in second kernel due to devices not being shutdown during crash and these
> devices are sending interrupts while second kernel is booting and drivers are
> not expecting any interrupts yet.
>
> In some cases, we are observing a storm of interrupts while second kernel
> is booting and kernel disables that irq line. May be the case of stuck irq
> line because it is shared level triggered irq and there is no driver
> loaded for the device.
>
> So, we need something generic which disables interrupt generation from device
> until a driver has been registered for that device and driver is ready to
> receive the interrupts. PCI specifications (ver 2.3 onwards), have introduced
> interrupt disable bit in command register to disable interrupt generation
> from the device. This can become handy here. In capture kernel, traverse all
> the PCI devices, disable interrupt generation. Enable the interrupt generation
> back once the driver for that device registers. May be after the probe handler
> has run. In probe handler, driver can reset the device or register for irq so
> that it can handle any interrupt from the device after that.
>
> Greg mentioned that there are reasons that we can not disable all pci
> interrupts. Meanwhile I am going through archives to find more about it.
>
> In previous conversations, Alan Stern had raised the issue of console also
> not working if interrupts are disabled on all the devices. I am not sure
> but this should be working at least for serial consoles and vga text consoles.
> May be sufficient to capture the dump.
>
> Attached is a hack patch which is by no means complete. I have got one machine
> which has got some PCI 2.3 compliant hardware. After applying this hack this
> problem does not occur atleast on this machine. Attached is the serial console
> log which shows one kind of problem due to unwanted interrupts.
>
> Bugme 4631 and 4573 are two more instances of driver initialization failure
> in second kernel.
>
>
>
>
>
>
> ---
> o In kdump, devices are not shutdown/reset after a crash and this leads to
>  various driver initialization failures while second kernel is booting.
>  Most of them seem to be happening due to the fact that system/driver
>  is receiving the interrupts from device when it is not prepared to do so.
>
> o This patch tries to solve the problem by disabling the interrupts at
>  PCI level for all the devices. These interrupts are enabled back once the
>  driver for that device registers. Currenty this enabling and disabling
>  is done only in dump capture kernel.
>
> o This is for devices compliant to PCI specification v2.3 or higher.
>
>
>
> Signed-off-by: Vivek Goyal <vgoyal@in.ibm.com>
> ---
>
> linux-2.6.12-rc5-mm1-16M-root/drivers/pci/pci-driver.c |    3 +
> linux-2.6.12-rc5-mm1-16M-root/drivers/pci/pci.c        |    4 ++
> linux-2.6.12-rc5-mm1-16M-root/include/linux/pci.h      |   33 +++++++++++++++++
> 3 files changed, 39 insertions(+), 1 deletion(-)
>
> diff -puN drivers/pci/pci.c~kdump-pci-interrupt-disable drivers/pci/pci.c
> --- linux-2.6.12-rc5-mm1-16M/drivers/pci/pci.c~kdump-pci-interrupt-disable	2005-06-03 14:35:26.000000000 +0530
> +++ linux-2.6.12-rc5-mm1-16M-root/drivers/pci/pci.c	2005-06-03 15:59:19.000000000 +0530
> @@ -823,6 +823,10 @@ static int __devinit pci_init(void)
>
> 	while ((dev = pci_get_device(PCI_ANY_ID, PCI_ANY_ID, dev)) != NULL) {
> 		pci_fixup_device(pci_fixup_final, dev);
> +
> +		/* A hack to disable interrupts from all PCI devices in
> +		 * capture kernel. */
> +		pci_disable_device_intx(dev);
> 	}
> 	return 0;
> }
> diff -puN drivers/pci/pci-driver.c~kdump-pci-interrupt-disable drivers/pci/pci-driver.c
> --- linux-2.6.12-rc5-mm1-16M/drivers/pci/pci-driver.c~kdump-pci-interrupt-disable	2005-06-03 14:35:26.000000000 +0530
> +++ linux-2.6.12-rc5-mm1-16M-root/drivers/pci/pci-driver.c	2005-06-03 14:35:26.000000000 +0530
> @@ -248,7 +248,8 @@ static int pci_device_probe(struct devic
> 	error = __pci_device_probe(drv, pci_dev);
> 	if (error)
> 		pci_dev_put(pci_dev);
> -
> +	else
> +		pci_enable_device_intx(pci_dev);
> 	return error;
> }
>
> diff -puN include/linux/pci.h~kdump-pci-interrupt-disable include/linux/pci.h
> --- linux-2.6.12-rc5-mm1-16M/include/linux/pci.h~kdump-pci-interrupt-disable	2005-06-03 14:35:26.000000000 +0530
> +++ linux-2.6.12-rc5-mm1-16M-root/include/linux/pci.h	2005-06-03 16:06:32.000000000 +0530
> @@ -901,6 +901,39 @@ extern void pci_disable_msix(struct pci_
> extern void msi_remove_pci_irq_vectors(struct pci_dev *dev);
> #endif
>
> +#ifdef CONFIG_CRASH_DUMP
> +static inline int pci_enable_device_intx(struct pci_dev *dev)
> +{
> +	u16 pci_command;
> +
> +	/* Enable Interrupt generation if not already enabled */
> +	pci_read_config_word(dev, PCI_COMMAND, &pci_command);
> +	if (pci_command & PCI_COMMAND_INTX_DISABLE) {
> +		pci_command &= ~PCI_COMMAND_INTX_DISABLE;
> +		pci_write_config_word(dev, PCI_COMMAND, pci_command);
> +	}
> +	return 0;
> +}
> +
> +static inline int pci_disable_device_intx(struct pci_dev *dev)
> +{
> +	u16 pci_command;
> +
> +	/* Disable Interrupt generation if not already disabled */
> +	pci_read_config_word(dev, PCI_COMMAND, &pci_command);
> +	if (!(pci_command & PCI_COMMAND_INTX_DISABLE)) {
> +		pci_command |= PCI_COMMAND_INTX_DISABLE;
> +		pci_write_config_word(dev, PCI_COMMAND, pci_command);
> +	}
> +	return 0;
> +}
> +#else
> +static inline int pci_enable_device_intx(struct pci_dev *dev)
> +{ return 0; }
> +static inline int pci_disable_device_intx(struct pci_dev *dev)
> +{ return 0; }
> +#endif /* CONFIG_CRASH_DUMP */
> +
> #endif /* CONFIG_PCI */
>
> /* Include architecture-dependent settings and functions */
> _
>

Cheers,
Dick Johnson
Penguin : Linux version 2.6.11.9 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
