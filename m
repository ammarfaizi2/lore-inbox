Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263003AbUH0KHu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263003AbUH0KHu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 06:07:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263626AbUH0KHu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 06:07:50 -0400
Received: from imap.gmx.net ([213.165.64.20]:36750 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S263003AbUH0KGV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 06:06:21 -0400
Date: Fri, 27 Aug 2004 12:06:19 +0200 (MEST)
From: "Thorsten Kruse" <thokruse@gmx.de>
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Subject: Problem with driver for serial multiportcard
X-Priority: 3 (Normal)
X-Authenticated: #24177598
Message-ID: <20768.1093601179@www21.gmx.net>
X-Mailer: WWW-Mail 1.6 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, 
 
within my degree dissertation I'm writing a driver-module for the serial 
pci-multiport-card APCI-7800 (by ADDI-Data) under kernel 2.4.20, but I have
a huge 
problem: The card doesn't generate any interrupts. I've put the driver
through his 
paces and consulted some persons, but nobody recognized any error in my
drivercode 
(Marcelo Tosatti adviced me to post this problem to the linux-kernel mailing
list). 
Now I'm really despaired, because my project-time will finish in a few
weeks. I hope 
anyone can help me in any way. 
 
Here's the problem: The pci-card contains 8 standard UART's 16c654 and is
simply a 
dumb multiport card. Communication in pollingmode goes well, but no
interrupt will 
be released although all interrupts are activated in the IER (Interrupt
Enable 
Register). The card uses a interrupt-collector-register (SIR), which shows
the 
source of the interrupt (if it was UART 1 bit 1 is set to 1, if it was UART
2 bit 2 
is set and so on). When I'm reading the ISR (Interrupt Status Register),
which gives 
me the status of the pending interrupt, it shows the pending interrupts with
the 
right status. But the collector-register never contains another value than
zero. As 
the manufacturer assures this register is enabled all the time, I don't have
to 
initialize the card before starting. The only thing I have to do is
configuring the 
UARTs, of course. But it's no error of the card, because with the standard
serial 
driver the card works as requested (unfortunately my driver has to support
special 
features, which aren't provided by the standard driver). I don't know what's
going 
wrong, I made all possible configurations but every time the collector
register is 
zero. 
 
If anyone needs further information I will post it immediately. 
Beneath the text there is a short test-drivercode. At the bottom is the
sourcecode 
of the headerfile "addi_7800_sys.h". 
 
If anyone will give me any hints to solve this problem I would be very very
very 
thankful! 
 
 
Best regards 
Thorsten Kruse 
 
 
 
 
 
 
/********************************************************************** 
******************** Short driver for testing ************************* 
**********************************************************************/ 
 
 
#ifndef __KERNEL__ 
#	define __KERNEL__ 
#endif 
 
#ifndef MODULE 
#	define MODULE 
#endif 
 
#include <linux/config.h> 
#include <linux/module.h> 
#include <linux/kernel.h> 
#include <linux/init.h> 
#include <linux/slab.h> 
#include <linux/fs.h> 
#include <linux/errno.h> 
#include <linux/types.h> 
#include <asm/system.h> 
#include <linux/pci.h> 
#include <linux/string.h> 
 
#include "addi_7800_sys.h" 
 
#if (LINUX_VERSION_CODE >= 132096)	/* 2.4.0 */ 
 
 
static char *driver_name = "APCI-7800"; 
 
static int major = 40;		/*Major-Nr. static for testing*/ 
static int trm_fifo_size = 4096; 
static int rec_fifo_size = 4096; 
 
 
static struct addi_pci_info info; 
 
 
static struct file_operations addi_fops = 
{ 
	owner:		THIS_MODULE, 
	open:		addi_open, 
	release:	addi_release, 
	read:		addi_read, 
	write:		addi_write, 
	ioctl:		addi_ioctl, 
}; 
 
 
static struct pci_device_id addi_pci_tbl[] __initdata = 
{ 
	{ ADDI_VENDOR_ID, ADDI_DEVICE_ID, PCI_ANY_ID, PCI_ANY_ID, }, 
	{ 0, }, 
}; 
MODULE_DEVICE_TABLE(pci, addi_pci_tbl); 
 
 
static struct pci_driver apci_7800 = 
{ 
	name:		"apci_7800", 
	id_table:	addi_pci_tbl, 
	probe:		addi_probe, 
	remove:		addi_remove, 
}; 
 
 
static int __init addi_probe(struct pci_dev *dev, const struct pci_device_id
*id) 
{ 
	int ret = 0; 
 
	pci_enable_device(dev); 
	info.dev = dev; 
	info.irq = info.dev->irq; 
	info.io_base = pci_resource_start(dev, 0); 
	info.io_end = pci_resource_end(dev, 0); 
	info.io_len = pci_resource_len(dev, 0); 
 
	if(!request_region(info.io_base, info.io_len, driver_name)) 
	{ 
		printk(KERN_ERR "%s: Can't get I/O at 0x%lx\n", 
			driver_name, info.io_base); 
		unregister_chrdev(major, driver_name); 
		goto fail; 
	} 
	return ret; 
 
fail: 
	ret = -ENODEV; 
	return ret; 
} 
 
 
static void __exit addi_remove (struct pci_dev *dev) 
{ 
	release_region(info.io_base, info.io_len); 
} 
 
 
void addi_interrupt(int irq, void *dev_id, struct pt_regs *regs) 
{ 
	char sir, isr; 
	addi_module *module_info; 
	module_info = (addi_module*) dev_id; 
 
	sir = inb(module_info->io_base+UART_SIR); 
	isr = inb(module_info->io_base+UART_ISR); 
 
	if(isr == (1 << (module_info->module_nr - 1))) 
	{ 
		/*Interruptcode*/ 
	} 
} 
 
 
 
static ssize_t addi_read(struct file *filp, char *buf, size_t count, loff_t
*f_pos) 
{ 
/************************************** 
* Read 64 Bytes from FIFO for testing * 
**************************************/ 
 
	int i; 
	int ret = 0; 
	addi_module *module_info; 
	char feld[64]; 
 
	module_info = (addi_module*) filp->private_data; 
	if(down_interruptible(&module_info->sem)) 
		return(-ERESTARTSYS); 
 
	for(i=0;i<64;i++) 
		feld[i] = inb(module_info->io_base+UART_RBR); 
 
	up(&module_info->sem); 
 
	return(ret); 
} 
 
 
static ssize_t addi_write(struct file *filp, const char *buf, size_t count,
loff_t 
*offset) 
{ 
/*************************************** 
** Write 64 Bytes to FIFO for testing ** 
***************************************/ 
 
	int i; 
	int ret = 0; 
	addi_module *module_info; 
 
	module_info = (addi_module*) filp->private_data; 
 
	if(down_interruptible(&module_info->sem)) 
		return(-ERESTARTSYS); 
 
	for(i=0;i<64;i++) 
	{ 
		outb((char) i, module_info->io_base+UART_THR); 
	} 
 
	up(&module_info->sem); 
 
	return(ret); 
} 
 
 
 
static void addi_configure(addi_module *module_info) 
{ 
/******************************************* 
****Hard coded configuration for testing**** 
*******************************************/ 
 
	unsigned long flags; 
 
	save_flags(flags); 
	cli(); 
 
	/*Set MCR*/ 
	outb(0x10, (module_info->io_base+UART_MCR));	/*Loop on*/ 
 
	/*Enable Interrupts*/ 
	outb(0x0F, (module_info->io_base+UART_IER)); 
 
	/*Set FCR*/ 
	outb(0x01, (module_info->io_base+UART_FCR)); 
	outb(0xA9, (module_info->io_base+UART_FCR)); 
 
	/*Set Baudrate*/ 
	outb(0x80, (module_info->io_base+UART_LCR));	/*Set DLAB*/ 
	outb(0x18, (module_info->io_base+UART_DLL)); 
	outb(0x00, (module_info->io_base+UART_DLM)); 
	outb(0, (module_info->io_base+UART_LCR)); 
 
	/*Set LCR*/ 
	outb(0x03, (module_info->io_base+UART_LCR)); 
 
	outb(0x07, (module_info->io_base+UART_FCR));	/*Reset FIFOs*/ 
 
	restore_flags(flags); 
} 
 
 
static int addi_ioctl(struct inode *inode, struct file *filp, 
		      unsigned int cmd, unsigned long arg) 
{ 
/*********************** 
***Configurationcode**** 
***********************/ 
 
	return(0); 
} 
 
 
static int addi_open(struct inode *inode, struct file *filp) 
{ 
	int ret = 0, minor, pci_area; 
	addi_module *module_info; 
 
	minor = MINOR(inode->i_rdev); 
	if(!(module_info = kmalloc(sizeof(addi_module), GFP_KERNEL))) 
	{ 
		printk(KERN_ERR "%s: kmalloc() causes an error\n",driver_name); 
		goto fail; 
	} 
 
	sema_init(&module_info->sem, 1); 
	module_info->pci_info = &info; 
	module_info->irq = module_info->pci_info->irq; 
	module_info->module_nr = minor; 
	module_info->trm_fifo_size = trm_fifo_size; 
	module_info->rec_fifo_size = rec_fifo_size; 
 
	/********************************************************************* 
	*****Find out the right baseaddress of the module on the pci-card***** 
	*********************************************************************/ 
	pci_area = (module_info->module_nr + 1) / 2; 
	module_info->io_base = pci_resource_start(module_info->pci_info->dev, 
pci_area); 
	module_info->io_end = pci_resource_end(module_info->pci_info->dev, 
pci_area); 
	module_info->io_len = (pci_resource_len(module_info->pci_info->dev, 
pci_area)) / 2; 
 
	if(!(module_info->module_nr % 2)) 
		module_info->io_base += module_info->io_len; 
	else 
		module_info->io_end -= module_info->io_len; 
	/********************************************************************/ 
 
 
	ret = request_irq(module_info->irq, addi_interrupt, SA_SHIRQ, 
		driver_name, module_info); 
	if(ret) 
	{ 
		printk(KERN_ERR "%s: Can't get IRQ %d\n",driver_name, 
			module_info->irq); 
		kfree(module_info); 
		goto fail; 
	} 
 
 
	if(!(request_region(module_info->io_base, module_info->io_len, 
		driver_name))) 
	{ 
		printk(KERN_ERR "%s: Can't get I/O at 0x%lx\n", driver_name, 
			module_info->io_base); 
		free_irq(module_info->irq, module_info); 
		kfree(module_info); 
		goto fail; 
	} 
 
	/* Which module is inserted ??? */ 
	module_info->io_type = ((inl(module_info->pci_info->io_base + MODULE_RD))
>> 
				((module_info->module_nr - 1) * 4)) & 0x07; 
 
	if(module_info->io_type < 0 || module_info->io_type > 7 
	   || module_info->io_type == 2) 
	{ 
		ret = -ENODEV; 
		printk(KERN_ERR "%s: No SI-Module found at port %d\n", 
				driver_name,module_info->module_nr); 
		free_irq(module_info->irq, module_info); 
		release_region(module_info->io_base, module_info->io_len); 
		kfree(module_info); 
		goto fail; 
	} 
 
	addi_configure(module_info); 
 
	printk(KERN_INFO "%s: Module %s found at port %d (I/O: 0x%lx - 0x%lx  IRQ: 
%d)\n",driver_name, 
			module_type[module_info->io_type], module_info->module_nr, 
			module_info->io_base, module_info->io_end, 
module_info->irq); 
 
	(addi_module*) filp->private_data = module_info; 
	return(ret); 
 
fail: 
	return(ret); 
} 
 
 
static int addi_release(struct inode *inode, struct file *filp) 
{ 
	addi_module *module_info; 
 
 	module_info = (addi_module*) filp->private_data; 
	free_irq(module_info->irq, module_info); 
	release_region(module_info->io_base, module_info->io_len); 
	kfree(module_info); 
	filp->private_data = NULL; 
 
	return(0); 
} 
 
 
static int __init addi_init(void) 
{ 
	int ret; 
 
	ret = register_chrdev(major, driver_name, &addi_fops); 
	if(ret < 0) 
	{ 
		printk(KERN_ERR "%s: Can't register Major-Nr. %d\n", 
				driver_name, major); 
		goto fail; 
	} 
	if(major == 0) 
		major = ret; 
 
	ret = pci_module_init(&apci_7800); 
	if(ret) 
	{ 
		printk(KERN_ERR "%s: Can't register PCI-Device\n",driver_name); 
		unregister_chrdev(major, driver_name); 
		goto fail; 
	} 
	printk(KERN_INFO "%s: Driver registered (Major-Nr. %d  I/O: 0x%lx - 
0x%lx)\n", 
		driver_name, major, info.io_base, info.io_end); 
 
	return(0); 
 
fail: 
	return(ret); 
} 
 
 
static void __exit addi_exit(void) 
{ 
	pci_unregister_driver(&apci_7800); 
	unregister_chrdev(major, driver_name); 
} 
 
 
module_init(addi_init); 
module_exit(addi_exit); 
 
