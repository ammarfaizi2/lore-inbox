Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262052AbUB2NOf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Feb 2004 08:14:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262048AbUB2NOb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Feb 2004 08:14:31 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:18371 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262052AbUB2NO0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Feb 2004 08:14:26 -0500
Date: Sun, 29 Feb 2004 13:14:25 +0000
From: viro@parcelfarce.linux.theplanet.co.uk
To: Maurice van der Stee <stee@planet.nl>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
Subject: Re: 2.6.4-rc1 oops on HPFS filesystem file rename
Message-ID: <20040229131425.GH16357@parcelfarce.linux.theplanet.co.uk>
References: <20040228171259.GA587@maurice.stee.nl> <20040228190649.GF16357@parcelfarce.linux.theplanet.co.uk> <20040229113130.GA577@maurice.stee.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040229113130.GA577@maurice.stee.nl>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 29, 2004 at 12:31:30PM +0100, Maurice van der Stee wrote:
> I think I tested most of the basic file system operations, rename,  
> move, copy, edit, truncate etc. and found no problems with the second  
> patch applied..

Actually, I've found a problem with the original - race between write_inode()
and cross-directory rename(), of all things.  Mind testing the patchset on
ftp.linux.org.uk/pub/people/viro/HPFS*?  First two patches were posted in
this thread, the rest goes on top of them.

Race in question is funny, BTW - write_inode() might have to find and
update directory entry in the parent, so it gets the parent inode and locks
it (that's what hpfs-private lock was for - it gave exclusion between
directory modifications and write_inode() directory entry update; directory
entries can move on insertion/removal, so we need to make sure that it
won't happen during that updating).  The trouble being, it did not make
sure that we lock the right directory - if rename() had moved the file
in question while we were trying to lock the parent, we would end up with
very confused write_inode().

Similar race exists for unlink() vs. write_inode() - the latter checks
->i_nlink, but there is no warranty that it won't become 0 between the
check and locking the parent.  Ditto for rmdir() and overwriting rename().

The fix is simple: we turn semaphore into sempahore + rwsem and
	1) on mkdir/mknod/create/symlink grab rwsem on parent for writing
	2) on rmdir/unlink/rename we grab semaphore on victim and object
being moved, then grab rwsem on parent(s) for writing.
	3) on write_inode we grab semaphore on inode, then check that
it has non-zero ->i_nlink, get parent and grab rwsem on parent for reading.

Exclusion already provided by VFS makes order in rename() (there we might
get two semaphores and two rwsems) a non-issue - we already have all ->rename()
on given fs serialized.  Order among semaphores and among rwsems, that is -
semaphores are always taken first.

Aside of that, patchset switches from use of iget() to use of iget_locked(),
which allows to kill the horrors in hpfs_lock_iget(), and does general
cleanup.

Unless there are complaints and bug reports, it will go to Linus in a couple
of days.
