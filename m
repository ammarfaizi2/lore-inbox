Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261990AbUKPO4v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261990AbUKPO4v (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 09:56:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261996AbUKPO4v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 09:56:51 -0500
Received: from sv1.lisha.ufsc.br ([150.162.62.1]:44705 "EHLO sv1.lisha.ufsc.br")
	by vger.kernel.org with ESMTP id S261990AbUKPO4W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 09:56:22 -0500
From: Thiago Robert dos Santos <robert@lisha.ufsc.br>
Message-ID: <33229.150.162.62.34.1100616978.squirrel@150.162.62.34>
Date: Tue, 16 Nov 2004 12:56:18 -0200 (BRDT)
Subject: [Fwd: PCI mapper]
To: linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.3a-0.f1.1
X-Mailer: SquirrelMail/1.4.3a-0.f1.1
MIME-Version: 1.0
Content-Type: multipart/mixed;boundary="----=_20041116125618_84016"
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_20041116125618_84016
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

All,


  I have developed a module that maps a given device's memory into user
space.
The module is very simple (see the source code attached). It just
defines the following file operations: open, release, ioctl and mmap.

   I'm having a problem in porting this module to the 2.6 series.
Apparently, everything is working fine but I just can't access the
device's memory (even tough I get a valid point from the mmap system
call).

    Can anyone help me?


Thanks in advance.

------=_20041116125618_84016
Content-Type: text/x-csrc; name="pcimap.c"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="pcimap.c"

#include <linux/init.h>
#include <linux/module.h>
#include <linux/moduleparam.h>
#include <linux/version.h>

#include <linux/config.h>
#include <linux/kernel.h>
#include <linux/errno.h>

#include <linux/fs.h>		/* for file_operations */
#include <linux/pci.h>		/* for pci_find_device */
#include <linux/slab.h>		/* for kmalloc */
#include <asm/segment.h>	/* for memcpy */
#include <asm/io.h>		/* for virt_to_phys */
#include <linux/byteorder/little_endian.h>

// TODO: Deveria ser definido no Makefile
#define DBLEV 31

#include "debug.h"
#include "pcimap.h"


MODULE_AUTHOR ("Thiago Robert");
MODULE_DESCRIPTION ("PCI Device Mapper");
MODULE_LICENSE ("GPL");


/* MODULE PARAMETERS */
int dev = PCIMAP_MAJOR;
int n_devs = PCIMAP_N_DEVS;
int vendor_id = VENDOR_ID;
int device_id = DEVICE_ID;

module_param (dev, int, 0);	// PCI Map major device number
module_param (n_devs, int, 0);	// Number of PCI Map devices
module_param (vendor_id, int, 0);	// PCI vendor id
module_param (device_id, int, 0);	// PCI device id


/* Offset for PCI Regions */
static const int pciregs[PCIMAP_N_REGS] = {
	PCI_BASE_ADDRESS_0,
	PCI_BASE_ADDRESS_1,
	PCI_BASE_ADDRESS_2,
	PCI_BASE_ADDRESS_3,
	PCI_BASE_ADDRESS_4,
	PCI_BASE_ADDRESS_5
};


/* Mapped PCI devices */
static struct PCI_Device *pcidevs;


static int
pcimap_open (struct inode *inode, struct file *filp)
{
	int unit = 0, reg = 0;

	unit = iminor (inode) >> 4;
	reg = iminor (inode) & 0x0f;

	debug (DB_TRACE, "PCIMAP: pcimap_open(unit=%d,reg=%d)\n", unit, reg);

	if ((unit >= n_devs) || (!pcidevs[unit].found)
	    || reg >= PCIMAP_N_REGS)
		return -ENODEV;

	if (!pcidevs[unit].reg[reg].size)
		return -ENODEV;

	/* PCI Map devices are not sharable */
	if (pcidevs[unit].reg[reg].busy)
		return -EBUSY;

	pcidevs[unit].reg[reg].busy = 1;

	return 0;
}

