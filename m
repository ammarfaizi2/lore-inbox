Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932614AbWBXGCK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932614AbWBXGCK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 01:02:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751846AbWBXGCJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 01:02:09 -0500
Received: from smtp.osdl.org ([65.172.181.4]:59080 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751845AbWBXGCI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 01:02:08 -0500
Date: Thu, 23 Feb 2006 22:00:53 -0800
From: Andrew Morton <akpm@osdl.org>
To: John McCutchan <john@johnmccutchan.com>
Cc: john@johnmccutchan.com, holt@sgi.com, linux-kernel@vger.kernel.org,
       rml@novell.com, arnd@arndb.de, hch@lst.de,
       Dipankar Sarma <dipankar@in.ibm.com>
Subject: Re: udevd is killing file write performance.
Message-Id: <20060223220053.2f7a977e.akpm@osdl.org>
In-Reply-To: <20060224054724.GA8593@johnmccutchan.com>
References: <20060222134250.GE20786@lnx-holt.americas.sgi.com>
	<1140626903.13461.5.camel@localhost.localdomain>
	<20060222175030.GB30556@lnx-holt.americas.sgi.com>
	<1140648776.1729.5.camel@localhost.localdomain>
	<20060222151223.5c9061fd.akpm@osdl.org>
	<1140651662.2985.2.camel@localhost.localdomain>
	<20060223161425.4388540e.akpm@osdl.org>
	<20060224054724.GA8593@johnmccutchan.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John McCutchan <john@johnmccutchan.com> wrote:
>
>  > > @@ -538,7 +537,7 @@
>  > >  	struct dentry *parent;
>  > >  	struct inode *inode;
>  > >  
>  > > -	if (!atomic_read (&inotify_watches))
>  > > +	if (!atomic_read (&dentry->d_sb->s_inotify_watches))
>  > >  		return;
>  > >  
>  > 
>  > What happens here if we're watching a mountpoint - the parent is on a
>  > different fs?
> 
>  There are four cases to consider here.
> 
>  Case 1: parent fs watched and child fs watched
>  	correct results
>  Case 2: parent fs watched and child fs not watched
>  	We may not deliver an event that should be delivered.
>  Case 3: parent fs not watched and child fs watched
>  	We take d_lock when we don't need to
>  Case 4: parent fs not watched and child fs not watched
>  	correct results
> 
>  Case 2 screws us. We have to take the lock to even look at the parent's
>  dentry->d_sb->s_inotify_watches. I don't know of a way around this one.

Yeah.  There are a lot of "screw"s in this thread.

I wonder if RCU can save us - if we do an rcu_read_lock() we at least know
that the dentries won't get deallocated.  Then we can take a look at
d_parent (which might not be the parent any more).  Once in a million years
we might send a false event or miss sending an event, depending on where
our dentry suddenly got moved to.  Not very nice, but at least it won't
oops.

(hopefully cc's Dipankar)
