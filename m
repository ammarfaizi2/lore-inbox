Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750771AbWIARQZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750771AbWIARQZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 13:16:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750795AbWIARQZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 13:16:25 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:36750 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750771AbWIARQY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 13:16:24 -0400
Subject: Re: [patch 3/9] Guest page hinting: volatile page cache.
From: Dave Hansen <haveblue@us.ibm.com>
To: schwidefsky@de.ibm.com
Cc: Andy Whitcroft <apw@shadowen.org>, linux-kernel@vger.kernel.org,
       virtualization@lists.osdl.org, akpm@osdl.org, nickpiggin@yahoo.com.au,
       frankeh@watson.ibm.com
In-Reply-To: <1157129762.21733.63.camel@localhost>
References: <20060901110948.GD15684@skybase>
	 <1157122667.28577.69.camel@localhost.localdomain>
	 <1157124674.21733.13.camel@localhost>  <44F8563B.3050505@shadowen.org>
	 <1157126640.21733.43.camel@localhost>
	 <1157127483.28577.117.camel@localhost.localdomain>
	 <1157127943.21733.52.camel@localhost>
	 <1157128634.28577.139.camel@localhost.localdomain>
	 <1157129762.21733.63.camel@localhost>
Content-Type: text/plain
Date: Fri, 01 Sep 2006 10:16:10 -0700
Message-Id: <1157130970.28577.150.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-09-01 at 18:56 +0200, Martin Schwidefsky wrote:
> On Fri, 2006-09-01 at 09:37 -0700, Dave Hansen wrote:
> > Can you give me the sequence of events that occur so that we need to
> > set, then check PG_discarded?  I'm not getting it.
> > 
> > 1. there is good data in a page
> > ...
> > 50.  ... and PG_discarded gets set
> > ...
> > 99.  We check PG_discarded and ...
> 
> Ok, here we go:
> 0) there is good data in a page
> 1) the host scans for pages to reclaim and selects a page of a
> particular guest
> 2) the host checks the page state and decides to either swap the page or
> discard it
> 3) nothing happens for a long time
> 4) the guest comes around and tries to access the long gone page
> 5) the host gets a fault because the page is gone from the hosts page
> table for the guest system
> 6) the host delivers a discard fault to the guest
> 7) the architecture dependent fault handler gets a page reference for
> the discarded page (tricky for s390)
> 8) page_discard is called which locks the page and does a
> TestSetPageDiscarded. If the bit has not been set yet the page is
> removed from the page cache. There can still be page references around.
> 
> Concurrent to 5-8 another cpu could be just be removing the page from
> page cache as well. Without the check for the discarded bit the page
> would get removed twice. This does nasty things to reference counting,
> mapping->nrpages, ...

This feels like something that can be done with RCU.  The
__page_discard() is the write operation, right?  So, take an rcu write
lock inside of the page discard function, and read locks over the
current places where PG_discarded is set.

That should make sure that the discard operation itself can't be done
concurrently with one of the __remove_from*() operations.  Once the
write lock has been acquired, you just check page->mapping to see if the
a __remove_from*() operation has occurred while you waited.

> Ouch, I understand what you are trying to tell me. The struct page
> entries that cover the mem_map array itself has free bits we could try
> to cannibalize.

Right.  It is certainly ugly.  I'd much rather have some kind of 

	spin_lock(&lock_array[hash_function(page)]);

thing.

-- Dave

