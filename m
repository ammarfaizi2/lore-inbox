Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264984AbTBOUBo>; Sat, 15 Feb 2003 15:01:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265008AbTBOUBo>; Sat, 15 Feb 2003 15:01:44 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:46342 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S264984AbTBOUBm>; Sat, 15 Feb 2003 15:01:42 -0500
Date: Sat, 15 Feb 2003 12:08:10 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Davide Libenzi <davidel@xmailserver.org>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Synchronous signal delivery..
In-Reply-To: <Pine.LNX.4.50.0302141751220.988-100000@blue1.dev.mcafeelabs.com>
Message-ID: <Pine.LNX.4.44.0302151202020.11840-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 14 Feb 2003, Davide Libenzi wrote:
> >
> > Some of it can be pulled in. However, the way the dynamic inode allocation
> > works, different kinds of inodes _have_ to have different superblocks,
> > since that's the level where the inode allocation and caching works. So
> > the fake inodes for a pipe, for example, are _not_ the same as the fake
> > inodes for the sigfd's. So not all of it is shared.
> 
> Superblocks will be different, but their "fake" functionality can be
> shared. A few parameters like file system name, file system magic number,
> root name, ... will be able to do the trick :
> 
> fakefs_t fakefs_create(chat const *root, char const *name, unsigned long magic);
> struct inode *fakefs_new_inode(fakefs_t fkfs);
> void fakefs_close(fakefs_t fkfs);

I'd love to see this. I agree that a fair amount of this should be
shareable with the pipe and socket code, for example. But I would call it
"virtual" instead of "fake", since there is nothing fake about the inode.  
A pipe inode is one of the most fundamental and basic things in UNIX, it's
not "fake" just because it doesn't live on a harddisk.

In fact, one thing I noticed when doing the sigfd() code is that the pipe
code doesn't take advantage of the new inode allocation layer as well as
it could. It still uses multiple allocations, doing a _separate_
allocation for the small "pipe_inode_info" instead of doing the embedding 
trick.

And that's obviously because the code was only minimally changed, because
doing the FS setup with a super-block operation to get at a specialized
allocator is more lines of code than people were willing to do when doing
the conversion.

(It's not _that_ many lines of code, but it could certainly be improved. 
Almost everybody does the same thing at inode allocation and 
de-allocation, it's just that the structure containers are different).

		Linus

