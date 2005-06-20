Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261594AbVFTVKd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261594AbVFTVKd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 17:10:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261552AbVFTVHy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 17:07:54 -0400
Received: from alog0364.analogic.com ([208.224.222.140]:32932 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261575AbVFTVDz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 17:03:55 -0400
Date: Mon, 20 Jun 2005 17:03:17 -0400 (EDT)
From: "Richard B. Johnson" <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: "David S. Miller" <davem@davemloft.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: Linux-2.6.12 memory mapping broken
In-Reply-To: <20050620.134302.85685273.davem@davemloft.net>
Message-ID: <Pine.LNX.4.61.0506201650400.5656@chaos.analogic.com>
References: <Pine.LNX.4.61.0506201548150.5317@chaos.analogic.com>
 <20050620.134302.85685273.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Jun 2005, David S. Miller wrote:

> From: "Richard B. Johnson" <linux-os@analogic.com>
> Date: Mon, 20 Jun 2005 15:53:34 -0400 (EDT)
>
>> I can test any patches.
>
> You have to let remap_pfn_range() fill in the PTEs for you,
> you can't fill them in yourself.  Just supply the correct
> "pfn" argument and you should be all set.
>

So I just supply the pointer now?

Right now my code does:

This is version-dependent, therefore a MACRO:
#define REMAP(a,b,c,d,e) remap_pfn_range((a), (b), (c) >> PAGE_SHIFT, (d), (e))

SHOW is a MACRO to write debugging info if enabled.

static int mmap(struct file *fp, struct vm_area_struct *vma)
{
     int minor, ret = 0;
     size_t len;
     SHOW(mmap);
     minor = MINOR(fp->f_dentry->d_inode->i_rdev);	// Extended open
     DEB(printk("UNIQUE.dma.len = %08x\n", UNIQUE.dma.len));
     DEB(printk("vma->vm_end-vma->vm_start=%08lx\n",vma->vm_end-vma->vm_start));
     len = MIN(UNIQUE.dma.len, (vma->vm_end - vma->vm_start));
     down(&UNIQUE.pci_sem);				// Acquire resource
     vma->vm_flags |= (VM_IO | VM_SHM | VM_LOCKED);	// Set required flags
     vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
     DEB(printk("About to execute remap_pfn_range\n"));
     DEB(printk("    vma->vm_start = %08lx\n", vma->vm_start));
     DEB(printk("     base address = %08x\n", UNIQUE.dma.base));
     DEB(printk("           length = %08x\n", len));
     DEB(printk("vma->vm_page_prot = %08x\n", *((size_t *)&vma->vm_page_prot)));
     ret = REMAP(vma, vma->vm_start, UNIQUE.dma.base, len, vma->vm_page_prot);
     DEB(printk("   returned value = %d\n", ret));
     up(&UNIQUE.pci_sem);				// Release resource
     return ret;
}

If I just give it the pointer, what do I put in the other
passed parameters?


Cheers,
Dick Johnson
Penguin : Linux version 2.6.11.9 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