EXPORT_NO_SYMBOLS; 
 
MODULE_LICENSE("GPL"); 
 
 
#else 
#	error "Linux Kernel-Version 2.4 or higher required" 
#endif	/*LINUX_VERSION_CODE*/ 
  
 
 
 
 
/************************************************************** 
**************** Header file addi_7800_sys.h ****************** 
**************************************************************/ 
 
#ifndef ADDI_7800_H 
#define ADDI_7800_H 
 
 
#define ADDI_VENDOR_ID	0x10E8 
#define ADDI_DEVICE_ID	0x818E 
 
#define MODULE_WR	0x00	/*Base 0 + 0x00*/ 
#define MODULE_RD	0x10	/*Base 0 + 0x10*/ 
 
 
char* module_type[] = 
{ 
	"PM232", 
	"PM485", 
	"", 
	"PM422", 
	"PM232-G", 
	"PM485-G", 
	"PMTTY-G", 
	"PM422-G" 
}; 
 
 
 
/*****************************************/ 
/*****Register-Adresses of UART 16654*****/ 
/*****************************************/ 
 
#define UART_RBR	0x00	/*DLAB == 0, read-only*/ 
#define UART_THR	0x00	/*DLAB == 0, write-only*/ 
#define UART_DLL	0x00 	/*DLAB == 1*/ 
#define UART_DLM	0x01	/*DLAB == 1*/ 
#define UART_IER	0x01	/*DLAB == 0*/ 
#define UART_FCR	0x02	/*write-only*/ 
#define UART_ISR	0x02	/*read-only*/ 
#define UART_LCR	0x03 
#define UART_MCR	0x04 
#define UART_LSR	0x05 
#define UART_MSR	0x06 
#define UART_SPR	0x07	/*write-only*/ 
#define UART_SIR	0x07	/*read-only*/ 
#define UART_EFR	0x02	/*LCR = 0xBF*/ 
 
 
 
