Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261506AbTKOGCO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Nov 2003 01:02:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261509AbTKOGCO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Nov 2003 01:02:14 -0500
Received: from mail.icsmail.net ([69.5.139.6]:65188 "EHLO icsmail.net")
	by vger.kernel.org with ESMTP id S261506AbTKOGCK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Nov 2003 01:02:10 -0500
Subject: Mysterious driver-related oops in vm system
From: Steve Holland <sdh4@iastate.edu>
Reply-To: sdh4@iastate.edu
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: 
Message-Id: <1068876126.3796.18.camel@gavroche>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 15 Nov 2003 00:02:06 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I've been trying to debug a nasty driver related oops
in the VM system on 2.4 kernels, and have reduced the 
problem to a relatively simple test case that seems to cause an 
oops on most Linux kernels. The oops occurs when the
test program calls exit(). It requires more than one execution
of the test program to cause an oops. Not all kernels generate 
the oops, but there doesn't seem to be any particular pattern. 

I have seen the problem on a variety of 2.4 kernels (2.4.18-2.4.22)
including both i586 and x86-64 platforms. 


The oops is in mm/page_alloc.c, __free_pages_ok()
                if (BAD_RANGE(zone,buddy2))
                        BUG();

crashes here -> list_del(&buddy1->list);
                mask <<= 1;
                area++;
                index >>= 1;

sample call trace: __free_pte zap_pte_range do_page_fault
zap_page_range exit_mmap mmput do_exit schedule do_group_exit
system_call 

The crash is in the inline expansion of __list_del (linux/list.h):

static inline void __list_del(struct list_head *prev, struct list_head
*next)
{
        next->prev = prev;
        prev->next = next;
}

which is called by list_del: (linux/list.h)

static inline void list_del(struct list_head *entry)
{
        __list_del(entry->prev, entry->next);
        entry->next = (void *) 0;
        entry->prev = (void *) 0;
}


And the crash is because both entry->prev and entry->next are NULL. 


The problem seems to be related to the munmapping of a shared memory
segment. Modifying the test program to explicitly munmap() before
calling exit() causes instead a hang at the munmap() call. 
This is particularly intriguing, since the driver does not implement
munmap() itself, but rather relies on the kernel default behavior. 
The driver is memory mapping space originally allocated with 
pci_alloc_consistent. 

As far as I can tell, the driver implements mmap() and nopage()
correctly.

Here is mmap:

static int das4020_mmap( struct file *filePtr, struct vm_area_struct
*vma ) 
{
  int board = 0;
  int chan  = 0;
  int size  = vma->vm_end - vma->vm_start;
  unsigned int minor = MINOR(filePtr->f_dentry->d_inode->i_rdev);

  board = BOARD(minor);            /* get which board   */
  chan =  (minor & 0xf);           /* get which channel */

  if (chan >= 0 && chan < AD_CHANNELS) {

    
    if(vma->vm_pgoff != 0) {     // You have to map the entire buffer.
      return(-EINVAL);
    }

    if (size > BoardData[board].dma_phy_size) {     // You cannot
request more than the max buffer
      return(-EINVAL);
    }

    vma->vm_ops = &das4020_vops;
    vma->vm_flags |= VM_RESERVED;
    vma->vm_private_data = (void *) minor;
  }
  return 0;
}



And here is nopage(): 

static struct page *das4020_nopage(struct vm_area_struct *vma, unsigned
long address, int write_access)
{
  struct page  *page = NOPAGE_SIGBUS;      // page to be mapped
  unsigned char *v_addr = NULL;            // kernel virtual address to
be mapped to user space
  unsigned int minor = (unsigned int) vma->vm_private_data;
  int board = 0;
  int chan = 0;
  unsigned long offset;   // offset to test for valid address

  board = BOARD(minor);
  chan = (minor & 0xf);

  offset = (address - vma->vm_start) + vma->vm_pgoff * PAGE_SIZE;
  if (offset >=  BoardData[board].dma_phy_size) {
    return NOPAGE_SIGBUS;
  }
  
  v_addr =  BoardData[board].dma_virt_addr + (address - vma->vm_start);
  page = virt_to_page(v_addr);
  get_page (page);
  return (page);
}


It was suggested last night that perhaps the VM_RESERVED flag was the
problem. Removing this flag does not change the behavior. 

The test case can be downloaded from:
http://69.5.151.193/~sdh4/drvbug.tar.gz
The test case does not require specialized hardware. 

A Makefile is included with instructions for demonstrating the kernel
oops. Some kernels do not seem to show the symptoms, while others do. 
A list of tests and results is included in the makefile. 

      Thanks for your help in tracking down this bug. 

      Steve Holland     11/14/03 

sdh4 AT cornell D nospam O nospam T edu

