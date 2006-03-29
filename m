Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750919AbWC2MTb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750919AbWC2MTb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 07:19:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750976AbWC2MTb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 07:19:31 -0500
Received: from uproxy.gmail.com ([66.249.92.201]:17191 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750869AbWC2MTa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 07:19:30 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type;
        b=UuRQJWIU0l7RlSRpA6kVvbAJdotOwJ/HNGges4QBldAXOTQc227ohRRtVvbJDJMuEQN1c7EvJYoqTZKzH5E4LVaShIEiGGwKsSXJc76Y044O6TDqlAjbOMx3YxWar6K+4v2EL9wVu/K+nhfzl/+ZypO4pMHmgwIY4Tge/wA1Dkc=
Message-ID: <b681c62b0603290419l7940a2c9k1abecb25ddc84e30@mail.gmail.com>
Date: Wed, 29 Mar 2006 17:49:26 +0530
From: "yogeshwar sonawane" <yogyas@gmail.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: whether to use nopage() implementation or remap_page/pfn_range() api
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_264_3214194.1143634766741"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_264_3214194.1143634766741
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi all,

I am allocating a buffer with __get_free_pages, then trying to map it.
As remap_pfn/page_range() cannot be used, I tried nopage()
implementation (check nopage_module.c). But while looking through some
drivers (oss), i found that remap_pfn/page_range() can be used for
such physical memory after setting PG_reserved bit of all pages of the
buffer. So i tried setting PG_reserved bit & then using
remap_page_range() (check remap_module.c). its also working fine.

1) Now what will be the correct way to do such type of mapping?

then i wrote the above things for memory obtained by pci_alloc_consistent()=
.
pci_remap_module.c contains implementation using remap_page_range().
pci_nopage_module.c contains implementation using nopage().

but while running nopage implementation, i am getting some kernel messeges =
like:

<0>Bad page state at __free_pages_ok (in process 'a.out', page c1632720)
flags:0x20001070 mapping:c19e23a4 mapcount:0 count:2
Backtrace:
 [<c01426d9>] bad_page+0x58/0x89
 [<c01429e3>] __free_pages_ok+0x77/0xcc
 [<f89130d3>] my_close+0x6d/0x74 [pci_nopage_module]
 [<c015a816>] __fput+0x55/0x100
 [<c014df24>] remove_vm_struct+0x62/0x79
 [<c014fc9c>] exit_mmap+0x13e/0x148
 [<c012016a>] mmput+0x4e/0x72
 [<c01240c7>] do_exit+0x1f1/0x3de
 [<c012439f>] sys_exit_group+0x0/0xd
 [<c02d0fb7>] syscall_call+0x7/0xb
Trying to fix it up, but a reboot is needed


Can somebody help me regarding this?

If i am missing something, let me know.

i have tried this on Fedora core 3 as well as RHEL4-U2 & getting
messeges on both.

thanks in advance.
Yogeshwar

------=_Part_264_3214194.1143634766741
Content-Type: text/x-csrc; name=remap_module.c; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Attachment-Id: f_eldm64q2
Content-Disposition: attachment; filename="remap_module.c"

#include <linux/kernel.h>
#include <linux/module.h>
#include <linux/fs.h>
#include <linux/init.h>
#include <linux/mm.h>
#include <asm/io.h>

struct file_operations fops ;
static int major ;

static int my_open(struct inode *inode, struct file *file)
{
	int i ;
	void *data_ptr ;
	struct page *page ;
	printk("I am in my_open\n") ;
	data_ptr = (void *) __get_free_pages(GFP_KERNEL, 4) ;
	if (data_ptr == NULL)
	{	
		printk("__get_free_pages failed\n") ;		
		return -1 ;
	}
	else
	{
		printk("__get_free_pages successful data_ptr = %ld\n", (unsigned long)data_ptr) ;
	}

	for (i = 0 ; i < 16 ; i++)
	{
		page = virt_to_page(data_ptr + PAGE_SIZE * i) ; 
		set_bit(PG_reserved, &page->flags) ;
	}	

	strcpy((char *)data_ptr, "HelloWorld") ;

	file->private_data = data_ptr ;
	return 0 ;
}

