Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265725AbSLFU02>; Fri, 6 Dec 2002 15:26:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267586AbSLFU01>; Fri, 6 Dec 2002 15:26:27 -0500
Received: from 216-42-72-140.ppp.netsville.net ([216.42.72.140]:34697 "EHLO
	tiny.suse.com") by vger.kernel.org with ESMTP id <S265725AbSLFU0Z>;
	Fri, 6 Dec 2002 15:26:25 -0500
Subject: Re: [patch] fix the ext3 data=journal unmount bug
From: Chris Mason <mason@suse.com>
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: Andrew Morton <akpm@digeo.com>, lkml <linux-kernel@vger.kernel.org>,
       ext3 users list <ext3-users@redhat.com>
In-Reply-To: <1039204675.5301.55.camel@sisko.scot.redhat.com>
References: <3DF0F69E.FF0E513A@digeo.com> <1039203287.9244.97.camel@tiny> 
	<3DF0FE4F.5F473D5E@digeo.com> 
	<1039204675.5301.55.camel@sisko.scot.redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 06 Dec 2002 15:34:18 -0500
Message-Id: <1039206858.9244.130.camel@tiny>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-12-06 at 14:57, Stephen C. Tweedie wrote:
> Hi,
> 
> On Fri, 2002-12-06 at 19:45, Andrew Morton wrote:
> 
> > > I see what ext3 gains from your current patch in the unmount case, but
> > > the sync case is really unchanged because of interaction with kupdate.
> > 
> > True.  And I'd like /bin/sync to _really_ be synchronous because
> > I use `reboot -f' all the time.  Even though SuS-or-POSIX say that
> > sync() only needs to _start_ the IO.  That's rather silly.
> 
> But at the same time I'd like to avoid sync becoming serialised on its
> writes.  If you've got a lot of filesystems mounted, doing each
> filesystem's sync sequentially and synchronously is going to be a lot
> slower than allowing async syncs.  In other words, for sync(2) we really
> want async commit submission followed by a synchronous wait for
> completion.  And that's probably more churn than I'd like to see at this
> stage for 2.4.

The bulk of the sync(2) will be async though, since most of the io is
actually writing dirty data buffers out.  We already do that in two
stages.

For 2.5, if an FS really wanted a two stage sync for it's non-data
pages, it could put a locked page onto one of the lists that
sync_inodes(1) will catch and wait for.  There are lots of other ways of
course, but there's already a framework for sync to wait on pages.

For 2.4, an FS async sync function could toss a locked buffer head into
the locked buffer lru list, and unlock when the commit is complete.

Neither idea is as clean as a real aio interface, but all the
infrastructure is already there. 

Also, I think async sync support is a different feature than allowing
the FS to know the difference between kupdate periodic writes and
syncs/unmounts.

-chris


