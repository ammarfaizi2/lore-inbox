Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266931AbSKLUqt>; Tue, 12 Nov 2002 15:46:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266940AbSKLUqs>; Tue, 12 Nov 2002 15:46:48 -0500
Received: from dbl.q-ag.de ([80.146.160.66]:58026 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id <S266931AbSKLUqs>;
	Tue, 12 Nov 2002 15:46:48 -0500
Message-ID: <3DD16A3A.8040108@colorfullife.com>
Date: Tue, 12 Nov 2002 21:53:14 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020830
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Rik van Riel <riel@conectiva.com.br>
CC: linux-kernel@vger.kernel.org, davem@redhat.com
Subject: Re: [PATCH] flush_cache_page while pte valid
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>
>>
>> The flush merely writes back the data, a copy-back operation, fully L2
>> cache coherent.  All cpus will see correct data if an intermittant
>> store occurs.
>
>The CPUs will, but the harddisk might not.
>  
>
The lost dirty bit can only happen on cpus where the hardware maintains 
a dirty bit. I doubt that the sparc cpus do that in hardware.

But like Hugh I don't understand how the cache writeback works on SMP.

cpu1:                cpu 2
                        access a mmaping, pte loaded into TLB
try_to_unmap_one()
flush_cache_page();
                        access the mmaping again. pte either still from
                        tlb, or reloaded from pte.
ptep_get_and_clear();
                        access the mmaping again, using the tlb
flush_tlb()
                        ??? How will the cpu write back now?

If the write back happens based on the tlb, then I don't understand why 
it's needed at all.

Regarding the dirty bit:
The assumption for the dirty bit is that the i386 cpu are the only cpus 
in the world (TM) that maintain the dirty bit in hardware, and tests on 
several i386 cpus have shown that the tlb walker retests the present bit 
before setting the dirty bit. Software tlb implementations must emulate 
that.

Thus it's guaranteed that
- if the dirty bit is not set in the result of ptep_get_and_clear, then 
no write operation has happened or will happen.
- if the dirty bit is set, then write operations could happen until the 
tlb flush.
- there will be no spuriously set dirty bits in the page tables.

--
    Manfred

