Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261542AbULBEaZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261542AbULBEaZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Dec 2004 23:30:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261554AbULBEaZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Dec 2004 23:30:25 -0500
Received: from smtp4.cableone.net ([24.116.0.230]:4005 "EHLO S4.cableone.net")
	by vger.kernel.org with ESMTP id S261553AbULBEaD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Dec 2004 23:30:03 -0500
Message-ID: <41AE6B0F.3000804@cableone.net>
Date: Wed, 01 Dec 2004 18:08:31 -0700
From: Lance Spaulding <lsjunk1@cableone.net>
User-Agent: Mozilla Thunderbird 0.8 (X11/20041010)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: mmap() on 2.6
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Abuse-Info: Send abuse complaints to abuse@cableone.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm trying to port one of my drivers from 2.4 to 2.6 and am having 
problems getting mmap() to work.  The driver works fine in 2.4 but hangs 
on 2.6 (using the same machine). 

What I'm doing is setting aside 40 Meg of memory so I can use a 32 meg 
buffer for DMAs from a custom ASIC. I need to be able to acccess this 
memory both from kernel and user space. 

To do this, I do the following steps:

 -  In grub.conf, I use "mem=472m"

 - In my driver, I do an ioremap(0x1d800000, 0x02000000) to get a kernel 
pointer to the memory.  This part works fine.

 - In myapp, I call mmap(0, 0x02000000, (PROT_READ | PROT_WRITE), 
(MAP_SHARED | MAP_LOCKED), fd, (uint32)0x1d800000)

 - In my driver's mmap() function, I do the following:
    vma->vm_flags|=(VM_RESERVED | VM_IO | VM_LOCKED | VM_SHM);
    remap_page_range(vma, vma->vm_start, offset, 
vma->vm_end-vma->vm_start, vma->vm_page_prot)
    which ends up being:
    remap_page_range(0xDC3C7078, 0xB7257000, 0x1D800000, 0xC00000, 0x27)

This remap call works fine and my driver then tries to return 0 but at 
that point, the thread appears completely locked up. I'm never getting 
control back to the calling app. I can switch virtual consoles and run 
other commands just fine.

Can anyone tell me what I'm doing wrong and what I need to change for 
2.6? This part of the driver has always worked fine on 2.4.

Thanks in advance,
Lance
