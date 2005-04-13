Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261299AbVDMKnK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261299AbVDMKnK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Apr 2005 06:43:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261300AbVDMKnJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Apr 2005 06:43:09 -0400
Received: from mail.sysgo.com ([62.8.134.5]:44176 "EHLO mail.sysgo.com")
	by vger.kernel.org with ESMTP id S261299AbVDMKmx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Apr 2005 06:42:53 -0400
From: Rolf Offermanns <roffermanns@sysgo.com>
Organization: SYSGO AG
To: linux-kernel@vger.kernel.org
Subject: mmap + dma_alloc_coherent
Date: Wed, 13 Apr 2005 12:43:47 +0200
User-Agent: KMail/1.8
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504131243.48694.roffermanns@sysgo.com>
X-AntiVirus: checked by AntiVir MailGate (version: 2.0.2-8; AVE: 6.30.0.7; VDF: 6.30.0.92; host: mailgate2.sysgo.com)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I would like to mmap a kernel buffer, allocated with pci_alloc_consistent()
for DMA, to userspace and came up with the following. Since there seem to be
some (unresolved) issues (see below) with this and I would like to do the
RightThing(TM), I would appreciate your comments about my stuff.

As for the unresolved issues, I found the following LKML threads to be very
helpful in understanding the problem:
1. (DMA API issues) 
http://marc.theaimsgroup.com/?l=linux-kernel&m=108757847518687&w=2
2. (can device drivers return non-ram via vm_ops->nopage?) 
http://marc.theaimsgroup.com/?l=linux-kernel&m=107978968703503&w=2

What I did (with comments on problematic / not fully clear to me parts):


pci_probe():
my_buffer = pci_alloc_consistent() (size: PAGE_SIZE << 4)

------------------------------------------------------------------------
my_mmap():
vma->vm_ops = &my_vm_ops;
vma->vm_flags |= (VM_RESERVED | VM_IO);
my_vma_open(vma);

my_vm_ops = {
        .open = my_vm_open,
        .close = my_vm_close,
        .nopage = my_vm_nopage,
}

Q: Is VM_IO needed here? I took it from the sg.c driver.
Q: I choosed nopage because remap_page_range does not work on RAM pages.
   Correct?
------------------------------------------------------------------------

my_vm_open():
increment vma usage count

my_vm_close():
decrement vma usage count

my_vm_nopage():
offset = (address - vma->vm_start) + (vma->vm_pgoff << PAGE_SHIFT);
pageptr = my_buffer + offset;
page = virt_to_page(pageptr);

/* got it, now increment the count */
get_page(page);

if (type)
{
        *type = VM_FAULT_MINOR;
}
return page;

Q: As seen in the threads mentioned above I should not use virt_to_page() on
addresses I got from pci_alloc_consistent/dma_alloc_coherent. What is the
right way to handle this?
Q: get_page() increments the page refcount. Where is the correspondig
put_page() operation? 
--------------------------------------------------------------------------

pci_remove():
pci_free_consistent(my_buffer, ...)

--------------------------------------------------------------------------


I first tried the above and failed. Somehow my driver seemed to screw up the
page tables. I noticed a function sg_correct4mmap() in the sg.c driver which
"fixes" refcount handling on pages allocated using __get_free_pages() with
order > 0. After implementing this things improved. Here are the changes:

my_mmap():
if (!mmap_called)
{
        correct4mmap(my_buffer, 1);
        mmap_called = 1;
}

release():
if (mmap_called)
{
        if (vma_usage_count == 0)
        {
                correct4mmap(my_buffer, 0)
                mmap_called = 0;
        }
}

Q: Can someone please briefly explain, why (if at all) this is needed?
-----------------------------------------------------------------------------

Somehow the whole thing does not "feel" right so I would really like some
comments on this. I think this could be helpful to other, too.

Quoting Jeff Garzik from one of the older threads:
"My suggestion/request to the VM wizards would be to directly provide mmap
helpers for dma/mmio/pio, that Does The Right Thing.  And require their
use in every driver.  Don't give driver writers the opportunity to think
about this stuff and/or screw it up."

There are such helper functions on ARM and Russel tried to push them into
the generic DMA API (the last time in June 2004, I think). Can any progress
be expected regarding these helper functions?


Thanks for your time.

-Rolf

-- 
Rolf Offermanns <roffermanns@sysgo.com>
SYSGO AG     Tel.: +49-6136-9948-0
Am Pfaffenstein 14   Fax: +49-6136-9948-10
55270 Klein-Winternheim  http://www.sysgo.com

