Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262581AbSJGRS2>; Mon, 7 Oct 2002 13:18:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262584AbSJGRS2>; Mon, 7 Oct 2002 13:18:28 -0400
Received: from mta4.rcsntx.swbell.net ([151.164.30.28]:30700 "EHLO
	mta4.rcsntx.swbell.net") by vger.kernel.org with ESMTP
	id <S262581AbSJGRSZ>; Mon, 7 Oct 2002 13:18:25 -0400
Date: Mon, 07 Oct 2002 12:24:47 -0500
From: Patrick Jennings <jennings@red-river.com>
Subject: New PCI Device Driver
To: LKML <linux-kernel@vger.kernel.org>
Message-id: <NFBBJBMDCLFFHHFEAKNAMEEHCBAA.jennings@red-river.com>
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

Hello All:

I have been tasked with writing a driver for my companies digital radio.
The card has 16K of PCI space at BAR0.  I need to memory map this into user
space, and provide DMA and isr handling.  First things first i want to get
the mapping working.   When i run the code below after inserting the module
i seg. fault.  I know this is what happens when engineers have to write
code, but can someone point me in the right direction?

Thanks!!!

/Patrick

+========================================================+
Patrick Jennings       | jennings@red-river.com
Red River              | Direct Phone   (972) 671-9636
Radio Products Group   | Main Phone     (972) 671-9570
797 North Grove Road   | Fax            (972) 671-9572
Suite 101              | www.red-river.com
Richardson,TX  75081   |


[driver.c]
#define VEND_ID 0x1171
#define DEV_ID 0xA050

#define CARD_NAME "Model 300"
#define M300_MAJOR 240


int redriver_init_module(void)
{
	int status;
	struct pci_dev *pcidev=NULL;
	unsigned long databuf;

	printk("<1>Red River Module Init\n");
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


	redriver_device_data.io_base_start = (unsigned long
*)pci_resource_start(pcidev, 0);
	redriver_device_data.io_base_stop = (unsigned long
*)pci_resource_end(pcidev, 0);

	printk("M300:IO_BASE: 0x%x\n", redriver_device_data.io_base_start);
	databuf = *(redriver_device_data.io_base_start+(0x590));
	printk("Firm rev register 0x%x\n",databuf);
	return 0;
}


int redriver_remap_mmap(struct file * flip, struct vm_area_struct *vma)
{

	vma->vm_flags |= (VM_RESERVED | VM_IO);

	if(remap_page_range(vma->vm_start, redriver_device_data.io_base_start,
vma->vm_end-vma->vm_start,vma->vm_page_prot))
		return -EAGAIN;

	vma->vm_ops = &redriver_remap_vm_ops;
	redriver_vma_open(vma);
	return 0;
}


module_init(redriver_init_module);
module_exit(redriver_cleanup_module);


[testprog.c]
int main(void)
{
	int fd;
	unsigned long  *vadr;
	unsigned long read_data;

	printf("%s\n",PROG_NAME);
	printf("%s\n",__DATE__);

	fd = open("/dev/model300_0", O_RDWR);
	if(fd == -1)
	{
		printf("Error opening device\n");
		return(-1);
	}
	else
	{
		printf("Device opend OK\n");
	}

	vadr = mmap(NULL, 0x, PROT_READ|PROT_WRITE, MAP_SHARED, fd, 0);
	if(vadr)
	{
		printf("Error opening memory!\n");
		exit(-1);
	}

	read_data = *(vadr+0x590/4) //Read 0x590 firm reg register
	printf("Data is 0x%x\n",read_data);
	close(fd);
return(0);
}


