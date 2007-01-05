Return-Path: <linux-kernel-owner+w=401wt.eu-S1161141AbXAEQTk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161141AbXAEQTk (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 11:19:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161142AbXAEQTk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 11:19:40 -0500
Received: from mail.tmr.com ([64.65.253.246]:36384 "EHLO gaimboi.tmr.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161141AbXAEQTj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 11:19:39 -0500
Message-ID: <459E7AB3.8080802@tmr.com>
Date: Fri, 05 Jan 2007 11:20:03 -0500
From: Bill Davidsen <davidsen@tmr.com>
Organization: TMR Associates Inc, Schenectady NY
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.8) Gecko/20061105 SeaMonkey/1.0.6
MIME-Version: 1.0
To: Denis Vlasenko <vda.linux@googlemail.com>
CC: Hugh Dickins <hugh@veritas.com>,
       Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: open(O_DIRECT) on a tmpfs?
References: <459CEA93.4000704@tls.msk.ru> <Pine.LNX.4.64.0701041242530.27899@blonde.wat.veritas.com> <459D290B.1040703@tmr.com> <200701042317.02908.vda.linux@googlemail.com>
In-Reply-To: <200701042317.02908.vda.linux@googlemail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Denis Vlasenko wrote:
> On Thursday 04 January 2007 17:19, Bill Davidsen wrote:
>   
>> Hugh Dickins wrote:
>> In many cases the use of O_DIRECT is purely to avoid impact on cache 
>> used by other applications. An application which writes a large quantity 
>> of data will have less impact on other applications by using O_DIRECT, 
>> assuming that the data will not be read from cache due to application 
>> pattern or the data being much larger than physical memory.
>>     
>
> But O_DIRECT is _not_ about cache. At least I think it was not about
> cache initially, it was more about DMAing data directly from/to
> application address space to/from disks, saving memcpy's and double
> allocations. Why do you think it has that special alignment requirements?
> Are they cache related? Not at all!
>   
I'm not sure I can see how you find "don't use cache" not cache related. 
Saving the resources needed for cache would seem to obviously leave them 
for other processes.
> After that people started adding unrelated semantics on it -
> "oh, we use O_DIRECT in our database code and it pushes EVERYTHING
> else out of cache. This is bad. Let's overload O_DIRECT to also mean
> 'do not pollute the cache'. Here's the patch".
>   
Did O_DIRECT ever use cache in some way? Doing DMA directly out of user 
space would seem to avoid using cache unless code was actually added to 
write to cache as well as disk, since the data isn't needed in any buffer.
> DB people from certain well-known commercial DB have zero coding
> taste. No wonder their binaries are nearly 100 MB (!!!) in size...
>
> In all fairness, O_DIRECT's direct-DMA makes is easier to implement
> "do-not-cache-me" than to do it for generic read()/write()
> (just because O_DIRECT is (was?) using different code path,
> not integrated into VM cache machinery that much).
>
> But _conceptually_ "direct DMAing" and "do-not-cache-me"
> are orthogonal, right?
>   
In the sense that you must do DMA or use cache, yes.
> That's why we also have bona fide fadvise and madvise
> with FADV_DONTNEED/MADV_DONTNEED:
>
> http://www.die.net/doc/linux/man/man2/fadvise.2.html
> http://www.die.net/doc/linux/man/man2/madvise.2.html
>
> _This_ is the proper way to say "do not cache me".
>   
But none of those advisories says how to cache or not, only what the 
expected behavior will be. So FADV_NOREUSE does not control cache use, 
it simply allows the system to make assumptions. If I still had the load 
which generated my cache problems I would try both methods while doing a 
large data copy, and see if the end result was similar. In theory 
NOREUSE "could be" more efficient of disk, but also use a lot of cache 
depending  on the implementation.

One of the problems with RAID-5 and large data is that you can read it a 
lot faster than you can write it (in most cases), resulting in filling 
the cache with data from one process. Perhaps a scheduler tunable for 
allowed queued disk data would help with this, but copying a TB data set 
has a very bad effect on other i/o.
> I think tmpfs should just ignore O_DIRECT bit.
> That won't require much coding.

Since tmpfs is useful for testing programs, this would have an actual 
user benefit.

-- 
bill davidsen <davidsen@tmr.com>
  CTO TMR Associates, Inc
  Doing interesting things with small computers since 1979

