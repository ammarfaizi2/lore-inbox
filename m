Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273589AbRIQM0G>; Mon, 17 Sep 2001 08:26:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273588AbRIQMZ4>; Mon, 17 Sep 2001 08:25:56 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:31251 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S273589AbRIQMZm>; Mon, 17 Sep 2001 08:25:42 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Jan Harkes <jaharkes@cs.cmu.edu>, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: broken VM in 2.4.10-pre9
Date: Mon, 17 Sep 2001 14:33:12 +0200
X-Mailer: KMail [version 1.3.1]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010917003422Z16197-2757+375@humbolt.nl.linux.org> <Pine.LNX.4.33.0109161738110.1054-100000@penguin.transmeta.com> <20010917011157.A22989@cs.cmu.edu>
In-Reply-To: <20010917011157.A22989@cs.cmu.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010917122559Z16382-2758+129@humbolt.nl.linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On September 17, 2001 07:11 am, Jan Harkes wrote:
> As far as I can understand the _original_ design on which the current VM
> is based, aging only occurs to pages on the active 'ring', the inactive
> lists are basically LRU-ordered victim caches. Pages are unmapped before
> they go to the inactive_dirty list and buffers are flushed before they
> can go to inactive_clean.
>
> Ofcourse both the used_once changes and -pre10 sort of flushed these
> designs down the toilet by putting mapped pages on the inactive_dirty
> list and turning the active list into an LRU.

The active list is *supposed* to approximate an LRU.  The inactive lists
are not LRUs but queues, and have always been.

The inactive queues have always had both mapped and unmapped pages on
them. The reason for unmapping a swap cache page page when putting it
on the inactive queue is to give it some time to be rescued, since we
otherwise have no information about its short-term activity because
we have no way of accessing the hardware dirty bit given the physical
page on the lru.  A second reason for unmapping it is, we don't have
any choice.  The point where we place it on the inactive queue is the
last point where we're able to find its userspace page table entry.

<paid advertisement>
We'd be able to avoid unmapping swap cache pages with Rik's rmap
patch because we can easily check the hardware referenced bit before
finally evicting the page.  Plus, and I hope I'm interpreting this
correctly, we can allocate the swap slot and perform swap clustering
at that time, greatly simplifying the swapout code.
</paid advertisment> ;-)

Drifting a little further offtopic.  As far as I can tell, there's no 
fundamental reason why we cannot make the current strategy work as 
well as Rik's rmaps probably will, with some more blood, sweat and
code study.  On the other hand, Matt Dillon, the reigning champion of
virtual memory managment, was quite firm in stating that we should
drop the current virtually scanning strategy in favor of 100%
physical scanning as BSD uses, relying on reverse mapping.

   http://mail.nl.linux.org/linux-mm/2000-05/msg00419.html
   (Matt Dillon holds forth on the design of BSD's memory manager)

--
Daniel
