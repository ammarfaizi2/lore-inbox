Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262427AbTEXMVF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 May 2003 08:21:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262429AbTEXMVF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 May 2003 08:21:05 -0400
Received: from mail024.syd.optusnet.com.au ([210.49.20.148]:20401 "EHLO
	mail024.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S262427AbTEXMVD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 May 2003 08:21:03 -0400
Message-ID: <3ECF66A8.8070002@optusnet.com.au>
Date: Sat, 24 May 2003 22:33:44 +1000
From: "steve.glass@optusnet.com.au" <steve.glass@optusnet.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Boot time OOPS when using large (128MB) frame buffer with VESA fb
 driver
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

/[1.] One line summary of the problem:/

Immediately after getting the "booting linux" message the screen clears 
and the machine freezes.
/
[2.] Full description of the problem/report:/

After upgrading my PC from 512MB to 1GB of RAM and repeatably got the 
above behaviour. Using a serial console it is clear that the kernel is 
issuing an OOPS but the video card hasn't finished initialization.

/[2.1.] Problem cause:
/
Very early in the boot sequence, vesafb_init(at line 540) calls 
ioremap() to map the frame buffer. Eventually, __ioremap() calls 
get_vm_area() to request is to find a 128MB block (the size of my Ti4200 
frame buffer). This should be a problem because the whole non-contiguous 
memory is only 128MB and get_vm_area() adds PAGE_SIZE (another 8MB 
sanity space) for good measure. Unfortunately, a bug in get_vm_area() 
means that the memory wrap-around check is not performed during first 
call - and this is the first time it is called!

As a result, the block is erroneously allocated and returned. 
Fortunately, __ioremap() does a redundant check that the start address 
plus size does not wrap around and this test fails so it BUGs out at 
line 73. The video card hasn't been initialized yet so the user never 
gets to see the OOPS message (I used a serial console).

/[2.2.] Solution:
/
The problem is fixed by changing the definition of __VMALLOC_RESERVE so 
it reserves more memory for the non-contiguous address pool. E.g. 
changing line 143 of include/asm-i386/page.h to allocate 192MB of addresses.

#define __VMALLOC_RESERVE       (192 << 20)

With this done there is no need to fix the bug in get_vm_area(); 
although I can provide the code for that.

/[3.] Keywords (i.e., modules, networking, kernel):
/
kernel, vesafb, i386, non-contiguous memory manager, get_vm_area()

[4.] Kernel version (from /proc/version):

2.4.19, 2.4.20, 2.4.21rc1

...

[7.] Environment

PC, Athlon, ASUS A7V333 mobo, 1GB RAM, Ti4200 128MB video card.

Hope that is good, its working perfectly with just that 1-line change.

Steve


