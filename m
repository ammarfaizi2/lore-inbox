Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263340AbTEIRFM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 May 2003 13:05:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263348AbTEIRFL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 May 2003 13:05:11 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:51854 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263340AbTEIRFI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 May 2003 13:05:08 -0400
Message-ID: <3EBBE26E.9090606@us.ibm.com>
Date: Fri, 09 May 2003 10:16:30 -0700
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020623 Debian/1.0.0-0.woody.1
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Jamie Lokier <jamie@shareable.org>, Roland McGrath <roland@redhat.com>,
       Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i386 uaccess to fixmap pages
References: <Pine.LNX.4.44.0305090944420.9705-100000@home.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> On Fri, 9 May 2003, Dave Hansen wrote:
> 
>>We've been playing with patches in the -mjb tree which make PAGE_OFFSET
>>and TASK_SIZE move to some weird values.  I have it to the point where I
>>could do a 3.875:0.125 user:kernel split.
> 
> That's still not "weird" in the current sense.
> 
> We've always (well, for a long time) been able to handle a TASK_SIZE that 
> has a 111..00000 pattern - and in fact we used to _depend_ on that kind of 
> pattern, because macros like "virt_to_phys()" were simple bitwise-and 
> operations. There may be some code in the kernel that still depends on 
> that kind of bitwise operation with TASK_SIZE.
> 
> Your 3.875:0.125 split still fits that pattern, and thus doesn't create 
> any new cases.
> 
> In contrast, a TASK_SIZE of 0xc1000000 can no longer just "mask off" the 
> kernel address bits. And _that_ is what I meant with "strange value".

Ahhh, weird*er* :)

These patches at least address a small class of problems where it is
assumed that the kernel pagetable entries start at the beginning of a
pmd.  Anyway, 2.5.68-mjb3 boots with a 0xE1000000 PAGE_OFFSET with PAE
on a 4GB machine.  It does "just work", at least in Martin's tree.

3343MB HIGHMEM available.
368MB LOWMEM available.

elm3b82:~# cat /proc/meminfo
MemTotal:      3758468 kB
MemFree:       3728368 kB
Buffers:          1696 kB
Cached:           8184 kB
SwapCached:          0 kB
Active:           7640 kB
Inactive:         4936 kB
HighTotal:     3424228 kB
HighFree:      3412224 kB
LowTotal:       334240 kB
LowFree:        316144 kB
SwapTotal:           0 kB
SwapFree:            0 kB
Dirty:             304 kB
Writeback:           0 kB
Mapped:           5900 kB
Slab:             6292 kB
Committed_AS:     7024 kB
PageTables:        472 kB
VmallocTotal:   114680 kB
VmallocUsed:      2400 kB
VmallocChunk:   112280 kB

-- 
Dave Hansen
haveblue@us.ibm.com