static int my_close(struct inode *inode, struct file *file)
{
	int i ;
	struct page *page ;
	unsigned long data_ptr = (unsigned long)file->private_data ;
	printk("I am in my_close\n") ;
	printk("%s data_ptr = %ld\n", (char *)data_ptr, data_ptr) ;

	for (i = 0 ; i < 16 ; i++)
	{
		page = virt_to_page(data_ptr + PAGE_SIZE * i) ; 
		clear_bit(PG_reserved, &page->flags) ;
	}	
	free_pages(data_ptr, 4) ;
	return 0 ;
}

static int my_mmap(struct file *file, struct vm_area_struct *vma)
{
	void *data_ptr = (void *)file->private_data ;
	printk("I am in my_mmap\n") ;
	printk("data_ptr = %ld\n", (unsigned long) data_ptr) ;

	if (remap_page_range(vma, vma->vm_start, virt_to_phys(data_ptr), (vma->vm_end - vma->vm_start), vma->vm_page_prot)) 
	{
		printk("remap_page_range failed\n") ;	
		return -1 ;
	}
	return 0 ;
}

int init_module(void)
{
	printk("I am in init_module\n") ;

	major = register_chrdev(0, "mydriver", &fops) ;
	if(major == -1)
	{
		printk("register_chrdev failed\n") ;
		return -1 ;
	}
	printk("module is registered with major no = %d\n", major) ;
	return 0 ;
}

void cleanup_module(void)
{
	printk("I am in cleanup_module\n") ;
	unregister_chrdev(major, "mydriver") ;
}

struct file_operations fops = 
{
	.open = my_open,
	.release = my_close, 
	.mmap = my_mmap,
} ;











------=_Part_264_3214194.1143634766741
Content-Type: text/x-csrc; name=nopage_module.c; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Attachment-Id: f_eldm6jgi
Content-Disposition: attachment; filename="nopage_module.c"

#include <linux/kernel.h>
#include <linux/module.h>
#include <linux/fs.h>
#include <linux/init.h>
#include <linux/mm.h>
#include <asm/io.h>

struct file_operations fops ;
static int major ;

static int my_open(struct inode *inode, struct file *file)
{
	int i ;
	void *data_ptr ;
	struct page *page ;
	printk("I am in my_open\n") ;
	data_ptr = (void *) __get_free_pages(GFP_KERNEL, 4) ;
	if (data_ptr == NULL)
	{	
		printk("__get_free_pages failed\n") ;		
		return -1 ;
	}
	else
	{
		printk("__get_free_pages successful data_ptr = %ld\n", (unsigned long)data_ptr) ;
	}

	for (i = 0 ; i < 16 ; i++)
	{
		page = virt_to_page(data_ptr + PAGE_SIZE * i) ; 
		set_bit(PG_reserved, &page->flags) ;
	}	

	strcpy((char *)data_ptr, "HelloWorld") ;

	file->private_data = data_ptr ;
	return 0 ;
}

static int my_close(struct inode *inode, struct file *file)
{
	int i ;
	struct page *page ;
	unsigned long data_ptr = (unsigned long)file->private_data ;
	printk("I am in my_close\n") ;
	printk("%s data_ptr = %ld\n", (char *)data_ptr, data_ptr) ;

	for (i = 0 ; i < 16 ; i++)
	{
		page = virt_to_page(data_ptr + PAGE_SIZE * i) ; 
		clear_bit(PG_reserved, &page->flags) ;
	}	
	free_pages(data_ptr, 4) ;
	return 0 ;
}

void my_vma_open(struct vm_area_struct *vma) 
{
	printk("I am in my_vma_open\n") ;
}

void my_vma_close(struct vm_area_struct *vma)
{
	printk("I am in my_vma_close\n") ;
}

