Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262066AbTKYHMj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Nov 2003 02:12:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262072AbTKYHMj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Nov 2003 02:12:39 -0500
Received: from [202.37.96.11] ([202.37.96.11]:38809 "EHLO
	gatekeeper.tait.co.nz") by vger.kernel.org with ESMTP
	id S262066AbTKYHM3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Nov 2003 02:12:29 -0500
Date: Tue, 25 Nov 2003 20:16:15 +1300
From: Dmytro Bablinyuk <dmytro.bablinyuk@tait.co.nz>
Subject: tmpfs crashes without devfs support
To: linux-kernel@vger.kernel.org
Message-id: <3FC301BF.3050208@tait.co.nz>
MIME-version: 1.0
Content-type: multipart/mixed; boundary="Boundary_(ID_b4lHomz0OeDZ7EGwJydQZA)"
X-Accept-Language: en-us, en
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.5)
 Gecko/20030925
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--Boundary_(ID_b4lHomz0OeDZ7EGwJydQZA)
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT

Hi,

We have a problem and we think we got a solution but could anybody
please explain me the connection between tmpfs and devfs.

The actual story is:
We have a PowerPC 8xx (2.4.22 kernel) having a shared memory with DSP.
We have a driver(see attach) which mmaps devices shared memory to a user
process memory and we have tmpfs enabled.
After some time we discovered - whenever you do "ls /proc/net" it
crashes kernel. It works fine without our driver.
But we also discovered if we enable DEVFS support then tmpfs works just
fine with driver and no crashes anymore.

Could somebody explain me please a connection between tmpfs and devfs if
any.

Thank you very much for any help.


--Boundary_(ID_b4lHomz0OeDZ7EGwJydQZA)
Content-type: text/plain; name=hpi.c
Content-transfer-encoding: 7BIT
Content-disposition: inline; filename=hpi.c

#include <linux/config.h>
#include <linux/version.h>
#include <linux/module.h>
#if defined(MODVERSIONS)
#include <linux/modversions.h>
#endif

#include <linux/kernel.h>
#include <linux/fs.h>
#include <linux/string.h>
#include <linux/module.h>
#include <linux/errno.h>

#include <linux/mm.h>
#include <linux/vmalloc.h>
#include <linux/mman.h>
#include <linux/wrapper.h>
#include <linux/slab.h>
#include <asm/io.h>

#include <asm/8xx_immap.h>

/* needed for __init,__exit directives */ 
#include <linux/init.h>

#define DSP_BASE      (( unsigned long)0x80000000)

#define DSP_ADDR      (( unsigned long)0x80100000)
#define WINDOW_SIZE   (( unsigned long)0x00028000)

#define LOW_PA13   1
#define HIGH_PA13  2
#define RUN        3
#define TOGL_PA2   4 //PA2

#define PA13       0x0004
#define PA2        0x2000

#define BUG        1

volatile immap_t *immap;
volatile unsigned char togl;

/* device open */
int hpi_open(struct inode *inode, struct file *file);
/* device close */
int hpi_release(struct inode *inode, struct file *file);
/* device mmap */
int hpi_mmap(struct file *file, struct vm_area_struct *vma);
/* device ioctl */
int hpi_ioctl(struct inode *, struct file *, unsigned int, unsigned long);

/* the ordinary device operations */
static struct file_operations hpi_fops =
  {
    owner:   THIS_MODULE,
    mmap:    hpi_mmap,
    open:    hpi_open,
    release: hpi_release,
    ioctl:   hpi_ioctl,
  };

/* pointer to page aligned area */
static ushort *dsp_area = NULL;
/* pointer to unaligned area */
static ushort *dsp_ptr = NULL;

#if BUG
/* pointer to page aligned area */
static ushort *dsp_area_b = NULL;
/* pointer to unaligned area */
static ushort *dsp_ptr_b = NULL;
#endif

/* major number of device */
static int major;

int device_used = 0;

/* we parse the page tables in order to find the direct mapping of
   the page. This works only without holding any locks for pages we
   are sure that they do not move in memory.
*/
volatile void *virt_to_kseg(volatile void *address)
{
  pgd_t *pgd; pmd_t *pmd; pte_t *ptep, pte;
  unsigned long va, ret = 0UL;
	
  va=VMALLOC_VMADDR((unsigned long)address);
	
  /* get the page directory. Use the kernel memory map. */
  pgd = pgd_offset_k(va);

  /* check whether we found an entry */
  if (!pgd_none(*pgd)) {
    /* get the page middle directory */
    pmd = pmd_offset(pgd, va);
    /* check whether we found an entry */
    if (!pmd_none(*pmd)) {
      /* get a pointer to the page table entry */
      ptep = pte_offset(pmd, va);
      pte = *ptep;
      /* check for a valid page */
      if (pte_present(pte)) {
        /* get the address the page is refering to */
        ret = (unsigned long)page_address(pte_page(pte));
        /* add the offset within the page to the page address */
        ret |= (va & (PAGE_SIZE -1));
      }
    }
  }
  return((volatile void *)ret);
}

