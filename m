Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267438AbTAQJE6>; Fri, 17 Jan 2003 04:04:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267439AbTAQJE6>; Fri, 17 Jan 2003 04:04:58 -0500
Received: from ausmtp02.au.ibm.COM ([202.135.136.105]:2469 "EHLO
	ausmtp02.au.ibm.com") by vger.kernel.org with ESMTP
	id <S267438AbTAQJE4>; Fri, 17 Jan 2003 04:04:56 -0500
Subject: Kernel BUG(oops) does not occur after upgrading glibc
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org
X-Mailer: Lotus Notes Release 5.0.3 (Intl) 21 March 2000
Message-ID: <OF5B129FA7.EE286E9B-ON65256CB1.003172CC@in.ibm.com>
From: "Srikrishnan Sundararajan" <srikrishnan@in.ibm.com>
Date: Fri, 17 Jan 2003 14:33:46 +0530
X-MIMETrack: Serialize by Router on d23m0067/23/M/IBM(Release 5.0.9a |January 7, 2002) at
 17/01/2003 02:33:48 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I got the following oops message using my S/390 VM-type linux image with
2GB of memory. (Kernel BUG at page_alloc.c:91!)
Using 2.4.19. I was running a test program which keeps on allocating memory
using malloc and assigns values  (with proper checking of return value of
malloc. ) While using brk( ) system call, I did not get any problems.
When I upgraded my glibc from version 2.2.5 to 2.3.1, the oops or Kernel
BUG no longer occurred. As it was a "Kernel BUG" in the first place, do we
still consider this as a BUG in the kernel or purely an error in glibc
which was fixed in the 2.3.1 version?

My inference is that using malloc which is part of the older glibc (2.2.5)
was corrupting a kernel data structure, which resulted in the oops during
swap_out.
Note: I was not able to reproduce this problem on intel. I do not have any
nVidia driver.

The oops message:

Kernel BUG at page_alloc.c:91! (2.4.19)
From: Heiko Carstens (Heiko.Carstens@de.ibm.com)
Date: Mon Sep 02 2002 - 03:26:56 EST


Hi,
I experienced several kernel BUGs while running the linux kernel version
2.4.19 on a single cpu s390 machine with 2GB RAM and 256MB of swap space.
All of these  BUGs happened at page_alloc.c in the function
__free_pages_ok. In that function there is the check if (page->mapping) BUG
();  which is exactly what happened. A page had a mapping but
__free_pages_ok()  got called anyway. Looking at the backtrace I was able
to see that this  specific BUG() occurred when page_cache_release() was
called from the function  try_to_swap_out().


Looks to me that this function itself has a bug: after the drop_pte label
it is  checked if the current page has a mapping. If this is true there is
a jump  to  the drop_pte label, where without any further checking
page_cache_release() gets
called which will result in the above described BUG() if page_count(page)
== 1.

Here is the output of the kernel (I removed all inline statements in
vmscan.c):


kernel BUG at page_alloc.c:91!
illegal operation: 0001
CPU: 0 Not tainted
           80042730 00000001 013c578c 6ce26e00
           00000020 575a0001 6ce26e00 00000000
           013c578c 80042388 80042730 6c7e13c8
           00000000 00000000 00000000 00000000
           00000000 00000000 00000000 00000000
           00000000 00000000 00000000 00000000
Call Trace: [<000430d2>] [<00040eec>] [<00041088>] [<00041132>]
            [<000411da>] [<000412cc>] [<000413b0>] [<00041646>]
Warning (Oops_read): Code line not seen, dumping what data is available


Trace; 000430d2 <__free_pages+52/58>
Trace; 00040eec <try_to_swap_out+224/284>
Trace; 00041088 <swap_out_pmd+13c/178>
Trace; 00041132 <swap_out_pgd+6e/a0>
Trace; 000411da <swap_out_vma+76/bc>
Trace; 000412cc <swap_out_mm+ac/d0>
Trace; 000413b0 <swap_out+c0/150>
Trace; 00041646 <shrink_cache+206/5c8>


regards,
Heiko

