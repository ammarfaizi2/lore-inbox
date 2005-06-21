Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261676AbVFUEZ0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261676AbVFUEZ0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 00:25:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261673AbVFUEWa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 00:22:30 -0400
Received: from CPE000f6690d4e4-CM00003965a061.cpe.net.cable.rogers.com ([69.193.74.134]:2469
	"EHLO vertex") by vger.kernel.org with ESMTP id S261904AbVFUCmt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 22:42:49 -0400
Subject: Re: [patch] inotify.
From: John McCutchan <ttb@tentacle.dhs.org>
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: Robert Love <rml@novell.com>, Andrew Morton <akpm@osdl.org>,
       Christoph Hellwig <hch@lst.de>, arnd@arndb.de, zab@zabbo.net,
       linux-kernel@vger.kernel.org, viro@parcelfarce.linux.theplanet.co.uk
In-Reply-To: <17079.31644.985407.988980@cse.unsw.edu.au>
References: <1118855899.3949.21.camel@betsy> <42B1BC4B.3010804@zabbo.net>
	 <1118946334.3949.63.camel@betsy> <200506171907.39940.arnd@arndb.de>
	 <20050617175605.GB1981@tentacle.dhs.org>
	 <20050617143334.41a31707.akpm@osdl.org> <1119044430.7280.22.camel@phantasy>
	 <1119052357.7280.24.camel@phantasy>
	 <17079.25741.91251.232880@cse.unsw.edu.au>
	 <1119320137.17767.10.camel@vertex>
	 <17079.31644.985407.988980@cse.unsw.edu.au>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 20 Jun 2005 22:43:51 -0400
Message-Id: <1119321831.18331.8.camel@vertex>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-06-21 at 12:29 +1000, Neil Brown wrote:
> On Monday June 20, ttb@tentacle.dhs.org wrote:
> > On Tue, 2005-06-21 at 10:51 +1000, Neil Brown wrote:
> > > I haven't yet decided if I like it or not, but maybe I have some
> > > useful comments to make...
> > > 
> > > > +
> > > > +Q: What is the design decision behind using an-fd-per-device as
> > > > +opposed to an fd-per-watch?
> > > > +
> > > > +A: An fd-per-watch quickly consumes more file descriptors than
> > > > +are allowed, more fd's than are feasible to manage, and more
> > > > +fd's than are ideally select()-able.  Yes, root can bump the
> > > > +per-process fd limit and yes, users can use epoll, but requiring
> > > > +both is silly and an extraneous requirement.  A watch consumes
> > > > +less memory than an open file, separating the number spaces is
> > > > +thus sensible.  The current design is what user-space developers
> > > > +want: Users open the device, once, and add n watches, requiring
> > > > +but one fd and no twiddling with fd limits.
> > > > +Opening /dev/inotify two thousand times is silly.  If we can
> > > > +implement user-space's preferences cleanly--and we can, the idr
> > > > +layer makes stuff like this trivial--then we should.
> > > > +
> > > 
> > > 
> > > To address the particular points:
> > >  - "An fd-per-watch quickly consumes more file descriptors than
> > >     are allowed"
> > > 
> > >   I note that the current limit if 'wd's is 8192 per user, compared
> > >   with the default 'fd' limit of 1024 per process.  So if a user has
> > >   more than 8 processes making very heavy use of inotify, they would
> > >   be better off with the file-descriptor limit...
> > >   So I don't find this argument convincing.
> > > 
> > >   I would suggest that it be removed, and you put in a separate
> > >   section discussion resource usage and limits.  You could explain why
> > >   you don't use rlimit (probably not a hard case to win) and why the
> > >   sysadmin cannot give different limits to different users (as a
> > >   sys-admin, I would fight that), and why no one user would ever want
> > >   more than about 8 processes using inotify :-)
> > > 
> > 
> > Looking at beagle, it is a single process that can easily watch more
> > than 1024 directories. Beagle would have to work around the 1024 limit
> > by managing processes, each of which watch a fraction of the total
> > watches. PITA. Also, 8192 was an arbitrary choice that seemed big enough
> > for most users needs and all of these limits can be set in sysfs.
> > Checkout /sys/misc/inotify.
> 
> 
> I think you missed my point...
> The FAQ entry which I found unconvincing said
> 
> "Yes, root can bump the per-process fd limit ... but requiring [this]
>  is silly and an extraneous requirement." 
> 
> So when you say "... all of these limits can be set in sysfs", you are
> effectively contradicting the FAQ entry.
> Yes, 1024 is an arbitrary limit.  But so is 8192.
> The argument "We cannot use fd's because the arbitrary limit is lower
> than the arbitrary limit that I want to use" simply doesn't hold
> water.
> There may well be other good arguments against 'fd's, but I'm trying
> to point out that this isn't one of them, and so shouldn't appear in
> this part of the FAQ.
> 

Fair enough. 

But, because the fd limit is established at 1024 and we will want the wd
limit to be much higher than the current fd limit, we do need our own
limit. fd's and wd's represent different things, why confuse the two
limits?

> 
> > 
> > >  -  "more fd's than are feasible to manage,"
> > > 
> > >    It's not clear what this means.  The program will still need to
> > >    manage lots of 'wd's.  How is this different from handling 'fd's?
> > >    The only 'manage'ment issue I could come up with is the hassle of
> > >    shepherding all these 'wd's through a 'fork', only to close them
> > >    before an 'exec'.  Is that what you mean?  If so it would help to
> > >    make it more explicit.
> > > 
> > 
> > The program doesn't really have to manage the wd's. A program simply
> > needs a map from wd to it's own structure.
> 
> So I think you are agreeing with me that the text "more fd's than are
> feasible to manage," should be removed from the FAQ?  Thanks.
> 

No, I'm not. An application would have to manage them if they were fd's.
My select() example in the previous mail explains.

> > 
> > Assume for a moment that we had chosen a fd-as-watch approach. Now take
> > beagle, which has tons of watches. Every time beagle goes through it's
> > loop, it has to add each of those watch-fd's to the select table, then
> > check for each one afterwards. It's pretty easy to see how this is
> > unmanageable and a waste of CPU time. 
> 
> I don't think there can be any question that having to tell select
> about each 'watch' is unreasonable.
> 

And if watches were represented as fd's we would have to do just that.

> > 
> > Why bother though? The idr layer lets us have a integer that maps to a 
> > data structure in kernel space, pretty much for free. 
> > 
> Because some people think that creating a whole new abstraction when
> we have one (fds) that seem to fit the bill, is the wrong thing to do.
> I don't currently have an opinion on that, but I am trying to explore
> options with a bit of lateral thinking.

I appreciate that you are trying to explore alternatives. I have done
the same, and come to the conclusion that the current interface is the
best approach. It is friendly to both the kernel and the user space
programs which use inotify.

-- 
John McCutchan <ttb@tentacle.dhs.org>
