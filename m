Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266521AbUGPVkS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266521AbUGPVkS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jul 2004 17:40:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266522AbUGPVkS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jul 2004 17:40:18 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:27571 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S266521AbUGPVkN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jul 2004 17:40:13 -0400
Message-ID: <40F84A87.5050403@comcast.net>
Date: Fri, 16 Jul 2004 14:37:11 -0700
From: "Amit D. Chaudhary" <amit_c@comcast.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040616
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: MAX_DMA_ADDRESS in include/asm/asm-i386/dma.h (2.6.x and 2.4.x)
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While writing some DMA page gathering code, I realize that 
__get_free_page or kmalloc does not return memory more than 16 MB 
(typically around 11-12 MB even if it done right after a reboot.)

Since this is for a PCI device (A Fibre channel HBA), I remembered that 
the book Linux Device Driver, edition 2 mentions that the 16 MB limit is 
for DMA with ISA devices, while PCI DMA can access upto 950 MB or so, 
using 32 bit addresses.

Digging further into the code, I found that this being a Intel PC (a P4 
2.8 GHz with 1GB RAM) with High Mem for 4 GB enabled kernel, the define 
in linux/include/asm/asm-i386/dma.h for MAX_DMA_ADDRESS is probably what 
is limiting this. The #define is the same in 2.6.8-rc1 as well as 2.4.x 
(2.4.20 and 2.4.25 is what I checked.)

/* The maximum address that we can perform a DMA transfer to on this 
platform */
#define MAX_DMA_ADDRESS      (PAGE_OFFSET+0x1000000)

 From what I can understand so far, this implies 0xC000 0000 + 
+0x1000000 = A total of 16 MB

I changed this to 256 MB which was less than the limit in the book and 
enough for the test code purpose
#define MAX_DMA_ADDRESS      (PAGE_OFFSET+0x10000000)

After running some FC traffic and delibrately not free'ing memory, the 
memory above 16 MB was DMA'abled and the data was read and written 
correctly.

So, the question is, can someone DMA and x86 architecture expert comment 
on this? Am I missing something?
And if the above code is ok, is there a way to have the above change in 
the main kernel so that it works with ISA and PCI devices?

Thanks
Amit
