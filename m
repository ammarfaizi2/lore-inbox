Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751358AbWAVVDE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751358AbWAVVDE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jan 2006 16:03:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751359AbWAVVDD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jan 2006 16:03:03 -0500
Received: from thunk.org ([69.25.196.29]:36302 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S1751358AbWAVVDC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jan 2006 16:03:02 -0500
Date: Sun, 22 Jan 2006 16:02:38 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: John Richard Moser <nigelenki@comcast.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: soft update vs journaling?
Message-ID: <20060122210238.GA28980@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	John Richard Moser <nigelenki@comcast.net>,
	linux-kernel@vger.kernel.org
References: <43D3295E.8040702@comcast.net> <20060122093144.GA7127@thunk.org> <43D3D4DF.2000503@comcast.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43D3D4DF.2000503@comcast.net>
User-Agent: Mutt/1.5.11
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 22, 2006 at 01:54:23PM -0500, John Richard Moser wrote:
> > Whenever you want to extend a filesystem to add some new feature, such
> > as online resizing, for example, it's not enough to just add that
> 
> Online resizing is ever safe?  I mean, with on-disk filesystem layout
> support I could somewhat believe it for growing; for shrinking you'd
> need a way to move files around without damaging them (possible).  I
> guess it would be.
> 
> So how does this work?  Move files -> alter file system superblocks?

The online resizing support in ext3 only grows the filesystems; it
doesn't shrink it.  What is currently supported in 2.6 requires you to
reserve space in advance.  There is also a slight modification to the
ext2/3 filesystem format which is only supported by Linux 2.6 which
allows you to grow the filesystem without needing to move filesystem
data structures around; the kernel patches for actualling doing this
new style of online resizing aren't yet in mainline yet, although they
have been posted to ext2-devel for evaluation.

> A passive-active approach could passively generate a list of inodes from
> dentries as they're accessed; and actively walk the directory tree when
> the disk is idle.  Then a quick allocation check between inodes and
> whatever allocation lists or trees there are could be done.

That doesn't really help, because in order to release the unused disk
blocks, you have to walk every single inode and keep track of the
block allocation bitmaps for the entire filesystem.  If you have a
really big filesystem, it may require hundreds of megabytes of
non-swappable kernel memory.  And if you try to do this in userspace,
it becomes an unholy mess trying to keep the userspace and in-kernel
mounted filesystem data structures in sync.

						- Ted
