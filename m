Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264723AbTFQNl5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jun 2003 09:41:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264725AbTFQNl5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jun 2003 09:41:57 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:44012 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264723AbTFQNly
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jun 2003 09:41:54 -0400
Date: Tue, 17 Jun 2003 14:55:48 +0100
From: Matthew Wilcox <willy@debian.org>
To: Anton Blanchard <anton@samba.org>
Cc: Matthew Wilcox <willy@debian.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@osdl.org>, Greg KH <greg@kroah.com>
Subject: Re: pci_domain_nr vs. /sys/devices
Message-ID: <20030617135548.GO30843@parcelfarce.linux.theplanet.co.uk>
References: <1055341842.754.3.camel@gaston> <20030611144801.GZ28581@parcelfarce.linux.theplanet.co.uk> <20030617044948.GA1172@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030617044948.GA1172@krispykreme>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 17, 2003 at 02:49:48PM +1000, Anton Blanchard wrote:
> I like it. I think we do need the bus number in the top level since we
> could have multiple host bridges on the same domain. I put a quick patch
> together, it lays things out as such:
> 
> /sys/devices/pci0002:00/0002:00:02.2

Yep, I have a patch to do the same thing.  Sorry, didn't realise you
were working on this too; I should've cc'd you.

> It also adds the domain to /proc/pci (are there userspace tools that
> parse this directly?):
> 
>   Domain  2, Bus  0, device   2, function  2:

Probably ;-(

> And only creates /proc/bus/pci entries for the first domain. I was going
> to extend it one level to encode the domain but I now think we should just
> move that functionality into sysfs and be done with it. Willy, you had a
> patch that exposed BARS etc in sysfs didnt you? X and lspci etc will need
> updating to match, but they are currently broken.

Yes.  Some people felt my patch didn't go far enough (they wanted
_everything_ as its own little file, and damn the dentry/inode
consumption!), but it's resurrectable.

My personal feeling is that we should leave the resources file alone
(except for fixing its formatting; patch already with greg), expose the
config file and expose the contents of the resources.

> I chose to add the domain into dev->slot_name since its needed for matching
> kernel messages to drivers. Im wondering if we should make this conditional
> on pci domain support since it does add some noise for those who couldnt
> care less about domains.

I think we probably shouldn't since that requires additional testing &
fixing of stuff for those of us with multiple-domain boxes.

> Finally there was some shuffling required to make pci_bus_exists work
> (passing in a pci_bus *, ->sysdata and ->number must be initialised
> before calling it). There are some uses of pci_bus_exists in x86 that
> will need updating.

I actually eliminated pci_bus_exists() completely in my tree.
pci_find_bus() does the job just as well.

> Thoungts?

We're definitely moving in the same direction ;-)

Here's one place we differ...

> ===== drivers/pci/proc.c 1.29 vs edited =====
> --- 1.29/drivers/pci/proc.c	Wed Jun 11 02:33:14 2003
> +++ edited/drivers/pci/proc.c	Tue Jun 17 09:32:20 2003
> @@ -382,6 +382,10 @@
>  	if (!proc_initialized)
>  		return -EACCES;
>  
> +	/* Backwards compatibility for domain 0 only */
> +	if (pci_domain_nr(dev->bus) != 0)
> +		return 0;
> +
>  	if (!(de = bus->procdir)) {
>  		sprintf(name, "%02x", bus->number);
>  		de = bus->procdir = proc_mkdir(name, proc_bus_pci_dir);

I create them anyway, but put the domain on the front.  I bet that'll
break Alpha too (I've read further in the thread but need to reply from
here ..)

> @@ -470,8 +474,9 @@
>  	pci_read_config_byte (dev, PCI_LATENCY_TIMER, &latency);
>  	pci_read_config_byte (dev, PCI_MIN_GNT, &min_gnt);
>  	pci_read_config_byte (dev, PCI_MAX_LAT, &max_lat);
> -	seq_printf(m, "  Bus %2d, device %3d, function %2d:\n",
> -	       dev->bus->number, PCI_SLOT(dev->devfn), PCI_FUNC(dev->devfn));
> +	seq_printf(m, "  Domain %2d, Bus %2d, device %3d, function %2d:\n",
> +	       pci_domain_nr(dev->bus), dev->bus->number, PCI_SLOT(dev->devfn),
> +	       PCI_FUNC(dev->devfn));
>  	class = pci_class_name(class_rev >> 16);
>  	if (class)
>  		seq_printf(m, "    %s", class);

I'd prefer not to touch it.

> ===== include/linux/pci.h 1.90 vs edited =====
> --- 1.90/include/linux/pci.h	Wed Jun 11 16:49:42 2003
> +++ edited/include/linux/pci.h	Tue Jun 17 10:27:32 2003
> @@ -414,7 +414,7 @@
>  	struct resource dma_resource[DEVICE_COUNT_DMA];
>  	struct resource irq_resource[DEVICE_COUNT_IRQ];
>  
> -	char		slot_name[8];	/* slot name */
> +	char		slot_name[13];	/* slot name */
>  
>  	/* These fields are used by common fixups */
>  	unsigned int	transparent:1;	/* Transparent PCI bridge */

Let's make slot_name a pointer to the struct device busid.

-- 
"It's not Hollywood.  War is real, war is primarily not about defeat or
victory, it is about death.  I've seen thousands and thousands of dead bodies.
Do you think I want to have an academic debate on this subject?" -- Robert Fisk
