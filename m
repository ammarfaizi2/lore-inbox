Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261294AbTEMO1I (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 10:27:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261308AbTEMO1I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 10:27:08 -0400
Received: from watch.techsource.com ([209.208.48.130]:38594 "EHLO
	techsource.com") by vger.kernel.org with ESMTP id S261294AbTEMO1G
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 10:27:06 -0400
Message-ID: <3EC104FC.5010001@techsource.com>
Date: Tue, 13 May 2003 10:45:16 -0400
From: Timothy Miller <miller@techsource.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
CC: "'Linux Kernel Mailing List'" <linux-kernel@vger.kernel.org>
Subject: Re: A way to shrink process impact on kernel memory usage?
References: <A46BBDB345A7D5118EC90002A5072C780CCB00C1@orsmsx116.jf.intel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Perez-Gonzalez, Inaky wrote:
>>-----Original Message-----
>>From: Timothy Miller [mailto:miller@techsource.com]
>>
>>One of the things that's been worked on to reduce kernel memory usage
>>for processes is to shrink the kernel stack from 8k to 4k.  I mean, it's
>>not like you could shrink it to 6k, right?  Well, why not?  Why not
>>allocate an 8k space and put various process-related data structures at
>>the beginning of it?  Sure, a stack overflow could corrupt that data,
>>but a stack overflow would be disasterous anyhow.
> 
> 
> It is being done already. At least, on i386, alloc_thread_info() 
> allocates two pages; at the beginning you have the thread info
> structure [context and friends]. 
> 
> This is called from copy_process(), dup_task_struct(), alloc_thread_info().
> 
> However, what you say makes sense, but it'd be kind of difficult to
> calculate how much is enough ... maybe, who knows. But the only 
> thing you can put in there is stuff that is specific to each thread
> (scheduling information, parent/s, childs, siblings, pid maps,
> timers? used_math, comm, fsinfo, ipc, etc, etc ...).

If you have some data which is common to a group of threads/processes, 
it could be stored in one (or more--redundantly) of the process stacks. 
  If the refcount is not zero and the process stack holding the data is 
to die, the data can be moved to another stack or otherwise stored 
somewhere else.

> 
> Thus, it'd be interesting to collapse all the common stuff in
> the task_struct corresponding to a same thread group into a single
> one, and move whatever is thread specific out to a thread-specific
> structure [alike to thread_info, although I guess you want to keep
> thread_info really small for cache performance].
> 
> That should save a lot of task_structs when threading and move all
> the info to that place you say. It is going to be a lot of work,
> though, very kind of 2.7.
> 

It might, nevertheless, be a good an equitable solution to the problem. 
  Another way to skin a cat, as it were.

> 
>>Someone complained about a process structure already being too bloated.
>>  Unless it's several K in size already, you can bloat it up all you
>>please this way.
> 
> 
> Not really - the more bloated, the more cache misses you will have.
> There are a lot of fields that don't use all the bits and a lot
> of Booleans; it'd make sense to collapse all those into a single
> word if possible.

Most assuredly.  Why are they not already? :)

> 
>>Another advantage is that you could make the datastructures growable.
>>The stack grows down, and the data grows up.  As long as they don't
>>meet, all is well.
> 
> 
> To solve that, you put the structures on the top of the area instead
> of at the beginning. That way you are sure the stack cannot overflow
> over your (very delicate) data structures, and makes it easier to add
> an overflow guard page (as the stack end is at the beginning of a
> page).

I believe I mentioned that idea.  Either the stack and data grow in 
opposite directions, with obvious advantages and risks, or the data is 
at the top of the area but therefore not growable.


