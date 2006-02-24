Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932580AbWBXEaT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932580AbWBXEaT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 23:30:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932587AbWBXEaT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 23:30:19 -0500
Received: from smtp102.rog.mail.re2.yahoo.com ([206.190.36.80]:50567 "HELO
	smtp102.rog.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S932580AbWBXEaS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 23:30:18 -0500
Date: Fri, 24 Feb 2006 00:47:26 -0500
From: John McCutchan <john@johnmccutchan.com>
To: Andrew Morton <akpm@osdl.org>
Cc: john@johnmccutchan.com, holt@sgi.com, linux-kernel@vger.kernel.org,
       rml@novell.com, arnd@arndb.de, hch@lst.de
Subject: Re: udevd is killing file write performance.
Message-ID: <20060224054724.GA8593@johnmccutchan.com>
References: <20060222134250.GE20786@lnx-holt.americas.sgi.com> <1140626903.13461.5.camel@localhost.localdomain> <20060222175030.GB30556@lnx-holt.americas.sgi.com> <1140648776.1729.5.camel@localhost.localdomain> <20060222151223.5c9061fd.akpm@osdl.org> <1140651662.2985.2.camel@localhost.localdomain> <20060223161425.4388540e.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060223161425.4388540e.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 23, 2006 at 04:14:25PM -0800, Andrew Morton wrote:
> John McCutchan <john@johnmccutchan.com> wrote:
> >
> > ...
> > > 
> > > I have a bad feeling about this one.  It'd be nice to have an exact
> > > understanding of the problen source, but if it's just lots of traffic on
> > > ->d_lock we're kinda stuck.  I don't expect we'll run off and RCUify
> > > d_parent or turn d_lock into a seq_lock or anything liek that.
> > > 
> > > Then again, maybe making d_lock an rwlock _will_ help - if this workload is
> > > also hitting tree_lock (Robin?) and we're not seeing suckiness due to that
> > > then perhaps the rwlock is magically helping.
> > > 
> > > 
> > > > instead of your hack.
> > > 
> > > It's not a terribly bad hack - it's just poor-man's hashing, and it's
> > > reasonably well-suited to the sorts of machines and workloads which we
> > > expect will hit this problem.
> > > 
> > 
> > If this is as good as it gets, here is a patch (totally untested).
> > 
> > ...
> > @@ -538,7 +537,7 @@
> >  	struct dentry *parent;
> >  	struct inode *inode;
> >  
> > -	if (!atomic_read (&inotify_watches))
> > +	if (!atomic_read (&dentry->d_sb->s_inotify_watches))
> >  		return;
> >  
> 
> What happens here if we're watching a mountpoint - the parent is on a
> different fs?

There are four cases to consider here.

Case 1: parent fs watched and child fs watched
	correct results
Case 2: parent fs watched and child fs not watched
	We may not deliver an event that should be delivered.
Case 3: parent fs not watched and child fs watched
	We take d_lock when we don't need to
Case 4: parent fs not watched and child fs not watched
	correct results

Case 2 screws us. We have to take the lock to even look at the parent's
dentry->d_sb->s_inotify_watches. I don't know of a way around this one.

John