static int
pcimap_close (struct inode *inode, struct file *filp)
{
	int unit = 0, reg = 0;

	unit = iminor (inode) >> 4;
	reg = iminor (inode) & 0x0f;

	debug (DB_TRACE, "PCIMAP: pcimap_close(unit=%d,reg=%d)\n", unit, reg);

	pcidevs[unit].reg[reg].busy = 0;

	return 0;
}

static int
pcimap_mmap2 (struct file *filp, struct vm_area_struct *vma)
{
	int unit, reg;
	unsigned long size, phy_addr;

    unit = MINOR(filp->f_dentry->d_inode->i_rdev) >> 4;
    reg = MINOR(filp->f_dentry->d_inode->i_rdev) & 0x0f;

	size = vma->vm_end - vma->vm_start;

	debug (DB_TRACE,
	       "DEBUG: pcimap_mmap(unit=%d,reg=%d,start=%lx,size=%lx,off=%lx)\n",
	       unit, reg, vma->vm_start, size, vma->vm_pgoff * PAGE_SIZE);

	/* Mapping must be page aligned and not larger than the region size */
	if ((size + vma->vm_pgoff * PAGE_SIZE) > pcidevs[unit].reg[reg].size)
    {
		return -EINVAL;
    }

	/* Get device's memory physical address for mapping */
	phy_addr =
		pcidevs[unit].reg[reg].phy_addr + vma->vm_pgoff * PAGE_SIZE;

	/* Isn't it necessary to call ioremap_nocache? how? */
//	 vma->vm_start = (unsigned int) ioremap_nocache(phy_addr, size); 
	 

	/* Map device's memory in the requested address space range */
	if (remap_page_range (vma, phy_addr, 0, size, vma->vm_page_prot))
    {
		return -EAGAIN;
    }
    
	filp->f_dentry->d_inode->i_count.counter++;

	return 0;
}

static int
pcimap_mmap (struct file *filp, struct vm_area_struct *vma)
{
    
    // /lib/modules/2.6.5-1.358/build/include/linux/mm.h --> definicao vm_area_stuct
    
	int unit, reg;
	unsigned long size, phy_addr;

    unit = MINOR(filp->f_dentry->d_inode->i_rdev) >> 4;
    reg = MINOR(filp->f_dentry->d_inode->i_rdev) & 0x0f;

	size = vma->vm_end - vma->vm_start;

	debug (DB_TRACE,
	       "PCIMAP: pcimap_mmap(unit=%d,reg=%d,start=%lx,size=%lx,off=%lx)\n",
	       unit, reg, vma->vm_start, size, vma->vm_pgoff * PAGE_SIZE);

	debug (DB_TRACE,
	       "DEBUG: pcimap_mmap(vm_end=%lx, vm_start=%lx, vm_pgoff=%lx, PAGE_SIZE=%lx)\n",
	       vma->vm_end, vma->vm_start, vma->vm_pgoff, PAGE_SIZE);

	/* Mapping must be page aligned and not larger than the region size */
	if ((size + vma->vm_pgoff * PAGE_SIZE) > pcidevs[unit].reg[reg].size)
    {
		return -EINVAL;
    }

	/* Get device's memory physical address for mapping */
	phy_addr =
		pcidevs[unit].reg[reg].phy_addr + vma->vm_pgoff * PAGE_SIZE;
    
	debug (DB_TRACE,
	       "DEBUG: pcimap_mmap(phy=%lx, phy2=%x)\n", phy_addr, pcidevs[unit].reg[reg].phy_addr);
    

	/* Isn't it necessary to call ioremap_nocache? how? */
//    vma->vm_start = (unsigned int) ioremap_nocache(phy_addr, size); 
	 

	/* Map device's memory in the requested address space range */
	if (remap_page_range (vma, phy_addr, 0, size, vma->vm_page_prot))
    {
		return -EAGAIN;
    }
    
	filp->f_dentry->d_inode->i_count.counter++;

	debug (DB_TRACE,
	       "DEBUG: pcimap_mmap(counter=%d)\n", filp->f_dentry->d_inode->i_count.counter);
    
	return 0;
}