struct page *my_vma_nopage(struct vm_area_struct *vma, unsigned long address, int *type)
{
	struct page *page ;
	unsigned long offset = address - vma->vm_start ;
	void *base_kern_addr = vma->vm_private_data ;
	printk("I am in my_vma_nopage\n") ;

	page = virt_to_page(base_kern_addr + offset) ;

	get_page(page) ;

	if (type)
	{
		*type = VM_FAULT_MINOR ;
	}

	return page ;
}

static struct vm_operations_struct my_vm_ops = 
{ 
	.open = my_vma_open,
	.close = my_vma_close,
	.nopage = my_vma_nopage,
} ;

static int my_mmap(struct file *file, struct vm_area_struct *vma)
{
	void *data_ptr = (void *)file->private_data ;
	printk("I am in my_mmap\n") ;
	printk("data_ptr = %ld\n", (unsigned long) data_ptr) ;

	vma->vm_flags |= VM_RESERVED ;
	vma->vm_ops = &my_vm_ops ;
	vma->vm_private_data = data_ptr ;
	my_vma_open(vma) ;

	return 0 ;
}

int init_module(void)
{
	printk("I am in init_module\n") ;

	major = register_chrdev(0, "mydriver", &fops) ;
	if(major == -1)
	{
		printk("register_chrdev failed\n") ;
		return -1 ;
	}
	printk("module is registered with major no = %d\n", major) ;
	return 0 ;
}

void cleanup_module(void)
{
	printk("I am in cleanup_module\n") ;
	unregister_chrdev(major, "mydriver") ;
}

struct file_operations fops = 
{
	.open = my_open,
	.release = my_close, 
	.mmap = my_mmap,
} ;











------=_Part_264_3214194.1143634766741
Content-Type: text/x-csrc; name=pci_remap_module.c; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Attachment-Id: f_eldm6oo2
Content-Disposition: attachment; filename="pci_remap_module.c"

#include <linux/kernel.h>
#include <linux/module.h>
#include <linux/fs.h>
#include <linux/init.h>
#include <linux/mm.h>
#include <asm/io.h>
#include <linux/pci.h>

#define VENDOR_ID 0x14E4
#define DEVICE_ID 0x1600
#define SIZE 	  10000 

struct file_operations fops ;
static int major ;
struct pci_dev *pci_dev = NULL ;
dma_addr_t bus_addr ;

static int my_open(struct inode *inode, struct file *file)
{
	void *virt_addr = (void *)NULL ;
	struct page *page, *end_page ;
	printk("I am in my_open\n") ;
	
	virt_addr = pci_alloc_consistent(pci_dev, SIZE, &bus_addr) ;

    	if (virt_addr == NULL)
    	{
        	printk("pci_alloc_consistent failed\n") ;
        	return -ENOMEM ;
    	}	
	else
	{
		printk("pci_alloc_consistent successful, virt_addr = %ld\n", (unsigned long)virt_addr) ;
	}

    	end_page = virt_to_page(virt_addr + SIZE - 1) ;

    	for (page = virt_to_page(virt_addr) ; page <= end_page ; page++)
    	{
        	set_bit(PG_reserved, &page->flags) ;
    	}	

	file->private_data = virt_addr ;
	return 0 ;
}

static int my_close(struct inode *inode, struct file *file)
{
	int *ptr, i ;
	struct page *page, *end_page ;
	void *virt_addr = file->private_data ;
	printk("I am in my_close\n") ;
	printk("virt_addr = %ld\n", (unsigned long)virt_addr) ;

	ptr = (int *)virt_addr ;

	printk("my_close : data read from kernel : \n") ;

	for(i = 0 ; i < 2048 ; i++)
    	{
        	printk("%d ", *(ptr + i)) ;
    	}

	end_page = virt_to_page(virt_addr + SIZE - 1) ;

	for (page = virt_to_page(virt_addr) ;
                        page <= end_page ; page++)
    	{
        	clear_bit(PG_reserved, &page->flags) ;
    	}		

	pci_free_consistent(pci_dev,SIZE,virt_addr,bus_addr) ;

	return 0 ;
}

