Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262058AbVDEVVc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262058AbVDEVVc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 17:21:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261983AbVDEU4U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 16:56:20 -0400
Received: from fire.osdl.org ([65.172.181.4]:11241 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262025AbVDEUyC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 16:54:02 -0400
Message-ID: <4252FAE6.8080107@osdl.org>
Date: Tue, 05 Apr 2005 13:53:58 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
Organization: OSDL
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ross Biro <rossb@google.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [RFC/Patch 2.6.11] Take control of PCI Master Abort Mode
References: <4252E827.4080807@google.com>
In-Reply-To: <4252E827.4080807@google.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ross Biro wrote:
> 
> Currently Linux 2.6 assumes the BIOS (or firmware) sets the master abort 
> mode flag on PCI bridge chips in a coherent fashion.  This is not always 
> the case and the consequences of getting this flag incorrect can cause 
> hardware to fail or silent data corruption.  This patch lets the user 
> override the BIOS master abort setting at boot time and the distro 
> maintainer to set a default according to their target audience.
> 
> The comments in the patch are probably a bit too verbose, but I think it 
> is a good patch to start discussions around.  If it is decided that 
> something should be done about this problem, this patch could be 
> included in a -mm release and migrate into Linus's kernel as appropriate.

The comments were helpful to me.

> This incarnation of the patch has had minimal testing.  For our internal 
> kernels, we always force the master abort mode to 1 and then let the 
> device drivers for hardware we know can't handle target aborts switch 
> the master abort mode to 0. This does not seem appropriate for general 
> release.
> 
> Some background for those who do not spend most of their waking hours 
> exploring buses and what can go wrong.

Is this related (or could it be -- or should it be) at all to the
current discussion on the linux-pci mailing list
linux-pci@atrey.karlin.mff.cuni.cz) about "PCI Error Recovery
API Proposal" ?

> The master abort flag tells a PCI bridge what to do when a bus master 
> behind the bridge requests the bus and the bridge is unable to get the 
> bus.  With the flag clear, for master reads the bridge returns all 
> 0xff's (hence silent data corruption) and for master writes, it throws 
> the data away.  With the bit set, the bridge sends a target abort to the 
> master.  This can only happen when the system is heavily loaded.

or a PCI device isn't playing nicely?

> The problem with always setting the bit is that some PCI hardware, 
> notably some Intel E-1000 chips (Ethernet controller: Intel Corporation: 
> Unknown device 1076) cannot properly handle the target abort bit.  In 
> the case of the E-1000 chip, the driver must reset the chip to recover. 
> This usually leads to the machine being off the network for several 
> seconds, or sometimes even minutes, which can be bad for servers.
> 
> I even have a single motherboard with both a device that cannot handle 
> the target abort and an IDE controller that can handle the target abort 
> behind the same bridge.  For this motherboard, I have to choose the 
> lesser of two evils, network hiccups or potential data corruption.
> For the record, I have seen both occur.  Other people may make wish to 
> make a different choice than we did, hence this patch allows the user to 
> choose the mode at runtime.
> 
>     Ross
> 
> ------------------------------------------------------------------------
> 
> diff -ur linux-2.6.11/drivers/pci/Kconfig linux-2.6.11-new/drivers/pci/Kconfig
> --- linux-2.6.11/drivers/pci/Kconfig	2005-03-01 23:37:51.000000000 -0800
> +++ linux-2.6.11-new/drivers/pci/Kconfig	2005-04-01 07:19:32.000000000 -0800
> @@ -47,3 +47,38 @@
>  
>  	  When in doubt, say Y.
>  
> +choice
> +	prompt "Enable PCI Master Abort Mode"
> +	depends on PCI
> +	default PCI_MASTER_ABORT_DEFAULT
> +	help
> +	  On PCI systems, when a bus is unavailable to a bus master, a 
> +	  master abort occurs.  Older bridges satisfy the master request
> +	  with all 0xFF's.  This can lead to silent data corruption.  Newer
> +	  bridges can send a target abort to the bus master.  Some PCI
> +	  hardware cannot handle the target abort.  Some x86 BIOSes configure
> +          the buses in a suboptimal way.  This option allows you to override
           ^^^ extra spaces

> +	  the BIOS setting.  If unsure chose default.  This choice can be
                                        choose
