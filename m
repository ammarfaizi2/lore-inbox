Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264538AbUEXSsn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264538AbUEXSsn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 May 2004 14:48:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264629AbUEXSsn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 May 2004 14:48:43 -0400
Received: from sj-iport-3-in.cisco.com ([171.71.176.72]:1430 "EHLO
	sj-iport-3.cisco.com") by vger.kernel.org with ESMTP
	id S264538AbUEXSsj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 May 2004 14:48:39 -0400
From: "shanthi kiran pendyala" <skiranp@cisco.com>
To: <linux-kernel@vger.kernel.org>
Subject: Mmap problem (VM_DENYWRITE)
Date: Mon, 24 May 2004 11:49:10 -0700
Message-ID: <000a01c441bf$ccb83600$322147ab@amer.cisco.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.5709
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4927.1200
Importance: Normal
In-Reply-To: <20040519062044.15651.qmail@web90107.mail.scd.yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

<<I am not subscribed to this list b'cos of the volume of emails. Please
include my email in the reply.>>

I am writing a device driver for a fpga device. 
I implemented a dummy char device to gain user space access to the device
registers thru mmap. 
The kernel is 2.4.18. 
The CPU is sibyte (mips64 cpu) with 40 bits of physical addressing and 44
bits of virtual addressing.

After mmaping in userspace any writes to the mmap region is not working. 
I think it is b'cos of the protection field in the vma is set to
VM_DENYWRITE. 
The complete prot flag is (VM_READ | VM_WRITE | VM_EXEC | VM_GROWSUP |
VM_DENYWRITE)

Why is this happening? I need to have both read and write access to region.
How do I fix this ?

Thanks for you help

Shanthi kiran


Output after running test program
=================================
 building page tables for va 0x2aac5000 phy 0x10940000 
 vsize 0x20000 psize 0x20000 prot 0xa07


===================================================================
My mmap implementation is as follow

#define FPGA_CSR_ADDR_START 0x10940000
#define FPGA_CSR_ADDR_END   0x1095ffff
#define MMAP_SIZE (FPGA_CSR_ADDR_END + 1 - FPGA_CSR_ADDR_START)

int
fpga_mmap(struct file *filp, struct vm_area_struct *vma) {

    unsigned long offset = vma->vm_pgoff << PAGE_SHIFT;
    unsigned long vsize = vma->vm_end - vma->vm_start;
    unsigned long phys = FPGA_CSR_ADDR_START + offset;
    unsigned long psize = MMAP_SIZE - offset;

    if(vsize > psize)
        return -EINVAL;

    printk("<1> building page tables for va 0x%lx phy 0x%lx \n",
            vma->vm_start, phys);

    printk("<1> vsize 0x%lx psize 0x%lx prot 0x%lx\n",
           vsize, psize, vma->vm_page_prot.pgprot);

    /* build new page tables */
    if (remap_page_range(vma->vm_start, phys, vsize, vma->vm_page_prot))
            return -EAGAIN;

    return 0;
}
================================================================
I try to access to the device memory region with this user space test
program
    ....
	fpga_fd = open(FPGA_DEV_FILE_NAME, O_RDWR);

    if(cde_fd < 0) {
        printf("can't open %s err %d\n", FPGA_DEV_FILE_NAME, fpga_fd);
        goto finish;
    }

    offset = 0;
    fpga_csr_start = mmap(0, MMAP_SIZE,
                PROT_READ|PROT_WRITE, MAP_SHARED,
                fpga_fd, offset);

    if (fpga_csr_start < 0 ) {
        printf(" error in mmap errno %d", errno);
        goto finish;
    }

...
============================================================================

