Return-Path: <linux-kernel-owner+w=401wt.eu-S1422709AbXAHTmR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422709AbXAHTmR (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 14:42:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422708AbXAHTmR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 14:42:17 -0500
Received: from mail.tmr.com ([64.65.253.246]:38835 "EHLO gaimboi.tmr.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422709AbXAHTmQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 14:42:16 -0500
Message-ID: <45A29EC2.8020502@tmr.com>
Date: Mon, 08 Jan 2007 14:42:58 -0500
From: Bill Davidsen <davidsen@tmr.com>
Organization: TMR Associates Inc, Schenectady NY
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.8) Gecko/20061105 SeaMonkey/1.0.6
MIME-Version: 1.0
To: Denis Vlasenko <vda.linux@googlemail.com>
CC: Hugh Dickins <hugh@veritas.com>,
       Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: open(O_DIRECT) on a tmpfs?
References: <459CEA93.4000704@tls.msk.ru> <200701042317.02908.vda.linux@googlemail.com> <459E7AB3.8080802@tmr.com> <200701060130.13903.vda.linux@googlemail.com>
In-Reply-To: <200701060130.13903.vda.linux@googlemail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Denis Vlasenko wrote:
> On Friday 05 January 2007 17:20, Bill Davidsen wrote:
>   
>> Denis Vlasenko wrote:
>>     
>>> But O_DIRECT is _not_ about cache. At least I think it was not about
>>> cache initially, it was more about DMAing data directly from/to
>>> application address space to/from disks, saving memcpy's and double
>>> allocations. Why do you think it has that special alignment requirements?
>>> Are they cache related? Not at all!
>>>       
>
>   
>> I'm not sure I can see how you find "don't use cache" not cache related. 
>> Saving the resources needed for cache would seem to obviously leave them 
>> for other processes.
>>     
>
> I feel that word "direct" has nothing to do with caching (or lack thereof).
> "Direct" means that I want to avoid extra allocations and memcpy:
>
> 	write(fd, hugebuf, 100*1024*1024);
>
> Here application uses 100 megs for hugebuf, and if it is not sufficiently
> aligned, even smartest kernel in this universe cannot DMA this data
> to disk. No way. So it needs to allocate ANOTHER, aligned buffer,
> memcpy the data (completely flushing L1 and L2 dcaches), and DMA it
> from there. Thus we use twice as much RAM as we really need, and do
> a lot of mostly pointless memory moves! And worse, application cannot
> even detect it - it works, it's just slow and eats a lot of RAM and CPU.
>
> That's where O_DIRECT helps. When app wants to avoid that, it opens fd
> with O_DIRECT. App in effect says: "I *do* want to avoid extra shuffling,
> because I will write huge amounts of data in big blocks."
>
>   
>>> But _conceptually_ "direct DMAing" and "do-not-cache-me"
>>> are orthogonal, right?
>>>       
>> In the sense that you must do DMA or use cache, yes.
>>     
>
> Let's say I implemented a heuristic in my cp command:
> if source file is indeed a regular file and it is
> larger than 128K, allocate aligned 128K buffer
> and try to copy it using O_DIRECT i/o.
>
> Then I use this "enhanced" cp command to copy a large directory
> recursively, and then I run grep on that directory.
>
> Can you explain why cp shouldn't cache the data it just wrote?
> I *am* going to use it shortly thereafter!
>
>   
>>> That's why we also have bona fide fadvise and madvise
>>> with FADV_DONTNEED/MADV_DONTNEED:
>>>
>>> http://www.die.net/doc/linux/man/man2/fadvise.2.html
>>> http://www.die.net/doc/linux/man/man2/madvise.2.html
>>>
>>> _This_ is the proper way to say "do not cache me".
>>>       
>> But none of those advisories says how to cache or not, only what the 
>> expected behavior will be. So FADV_NOREUSE does not control cache use, 
>> it simply allows the system to make assumptions.
>>     
>
> Exactly. If you don't need the data, Just let kernel know that.
> When you use O_DIRECT, you are saying "I want direct DMA to disk without
> extra copying". With fadvise(FADV_DONTNEED) you are saying
> "do not expect access in the near future" == "do not try to optimize
> for possible accesses in near future" == "do not cache"!.
>   
As long as "don't cache" doesn't imply "don't buffer." In the case of a 
large copy or other large single-file write (8.5GB backup DVDs come to 
mind), the desired behavior is to buffer if possible, start writing 
immediately (data will not change in buffer), and release the buffer as 
soon as write is complete. That doesn't seem to be the current 
interpretation of DONTNEED. Or O_DIRECT either, I agree.
> Again: with O_DIRECT:
>
> write(fd, hugebuf, 100*1024*1024);
>
> kernel _has _difficulty_ caching these data, simply because
> data isn't copied into kernel pages anyway, and if user will
> continue to use hugebuf after write(), kernel simply cannot
> cache that data - it _hasn't_ the data.
>   
In linux if you point the gun at your foot and pull the trigger it goes 
bang. I have no problem with that.
> But if user will unmap the hugebuf? What then? Should kernel
> forget that data in these pages is in effect a cached data from
> the file being written to? Not necessarily.
>   
Why should the kernel make an effort to remember? Incompetence, like 
virtue, is its own reward.
> Four years ago Linus wrote an email about it:
>
> http://lkml.org/lkml/2002/5/11/58
>
> btw, as an Oracle DBA on my day job, I completely agree
> with Linus on the "deranged monkey" comparison in that mail...
The problem with the suggested Linux implementation is that it's 
complex, and currently would move a lot of the logic into user space, in 
code which is probably not portable, or might tickle bad behavior on 
other systems.

Around 2.4.16 (or an -aa variant) I tried code to track writes per file, 
and if some number of bytes had been written to a file without a read or 
seek, any buffered blocks were queued to be written. This got around the 
behavior of generating data until memory was full, then writing it all 
out and having the disk very busy. It was just a proof of concept, but 
it did spread the disk writes to a more constant load and more 
consistent response to other i/o. There doesn't seem to be an easy 
tunable to do this, probably because the need isn't all that common.

-- 
bill davidsen <davidsen@tmr.com>
  CTO TMR Associates, Inc
  Doing interesting things with small computers since 1979

