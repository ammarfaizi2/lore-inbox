Return-Path: <linux-kernel-owner+w=401wt.eu-S932895AbWLNTQf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932895AbWLNTQf (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 14:16:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932897AbWLNTQf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 14:16:35 -0500
Received: from dspnet.fr.eu.org ([213.186.44.138]:4464 "EHLO dspnet.fr.eu.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932895AbWLNTQd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 14:16:33 -0500
Date: Thu, 14 Dec 2006 20:16:29 +0100
From: Olivier Galibert <galibert@pobox.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [GIT PATCH] more Driver core patches for 2.6.19
Message-ID: <20061214191629.GA68100@dspnet.fr.eu.org>
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>,
	linux-kernel@vger.kernel.org
References: <20061213195226.GA6736@kroah.com> <200612141056.03538.hjk@linutronix.de> <20061214115105.GA8742@dspnet.fr.eu.org> <200612141345.18103.hjk@linutronix.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="yrj/dFKFPuw6o+aM"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200612141345.18103.hjk@linutronix.de>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--yrj/dFKFPuw6o+aM
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Thu, Dec 14, 2006 at 01:45:16PM +0100, Hans-Jürgen Koch wrote:
> What you suggest is not a "small kernel module". It's what we have now,
> writing a complete driver.

Who says a complete driver has to be big?


> That's what UIO does, plus some standard sysfs files, that tell you e.g.
> the size of the cards memory you can map. There are standard file names
> that allow you e.g. to automatically search for all registered uio 
> drivers and their properties.

Which makes the userspace code much more complex than needed.


> If the card already has that data in its dual port RAM, you do an
> unneccessary copy.

Unnecessary only if
  [card data rate]*[maximum userspace latency] < [dual port ram size].

Doing the buffering in the kernel where it belongs changes the right
part of the equation to [buffer size], which can be orders of
magnitude way bigger.  And you can have the card DMA into the buffer
directly if you feel like it.


> > - implements a read interface to read data from the buffer
> 
> Here you do the next unneccessary copy.

You can mmap, you can splice(), none is really hard.


> > - implement ioctls for whatever controls you need
> 
> Implementing ioctls for everything is bad coding style and a has bad
> performance.

I thought the ALSA guys always said their stuff was high performance?

In any case, if ioctl is too slow for your controls, it means that
your ioctls are too low level, as in register access instead of
"reboot card at address x".  And uio, with its lack of protection
against wandering interrupts, can't cut it.


> I said "high-end AD card", that means you have a 
> signal processor on that board, want to download firmware to it 
> and so on. You end up copying lots of data between user space
> and kernel space.

You're allowed to implement write() too.


> Yes, that's a complete kernel driver that you'd never get into
> a mainline kernel. Furthermore, the card manufacturer would have to
> employ at least two experienced Linux _kernel_ programmers. That's
> too much for a small company who's business is something different.

So they have a choice between learning a minimum of linux kernel
internals, or a minimum of uio.  I suspect the hidden kinks of uio and
relative lack of documentation make the kernel route *way* easier.


> You can achieve 100 lines with uio, including sysfs and poll. What you
> describe would never fit in 200 lines for a non-trivial card.

Ok, 200 is an exaggeration.  Here is a 600-lines 2.4 driver that does
what I say, with direct dma to the internal buffer from the card and
userland-driven firmware upload.  I know that a 2.6 version would
actually be smaller.

  OG.


--yrj/dFKFPuw6o+aM
Content-Type: text/x-csrc; charset=us-ascii
Content-Disposition: attachment; filename="iiadc64.c"

//========================= Official Notice ===============================
//
// "This software was developed at the National Institute of Standards
// and Technology by employees of the Federal Government in the course of
// their official duties. Pursuant to Title 17 Section 105 of the United
// States Code this software is not subject to copyright protection and
// is in the public domain.
//
// The NIST Data Flow System (NDFS) is an experimental system and is
// offered AS IS. NIST assumes no responsibility whatsoever for its use
// by other parties, and makes no guarantees and NO WARRANTIES, EXPRESS
// OR IMPLIED, about its quality, reliability, fitness for any purpose,
// or any other characteristic.
//
// We would appreciate acknowledgement if the software is used.
//
// This software can be redistributed and/or modified freely provided
// that any derivative works bear some notice that they are derived from
// it, and any modified versions bear some notice that they have been
// modified from the original."
//
//=========================================================================




#include <linux/version.h>
#include <linux/module.h>
#include <linux/delay.h>
#include <linux/errno.h>
#include <linux/fs.h>
#include <linux/kernel.h>
#include <linux/major.h>
#include <linux/slab.h>
#include <linux/mm.h>
#include <linux/poll.h>
#include <linux/pci.h>
#include <linux/signal.h>
#include <asm/io.h>
#include <linux/ioport.h>
#include <asm/pgtable.h>
#include <asm/page.h>
#include <linux/sched.h>
#include <asm/segment.h>
#include <linux/types.h>
#include <linux/wrapper.h>
#include <linux/interrupt.h>
#include <linux/kmod.h>
#include <linux/vmalloc.h>
#include <linux/init.h>

#include "iiadc64.h"

#define DEBUG_AL(format, a...) printk(KERN_WARNING format, ##a)
#define DEBUG_ER(format, a...) printk(KERN_WARNING format, ##a)
#define DEBUG_WR(format, a...) printk(KERN_WARNING format, ##a)
#define DEBUG_IN(format, a...) printk(KERN_WARNING format, ##a)
#define DEBUG_TR(format, a...) printk(KERN_WARNING format, ##a)

enum{ MODE_MEMORY, MODE_RING, MODE_MAILBOX };
enum{ RING_SIZE = 4096*4096 };

static int iiadc64_open(struct inode *, struct file *);
static int iiadc64_release(struct inode *, struct file *);
static int iiadc64_ioctl(struct inode *, struct file *, unsigned int, unsigned long);
static ssize_t iiadc64_read(struct file *, char *, size_t, loff_t *);
static ssize_t iiadc64_write(struct file *, const char *, size_t, loff_t *);

static struct file_operations iiadc64_fops = {
  open:    iiadc64_open,
  release: iiadc64_release,
  ioctl:   iiadc64_ioctl,
  read:    iiadc64_read,
  write:   iiadc64_write
};

struct iiadc64_state {
  struct pci_dev *dev;
  unsigned long iobase;
  unsigned int irq;
  unsigned char  *memory;
  int access_mode, access_mbox;
  int irqen;
  int irqtick;
  int ring_rpos, ring_wpos;
  int dropouts;
  spinlock_t lock;

#if LINUX_VERSION_CODE >= 0x20300
  wait_queue_head_t ring_wait;
#else
  struct wait_queue *ring_wait;
#endif
} is;


/* [DaveM] I've recoded most of this so that:
 * 1) It's easier to tell what is happening
 * 2) It's more portable, especially for translating things
 *    out of vmalloc mapped areas in the kernel.
 * 3) Less unnecessary translations happen.
 *
 * The code used to assume that the kernel vmalloc mappings
 * existed in the page tables of every process, this is simply
 * not guarenteed.  We now use pgd_offset_k which is the
 * defined way to get at the kernel page tables.
 */

/* Given PGD from the address space's page table, return the kernel
 * virtual mapping of the physical memory mapped at ADR.
 */
static inline unsigned long uvirt_to_kva(pgd_t *pgd, unsigned long adr)
{
  unsigned long ret = 0UL;
  pmd_t *pmd;
  pte_t *ptep, pte;
  
  if (!pgd_none(*pgd)) {
    pmd = pmd_offset(pgd, adr);
    if (!pmd_none(*pmd)) {
      ptep = pte_offset(pmd, adr);
      pte = *ptep;
      if(pte_present(pte)) {
	ret  = (unsigned long) page_address(pte_page(pte));
	ret |= (adr & (PAGE_SIZE - 1));
				
      }
    }
  }
  return ret;
}

static inline unsigned long uvirt_to_bus(unsigned long adr) 
{
  unsigned long kva, ret;

  kva = uvirt_to_kva(pgd_offset(current->mm, adr), adr);
  ret = virt_to_bus((void *)kva);
  return ret;
}

static inline unsigned long kvirt_to_bus(unsigned long adr) 
{
  unsigned long va, kva, ret;

  va = VMALLOC_VMADDR(adr);
  kva = uvirt_to_kva(pgd_offset_k(va), va);
  ret = virt_to_bus((void *)kva);
  return ret;
}

/* Here we want the physical address of the memory.
 * This is used when initializing the contents of the
 * area and marking the pages as reserved.
 */
static inline unsigned long kvirt_to_pa(unsigned long adr) 
{
  unsigned long va, kva, ret;

  va = VMALLOC_VMADDR(adr);
  kva = uvirt_to_kva(pgd_offset_k(va), va);
  ret = __pa(kva);
  return ret;
}

static void * rvmalloc(signed long size)
{
  void * mem;
  unsigned long adr, page;

  mem=vmalloc_32(size);
  if (mem) 
    {
      memset(mem, 0, size); /* Clear the ram out, no junk to the user */
      adr=(unsigned long) mem;
      while (size > 0) 
	{
	  page = kvirt_to_pa(adr);
	  mem_map_reserve(virt_to_page(__va(page)));
	  adr+=PAGE_SIZE;
	  size-=PAGE_SIZE;
	}
    }
  return mem;
}

static void rvfree(void * mem, signed long size)
{
  unsigned long adr, page;
        
  if (mem) 
    {
      adr=(unsigned long) mem;
      while (size > 0) 
	{
	  page = kvirt_to_pa(adr);
	  mem_map_unreserve(virt_to_page(__va(page)));
	  adr+=PAGE_SIZE;
	  size-=PAGE_SIZE;
	}
      vfree(mem);
    }
}

static unsigned int iiadc64_mailbox_read(int box)
{
  int counter = 100000;
  int mask = 0xf0000 << (box*4);
  while(!(inl(is.iobase + 0x34) & mask) && (--counter));
  if(!counter)
    DEBUG_ER("iiadc64:  Timeout on mailbox %d read\n", box);
  return inl(is.iobase + 0x10 + 4*box);
}

static int iiadc64_mailbox_check_read(int box)
{
  int mask = 0xf0000 << (box*4);
  return (inl(is.iobase + 0x34) & mask) != 0;
}

static void iiadc64_mailbox_write(int box, unsigned int data)
{
  int counter = 100000;
  int mask = 0xf << box;
  while((inl(is.iobase + 0x34) & mask) && (--counter));
  if(!counter)
    DEBUG_ER("iiadc64:  Timeout on mailbox %d write\n", box);
  outl(data, is.iobase + 4*box);
}

static void iiadc64_irq(int irq, void *dev_id, struct pt_regs *regs)
{
  unsigned int istat;
  istat = inl(is.iobase + 0x38);

  if(istat & 0x20000) {
    unsigned int request = iiadc64_mailbox_read(1);

    if(request == 1) {
      spin_lock(&is.lock);
      is.ring_wpos = 0;
      is.ring_rpos = 0;
      is.dropouts = 0;
      spin_unlock(&is.lock);

      iiadc64_mailbox_write(0, 0);
    } else {
      int delta;
      int csize;
      request *= 4096;
      delta = request - is.ring_wpos;
      if(delta < 0)
	delta += RING_SIZE;

      spin_lock(&is.lock);
      csize = is.ring_wpos - is.ring_rpos;
      if(csize < 0)
	csize += RING_SIZE;
      if(csize + delta > RING_SIZE)
	is.dropouts++;

      is.ring_wpos = request;
      is.irqtick++;
      spin_unlock(&is.lock);
      wake_up_interruptible(&is.ring_wait);
    }
  }

  if(istat & 0x800000)
    outl(istat, is.iobase + 0x38);
}

static void iiadc64_reset(void)
{
  unsigned int intcsr;
  unsigned int timeout;
  unsigned int val;

  if(is.irqen)
    intcsr = 0x003f1400;
  else
    intcsr = 0x003f0000;

  outl(intcsr, is.iobase + 0x38);
  outl(0x0f000000, is.iobase + 0x3c);
  timeout = HZ/10;
  do {
    current->state = TASK_INTERRUPTIBLE;
    timeout = schedule_timeout(timeout);
  } while (timeout);
  outl(0x00000000, is.iobase + 0x3c);
  timeout = HZ/5;
  do {
    current->state = TASK_INTERRUPTIBLE;
    timeout = schedule_timeout(timeout);
  } while (timeout);

  if(is.irqen)
    outl(0x00000600, is.iobase + 0x3c);

  val = iiadc64_mailbox_read(0);
  if(val != 0x1f)
    DEBUG_ER("iiadc64: Wrong value in mailbox 0 after reset : %08x\n", val);
  else
    DEBUG_IN("iiadc64: Reset successful\n");

  while(iiadc64_mailbox_check_read(0))
    (void)iiadc64_mailbox_read(0);

  is.ring_rpos = 0;
  is.ring_wpos = 0;
}

static int iiadc64_open(struct inode *inode, struct file *file)
{
  is.access_mode = MODE_MEMORY;
  is.irqtick = 0;
  is.ring_wpos = is.ring_rpos = 0;
  is.dropouts = 0;
  if(request_irq(is.irq, iiadc64_irq, SA_SHIRQ, "iiadc64", &is)) {
    DEBUG_ER("iiadc64: Couldn't get shared irq %d\n", is.irq);
    return -EIO;
  }
  is.irqen = 1;
  iiadc64_reset();
  
  MOD_INC_USE_COUNT;
  return 0;
}

static int iiadc64_release(struct inode *inode, struct file *file)
{
  is.irqen = 0;
  iiadc64_reset();
  free_irq(is.irq, &is);
  
  MOD_DEC_USE_COUNT;
  return 0;
}

static int iiadc64_ioctl(struct inode *inode, struct file *file, unsigned int cmd, unsigned long param)
{
  switch(cmd) {
  case II_RESET:
    iiadc64_reset();
    break;

  case II_MODE_MEMORY:
    is.access_mode = MODE_MEMORY;
    break;

  case II_MODE_RING:
    is.access_mode = MODE_RING;
    break;

  case II_MODE_MAILBOX: {
    int mbox, err;
    err = get_user(mbox, (int *)param);
    if(err)
      return err;
    if(mbox<0 || mbox>3)
      return -EINVAL;
    
    is.access_mode = MODE_MAILBOX;
    is.access_mbox = mbox;
    break;
  }

  case II_PCI_TABLE: {
    unsigned int adr;
    int err;
    int i;
    err = get_user(adr, (unsigned int *)param);
    if(err)
      return err;

    for(i=0; i<RING_SIZE/4096; i++) {
      iiadc64_mailbox_write(0, 1);
      iiadc64_mailbox_write(0, adr++);
      iiadc64_mailbox_write(0, kvirt_to_bus((unsigned long)is.memory+i*4096));
    }

    break;
  }

  case II_RUN: {
    unsigned int adr;
    int err;
    err = get_user(adr, (unsigned int *)param);
    if(err)
      return err;
	
    iiadc64_mailbox_write(0, 3);
    iiadc64_mailbox_write(0, adr);
    break;
  }

  default:
    return -ENOTTY;
  }
  return 0;
}

static ssize_t iiadc64_read(struct file *file, char *buf, size_t size, loff_t *offset)
{
  switch(is.access_mode) {
  case MODE_MEMORY: {
    size_t cur_size;
    int adr = *offset / 4;
    
    cur_size = size;
    while(cur_size > 0) {
      size_t block_size = cur_size;
      unsigned int *data = (unsigned int *)is.memory;
      size_t cb_size;
      
      if(block_size > PAGE_SIZE)
	block_size = PAGE_SIZE;
      
      cur_size -= block_size;
      cb_size = block_size;
      
      while(cb_size) {
	iiadc64_mailbox_write(0, 2);
	iiadc64_mailbox_write(0, adr++);
	*data++ = iiadc64_mailbox_read(0);
	cb_size -= 4;
      }
      
      if(copy_to_user(buf, (const void *)is.memory, block_size))
	return -EFAULT;
      buf += block_size;
    }
    
    *offset += size;
    return size;
  }
  case MODE_RING: {
    size_t cur_size;
    unsigned long flags;
    int avail, dropouts;

    cur_size = size;
    while(cur_size) {
      size_t block_size;
      spin_lock_irqsave(&is.lock, flags);
      while(is.ring_wpos == is.ring_rpos) {
	spin_unlock_irqrestore(&is.lock, flags);

	interruptible_sleep_on(&is.ring_wait);
	if (signal_pending(current)) {
	  DEBUG_TR("iiadc64: ERESTARTSYS\n");
	  return -ERESTARTSYS;
	}
	spin_lock_irqsave(&is.lock, flags);
      }

      avail = is.ring_wpos - is.ring_rpos;
      spin_unlock_irqrestore(&is.lock, flags);

      if(avail < 0)
	avail += RING_SIZE;

      block_size = cur_size;
      if(block_size > avail)
	block_size = avail;
      if(block_size + is.ring_rpos > RING_SIZE)
	block_size = RING_SIZE - is.ring_rpos;

      if(copy_to_user(buf, (const void *)(is.memory + is.ring_rpos), block_size))
	return -EFAULT;

      spin_lock_irqsave(&is.lock, flags);
      is.ring_rpos += block_size;
      if(is.ring_rpos == RING_SIZE)
	is.ring_rpos = 0;

      dropouts = is.dropouts;
      is.dropouts = 0;
      spin_unlock_irqrestore(&is.lock, flags);

      if(dropouts)
	DEBUG_ER("iiadc64:  Dropout detected\n");

      buf += block_size;
      cur_size -= block_size;
    }
    *offset += size;
    return size;
  }
  case MODE_MAILBOX: {
    size_t cur_size = size;
    for(;;) {
      unsigned int val = iiadc64_mailbox_read(is.access_mbox);
      if(put_user(val, (unsigned int *)buf))
	return -EFAULT;
      buf += sizeof(unsigned int);
      if(cur_size <= sizeof(unsigned int))
	break;
      cur_size -= sizeof(unsigned int);
    }
    *offset += size;
    return size;
  }
  default:
    return -ENOTTY;
  }
}

static ssize_t iiadc64_write(struct file *file, const char *buf, size_t size, loff_t *offset)
{
  switch(is.access_mode) {
  case MODE_MEMORY: {
    size_t cur_size;
    int adr = *offset / 4;
    
    cur_size = size;
    while(cur_size > 0) {
      size_t block_size = cur_size;
      unsigned int *data = (unsigned int *)is.memory;
      
      if(block_size > PAGE_SIZE)
	block_size = PAGE_SIZE;
      
      if(copy_from_user((void *)is.memory, buf, block_size))
	return -EFAULT;
      buf += block_size;
      cur_size -= block_size;
      
      while(block_size) {
	iiadc64_mailbox_write(0, 1);
	iiadc64_mailbox_write(0, adr++);
	iiadc64_mailbox_write(0, *data++);
	block_size -= 4;
      }
    }
    
    *offset += size;
    return size;
  }
  case MODE_MAILBOX: {
    size_t cur_size = size;
    for(;;) {
      unsigned int val;
      if(get_user(val, (unsigned int *)buf))
	return -EFAULT;
      iiadc64_mailbox_write(is.access_mbox, val);
      buf += sizeof(unsigned int);
      if(cur_size <= sizeof(unsigned int))
	break;
      cur_size -= sizeof(unsigned int);
    }
    *offset += size;
    return size;
  }
  default:
    return -ENOTTY;
  }
}


#ifdef MODULE
int init_module(void)
#else
  int iiadc64_init(void)
#endif
{
  DEBUG_AL("IIADC64 minimal kernel driver (c) 1999 Olivier Galibert\n");

  is.dev = pci_find_device(0x10e8, 0x807f, 0);
  if(!is.dev) {
    DEBUG_ER("iiadc64: Unable to find the DSP board\n");
    return -EIO;
  }

#if LINUX_VERSION_CODE >= 0x20400
  if(pci_enable_device(is.dev))
    return -EIO;

  pci_set_master(is.dev);

  is.iobase = pci_resource_start(is.dev, 0);
#else
  is.iobase = is.dev->base_address[0] & PCI_BASE_ADDRESS_IO_MASK;
#endif
  is.irq = is.dev->irq;
  is.memory = rvmalloc(RING_SIZE);

  if(!is.memory) {
    DEBUG_ER("iiadc64: Couldn't allocate ring buffer\n");
    return -EIO;
  }

  if (register_chrdev(II_MAJOR, "iiadc64", &iiadc64_fops)) {
    DEBUG_ER("iiadc64: Unable to register character device\n");
    return -EIO;
  }

  DEBUG_IN("iiadc64: DSP board found, io at 0x%lx, irq %u\n", is.iobase, is.irq);

#if LINUX_VERSION_CODE >= 0x20300
  init_waitqueue_head(&is.ring_wait);
#else
  is.ring_wait = 0;
  init_waitqueue(&is.ring_wait);
#endif

  is.lock = SPIN_LOCK_UNLOCKED;

  iiadc64_reset();

  return 0;
}

#ifdef MODULE
void cleanup_module(void)
{
  rvfree(is.memory, RING_SIZE);
  unregister_chrdev(II_MAJOR, "iiadc64");
}
#endif

--yrj/dFKFPuw6o+aM
Content-Type: text/x-chdr; charset=us-ascii
Content-Disposition: attachment; filename="iiadc64.h"

//========================= Official Notice ===============================
//
// "This software was developed at the National Institute of Standards
// and Technology by employees of the Federal Government in the course of
// their official duties. Pursuant to Title 17 Section 105 of the United
// States Code this software is not subject to copyright protection and
// is in the public domain.
//
// The NIST Data Flow System (NDFS) is an experimental system and is
// offered AS IS. NIST assumes no responsibility whatsoever for its use
// by other parties, and makes no guarantees and NO WARRANTIES, EXPRESS
// OR IMPLIED, about its quality, reliability, fitness for any purpose,
// or any other characteristic.
//
// We would appreciate acknowledgement if the software is used.
//
// This software can be redistributed and/or modified freely provided
// that any derivative works bear some notice that they are derived from
// it, and any modified versions bear some notice that they have been
// modified from the original."
//
//=========================================================================



#ifndef __IIADC64_H
#define __IIADC64_H

#include <linux/ioctl.h>

#define II_MAJOR 121

#define II_RESET		_IO(II_MAJOR, 0)
#define II_MODE_MEMORY		_IO(II_MAJOR, 1)
#define II_MODE_RING		_IO(II_MAJOR, 2)
#define II_MODE_MAILBOX		_IOR(II_MAJOR, 3, int)
#define II_PCI_TABLE		_IOR(II_MAJOR, 4, unsigned int)
#define II_RUN			_IOR(II_MAJOR, 5, unsigned int)

#endif

--yrj/dFKFPuw6o+aM--
