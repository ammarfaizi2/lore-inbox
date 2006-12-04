Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937043AbWLDQJY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937043AbWLDQJY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 11:09:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937057AbWLDQJY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 11:09:24 -0500
Received: from warden-p.diginsite.com ([208.29.163.248]:61297 "HELO
	warden.diginsite.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with SMTP id S937043AbWLDQJX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 11:09:23 -0500
Date: Mon, 4 Dec 2006 07:55:31 -0800 (PST)
From: David Lang <dlang@digitalinsight.com>
X-X-Sender: dlang@dlang.diginsite.com
To: Kyle Moffett <mrmacman_g4@mac.com>
cc: Aucoin@Houston.RR.com, "'Tim Schmielau'" <tim@physik3.uni-rostock.de>,
       "'Andrew Morton'" <akpm@osdl.org>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, clameter@sgi.com
Subject: Re: la la la la ... swappiness
In-Reply-To: <5E2B4840-C384-48E2-A5C2-ED3C84FA7A48@mac.com>
Message-ID: <Pine.LNX.4.63.0612040733390.6970@qynat.qvtvafvgr.pbz>
References: <200612040154.kB41sadx019068@ms-smtp-03.texas.rr.com>
 <5E2B4840-C384-48E2-A5C2-ED3C84FA7A48@mac.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think that I am seeing two seperate issues here that are getting mixed up.

1. while doing the tar + patch the system is choosing to use memory for 
caching the tar (pushing program data out to cache).

2. after the tar has completed the data remins in the cache.

the answer for #2 is the one that is being stated in the response below, namely 
that this shouldn't matter, the memory used for the inactive cache is just as 
good as free memory (i.e. it can be used immediatly for other purposes with no 
swap needed), so the fact that it's inactive instead of free doesn't matter.

however the real problem that Aucoin is running into is #1, namely that when the 
patching process (tar, etc) kicks off the system is choosing to use it's ram as 
a cache instead of leaving it in use for the processes that are running. if he 
manually forces the system to drop it's cache (echoing 3 into drop_caches 
repeatedly during the run of the patch process) he is able to keep this under 
control.

from the documentation on swappiness it seems like setting it to 0 would do what 
he wants (tell the system not to swap out process memory to make room for more 
cache), but he's reporting that this is not working as expected.

this is the same type of problem that people run into with the nightly updatedb 
run pushing inactive programs out of ram makeing the system sluggish the next 
morning.

IIRC there is a flag that can be passed to the open that tells the system that 
the data is 'use once' and not to cache it, is it possible to do ld_preload 
tricks to force this parameter for all the programs that his patch script is 
useing?

David Lang

On Mon, 4 Dec 2006, Kyle Moffett wrote:

> On Dec 03, 2006, at 20:54:41, Aucoin wrote:
>> As a side note, even now, *hours* after the tar has completed and even 
>> though I have swappiness set to 0, cache pressure set to 9999, all dirty 
>> timeouts set to 1 and all dirty ratios set to 1, I still have a 360+K 
>> inactive page count and my "free" memory is less than 10% of normal.
>
> The point you're missing is that an "inactive" page is a free page that 
> happens to have known clean data on it corresponding to something on disk. 
> If you need to use the inactive page for something all you have to do is 
> either zero it or fill it with data from elsewhere.  There is _no_ practical 
> reason for the kernel to turn an "inactive" page into a "free" page.  On my 
> Linux systems after heavy local-disk and network intensive read-only load I 
> have no more than 2% "free" memory, most of the rest is "inactive" (in one 
> case some 2GB of it).  There's nothing _wrong_ with that much "inactive" 
> memory, it just means that you were using it for data at one point, then 
> didn't need it anymore and haven't reused it since.
>
>> I'm not pretending to understand what's happening here but shouldn't some 
>> kind of expiration have kicked in by now and freed up all those inactive 
>> pages?
>
> Nope; the pages will continue to contain valid data until you overwrite them 
> with new data somehow.  Now, if they were "dirty" pages, containing unwritten 
> data, then you would be correct.
>
>> The *instant* I manually push a "3" into drop_caches I have 100% of my 
>> normal free memory and the inactive page count drops below 2K. Maybe I 
>> completely misunderstood the purpose of all those dials but I really did 
>> get the feeling that twisting them all tight would make the housekeeping 
>> algorithms more aggressive.
>
> In this case you're telling the kernel to go beyond its normal housekeeping 
> and delete perfectly good data from memory.  The only reason to do that is 
> usually to make benchmarks mildly more repeatable and doing it on a regular 
> basis tends to kill performance.
>
> Cheers,
> Kyle Moffett
>
>> [copy of long previous email snipped]
>
> PS: No need to put a copy of the entire message you are replying to at the 
> end of your post, it just chews up space.  If anything please quote inline 
> immediately before the appropriate portion of your reply so we can get the 
> gist, much as I have done above.
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
