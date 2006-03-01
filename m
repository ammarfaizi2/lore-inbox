Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750936AbWCATlX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750936AbWCATlX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 14:41:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751844AbWCATlX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 14:41:23 -0500
Received: from smtpq1.groni1.gr.home.nl ([213.51.130.200]:7647 "EHLO
	smtpq1.groni1.gr.home.nl") by vger.kernel.org with ESMTP
	id S1750936AbWCATlX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 14:41:23 -0500
Message-ID: <4405F929.2030609@keyaccess.nl>
Date: Wed, 01 Mar 2006 20:42:33 +0100
From: Rene Herman <rene.herman@keyaccess.nl>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: 2.6.16-rc5 OOM regression
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
X-AtHome-MailScanner-Information: Neem contact op met support@home.nl voor meer informatie
X-AtHome-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus.

I was playing with "slabtop" (a /proc/slabinfo display tool) while 
running a little memory-eater app in a different xterm:

=== pig.c

#include <stdlib.h>

int main(void)
{
	unsigned char *p;

	while ((p = malloc(4096)))
		*p = 0;
	return 0;
}

===

I was expecting the oom-killer but instead had X freeze on me entirely. 
  No keyboard or mouse, and while the machine does still ping in this 
state, also no rlogins. This does not happen in 2.6.15.4 -- there the 
oom-killer will kill the eater app (sometimes including the xterm it's 
in, sometimes not, but not a problem).

The 2.6.16-rc5 freeze is "highly repeatable", meaning not always, but 
very often. It seems that having for example Firefox loaded increases 
the chances of a full freeze, but that might just be chance as well.

Even when it does not freeze, the machine's highly unstable. After 
these, I had attempted reboots hang forever, and things such as:

   scheduling while atomic init/0x00000001/1
   [	] schedule
   [	] do_page_fault
   [	] work_resched

all over dmesg.

The machine is UP, Duron 1300, 768MB RAM and 1.5G swap (shared with a 
tmpfs on /tmp). Running the memory eater without X (and without slabtop) 
loaded I get the following in dmesg under 2.6.16-rc5:

===
oom-killer: gfp_mask=0x280d2, order=0
  [<c042d928>] out_of_memory+0x24/0xac
  [<c042e827>] __alloc_pages+0x1dc/0x260
  [<c04359eb>] do_anonymous_page+0x3e/0x13e
  [<c0435e03>] __handle_mm_fault+0xb7/0x1c4
  [<c040d15b>] do_page_fault+0x176/0x4c1
  [<c0436a64>] sys_brk+0xac/0xda
  [<c040cfe5>] do_page_fault+0x0/0x4c1
  [<c0402767>] error_code+0x4f/0x54
Mem-info:
DMA per-cpu:
cpu 0 hot: high 0, batch 1 used:0
cpu 0 cold: high 0, batch 1 used:0
DMA32 per-cpu: empty
Normal per-cpu:
cpu 0 hot: high 186, batch 31 used:31
cpu 0 cold: high 62, batch 15 used:58
HighMem per-cpu: empty
Free pages:        6580kB (0kB HighMem)
Active:96166 inactive:93920 dirty:0 writeback:0 unstable:0 free:1645 
slab:1138 mapped:190049 pagetables:616
DMA free:3076kB min:72kB low:88kB high:108kB active:5216kB 
inactive:5432kB present:16384kB pages_scanned:11823 all_unreclaimable? yes
lowmem_reserve[]: 0 0 751 751
DMA32 free:0kB min:0kB low:0kB high:0kB active:0kB inactive:0kB 
present:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 751 751
Normal free:3504kB min:3468kB low:4332kB high:5200kB active:379448kB 
inactive:370248kB present:769984kB pages_scanned:490725 
all_unreclaimable? no
lowmem_reserve[]: 0 0 0 0
HighMem free:0kB min:128kB low:128kB high:128kB active:0kB inactive:0kB 
present:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0 0
DMA: 1*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 1*1024kB 
1*2048kB 0*4096kB = 3076kB
DMA32: empty
Normal: 4*4kB 4*8kB 2*16kB 1*32kB 1*64kB 0*128kB 1*256kB 0*512kB 
1*1024kB 1*2048kB 0*4096kB = 3504kB
HighMem: empty
Swap cache: add 393262, delete 393254, find 8/14, race 0+0
Free swap  = 0kB
Total swap = 1572856kB
Free swap:            0kB
196592 pages of RAM
0 pages of HIGHMEM
2399 reserved pages
31 pages shared
13 pages swap cached
0 pages dirty
0 pages writeback
190052 pages mapped
1138 pages slab
616 pages pagetables
Out of Memory: Kill process 1194 (pig) score 583113 and children.
Out of memory: Killed process 1194 (pig).
note: pig[1194] exited with preempt_count 1
===

Full dmesg from boot + one "pig" run also available at:

http://members.home.nl/rene.herman/dmesg-2.6.16-rc5-pig

Under 2.6.15.4, I get more of this, but _without_ the traceback at the 
top, and without the "exited with preempt_count 1" at the end. Assuming 
it's not highly interesting, I have not included it but available at:

http://members.home.nl/rene.herman/dmesg-2.6.15.4-pig

(also boot + one "pig" run).

As said, the X freeze is not really completely-fully repeatable -- the 
"exited with preempt_count 1" is though.

Rene.

