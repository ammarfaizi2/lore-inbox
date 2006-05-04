Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750710AbWEDS5Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750710AbWEDS5Z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 May 2006 14:57:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750716AbWEDS5Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 May 2006 14:57:25 -0400
Received: from ishtar.tlinx.org ([64.81.245.74]:9612 "EHLO ishtar.tlinx.org")
	by vger.kernel.org with ESMTP id S1750710AbWEDS5Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 May 2006 14:57:25 -0400
Message-ID: <445A4E91.1050802@tlinx.org>
Date: Thu, 04 May 2006 11:57:21 -0700
From: Linda Walsh <lkml@tlinx.org>
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
MIME-Version: 1.0
To: Wu Fengguang <wfg@mail.ustc.edu.cn>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] kernel facilities for cache prefetching
References: <346556235.24875@ustc.edu.cn> <44592491.4060503@tlinx.org> <346744728.01465@ustc.edu.cn>
In-Reply-To: <346744728.01465@ustc.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wu Fengguang wrote:
> On Wed, May 03, 2006 at 02:45:53PM -0700, Linda Walsh wrote:
>   
>>    1. As you mention; reading files "sequentially" through the file
>> system is "bad" for several reasons.  Areas of interest:
>>    a) don't go through the file system.  Don't waste time doing
>> directory lookups and following file-allocation maps;  Instead,
>> use raw-disk i/o and read sectors in using device & block number.
>>     
>
> Sorry, it does not fit in the linux's cache model.
>   
---
    Maybe linux's cache model needs to be _improved_ to better
allow for hardware acceleration?^**  It is the job of the OS to provide
sufficiently low level facilities to allow optimal use of the system
hardware, while at the same time providing enough high level facilities
to support applications that don't require such tuning.


>>    b) Be "dynamic"; "Trace" (record (dev&blockno/range) blocks
>> starting ASAP after system boot and continuing for some "configurable"
>> number of seconds past reaching the desired "run-level" (coinciding with
>> initial disk quiescence).  Save as "configurable" (~6-8?) number of
>> traces to allow finding the common initial subset of blocks needed.
>>     
>
> It is a alternative way of doing the same job: more precise, with more
> complexity and more overhead.  However the 'blockno' way is not so
> tasteful.
>   
----
Maybe not so tasteful to you, but it is an alternate path that
circumvents unnecessary i/o redirections.  An additional optimization
is to have a "cache" of frequently used "system applications" that have
their pathnames registered, so no run-time seaching of the user PATH
is necessary.

>>    c) Allow specification of max# of blocks and max number of "sections"
>> (discontiguous areas on disk);
>>     
>
> Good point, will do it in my work.
>
>   
>>    d) "Ideally", would have a way to "defrag" the common set of blocks.
>> I.e. -- moving the needed blocks from potentially disparate areas of
>> files into 1 or 2 contiguous areas, hopefully near the beginning of
>> the disk (or partition(s)).
>>    That's the area of "boot" pre-caching.
>>     
>
>   
> I guess poor man's defrag would be good enough for the seeking storm.
>   
---
    I disagree. The "poor man's defrag, as you call it, puts entire files
into contiguous sections -- each of which will have to be referenced by 
following
a PATH and directory chain.  The optimization I'm talking about would 
only store
the referenced data-blocks actually used in the files.  This would allow a
directy read into memory of a *bunch* of needed sectors while not including
sectors from the same files that are not actually read from during the 
boot *or*
app. initialization process.

>>    That's "application" pre-caching.
>>     
> Yes, it is a planned feature, will do it.
>   
Trés cool.
>>    A third area -- that can't be easily done in the kernel, but would
>> require a higher skill level on the part of application and library
>> developers, is to move towards using "delay-loaded" libraries.  In
>> Windows, it seems common among system libraries to use this feature. 
>> An obvious benefit -- if certain features of a program are not used,
>> the associated libraries are never loaded.  Not loading unneeded parts
>> of a program should speed up initial application load time, significantly.
>>     
> Linux already does lazy loading for linked libs. The only one pitfall
> is that /lib/ld-linux.so.2 seems to touch the first 512B data of every
> libs before doing mmap():
>   
----
    Yes -- and this is the "killer".  If my app may "potentially" use
50 run-time libs, but in any single invocation, only uses 20 of those
libs, the page tables and fixups for the unused 30 libraries don't
need to be done.  In fact, in some configurations, those 30 libs may
not even need to be present on disk!

    Typical example - "Active Directory"; I don't use it.  I don't
need the libraries on my system or need them "resolved" at runtime. 
It would be far preferable if programs would only load those
libraries actually used at run-time -- and load them *dynamically*,
as needed (for libraries that may not actually be called or
used).  This way, the initial time to start the program is
significantly reduced to the "core" set of libraries needed to
run the program.  Optional features are loaded as those features
are called for off disk.  Delays of loading optional libraries
one-two at a time, interactively, are not likely to be noticed,
but if you load all of those "optional" libraries prior to execution,
the sum-total will be noticed in an interactive environment.

^** -- "somewhere", it _seems_, the physical, device relative sector
must be resolved.  If it is not, how is i/o-block buffer consistency
maintained when the user references "device "hda", sector "1000", then
the same sector as "hda1", sector 500, and also as file "/etc/passwd",
sector 0?  _If_ cache consistency is maintained (and I _assume_^**2
it is), they all need to be mapped to a physical sector at some point.

^**2 - Use of assumption noted; feel free to correct me and tell me
this isn't the case if linux doesn't maintain disk-block cache
consistency.


-linda




