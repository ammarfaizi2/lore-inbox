Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263537AbTLPFmj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Dec 2003 00:42:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263618AbTLPFmj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Dec 2003 00:42:39 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:14989
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S263537AbTLPFmg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Dec 2003 00:42:36 -0500
From: Rob Landley <rob@landley.net>
Reply-To: rob@landley.net
To: =?iso-8859-1?q?J=F6rn=20Engel?= <joern@wohnheim.fh-wedel.de>
Subject: Re: Is there a "make hole" (truncate in middle) syscall?
Date: Mon, 15 Dec 2003 23:43:10 -0600
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
References: <20031211125806.B2422@hexapodia.org> <200312121537.42303.rob@landley.net> <20031215124752.GA27005@wohnheim.fh-wedel.de>
In-Reply-To: <20031215124752.GA27005@wohnheim.fh-wedel.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200312152343.11321.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 15 December 2003 06:47, Jörn Engel wrote:
> On Fri, 12 December 2003 15:37:42 -0600, Rob Landley wrote:
> > On Friday 12 December 2003 08:24, Jörn Engel wrote:
> > > > ...and it sucks.  Same problem as with updatedb - 99% of all work is
> > > > bogus, but you don't know which 99%, because the one knowing about
> > > > it, the kernel, doesn't tell you a thing.
> > >
> > > Actually, updatedb sucks even worse.  The database is notoriously
> > > outdated and each run of updatedb has the effect of flushing the
> > > cache.  Because of the cache-flushing effect, you cannot even run it
> > > with maximum niceness.  Running it still hurts you *afterwards*.
> > >
> > > Same goes for you userland daemon without kernel support.
> >
> > 1) The date optimization, only looking at files newer than the last run,
> > means you can avoid looking at 90% of the filesystem.
>
> And how do you figure out the date?  ;)

You look at the dentry.  Yes, you have to traverse the filesystem.  There are 
a number of things that care about traversing the filesystem, including 
scheduled backups, updatedb, and potentially this thing.  I realise that you 
believe nobody should ever do this.  I don't care.

> > 2) If drop-behind ever gets working, life is good for this sort of thing.
> >  If not, there's always O_DIRECT or its replacement (whatever Linus and
> > the oracle guy were arguing about last month)...
>
> Not sure what drop-behind is.  Sounds interesting.

Google for it.

> Anyway, what updatedb, userspace defragmenters etc. need is a
> notification, what has changed.

Most of this infrastructure is there already.  Documentation/dnotify.txt.

> Without this notification, they have
> to look at everything and figure it out themselves.  Ask the network
> people why select doesn't scale too well

Were you here for the discussion of I/O completion ports as a potential 
solution to the "thundering herd" problem a few years ago?  Haven't checked 
to see how similar epoll is, I haven't had a scalability bottleneck in that 
area recently...

> - updatedb is even worse
> because it doesn't even notice that *anything* has changed, much less
> what change happened.

You don't WANT it to.  You want to batch up the work so that if a file changes 
every thirty seconds you're not constantly being woken up to deal with it 
again!

> O_DIRECT, O_STREAMING or O_WHATEVER is also a different beast.  With
> streaming media, there is no way to avoid touching the data in the
> first place.  If there was, we could do even better, but there isn't.

If you need to look at the contents of the disk (to check for the runs of null 
bytes), then you need to look at the contents of the disk.  Once you've 
identified data you need to load in, if you don't want to push everything 
else out of cache, you should be able to give some kind of hint that it 
shouldn't keep this data around.  The new ionice work is at least a step in 
this direction, although it doesn't address this particular problem, and I 
believe the dentry cache is a different beast than the page cache...

> For updatedb there is.

I'm not talking about updatedb.

> Jörn

Rob
