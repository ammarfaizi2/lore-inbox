Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281018AbRKGWJr>; Wed, 7 Nov 2001 17:09:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280997AbRKGWJe>; Wed, 7 Nov 2001 17:09:34 -0500
Received: from tourian.nerim.net ([62.4.16.79]:6416 "HELO tourian.nerim.net")
	by vger.kernel.org with SMTP id <S281017AbRKGWJS>;
	Wed, 7 Nov 2001 17:09:18 -0500
Message-ID: <3BE9B10C.9060903@free.fr>
Date: Wed, 07 Nov 2001 23:09:16 +0100
From: Lionel Bouton <Lionel.Bouton@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5+) Gecko/20011106
X-Accept-Language: en-us
MIME-Version: 1.0
To: "'Roy Sigurd Karlsbakk'" <roy@karlsbakk.net>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: RAID question
In-Reply-To: <06601B69B526914CB62E1C7B1663B5CA436014@w2kexgvie02>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bene, Martin wrote:

>Hi Roy,
>
>>raid5: measuring checksumming speed
>>   8regs     :  1480.800 MB/sec
>>   32regs    :   711.200 MB/sec
>>   pIII_sse  :  1570.400 MB/sec
>>   pII_mmx   :  1787.200 MB/sec
>>   p5_mmx    :  1904.000 MB/sec
>>raid5: using function: pIII_sse (1570.400 MB/sec)
>>
>>Why is raid5 using function pIII_sse when p5_MMX is way faster?
>>
>
>The sse version is prefered over the others and gets used regardless of
>speed if it's available:
>
>/* We force the use of the SSE xor block because it can write around L2.
>   We may also be able to load into the L1 only depending on how the cpu
>   deals with a load to a line that is being prefetched.  */
>
As your cpu(s) work on the data before sending it back to the devices in 
the case of RAID5 and as in the general case memory writes invalidate an 
amount of L2 cache corresponding to the amount of data to write, you'll 
push out of L2 data of your running applications, hence slowing them down.

Imagine you have a block you want to write to/read from your 4k chunk 
size, 3 drive RAID 5 array.
For an atomic write, you'll read 8k from memory and write 12k back. It's 
20k of L2 cache involved. The 8k read may already be in cache (you write 
to disk what you worked on earlier) but the 12k are generated so they 
surely won't.
On x86 12-20k of L2 cache is a substansial amount of cache. And it's the 
lowest atomic read/write operation you can imagine, with 64kb chunck 
size and 5 drives it would be 64 x 5 = 320 to 64 x 9 = 576k -> whole L2 
invalidated on most modern x86 cpu.

What does cache give you ? Fast access to recently used memory and 
write-back capability.
Cache use in this case is *bad* because you won't reuse the cached data. 
Write-back won't give much (you stream whole chunks down the memory bus 
anyway).
You *may* slow down disk writes (if you have something near 2GB/s of 
disk bandwidth on your RAID...) but you'll *surely* slow down your 
applications a lot by taking away their data from your L2 cache(s).

So the raid code doesn't use the optimal disk throughput method, it uses 
the optimal system performance method...

