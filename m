Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265625AbSJXTcS>; Thu, 24 Oct 2002 15:32:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265614AbSJXTcS>; Thu, 24 Oct 2002 15:32:18 -0400
Received: from dbl.q-ag.de ([80.146.160.66]:52904 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id <S265624AbSJXTcQ>;
	Thu, 24 Oct 2002 15:32:16 -0400
Message-ID: <3DB84C3E.1070709@colorfullife.com>
Date: Thu, 24 Oct 2002 21:38:38 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020827
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: erich@uruk.org
CC: Matthias Welk <matthias.welk@fokus.gmd.de>, arjanv@redhat.com,
       linux-kernel@vger.kernel.org
Subject: Re: [CFT] faster athlon/duron memory copy implementation
References: <E184nEw-00071m-00@trillium-hollow.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

erich@uruk.org wrote:

>>copy_page() tests
>>copy_page function 'warm up run'         took 18081 cycles per page
>>copy_page function '2.4 non MMX'         took 19487 cycles per page
>>copy_page function '2.4 MMX fallback'    took 19403 cycles per page
>>copy_page function '2.4 MMX version'     took 18086 cycles per page
>>copy_page function 'faster_copy'         took 11372 cycles per page
>>copy_page function 'even_faster'         took 11183 cycles per page
>>copy_page function 'no_prefetch'         took 7815 cycles per page
>>1020 [maw] (buruk) /tmp/athlon # athlon_test
>>    
>>
>
>
>Whoa!  Hmm.
>
>If I'm reading this right, with a processor speed of 1.666 GHz,
>you're getting:
>
>    (4096 bytes / 7815 clocks) * 1.666 GHz  =  873 MB/sec
>
>The perfect peak performance of your setup, if the cache implements
>standard write-allocate behavior (the target cache line is read before it
>is written because the write logic doesn't know you're going to overwrite
>the whole line in cases like this), should be:
>  
>
There is no write allocate.

There are 2 optimizations for bulk memory copy:
- avoid the write allocate. Possible with the mmx or sse non-temporal 
cache hints
    * already in the kernel. Difference between MMX and faster_copy
- avoid dram page misses, and stream from the memory chips with maximum 
efficiency.
    * new optimization. "prefetch" is a hint for the cpu that the 
program might need the memory
        If I understand the AMD document correctly, then this is not 
what's needed for bulk
        memory copy: we know that we'll need that cacheline. Thus a real 
read, to force the cpu to
        fetch the cacheline, even if all read buffers are occupied.

--
    Manfred


