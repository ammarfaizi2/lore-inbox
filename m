Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132642AbRDGMQT>; Sat, 7 Apr 2001 08:16:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132644AbRDGMQI>; Sat, 7 Apr 2001 08:16:08 -0400
Received: from front7.grolier.fr ([194.158.96.57]:36064 "EHLO
	front7.grolier.fr") by vger.kernel.org with ESMTP
	id <S132642AbRDGMP6> convert rfc822-to-8bit; Sat, 7 Apr 2001 08:15:58 -0400
Date: Sat, 7 Apr 2001 11:04:38 +0200 (CEST)
From: =?ISO-8859-1?Q?G=E9rard_Roudier?= <groudier@club-internet.fr>
To: Michael Reinelt <reinelt@eunet.at>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Multi-function PCI devices
In-Reply-To: <3ACECA8F.FEC9439@eunet.at>
Message-ID: <Pine.LNX.4.10.10104071043360.1085-100000@linux.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 7 Apr 2001, Michael Reinelt wrote:

> Hi there,
> 
> I've got a problem with my communication card: It's a PCI card with a
> NetMos chip, and it provides two serial and one parallel port. It's not
> officially supported by the linux kernel, so I wrote my own patch and
> sent it to the parallel, serial and pci maintainer. The patch itself is
> basically an extension of the pci id tables; and I hope it's in the
> queue for the official kernel. 
> 
> The patch worked great for me with kernel 2.4.1 and .2, but no longer
> with 2.4.3. The parallel port still works, but the serial port will not
> be detected. I had a quite long debugging session last night (adding
> printk's to the pci code takes some time, for you have to reboot to load
> the new kernel), and I think I found the reason:
> 
> The card shows up on the PCI bus as one device. For the card provides
> both serial and parallel ports, it will be driven by two subsystems, the
> serial and the parallel driver.

Given your description, this board is certainly not a multi-fonction PCI
device. Multi-function PCI devices provide separate resources for each
function in a way that allows each function to be driven by separate
software drivers. A single function PCI device that provides several
functionnalities commonly handled by separate sub-systems, is nothing but
a bag of shit we should not want to support in any O/S in my opinion.
Let me claim that ingenieers that want O/Ses to support such hardware are
either morons or bastards.

> I found that _either_ the parallel or the serial port works, depending
> on which module you load first. The reason for this seems to be in
> pci.c, especially in the pci_register_driver() function. It reads:
> 
> int pci_register_driver(struct pci_driver *drv)
> {
> 	struct pci_dev *dev;
> 	int count = 0;
> 
> 	list_add_tail(&drv->node, &pci_drivers);
> 	pci_for_each_dev(dev) {
> 		if (!pci_dev_driver(dev))
> 			count += pci_announce_device(drv, dev);
> 	}
> 	return count;
> }
> 
> 
> pci_announce_device() will be called only if there's no other driver
> claiming the device. This explains why either the parallel or the serial
> port will be detected: The first driver loaded will see the device, the
> next drivers won't.
> 
> I'm afraid this is not a bug, but a design issue, and will be hard to
> solve. Maybe we need a flag for such devices which allows it to be
> claimed ba more thean one driver?
> 
> In the meantime, what can I do to get both ports working?

Since the hardware does not allows the software to transparently share the
different functionnalities provided by the silicium, you must handle such
sharing by software. I mean, you must, at least, write a module (or
sub-driver or sub-system) that will handle the sharing of the PCI
function. Band-aiding the kernel code in order to cope with such
brain-deaded hardware would be a pity, in my opinion. Burden must stay
where it is deserved. If they want their 'save 0.01$ but push shit ahead'
hardware to be supported, they should write their drivers themselves, in
my opinion.

  Gérard.


