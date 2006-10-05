Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751296AbWJEUjT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751296AbWJEUjT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 16:39:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751291AbWJEUjS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 16:39:18 -0400
Received: from calculon.skynet.ie ([193.1.99.88]:50903 "EHLO
	calculon.skynet.ie") by vger.kernel.org with ESMTP id S1751289AbWJEUjR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 16:39:17 -0400
Date: Thu, 5 Oct 2006 21:39:15 +0100 (IST)
From: Mel Gorman <mel@csn.ul.ie>
X-X-Sender: mel@skynet.skynet.ie
To: Andi Kleen <ak@suse.de>
Cc: vgoyal@in.ibm.com, Steve Fox <drfickle@us.ibm.com>,
       Badari Pulavarty <pbadari@us.ibm.com>, Martin Bligh <mbligh@mbligh.org>,
       Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       netdev@vger.kernel.org, kmannth@us.ibm.com,
       Andy Whitcroft <apw@shadowen.org>
Subject: Re: 2.6.18-mm2 boot failure on x86-64
In-Reply-To: <200610052108.55208.ak@suse.de>
Message-ID: <Pine.LNX.4.64.0610052128570.29014@skynet.skynet.ie>
References: <20060928014623.ccc9b885.akpm@osdl.org> <200610052027.02208.ak@suse.de>
 <20061005185217.GF20551@in.ibm.com> <200610052108.55208.ak@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Oct 2006, Andi Kleen wrote:

> On Thursday 05 October 2006 20:52, Vivek Goyal wrote:
>> On Thu, Oct 05, 2006 at 08:27:02PM +0200, Andi Kleen wrote:
>>> On Thursday 05 October 2006 19:57, Steve Fox wrote:
>>>> On Thu, 2006-10-05 at 17:40 +0200, Andi Kleen wrote:
>>>>
>>>>> Please don't snip the Code: line. It is fairly important.
>>>>
>>>> Sorry about that. The remote console I was using appears to overwrite
>>>> some text after I force the reboot. Here's a clean one.
>>>>
>>>> global ffffffffffffffff
>>>
>>> Ok that definitely shouldn't be in there.
>>>
>>> I guess we need to track when it gets corrupted. Can you send the full
>>> boot log with this patch applied?
>>>
>>
>> Just recalled one more observation about the problem when keith had
>> reported it last. If I just move .bss before .data_nosave instead
>> of it being at the end, keith's problem had disappeared.
>
> Yes, that could well be that it's something in the new bootmap
> management.  Steve's box failed at
>
> Using ACPI (MADT) for SMP configuration information
> Nosave address range: 000000000009a000 - 000000000009b000
> Nosave address range: 000000000009b000 - 00000000000a0000
> Nosave address range: 00000000000a0000 - 00000000000e0000
> Nosave address range: 00000000000e0000 - 0000000000100000
> Nosave address range: 00000000bff76000 - 00000000bff77000
> Nosave address range: 00000000bff77000 - 00000000bff98000
> Nosave address range: 00000000bff98000 - 00000000bff99000
> Nosave address range: 00000000bff99000 - 00000000c0000000
> Nosave address range: 00000000c0000000 - 00000000fec00000
> Nosave address range: 00000000fec00000 - 0000000100000000
> Allocating PCI resources starting at c4000000 (gap: c0000000:3ec00000)
> afinfo corrupted at init/main.c:512
>
> which is directly after that code does lots of stuff.
>
> Mel might want to take a look (and perhaps
> also cut down a little on the ugly printks ...)
>

Steve tested a patch with arch-independent zone-sizing backed out for 
x86_64 and things looked ok but that is no guarantee it is not a 
contributary factor. The "Nosave address range:" printks are related to a 
suspend problem that was reported .... end of June I believe.

I'll pick this up in the morning because I should have access to the same 
machine Steve does and see what I can come up with.

> BTW I found one of my test systems too now which does a lot of:
> I'm about to leave for vacation so i won't have time to track it down
> any time soon. But here is it for reference.
>

hmm, rather than bugging you with patches now, I'll see what I can find 
with the x86_64 machines I have access to and see can I reproduce it.

> -Andi
>
> Please enable the IOMMU option in the BIOS setup
> This costs you 64 MB of RAM
> Mapping aperture over 65536 KB of RAM @ 8000000
> Bad page state in process 'swapper'
> page:ffff810003ee5480 flags:0x0000000000000000 mapping:0000000000000000 mapcount:1 count:0
> Trying to fix it up, but a reboot is needed
> Backtrace:
>
> Call Trace:
> [<ffffffff8020ac84>] show_trace+0x34/0x47
> [<ffffffff8020aca9>] dump_stack+0x12/0x17
> [<ffffffff802586a7>] bad_page+0x57/0x81
> [<ffffffff80258791>] __free_pages_ok+0x64/0x247
> [<ffffffff807cca72>] free_all_bootmem_core+0xcc/0x1a9
> [<ffffffff807ca08b>] numa_free_all_bootmem+0x3b/0x77
> [<ffffffff807c915e>] mem_init+0x44/0x186
> [<ffffffff807bc5f0>] start_kernel+0x17b/0x207
> [<ffffffff807bc168>] _sinittext+0x168/0x16c
>
> Bad page state in process 'swapper'
> page:ffff810003ee54b8 flags:0x0000000000000000 mapping:0000000000000000 mapcount:1 count:0
> Trying to fix it up, but a reboot is needed
> Backtrace:
>
> Call Trace:
> [<ffffffff8020ac84>] show_trace+0x34/0x47
> [<ffffffff8020aca9>] dump_stack+0x12/0x17
> [<ffffffff802586a7>] bad_page+0x57/0x81
> [<ffffffff80258791>] __free_pages_ok+0x64/0x247
> [<ffffffff807cca72>] free_all_bootmem_core+0xcc/0x1a9
> [<ffffffff807ca08b>] numa_free_all_bootmem+0x3b/0x77
> [<ffffffff807c915e>] mem_init+0x44/0x186
> [<ffffffff807bc5f0>] start_kernel+0x17b/0x207
> [<ffffffff807bc168>] _sinittext+0x168/0x16c
>
>
> ... lots more of those ...
>

-- 
Mel Gorman
Part-time Phd Student                          Linux Technology Center
University of Limerick                         IBM Dublin Software Lab
