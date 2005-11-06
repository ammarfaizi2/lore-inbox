Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932339AbVKFIpZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932339AbVKFIpZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Nov 2005 03:45:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932336AbVKFIpZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Nov 2005 03:45:25 -0500
Received: from smtpout.mac.com ([17.250.248.88]:21495 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S932339AbVKFIpZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Nov 2005 03:45:25 -0500
In-Reply-To: <Pine.LNX.4.64.0511040725090.27915@g5.osdl.org>
References: <20051104010021.4180A184531@thermo.lanl.gov> <Pine.LNX.4.64.0511032105110.27915@g5.osdl.org> <20051103221037.33ae0f53.pj@sgi.com> <20051104063820.GA19505@elte.hu> <Pine.LNX.4.64.0511040725090.27915@g5.osdl.org>
Mime-Version: 1.0 (Apple Message framework v734)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <796B585C-CB1C-4EBA-9EF4-C11996BC9C8B@mac.com>
Cc: Ingo Molnar <mingo@elte.hu>, Paul Jackson <pj@sgi.com>,
       andy@thermo.lanl.gov, mbligh@mbligh.org, akpm@osdl.org,
       arjan@infradead.org, arjanv@infradead.org, haveblue@us.ibm.com,
       kravetz@us.ibm.com, lhms-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org, mel@csn.ul.ie,
       nickpiggin@yahoo.com.au
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [Lhms-devel] [PATCH 0/7] Fragmentation Avoidance V19
Date: Sun, 6 Nov 2005 03:44:48 -0500
To: Linus Torvalds <torvalds@osdl.org>
X-Mailer: Apple Mail (2.734)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 4, 2005, at 10:31:48, Linus Torvalds wrote:
> I can pretty much guarantee that any kernel I maintain will never  
> have dynamic kernel pointers: when some memory has been allocated  
> with kmalloc() (or equivalent routines - pretty much _any_ kernel  
> allocation), it stays put.

Hmm, this brings up something that I haven't seen discussed on this  
list (maybe a long time ago, but perhaps it should be brought up  
again?).  What are the pros/cons to having a non-physically-linear  
kernel virtual memory space?  Would it be theoretically possible to  
allow some kind of dynamic kernel page swapping, such that the _same_  
kernel-virtual pointer goes to a different physical memory page?   
That would definitely satisfy the memory hotplug people, but I don't  
know what the tradeoffs would be for normal boxen.

It seems like the trick would be to make sure that page accesses  
_during_ the swap are correctly handled.  If the page-swapper  
included code in the kernel fault handler to notice that a page was  
in the process of being swapped out/in by another CPU, it could just  
wait for swap-in to finish and then resume from the new page.  This  
would get messy with DMA and non-cpu memory accessors and such, which  
are what I assume the reasons for not implementing this in the past  
have been.

 From what I can see, the really dumb-obvious-slow method would be to  
call the first and last parts of software-suspend.  As memory hotplug  
is a relatively rare event, this would probably work well enough  
given the requirements:
     1)  Run software suspend pre-memory-dump code
     2)  Move pages off the to-be-removed node, remapping the kernel  
space to the new locations.
     3)  Mark the node so that new pages don't end up on it
     4)  Run software suspend post-memory-reload code

<random-guessing>
Perhaps the non-contiguous memory support would be of some help here?
</random-guessing>

Cheers,
Kyle Moffett

--
Simple things should be simple and complex things should be possible
   -- Alan Kay



