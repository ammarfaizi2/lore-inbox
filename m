Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264788AbUEJPva@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264788AbUEJPva (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 May 2004 11:51:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264822AbUEJPva
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 May 2004 11:51:30 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:12431 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S264788AbUEJPv2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 May 2004 11:51:28 -0400
Date: Mon, 10 May 2004 17:51:27 +0200
From: Pavel Machek <pavel@suse.cz>
To: =?iso-8859-2?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Cc: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       linux-kernel@vger.kernel.org, Jamie Lokier <jamie@shareable.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [ANNOUNCEMENT PATCH COW] proof of concept impementation of cowlinks
Message-ID: <20040510155127.GD27008@atrey.karlin.mff.cuni.cz>
References: <20040506131731.GA7930@wohnheim.fh-wedel.de> <200405081645.06969.vda@port.imtp.ilyichevsk.odessa.ua> <20040508221017.GA29255@atrey.karlin.mff.cuni.cz> <200405091709.37518.vda@port.imtp.ilyichevsk.odessa.ua> <20040509215351.GA15307@atrey.karlin.mff.cuni.cz> <20040510154450.GA16182@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040510154450.GA16182@wohnheim.fh-wedel.de>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Oh, get_cow_inode() should really be allowed to fail in some usefull
> > way, so that filesystems do not have to implement it if its hard for
> > them.
> 
> Also correct.
> 
> And while we're at it, I need a brain extention again.  Pavel? ;)
> 
> The real cowlink patch (too ugly to show it yet) is something like
> this:
> 
> inode 1: real file
> inode 2: cow->inode 1
> inode 3: cow->inode 1
> 
> Stat() on inode 2 is implemented here:
> 
> static void cowlink_fillattr(struct inode *link, struct kstat *stat)
> {
> 	struct super_block *sb = link->i_sb;
> 	ino_t ino = link->i_op->readcow(link);
> 	struct inode *inode = iget(sb, ino);
> 
> 	stat->dev       = link->i_sb->s_dev;
> 	stat->ino       = ino;
> 	stat->mode      = link->i_mode - S_IFCOW + S_IFREG;
> 	stat->nlink     = link->i_nlink;
> 	stat->uid       = link->i_uid;
> 	stat->gid       = link->i_gid;
> 	stat->rdev      = 0;
> 	stat->atime     = link->i_atime;
> 	stat->mtime     = link->i_mtime;
> 	stat->ctime     = link->i_ctime;
> 	stat->size      = i_size_read(inode);
> 	stat->blocks    = inode->i_blocks;
> 	stat->blksize   = inode->i_blksize;
> }
> 
> size, blocks and blksize has to be taken from inode 1, sure.  uid,
> gid, mode and *time are from inode 2, also obvious.  dev doesn't
> matter yet, but we might do cross-filesystem cowlinks someday.  nlink
> should be from inode 2, so several hard links on it work, also agreed.
> 
> What about ino?  I currently return 1, so diff remains fast without
> any changes.  If someone really needs the difference between inode 2
> and 3, I would introduce a cstat() system call similar to lstat(),
> which would return ino=2.

I think you need to return 2, otherwise inode numbers change when
cowling is broken.... and that would be bad.

Aha.. That is another neccessary property for get_cow_inode():
cow_inode can change, any time, unlike normal inode.

								Pavel
-- 
Horseback riding is like software...
...vgf orggre jura vgf serr.