typedef struct addi_pci_info 
{ 
	unsigned short	io_base; 
	unsigned short	io_end; 
	int		io_len; 
	int		irq; 
	struct pci_dev	*dev; 
}addi_pci_info; 
 
 
typedef struct addi_module 
{ 
	int			module_nr; 
	int			io_type; 
	unsigned short		io_base; 
	unsigned short		io_end; 
	int			io_len; 
	int			trm_fifo_size; 
	int			rec_fifo_size; 
	int			irq; 
	struct semaphore	sem; 
	addi_pci_info		*pci_info; 
}addi_module; 
 
 
 
static int __init addi_init(void); 
static void __exit addi_exit(void); 
static int __init addi_probe(struct pci_dev *, const struct pci_device_id
*); 
static void __exit addi_remove (struct pci_dev *); 
static int addi_open(struct inode *, struct file *); 
static int addi_release(struct inode *, struct file *); 
static ssize_t addi_read(struct file *, char *, size_t, loff_t *); 
static ssize_t addi_write(struct file *, const char *, size_t, loff_t *); 
static int addi_ioctl(struct inode *, struct file *, unsigned int, unsigned
long); 
static void addi_interrupt(int, void *, struct pt_regs *); 
static void addi_configure(addi_module *); 
 
 
#endif 
 
 

-- 
NEU: Bis zu 10 GB Speicher für e-mails & Dateien!
1 GB bereits bei GMX FreeMail http://www.gmx.net/de/go/mail

