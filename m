Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269494AbUHZU24@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269494AbUHZU24 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 16:28:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269589AbUHZUZu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 16:25:50 -0400
Received: from mout.perfora.net ([217.160.230.41]:16320 "EHLO mout.perfora.net")
	by vger.kernel.org with ESMTP id S269592AbUHZUXA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 16:23:00 -0400
X-Provags-ID: perfora.net abuse@perfora.net f6539cf98449d0c71ae4cb6bf16e71fe
Message-Id: <4.3.2.7.2.20040826123833.0188e068@popmail.compuserve.com>
X-Mailer: QUALCOMM Windows Eudora Version 4.3.2
Date: Thu, 26 Aug 2004 13:22:47 -0700
To: linux-kernel@vger.kernel.org
From: Clive Levinson <clivel@bundu.com>
Subject: Physical memory mapping with nopage handler
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I have been stuck for a few days trying to map physical memory
in my framebuffer driver using the nopage handler on a strongArm.

The hardware is physically at address 0x2C000000, iotable_init()
maps it to 0XF1000000.

Within my driver, writing directly to 0XF1000000 will set pixels
on the screen. However for, a user application that calls mmap
to map the framebuffer, I need to do something like:
io_remap_page_range(vma->vm_start, 0x2c000000,
                     vma->vm_end - vma->vm_start,
                     vma->vm_page_prot)

This works, and the user level application then is able to write
to the framebuffer.

My first point of confusion, is what is the relationship between
the physical address at 0x2C000000, and the 0XF1000000 ?

The real problem is that my hardware has banked memory,
using  mmap,  I can only write to the first 64K of the framebuffer.
I decided to get around this by using a nopage handler, so that I
can handle the bank switching.

This is basically what I have:

static struct vm_operations_struct myfb_vm_ops = {
   nopage: myfb_nopage,
};

static int myfb_mmap(struct fb_info *info,
                      struct file *file,
                      struct vm_area_struct *vma)
{
   vma->vm_flags = vma->vm_flags|VM_IO|VM_RESERVED;
   vma->vm_ops = &myfb_vm_ops;
   return 0;
}

static struct page * myfb_nopage(struct vm_area_struct * vma,
                                  unsigned long address,
                                  int unused)
{

   pte_t pte;

   //ignore the address offset at this point, assume it is the
   //same as vma->vm_start

   //pte=mk_pte_phys( 0x2c000000, PAGE_SHARED); //Generates an error
   pte=mk_pte_phys( 0xf1000000, PAGE_SHARED); //No error
   pageptr=pte_page( pte );
   get_page( pageptr );
   return pageptr;
}

If I use mk_pte_phys( 0x2c000000, PAGE_SHARED), I get an internal
error. If use pte=mk_pte_phys( 0xf1000000, PAGE_SHARED), it
satisfies the page request, however, the write is not actually
happening to the actual framebuffer, I am not sure where it
is going. Any suggestions or tips please?

I am using Linux V2.4.18, I would appreciate any replies CC'd
directly to me, as I am not subscribed to the list.
Thanks,
Clive

