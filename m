Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262085AbUGMCb1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262085AbUGMCb1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 22:31:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262138AbUGMCb1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 22:31:27 -0400
Received: from smtp105.mail.sc5.yahoo.com ([66.163.169.225]:51815 "HELO
	smtp105.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262085AbUGMCbZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 22:31:25 -0400
Message-ID: <40F34978.60709@yahoo.com.au>
Date: Tue, 13 Jul 2004 12:31:20 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040707 Debian/1.7-5
X-Accept-Language: en
MIME-Version: 1.0
To: Daniel Phillips <phillips@istop.com>
CC: Andrew Morton <akpm@osdl.org>, lmb@suse.de, arjanv@redhat.com,
       sdake@mvista.com, teigland@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] Minneapolis Cluster Summit, July 29-30
References: <1089501890.19787.33.camel@persist.az.mvista.com> <40F294D2.3010203@yahoo.com.au> <20040712135432.57d0133c.akpm@osdl.org> <200407122219.17582.phillips@istop.com>
In-Reply-To: <200407122219.17582.phillips@istop.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips wrote:
> Hi Andrew,
> 
> On Monday 12 July 2004 16:54, Andrew Morton wrote:
> 
>>Nick Piggin <nickpiggin@yahoo.com.au> wrote:
>>
>>>I don't see why it would be a problem to implement a "this task
>>>facilitates page reclaim" flag for userspace tasks that would take
>>>care of this as well as the kernel does.
>>
>>Yes, that has been done before, and it works - userspace "block drivers"
>>which permanently mark themselves as PF_MEMALLOC to avoid the obvious
>>deadlocks.
>>
>>Note that you can achieve a similar thing in current 2.6 by acquiring
>>realtime scheduling policy, but that's an artifact of some brainwave which
>>a VM hacker happened to have and isn't a thing which should be relied upon.
> 
> 
> Do you have a pointer to the brainwave?
> 

Search for rt_task in mm/page_alloc.c

> 
>>A privileged syscall which allows a task to mark itself as one which
>>cleans memory would make sense.
> 
> 
> For now we can do it with an ioctl, and we pretty much have to do it for 
> pvmove.  But that's when user space drives the kernel by syscalls; there is 
> also the nasty (and common) case where the kernel needs userspace to do 
> something for it while it's in PF_MEMALLOC.  I'm playing with ideas there, 
> but nothing I'm proud of yet.  For now I see the in-kernel approach as the 
> conservative one, for anything that could possibly find itself on the VM 
> writeout path.
> 

You'd obviously want to make the PF_MEMALLOC task as tight as possible,
and running mlocked: I don't particularly see why such a task would be
any safer in-kernel.

PF_MEMALLOC tasks won't enter page reclaim at all. The only way they
will reach the writeout path is if you are write(2)ing stuff (you may
hit synch writeout).
