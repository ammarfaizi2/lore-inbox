Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263375AbUEKTEh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263375AbUEKTEh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 15:04:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263389AbUEKTEh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 15:04:37 -0400
Received: from CPE0000c02944d6-CM00003965a061.cpe.net.cable.rogers.com ([69.193.74.215]:23739
	"EHLO tentacle.dhs.org") by vger.kernel.org with ESMTP
	id S263375AbUEKTEY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 15:04:24 -0400
Date: Tue, 11 May 2004 15:02:31 -0400
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: nautilus-list@gnome.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC/PATCH] inotify -- a dnotify replacement
Message-ID: <20040511190228.GA12609@tentacle.dhs.org>
References: <1084152941.22837.21.camel@vertex> <20040510021141.GA10760@taniwha.stupidest.org> <1084227460.28663.8.camel@vertex> <20040511024701.GA19489@taniwha.stupidest.org> <1084278001.1225.9.camel@vertex> <20040511124647.GE17014@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040511124647.GE17014@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.5.5.1+cvs20040105i
From: John McCutchan <ttb@tentacle.dhs.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 11, 2004 at 01:46:47PM +0100, viro@parcelfarce.linux.theplanet.co.uk wrote:
> On Tue, May 11, 2004 at 08:20:01AM -0400, John McCutchan wrote:
>  
> > Inotify will support watching a hierarchy. The reason it was not
> > implemented yet is because the one app that I really care about is
> > nautilus and the maintainer of it says he doesn't care. 
> 
> How are you going to implement that?

>From a quick glance at someone elses implementation of it, I plan on
walking up the dentries and checking at each level if a watcher on that
level is interested in events from subdirectories. Is this good practice in
the kernel?

> > The big feature that inotify is trying to provide is not having to keep
> > a file open (So that unmounting is not affected). I asked for some
> > guidance from people more familiar with the kernel so that I can
> > implement this feature, it requires changes made to the inode cache, and
> > how unmounting is done.
> 
> Bzzert.  First of all, on quite a few filesystems inumbers are stable
> only when object is pinned down.  What's more, if it's not pinned down
> you've got nothing even remotely resembling a reliable way to tell if
> two events had happened to the same object - inumbers can be reused.

The inode will be pinned down, I haven't implemented this yet but I am
going to change the inode cache (is this the right place? )
so that if inode->watcher_count > 0 the inode stays pinned. Then when
the filesystem is unmounted, we will kick off all the watchers on
each inode.

> 
> Besides, your "doesn't pin down" is racy as hell - not to mention the
> way you manage the lists, pretty much every function is an exploitable
> hole.  Hell, just take a look at your "find inode" stuff - you grab
> superblock, find an inode by inumber (great idea, that - especially
> since on a bunch of filesystems it will get you BUG() or equivalent)
> then drop refernce to superblock (at which point it can be destroyed by
> umount()) _and_ do iput() (which will do lovely, lovely things if that
> umount did happen).  Moreover, you return a pointer to inode, even
> though there's nothing to hold it alive anymore.  And dereference that
> pointer later on, not caring if it had been freed/reused/whatever.

Like I said above,as long as an inode has a watcher it will be pinned. As
for the races, I plan on implementing locking around all of the list operations.
Perhaps I wasn't very clear that this is very much a WIP and lots of work is
needed.

> 
> Overall: hopeless crap.  And that's a direct result of your main feature -
> it's really broken by design.

Having directory event notification without needing to keep a file open on the
device is not broken by design. It is the only reasonable solution to
a problem that needs fixing. You can't simply say that a file manager
needing to be notified when directories change is broken. How would
you solve this problem?

John
