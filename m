Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161228AbVIPSdi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161228AbVIPSdi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 14:33:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161255AbVIPSdi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 14:33:38 -0400
Received: from kepler.fjfi.cvut.cz ([147.32.6.11]:56994 "EHLO
	kepler.fjfi.cvut.cz") by vger.kernel.org with ESMTP
	id S1161228AbVIPSdh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 14:33:37 -0400
Date: Fri, 16 Sep 2005 20:33:36 +0200 (CEST)
From: Martin Drab <drab@kepler.fjfi.cvut.cz>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: mmap(2)ping of pci_alloc_consistent() allocated buffers on 2.4
 kernels question/help
Message-ID: <Pine.LNX.4.60.0509162009510.14084@kepler.fjfi.cvut.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

can anyone explain me why it is not possible to mmap(2) a buffer 
allocated in kernel by pci_alloc_consistent() to userspace on a 2.4 
kernel?

In kernel PCI device initialization function I do something like:

...
kladdr = pci_alloc_consistent (dev, BUFSIZE, &baddr);
...

Then I send the physical address (i.e. the value of phaddr = __pa(kladdr)) 
to the userspace application, and then when in the userspace I do 
something like

...
fd = fopen ("/dev/mem", O_RDWR);
buf = mmap (NULL, BUFSIZE, PROT_READ|PROT_WRITE, MAP_SHARED, fd, phaddr);
...

I get a mapping stated correctly in /proc/<pid>/maps as

40016000-4001e000 rw-s 11ac0000 00:06 4       /dev/mem

which is all correct. But when I read the contents of the mmap(2)ped 
memory within the application I get all zeroes, while the value of the 
buffer when read from kernel space or by simply doing

dd if=/dev/mem of=temp.dat bs=65536 skip=4524 count=1

I get the correct values (which are not all zeros). Something in the 
process of mmap(2) system call seems to redirect the pages to /dev/zero it 
seems. Is it intentional? Why?

Can I get around it somehow? The desired goal would be to mmap the buffer 
directly from kernel upon an ioctl call to the driver of the PCI device. 
(I do it by emmulating the mmap(2) call but initiated from the kernel by 
calling the do_mmap_pgoff() with appropriate arguments, but (no surprise) 
it does the same thing as the mmap(2) called from the userspace.

Can the mmapping be done correctly at least from the kernel somehow? Or is 
it not possible at all.

Any hint would be much appreciated.

Thanks,
Martin.
