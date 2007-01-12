Return-Path: <linux-kernel-owner+w=401wt.eu-S1751149AbXALO61@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751149AbXALO61 (ORCPT <rfc822;w@1wt.eu>);
	Fri, 12 Jan 2007 09:58:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751213AbXALO61
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Jan 2007 09:58:27 -0500
Received: from mail.tmr.com ([64.65.253.246]:42158 "EHLO gaimboi.tmr.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751156AbXALO6Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Jan 2007 09:58:25 -0500
Message-ID: <45A7A23F.7040801@tmr.com>
Date: Fri, 12 Jan 2007 09:59:11 -0500
From: Bill Davidsen <davidsen@tmr.com>
Organization: TMR Associates Inc, Schenectady NY
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.8) Gecko/20061105 SeaMonkey/1.0.6
MIME-Version: 1.0
To: Aubrey <aubreylee@gmail.com>
CC: Nick Piggin <nickpiggin@yahoo.com.au>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Hua Zhong <hzhong@gmail.com>,
       Hugh Dickins <hugh@veritas.com>, linux-kernel@vger.kernel.org,
       hch@infradead.org, kenneth.w.chen@intel.com, mjt@tls.msk.ru
Subject: Re: O_DIRECT question
References: <6d6a94c50701101857v2af1e097xde69e592135e54ae@mail.gmail.com>	 <6d6a94c50701102245g6afe6aacxfcb2136baee5cbfa@mail.gmail.com>	 <20070110225720.7a46e702.akpm@osdl.org>	 <45A5E1B2.2050908@yahoo.com.au>	 <6d6a94c50701102354l7ab41a3bp4761566204f1d992@mail.gmail.com>	 <45A5F157.9030001@yahoo.com.au> <45A6F70E.1050902@tmr.com>	 <45A70EF9.40408@yahoo.com.au>	 <Pine.LNX.4.64.0701112044070.3594@woody.osdl.org>	 <45A714F8.6020600@yahoo.com.au> <6d6a94c50701112122l66a4866bg548009dddb806434@mail.gmail.com>
In-Reply-To: <6d6a94c50701112122l66a4866bg548009dddb806434@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Aubrey wrote:
> On 1/12/07, Nick Piggin <nickpiggin@yahoo.com.au> wrote:
>> Linus Torvalds wrote:
>> >
>> > On Fri, 12 Jan 2007, Nick Piggin wrote:
>> >
>> >>We are talking about about fragmentation. And limiting pagecache to 
>> try to
>> >>avoid fragmentation is a bandaid, especially when the problem can 
>> be solved
>> >>(not just papered over, but solved) in userspace.
>> >
>> >
>> > It's not clear that the problem _can_ be solved in user space.
>> >
>> > It's easy enough to say "never allocate more than a page". But it's 
>> often
>> > not REALISTIC.
>>  >
>> > Very basic issue: the perfect is the enemy of the good. Claiming that
>> > there is a "proper solution" is usually a total red herring. Quite 
>> often
>> > there isn't, and the "paper over" is actually not papering over, it's
>> > quite possibly the best solution there is.
>>
>> Yeah *smallish* higher order allocations are fine, and we use them 
>> all the
>> time for things like stacks or networking.
>>
>> But Aubrey (who somehow got removed from the cc list) wants to do 
>> order 9
>> allocations from userspace in his nommu environment. I'm just trying 
>> to be
>> realistic when I say that this isn't going to be robust and a userspace
>> solution is needed.
>>
> Hmm..., aside from big order allocations from user space, if there is
> a large application we need to run, it should be loaded into the
> memory, so we have to allocate a big block to accommodate it. kernel
> fun like load_elf_fdpic_binary() etc will request contiguous memory,
> then if vfs eat up free memory, loading fails. 
Before we had virtual memory we had only a base address register, start 
at this location and go thus far, and user program memory had to be 
contiguous. To change a program size, all other programs might be moved, 
either by memory copy or actual swap to disk if total memory became a 
problem. To minimize the pain, programs were loaded at one end of 
memory, and system buffers and such were allocated at the other. That 
allowed the most recently loaded program the best chance of being able 
to grow without thrashing.

The point is that if you want to be able to allocate at all, sometimes 
you will have to write dirty pages, garbage collect, and move or swap 
programs. The hardware is just too limited to do something less painful, 
and the user can't see memory to do things better. Linus is right, 
'Claiming that there is a "proper solution" is usually a total red 
herring. Quite often there isn't, and the "paper over" is actually not 
papering over, it's quite possibly the best solution there is.' I think 
any solution is going to be ugly, unfortunately.

-- 
bill davidsen <davidsen@tmr.com>
  CTO TMR Associates, Inc
  Doing interesting things with small computers since 1979

