Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132608AbRDGIHh>; Sat, 7 Apr 2001 04:07:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132611AbRDGIH1>; Sat, 7 Apr 2001 04:07:27 -0400
Received: from panchito.Austria.EU.net ([193.154.160.103]:44701 "EHLO
	relay3.austria.eu.net") by vger.kernel.org with ESMTP
	id <S132608AbRDGIHH>; Sat, 7 Apr 2001 04:07:07 -0400
Message-ID: <3ACECA8F.FEC9439@eunet.at>
Date: Sat, 07 Apr 2001 10:06:39 +0200
From: Michael Reinelt <reinelt@eunet.at>
Organization: netWorks
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Multi-function PCI devices
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-AntiVirus: OK (checked by AntiVir Version 6.6.0.12)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,

I've got a problem with my communication card: It's a PCI card with a
NetMos chip, and it provides two serial and one parallel port. It's not
officially supported by the linux kernel, so I wrote my own patch and
sent it to the parallel, serial and pci maintainer. The patch itself is
basically an extension of the pci id tables; and I hope it's in the
queue for the official kernel. 

The patch worked great for me with kernel 2.4.1 and .2, but no longer
with 2.4.3. The parallel port still works, but the serial port will not
be detected. I had a quite long debugging session last night (adding
printk's to the pci code takes some time, for you have to reboot to load
the new kernel), and I think I found the reason:

The card shows up on the PCI bus as one device. For the card provides
both serial and parallel ports, it will be driven by two subsystems, the
serial and the parallel driver.

I found that _either_ the parallel or the serial port works, depending
on which module you load first. The reason for this seems to be in
pci.c, especially in the pci_register_driver() function. It reads:

int pci_register_driver(struct pci_driver *drv)
{
	struct pci_dev *dev;
	int count = 0;

	list_add_tail(&drv->node, &pci_drivers);
	pci_for_each_dev(dev) {
		if (!pci_dev_driver(dev))
			count += pci_announce_device(drv, dev);
	}
	return count;
}


pci_announce_device() will be called only if there's no other driver
claiming the device. This explains why either the parallel or the serial
port will be detected: The first driver loaded will see the device, the
next drivers won't.

I'm afraid this is not a bug, but a design issue, and will be hard to
solve. Maybe we need a flag for such devices which allows it to be
claimed ba more thean one driver?

In the meantime, what can I do to get both ports working?

TIA, Michael

-- 
netWorks       	                                  Vox: +43 316  692396
Michael Reinelt                                   Fax: +43 316  692343
Geisslergasse 4					  GSM: +43 676 3079941
A-8045 Graz, Austria			      e-mail: reinelt@eunet.at
