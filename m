Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267625AbSLFV7M>; Fri, 6 Dec 2002 16:59:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267627AbSLFV7M>; Fri, 6 Dec 2002 16:59:12 -0500
Received: from 216-42-72-140.ppp.netsville.net ([216.42.72.140]:33674 "EHLO
	tiny.suse.com") by vger.kernel.org with ESMTP id <S267625AbSLFV7L>;
	Fri, 6 Dec 2002 16:59:11 -0500
Subject: Re: [patch] fix the ext3 data=journal unmount bug
From: Chris Mason <mason@suse.com>
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: Andrew Morton <akpm@digeo.com>, lkml <linux-kernel@vger.kernel.org>,
       ext3 users list <ext3-users@redhat.com>
In-Reply-To: <1039209773.5300.84.camel@sisko.scot.redhat.com>
References: <3DF0F69E.FF0E513A@digeo.com> <1039203287.9244.97.camel@tiny> 
	<3DF0FE4F.5F473D5E@digeo.com> 
	<1039204675.5301.55.camel@sisko.scot.redhat.com> 
	<1039206858.9244.130.camel@tiny> 
	<1039209773.5300.84.camel@sisko.scot.redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 06 Dec 2002 17:07:00 -0500
Message-Id: <1039212420.9244.173.camel@tiny>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-12-06 at 16:22, Stephen C. Tweedie wrote:
> Hi,
> 
> On Fri, 2002-12-06 at 20:34, Chris Mason wrote:
> 
> > The bulk of the sync(2) will be async though, since most of the io is
> > actually writing dirty data buffers out.  We already do that in two
> > stages.
> 
> Not with data journaling.  That's the whole point: the VFS assumes too
> much about where the data is being written, when.

But with data journaling, there's a limited amount data pending that
needs to be sent to the log.  It isn't like the data pages in the
data=writeback, where there might be gigs and gigs worth of pages.  

Most data=journal setups are for synchronous writes, where the
transactions will be small, so sending things to the log won't take
long.

> 
> > For 2.5, if an FS really wanted a two stage sync for it's non-data
> > pages
> 
> But it's data that is the problem.  For sync() semantics,
> data-journaling only requires that the pages have hit the journal.  For
> umount, it is critical that we complete the final writeback before
> destroying the inode lists.

Well, I was trying to find a word for pages involved w/the journal and
failed ;-)  My only real point is we can add an async sync without
changing the way supers get processed.

It seems like a natural progression to start adding journal address
spaces to deal with this instead of extra stuff in the super code, where
locking and super flag semantics make things sticky.

-chris


