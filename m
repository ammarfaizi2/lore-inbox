Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266237AbUG0EHw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266237AbUG0EHw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 00:07:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266242AbUG0EHw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 00:07:52 -0400
Received: from smtp107.mail.sc5.yahoo.com ([66.163.169.227]:20327 "HELO
	smtp107.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S266237AbUG0EHt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 00:07:49 -0400
Message-ID: <4105D511.9030207@yahoo.com.au>
Date: Tue, 27 Jul 2004 14:07:45 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031107 Debian/1.5-3
X-Accept-Language: en
MIME-Version: 1.0
To: Daniel Phillips <phillips@istop.com>
CC: Andrew Morton <akpm@osdl.org>, lmb@suse.de, arjanv@redhat.com,
       sdake@mvista.com, teigland@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] Minneapolis Cluster Summit, July 29-30
References: <1089501890.19787.33.camel@persist.az.mvista.com> <200407122219.17582.phillips@istop.com> <40F34978.60709@yahoo.com.au> <200407262331.44176.phillips@istop.com>
In-Reply-To: <200407262331.44176.phillips@istop.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips wrote:

>On Monday 12 July 2004 22:31, Nick Piggin wrote:
>
>>
>>Search for rt_task in mm/page_alloc.c
>>
>
>Ah, interesting idea: realtime tasks get to dip into the PF_MEMALLOC reserve, 
>until it gets down to some threshold, then they have to give up and wait like 
>any other unwashed nobody of a process.  _But_ if there's a user space 
>process sitting in the writeout path and some other realtime process eats the 
>entire realtime reserve, everything can still grind to a halt.
>
>So it's interesting for realtime, but does not solve the userspace PF_MEMALLOC 
>inversion.
>
>

Not the rt_task thing, because yes, you can have other RT tasks that aren't
small and bounded that screw up your reserves.

But a PF_MEMALLOC userspace task is still useful.

>>>>A privileged syscall which allows a task to mark itself as one which
>>>>cleans memory would make sense.
>>>>
>>>For now we can do it with an ioctl, and we pretty much have to do it for
>>>pvmove.  But that's when user space drives the kernel by syscalls; there
>>>is also the nasty (and common) case where the kernel needs userspace to
>>>do something for it while it's in PF_MEMALLOC.  I'm playing with ideas
>>>there, but nothing I'm proud of yet.  For now I see the in-kernel
>>>approach as the conservative one, for anything that could possibly find
>>>itself on the VM writeout path.
>>>
>>You'd obviously want to make the PF_MEMALLOC task as tight as possible,
>>and running mlocked:
>>
>
>Not just tight, but bounded.  And tight too, of course.
>
>
>>I don't particularly see why such a task would be any safer in-kernel.
>>
>
>The PF_MEMALLOC flag is inherited down a call chain, not across a pipe or 
>similar IPC to user space.
>
>
This is no different in kernel of course. You would have to think about
which threads need the flag and which do not. Even better, you might
aquire and drop the flag only when required. I can't see any obvious
problems you would run into.

>>PF_MEMALLOC tasks won't enter page reclaim at all. The only way they
>>will reach the writeout path is if you are write(2)ing stuff (you may
>>hit synch writeout).
>>
>
>That's the problem.
>
>

Well I don't think it would be a problem to get the write throttling path
to ignore PF_MEMALLOC tasks if that is what you need. Again, this shouldn't
be any different to in kernel code.


