Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265168AbSLMRAM>; Fri, 13 Dec 2002 12:00:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265169AbSLMRAM>; Fri, 13 Dec 2002 12:00:12 -0500
Received: from dsl-65-188-251-69.telocity.com ([65.188.251.69]:15236 "EHLO
	orr.homenet") by vger.kernel.org with ESMTP id <S265168AbSLMRAK>;
	Fri, 13 Dec 2002 12:00:10 -0500
Date: Fri, 13 Dec 2002 12:07:44 -0500
To: linux-kernel@vger.kernel.org
Subject: pci api question
Message-ID: <20021213170744.GA2881@orr.falooley.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
From: Jason Lunz <lunz@falooley.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have a userspace program that I'd like to port to the kernel. The only
thing it really does is flip a bit in a pci config register of my Via
northbridge.

I've got it mostly done, except that I'm not sure how to express what
the userspace program does using the linux pci api. The (very ugly)
userspace program, in a nutshell, does this:

	#define DWORD unsigned long

	DWORD PCIRead(int reg, int fn=0, int dev=0,int bus=0, int port=0xcf8)
	{
		DWORD r=0x80000000;
		DWORD ret,org;
		
		r|=(( bus & 0xff) <<16);
		r|=(( dev & 0x1f) <<11);
		r|=(( fn &  0x7 ) << 8);
		r|=(( reg & 0xfc) );
		
		org=inl(port);
		outl(r,port);
		ret=inl(port+4);
		outl(org,port);
		
		return ret;
	}

	void PCIWrite(DWORD val, int reg, int fn=0, int dev=0,int bus=0, int port=0xcf8)
	{
		DWORD r=0x80000000;
		DWORD org;
		
		r|=(( bus & 0xff) <<16);
		r|=(( dev & 0x1f) <<11);
		r|=(( fn &  0x7 ) << 8);
		r|=(( reg & 0xfc) );

		org=inl(port);
		outl(r,port);
		outl(val,port+4);
		outl(org,port);
	}
		
	void main(void) {
		DWORD res;

		res =PCIRead(0x52,0,0,0);
		printf("read %#.8x\n", res);
		res |= 0x00800000;
		printf("writing %#.8x\n", res);
		PCIWrite(res,0x52,0,0,0);
	}

this prints out

	read 0xb46ba417
	writing 0xb4eba417

I want to do this within the kernel. I have this (abridged):

	#include <linux/module.h>
	#include <linux/pci.h>

	static int __devinit via_nb_init(struct pci_dev *pdev, const struct pci_device_id *ent);
	static void __devexit via_nb_remove(struct pci_dev *pdev);

	static struct pci_device_id via_nb_tbl[] __devinitdata = {
		{PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_8363_0, PCI_ANY_ID, PCI_ANY_ID,},
		{PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_8371_0, PCI_ANY_ID, PCI_ANY_ID,},
		{0,}
	};

	static struct pci_driver via_nb_driver = {
		name:		"via83xx_pm-nb",
		id_table:	via_nb_tbl,
		probe:		via_nb_init,
		remove:		via_nb_remove,
	};

	static int __devinit
	via_nb_init(struct pci_dev *pdev, const struct pci_device_id *ent)
	{
		u32 enable;
		printk(KERN_INFO "via83xx_pm: Initializing northbridge %s\n", pdev->name);

		pci_read_config_dword(pdev, 0x52, &enable);
		printk(KERN_INFO "read %#.8x\n", enable);
		enable |= 0x00800000;
		printk(KERN_INFO "writing %#.8x to 0x52\n", enable);
		pci_write_config_dword(pdev, 0x52, enable);
		return 0;
	}

	static void __devexit
	via_nb_remove(struct pci_dev *pdev)
	{
		u32 enable;
		pci_read_config_dword(pdev, 0x52, &enable);
		printk(KERN_INFO "0x52 is %#.8x\n", enable);
		enable &= ~0x00800000;
		printk(KERN_INFO "would write %#.8x to 0x52\n", enable);
		pci_write_config_dword(pdev, 0x52, enable);
	}

	static int __init
	via83xx_pm_init(void)
	{
		found = pci_module_init(&via_nb_driver);
		if (found < 0) {
			printk(KERN_ERR "via83xx_pm: Could not find northbridge\n");
			return 1;
		}

		return 0;
	}

	static void __exit
	via83xx_pm_cleanup(void)
	{
		pci_unregister_driver(&via_nb_driver);
	}

	MODULE_LICENSE("GPL");
	module_init(via83xx_pm_init);
	module_exit(via83xx_pm_cleanup);

however, the pci_(read|write)_config_dword() calls seem to be changing
a different register than the userspace program. The kernel module
prints out these (very different) values:

	read 0xc12cc400
	would write 0xc1acc400

The userspace version works. The kernel one doesn't.  Any idea what I'm
doing wrong?

thanks, Jason
