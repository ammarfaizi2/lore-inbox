Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750781AbWDDR7J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750781AbWDDR7J (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 13:59:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750782AbWDDR7J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 13:59:09 -0400
Received: from nwd2mail1.analog.com ([137.71.25.50]:35725 "EHLO
	nwd2mail1.analog.com") by vger.kernel.org with ESMTP
	id S1750781AbWDDR7I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 13:59:08 -0400
Message-Id: <6.1.1.1.0.20060404135252.01ec9920@ptg1.spd.analog.com>
X-Mailer: QUALCOMM Windows Eudora Version 6.1.1.1
Date: Tue, 04 Apr 2006 13:59:00 -0400
To: linux-kernel@vger.kernel.org
From: Robin Getz <rgetz@blackfin.uclinux.org>
Subject: [RFC2] non-power of 2 allocator for noMMU Linux
Cc: pwilshire@cox.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Based on the feedback we got last week, Phil did look into alloc_exact, and 
had the following thoughts:

 >
 > It looks simple but the trouble is that all the freed pages are freed
 > one at a time.
 >
 > So you get a po2 block of memory and return the excess to the single
 > page list ( hot pages )
 >
 > When you free the allocation you return the original block ( less the
 > already freed pages ) to the hot page list as single pages.
 >
 > I guess the system will then see too many hot pages and combine them
 > but I have not researched this.
 >
 > I see a possible increased risk of fragmentation with this system.
 > The idea of taking a large block of memory and then splitting the
 > whole thing up into a large number of single pages troubles me.
 >
 > I have dropped the hot page list in sidekick. single pages are kept as
 > is in the latest version.
 >
 > The manual merge ( which could be simply automated if needed ) will
 > perform the page combination.

The non-power of 2 patch he has been working on (which is stable enough to 
boot a system) is at:

http://blackfin.uclinux.org/tracker/index.php?func=detail&aid=1175

It is not Blackfin specific. We just have a number of these systems set
up for testing.

This was the notice he sent to the uClinuc-dev mailing list a few days ago:
>I have been working for a few weeks on a non power of 2 allocator for the 
>2.6 kernel.
>The work was triggered by the arrival of  the slob allocator, I got the 
>basis of an idea from that system.
>
>The objective was to provide a system that could be used in smaller memory 
>footprints and not incur the power of 2 overhead for all allocations in a 
>non MMU environment
>
>The operation is quite simple. All available memory is turned into a super 
>slob and, if you ask for an allocation of order size 4 or more then you 
>will get the exact number of pages you need to satisfy your memory size 
>request.
>
>AS you free memory the block of pages is added back into the pool and also 
>added to a "free memory" list.
>
>Future allocations will scan the list first for a suitable block and 
>neither find one of an exact size or a larger one.
>
>If needed, the larger block is broken up into two smaller blocks to suit a 
>given request.
>
>The difference between this and the older 2.4 NP2 allocator is the fact 
>that the free page bit map (and associated bit map search) is no longer 
>needed. This  allocator should be almost as fast as the power of 2 allocator.
>The nature of its operation tends to limit fragmentation but more testing 
>is needed.
>
>Note that the slob system in the 2.16 kernel is not optimized, There is a 
>speed up patch for the slob allocator that also should be applied.
>I will upgrade the slob code in a later patch.

Any feedback appreciated.

-robin 

