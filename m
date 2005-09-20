Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964868AbVITDuL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964868AbVITDuL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Sep 2005 23:50:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964869AbVITDuL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Sep 2005 23:50:11 -0400
Received: from smtp105.rog.mail.re2.yahoo.com ([206.190.36.83]:45409 "HELO
	smtp105.rog.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S964868AbVITDuK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Sep 2005 23:50:10 -0400
Subject: Re: [patch] stop inotify from sending random DELETE_SELF event
	under load
From: John McCutchan <ttb@tentacle.dhs.org>
To: Al Viro <viro@ftp.linux.org.uk>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Robert Love <rml@novell.com>, Al Viro <viro@ZenIV.linux.org.uk>
In-Reply-To: <20050920033148.GA7992@ftp.linux.org.uk>
References: <1127177337.15262.6.camel@vertex>
	 <Pine.LNX.4.58.0509191821220.2553@g5.osdl.org>
	 <20050920033148.GA7992@ftp.linux.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 19 Sep 2005 23:51:44 -0400
Message-Id: <1127188304.17794.11.camel@vertex>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-09-20 at 04:31 +0100, Al Viro wrote:
> On Mon, Sep 19, 2005 at 06:37:43PM -0700, Linus Torvalds wrote:
> > 
> > 
> > On Mon, 19 Sep 2005, John McCutchan wrote:
> > > 
> > > Below is a patch that fixes the random DELETE_SELF events when the
> > > system is under load. The problem is that the DELETE_SELF event is sent
> > > from dentry_iput, which is called in two code paths,
> > > 
> > > 1) When a dentry is being deleted
> > > 2) When the dcache is being pruned.
> > 
> > No no.
> > 
> > The problem is that you put the "fsnotify_inoderemove(inode);" in the 
> > wrong place, and I and Al never noticed.
> > 
> > iput() doesn't have anything to do with delete at all, and adding a flag 
> > to it would be wrong. The inode may stay around _after_ the unlink() for 
> > as long as it has users (or much longer, if you have hardlinks ;). 
> > 
> > You should probably move the "fsnotify_inoderemove(inode);" call into
> > generic_delete_inode() instead, just after "security_inode_delete()".  No
> > new flags, just a new place.
> > 
> > (Oh, I think you need to add it to "hugetlbfs_delete_inode()" too).
> > 
> > There's still a potential problem there: some network filesystems seem to
> > use "generic_delete_inode()" as their "drop_inode" thing. Which may mean 
> > that you get spurious delete messages when the reference is dropped. I 
> > don't see how to avoid that, though - we fundamentally don't _know_ when 
> > the inode actually gets deleted.
> > 
> > Al, do you have any comments? Anything stupid I missed?
> 
> One fundamentally stupid thing is exposing to userland events that
> are none of its fscking business.  Link removal - sure.  Last link
> removal - perhaps, but that's not obvious; in any case it should be
> tied to notification of link removal.  But inode getting freed or
> last dentry going away is none of the userland concern.  

I just thought I should clarify exactly when we want to send the
DELETE_SELF event to user space:

A path which points to inode X has been deleted.

-- 
John McCutchan <ttb@tentacle.dhs.org>
