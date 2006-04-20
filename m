Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750815AbWDTKJE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750815AbWDTKJE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 06:09:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750817AbWDTKJE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 06:09:04 -0400
Received: from ms-smtp-01.tampabay.rr.com ([65.32.5.131]:3727 "EHLO
	ms-smtp-01.tampabay.rr.com") by vger.kernel.org with ESMTP
	id S1750815AbWDTKJD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 06:09:03 -0400
Message-ID: <44475DBA.7020308@cfl.rr.com>
Date: Thu, 20 Apr 2006 06:08:58 -0400
From: Mark Hounschell <dmarkh@cfl.rr.com>
Reply-To: dmarkh@cfl.rr.com
User-Agent: Thunderbird 1.5 (X11/20060111)
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
CC: markh@compro.net
Subject: get_user_pages ?
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

For some reason (unknown to me) the VM_IO and even newer VM_PFNMAP
vm_flags are set when I use this call causing it to fail for me. I'm
currently using 2.6.16.9 on an x86 platform.

My situation is this.

A user land application allocates a large chunk of memory (16-256mb) via
shmget/shmat because other applications also have to attach to the same
memory. I have to build page tables for this memory to be loaded down to
a pci card so that card can access directly that memory. Accesses can be
dma or even single word read or writes as the card sees fit. This is
what has been done successfully in the past. It has been problematic
from get go.

First the memory is remapped into bigphysarea using the mmap function of
the GPL code provided below. The bigphys patch I am using is at the very
end of this post. We use the bigphys patch because this card is not
smart enough to handle a real scatter/gather list. It does not know how
to handle crossing page boundaries into non-contiguous memory.


#define MAX_LCRSMEM_DEV 20

struct lcrsmmap {
        int             pid;            // process ID of creator
        int             type;           // if (type == 0) lcrs, else utility
        int             key;            // shared memory key
        unsigned int    vm_start;       // starting virtual address
        size_t          size;           // number of bytes
        char            *bigp_memory;   // bigphysarea virtual address
        uint64_t        lcrsmem_phys;   // bigphysarea physical address
                                        // (needed by remap)
} lcrsmmap[MAX_LCRSMEM_DEV];

static int lcrsmem_mmap(struct file *the_file, struct vm_area_struct *vma)
{
    int i, k, result;

    for (i = 0; i < MAX_LCRSMEM_DEV; i++) {
        // look for the entry made by LCRSMEM_ID ioctl required prior to
        // this call
        if (lcrsmmap[i].pid == current->pid) {
            // found the id entry
            if ((lcrsmmap[i].type == SHM_LCRS_PRIMARY)
                && (lcrsmmap[i].vm_start == vma->vm_start)) {
                // this is lcrs (primary)
                // lcrsmem_alloc_bigp() will allocate new space and
                // then remap to it
                result = lcrsmem_alloc_bigp(i, vma);
                break;
            } else if ((lcrsmmap[i].type == SHM_LCRS_UTILITY)
                       && (lcrsmmap[i].vm_start == vma->vm_start)) {
                // this is a utility,
                // Find the primary entry and remap to it.  No new
                // allocation.
                for (k = 0; k < MAX_LCRSMEM_DEV; k++) {
                    if (lcrsmmap[i].key == lcrsmmap[k].key) {
                        // found primary entry
                        // go remap it
                        result = lcrsmem_remap(k, vma);
                        break;
                    }
                }
                if (k >= MAX_LCRSMEM_DEV) {
                    // did not find primary entry
                    printk(KERN_WARNING
                           "lcrsmmap SHM_LCRS_UTILITY mmap no primary
LCRSMEM_ID entry\n");
                    return -EINVAL;
                }
                break;
            }
        }
    }
    if (i >= MAX_LCRSMEM_DEV) {
        // no matching entry found
        printk(KERN_WARNING "lcrsmmap mmap no LCRSMEM_ID entry\n");
        return -EINVAL;
    }

    return (result);
}

int lcrsmem_alloc_bigp(int entry, struct vm_area_struct *vma)
{
    unsigned long adr;
    int32_t temp_size;
    lcrsmmap[entry].size = vma->vm_end - vma->vm_start;

    lcrsmmap[entry].bigp_memory =
        (char *) bigphysarea_alloc_pages(lcrsmmap[entry].size / PAGE_SIZE,
                                         0x100000 / PAGE_SIZE, GFP_KERNEL);
    lcrsmmap[entry].lcrsmem_phys =
        virt_to_bus(lcrsmmap[entry].bigp_memory);
    if (lcrsmmap[entry].bigp_memory) {
        adr = (unsigned long) lcrsmmap[entry].bigp_memory;
        temp_size = lcrsmmap[entry].size;
        while (temp_size > 0) {
            SetPageReserved(virt_to_page(adr));
            adr += PAGE_SIZE;
            temp_size -= PAGE_SIZE;
        }
    } else {
        printk(KERN_ERR "lcrsmem: bigphysarea_alloc_pages failed\n");
        return -ENOMEM;
    }

    lcrsmmap[entry].lcrsmem_phys =
        virt_to_phys(lcrsmmap[entry].bigp_memory);

    return (lcrsmem_remap(entry, vma));
}

/*
 *  lcrsmem_remap sets the virtual memory block to the designated
 *  physical space
 *
 */
int lcrsmem_remap(int entry, struct vm_area_struct *vma)
{
    size_t lcrsmem_size;

    lcrsmem_size = vma->vm_end - vma->vm_start;

#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,10)
    if (remap_pfn_range(vma, vma->vm_start,
                        ((unsigned long) lcrsmmap[entry].
                         lcrsmem_phys) >> PAGE_SHIFT,
                        vma->vm_end - vma->vm_start, vma->vm_page_prot))
#elif LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,0)
    if (remap_page_range(vma, vma->vm_start, lcrsmmap[entry].lcrsmem_phys,
                         vma->vm_end - vma->vm_start,
                         vma->vm_page_prot))
#else
    if (remap_page_range(vma->vm_start, lcrsmmap[entry].lcrsmem_phys,
                         vma->vm_end - vma->vm_start,
                         vma->vm_page_prot))
#endif
        return -EAGAIN;
    else
        return (0);

}


Then the user land application, via an ioctl into this same module,
builds a page table by obtaining a bus address for each page in this
memory. Then sends it to the card. It is the get_user_pages call below
that now fails because the new VM_PFNMAP bit is set in vm->flags for
some reason. Also note that the Vm_IO bit in vm->flags also caused the
get_user_pages call to fail also. We worked around that and this code
worked till just recently. I assume the Vm_IO bit was set because the
initial memory was obtained through /dev/shm??? So we just reset it
before making the call.


int32_t lcrsmem_ioctl(struct inode *inode, struct file *the_file,
                      uint32_t ioctl_cmd, unsigned long arg)
{
    int i;
    pid_t task_id;
    lcrs_shm_info_t shm_info;
    unsigned int vmio_flag = 0;

    switch (ioctl_cmd) {
    case (LCRSMEM_VIRT2BUS):
        {
            // find PCI bus address for a virtual address

#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,0)
            int val;
            struct kiobuf *iobuf;
#else
            struct page *pages;
            struct vm_area_struct *vma;
            int ret = 0;
#endif
            lcrs_pte_struct_t pte_info;
            uint64_t pci_address;
            uint32_t phys_addr;

            if (copy_from_user(&pte_info,
                               (lcrs_pte_struct_t *) arg,
                               sizeof(lcrs_pte_struct_t)) != 0)
                return -EFAULT;

#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,0)

            // just translate one address
            val = alloc_kiovec(1, &iobuf);

            if (val != 0) {
                printk(KERN_WARNING
                       "LCRSMEM_VIRT2BUS alloc_kiovec failure\n");
                return (val);
            }
            val =
                (map_user_kiobuf
                 (READ, iobuf, (unsigned long) pte_info.virt_addr, 1));
            if (val != 0) {
                printk(KERN_WARNING
                       "LCRSMEM_VIRT2BUS map_user_kiobuf failure (%x)\n",
                       val);
                unmap_kiobuf(iobuf);
                free_kiovec(1, &iobuf);
                return (val);
            }
            pci_address = virt_to_bus(page_address(iobuf->maplist[0]));
            free_kiovec(1, &iobuf);
#else
            /*
             *      2.6 kernel!!!!!
             * Get our physical/bus address
             */

            down_read(&current->mm->mmap_sem);

            /*
             * Get around the mlock fix in get_user_pages that forces
             * the call to fail if VM_IO bit is set in vma->vm_flags
             * I assume the VM_IO bit is set because shm memory is
             * obtained though /dev/shm???
             */

            vma =
                find_vma(current->mm,
                    (unsigned long) pte_info.virt_addr);
            vmio_flag = (vma->vm_flags & VM_IO);
            vma->vm_flags &= ~VM_IO;

            ret = get_user_pages(current, current->mm,
                                (unsigned long) pte_info.virt_addr,
                                 1,     // one page
                                 1,     // write access
                                 1,     // force write access
                                 &pages,        // page struct
                                 NULL); //

            if (vmio_flag != 0) {
                vma->vm_flags |= VM_IO;
            }

            up_read(&current->mm->mmap_sem);

            if (ret < 0) {
                return -EFAULT;
            } else {
                phys_addr = page_to_phys(pages);        // on x86 phys = bus
                page_cache_release(pages);
            }

            pci_address = phys_addr;

#endif
            pte_info.pcimsa = 0;
            pte_info.pcilsa = pci_address;
            if (PAGE_SIZE < 8192)       // MPX page size
                pte_info.pagesize = PAGE_SIZE;
            else
                pte_info.pagesize = 8192;
            if (copy_to_user((lcrs_pte_struct_t *) arg,
                             &pte_info, sizeof(lcrs_pte_struct_t)))
                return -EFAULT;

            break;
        }

    case (LCRSMEM_ID):
        {
            // identify a shared memory partition
            if (copy_from_user(&shm_info, (int *) arg,
                               sizeof(lcrs_shm_info_t)) != 0)
                return -EFAULT;

            // search for an unused entry to fill
            for (i = 0; i < MAX_LCRSMEM_DEV; i++) {
                if (current->pid != current->tgid)
                    task_id = current->tgid;
                else
                    task_id = current->pid;

                if ((lcrsmmap[i].key == shm_info.key)
                    && (lcrsmmap[i].pid == task_id)) {
                    // duplicate key, stale?
                    break;
                } else if (lcrsmmap[i].key == 0) {
                    // use first free entry
                    lcrsmmap[i].pid = task_id;
                    lcrsmmap[i].key = shm_info.key;
                    lcrsmmap[i].vm_start =
                        (unsigned int) shm_info.address;
                    lcrsmmap[i].type = shm_info.type;
                    lcrsmmap[i].size = shm_info.size;
                    break;
                }
            }
            if (i >= MAX_LCRSMEM_DEV) {
                printk(KERN_WARNING
                       "lcrsmem attempting to mmap too many (%x)
entries\n",i);
                return -ENOMEM;
            }
            break;
        }

    default:
        return -EINVAL;
    }
    return 0;

}

Here is mm/bigphysarea.c from the bigphys patch I'm using.

/* linux/mm/bigphysarea.c, M. Welsh (mdw@cs.cornell.edu)
 * Copyright (c) 1996 by Matt Welsh.
 * Extended by Roger Butenuth (butenuth@uni-paderborn.de), October 1997
 * Extended for linux-2.1.121 till 2.4.0 (June 2000)
 *     by Pauline Middelink <middelink@polyware.nl>
 * Extended for linux-2.6.9 (November 2004)
 *     by Nick Martin <nim@mit.edu>
 * Extended for linux-2.6.11 (June 2005)
 *     by Remy Bohmer <remy.bohmer@gmail.com>
 *
 * This is a set of routines which allow you to reserve a large (?)
 * amount of physical memory at boot-time, which can be
allocated/deallocated
 * by drivers. This memory is intended to be used for devices such as
 * video framegrabbers which need a lot of physical RAM (above the amount
 * allocated by kmalloc). This is by no means efficient or recommended;
 * to be used only in extreme circumstances.
 *
 *   This program is free software; you can redistribute it and/or modify
 *   it under the terms of the GNU General Public License as published by
 *   the Free Software Foundation; either version 2 of the License, or
 *   (at your option) any later version.
 *
 *   This program is distributed in the hope that it will be useful,
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *   GNU General Public License for more details.
 *
 *   You should have received a copy of the GNU General Public License
 *   along with this program; if not, write to the Free Software
 *   Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
 *
 */

#include <linux/config.h>
#include <linux/ptrace.h>
#include <linux/types.h>
#include <linux/kernel.h>
#include <linux/init.h>
#include <linux/pci.h>
#include <linux/proc_fs.h>
#include <linux/string.h>
#include <linux/mm.h>
#include <linux/bootmem.h>
#include <linux/errno.h>
#include <linux/bigphysarea.h>

static int get_info(char* buf, char**, off_t, int);

typedef struct range_struct {
       struct range_struct *next;
       caddr_t base;                   /* base of allocated block */
       size_t  size;                   /* size in bytes */
} range_t;

/*
 * 0: nothing initialized
 * 1: bigphysarea_pages initialized
 * 2: free list initialized
 */
static int     init_level = 0;
static int     bigphysarea_pages = 0;
static caddr_t bigphysarea = 0;
static range_t *free_list = NULL;
static range_t *used_list = NULL;
static struct resource mem_resource = { "Bigphysarea", 0, 0,
IORESOURCE_MEM|IORESOURCE_BUSY };

static
int __init bigphysarea_init(void)
{
       if (bigphysarea_pages == 0 || bigphysarea == 0)
               return -EINVAL;

       /* create to /proc entry for it */
       if (!create_proc_info_entry("bigphysarea",0444,NULL,get_info)) {
               // ohoh, no way to free the allocated memory!
               // continue without proc support, it not fatal in itself
//
free_bootmem((unsignedlong)bigphysarea>>PAGE_SHIFT,bigphysarea_pages<<PAGE_SHIFT);
//             bigphysarea = 0;
//             return -ENOMEM;
       }

       init_level = 1;

       printk(KERN_INFO "bigphysarea: Allocated %d pages at 0x%p.\n",
              bigphysarea_pages, bigphysarea);

       return 0;
}

__initcall(bigphysarea_init);

/*
 * call when 'bigphysarea=' is given on the commandline.
 *
 * Strangely, bootmem is still active during this call, but
 * during the processing of the initcalls it isn't anymore!
 * So we alloc the needed memory here instead of bigphysarea_init().
 */
static
int __init bigphysarea_setup(char *str)
{
       int par;
       if (get_option(&str,&par)) {
               bigphysarea_pages = par;
               // Alloc the memory
               bigphysarea =
alloc_bootmem_low_pages(bigphysarea_pages<<PAGE_SHIFT);
               if (!bigphysarea) {
                       printk(KERN_CRIT "bigphysarea: not enough memory
for %d pages\n",bigphysarea_pages);
                       return -ENOMEM;
               }

               // register the resource for it
               mem_resource.start = virt_to_phys(bigphysarea);
               mem_resource.end = mem_resource.start +
(bigphysarea_pages<<PAGE_SHIFT);
               request_resource(&iomem_resource, &mem_resource);
       }
       return 1;
}

__setup("bigphysarea=", bigphysarea_setup);

/*
 * When we have pages but don't have a freelist, put all pages in
 * one free list entry. Return 0 on success, 1 on error.
 */
static
int init2(int priority)
{
       if (init_level == 1) {
               free_list = kmalloc(sizeof(range_t), priority);
               if (free_list != NULL) {
                       free_list->next = NULL;
                       free_list->base = bigphysarea;
                       free_list->size = bigphysarea_pages * PAGE_SIZE;
                       init_level = 2;
                       return 0;
               }
       }
       return 1;
}


/*
 * Allocate `count' pages from the big physical area. Pages are aligned to
 * a multiple of `align'. `priority' has the same meaning in kmalloc, it
 * is needed for management information.
 * This function may not be called from an interrupt!
 */
caddr_t bigphysarea_alloc_pages(int count, int align, int priority)
{
       range_t *range, **range_ptr, *new_range, *align_range;
       caddr_t aligned_base;

       if (init_level < 2)
               if (init2(priority))
                       return 0;
       new_range   = NULL;
       align_range = NULL;

       if (align == 0)
               align = PAGE_SIZE;
       else
               align = align * PAGE_SIZE;
       /*
        * Search a free block which is large enough, even with alignment.
        */
       range_ptr = &free_list;
       while (*range_ptr != NULL) {
               range = *range_ptr;
               aligned_base =
                 (caddr_t)((((unsigned long)range->base + align - 1) /
align) * align);
               if (aligned_base + count * PAGE_SIZE <=
                   range->base + range->size)
                       break;
            range_ptr = &range->next;
       }
       if (*range_ptr == NULL)
               return 0;
       range = *range_ptr;
       /*
        * When we have to align, the pages needed for alignment can
        * be put back to the free pool.
        * We check here if we need a second range data structure later
        * and allocate it now, so that we don't have to check for a
        * failed kmalloc later.
        */
       if (aligned_base - range->base + count * PAGE_SIZE < range->size) {
               new_range = kmalloc(sizeof(range_t), priority);
               if (new_range == NULL)
                       return NULL;
       }
       if (aligned_base != range->base) {
               align_range = kmalloc(sizeof(range_t), priority);
               if (align_range == NULL) {
                       if (new_range != NULL)
                               kfree(new_range);
                       return NULL;
               }
               align_range->base = range->base;
               align_range->size = aligned_base - range->base;
               range->base = aligned_base;
               range->size -= align_range->size;
               align_range->next = range;
               *range_ptr = align_range;
               range_ptr = &align_range->next;
       }
       if (new_range != NULL) {
               /*
                * Range is larger than needed, create a new list element for
                * the used list and shrink the element in the free list.
                */
               new_range->base        = range->base;
               new_range->size        = count * PAGE_SIZE;
               range->base = new_range->base + new_range->size;
               range->size = range->size - new_range->size;
       } else {
               /*
                * Range fits perfectly, remove it from free list.
                */
               *range_ptr = range->next;
               new_range = range;
       }
       /*
        * Insert block into used list
        */
       new_range->next = used_list;
       used_list = new_range;

       return new_range->base;
}
EXPORT_SYMBOL(bigphysarea_alloc_pages);

/*
 * Free pages allocated with `bigphysarea_alloc_pages'. `base' must be an
 * address returned by `bigphysarea_alloc_pages'.
 * This function my not be called from an interrupt!
 */
void bigphysarea_free_pages(caddr_t base)
{
       range_t *prev, *next, *range, **range_ptr;

       /*
        * Search the block in the used list.
        */
       for (range_ptr = &used_list;
            *range_ptr != NULL;
            range_ptr = &(*range_ptr)->next)
               if ((*range_ptr)->base == base)
                       break;
       if (*range_ptr == NULL) {
               printk("bigphysarea_free_pages(0x%08x), not allocated!\n",
                      (unsigned)base);
               return;
       }
       range = *range_ptr;
       /*
        * Remove range from the used list:
        */
       *range_ptr = (*range_ptr)->next;
       /*
        * The free-list is sorted by address, search insertion point
        * and insert block in free list.
        */
       for (range_ptr = &free_list, prev = NULL;
            *range_ptr != NULL;
            prev = *range_ptr, range_ptr = &(*range_ptr)->next)
               if ((*range_ptr)->base >= base)
                       break;
       range->next  = *range_ptr;
       *range_ptr   = range;
       /*
        * Concatenate free range with neighbors, if possible.
        * Try for upper neighbor (next in list) first, then
        * for lower neighbor (predecessor in list).
        */
       if (range->next != NULL &&
           range->base + range->size == range->next->base) {
               next = range->next;
               range->size += range->next->size;
               range->next = next->next;
               kfree(next);
       }
       if (prev != NULL &&
           prev->base + prev->size == range->base) {
               prev->size += prev->next->size;
               prev->next = range->next;
               kfree(range);
       }
}
EXPORT_SYMBOL(bigphysarea_free_pages);

caddr_t bigphysarea_alloc(int size)
{
       int pages = (size + PAGE_SIZE - 1) / PAGE_SIZE;

       return bigphysarea_alloc_pages(pages, 1, GFP_KERNEL);
}
EXPORT_SYMBOL(bigphysarea_alloc);


void bigphysarea_free(caddr_t addr, int size)
{
       (void)size;
       bigphysarea_free_pages(addr);
}
EXPORT_SYMBOL(bigphysarea_free);

static
int get_info(char *buf, char **a, off_t b, int c)
{
       char    *p = buf;
       range_t *ptr;
       int     free_count, free_total, free_max;
       int     used_count, used_total, used_max;

       if (init_level == 1)
         init2(GFP_KERNEL);

       free_count = 0;
       free_total = 0;
       free_max   = 0;
       for (ptr = free_list; ptr != NULL; ptr = ptr->next) {
               free_count++;
               free_total += ptr->size;
               if (ptr->size > free_max)
                       free_max = ptr->size;
       }

       used_count = 0;
       used_total = 0;
       used_max   = 0;
       for (ptr = used_list; ptr != NULL; ptr = ptr->next) {
               used_count++;
               used_total += ptr->size;
               if (ptr->size > used_max)
                       used_max = ptr->size;
       }

       if (bigphysarea_pages == 0) {
               p += sprintf(p, "No big physical area allocated!\n");
               return  p - buf;
       }

       p += sprintf(p, "Big physical area, size %ld kB\n",
                    bigphysarea_pages * PAGE_SIZE / 1024);
       p += sprintf(p, "                       free list:
used list:\n");
       p += sprintf(p, "number of blocks:      %8d               %8d\n",
                    free_count, used_count);
       p += sprintf(p, "size of largest block: %8d kB            %8d kB\n",
                    free_max / 1024, used_max / 1024);
       p += sprintf(p, "total:                 %8d kB            %8d kB\n",
                    free_total / 1024, used_total /1024);

       return  p - buf;
}

I'm not the author of any of this code so please gentle with me. Nor do
I have much of an understanding of the vm system. Any help in how this
task should really be accomplished, taken the stated limitations of the
pci card in mind, would be greatly appreciated. And any help as to what
would just make it work again would also be greatly appreciated. As I
stated above this all worked fine until the VM_PFNMAP bit was added to
the vm->flags and subsequently checked for in the get_user_pages call.

Thanks in advance
Regards
Mark
