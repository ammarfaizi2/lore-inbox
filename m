Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261173AbULACqp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261173AbULACqp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 21:46:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261195AbULACqo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 21:46:44 -0500
Received: from rproxy.gmail.com ([64.233.170.198]:19624 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261173AbULACqY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 21:46:24 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=Nbn7e7RM2FQm6rQO1TkNTDE8FkVtwrIaxRVssvjsNx0RkGIPlJjlMXVQfBgIAB8GPvqD7buTh+W/7RJ/PUvTDBH7UzcczeCvStpJ/JRrxdVjUoAdOR+JWNGndiadf2BAsjc+45dJLTkDA2DHGW3rwlJfN0xnxce6pp/VVCuLjAY=
Message-ID: <cce9e37e04113018465091010f@mail.gmail.com>
Date: Wed, 1 Dec 2004 02:46:18 +0000
From: Phil Lougher <phil.lougher@gmail.com>
Reply-To: Phil Lougher <phil.lougher@gmail.com>
To: John Richard Moser <nigelenki@comcast.net>
Subject: Re: Designing Another File System
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <41AD218E.7090305@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <41ABF7C5.5070609@comcast.net>
	 <cce9e37e041130112243beb62d@mail.gmail.com>
	 <41AD218E.7090305@comcast.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Nov 2004 20:42:38 -0500, John Richard Moser
> Phil Lougher wrote:
> | Um,  all filesystems do that, I think you're missing words to the
> | effect "without any performance loss or block fragmentation" !
>
> All filesystems allow you to create the FS with 1 inode total?
>
> Filesystem            Inodes   IUsed   IFree IUse% Mounted on
> /dev/hda1            7823616  272670 7550946    4% /
>
> No, it looks like this one allocates many inodes and uses them as it
> goes.  Reiser has 0 inodes . . .

Yes you're right.  What I said was total rubbish.  I read your
statement as meaning to dynamically allocate/deallocate inodes from a
set configured at filesystem creation...

> |
> | The 64 bit resolution is only necessary within the filesystem dentry
> | lookup function to go from a directory name entry to the physical
> | inode location on disk.  The inode number can then be reduced to 32
> | bits for 'presentation' to the VFS.  AFAIK as all file access is
> | through the dentry cache this is sufficient.  The only problems are
> | that VFS iget() needs to be replaced with a filesystem specific iget.
> | A number of filesystems do this.  Squashfs internally uses 37 bit
> | inode numbers and presents them as 32 bit inode numbers in this way.
> |
>
> Ugly, but ok.  What happens when i actually have >4G inodes though?

Well this is an issue that affects all filesystems on 32-bit systems
(as Alan said inode numbers are 64 bits on 64 bit systems).  To be
honest I've never let this worry me...

A 32-bit system can never cache 4G inodes in memory without falling
over, and so a simple solution would be to allocate the 32-bit inode
number dynamically (e.g. starting at one and going up, keeping track
of inode numbers still used for use when/if wraparound occured), this
would guarantee inode number uniqueness for the subset of file inodes
in memory at any one time, with the drawback that inode numbers
allocated to files will change over filesystem mounts.  Alternatively
from reading fs/inode.c it appears that inode numbers only need to be
unique if the fast hashed inode cache lookup functions are used, there
are other inode cache lookup functions that can be used if inode
numbers are not unique.

> | I've had people trying to store 500,000 + files in a Squashfs
> | directory.  Needless to say with the original directory implementation
> | this didn't work terribly well...
> |
> 
> Ouch.  Someone told me the directory had to be O(1) lookup . . . .

Ideally yes, but ultimately with your filesystem you make the rules
:-)   The Squashfs directory design was fast for the original expected
directory size (ideally <= 64K, maximum 512K) seen on embedded
systems.  The next release of Squashfs has considerably improved
indexed directories which are O(1) for large directories.  To be
released sometime soon, if anyone's interested...

Phillip Lougher