> +	  overridden at boot time with the pci_enable_master_abort={default,
> +	  enable, disable}
                            boot option.

> +
> +config PCI_MASTER_ABORT_DEFAULT
> +	bool "Default"
> +	help
> +	  Choose this option if you are unsure, or believe your
> +	  firmware does the right thing.
> +
> +config PCI_MASTER_ABORT_ENABLE
> +	bool "Enable"
> +	help
> +	  Choose this option if it is more important for you to prevent
> +	  silent data loss than to have more hardware configurations work.
                                         ^^^^ ??

> +
> +
> +config PCI_MASTER_ABORT_DISABLE
> +	bool "Disable"
> +	help
> +	  Choose this option if it is more important for you to have more
                                                                   ^^^^
The phrase "have more hardware configurations work" need something....
Maybe add something like:  "Some devices are known not to work with
PCI Master Aborts.  If you have one of these devices, you probably
want to Disable this option."


> +	  hardware configurations work than to prevent silent data loss.
> +
> +endchoice
> diff -ur linux-2.6.11/drivers/pci/probe.c linux-2.6.11-new/drivers/pci/probe.c
> --- linux-2.6.11/drivers/pci/probe.c	2005-03-01 23:38:13.000000000 -0800
> +++ linux-2.6.11-new/drivers/pci/probe.c	2005-04-05 12:07:53.000000000 -0700
> @@ -28,6 +28,15 @@
>  
>  LIST_HEAD(pci_devices);
>  
> +/* used to force master abort mode on or off at runtime.
> +   PCI_MASTER_ABORT_DEFAULT means leave alone, the BIOS got it correct.
> +   PCI_MASTER_ABORT_ENABLE means turn it on everywhere.
> +   PCI_MASTER_ABORT_DISABLE means turn it off everywhere.
> +*/
> +
> +static int pci_enable_master_abort=PCI_MASTER_ABORT_VAL;

Nitpick:  spaces around the '=' would enhance readability and be
appreciated.

> @@ -429,6 +438,20 @@
>  	pci_write_config_word(dev, PCI_BRIDGE_CONTROL,
>  			      bctl & ~PCI_BRIDGE_CTL_MASTER_ABORT);
>  
> +	/* Some BIOSes disable master abort mode, even though it's
> +	   usually a good thing (prevents silent data corruption).
> +	   Unfortunately some hardware (buggy e-1000 chips for
> +	   example) require Master Abort Mode to be off, or they will
> +	   not function properly. So we enable master abort mode
> +	   unless the user told us not to.  The default value
> +	   for pci_enable_master_abort is set in the config file,
> +	   but can be overridden at setup time. */
Nit #2:  kernel long-comment style is:
	/*
	 * line1
	 * line2
	 */

> +	if (pci_enable_master_abort == PCI_MASTER_ABORT_ENABLE) {
> +		bctl |= PCI_BRIDGE_CTL_MASTER_ABORT;
> +	} else if (pci_enable_master_abort == PCI_MASTER_ABORT_DISABLE) {
> +		bctl &= ~PCI_BRIDGE_CTL_MASTER_ABORT;
> +	}
> +
>  	pci_enable_crs(dev);
>  
>  	if ((buses & 0xffff00) && !pcibios_assign_all_busses() && !is_cardbus) {
> @@ -932,6 +955,22 @@
>  	kfree(b);
>  	return NULL;
>  }
> +
> +static int __devinit pci_enable_master_abort_setup(char *str)
Why __devinit?  Looks to me like __init would be fine.

> +{
> +	if (strcmp(str, "enable") == 0) {
> +		pci_enable_master_abort = PCI_MASTER_ABORT_ENABLE;
> +	} else if (strcmp(str, "disable") == 0) {
> +		pci_enable_master_abort = PCI_MASTER_ABORT_DISABLE;
> +	} else if (strcmp(str, "default") == 0) {
> +		pci_enable_master_abort = PCI_MASTER_ABORT_DEFAULT;
> +	} else {
> +		printk (KERN_ERR "PCI: Unknown Master Abort Mode (%s).", str);
> +	}
> +}
> +
> +__setup("pci_enable_master_abort=", pci_enable_master_abort_setup);

-- 
~Randy