static int my_mmap(struct file *file, struct vm_area_struct *vma)
{
	void *data_ptr = (void *)file->private_data ;
	printk("I am in my_mmap\n") ;
	printk("data_ptr = %ld\n", (unsigned long) data_ptr) ;

	if (remap_page_range(vma, vma->vm_start, virt_to_phys(data_ptr), (vma->vm_end - vma->vm_start), vma->vm_page_prot)) 
	{
		printk("remap_page_range failed\n") ;	
		return -1 ;
	}
	return 0 ;
}

int init_module(void)
{
	printk("I am in init_module\n") ;

	pci_dev = pci_get_device(VENDOR_ID, DEVICE_ID, pci_dev) ;

        if (pci_dev == (struct pci_dev *)NULL)
        {
            printk("pci_get_device failed\n") ;
	    return -1 ;
        }

	printk("pci_dev found, pci_dev = %ld\n", (unsigned long)pci_dev) ;

	major = register_chrdev(0, "mydriver", &fops) ;
	if(major == -1)
	{
		printk("register_chrdev failed\n") ;
		return -1 ;
	}
	printk("module is registered with major no = %d\n", major) ;
	return 0 ;
}

void cleanup_module(void)
{
	printk("I am in cleanup_module\n") ;
	unregister_chrdev(major, "mydriver") ;
}

struct file_operations fops = 
{
	.open = my_open,
	.release = my_close, 
	.mmap = my_mmap,
} ;











------=_Part_264_3214194.1143634766741
Content-Type: text/x-csrc; name=pci_nopage_module.c; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Attachment-Id: f_eldm6t2q
Content-Disposition: attachment; filename="pci_nopage_module.c"

#include <linux/kernel.h>
#include <linux/module.h>
#include <linux/fs.h>
#include <linux/init.h>
#include <linux/mm.h>
#include <asm/io.h>
#include <linux/pci.h>

#define VENDOR_ID 0x14E4
#define DEVICE_ID 0x1600
#define SIZE 	  10000 

struct file_operations fops ;
static int major ;
struct pci_dev *pci_dev = NULL ;
dma_addr_t bus_addr ;

static int my_open(struct inode *inode, struct file *file)
{
	void *virt_addr = (void *)NULL ;
	printk("I am in my_open\n") ;
	
	virt_addr = pci_alloc_consistent(pci_dev, SIZE, &bus_addr) ;

    	if (virt_addr == NULL)
    	{
        	printk("pci_alloc_consistent failed\n") ;
        	return -ENOMEM ;
    	}	
	else
	{
		printk("pci_alloc_consistent successful, virt_addr = %ld\n", (unsigned long)virt_addr) ;
	}

	file->private_data = virt_addr ;
	return 0 ;
}

static int my_close(struct inode *inode, struct file *file)
{
	int *ptr, i ;
	void *virt_addr = file->private_data ;
	printk("I am in my_close\n") ;
	printk("%s virt_addr = %ld\n", (char *)virt_addr, (unsigned long)virt_addr) ;

	ptr = (int *)virt_addr ;

	printk("my_close : data read from kernel : \n") ;

	for(i = 0 ; i < 2048 ; i++)
    	{
        	printk("%d ", *(ptr + i)) ;
    	}

	pci_free_consistent(pci_dev,SIZE,virt_addr,bus_addr) ;

	return 0 ;
}

void my_vma_open(struct vm_area_struct *vma)
{
        printk("I am in my_vma_open\n") ;
}

void my_vma_close(struct vm_area_struct *vma)
{
        printk("I am in my_vma_close\n") ;
}

struct page *my_vma_nopage(struct vm_area_struct *vma, unsigned long address, int *type)
{
        struct page *page ;
        unsigned long offset = address - vma->vm_start ;
        void *base_kern_addr = vma->vm_private_data ;
        printk("I am in my_vma_nopage\n") ;