static int
pcimap_ioctl (struct inode *inode, struct file *filp, unsigned int cmd,
	      unsigned long arg)
{
	int unit = 0, reg = 0;

	unit = iminor (inode) >> 4;
	reg = iminor (inode) & 0x0f;

	debug (DB_TRACE,
	       "PCIMAP: pcimap_ioctl(unit=%d,reg=%d,cmd=%x,arg=%lx)\n", unit,
	       reg, cmd, arg);

	switch (cmd)
	{
	case PCIMAP_GET_SIZE:	/* Return DMA buffer's size */
		return pcidevs[unit].reg[reg].size;
		break;
	case PCIMAP_GET_PHY_ADDR:	/* Return DMA buffer's physical address */
		return pcidevs[unit].reg[reg].phy_addr;
		break;

	default:
		return -EINVAL;
	}

	return 0;
}


/* PCIMAP FILE OPERATIONS */
struct file_operations pcimap_fops = {
	.mmap = pcimap_mmap,	/* mmap */
	.ioctl = pcimap_ioctl,	/* ioctl */
	.open = pcimap_open,	/* open */
	.release = pcimap_close,	/* close */
};


int
pcimap_init (void)
{
	int i, j, err;
	struct pci_dev *pci_dev;

	debug (DB_TRACE,
	       "PCIMAP: Loading PCI Map(dev=%d,n_devs=%d,vendor_id=%x,device_id=%x)\n",
	       dev, n_devs, vendor_id, device_id);

	/* Check for mandatory module parameters */
	if ((vendor_id == -1) || (device_id == -1))
	{
		printk (KERN_WARNING
			"PCI vendor and device id must be specified!\n");
		return -EINVAL;
	}

	/* Allocate the control structure for PCI Maps */
	pcidevs = kmalloc (n_devs * sizeof (struct PCI_Device), GFP_KERNEL);
	if (!pcidevs)
	{
		return -ENOMEM;
	}
	memset (pcidevs, 0, n_devs * sizeof (struct PCI_Device));

	i = 0;
	pci_dev = NULL;
	do
	{
		/* Look for our PCI device */
		pci_dev = pci_find_device (vendor_id, device_id, pci_dev);
		if (!pci_dev)
		{
			break;
		}

		/* (Re)configure device for bus mastering */
		pci_read_config_word (pci_dev, PCI_COMMAND, &pcidevs[i].cmd);
		if (!(pcidevs[i].cmd & PCI_COMMAND_MEMORY))
		{
			pcidevs[i].cmd |= PCI_COMMAND_MEMORY;
			debug (DB_WARNING,
			       "PCIMAP: PCI_COMMAND_MEMORY not set for device!\n");
		}

		if (!(pcidevs[i].cmd & PCI_COMMAND_MASTER))
		{
			pcidevs[i].cmd |= PCI_COMMAND_MASTER;
			debug (DB_WARNING,
			       "PCIMAP: PCI_COMMAND_MASTER not set for device!\n");
		}
		if (!(pcidevs[i].cmd & PCI_COMMAND_INVALIDATE))
		{
			pcidevs[i].cmd |= PCI_COMMAND_INVALIDATE;
			debug (DB_WARNING,
			       "PCIMAP: PCI_COMMAND_INVALIDATE not set for device!\n");
		}
		pci_write_config_word (pci_dev, PCI_COMMAND, pcidevs[i].cmd);

		/* Get device's configuration */
		pci_read_config_word (pci_dev, PCI_COMMAND, &pcidevs[i].cmd);
		pci_read_config_word (pci_dev, PCI_STATUS, &pcidevs[i].stat);
		pci_read_config_byte (pci_dev, PCI_REVISION_ID,
				      &pcidevs[i].rev);

		/* Get regions */
		for (j = 0; j < PCIMAP_N_REGS; j++)
		{

			/* Get reagion info */
			pci_read_config_dword (pci_dev, pciregs[j],
					       &pcidevs[i].reg[j].phy_addr);
			pci_write_config_dword (pci_dev, pciregs[j], ~0);
			pci_read_config_dword (pci_dev, pciregs[j],
					       &pcidevs[i].reg[j].size);
			pci_write_config_dword (pci_dev, pciregs[j],
						pcidevs[i].reg[j].phy_addr);

			/* Check for memory region     */
			if (!pcidevs[i].reg[j].size
			    || (pcidevs[i].reg[j].
				phy_addr & PCI_BASE_ADDRESS_SPACE_IO))
			{
				pcidevs[i].reg[j].phy_addr = 0;
				pcidevs[i].reg[j].size = 0;
				continue;
			}

			/* We only handle 32 bit addressed memory above 1 Mb */
			if ((pcidevs[i].reg[j].
			     phy_addr & PCI_BASE_ADDRESS_MEM_TYPE_MASK) &
			    (PCI_BASE_ADDRESS_MEM_TYPE_1M |
			     PCI_BASE_ADDRESS_MEM_TYPE_64))
			{
				pcidevs[i].reg[j].phy_addr = 0;
				pcidevs[i].reg[j].size = 0;
				continue;
			}

			/* Adjust address and size */
			pcidevs[i].reg[j].phy_addr &=
				PCI_BASE_ADDRESS_MEM_MASK;
			pcidevs[i].reg[j].size =
				~(pcidevs[i].reg[j].
				  size & PCI_BASE_ADDRESS_MEM_MASK) + 1;

			pcidevs[i].regs |= 1 << j;
		}

		if (pcidevs[i].regs)
		{
			pcidevs[i].found = 1;
		}

/*		debug (DB_INFO, "PCIMAP: debug\n");
		debug (DB_INFO, "pcidev[%d]->ctrl=%x\n", i, pcidevs[i].cmd);
		debug (DB_INFO, "pcidev[%d]->stat=%x\n", i, pcidevs[i].stat);
		debug (DB_INFO, "pcidev[%d]->rev=%x\n", i, pcidevs[i].rev);
		debug (DB_INFO, "pcidev[%d]->regs=%x\n", i, pcidevs[i].regs);
		for (j = 0; j < PCIMAP_N_REGS; j++)
		{
			if (pcidevs[i].reg[j].size)
			{
				debug (DB_INFO,
				       "pcidev[%d]->reg[%d]->phy_addr=%x\n",
				       i, j, pcidevs[i].reg[j].phy_addr);
				debug (DB_INFO,
				       "pcidev[%d]->reg[%d]->size=%d\n", i, j,
				       pcidevs[i].reg[j].size);
			}
		}
*/
	}
	while ((++i < n_devs) && pci_dev);

	if (i == 0)
	{
		kfree (pcidevs);
		return -ENODEV;
	}

	/* Register the device driver */
	err = register_chrdev (dev, "pcimap", &pcimap_fops);
	if (err < 0)
	{
		return err;
	}

	return 0;
}


