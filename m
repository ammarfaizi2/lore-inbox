Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265878AbUEUSOX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265878AbUEUSOX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 May 2004 14:14:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265937AbUEUSOX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 May 2004 14:14:23 -0400
Received: from mail.fastclick.com ([205.180.85.17]:35251 "EHLO
	mail.fastclick.net") by vger.kernel.org with ESMTP id S265878AbUEUSOV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 May 2004 14:14:21 -0400
Message-ID: <40AE46F9.60600@fastclick.com>
Date: Fri, 21 May 2004 11:14:17 -0700
From: "Brett E." <brettspamacct@fastclick.com>
Reply-To: brettspamacct@fastclick.com
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Martin J. Bligh" <mbligh@aracnet.com>
CC: linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       jbarnes@engr.sgi.com
Subject: Re: How can I optimize a process on a NUMA architecture(x86-64 specifically)?
References: <40AD52A4.3060607@fastclick.com> <273180000.1085121453@[10.10.2.4]> <40AE3BF5.5080804@fastclick.com> <74030000.1085161614@flay>
In-Reply-To: <74030000.1085161614@flay>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin J. Bligh wrote:

>>>>Say you have a bunch of single-threaded processes on a NUMA machine. 
>>>>Does the kernel make sure to prefer allocations using a certain CPU's 
>>>>memory, preferring to run a given process on the CPU which contains 
>>>>its memory?  Or should I use the NUMA API(libnuma) to spell this out 
>>>>to the kernel? Does the kernel do the right thing in this case?
>>>
>>>
>>>The kernel will generally do the right thing (process local alloc) by
>>>default. In 99% of cases, you don't want to muck with it - unless you're
>>>running one single app dominating the whole system, and nothing else is
>>>going on, you probably don't want to specify anything explicitly.
>>>
>>>M.
>>>
>>
>>Let's say I have a 2 way opteron and want to run 4 long-lived processes.   I fork and exec to create 1 of the processes, it chooses to run on processor 0 since processor 1 is overloaded at that time, so its homenode is processor 0. 
> 
> 
> There is no such thing as a homenode. What you describe is more or less why
> we ditched that concept.
> 
> 
>>I fork and exec another, it chooses processor 0 since processors 1 is overloaded at that time. .. Let's say an uneven distribution is chosen for all 4 processes, with all processes mapped to processor 0. So they allocate on node 0 yet the scheduler will map these to both processors since CPU should be balanced. In this case, you will have a situation where the second processor will have to fetch memory from the other processor's memory.
> 
> 
> Each process will allocate local to the CPU it is running on when it does the
> allocate, so it's difficult to get as off-kilter as you describe (though it
> is still possible).

So could process 0 run on processor 0, allocating local to processor 0, 
then run on processor 1, allocating local to processor 1, this way 
allocating to both processors?  So over time process 0's allocations 
would be split up between both processors, defeating NUMA.  The homenode 
concept + explicit CPU pinning seems useful in that they allow you to 
take advantage of NUMA better. Without these two things the kernel will 
just allocate on the currently running CPU whatever that may be when in 
fact a preference must be given to a CPU at some point, hopefully early 
on in the life of the process, in order to take advantage of NUMA.

I'm trying to play devil's advocate by the way so bear with me, you've 
been very helpful and I'm learning a great deal from you.  :)


Thanks,

Brett

