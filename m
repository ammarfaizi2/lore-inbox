Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262557AbVDGTRN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262557AbVDGTRN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 15:17:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262565AbVDGTRM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 15:17:12 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:18863 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S262557AbVDGTQu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 15:16:50 -0400
Subject: Re: ext3 allocate-with-reservation latencies
From: Mingming Cao <cmm@us.ibm.com>
Reply-To: cmm@us.ibm.com
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: Ingo Molnar <mingo@elte.hu>, Lee Revell <rlrevell@joe-job.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <1112879303.2859.78.camel@sisko.sctweedie.blueyonder.co.uk>
References: <1112673094.14322.10.camel@mindpipe>
	 <20050405041359.GA17265@elte.hu>
	 <1112765751.3874.14.camel@localhost.localdomain>
	 <20050407081434.GA28008@elte.hu>
	 <1112879303.2859.78.camel@sisko.sctweedie.blueyonder.co.uk>
Content-Type: text/plain
Organization: IBM LTC
Date: Thu, 07 Apr 2005 12:16:44 -0700
Message-Id: <1112901405.3787.50.camel@dyn318043bld.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-04-07 at 14:08 +0100, Stephen C. Tweedie wrote:
> Hi,
> 
> On Thu, 2005-04-07 at 09:14, Ingo Molnar wrote:
> 
> > doesnt the first option also allow searches to be in parallel?
> 
> In terms of CPU usage, yes.  But either we use large windows, in which
> case we *can't* search remotely near areas of the disk in parallel; or
> we use small windows, in which case failure to find a free bit becomes
> disproportionately expensive (we have to do an rbtree link and unlink
> for each window we search.)
> 

I was thinking that at the end of find_next_reservable_window(), since
we already know the previous node in the rbtree to insert, we could just
link the window there, that way the rbtree link cost will be minimized.

Then I realize in rbtree, previous node is not necessary the parent
node, we still have to search part of the rbtree to find the parent
node, which is really expensive in the case the insertion operations are
very frequent. Hmmm...

> >  This particular one took over 1 msec, 

If you look at the pattern in the latency report:
	.........
     cvs-14981 0.n.2 1044us : find_next_zero_bit (bitmap_search_next_usable_block)
     cvs-14981 0.n.2 1045us : ext3_test_allocatable (bitmap_search_next_usable_block)
     cvs-14981 0.n.2 1045us : find_next_zero_bit (bitmap_search_next_usable_block)
     cvs-14981 0.n.2 1046us : find_next_zero_bit (bitmap_search_next_usable_block)
     cvs-14981 0.n.2 1047us : ext3_test_allocatable (bitmap_search_next_usable_block)
     cvs-14981 0.n.2 1048us : find_next_zero_bit (bitmap_search_next_usable_block)
     cvs-14981 0.n.2 1049us : find_next_zero_bit (bitmap_search_next_usable_block)
     cvs-14981 0.n.2 1049us : ext3_test_allocatable (bitmap_search_next_usable_block)
	........

the patten is: two calls to find_next_zero_bit() followed by a
ext3_test_allocatabl(). And we have about 440 iteration in this report.

That means we are really unlucky: Checked the on disk bitmap, found a
free bit, but it's not free in the journal copy, then we check the
journal copy, find a free bit, but it's not free on disk....I could
imagine we need to check the journal copy once or twice(to prevent re-
use the just freed bit before it is been commited), but how could this
many (440) iterations happen?


Mingming

