Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130029AbRCAUf6>; Thu, 1 Mar 2001 15:35:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130008AbRCAUfR>; Thu, 1 Mar 2001 15:35:17 -0500
Received: from www.wen-online.de ([212.223.88.39]:40197 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S129932AbRCAUe0>;
	Thu, 1 Mar 2001 15:34:26 -0500
Date: Thu, 1 Mar 2001 21:33:59 +0100 (CET)
From: Mike Galbraith <mikeg@wen-online.de>
X-X-Sender: <mikeg@mikeg.weiden.de>
To: Rik van Riel <riel@conectiva.com.br>
cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [patch][rfc][rft] vm throughput 2.4.2-ac4
In-Reply-To: <Pine.LNX.4.33.0103011230480.1961-100000@duckman.distro.conectiva>
Message-ID: <Pine.LNX.4.33.0103012021470.1542-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Mar 2001, Rik van Riel wrote:

> On Thu, 1 Mar 2001, Mike Galbraith wrote:
> > On Wed, 28 Feb 2001, Rik van Riel wrote:
> > > On Wed, 28 Feb 2001, Marcelo Tosatti wrote:
> > > > On Wed, 28 Feb 2001, Mike Galbraith wrote:
> > >
> > > > > That's one reason I tossed it out.  I don't _think_ it should have any
> > > > > negative effect on other loads, but a test run might find otherwise.
> > > >
> > > > Writes are more expensive than reads. Apart from the aggressive read
> > > > caching on the disk, writes have limited caching or no caching at all if
> > > > you need security (journalling, for example). (I'm not sure about write
> > > > caching details, any harddisk expert?)
> > >
> > > I suspect Mike needs to change his benchmark load a little
> > > so that it dirties only 10% of the pages (might be realistic
> > > for web and/or database loads).
> >
> > Asking the user to not dirty so many pages is wrong.  My benchmark
> > load is many compute intensive tasks which each dirty a few pages
> > while doing real work.  It would be unrealistic if it just dirtied
> > pages as fast as possible to intentionally jam up the vm, but it
> > doesn't do that.
>
> Asking you to test a different kind of workload is wrong ??

No no no and again no (perhaps I misread that bit).  But otoh, you
haven't tested the patch I sent in good faith.  I sent it because I
have thought about it.  I may be wrong in my interpretation of the
results, but those results were thought about.. and they exist.

> The kind of load I described _is_ realistic, think for example
> about ftp/www/MySQL servers...

Yes.  My favorite test load is also realistic.

> > > At that point, you should be able to see that doing writes
> > > all the time can really mess up read performance due to extra
> > > introduced seeks.
> >
> > The fact that writes are painful doesn't change the fact that data
> > must be written in order to free memory and proceed.  Besides, the
> > elevator is supposed to solve that not the allocator.. or?
>
> But if the amount of dirtied pages is _small_, it means that we can
> allow the reads to continue uninterrupted for a while before we
> flush all dirty pages in one go...

"If wishes were horses, beggers would ride."

There is no mechanysm in place that ensures that dirty pages can't
get out of control, and they do in fact get out of control, and it
is exaserbated (mho) by attempting to define 'too much I/O' without
any information to base this definition upon.

> Also, the elevator can only try to optimise whatever you throw at
> it. If you throw random requests at the elevator, you cannot expect
> it to do ANY GOOD ...

This is a very good point (which I will think upon).  I ask you this
in return.  Why do you think that the random junk you throw at the
elevator is different than the random junk I throw at it? ;-)  I see
no difference at all.. it's the same exact junk.  (it's junk because
neither of us knows that it will be optimizable.. it really is a
random bunch of pages because we have ZERO information concerning
the origins, destinations nor informational content of the pages we're
pushing.  We have no interest [only because we aren't clever enough
to be interested] in these things.)

> The merging at the elevator level only works if the requests sent to
> it are right next to each other on disk. This means that randomly
> sending stuff to disk really DOES DESTROY PERFORMANCE and there's
> nothing the elevator could ever hope to do about that.

True to some (very real) extent because of the limited buffering of
requests.  However, I can not find any useful information that the
vm is using to guarantee the IT does not destroy performance by your
own definition.  If it's there and I'm just missing it, I'd thank
you heartily if you'd hit me up side the head with a clue-x-4 ;-)

> > > We probably want some in-between solution (like FreeBSD has today).
> > > The first time they see a dirty page, they mark it as seen, the
> > > second time they come across it in the inactive list, they flush it.
> > > This way IO is still delayed a bit and not done if there are enough
> > > clean pages around.
> >
> > (delayed write is fine, but I'll be upset if vmlinux doesn't show up
> > after I buy more ram;)
>
> Writing out of old data is a task independent of the VM. This is a
> job done by kupdate. The only thing the VM does is write pages out
> earlier when it's under memory pressure.

I was joking.

> > > Another solution would be to do some more explicit IO clustering and
> > > only flush _large_ clusters ... no need to invoke extra disk seeks
> > > just to free a single page, unless you only have single pages left.
> >
> > This sounds good.. except I keep thinking about the elevator.
> > Clusters disappear as soon as they hit the queues so clustering
> > at the vm level doesn't make any sense to me.
>
> You should think about the elevator a bit more. Feel for the poor
> thing and try to send it requests it can actually do something
> useful with ;)

I will, and I hope you can help me out with a little more food for
thought.

	-Mike

