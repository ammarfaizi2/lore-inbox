Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264052AbTDJORb (for <rfc822;willy@w.ods.org>); Thu, 10 Apr 2003 10:17:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264053AbTDJORb (for <rfc822;linux-kernel-outgoing>);
	Thu, 10 Apr 2003 10:17:31 -0400
Received: from franka.aracnet.com ([216.99.193.44]:21477 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S264052AbTDJOR3 (for <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Apr 2003 10:17:29 -0400
Date: Thu, 10 Apr 2003 07:29:03 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Hugh Dickins <hugh@veritas.com>
cc: Andrew Morton <akpm@digeo.com>, Dave McCracken <dmccr@us.ibm.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix obj vma sorting
Message-ID: <208780000.1049984941@[10.10.2.4]>
In-Reply-To: <Pine.LNX.4.44.0304101433420.1705-100000@localhost.localdomain>
References: <Pine.LNX.4.44.0304101433420.1705-100000@localhost.localdomain>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> > Here's the diffprofile for just your patch ... where it's positive,
>> > that's the increase in the number of ticks by applying your patch.
>> > Where it's negative, that's the decrease. The %age is the change from
>> > the first to the second profile:
>> > 
>> > larry:/var/bench/results# diffprofile 2.5.67-mjb0.2{-nosort,}/sdetbench/64/profile
>> >       7148    24.9% total
>> >       6482    37.7% default_idle
>> >       1466   842.5% __down
>> >        442   566.7% __wake_up
>> >        435   378.3% schedule
>> >        251     0.0% move_vma_start
>> >        149   876.5% __vma_link
>> >         72    40.2% remove_shared_vm_struct
>> >         46    35.1% copy_mm
>> >         20    60.6% vma_link
>> > 
>> > Note the massive increase in down() (and some of the vma ops).
>> 
>> Thanks for all the info, I'm sorry, I must rush away now.
>> I'll try another think later, but hope someone can do better.
> 
> I've not reproduced this in testing myself (I don't have SDET);
> but the conclusion I've come to is that the length of your vma lists
> (for one or probably more files) was such that they were already
> dangerously extending the hold of i_shared_sem with Dave's linear-
> search-to-sort patch, and my additional downs in move_vma_start
> then just pushed it over the edge into a thrash of collisions.
> 
> Clearly I was wrong to suppose that move_vma_start would scarcely be
> called: even in my testing it showed up ~50% higher than __vma_link,
> the other user of __vma_link_file.  But we cannot avoid i_shared_sem
> there (can probably avoid page_table_lock and I did try doing without
> that, just in case my up before spin_unlock had some hideous effect,
> but apparently not).

Yeah, sorry ... I guess someone should have published the phone conversation
we had yesterday ... </me pokes Dave in the eye>

We came to the conclusion that should be adding the semaphore to the current 
code even, as list_add_tail isn't atomic to a doubly linked list (unless
maybe you can do some fancy-pants compare and exchange thing after setting
up the prev pointer of the new element already). Which is probably going
to suck performance-wise, but I'd prefer correctness. From there we can
make a better judgment, but it sounds like it's going to content horribly
on those busy semaphores. 

cat /proc/*/maps | nawk '{print $6}' | sort | uniq -c
reveals that we have 600 or so mappings to libc and ld splattered around,
which seems fairly low load ... SDET is doing bunches of shell scripts,
which probably generates the high operations on top of that.

I think the "list of lists" thing will help this, but unless we do 
something like RCU here, I don't see how we can do much to this data
structure without death-by-semaphore contention.

> I believe you've done the right thing in 2.5.67-mjb1: chucked out
> both my patch and the vma list sorting: it's just too expensive on
> the fast path, and you've shown that vividly.

Yeah, I was being grumpy and threw it all out ;-) Needs more
thought before we decide what to do with this stuff.

M.

