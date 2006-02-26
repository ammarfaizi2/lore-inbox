Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750722AbWBZQzf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750722AbWBZQzf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Feb 2006 11:55:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750791AbWBZQzf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Feb 2006 11:55:35 -0500
Received: from d36-15-41.home1.cgocable.net ([24.36.15.41]:28349 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S1750722AbWBZQze (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Feb 2006 11:55:34 -0500
Subject: Re: udevd is killing file write performance.
From: John McCutchan <john@johnmccutchan.com>
Reply-To: john@johnmccutchan.com
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Andrew Morton <akpm@osdl.org>, holt@sgi.com, linux-kernel@vger.kernel.org,
       rml@novell.com, arnd@arndb.de, hch@lst.de,
       Dipankar Sarma <dipankar@in.ibm.com>
In-Reply-To: <43FEB0BF.6080403@yahoo.com.au>
References: <20060222134250.GE20786@lnx-holt.americas.sgi.com>
	 <1140626903.13461.5.camel@localhost.localdomain>
	 <20060222175030.GB30556@lnx-holt.americas.sgi.com>
	 <1140648776.1729.5.camel@localhost.localdomain>
	 <20060222151223.5c9061fd.akpm@osdl.org>
	 <1140651662.2985.2.camel@localhost.localdomain>
	 <20060223161425.4388540e.akpm@osdl.org>
	 <20060224054724.GA8593@johnmccutchan.com>
	 <20060223220053.2f7a977e.akpm@osdl.org>  <43FEB0BF.6080403@yahoo.com.au>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sun, 26 Feb 2006 11:55:18 -0500
Message-Id: <1140972918.15634.1.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-24-02 at 18:07 +1100, Nick Piggin wrote:
> Andrew Morton wrote:
> > John McCutchan <john@johnmccutchan.com> wrote:
> > 
> >> > > @@ -538,7 +537,7 @@
> >> > >  	struct dentry *parent;
> >> > >  	struct inode *inode;
> >> > >  
> >> > > -	if (!atomic_read (&inotify_watches))
> >> > > +	if (!atomic_read (&dentry->d_sb->s_inotify_watches))
> >> > >  		return;
> >> > >  
> >> > 
> >> > What happens here if we're watching a mountpoint - the parent is on a
> >> > different fs?
> >>
> >> There are four cases to consider here.
> >>
> >> Case 1: parent fs watched and child fs watched
> >> 	correct results
> >> Case 2: parent fs watched and child fs not watched
> >> 	We may not deliver an event that should be delivered.
> >> Case 3: parent fs not watched and child fs watched
> >> 	We take d_lock when we don't need to
> >> Case 4: parent fs not watched and child fs not watched
> >> 	correct results
> >>
> >> Case 2 screws us. We have to take the lock to even look at the parent's
> >> dentry->d_sb->s_inotify_watches. I don't know of a way around this one.
> > 
> > 
> > Yeah.  There are a lot of "screw"s in this thread.
> > 
> > I wonder if RCU can save us - if we do an rcu_read_lock() we at least know
> > that the dentries won't get deallocated.  Then we can take a look at
> > d_parent (which might not be the parent any more).  Once in a million years
> > we might send a false event or miss sending an event, depending on where
> > our dentry suddenly got moved to.  Not very nice, but at least it won't
> > oops.
> > 
> > (hopefully cc's Dipankar)
> 
> I saw this problem when testing my lockless pagecache a while back.
> 
> Attached is a first implementation of what was my idea then of how
> to solve it... note it is pretty rough and I never got around to doing
> much testing of it.
> 
> Basically: moves work out of inotify event time and to inotify attach
> /detach time while staying out of the core VFS.


This looks really good. There might be some corner cases but it looks
like it will solve this problem nicely.

-- 
John McCutchan <john@johnmccutchan.com>
