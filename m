Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263006AbUDLTCO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Apr 2004 15:02:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263031AbUDLTCN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Apr 2004 15:02:13 -0400
Received: from obsidian.spiritone.com ([216.99.193.137]:45766 "EHLO
	obsidian.spiritone.com") by vger.kernel.org with ESMTP
	id S263006AbUDLTCD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Apr 2004 15:02:03 -0400
Date: Mon, 12 Apr 2004 12:01:53 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Hugh Dickins <hugh@veritas.com>
cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Rajesh Venkatasubramanian <vrajesh@umich.edu>
Subject: Re: [PATCH] anobjrmap 9 priority mjb tree
Message-ID: <3360000.1081796512@[10.10.2.4]>
In-Reply-To: <Pine.LNX.4.44.0404121904520.10436-100000@localhost.localdomain>
References: <Pine.LNX.4.44.0404121904520.10436-100000@localhost.localdomain>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Mon, 12 Apr 2004, Martin J. Bligh wrote:
>> >> Any chance of you doing the same comparison between 2.6.5-aa5 
>> >> 2.6.5-aa5 minus prio-tree?
>> 
>> Hmm. it's halfway between the two. There does seem to be less sem 
>> contention, though the profile ticks in __down isn't really an accurate
>> measure.
> 
> Thanks a lot, Martin (despite my silence, I really am listening and
> pondering intermittently on this).  So, -aa5 shows high __down count
> too, may not be any kind of accurate measure, but it's surely not good.
> 
> Mainly I'm concentrating on getting ready the next few patches
> of the objrmap set for Andrew (not to be sent for a day or two).
> Unless we see a plausible way forward on your SDET numbers, I
> think it casts this project in doubt - but even so I do need
> to focus or I'll just mess them up.
> 
> Seems as if prio tree has too high a cost there, yet we believe we
> need it to handle the corner cases of objrmap.

I'm still not sure those corner cases actually occur now that we have
Oracle using remap_file_pages. But Andrew mentioned some uml thing
recently - not sure if that workload affects this or not.

> What I want to investigate, when I'm far enough done, is the effect
> of restoring i_shared_sem to the i_shared_lock it was before 2.5.57.
> My fantasy is that your SDET would behave much more stably without
> that as a semaphore, that prio tree just pushes it over your cliff.

Yeah, to be honest, maybe SDET is kind of bolloxed anyway by i_shared_sem
It needs a better fix. This probably shouldn't hold up objrmap, but it
would be nice to have a think about ;-)
 
> It is easier to insert and remove vmas in the list than the tree,
> and you can get away with leaving them in place quite often with
> the list.
> 
> (Expect me to shout excitedly "Hey, the __down count has gone right
> down, that proves I'm right!")
> 
> i_shared_lock changed to i_shared_sem to allow that cond_resched_lock
> in unmap_vmas to solve vmtruncate latency problems?  With i_mmap and
> i_mmap_shared as lists, isn't it easy to insert a dummy marker vma
> and drop the lock if we need resched?  Resuming from marker after.
> 
> But, sadly, I doubt that can be done with the prio tree: Rajesh?

If it were just a list, maybe RCU would be appropriate. It might be
rather write-heavy though ? I think I played with an rwsem instead
of a sem in the past too (though be careful if you try this, as for
no good reason the return codes are inverted ;-()

M.


