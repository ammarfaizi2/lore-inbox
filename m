Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318234AbSIBIWg>; Mon, 2 Sep 2002 04:22:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318237AbSIBIWg>; Mon, 2 Sep 2002 04:22:36 -0400
Received: from d12lmsgate-3.de.ibm.com ([195.212.91.201]:63921 "EHLO
	d12lmsgate-3.de.ibm.com") by vger.kernel.org with ESMTP
	id <S318234AbSIBIWe>; Mon, 2 Sep 2002 04:22:34 -0400
Importance: Normal
MIME-Version: 1.0
Sensitivity: 
To: linux-kernel@vger.kernel.org
Subject: Kernel BUG at page_alloc.c:91! (2.4.19)
X-Mailer: Lotus Notes Release 5.0.8  June 18, 2001
Message-ID: <OF990F4927.6697D5BE-ONC1256C28.002E59F8@de.ibm.com>
From: "Heiko Carstens" <Heiko.Carstens@de.ibm.com>
Date: Mon, 2 Sep 2002 10:26:56 +0200
X-MIMETrack: Serialize by Router on D12ML032/12/M/IBM(Release 5.0.9a |January 7, 2002) at
 02/09/2002 10:26:57,
	Serialize complete at 02/09/2002 10:26:57
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I experienced several kernel BUGs while running the linux kernel version 
2.4.19
on a single cpu s390 machine with 2GB RAM and 256MB of swap space. All of 
these
BUGs happened at page_alloc.c in the function __free_pages_ok. In that 
function
there is the check
if (page->mapping) BUG();
which is exactly what happened. A page had a mapping but __free_pages_ok() 
got
called anyway. Looking at the backtrace I was able to see that this 
specific
BUG() occurred when page_cache_release() was called from the function
try_to_swap_out().

Looks to me that this function itself has a bug: after the drop_pte label 
it is
checked if the current page has a mapping. If this is true there is a jump 
to
the drop_pte label, where without any further checking 
page_cache_release() gets
called which will result in the above described BUG() if page_count(page) 
== 1.

Here is the output of the kernel (I removed all inline statements in 
vmscan.c):

kernel BUG at page_alloc.c:91! 
illegal operation: 0001 
CPU:    0    Not tainted 
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

