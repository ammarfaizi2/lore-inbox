Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263166AbTLAFs2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Dec 2003 00:48:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263325AbTLAFs2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Dec 2003 00:48:28 -0500
Received: from dci.doncaster.on.ca ([66.11.168.194]:42651 "EHLO smtp.istop.com")
	by vger.kernel.org with ESMTP id S263166AbTLAFsW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Dec 2003 00:48:22 -0500
From: Andrew Miklas <public@mikl.as>
Reply-To: public@mikl.as
Subject: Possible bug with munmap/nopage
Date: Mon, 1 Dec 2003 00:43:41 -0500
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Disposition: inline
To: linux-kernel@vger.kernel.org
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200312010043.41754.public@mikl.as>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,


I'm seeing a very strange bug when trying to map more than one page using the 
nopage callback.  I'm not sure if the problem is with my module or the 
kernel.

A process is able to map and unmap a region once successfully using my module; 
however, the next time the process (or another) has the same page mapped into 
its space, the munmap call will lock the process up and the system becomes 
unusable.  (Not quite a full lockup, but many things, such as starting "top", 
killing off the offending process, etc. don't work).

This happens even when I rmmod and insmod my module between runs of the 
process.  I think something (possibly my module) is doing something incorrect 
to the pages when they are unmapped.

This doesn't happen if only one page is mapped by nopage.  In that case, 
everything works correctly, even for multiple map/unmaps.


Here is the backtrace produced by using sysrq-T:
(I'm running 2.4.22 patched with kdb)

rwsem_down_failed_common + 0x4C/0x70
rwsem_down_read_failed + 0x1f/0x30
.text.lock.fault + 0x7/0x63
fbcon_scroll + 0x5a1/0xa90
scrup + 0xf8/0x110
lf + 0x62/0x70
do_page_fault + 0x0/0x4dd
error_code + 0x34/0x40
__free_pages_ok + 0x252/0x300
__free_pages + 0x27/0x30
free_pages_and_swap_cache + 0x19/0x40
__free_pte + 0x5a/0x70
zap_pte_range + 0x10f/0x134
zap_page_range + 0x82/0x100
do_munmap + 0x1d1/0x250
sys_munmap + 0x32/0x50
system_call + 0x33/0x40


I've included the code for the module and test process below.


Am I doing something wrong, or is the lockup the result of some bug in the 
kernel?


Thanks for any help.



-- Andrew


========================


module code
------------------------

#include <linux/module.h>
#include <linux/pci.h>
#include <linux/fs.h>
#include <linux/proc_fs.h>
#include <asm/page.h>
#include <asm/pgtable.h>

#define DMA_BUF_SIZE 0x2000

static int user_dma_mmap(struct file *, struct vm_area_struct *);
static struct page *user_dma_mmap_nopage(struct vm_area_struct *, unsigned 
long, int);


static void* kernAddr;
static dma_addr_t dmaAddr;


static struct file_operations fileOps = 
{
	mmap: user_dma_mmap
};

static struct vm_operations_struct vmaOps = 
{
	nopage: user_dma_mmap_nopage
};


static struct page *user_dma_mmap_nopage(struct vm_area_struct *area, unsigned 
long address, int unused)
{
	struct page *pagePtr;
	unsigned long offset = address - area->vm_start;
	unsigned long kernPageBase;

	if (offset >= DMA_BUF_SIZE)
	{
		// The process tried to remap beyond the buffer we have allocated for them.
		return NOPAGE_SIGBUS;
	}

	kernPageBase = (unsigned long) kernAddr + offset;

	// This is ok, because addresses returned by pci_alloc_consistent (ie. 
get_free_pages)
	// are safe for use with virt_to_page, right?
	pagePtr = virt_to_page(kernPageBase);

	get_page(pagePtr);

	return pagePtr;
}


static int user_dma_mmap(struct file *filp, struct vm_area_struct *vma)
{
	// We'll do the interesting stuff in nopage
	vma->vm_ops = &vmaOps;
	return 0;
}


static int __init user_dma_init(void)
{
	struct proc_dir_entry *dmaProc;

	printk(KERN_DEBUG "User DMA interface loading.\n");

	kernAddr = pci_alloc_consistent(NULL, DMA_BUF_SIZE, &dmaAddr);
	dmaProc = create_proc_entry("user_dma", S_IFBLK | S_IRUGO | S_IWUGO, 
&proc_root);

	dmaProc->proc_fops = &fileOps;
	return 0;
}

static void __exit user_dma_exit(void)
{
	pci_free_consistent(NULL, DMA_BUF_SIZE, kernAddr, dmaAddr);
	remove_proc_entry("user_dma", &proc_root);
	printk(KERN_DEBUG "User DMA interface unloading.\n");
}


MODULE_AUTHOR("Andrew Miklas (public at mikl dot as)");
MODULE_LICENSE("GPL");
MODULE_DESCRIPTION("Userspace DMA Interface");

module_init(user_dma_init);
module_exit(user_dma_exit);


=========================================


test process code
----------------------

#include <stdio.h>
#include <fcntl.h>
#include <sys/mman.h>

// 2 page mapping will cause the problem, 1 page will not.
#define SIZE 0x2000
#define OFFSET 0
#define PAGE_SIZE 0x1000

int main(int argc, char *argv[])
{
	int retVal;
	int fd = open("/proc/user_dma", O_RDWR);
	void *dmaMap = mmap(NULL, SIZE, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 
OFFSET);

	printf("MAP: %p\n", dmaMap);

	if (dmaMap != MAP_FAILED)
	{
		int i;
		for (i = 0; i < SIZE; i += PAGE_SIZE)
		{
			*((char*) (dmaMap + i));
		}

		printf("Pre unmap\n");
		retVal = munmap(dmaMap, SIZE);
		printf("UNMAP: %i\n", retVal);
	}

	close(fd);
	return 0;
}