	printk("nopage : address = %ld, vma->vm_start = %ld, offset = %ld, base_kern_addr = %ld\n",
		address, (unsigned long)vma->vm_start, offset, (unsigned long)base_kern_addr) ;

        page = virt_to_page(base_kern_addr + offset) ;

        get_page(page) ;

        if (type)
        {
                *type = VM_FAULT_MINOR ;
        }

        return page ;
}

static struct vm_operations_struct my_vm_ops =
{
        .open = my_vma_open,
        .close = my_vma_close,
        .nopage = my_vma_nopage,
} ;

static int my_mmap(struct file *file, struct vm_area_struct *vma)
{
	void *data_ptr = (void *)file->private_data ;
	printk("I am in my_mmap\n") ;
	printk("data_ptr = %ld\n", (unsigned long) data_ptr) ;

	vma->vm_flags |= VM_RESERVED ;
        vma->vm_ops = &my_vm_ops ;
        vma->vm_private_data = data_ptr ;
        my_vma_open(vma) ;

	return 0 ;
}

int init_module(void)
{
	printk("I am in init_module\n") ;

	pci_dev = pci_get_device(VENDOR_ID, DEVICE_ID, pci_dev) ;

        if (pci_dev == (struct pci_dev *)NULL)
        {
            printk("pci_get_device failed\n") ;
	    return -1 ;
        }

	printk("pci_dev found, pci_dev = %ld\n", (unsigned long)pci_dev) ;

	major = register_chrdev(0, "mydriver", &fops) ;
	if(major == -1)
	{
		printk("register_chrdev failed\n") ;
		return -1 ;
	}
	printk("module is registered with major no = %d\n", major) ;
	return 0 ;
}

void cleanup_module(void)
{
	printk("I am in cleanup_module\n") ;
	unregister_chrdev(major, "mydriver") ;
}

struct file_operations fops = 
{
	.open = my_open,
	.release = my_close, 
	.mmap = my_mmap,
} ;











------=_Part_264_3214194.1143634766741
Content-Type: text/x-csrc; name=user.c; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Attachment-Id: f_eldm6wk2
Content-Disposition: attachment; filename="user.c"

#include <stdio.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <fcntl.h>
#include <sys/mman.h>

main() 
{
	int fd ;
	void *virt_addr ;
	int *ptr1, *ptr2, i ;

	fd = open("mydevice", O_RDWR) ;
	if (fd == -1)
	{
		printf("open failed\n") ;	
		exit(-1) ;
	}

	virt_addr = mmap(NULL, 10000, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0) ;
	if (virt_addr == MAP_FAILED)
	{
		printf("mmap failed\n") ;
		exit(-1) ;
	}

	ptr1 = (int *) virt_addr ;

	ptr2 = (int *) virt_addr ;

    	printf("ptr1 = %ld, ptr2 = %ld virt_addr=%ld \n",

        	(unsigned long)ptr1, (unsigned long)ptr2,

	        (unsigned long)virt_addr) ;

    	for(i = 0 ; i < 2048 ; i++)
    	{
        	*(ptr1 + i) = i ;
    	}

    	for(i = 0 ; i < 2048 ; i++)
    	{
        	printf("%d ", *(ptr2 + i)) ;
    	}

	munmap(virt_addr, 80) ;

	close(fd) ;
	
	return 0 ;
}











------=_Part_264_3214194.1143634766741
Content-Type: application/octet-stream; name=Makefile
Content-Transfer-Encoding: 7bit
X-Attachment-Id: f_eldm78qq
Content-Disposition: attachment; filename="Makefile"

obj-m = pci_nopage_module.o

KDIR = /lib/modules/$(shell uname -r)/build
PWD = $(shell pwd)

default:
	$(MAKE) -C $(KDIR) M=$(PWD) modules

clean:
	$(MAKE) -C $(KDIR) M=$(PWD) clean











------=_Part_264_3214194.1143634766741--