void
pcimap_exit (void)
{
	debug (DB_TRACE, "PCIMAP: Unloading PCI Map\n");

	/* Unregister the device driver */
	unregister_chrdev (dev, "pcimap");

	/* Release PCI Maps control structure */
	kfree (pcidevs);
}


module_init (pcimap_init);
module_exit (pcimap_exit);
------=_20041116125618_84016
Content-Type: text/x-chdr; name="pcimap.h"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="pcimap.h"

#ifndef PCIMAP_H
#define PCIMAP_H


#include <linux/ioctl.h>


#define PCIMAP_MAJOR 125
#define PCIMAP_N_DEVS 2
#define PCIMAP_N_REGS 6
#define VENDOR_ID 0x14C1
#define DEVICE_ID 0x8043


#define PCIMAP_GET_SIZE _IOR(PCIMAP_MAJOR, 0, unsigned long)
#define PCIMAP_GET_PHY_ADDR _IOR(PCIMAP_MAJOR, 1, unsigned long)


struct PCI_Region
{
	int busy;
	unsigned int phy_addr;
	unsigned int size;
};

struct PCI_Device
{
	int found;
	unsigned short cmd;
	unsigned short stat;
	unsigned char rev;
	int regs;
	struct PCI_Region reg[PCIMAP_N_REGS];
};

