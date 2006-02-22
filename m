Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030336AbWBVXUJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030336AbWBVXUJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 18:20:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030339AbWBVXUI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 18:20:08 -0500
Received: from smtp.osdl.org ([65.172.181.4]:3206 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030336AbWBVXUG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 18:20:06 -0500
Date: Wed, 22 Feb 2006 15:12:23 -0800
From: Andrew Morton <akpm@osdl.org>
To: john@johnmccutchan.com
Cc: holt@sgi.com, linux-kernel@vger.kernel.org, rml@novell.com, arnd@arndb.de,
       hch@lst.de
Subject: Re: udevd is killing file write performance.
Message-Id: <20060222151223.5c9061fd.akpm@osdl.org>
In-Reply-To: <1140648776.1729.5.camel@localhost.localdomain>
References: <20060222134250.GE20786@lnx-holt.americas.sgi.com>
	<1140626903.13461.5.camel@localhost.localdomain>
	<20060222175030.GB30556@lnx-holt.americas.sgi.com>
	<1140648776.1729.5.camel@localhost.localdomain>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John McCutchan <john@johnmccutchan.com> wrote:
>
> On Wed, 2006-22-02 at 11:50 -0600, Robin Holt wrote:
> > On Wed, Feb 22, 2006 at 11:48:23AM -0500, John McCutchan wrote:
> > > On Wed, 2006-22-02 at 07:42 -0600, Robin Holt wrote:
> > > > 
> > > > I know _VERY_ little about filesystems.  udevd appears to be looking
> > > > at /etc/udev/rules.d.  This bumps inotify_watches to 1.  The file
> > > > being written is on an xfs filesystem mounted at a different mountpoint.
> > > > Could the inotify flag be moved from a global to a sb (or something
> > > > finer) point and therefore avoid taking the dentry->d_lock when there
> > > > is no possibility of a watch event being queued.
> > > 
> > > We could do this, and avoid the problem, but only in this specific
> > > scenario. The file being written is on a different mountpoint but whats
> > > to stop a different app from running inotify on that mount point?
> > > Perhaps the program could be altered instead? 
> > 
> > Looking at fsnotify_access() I think we could hit the same scenario.
> > Are you proposing we alter any appliction where multiple threads read
> > a single data file to first make a hard link to that data file and each
> > read from their private copy?  I don't think that is a very reasonable
> > suggestion.
> 
> Listen, what I'm saying is that your suggested change will only help in
> one specific scenario, and simply having inotify used on the 'wrong'
> mountpoint will get you back to square one. So, your suggestion isn't
> really a solution, but a way of avoiding the real problem. What I *am*
> suggesting is that a real fix be found,

I have a bad feeling about this one.  It'd be nice to have an exact
understanding of the problen source, but if it's just lots of traffic on
->d_lock we're kinda stuck.  I don't expect we'll run off and RCUify
d_parent or turn d_lock into a seq_lock or anything liek that.

Then again, maybe making d_lock an rwlock _will_ help - if this workload is
also hitting tree_lock (Robin?) and we're not seeing suckiness due to that
then perhaps the rwlock is magically helping.


> instead of your hack.

It's not a terribly bad hack - it's just poor-man's hashing, and it's
reasonably well-suited to the sorts of machines and workloads which we
expect will hit this problem.
