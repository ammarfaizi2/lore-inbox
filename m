Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315291AbSDWSVw>; Tue, 23 Apr 2002 14:21:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315292AbSDWSVv>; Tue, 23 Apr 2002 14:21:51 -0400
Received: from exchange.macrolink.com ([64.173.88.99]:32019 "EHLO
	exchange.macrolink.com") by vger.kernel.org with ESMTP
	id <S315291AbSDWSVs>; Tue, 23 Apr 2002 14:21:48 -0400
Message-ID: <11E89240C407D311958800A0C9ACF7D13A77B1@EXCHANGE>
From: Ed Vance <EdV@macrolink.com>
To: "'Gabor Kerenyi'" <wom@tateyama.hu>
Cc: linux-kernel@vger.kernel.org
Subject: RE: unconfigure PCI dev
Date: Tue, 23 Apr 2002 11:21:41 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gabor Kerenyi wrote:
> 
> I've got a strange problem.
> 
> I'm writing a driver for a PCI card.
> The card has a problem because the serial eeprom where the pci 
> configuration data is loaded from is not valid and therefore 
> the PLX-9050 chip gives some default value. It shows vendor:devid 
> as 10b5:9050 and the kernel identifies it as a PLX PCI <-> IOBus 
> Bridge. (kernel 2.5.7)
> 
> The serial eeprom can be read written at 50h in the local config 
> area. When I load my driver and it wants to request a memory 
> region it seems that it is already mapped. (I modified the driver 
> to look for 0x10b5:9050)
> 
> So it fails. 
> 
> The cat /proc/pci shows a memory region at 0xf4200000. 
> 
> int plc_init_dev1(struct pci_dev *dev)
> {
> 	printk("%x\n", pci_resource_start(dev, 0);
> 	return -EBUSY;
> 	if (check_mem_region(pci_resource_start(dev, 0), 128))
> 		return -EBUSY;
> }
> 
> So why is it already in use?
> I have to access that memory area. How can I do it if my driver 
> doesn't load? That's the only way to modify the eeprom contents.

Hi Gabor,

I assume you are referring to the single-bit-wide EEPROM interface in 
bits 24-28 of the PLX-9050 CNTRL register at offset 0x50 in PCI 
configuration space. 

Your pci_resource_start call is attempting to map BAR0, not PCI 
configuration space. You need to use the other series of pci_* calls 
that access config space, in particular, the pci_*_config_* series.

>From /usr/src/linux*/Documentation/pci.txt:

<start quote>
4. How to access PCI config space
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   You can use pci_(read|write)_config_(byte|word|dword) to access the 
config space of a device represented by struct pci_dev *. All these 
functions return 0 when successful or an error code (PCIBIOS_...) which 
can be translated to a text string by pcibios_strerror. Most drivers 
expect that accesses to valid PCI devices don't fail.

   If you access fields in the standard portion of the config header, 
please use symbolic names of locations and bits declared in <linux/pci.h>.
<end quote>

Good luck,
Ed Vance

---------------------------------------------------------------- 
Ed Vance              edv@macrolink.com
Macrolink, Inc.       1500 N. Kellogg Dr  Anaheim, CA  92807
----------------------------------------------------------------
