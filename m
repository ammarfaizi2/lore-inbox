Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263499AbTIIJJr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 05:09:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263501AbTIIJJr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 05:09:47 -0400
Received: from mta204-rme.xtra.co.nz ([210.86.15.147]:58581 "EHLO
	mta204-rme.xtra.co.nz") by vger.kernel.org with ESMTP
	id S263499AbTIIJJo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 05:09:44 -0400
Message-ID: <3F5E7ACD.8040106@tait.co.nz>
Date: Tue, 09 Sep 2003 21:13:49 -0400
From: Dmytro Bablinyuk <dmytro.bablinyuk@tait.co.nz>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030313
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Problem with remap_page_range
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


We have a DSP shared memory which we should access (from PowerPC).
The problem is when I do ioremap I can see the memory correctly from the 
driver (see below) but when I do remap_page_range to the user space 
application then data appears to be wrong, I can recognize some values 
there, but they are in the wrong places and other values around from 
everywhere else (see below).

I tried mem_map_reserve - but still without luck.

Could somebody please give me a clue on this.

Thank you very much in advance for any help.

Below: the dsp_area prints correct values from DSP RAM but remap_page_range does not work properly.

  dsp_ptr=ioremap_nocache( DSP_ADDR, WINDOW_SIZE);
  dsp_area=(ushort *)(((unsigned long)dsp_ptr + PAGE_SIZE -1) &
PAGE_MASK);
/*   for (virt_addr=(unsigned long)dsp_area; virt_addr<(unsigned
long)dsp_area+WINDOW_SIZE; */
/*        virt_addr+=PAGE_SIZE) { */
/*       /\* reserve all pages to make them remapable *\/ */
/*     mem_map_reserve(virt_to_page(virt_addr)); */
/*   } */

  printk("dsp_area[0]=%04x\n", dsp_area[0]); //prints correct values
  ...
  vma->vm_flags |= (VM_SHM | VM_LOCKED | VM_IO | VM_RESERVED);

  if (remap_page_range(vma->vm_start,
                       DSP_ADDR,
                       size,
                       vma->vm_page_prot
                       ))
    {
      printk("remap page range failed\n");
      return -ENXIO;
    }

Here is the ouput:
//correct from the driver
dsp_area[0]=0000
dsp_area[1]=bc00
dsp_area[2]=eb17
dsp_area[3]=2643
dsp_area[4]=54cd
dsp_area[5]=5405
dsp_area[6]=91ba
dsp_area[7]=49c2
dsp_area[8]=1f61
hpi_mmap: vma->vm_start=3006f000, vma->vm_end=30097000
vma->vm_flags=864fb

//wrong from the user space application
kadr=0x3006f000
kadr[0]=1c59
kadr[1]=49c2
kadr[2]=5405
kadr[3]=bc00
kadr[4]=49c2
kadr[5]=54cd
kadr[6]=bc00
kadr[7]=54cd



