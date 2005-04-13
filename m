Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261298AbVDMK3h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261298AbVDMK3h (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Apr 2005 06:29:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261297AbVDMK3b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Apr 2005 06:29:31 -0400
Received: from mx1.redhat.com ([66.187.233.31]:47562 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261294AbVDMK3O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Apr 2005 06:29:14 -0400
Subject: Re: ext3 allocate-with-reservation latencies
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Mingming Cao <cmm@us.ibm.com>
Cc: Ingo Molnar <mingo@elte.hu>, Lee Revell <rlrevell@joe-job.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Stephen Tweedie <sct@redhat.com>
In-Reply-To: <1113348434.4125.54.camel@dyn318043bld.beaverton.ibm.com>
References: <1112673094.14322.10.camel@mindpipe>
	 <20050405041359.GA17265@elte.hu>
	 <1112765751.3874.14.camel@localhost.localdomain>
	 <20050407081434.GA28008@elte.hu>
	 <1112879303.2859.78.camel@sisko.sctweedie.blueyonder.co.uk>
	 <1112917023.3787.75.camel@dyn318043bld.beaverton.ibm.com>
	 <1112971236.1975.104.camel@sisko.sctweedie.blueyonder.co.uk>
	 <1112983801.10605.32.camel@dyn318043bld.beaverton.ibm.com>
	 <1113220089.2164.52.camel@sisko.sctweedie.blueyonder.co.uk>
	 <1113244710.4413.38.camel@localhost.localdomain>
	 <1113249435.2164.198.camel@sisko.sctweedie.blueyonder.co.uk>
	 <1113288087.4319.49.camel@localhost.localdomain>
	 <1113304715.2404.39.camel@sisko.sctweedie.blueyonder.co.uk>
	 <1113348434.4125.54.camel@dyn318043bld.beaverton.ibm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1113388142.3019.12.camel@sisko.sctweedie.blueyonder.co.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-9) 
Date: Wed, 13 Apr 2005 11:29:02 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 2005-04-13 at 00:27, Mingming Cao wrote:

> > I wonder if there's not a simple solution for this --- mark the window
> > as "provisional", and if any other task tries to allocate in the space
> > immediately following such a window, it needs to block until that window
> > is released.

> Sounds interesting. However that implies we need a write lock to mark
> the window as provisional and block other files looking for windows near
> it: we need to insert the provisional window into the tree and then mark
> it as a temporary window, to really let other file notice this kind of
> "hold".

We need a lock for the tree modification, yes.

> I wonder if the benefit of read/write lock is worth all the hassles now.

The point of the provisional window is that you don't need read/write
locks at all.  The provisional window lets you unlock the tree
completely while you do the bitmap scan, so there's really no reason to
have rwlocks for the tree any more.

> If the new window's neighbor stays the same, we only need to roll
> forward once.  If not, after a successful scan, we need to grab the
> write lock, and make sure the window is still there.

When we take the provisional window, we can make a note of how much
space we have before the next window.  And because all future allocators
will stall if they try to allocate at this point due to the provisional
window, we know that that space will remain outside any other window
until we come to fix the provisional window and potentially roll it
forward to the space we found.

>  If we dropped the
> lock without holding the new space, we have to search the whole tree
> again to find out if the space is still there

As long as the space is within the area between the provisional window
and its successor, we don't need to do that.  (It gets more complex if
the bitmap search returns a bit _beyond_ the next window, though.)

> Also I am concerned about the possible
> starvation on writers.

In what way?

> I am thinking, maybe back to the spin_lock is not that bad with the
> "mark provisional" suggest you made?

Right, that was the intent --- sorry if I didn't make it clear. 

>  It allows us to mark the new space
> as provisional if we find a new space(prevent other window searching run
> into the same neighborhood). We could release the lock and scan the
> bitmap without worry about the new space will be taking by others.

Exactly.

Note that there _is_ some additional complexity here.  It's not entirely
free.  Specifically, if we have other tasks waiting on our provisional
window, then we need to be very careful about the life expectancy of the
wait queues involved, so that if the first task fixes its window and
then deletes it before the waiters have woken up, they don't get
confused by the provisional window vanishing while being waited for.

The easy solution is a global wait queue for that, but that doesn't
scale well.  The complex solution is a per-window wait queue and
reference count, which is obviously a bit of bloat, though probably
worth it for the high-load case.

Cheers,
 Stephen

