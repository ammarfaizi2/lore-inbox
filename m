Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264531AbUI0Noq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264531AbUI0Noq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 09:44:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265943AbUI0Nop
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 09:44:45 -0400
Received: from [202.125.86.130] ([202.125.86.130]:24044 "EHLO
	ns2.astrainfonets.net") by vger.kernel.org with ESMTP
	id S264531AbUI0NoA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 09:44:00 -0400
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: mmap system call error -- source code attached 
X-MimeOLE: Produced By Microsoft Exchange V6.5.6944.0
Date: Mon, 27 Sep 2004 19:16:25 +0530
Message-ID: <4EE0CBA31942E547B99B3D4BFAB34811107FD5@mail.esn.co.in>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: mmap system call error -- source code attached 
Thread-Index: AcSkl4IXwfvoB9eKQ4K915MNMU/9pA==
From: "Srinivas G." <srinivasg@esntechnologies.co.in>
To: "linux-kerne-Mailing-list" <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear all,

I developed a small character device driver. It should work for
reading/writing from RAM. I implemented the mmap functionality in this
device driver. It is very small program. Even though, I was unable to
read the contents from the mapped area. 
 
System configuration is: Intel x86 architecture and Red Hat 7.3 with
2.4.18-3 kernel version.

The following code contains the driver code, make file and application
(read/write) code.

-- make install command creates the node under /dev directory based on
device major number. 
-- make uninstall command removes the node from the /dev directory. 
-- write.c is used to write the contents into the device memory. 
-- read.c is used to the read the contents from the device memory using
read system call. 
-- read_mmap.c is used to read the contents from the device memory using
mmap system call. 
 
Here read.c and write.c are working fine where as when I try to read the
contents from the device memory using read_mmap.c file I was not getting
any thing except NULL, but when I was reading the same device memory
using read.c file it works fine.

What was the error? Where is the fault? 

Please any help greatly appreciated.
 
Thanks and regards,
Srinivas G


DRIVER CODE
-----------

/* Copyright (C) ESN Technologies
 * - Linux -
 * 
 * Simple character driver for Memory to show the mmap functionality
 * Module  : mmap_drv.c
 * Purpose : provides simple read/write operations from memory like 
 * using mmap functionality 
 *
 * Core OS interface functions of the driver
 *
 * Created on 27-09-2004 to handle mmap call back method.
 */ 

/* kernel headers */
#include <linux/module.h>	/* for everything ... */
#include <linux/init.h>		/* explicit init & exit module
difinitions */
#include <linux/kernel.h>	/* for printk */
#include <linux/fs.h>		/* for file and inode structure */
#include <linux/mm.h>		/* for vm_area_structure */
#include <linux/slab.h>		/* for kmalloc */
#include <asm/uaccess.h>	/* for copy_to_user and copy_from_user
*/
#include <asm/io.h>		/* for virt_to_phys API */

/* driver name in the /proc/devices and maximum devices */
#define MMAP_MODULE_NAME	"mmap-drv"
#define MAX_TYPE 		1
#define MAX_MEM_SIZE		(1024*102)  	/* maximum memory
allocated */

/* debugging */
#ifdef MMAP_DBG
#define PRINTK(fmt, arg...) printk("MMAP_DBG <%s>
"fmt,__FUNCTION__,##arg)
#else
#define PRINTK(fmt, arg...) while(0)
#endif

/* declare a pointer to hold the allocated memory */ 
unsigned char *mapped_area;
struct rw_semaphore mmap_sem;

/* function prototypes */
static loff_t mmap_llseek(struct file *, loff_t, int);
static int mmap_open(struct inode *, struct file *);
static int mmap_close(struct inode *, struct file *);
static ssize_t mmap_read(struct file *, char *, size_t, loff_t *);
static ssize_t mmap_write(struct file *, const char *, size_t, loff_t
*);
static int mmap_mmap(struct file *, struct vm_area_struct *);

/* file operations structure, callback functions! */
static struct file_operations mmap_fops = {
	owner: THIS_MODULE,
	llseek: mmap_llseek,
	open: mmap_open,
	release: mmap_close,
	read: mmap_read,
	write: mmap_write,
	mmap: mmap_mmap,
};

/* driver major number */
static int mmap_maj = 230;

MODULE_AUTHOR("SRINIVAS G");
MODULE_DESCRIPTION("Character Memory Device Driver to handle MMAP");
MODULE_LICENSE("GPL");

************************************************************************
****
/*
 * mmap_open(): open callback function.
 */
static int
mmap_open(struct inode *inode, struct file *filp)
{
	/* get the minor number from inode structure */
	unsigned int minor = MINOR(inode->i_rdev);

	PRINTK("callback invoked!\n");
	
	/* check whether the minor number is existed within the range */
	if(minor > MAX_TYPE) return -ENODEV;
	
	/* 
	 * put the address of file_operations structure in the
	 * f_op variable of file structure
	 */
	filp->f_op = &mmap_fops;
	
	/* increment the usage count */
	MOD_INC_USE_COUNT;
	
	return 0;	
}
************************************************************************
****

/*
 * mmap_close(): release callback function.
 */
static int
mmap_close(struct inode *inode, struct file *filp)
{
	PRINTK("callback invoked!\n");
	
	/* decrement the usage count */
	MOD_DEC_USE_COUNT;

	return 0;
}
************************************************************************
****

/*
 * mmap_read(): read callback function.
 */
static int
mmap_read(struct file *filp, char *buff, size_t count, loff_t *f_pos)
{
	ssize_t ret = 0,esnind;

	/* get the minor number */	
	int minor = MINOR(filp->f_dentry->d_inode->i_rdev);
	
	PRINTK("callback invoked!\n");
	
	/* check whether the minor number is existed within the range */
	if(minor > MAX_TYPE) return -ENODEV;
	
	/* to check whether the file position is at the end of the
memory */
	if(*f_pos >= MAX_MEM_SIZE) return ret;

	/* Is file position and count reaches to the end of memory */
	if(*f_pos + count > MAX_MEM_SIZE)
		count = MAX_MEM_SIZE - *f_pos;
		
	/* copy the contents from kernel space to user space */
 	if (copy_to_user(buff,mapped_area,count))
		ret = -EFAULT;

	/* change the file position accordingly */
	*f_pos += count;
	ret = count;
	
	return ret;	
}
************************************************************************
****

/*
 * mmap_write(): write callback function.
 */
static int
mmap_write(struct file *filp, const char *buff, size_t count, loff_t
*f_pos)
{
	ssize_t ret = 0,esnind;
	
	/* get the minor number */	
	int minor = MINOR(filp->f_dentry->d_inode->i_rdev);
	
	PRINTK("callback invoked!\n");

	/* check whether the minor number is existed within the range */
	if(minor > MAX_TYPE) return -ENODEV;
	
	/* to check whether the file position is at the end of the
memory */
	if(*f_pos >= MAX_MEM_SIZE) return ret;

	/* Is file position and count reaches to the end of memory */
	if(*f_pos + count > MAX_MEM_SIZE)
		count = MAX_MEM_SIZE - *f_pos;
	
	/* copy the contents from user space to kernel space */
 	if (copy_from_user(mapped_area,buff,count))
		ret = -EFAULT;
	
	/* change the file position accordingly */
	*f_pos += count;
	ret = count;
	
	return ret;	
}
************************************************************************
****

/*
 * mmap_mmap(): write callback function.
 */
static int
mmap_mmap(struct file *filp, struct vm_area_struct *vma)
{
	int ret =0, pages;
	unsigned long physic_addr, start, size, next;
	int minor = MINOR(filp->f_dentry->d_inode->i_rdev);
	
	PRINTK("callback invoked!\n");
	
	/* check whether the minor number is existed within the range */
	if(minor > MAX_TYPE) return -ENODEV;

	start = vma->vm_start;
	physic_addr = virt_to_phys(mapped_area);
	pages = MAX_MEM_SIZE / PAGE_SIZE;
	size = vma->vm_end - vma->vm_start;
	next = MAX_MEM_SIZE + PAGE_SIZE;

	printk("mapped area virtual address is : %08x!\n", mapped_area);

	printk("mapped area physical address : %08x!\n", physic_addr);
	
	if (size > next)
		return -EINVAL;

	vma->vm_flags |= VM_LOCKED;

	down_write(&mmap_sem);

	while(pages--)
	{
	   if
(remap_page_range(start,physic_addr,PAGE_SIZE,vma->vm_page_prot))
	   {
		   ret = -EAGAIN;
		   break;
	   }
	   if (size <= PAGE_SIZE)
		   break;

	   size  -= PAGE_SIZE;
	   start += PAGE_SIZE;
	}

	up_write(&mmap_sem);

	return ret;
}
************************************************************************
****

/*
 * mmap_llseek(): lseek callback function.
 */
static loff_t 
mmap_llseek(struct file *filp, loff_t off, int whence)
{
	loff_t newpos;

	PRINTK("callback invoked!\n");
	
	switch(whence)
	{
		case 0:	/* SEEK_SET */
			newpos = off;
			break;

		case 1:	/* SEEK_CUR */
			newpos = filp->f_pos + off;
			break;

		case 2:	/* SEEK_END */
			newpos = MAX_MEM_SIZE + off;
			break;
			
		default: return -EINVAL; 
	}

	if (newpos<0) return -EINVAL;

	filp->f_pos = newpos;

	return newpos;
}

************************************************************************
****

/*
 * Module entry point
 */
static int 
__init mmap_init(void)
{
	int result;

	PRINTK("invoked!\n");

	/* 
	 * register the MMAP device with major number, name and 
	 * pointer to file_operations structure 
	 */
	if(
(result=register_chrdev(mmap_maj,MMAP_MODULE_NAME,&mmap_fops)) < 0)
	{
		printk(KERN_ALERT "MMAP ERROR | could NOT register
device!\n");
		return result;
	}
	
	
	
	
	/* allocate the memory for Device to read/write */
	mapped_area = (char *)kmalloc((MAX_MEM_SIZE),GFP_KERNEL);

	if(mapped_area == NULL)
	{
		printk("INFO | MMAP kmalloc(%d) fail!\n",MAX_MEM_SIZE);
		return -ENOMEM;
	}
	
	/* initialize the allocated memory */
	memset(mapped_area, 0, MAX_MEM_SIZE);
	
	return 0;
}
************************************************************************
****


/*
 * Module exit point
 */
static void
__exit mmap_cleanup(void)
{
	PRINTK("invoked!\n");
	
	/* unregister the device with specified major number */
	if(unregister_chrdev(mmap_maj,MMAP_MODULE_NAME) < 0)
		printk("MMAP ERROR | Could NOT unregister the
device!\n");

	kfree(mapped_area);
	
}

/* module init/exit macros */
module_init(mmap_init);
module_exit(mmap_cleanup);
 
************************************************************************
****
************************************************************************
****

MAKE FILE
---------
#
# Makefile for FIFO Driver for Memory.
#

INCDIR=/usr/src/linux-2.4/include # Include path on RedHat

DEVICE=esn_mmap
MAJOR =230 
TARGET=mmap_device.o
OBJS=mmap_drv.o

#CFLAGS=-DMODULE -D__KERNEL__ -I$(INCDIR) -Wstrict-prototypes
-fomit-frame-pointer -O2 

### Enable Debugging ###
CFLAGS=-DMODULE -D__KERNEL__ -DMMAP_DBG -I$(INCDIR) -Wstrict-prototypes
-fomit-frame-pointer -O2 

$(TARGET): $(OBJS)
	$(LD) -r -o $(TARGET) $(OBJS)

clean:
	$(RM) $(TARGET) $(OBJS)

install:
	@mknod /dev/$(DEVICE)0 c $(MAJOR) 0

uninstall:
	@$(RM) /dev/$(DEVICE)*

************************************************************************
****
************************************************************************
****

WRITE.C
-------

/*
 * Description:
 * This program is used to write the specified number of characters 
 * into the specified character device 
 *
 * Command line arguments:
 * - actual executable file name
 * - Character device name 
 * - character string without spaces
 * 
 * Return value:
 * - positive number or 0 on success
 * - negative number on failure
 */

#include <stdio.h>
#include <fcntl.h>
#include <sys/stat.h>
#include <string.h>

int main (int argc, char *argv[])
{
	int fd, count,i;
	char buff[100];
	size_t write_count;

	/* check whether the no.of arguments are correct or not */
	if(argc < 3)
	{
		printf("\n USAGE : <file_name> <device_name>
<string>\n\n");
		printf("\n Example : ./write /dev/esn_mmap0
srinivas_esn\n\n");
		return;
	}
	
	/* opening the specified device from argument 1 */ 
	fd = open(argv[1], O_WRONLY);

	if (fd < 0)
	{
		printf("Unable to open the specidifed file!\n");
		return;
	}

	/* count the total no.of chars from argument 2 */
        write_count = strlen(argv[2]);
	
	/* writing the contents into the device */
	if ( (count = write(fd, argv[2], write_count)) > 0)
		printf("\nThe contents are written successfulle!\n\n");
	else
		printf("\nThe contents are not written into the
file!\n\n");

	return 0;
}
	
************************************************************************
****
************************************************************************
****

READ.C
------
/*
 * Description:
 * This program is used to read the specified number of characters 
 * from specified character device 
 *
 * Command line arguments:
 * - actual executable file name
 * - Character device name 
 * - No. of characters to read
 * 
 * Return value:
 * - positive number or 0 on success
 * - negative number on failure
 */

#include <stdio.h>
#include <fcntl.h>
#include <sys/stat.h>

int main (int argc, char *argv[])
{
	int fd, count,i;
	char buff[100];
	size_t read_count;
	
	if(argc < 3)
	{
		printf("\n USAGE : <file_name> <device_name> <no.of
chars to read>\n\n");
		printf("\n Example : ./read /dev/esn_mmap0 11\n\n");
		return;
	}
	
	/* opening the specified device from argument 1 */ 
	fd = open(argv[1], O_RDONLY);

	if (fd < 0)
	{
		printf("Unable to open the specidifed file!\n");
		return;
	}

	/* converting the argument 2 (no.of chars to read) into interger
*/
	sscanf(argv[2],"%d",&read_count);

	/* reading the contents from device */
	if ( (count = read(fd, buff, read_count)) > 0)
	{
		printf("The contents are : ");
	
		for (i = 0; i < read_count; i++)
			printf("%c",buff[i]);
	
		printf("\n");
	}
	else
		printf("The contents are not available in the file!\n");

	return 0;
}
	
************************************************************************
****
************************************************************************
****

READ_MMAP.C
-----------

/*
 * Description:
 * This program is used to read the specified number of characters 
 * from specified character device using mmap system call. 
 *
 * Command line arguments:
 * - actual executable file name
 * - Character device name 
 * - No. of characters to read
 * 
 * Return value:
 * - positive number or 0 on success
 * - negative number on failure
 */

#include <stdio.h>
#include <fcntl.h>
#include <sys/stat.h>
#include <sys/mman.h>	/* for mmap system call */
#define MAX_MEM_SIZE  (1024*102)

int main (int argc, char *argv[])
{
	int fd, count,i;
	char buff[100];
	size_t read_count;
	unsigned char *app_mapped_area;
	
	if(argc < 3)
	{
		printf("\n USAGE : <file_name> <device_name> <no.of
chars to read>\n\n");
		printf("\n Example : ./read_mmap /dev/esn_mmap0
11\n\n");
		return;
	}
	
	/* opening the specified device from argument 1 */ 
	fd = open(argv[1], O_RDONLY);

	if (fd < 0)
	{
		printf("Unable to open the specidifed file!\n");
		return;
	}

	/* converting the argument 2 (no.of chars to read) into interger
*/
	sscanf(argv[2],"%d",&read_count);

	app_mapped_area = (unsigned char
*)mmap(0,MAX_MEM_SIZE,PROT_READ,MAP_SHARED,fd,0);
	
	if (app_mapped_area == MAP_FAILED)
	{
		printf("mmap system call failed!\n");
		return -1;
	}
	printf("The mmapped address is %08x!\n",app_mapped_area);
	
	for (i = 0; i < read_count; i++)
	{
		printf("Inside FOR loop ....!\n");
		printf("%c",*app_mapped_area++);
	}

	return 0;
}
	
************************************************************************
****
************************************************************************
****


