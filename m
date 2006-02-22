Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932143AbWBVN4d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932143AbWBVN4d (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 08:56:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932175AbWBVN4d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 08:56:33 -0500
Received: from smtp.osdl.org ([65.172.181.4]:2944 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932143AbWBVN4c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 08:56:32 -0500
Date: Wed, 22 Feb 2006 05:55:35 -0800
From: Andrew Morton <akpm@osdl.org>
To: Robin Holt <holt@sgi.com>
Cc: linux-kernel@vger.kernel.org, rml@novell.com, arnd@arndb.de,
       ttb@tentacle.dhs.org, hch@lst.de
Subject: Re: udevd is killing file write performance.
Message-Id: <20060222055535.540eba86.akpm@osdl.org>
In-Reply-To: <20060222134250.GE20786@lnx-holt.americas.sgi.com>
References: <20060222134250.GE20786@lnx-holt.americas.sgi.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robin Holt <holt@sgi.com> wrote:
>
> 
> I have a customer application which sees a significant performance
> degradation when run with udevd running.  This appears to be due to:
> 
> 
> void inotify_dentry_parent_queue_event(struct dentry *dentry, u32 mask,
>                                        u32 cookie, const char *name)
> {
> ...
>         if (!atomic_read (&inotify_watches))
>                 return;
> 
>         spin_lock(&dentry->d_lock);
> 
> The particular application is a 512 thread application.  When run with
> udevd turned off the application finishes in about 6 seconds.  With it
> turned on, the appliction takes minutes (I think we timed it to around
> 22 minutes, but we have not been patient enough to wait it through to
> the end in some time).  This is being run on a 512cpu system, but there
> is a noticable performance hit on smaller systems as well.
> 
> As far as I can tell, the application has multiple threads writing
> different portions of the same file, but the customer is still working
> on providing a simplified test case.

Are you able to work out whether inotify_inode_watched(inode) is returning
true?

Probably it isn't, and everyone is hammering dentry->d_lock.  You'll
probably find that if all those processes were accessing the shared file
via separate filenames (all hardlinked to the same file), things would
improve.

I get a screwed feeling about this.  We have to take d_lock so we can get
at the parent dentry.  Otherwise we have obscure races with rename and
unlink.

> I know _VERY_ little about filesystems.  udevd appears to be looking
> at /etc/udev/rules.d.  This bumps inotify_watches to 1.  The file
> being written is on an xfs filesystem mounted at a different mountpoint.
> Could the inotify flag be moved from a global to a sb (or something
> finer) point and therefore avoid taking the dentry->d_lock when there
> is no possibility of a watch event being queued.

umm, yes, that's a bit of a palliative, but we could probably move
inotify_watches into dentry->d_inode->i_sb.

