Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261732AbVANAwf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261732AbVANAwf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 19:52:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261727AbVANAuF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 19:50:05 -0500
Received: from peabody.ximian.com ([130.57.169.10]:53435 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S261712AbVANArY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 19:47:24 -0500
Subject: Re: 2.6.10-mm3 scaling problem with inotify
From: Robert Love <rml@novell.com>
To: John Hawkes <hawkes@tomahawk.engr.sgi.com>
Cc: linux-kernel@vger.kernel.org, John McCutchan <ttb@tentacle.dhs.org>
In-Reply-To: <200501132356.j0DNujUY016224@tomahawk.engr.sgi.com>
References: <200501132356.j0DNujUY016224@tomahawk.engr.sgi.com>
Content-Type: text/plain
Date: Thu, 13 Jan 2005 19:49:18 -0500
Message-Id: <1105663758.6027.215.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-01-13 at 15:56 -0800, John Hawkes wrote:

> I believe I've encountered a scaling problem with the inotify code in
> 2.6.10-mm3.
> 
> vfs_read() and vfs_write() (for example) do:
>     dnotify_parent(dentry, DN_ACCESS);
>     inotify_dentry_parent_queue_event(dentry,
>                            IN_ACCESS, 0, dentry->d_name.name);
>     inotify_inode_queue_event(inode, IN_ACCESS, 0, NULL);
> for the optional "notify" functionality.
> 
> dnotify_parent() knows how to exit quickly:
>        if (!dir_notify_enable)
>                 return;

This isn't a "quick exit", though.  It is just a termination check in
case dnotify was disabled on boot.  The rest of dnotify_parent() is
always executed and it does the equivalent of dget_parent().

So why is inotify showing up on your test and not dnotify?

Hm, dnotify always grabs the lock but does not bump dentry->count unless
there is actually a watch on the dentry.  Could that really be the
difference and cause of the slowdown?  We could probably do that, too.

> Is it possible for a parent's inode->inotify_data to be enabled when none of 
> its children's inotify_data are enabled?  That would make it easy - just look 
> at the current inode's inotify_data before walking back to the parent.

Unfortunately, no.  There is no relationship between the parent and the
child inode's inotify_data structure.  The best we can do is exactly
what dnotify does, actually, which is

	spin_lock(&dentry->d_lock);
	parent = dentry->d_parent;
	if (parent->d_inode->i_dnotify_mask & event) {
		dget(parent);
		spin_unlock(&dentry->d_lock);
		__inode_dir_notify(parent->d_inode, event);
		dput(parent);
	} else {
		spin_unlock(&dentry->d_lock);
	}

Instead of our current "explicit"

	parent = dget_parent(dentry);
	inotify_inode_queue_event(parent->d_inode, mask, cookie,
				  filename);
	dput(parent);

E.g., save the ref unless absolutely needed.

I am open to other ideas, too, but I don't see any nice shortcuts like
what we can do in inotify_inode_queue_event().

(Other) John?  Any ideas?

Best,

	Robert Love


