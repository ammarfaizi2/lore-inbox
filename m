Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129501AbRCAEPQ>; Wed, 28 Feb 2001 23:15:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129502AbRCAEPH>; Wed, 28 Feb 2001 23:15:07 -0500
Received: from www.wen-online.de ([212.223.88.39]:25869 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S129501AbRCAEOz>;
	Wed, 28 Feb 2001 23:14:55 -0500
Date: Thu, 1 Mar 2001 05:14:35 +0100 (CET)
From: Mike Galbraith <mikeg@wen-online.de>
X-X-Sender: <mikeg@mikeg.weiden.de>
To: Rik van Riel <riel@conectiva.com.br>
cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [patch][rfc][rft] vm throughput 2.4.2-ac4
In-Reply-To: <Pine.LNX.4.33.0102281232240.5502-100000@duckman.distro.conectiva>
Message-ID: <Pine.LNX.4.33.0103010226370.1889-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Feb 2001, Rik van Riel wrote:

> On Wed, 28 Feb 2001, Marcelo Tosatti wrote:
> > On Wed, 28 Feb 2001, Mike Galbraith wrote:
>
> > > That's one reason I tossed it out.  I don't _think_ it should have any
> > > negative effect on other loads, but a test run might find otherwise.
> >
> > Writes are more expensive than reads. Apart from the aggressive read
> > caching on the disk, writes have limited caching or no caching at all if
> > you need security (journalling, for example). (I'm not sure about write
> > caching details, any harddisk expert?)
>
> I suspect Mike needs to change his benchmark load a little
> so that it dirties only 10% of the pages (might be realistic
> for web and/or database loads).

Asking the user to not dirty so many pages is wrong.  My benchmark
load is many compute intensive tasks which each dirty a few pages
while doing real work.  It would be unrealistic if it just dirtied
pages as fast as possible to intentionally jam up the vm, but it
doesn't do that.

> At that point, you should be able to see that doing writes
> all the time can really mess up read performance due to extra
> introduced seeks.

The fact that writes are painful doesn't change the fact that data
must be written in order to free memory and proceed.  Besides, the
elevator is supposed to solve that not the allocator.. or?

> We probably want some in-between solution (like FreeBSD has today).
> The first time they see a dirty page, they mark it as seen, the
> second time they come across it in the inactive list, they flush it.
> This way IO is still delayed a bit and not done if there are enough
> clean pages around.

(delayed write is fine, but I'll be upset if vmlinux doesn't show up
after I buy more ram;)

> Another solution would be to do some more explicit IO clustering and
> only flush _large_ clusters ... no need to invoke extra disk seeks
> just to free a single page, unless you only have single pages left.

This sounds good.. except I keep thinking about the elevator.  Clusters
disappear as soon as they hit the queues so clustering at the vm level
doesn't make any sense to me.  Where pages actually land is a function
of the fs, and that gets torn down even further by the elevator.  If
you submit pages one at a time, the plug will build clusters for you.

I don't think that the vm has the information needed to make decisions
like this nor the responsibility to do so.  It's a customer of the I/O
layers beneath it.

	-Mike

