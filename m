Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317851AbSFSLVj>; Wed, 19 Jun 2002 07:21:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317848AbSFSLVi>; Wed, 19 Jun 2002 07:21:38 -0400
Received: from loke.as.arizona.edu ([128.196.209.61]:9992 "EHLO
	loke.as.arizona.edu") by vger.kernel.org with ESMTP
	id <S317851AbSFSLVg>; Wed, 19 Jun 2002 07:21:36 -0400
Date: Wed, 19 Jun 2002 04:21:12 -0700 (MST)
From: Craig Kulesa <ckulesa@as.arizona.edu>
To: linux-kernel@vger.kernel.org
cc: linux-mm@kvack.org
Subject: [PATCH] (2/2) reverse mappings for current 2.5.23 VM
In-Reply-To: <Pine.LNX.4.44.0206181340380.3031@loke.as.arizona.edu>
Message-ID: <Pine.LNX.4.44.0206190231520.3637-100000@loke.as.arizona.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Where: 	   http://loke.as.arizona.edu/~ckulesa/kernel/rmap-vm/

This rather smaller patch serves a very different purpose than patch #1.  
It introduces the "minimal" rmap functionality of Rik van Riel's reverse 
mapping patches atop the current 2.5.23 classzone VM.  This quick patch 
was done on a whim at 1 AM, but it actually seems to perform pretty 
decently on my laptop.  Page eviction choice is quite good, even 
in the absence of any sort of page aging.  Using the same quick test as 
in the previous email: 

2.5.22 vanilla:
Total kernel swapouts during test = 29068 kB
Total kernel swapins during test  = 16480 kB
Elapsed time for test: 141 seconds

2.5.23-rmap (this patch -- "rmap-minimal"):           
Total kernel swapouts during test = 24068 kB
Total kernel swapins during test  =  6480 kB
Elapsed time for test: 133 seconds

2.5.23-rmap13b (Rik's "rmap-13b complete") :
Total kernel swapouts during test = 40696 kB
Total kernel swapins during test  =   380 kB
Elapsed time for test: 133 seconds

[Gotta tone down page_launder() a bit...]

Modifications:

	- in vmscan.c: dropped swap_out_add_to_swap_cache(), integrated 
	  its contents to rmap's add_to_swap() in swap_state.c.  This is a 
	  more reasonable place for it anyway. 

	- Dropped try_to_swap_out(), swap_out(), and all its brethren from 
	  vmscan.c.  What a great feeling! :)

	- In vmscan.c's shrink_cache():
	  If a page is actively referenced and page mapping in use, move 
	  the inactive page to the active list; alloc some swap space for 
	  anon pages, then if we must, fall to rmap's try_to_unmap() to 
	  swap.  Drop the max_mapped logic, since swap_out() is gone and 
	  we don't need it.  If try_to_unmap() fails, put the page on the 
	  active list.  These are all pieces of Rik's page_launder() 
	  logic in his integrated rmap scheme.  

	- use page_referenced() instead of TestClearPageReferenced() in 
	  refill_inactive()

	- compilation patches as per "complete" rmap patch #1 (previous 
	  email)

Okay it's quick and dirty, but it seems to work pretty well in initial 
(and not yet rigorous) tests.  Like the full rmap patch for 2.5, I'll try 
to keep this patch up to date with the 2.5 and rmap trees until VM 
development switches to 2.5.

Comments, patches, fixes & feedback always welcome. :)


Craig Kulesa
Steward Observatory, Univ. of Arizona


