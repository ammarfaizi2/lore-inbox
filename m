Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261626AbSJAMht>; Tue, 1 Oct 2002 08:37:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261628AbSJAMht>; Tue, 1 Oct 2002 08:37:49 -0400
Received: from Sungate-2.ser.netvision.net.il ([212.143.108.74]:29598 "EHLO
	BEASLEY.il.sangate.com") by vger.kernel.org with ESMTP
	id <S261626AbSJAMhs> convert rfc822-to-8bit; Tue, 1 Oct 2002 08:37:48 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.5762.3
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: Adpter card read old memory value
Date: Tue, 1 Oct 2002 15:43:09 +0300
Message-ID: <B71796881E0DF7409F066FE6656BDF2906F78A@beasley>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Adpter card read old memory value
Thread-Index: AcJpSBiNJyI74QXNR0S3PPpSPkbHEw==
From: "Eitan Ben-Nun" <eitan@sangate.com>
To: <linux-kernel@vger.kernel.org>
Cc: "Eitan Ben-Nun" <eitan@sangate.com>, "Uri Lublin" <uri@sangate.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This seems like a cache coherency problem: 
An adapter card on the pci bus send a message to pc i386 Linux to update a memory address. 
Then it reads the address and sees an old value, even though the pc cpu have performed an update to this memory address. 

Environment:  
SKA4 - (koa board) with two Intel Pentium III Xeon processors, running Linux, kernel 2.4.18-5 SMP. 
The Server has 1Giga Byte physical memory, but Linux operating system is aware of 512M only. 
In lilo.conf it indicates to use only 512M (from lilo.conf: append="mem=512M, nousb").
The upper 512M is managed by specialized software, 
and accessed from kernel using __io_remap(phsy_addr, PAGE_SIZE, _PAGE_PWT | PAGE_PCD) function. 

I would have preferred not to have this memory as write through, and define this physical memory as snoop able, for PCI reads, at the memory bus controller.   But i havn't figured out how to do that. 

What done so for to debug this problem: 
0. How did we verified this is the problem. 
The adapter perform a read to this address, and save the value. It sends an update message to the pc. After an update reply message arrives it reads the value again and see the old value. The adapter developer have verified no caching is done at the adapter side.

1. Testing:
Run the machine with one cpu, and two cpu and we saw the problem. 
Run the machine without cache: Cache was disabled at machine bios and we didn't see the problem.

2. Code changes:
At the beginning we used only ioremap, then we moved to ioremap_nocache, then to __ioremap with the above flags. 
We have verified the adapter and pc has the same physical addresses, we have verified the pc actually performed to update to the virtual address which Linux allocated for the physical address the adapter is reading from. 

3. investigations:
Searched and read items at the web: I've want over lkml FAQ, I've search the net for item regarding cache coherency problem, I read all the items on the linux-smp mailing list, I've reviewed the kernel code of _ioremap, vmalloc, get_pte etc..., I've read the three chapters in understanding the Linux kernel 2, 6, 13, and other books some on the web such as Linux kernel hacking, I've also searched and read at /usr/src/Documentation to seek help there, as you can see I'm pretty much desperate about this issue.


Regards, 
Eitan.



