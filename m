Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751113AbWFNThj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751113AbWFNThj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 15:37:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932173AbWFNThj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 15:37:39 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.152]:9953 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S1751113AbWFNThi (ORCPT <rfc822;Linux-Kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 15:37:38 -0400
Message-ID: <44906583.6070007@namesys.com>
Date: Wed, 14 Jun 2006 12:37:39 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: "Vladimir V. Saveliev" <vs@namesys.com>, Tom Vier <tmv@comcast.net>,
       Linux-Kernel@vger.kernel.org,
       Reiserfs developers mail-list <Reiserfs-Dev@namesys.com>,
       Reiserfs mail-list <Reiserfs-List@namesys.com>
Subject: Re: [PATCH] updated reiser4 - reduced cpu usage for writes by  writing
  more than 4k at a time (has implications for generic write code  and eventually
  for the IO layer)
References: <44736D3E.8090808@namesys.com> <20060524175312.GA3579@zero> <44749E24.40203@namesys.com> <20060608110044.GA5207@suse.de> <1149766000.6336.29.camel@tribesman.namesys.com> <20060608113517.GC5207@suse.de>
In-Reply-To: <20060608113517.GC5207@suse.de>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:

>On Thu, Jun 08 2006, Vladimir V. Saveliev wrote:
>  
>
>>Hello
>>
>>On Thu, 2006-06-08 at 13:00 +0200, Jens Axboe wrote:
>>    
>>
>>>On Wed, May 24 2006, Hans Reiser wrote:
>>>      
>>>
>>>>Tom Vier wrote:
>>>>
>>>>        
>>>>
>>>>>On Tue, May 23, 2006 at 01:14:54PM -0700, Hans Reiser wrote:
>>>>> 
>>>>>
>>>>>          
>>>>>
>>>>>>underlying FS can be improved.  Performance results show that the new
>>>>>>code consumes  40% less CPU when doing "dd bs=1MB ....." (your hardware,
>>>>>>and whether the data is in cache, may vary this result).  Note that this
>>>>>>has only a small effect on elapsed time for most hardware.
>>>>>>   
>>>>>>
>>>>>>            
>>>>>>
>>>>>Write requests in linux are restricted to one page?
>>>>>
>>>>> 
>>>>>
>>>>>          
>>>>>
>>>>It may go to the kernel as a 64MB write, but VFS sends it to the FS as
>>>>64MB/4k separate 4k writes.
>>>>        
>>>>
>>>Nonsense, 
>>>      
>>>
>>Hans refers to generic_file_write which does
>>prepare_write
>>copy_from_user
>>commit_write
>>for each page.
>>    
>>
>
>Provide your own f_op->write() ?
>  
>
In Unix VFS is an abstraction layer with a philosophical commitment to
allow filesystems to do their own thing, but Linux is quite different,
and what you suggest got vetoed with emphasis.   In all fairness, the
patch vs is sending is one I can live with that allows me to not worry
about aio code and direct io code, neither of which interest me at this
time.  So I suppose there is some benefit to all this hassle.

>  
>
>>>there are ways to get > PAGE_CACHE_SIZE writes in one chunk.
>>>Other file systems have been doing it for years.
>>>
>>>      
>>>
>>Would you, please, say more about it.
>>    
>>
>
>Use writepages?
>
>  
>
writepages is flush time code, this is sys_write() code.  sys_write
first sticks things into the cache,, then memory pressure or pages
reaching maximum time allowed in memory or fsync pushes them out to
disk, at which time writepages might get used.

This issue is about cached writes losing performance when done 4k at a
time.  It is very similar to why bios are better than submitting io 4k
at a time, but it is at a different stage.

Christoph Hellwig wrote:

>That's not really the vfs but the generic pagecache routines.  For some
>filesystems (e.g. XFS) only reservations for delayed allocations are
>performed in this path so it doesn't really matter.  For not so advanced
>filesystems batching these calls would definitly be very helpful.  Patches
>to get there are very welcome.
>  
>
>
Glad we all agree.  vs is sending a pseudocoded proposal.
