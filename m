Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132237AbRCVXIt>; Thu, 22 Mar 2001 18:08:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132238AbRCVXIn>; Thu, 22 Mar 2001 18:08:43 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:45041 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S132229AbRCVXI0>;
	Thu, 22 Mar 2001 18:08:26 -0500
Date: Thu, 22 Mar 2001 18:07:44 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Dave Kleikamp <shaggy@austin.ibm.com>
cc: Linus Torvalds <torvalds@transmeta.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC] sane access to per-fs metadata (was Re: [PATCH]
 Documentation/ioctl-number.txt)
In-Reply-To: <3ABA7777.E2198DE9@austin.ibm.com>
Message-ID: <Pine.GSO.4.21.0103221720250.5619-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[cc'd to fsdevel, since trick described below may be of interest for other
folks]

On Thu, 22 Mar 2001, Dave Kleikamp wrote:

> Alexander Viro wrote:
> > 
> > On Thu, 22 Mar 2001, Dave Kleikamp wrote:
> > 
> > > Linus,
> > > I would like to reserve a block of 32 ioctl's for the JFS filesystem.
> > 
> > Details, please? More specifically, what kind of objects are these ioctls
> > applied to?
> 
> I don't have all the details worked out yet, but the utilities to extend
> and defragment the filesystem will operate on a live volume, so the
> utilities will need to talk to the filesystem to move blocks, extend the
> block map, etc.
> 
> The utilities will probably open the root directory and apply the ioctls
> to it, unless there is a better way to do it.

There is - and it may simplify your life, actually. Here's what can be
done:
	a) Use _two_ DECLARE_FSTYPE in your filesystem. Say it, for JFS
(normal) and jfsmeta. Make it FS_LITTER one.
	b) let jfsmeta_read_super() take a pathname as an option (say it,
require "-o jfsroot=<some_path>")
	c) let it do lookup on that pathname and verify that it's on JFS
		error = 0;
		if (path_init(jfsroot, LOOKUP_FOLLOW|LOOKUP_POSITIVE, &nd))
			error = path_walk(jfsroot, &nd);
		if (error)
			/* fail */
		if (nd.mnt->mnt_sb->s_type != &jfs_fs_type)
			/* fail */
	d) store the reference to nd.mnt in superblock.
	e) Allocate root dentry (as usual) and whatever files you want
	   (just pull the example from fs/binfmt_misc.c in -ac).
	f) Make read/write on these files whatever you want them to do -
	   you can access the superblock of "master" JFS (see below)
	   via the saved value of nd.mnt (d).
	g) in jfsmeta_put_super() do mntput() on pointer saved in (d).

How it can be used? Well, say it you've mounted JFS on /usr/local
% mount -t jfsmeta none /mnt -o jfsroot=/usr/local
% ls /mnt
stats	control	bootcode whatever_I_bloody_want
% cat /mnt/stats
master is on /usr/local
fragmentation = 5%
696942 reads, yodda, yodda
% echo "defrag 69 whatever 42 13" > /mnt/control
% umount /mnt

That may look like an overkill, however
	* You can get rid of any need to register ioctls, etc.
	* You can add debugging/whatever at any moment with no need to
	  update any utilities - everything is available from plain shell
	* You can conveniently view whatever metadata you want - no need to
	  shove everything into ioctls on one object.
	* You can use normal permissions control - just set appropriate
	  permission bits for objects on jfsmeta

IOW, you can get normal filesystem view (meaning that you have all usual
UNIX toolkit available) for per-fs control stuff. And keep the ability to
do proper locking - it's the same driver that handles the main fs and you
have access to superblock. No need to change the API - everything is already
there...
	I'll post an example patch for ext2 (safe access to superblock,
group descriptors, inode table and bitmaps on a live fs) after this weekend
(== when misc shit will somewhat settle down).
						Cheers,
							Al

PS: Folks[1], I hope it explains why I'm very sceptical about "let's add new
A{B,P}I" sort of ideas - approach above can be used for almost all stuff
I've seen proposed. You can have multiple views of the same object. And
have all of them available via normal API.

[1] Hans, in particular ;-) Basically, that's the idea you keep mentioning -
_everything can be represented as fs_. Take it one step further and you'll
get _and the beauty of that is in the fact that you don't need new tools
to use the thing - generic ones are fine_

