Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261630AbSKCFDW>; Sun, 3 Nov 2002 00:03:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261640AbSKCFDV>; Sun, 3 Nov 2002 00:03:21 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:10708 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S261630AbSKCFDV>;
	Sun, 3 Nov 2002 00:03:21 -0500
Date: Sun, 3 Nov 2002 00:09:30 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Oliver Xymoron <oxymoron@waste.org>,
       Olaf Dietsche <olaf.dietsche#list.linux-kernel@t-online.de>,
       "Theodore Ts'o" <tytso@mit.edu>, Dax Kelson <dax@gurulabs.com>,
       Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org,
       davej@suse.de
Subject: Re: Filesystem Capabilities in 2.6?
In-Reply-To: <Pine.LNX.4.44.0211022040140.2541-100000@home.transmeta.com>
Message-ID: <Pine.GSO.4.21.0211022358430.25010-100000@steklov.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 2 Nov 2002, Linus Torvalds wrote:

> 
> On Sat, 2 Nov 2002, Alexander Viro wrote:
> > 
> > No, that's OK -
> > 
> > mount --bind /usr/bin/foo.real /usr/bin/foo.real
> > mount -o remount,nosuid /usr/bin/foo.real
> 
> Ehh. With the nosuid mount that will remove the effectiveness of the suid
> bit (not just the user change - it will also mask off the elevation of the
> capabilities), so the bind-mount with the capability mask will now mask
> off nothing to start with.

Nope.  Look - ->i_mode is still the same, nothing had changed.  Suid
interpretation happens *not* on a superblock level.  What happens is
	* we look at file->f_dentry->d_inode->i_mode.  No suid bit - no love.
	* then we look at file->f_vfsmnt->mnt_flags.  If that has MNT_NOSUID -
no love, again.
	* if suid bit is present and vfsmount is not marked nosuid - there
we go.

In other words, nosuid status is _already_ per-binding - having a nosuid
binding at /usr/bin/foo.real doesn't have anything to do with suid (or
partial suid) bindings elsewhere.

So trick above will remove effectiveness of the suid bit for binding
at the place where real binary lives.  If you want that place to retain
some capabilities - s/nosuid/capmask=.../ in the above.  It has nothing
to do with other places where you might bind the same file - each binding
has its own vfsmount and thus its own ->mnt_flags...

