Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261820AbSJIOqL>; Wed, 9 Oct 2002 10:46:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261818AbSJIOqL>; Wed, 9 Oct 2002 10:46:11 -0400
Received: from mta5.rcsntx.swbell.net ([151.164.30.29]:19870 "EHLO
	mta5.rcsntx.swbell.net") by vger.kernel.org with ESMTP
	id <S261817AbSJIOqF>; Wed, 9 Oct 2002 10:46:05 -0400
Date: Wed, 09 Oct 2002 09:52:36 -0500
From: Patrick Jennings <jennings@red-river.com>
Subject: PCI Driver developement
To: LKML <linux-kernel@vger.kernel.org>
Message-id: <NFBBJBMDCLFFHHFEAKNAAEKBCBAA.jennings@red-river.com>
MIME-version: 1.0
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 7BIT
Importance: Normal
X-Priority: 3 (Normal)
X-MSMail-priority: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stupid thing here.  Working on a driver for our digital radio, and I now get
following error when insmoding

	driver.o init_module: No such device

what is this telling me?

here is the code i think is important

<and yes i know about noy using <1>  it's on my to-do list :-) >

/patrick

+========================================================+
Patrick Jennings       | jennings@red-river.com
Red River              | Direct Phone   (972) 671-9636
Radio Products Group   | Main Phone     (972) 671-9570
797 North Grove Road   | Fax            (972) 671-9572
Suite 101              | www.red-river.com
Richardson,TX  75081   |

#define USE_PCI_REGISTER_DEVICES
#ifdef USE_PCI_REGISTER_DEVICES
	if((status = pci_module_init(&redriver_driver)) < 0)
	{
		printk("Red River Module Init Failed.  Maybe you don't have the harware
installed?\n");
		return(status);
	}
#else
	printk("<1>Red River Module (Old Way)\n");
	SET_MODULE_OWNER(&redriver_fops);

	pcidev = pci_find_device(VEND_ID, DEV_ID, pcidev);
	if(pcidev == NULL)
	{
		printk("<1>Couldn't find a red river device\n");
		return ENODEV;
	}

	status = pci_enable_device(pcidev);
	if(status)
	{
		printk("<1>Error enabling device\n");
		return(status);
	}

	status = register_chrdev(M300_MAJOR, CARD_NAME, &redriver_fops);
	if(status)
	{
		printk("<1>Couldn't register najor number for %s\n", CARD_NAME);
	}

	status = pci_read_config_byte(pcidev, PCI_INTERRUPT_LINE,
&redriver_device_data.irq);
	if(status)
	{
		printk("<1>RedRiver: Error getting IRQ\n");
	}
	printk("<1>Using IRQ %d\n",redriver_device_data.irq);

	redriver_device_data.io_base_start = (unsigned
long)pci_resource_start(pcidev, 0);
	redriver_device_data.io_base_stop = (unsigned long)pci_resource_end(pcidev,
0);
	redriver_device_data.size = pci_resource_len(pcidev,0);

/*
	status = request_irq(redriver_device_data.irq, redriver_irq,
SA_SHIRQ|SA_SAMPLE_RANDOM, "redriver");
*/
	printk("M300:IO_BASE: 0x%x\n", redriver_device_data.io_base_start);
	printk("M300:Size: 0x%x\n", redriver_device_data.size);

	return 0;
#endif
}



static int redriver_probe_pci(struct pci_dev * pcidev, const struct
pci_device_id * devid)
{
	int status;

	printk("<1>Enabling a Red River device (new way)\n");

	status = pci_enable_device(pcidev);
	if(status)
	{
		printk("<1>Error enabling device\n");
		return(status);
	}

	status = register_chrdev(M300_MAJOR, CARD_NAME, &redriver_fops);
	if(status)
	{
		printk("<1>Couldn't register najor number for %s\n", CARD_NAME);
	}

	status = pci_read_config_byte(pcidev, PCI_INTERRUPT_LINE,
&redriver_device_data.irq);
	if(status)
	{
		printk("<1>RedRiver: Error getting IRQ\n");
	}
	printk("<1>Using IRQ %d\n",redriver_device_data.irq);

	redriver_device_data.io_base_start = (unsigned
long)pci_resource_start(pcidev, 0);
	redriver_device_data.io_base_stop = (unsigned long)pci_resource_end(pcidev,
0);
	redriver_device_data.size = pci_resource_len(pcidev,0);

/*
	status = request_irq(redriver_device_data.irq, redriver_irq,
SA_SHIRQ|SA_SAMPLE_RANDOM, "redriver");
*/
	printk("M300:IO_BASE: 0x%x\n", redriver_device_data.io_base_start);
	printk("M300:Size: 0x%x\n", redriver_device_data.size);

	return(0);
}


