Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261828AbVCUPc4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261828AbVCUPc4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 10:32:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261824AbVCUPc4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 10:32:56 -0500
Received: from post.tau.ac.il ([132.66.16.11]:29673 "EHLO post.tau.ac.il")
	by vger.kernel.org with ESMTP id S261830AbVCUPcG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 10:32:06 -0500
Date: Mon, 21 Mar 2005 17:32:00 +0200 (IST)
From: Hayim Shaul <hayim@post.tau.ac.il>
X-X-Sender: hayim@nova.cs.tau.ac.il
To: linux-kernel@vger.kernel.org
Subject: mmap/munmap bug
Message-ID: <Pine.LNX.4.61.0503211731430.9160@nova.cs.tau.ac.il>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi all,

I have an unexplained bug with mmap/munmap on 2.6.X.

I'm writing a kernel module that gives super-fast access to the network.
It does so by doing mmap thus avoiding the memcpy to/from user.

It works well for some time but then the kernel panics with a bad_page
message (full stack is given below)

What I understand from this message is that an unmapped page is being
unmapped again. The bug usually appears when I unmap the area from user
space.

I don't understand what I am doing wrong. I follow the example from
Linux-device-driver (2nd ed.) and codes I found under drivers/.

I also saw that there's a mapping bug in the 2.6 kernels. I'm not
convinced yet that this is the case, but if so, is there a work around?

relevant parts of the code are given below.

I'd appreciate any input,
   Hayim.

************************************88
The full panic message:

Mar 21 08:48:15 localhost kernel: Bad page state at free_hot_cold_page
(in process 'noa', page c1000100)
Mar 21 08:48:15 localhost kernel: flags:0x00001014 mapping:00000000
mapcount:0 count:0
Mar 21 08:48:15 localhost kernel: Backtrace:
Mar 21 08:48:15 localhost kernel:  [<c01329a5>] bad_page+0x75/0xb0
Mar 21 08:48:15 localhost kernel:  [<c013308c>]
free_hot_cold_page+0x5c/0xd0
Mar 21 08:48:15 localhost kernel:  [<c013c6fb>]
zap_pte_range+0x14b/0x270
Mar 21 08:48:15 localhost kernel:  [<c013c873>] zap_pmd_range+0x53/0x70
Mar 21 08:48:15 localhost kernel:  [<c013c8d3>] zap_pud_range+0x43/0x60
Mar 21 08:48:15 localhost kernel:  [<c013c96e>]
unmap_page_range+0x7e/0xa0
Mar 21 08:48:15 localhost kernel:  [<c013ca81>] unmap_vmas+0xf1/0x200
Mar 21 08:48:15 localhost kernel:  [<c0141005>] unmap_region+0x75/0xe0
Mar 21 08:48:15 localhost kernel:  [<c0141303>] do_munmap+0x113/0x150
Mar 21 08:48:15 localhost kernel:  [<c0141384>] sys_munmap+0x44/0x70
Mar 21 08:48:15 localhost kernel:  [<c0102563>] syscall_call+0x7/0xb
Mar 21 08:48:15 localhost kernel: Trying to fix it up, but a reboot is
needed

**********************************************************8


static void sniffer_vma_open(struct vm_area_struct *vma) {
     printk("vma_open\n");
}

static void sniffer_vma_close(struct vm_area_struct *vma) {
     printk("vma_close\n");
}

static int proc_file_mmap(struct file *filp, struct vm_area_struct *vma)
{
     /* don.t do anything here: "nopage" will fill the holes */
     vma->vm_ops = &sniffer_vm_ops;
     vma->vm_flags |= VM_RESERVED;
     sniffer_vma_open(vma);
     return 0;
}

static struct page *proc_file_nopage(struct vm_area_struct *vma,
                 unsigned long address, int *type)
{
     struct page *page = NOPAGE_SIGBUS;

     unsigned long physaddr = ((address - vma->vm_start) >> PAGE_SHIFT) +
vma->vm_pgoff;

     if (! page_should_be_mapped(my_page_bitmap, physaddr))
         return NOPAGE_SIGBUS;

     page = virt_to_page((physaddr << PAGE_SHIFT));
//  page = virt_to_page(__va(physaddr << PAGE_SHIFT));    // bug in LDD?
     get_page(page);
     return page;
                                                                                }

struct vm_operations_struct sniffer_vm_ops = {
     .open   = sniffer_vma_open,
     .close  = sniffer_vma_close,
     .nopage = proc_file_nopage,
};
                                                                                 static 
struct file_operations File_Ops_4_Our_Proc_File = {
     .read = proc_file_read,
     .write = proc_file_write,
     .open = proc_file_open,
     .release = proc_file_close,
     .mmap = proc_file_mmap,
};

--
Kernelnewbies: Help each other learn about the Linux kernel.
Archive:       http://mail.nl.linux.org/kernelnewbies/
FAQ:           http://kernelnewbies.org/faq/


+++++++++++++++++++++++++++++++++++++++++++
This Mail Was Scanned By Mail-seCure System
at the Tel-Aviv University CC.
