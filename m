Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261250AbTEEThG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 15:37:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261251AbTEEThG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 15:37:06 -0400
Received: from paloalto-smrly2.gtei.net ([131.119.246.6]:23285 "HELO
	paloalto-smrly2.gtei.net") by vger.kernel.org with SMTP
	id S261250AbTEEThF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 15:37:05 -0400
Message-ID: <6AF24836F3EB074BA5C922466F9E92E10791B53E@prince.pc.cognex.com>
From: "Lee, Shuyu" <SLee@cognex.com>
To: linux-kernel@vger.kernel.org
Subject: How to DMA data from a pci device to a user buffer directly
Date: Mon, 5 May 2003 15:49:23 -0400 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, All.

In my device driver, I want to DMA image data from a PCI device (a frame
grabber) to a user buffer directly. Right now I am stuck at how to convert a
user virtual address to a physical address that can be used by the DMA
controller. 

Here is my sequence:
1) User allocates an image buffer, 
2) User passes the pointer (pUserVirtualAddr) of that buffer to the driver
through an ioctl call,
3) Driver calls alloc_kiovec(1, &iobuf);
4) Driver calls map_user_kiobuf(WRITE, iobuf, (ULONG)pUserVirtualAddr,
imageBufferSize);
I believe map_user_kiobuf() is executed successfully, for the following
reasons:
1) map_user_kiobuf() returns 0,
2) For imageBufferSize = 640*160, iobuf->nr_pages = 26. Because
pUserVirtualAddr is not page-aligned, 26 is correct. 
3) iobuf->offset is equal to (ULONG)pUserVirtualAddr & 0xFFF, which is also
correct.
What is strange to me is that iobuf->maplist[idx]->virtual = 0 for idx =
0,1,2,...,25.

One driver developer suggested that I do the following to get the physical
address for the first page:
physAddr = virt_to_bus(page_address(iobuf->maplist[0])) + iobuf->offset;
Because page_address() is "#define page_address(page) ((page)->virtual)" and
"virtual" is equal to 0, this approach will not work for me.

Another suggested that I add this to my code:
#define page_to_bus(page) \
        (ULONG)(((page) - mem_map) << PAGE_SHIFT),
and get the physical address for the first page this way:
physAddr = page_to_bus(iobuf->maplist[0])+iobuf->offset;
Because it is not clear to me what exactly is "mem_map", I am not sure how
"maplist" of type "struct page*", is subtracted by "mem_map" of type
"mem_map_t*".
In my test, I have:
1) maplist[0] = 0xC114ECEC;
2) mem_map = 0xC1000010.
Ignore the offset, what the physical address should be?

My development environment:
1) OS: RedHat 7.2 (2.4.7-10)
2) GCC: 3.2.1
3) PC:  P-III single processor w/ 128Mbytes of memory,
4) BUS: PCI,
5) My DMA controller has unlimited scatter-gather capability.

By the way, I have tested the rest of my code by DMA the image data to a
kernel buffer allocated using kmalloc() first, then do a memcpy() to copy
the image data to a user buffer. This alternative seems to work fine.

All suggestions and comments are greatly appreciated.
Shuyu

