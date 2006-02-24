Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932220AbWBXAPX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932220AbWBXAPX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 19:15:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932216AbWBXAPX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 19:15:23 -0500
Received: from smtp.osdl.org ([65.172.181.4]:50050 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932210AbWBXAPU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 19:15:20 -0500
Date: Thu, 23 Feb 2006 16:14:25 -0800
From: Andrew Morton <akpm@osdl.org>
To: john@johnmccutchan.com
Cc: holt@sgi.com, linux-kernel@vger.kernel.org, rml@novell.com, arnd@arndb.de,
       hch@lst.de
Subject: Re: udevd is killing file write performance.
Message-Id: <20060223161425.4388540e.akpm@osdl.org>
In-Reply-To: <1140651662.2985.2.camel@localhost.localdomain>
References: <20060222134250.GE20786@lnx-holt.americas.sgi.com>
	<1140626903.13461.5.camel@localhost.localdomain>
	<20060222175030.GB30556@lnx-holt.americas.sgi.com>
	<1140648776.1729.5.camel@localhost.localdomain>
	<20060222151223.5c9061fd.akpm@osdl.org>
	<1140651662.2985.2.camel@localhost.localdomain>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John McCutchan <john@johnmccutchan.com> wrote:
>
> ...
> > 
> > I have a bad feeling about this one.  It'd be nice to have an exact
> > understanding of the problen source, but if it's just lots of traffic on
> > ->d_lock we're kinda stuck.  I don't expect we'll run off and RCUify
> > d_parent or turn d_lock into a seq_lock or anything liek that.
> > 
> > Then again, maybe making d_lock an rwlock _will_ help - if this workload is
> > also hitting tree_lock (Robin?) and we're not seeing suckiness due to that
> > then perhaps the rwlock is magically helping.
> > 
> > 
> > > instead of your hack.
> > 
> > It's not a terribly bad hack - it's just poor-man's hashing, and it's
> > reasonably well-suited to the sorts of machines and workloads which we
> > expect will hit this problem.
> > 
> 
> If this is as good as it gets, here is a patch (totally untested).
> 
> ...
> @@ -538,7 +537,7 @@
>  	struct dentry *parent;
>  	struct inode *inode;
>  
> -	if (!atomic_read (&inotify_watches))
> +	if (!atomic_read (&dentry->d_sb->s_inotify_watches))
>  		return;
>  

What happens here if we're watching a mountpoint - the parent is on a
different fs?