#endif /* PCIMAP_H */
------=_20041116125618_84016
Content-Type: text/x-chdr; name="debug.h"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="debug.h"

typedef enum
{
	DB_ABORT,
	DB_ERROR,
	DB_WARNING,
	DB_INFO,
	DB_TRACE
} Debug_Level;

void debug (Debug_Level level, const char *format, ...);

#ifdef DBLEV
extern char *debug_levels[];

#define debug(level, format, args...) \
  if((1 << level) & (DBLEV))\
    printk(KERN_INFO format, ## args);

#else /* DBLEV */

#define debug(level, format, args...)

#endif /* DBLEV */
------=_20041116125618_84016
Content-Type: application/octet-stream; name="Makefile"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="Makefile"

ICAgIGlmbmVxICgkKEtFUk5FTFJFTEVBU0UpLCkKICAgIG9iai1tCTo9IHBjaW1hcC5vCgogICAg
ZWxzZQogICAgS0RJUgk6PSAvbGliL21vZHVsZXMvJChzaGVsbCB1bmFtZSAtcikvYnVpbGQKICAg
IFBXRAkJOj0gJChzaGVsbCBwd2QpCgogICAgZGVmYXVsdDogcGNpbWFwX3Rlc3QKCSQoTUFLRSkg
LUMgJChLRElSKSBTVUJESVJTPSQoUFdEKSBtb2R1bGVzCiAgICBlbmRpZgoKICAgIGNsZWFuOgoJ
cm0gKi5vIHBjaW1hcF90ZXN0ICoua28gcGNpbWFwLm1vZC5jCgogICAgZGlzdGNsZWFuOiBjbGVh
bgo=
------=_20041116125618_84016
Content-Type: text/x-csrc; name="pcimap_test.c"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="pcimap_test.c"

#include <unistd.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <fcntl.h>
#include <sys/mman.h>
#include <sys/ioctl.h>

#include "pcimap.h"

int
main (int argc, char *argv[])
{
	int i, fd0;
	char * ptr = NULL;
	unsigned long phy_addr, size;

	if (argc != 4)
	{
		fprintf (stderr, "Usage: %s device offset size!\n", argv[0]);
		return -1;
	}

	fd0 = open (argv[1], O_RDWR);
	if (fd0 < 0)
	{
		perror ("open");
		return -1;
	}

	size = ioctl (fd0, PCIMAP_GET_SIZE, NULL);
	if (size < 0)
	{
		perror ("ioctl");
		return -1;
	}
	printf ("PCI device memory size: %ld\n", size);

	phy_addr = ioctl (fd0, PCIMAP_GET_PHY_ADDR, NULL);
	if (phy_addr < 0)
	{
		perror ("ioctl");
		return -1;
	}
	printf ("PCI device memory physical address: %lx\n", phy_addr);

	ptr = (char *) mmap (0, atoi (argv[3]), PROT_READ | PROT_WRITE,
			     MAP_SHARED, fd0, atoi (argv[2]));
	if ((int) ptr == -1)
	{
        printf ("Error code: %d\n", (int) ptr);
		perror ("mmap");
		return -1;
	}
	else
	{
		printf ("PCI device memory logical address: %p\n", ptr);
//		strcpy (ptr, "PCIMAP test OK!");
		printf ("PCI device memory contents: ");
		for (i = atoi (argv[2]); i < atoi (argv[3]); i++)
        {
//            printf("%c", ptr[i]);
			putchar (ptr[i]);
		}
		putchar ('\n');
	}

	close (fd0);

	return 0;
}
------=_20041116125618_84016--

