Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263702AbUEWWz7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263702AbUEWWz7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 May 2004 18:55:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263711AbUEWWz7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 May 2004 18:55:59 -0400
Received: from web50001.mail.yahoo.com ([206.190.38.16]:37220 "HELO
	web50001.mail.yahoo.com") by vger.kernel.org with SMTP
	id S263702AbUEWWzc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 May 2004 18:55:32 -0400
Message-ID: <20040523225531.93467.qmail@web50001.mail.yahoo.com>
Date: Sun, 23 May 2004 15:55:31 -0700 (PDT)
From: fc scsi <scsi_fc_group@yahoo.com>
Subject: dmaable memory in user space
To: linux-kernel@vger.kernel.org
Cc: scsi_fc_group@yahoo.com
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1039399702-1085352931=:93198"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--0-1039399702-1085352931=:93198
Content-Type: text/plain; charset=us-ascii
Content-Id: 
Content-Disposition: inline

Hi,

I am trying to get DMAable memory in user space by
allocating it in kernel space and mmaping it to the
user space application. The requirement is that the
application will keep on doing allocations for this
memory and keep freeing it and it may not be for full
size pages(eg a few bytes only). For this I have
written a prototype driver and user application which
I have attached with the mail. Basically, the steps I
am following are:

1. implement the mmap() function in the driver
2. in user space the dma_malloc() call which is the
wrapper function to get dmaable memory will do the
following:
     a. call the mmap() on the driver where driver
allocates the private house keeping data structure in
vma(vma->vm_private_data) and initializes vmops, so
that munmap() will call the close() implemented by
driver
     b. does an ioctl with the start of vma address
which it gets from mmap() call above and the
allocation size. driver allocates the memory and calls
remap_page_range() to map the allocated region
directly in the user space and calls mem_map_reserve()
to reserve this area. it stores the pointer to the
kmalloc'ed area in vma->vm_private_data so that it
could be freed during close() of vma. Ioctl returns
the offset into page for the allocated memory
to the user space.
     c. the wrapper function returns the pointer of
the kmalloced area by adding this offset to the page
address returned by mmap().

This works fine for the first allocation in any page
and the corresponding free. But it causes an oops if
allocations are done more than once.

Can anybody shed some light on what I am doing wrong
which is causing this oops(divide error: 0000).

Thanks in advance for any information.

Regards. 


	
		
__________________________________
Do you Yahoo!?
Yahoo! Domains – Claim yours for only $14.70/year
http://smallbusiness.promotions.yahoo.com/offer 
--0-1039399702-1085352931=:93198
Content-Type: text/plain; name="remap_page_range.c"
Content-Description: remap_page_range.c
Content-Disposition: inline; filename="remap_page_range.c"

#include <linux/kernel.h>
#include <linux/module.h>
#include <linux/sched.h>
#include <linux/ioport.h>
#include <asm/io.h>
#include <asm/delay.h>
#include <linux/fs.h>
#include <linux/slab.h>
#include <linux/mm.h>
#include <linux/mm.h>
#include <linux/pci.h>
#include <linux/wrapper.h>

int major = -1;

/*
 * structure to keep address of kmalloc'ed area so that we can free it
 * in close() for the vma. size is not required.
 */
struct my_module_mem_mgr {
    unsigned long address;
    short size;
};

struct my_module_mem_mgr *tmp_mem_mgr_ptr;

/*
 * structure in which first two arguments are set by user space and used in 
 * driver and the third is set in driver and used by user space application.
 */
struct mem_ioctl_data {
    unsigned long requested_size;
    unsigned long start_of_vma;
    unsigned long return_offset;
};

static int my_module_ioctl(struct inode *inode, struct file *filep,
        unsigned int cmd, unsigned long arg)
{
    printk("\nmy_module_ioctl() invoked\n");
    if(cmd == 1)
    {
        struct vm_area_struct *vmalist = NULL;
        unsigned long requested_size;
        struct mem_ioctl_data * mid = (struct mem_ioctl_data *)arg;
        unsigned long start_of_vma;

        printk("\nioctl cmd 2: arg = 0x%lx\n", arg);
        printk("\nmid.requested_size = 0x%lx mid.start_of_vma = 0x%lx \
                mid.return_offset = 0x%lx\n", mid->requested_size, 
                mid->start_of_vma, mid->return_offset); 

        requested_size = mid->requested_size;
        start_of_vma = mid->start_of_vma;

        /*
         * Go through the vmas of the current process and see which one
         * corresponds to the starting address which we got in the ioctl
         * arguments
         */
        vmalist = current->mm->mmap;
        if (vmalist == NULL)
        {
            printk("\nvmalist is null\n");
        } else {
            for(;vmalist != NULL; vmalist=vmalist->vm_next)
            {
                if(vmalist->vm_start == start_of_vma)
                {
                    printk("\nfound the required vma: vmalist is 0x%p start \
                            = 0x%lx\n", vmalist, vmalist->vm_start);
                    /*
                     * We should have already allocated the vm_private_data
                     * structure in the mmap() call, so it should be non-NULL
                     */
                    if (vmalist->vm_private_data != NULL)
                    {
                        int *unaligned_kptr;
                        int *kptr;
                        struct vm_area_struct * vma = vmalist;
                        unsigned long size = vma->vm_end - vma->vm_start;
                        int rv;
                        unsigned long virt_addr;
                    
                        printk("\nvma = 0x%p\n", vma);
                        printk("\nvm_start = 0x%lx\n", vma->vm_start);
                        printk("\nvm_end = 0x%lx\n", vma->vm_end);
                        printk("\nvm_pgoff = 0x%lx\n", vma->vm_pgoff);
                    
                        /*
                         * Now allocate the DMAable memory for use in 
                         * user space
                         */
                        unaligned_kptr = kmalloc(requested_size, GFP_DMA);
                        printk("\nkptr with out alignment = 0x%p\n", 
                                unaligned_kptr);
                    
                        if(unaligned_kptr == 0)
                        {
                            printk("\nkmalloc failed for size = %ld\n", 
                                    requested_size);
                            return -1;
                        }
                    
                        /* 
                         * Reserve the page of the kmalloc'ed area
                         * Without this it doesn't work, why?
                         */
                        kptr=(int *)(((unsigned long)unaligned_kptr) & PAGE_MASK);
                        printk("\nkptr with alignment = 0x%p\n", kptr);
                    
                        for (virt_addr=(unsigned long)kptr; 
                             virt_addr<(unsigned long)kptr+size;
                             virt_addr+=PAGE_SIZE)
                        {
                            //FIXME: will this effect the free of other data 
                            //       in the same page, memory leakage ???
                            printk("\ndoing mem_map_reserve for address \
                                    0x%p\n", virt_to_page(virt_addr));
                            mem_map_reserve(virt_to_page(virt_addr));
                            //get_page(virt_to_page(virt_addr));
                        }
                     
                        /*
                         * Write a signature on the allocated area
                         * which we can verify from user space after mapping
                         * this page and calculating the correct offset in the
                         * page
                         */
                        unaligned_kptr[0]=(0xabcdefab);
                    
                        rv = remap_page_range(vma, vma->vm_start, 
                                              virt_to_phys(kptr), size, 
                                              PAGE_SHARED);
                        if(rv)
                        {
                            printk("\nremap_page_range failed rv = %d\n", rv);
                            return -5;
                        } else {
                            printk("\nremap_page_range succeeded\n");
                        }
                    
                        /*
                         * Store the address of the kmalloc'ed area so that
                         * we can free it whenever the close() for the vma is
                         * called (storing size is redundant, for debugging)
                         */
                        if (vma->vm_private_data == NULL)
                        {
                            //FIXME: free allocated mem
                            printk("\nvm_private_data is null in ioctl cmd 2!!!\n");
                            return -1;
                        } else {
                            tmp_mem_mgr_ptr = (struct my_module_mem_mgr *)(vmalist->vm_private_data);
                            tmp_mem_mgr_ptr->address = (unsigned long)unaligned_kptr;
                            tmp_mem_mgr_ptr->size = requested_size;
                        }
                    
                        /*
                         * Calculate the offset of the kmalloc'ed area in the 
                         * page and return it in the ioctl argument to the
                         * user space, so that the user space can get the
                         * correct ptr in the page
                         */
                        mid->return_offset = (((unsigned long)unaligned_kptr) & (PAGE_SIZE -1));
                        printk("\noffset to be returned is = 0x%lx\n", mid->return_offset);
                        return 0;

                    } else {
                        printk("\nvmalist->vm_private_data is null in ioctl cmd 2!!!\n");
                        return -1;
                    }
                }
            }
        }
        printk("\ncouldn't find the vma!!!\n");
        return -1;
    } else {
        printk("\nInvalid ioctl, cmd = %d\n", cmd);
        return -EINVAL;
    }
    return 0;
}

void my_module_vm_open(struct vm_area_struct * area)
{
    printk("\nmy_module_vm_open ....vma = 0x%p\n", area);
}

void my_module_vm_close(struct vm_area_struct * area)
{
    void * unaligned_address;
    void * address;
    unsigned long virt_addr;
    unsigned long size = area->vm_end - area->vm_start;

    printk("\nmy_module_vm_close ....vma = 0x%p\n", area);
    if (area->vm_private_data != NULL)
    {
        unaligned_address = (void *)((struct my_module_mem_mgr *)(area->vm_private_data))->address;
        printk("\nmy_module_vm_close(): vma->vm_private_data-> address = 0x%p \
                 vma->vm_private_data->size = 0x%d\n", unaligned_address, \
                 ((struct my_module_mem_mgr *)(area->vm_private_data))->size);

        /*
        * Unreserve the pages which we reserved
        */
        address=(int *)(((unsigned long)unaligned_address ) & PAGE_MASK);
        printk("\nmy_module_vm_close(): address with alignment = 0x%p\n", address);

        for (virt_addr=(unsigned long)address; 
            virt_addr<(unsigned long)address+size; 
            virt_addr+=PAGE_SIZE)
        {
            printk("\ndoing mem_map_unreserve for address 0x%p\n", 
                    virt_to_page(virt_addr));
            mem_map_unreserve(virt_to_page(virt_addr));
            //put_page(virt_to_page(virt_addr));
        }

        printk("\nfreeing unaligned_address 0x%p\n", unaligned_address);
        kfree(unaligned_address);

    } else {
        printk("\nmy_module_vm_close(): vm_private_data is NULLLLLL\n");
    }
}

struct page * my_module_nopage(struct vm_area_struct * vma, unsigned long address, int unused)
{
    printk("\nERROR!!! my_module_nopage called \n");
    return NOPAGE_SIGBUS;
}

struct vm_operations_struct my_module_vm_ops = {
    nopage: &my_module_nopage,
    open:   &my_module_vm_open,
    close:   &my_module_vm_close,
};

//FIXME: return in error cases dont free the mem allocated above them
int my_module_mmap(struct file * filp, struct vm_area_struct *vma)
{

    printk("\nmy_module_mmap: \n");
    printk("\nvma = 0x%p\n", vma);
    printk("\nvm_start = 0x%lx\n", vma->vm_start);
    printk("\nvm_end = 0x%lx\n", vma->vm_end);

    if (vma->vm_private_data != NULL)
    {
        printk("\nmy_module_mmap(): vm_private_data = 0x%p ERROR!!!\n", 
                vma->vm_private_data);
        return -1;
    } else {
        /*
         * Allocate the memory for storing the kmalloc ptr so that we can
         * free it in the close() for this vma
         */
        tmp_mem_mgr_ptr = kmalloc(sizeof(struct my_module_mem_mgr), GFP_KERNEL);
        if (tmp_mem_mgr_ptr == NULL)
        {
            printk("\nmy_module_mmap(): kmalloc failed for tmp_mem_mgr_ptr\n");
            return -1;
        }
        vma->vm_private_data = tmp_mem_mgr_ptr;
    }

    vma->vm_ops = &my_module_vm_ops;

    return 0;
}

void *retvalp = NULL;

struct file_operations my_module_ops =
{
    ioctl: my_module_ioctl,
    mmap: my_module_mmap,
};
int init_module()
{
	printk("\ninit module\n");

    major = register_chrdev(0, "my_module", &my_module_ops);

    if(major < 0)
    {
        printk("\nFailure register_chrdev\n");
        return -1;
    }
    else
    {
        //printk("\nregister_chrdev Successful\n");
    }

	return 0;
}

void cleanup_module()
{
    unregister_chrdev(major, "my_module");
	printk("\nCleanup module\n");
}

--0-1039399702-1085352931=:93198
Content-Type: text/plain; name=Makefile
Content-Description: Makefile
Content-Disposition: inline; filename=Makefile

INCLUDES+= /usr/src/linux-2.4/include

all: remap_page_range.o dma_alloc

remap_page_range.o: remap_page_range.c
	$(CC) -c -O -I$(INCLUDES) -Wall -DMODULE -D__KERNEL__ -o $@ $^

dma_alloc: dma_alloc.c
	$(CC) -I$(INCLUDES) -Wall -o $@ $^

clean:
	rm -f remap_page_range.o dma_alloc.c

--0-1039399702-1085352931=:93198
Content-Type: text/plain; name="dma_alloc.c"
Content-Description: dma_alloc.c
Content-Disposition: inline; filename="dma_alloc.c"

#include <stdio.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <sys/ioctl.h>
#include <stdlib.h>
#include <sys/mman.h>


struct mem_ioctl_data {
    unsigned long requested_size;
    unsigned long start_of_vma;
    unsigned long return_offset;
};

void * dma_malloc(unsigned int size)
{
    int fd = -1;
    unsigned int retval;
    int mmap_size;
    struct mem_ioctl_data mid;
    void * mmaprv;

    printf("\ndma_malloc called with size %u\n", size);

	if ((fd = open("/dev/my_module", O_RDWR)) < 0)
	{
		perror("open failed for /dev/my_module");
		return NULL;
	} else {
		//printf("\nopen succeeded\n");
	}

    mmap_size = (size/4096) + 1;

    printf("\nmmap_size = 0x%x\n", mmap_size);

    mmaprv = mmap(0, mmap_size, PROT_READ|PROT_WRITE, MAP_SHARED, fd, 0);

    if(mmaprv == MAP_FAILED)
    {
        printf("\nmmap failed\n");
        perror("mmap failure");
        return NULL;
    } else {
        printf("\nmmap succeeded mmaprv = 0x%p\n", mmaprv);
    }

    mid.requested_size = size;
    mid.start_of_vma   = (unsigned long)mmaprv;
    mid.return_offset  = 0xffffffff;

    retval = ioctl(fd, 1, &mid);
    if(retval)
    {
        perror("ioctl failed");
        return NULL;
    } else {
        printf("\nioctl succeeded\n");
    }

    if(mid.return_offset == 0xffffffff)
    {
        printf("\nmid.return_offset = 0x%lx\n", mid.return_offset);
        return NULL;
    }

    printf("\nmid.return_offset = 0x%lx\n", mid.return_offset);
    return (void *)(mmaprv + mid.return_offset);
}

int main(int argc, char * argv[])
{
    unsigned int size;
    char *cptr;
    void * ptr;

    printf("\nEnter the size of allocation ...\n");
    while (scanf("%u", &size))
    {
        printf("\nSize asked is %u\n", size);
        ptr = dma_malloc(size);
        if (ptr == NULL)
        {
            printf("\ndma_malloc failed for size %d ptr = 0x%p\n\n", size, ptr);
            return 0;
        } else {
            printf("\ndma_malloc succeeded for size %d ptr = 0x%p\n\n", size, ptr);
        }

        cptr = (char *)ptr;

        /*
         * This should print the signature that we wrote to the kmalloc'ed 
         * area in the driver
         */
        printf("\nptr = 0x%lx\n", *(unsigned long *)ptr);
    }

    return 0;
}


--0-1039399702-1085352931=:93198--
