Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265669AbSKFHRI>; Wed, 6 Nov 2002 02:17:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265670AbSKFHRI>; Wed, 6 Nov 2002 02:17:08 -0500
Received: from packet.digeo.com ([12.110.80.53]:59567 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S265669AbSKFHRG>;
	Wed, 6 Nov 2002 02:17:06 -0500
Message-ID: <3DC8C378.A585B7E9@digeo.com>
Date: Tue, 05 Nov 2002 23:23:36 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.45 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Benjamin LaHaise <bcrl@redhat.com>
CC: Badari Pulavarty <pbadari@us.ibm.com>, linux-aio@kvack.org,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] 2.5.46 AIO support for raw/O_DIRECT
References: <200211060103.gA613a321256@eng2.beaverton.ibm.com> <3DC86DAC.4EBB59C8@digeo.com> <20021106020505.A11610@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 06 Nov 2002 07:23:37.0116 (UTC) FILETIME=[6C12D5C0:01C28565]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin LaHaise wrote:
> 
> On Tue, Nov 05, 2002 at 05:17:32PM -0800, Andrew Morton wrote:
> > Or not proceed with this patch at all.  If this is to be the
> > only code which wishes to perform page list motion at interrupt
> > time, perhaps it's not justifiable?
> >
> > I really don't have a feeling for how valuable this is, nor
> > do I know whether there will be other code which wants to
> > perform page list manipulation at interrupt time.
> 
> I can think of a few other places that would like to perform page
> motion from irq context: anything else doing zero copy or page
> flipping, and more importantly the O(1) vm code that's being worked
> on.  The latter is actually quite important as we've got a number
> of customers running into problems with some of the algorithms in
> the 2.4 kernel where the kernel does not perform any list motion
> from irq context and this results in excess cpu time spent traversing
> lists to see if io has completed.

Interesting.  Would it be possible to get more details on this
problem?

We can shuffle pages around on the LRU from interrupts at present.
But not the address_space lists and buffer stuff.

We could remove the address_space lists and page->list altogether
with a bit of radix tree work.  I started in on that but got distracted.

mapping->clean_pages is actually obsolete now - we never walk it.  It
could be replaced with list_del_init() everywhere.

> > In fact I also don't know where the whole AIO thing sits at
> > present.  Is it all done and finished?  Is there more to come,
> > and if so, what??
> 
> There's more to come.  The bits I'm working on are running in kernel
> context mainly to simplify the copy_*_user case since we don't have
> full zero copy semantics available and coping with pinned pages is
> a challenge in a multiuser system, plus it makes reusing the existing
> networking code a lot easier.  Basically, anything that involves a
> copy of data is likely to be better implemented running in a task to
> get the priority of execution correct, whereas anything involving
> zero copy io is going to want completion from irq or bottom half
> context and hence dirty pages.  Does that make sense?

OK, thanks.  So I guess we make those locks irq-safe.  I don't
expect that would be feasible in 2.4 because of the hold times in 
truncate - it should be OK in 2.5.  I'll do the patch.
