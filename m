Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264767AbUEJPpw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264767AbUEJPpw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 May 2004 11:45:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264788AbUEJPpw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 May 2004 11:45:52 -0400
Received: from mail.fh-wedel.de ([213.39.232.194]:51603 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S264767AbUEJPpa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 May 2004 11:45:30 -0400
Date: Mon, 10 May 2004 17:44:50 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Pavel Machek <pavel@ucw.cz>
Cc: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       linux-kernel@vger.kernel.org, Jamie Lokier <jamie@shareable.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [ANNOUNCEMENT PATCH COW] proof of concept impementation of cowlinks
Message-ID: <20040510154450.GA16182@wohnheim.fh-wedel.de>
References: <20040506131731.GA7930@wohnheim.fh-wedel.de> <200405081645.06969.vda@port.imtp.ilyichevsk.odessa.ua> <20040508221017.GA29255@atrey.karlin.mff.cuni.cz> <200405091709.37518.vda@port.imtp.ilyichevsk.odessa.ua> <20040509215351.GA15307@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040509215351.GA15307@atrey.karlin.mff.cuni.cz>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 9 May 2004 23:53:51 +0200, Pavel Machek wrote:
> 
> I do not see how this matters. cowlinks are already non-POSIX. If
> is_hardlinked() always returns 1, but is_cowlinked() sometimes returns
> something else, you are still "as much POSIX as possible".

Assuming that POSIX is generally pretty sane, "as sane as possible" is
good enough for me.  If POSIX is insane in one way or another,
breaking POSIX is actually a feature, imho.

> > I don't know how to handle this now. Introducing cow-inode number
> > with semantic "cowino1==cowino2 => files are cowlinked" is
> > ugly and won't deal with per-block cow. Sooner or later someone
> > will want to have per block cow. Think about cow'ing multi-gigabyte
> > database files for checkpointing/backup purposes...
> 
> Well, if only block 17 is cowlink-shared between two files, I guess
> userspace does not want to know... And I think that cow-inode number
> *can* handle all other cases.

Correct.

> Oh, get_cow_inode() should really be allowed to fail in some usefull
> way, so that filesystems do not have to implement it if its hard for
> them.

Also correct.

And while we're at it, I need a brain extention again.  Pavel? ;)

The real cowlink patch (too ugly to show it yet) is something like
this:

inode 1: real file
inode 2: cow->inode 1
inode 3: cow->inode 1

Stat() on inode 2 is implemented here:

static void cowlink_fillattr(struct inode *link, struct kstat *stat)
{
	struct super_block *sb = link->i_sb;
	ino_t ino = link->i_op->readcow(link);
	struct inode *inode = iget(sb, ino);

	stat->dev       = link->i_sb->s_dev;
	stat->ino       = ino;
	stat->mode      = link->i_mode - S_IFCOW + S_IFREG;
	stat->nlink     = link->i_nlink;
	stat->uid       = link->i_uid;
	stat->gid       = link->i_gid;
	stat->rdev      = 0;
	stat->atime     = link->i_atime;
	stat->mtime     = link->i_mtime;
	stat->ctime     = link->i_ctime;
	stat->size      = i_size_read(inode);
	stat->blocks    = inode->i_blocks;
	stat->blksize   = inode->i_blksize;
}

size, blocks and blksize has to be taken from inode 1, sure.  uid,
gid, mode and *time are from inode 2, also obvious.  dev doesn't
matter yet, but we might do cross-filesystem cowlinks someday.  nlink
should be from inode 2, so several hard links on it work, also agreed.

What about ino?  I currently return 1, so diff remains fast without
any changes.  If someone really needs the difference between inode 2
and 3, I would introduce a cstat() system call similar to lstat(),
which would return ino=2.

Is this sane?  Should it be reversed and cstat() return ino=1, while
stat returns ino=2?  I can imagine that "tar -x" would create hard
links for every cowlink that "tar -c" saw, but I'm not sure yet.

Jörn

-- 
They laughed at Galileo.  They laughed at Copernicus.  They laughed at
Columbus. But remember, they also laughed at Bozo the Clown.
-- unknown