int __init init_hpi(void)
{

  unsigned long virt_addr;

  immap = (immap_t *)(mfspr(IMMR) & 0xFFFF0000);
  printk("HPI interface 201103\n");

  immap->im_ioport.iop_papar &= ~(PA13 | PA2); /* set PA13 to general I/O */
  immap->im_ioport.iop_padir |=  (PA13 | PA2); /* set PA13 as output      */

  if ((major=register_chrdev(0, "hpi", &hpi_fops))<0) {
    printk("hpi: unable to register character device\n");
    return (-EIO);
  }

  dsp_ptr=ioremap_nocache( DSP_BASE, WINDOW_SIZE);

  dsp_area=(ushort *)(((unsigned long)dsp_ptr + PAGE_SIZE -1) & PAGE_MASK);
  
  for (virt_addr=(unsigned long)dsp_area; virt_addr<(unsigned long)dsp_area + WINDOW_SIZE;
       virt_addr+=PAGE_SIZE) {
    /* reserve all pages to make them remapable */
    mem_map_reserve(virt_to_page(virt_addr));
  } 
  
#if BUG
  dsp_ptr_b=ioremap_nocache( DSP_BASE + 0x200000, WINDOW_SIZE);

  dsp_area_b=(ushort *)(((unsigned long)dsp_ptr_b + PAGE_SIZE -1) & PAGE_MASK);
  
  for (virt_addr=(unsigned long)dsp_area_b; virt_addr<(unsigned long)dsp_area_b + WINDOW_SIZE;
       virt_addr+=PAGE_SIZE) {
    /* reserve all pages to make them remapable */
    mem_map_reserve(virt_to_page(virt_addr));
  } 
#endif  

  return(0);
}

void __exit cleanup_hpi(void)
{
  unsigned long virt_addr;
  /* unreserve all pages */
   for(virt_addr=(unsigned long)dsp_area; virt_addr<(unsigned long)dsp_area+WINDOW_SIZE;
       virt_addr+=PAGE_SIZE) { 
       mem_map_unreserve(virt_to_page(virt_addr)); 
     } 

  iounmap((void *)DSP_ADDR);

#if BUG
  iounmap((void *)DSP_ADDR + 0x200000);
#endif

  /* unregister the device */
  unregister_chrdev(major, "hpi");
  return 0;
}

/* device open method */
int hpi_open(struct inode *inode, struct file *file)
{
  if (device_used){
    printk("Warning: device in use or was not released. Forcing to release device.");
    hpi_release( inode, file);
  }

  device_used ++;

  MOD_INC_USE_COUNT;

  immap->im_ioport.iop_padat &= ~PA2;
  togl = 0;

  return(0);
}

/* device close method */
int hpi_release(struct inode *inode, struct file *file)
{

  device_used --;

  MOD_DEC_USE_COUNT;

  return(0);
}

int hpi_ioctl(struct inode *inode, struct file *file, unsigned int cmd, unsigned long arg)
{
  static ushort *dsp_base_ptr;
  switch(cmd){
  case LOW_PA13:
    immap->im_ioport.iop_padat &= ~PA13;
    printk("%s: PA13 low\n", __func__);
    break;
  case HIGH_PA13:
    immap->im_ioport.iop_padat |= PA13; 
    printk("%s: PA13 high\n", __func__);
    break;
  case TOGL_PA2:
    if (togl){
      immap->im_ioport.iop_padat &= ~PA2;
      togl = 0;
    } else {
      immap->im_ioport.iop_padat |= PA2;
      togl = 1;
    }
    break;
  case RUN:
    dsp_base_ptr=ioremap_nocache( DSP_BASE, PAGE_SIZE);
    dsp_base_ptr[0] = 0x1;
    iounmap(dsp_base_ptr);
    break;
  }
  return(0);
}

/* device memory map method */
/* 2.4.x: this method is called from do_mmap_pgoff, from
   do_mmap, from the syscall. The caller of do_mmap grabs
   the mm semaphore. So we are protected from races here.
*/
int hpi_mmap(struct file *file, struct vm_area_struct *vma)
{

  unsigned long virt_addr;
  unsigned long offset = vma->vm_pgoff<<PAGE_SHIFT;
  unsigned long size = vma->vm_end - vma->vm_start;
  unsigned long base = DSP_ADDR + offset;

  if (offset & ~PAGE_MASK)
    {
      printk("offset not aligned: %ld\n", offset);
      return -ENXIO;
    }
        
  if (size != WINDOW_SIZE)
    {
      printk("wrong size\n");
      return(-ENXIO);
    }
        
  /* we only support shared mappings. Copy on write mappings are
     rejected here. A shared mapping that is writeable must have the
     shared flag set.
  */
  if ((vma->vm_flags & VM_WRITE) && !(vma->vm_flags & VM_SHARED))
    {
      printk("writeable mappings must be shared, rejecting\n");
      return(-EINVAL);
    }

#define pgprot_noncached(prot)  (__pgprot(pgprot_val(prot) | _PAGE_NO_CACHE | _PAGE_GUARDED))

  /* pages shouldn't be cached */
  vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);

  /* we do not want to have this area swapped out, lock it */  
  vma->vm_flags |= (VM_SHM | VM_LOCKED | VM_IO | VM_RESERVED);
          
  /* we create a mapping between the physical pages and the virtual
     addresses of the application with remap_page_range.
  */
  /*enter pages into mapping of application */

  if (io_remap_page_range(vma->vm_start,
                          base,
                          size,
                          vma->vm_page_prot
                          ))
    {
      printk("remap page range failed\n");
      return -ENXIO;
    }

  return(0);
}


module_init(init_hpi);
module_exit(cleanup_hpi);


--Boundary_(ID_b4lHomz0OeDZ7EGwJydQZA)--
