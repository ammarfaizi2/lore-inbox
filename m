Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261187AbUCBVMv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Mar 2004 16:12:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261781AbUCBVMk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Mar 2004 16:12:40 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:45557 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261822AbUCBVKs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Mar 2004 16:10:48 -0500
Message-ID: <4044F84D.4030003@mvista.com>
Date: Tue, 02 Mar 2004 13:10:37 -0800
From: George Anzinger <george@mvista.com>
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Amit S. Kale" <amitkale@emsyssoft.com>
CC: Andi Kleen <ak@suse.de>, akpm@osdl.org, pavel@ucw.cz,
       linux-kernel@vger.kernel.org, piggy@timesys.com,
       trini@kernel.crashing.org
Subject: Re: kgdb support in vanilla 2.6.2
References: <20040204230133.GA8702@elf.ucw.cz.suse.lists.linux.kernel> <200402061914.38826.amitkale@emsyssoft.com> <403FDB37.2020704@mvista.com> <200403011508.23626.amitkale@emsyssoft.com>
In-Reply-To: <200403011508.23626.amitkale@emsyssoft.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Amit S. Kale wrote:
> On Saturday 28 Feb 2004 5:35 am, George Anzinger wrote:
> 
>>Amit S. Kale wrote:
>>
>>>On Friday 06 Feb 2004 6:54 pm, Andi Kleen wrote:
>>>
>>>>On Fri, 6 Feb 2004 18:35:16 +0530
>>>>
>>>>"Amit S. Kale" <amitkale@emsyssoft.com> wrote:
>>>>
>>>>>On Friday 06 Feb 2004 5:46 pm, Andi Kleen wrote:
>>>>>
>>>>>>On Fri, 6 Feb 2004 17:28:36 +0530
>>>>>>
>>>>>>"Amit S. Kale" <amitkale@emsyssoft.com> wrote:
>>>>>>
>>>>>>>On Friday 06 Feb 2004 7:50 am, Andi Kleen wrote:
>>>>>>>
>>>>>>>>On Thu, 5 Feb 2004 23:20:04 +0530
>>>>>>>>
>>>>>>>>"Amit S. Kale" <amitkale@emsyssoft.com> wrote:
>>>>>>>>
>>>>>>>>>On Thursday 05 Feb 2004 8:41 am, Andi Kleen wrote:
>>>>>>>>>
>>>>>>>>>>Andrew Morton <akpm@osdl.org> writes:
>>>>>>>>>>
>>>>>>>>>>>need to take a look at such things and really convice
>>>>>>>>>>>ourselves that they're worthwhile.  Personally, I'd only be
>>>>>>>>>>>interested in the basic stub.
>>>>>>>>>>
>>>>>>>>>>What I found always extremly ugly in the i386 stub was that it
>>>>>>>>>>uses magic globals to talk to the page fault handler. For the
>>>>>>>>>>x86-64 version I replaced that by just using __get/__put_user
>>>>>>>>>>in the memory accesses, which is much cleaner. I would suggest
>>>>>>>>>>doing that for i386 too.
>>>>>>>>>
>>>>>>>>>May be I am missing something obvious. When debugging a page
>>>>>>>>>fault handler if kgdb accesses an swapped-out user page doesn't
>>>>>>>>>it deadlock when trying to hold mm semaphore?
>>>>>>>>
>>>>>>>>Modern i386 kernels don't grab the mm semaphore when the access is
>>>>>>>>
>>>>>>>>
>>>>>>>>>= TASK_SIZE and the access came from kernel space (actually I see
>>>>>>>>
>>>>>>>>x86-64 still does, but that's a bug, will fix). You could only see
>>>>>>>>a deadlock when using user addresses and you already hold the mm
>>>>>>>>semaphore for writing (normal read lock is ok). Just don't do that.
>>>>>>>
>>>>>>>OK. It don't deadlock when kgdb accesses kernel addresses.
>>>>>>>
>>>>>>>When a user space address is accessed through kgdb, won't the kernel
>>>>>>>attempt to fault in the user page? We don't want that to happen
>>>>>>>inside kgdb.
>>>>>>
>>>>>>Yes, it will. But I don't think it's a bad thing. If the users doesn't
>>>>>>want that they should not follow user addresses. After all kgdb is for
>>>>>>people who know what they are doing.
>>>>>
>>>>>Let kgdb refuse to access any addresses below TASK_SIZE. That's better
>>>>>than accidentally typing something and getting lost.
>>>>
>>>>That's fine. But can you perhaps add a magic command that enables it
>>>>again?
>>>
>>>Yes. This sounds good.
>>
>>This could be a flag in the kgdb_info structure.  See -mm kgdb.  Does not
>>require any new commands as it is just a global the user can change.
> 
> 
> Having all user modifiable variables in one place is definitely a good idea.  
> Need to do this sometime.

I also put the discovered status of each cpu other than the current one here. 
The structure is explained in the documentation part of the -mm patch.  Another 
thing I put here and have found to be very useful is the address that the stub 
was called from.  Often it is not clear just why we are in the stub, given that 
we trap such things as kernel page faults, NMI watchdog, BUG macros and such.  I 
have found, on occasion, that knowing this info has been key to understanding 
what was wrong.

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

