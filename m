Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273617AbRIUQfV>; Fri, 21 Sep 2001 12:35:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273618AbRIUQfL>; Fri, 21 Sep 2001 12:35:11 -0400
Received: from RAVEL.CODA.CS.CMU.EDU ([128.2.222.215]:37269 "EHLO
	ravel.coda.cs.cmu.edu") by vger.kernel.org with ESMTP
	id <S273617AbRIUQfA>; Fri, 21 Sep 2001 12:35:00 -0400
Date: Fri, 21 Sep 2001 12:35:21 -0400
To: Norbert Sendetzky <norbert@linuxnetworks.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Implementing a new network based file system
Message-ID: <20010921123519.B3974@cs.cmu.edu>
Mail-Followup-To: Norbert Sendetzky <norbert@linuxnetworks.de>,
	linux-kernel@vger.kernel.org
In-Reply-To: <200109211609.SAA08383@post.webmailer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200109211609.SAA08383@post.webmailer.de>
User-Agent: Mutt/1.3.20i
From: Jan Harkes <jaharkes@cs.cmu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 21, 2001 at 06:07:05PM +0200, Norbert Sendetzky wrote:
> My first question is related to the superblock:
> There are six functions about inode handling. Each of the above 
> network file systems (coda, nfs, smbfs) implements different 
> functions:
> 
> coda: read_inode and clear_inode
> nfs: read_inode, put_inode and delete_inode
> smbfs: put_inode and delete_inode
> 
> When do I need which function? Why are they necessary at all when 
> implementing a network file system? Can anyone explain the bigger 
> scheme behind this to me?

Any object (file/directory/symlink) needs an inode. You can either rely
on the generic VFS iget (or iget4) implementation to find previously
allocated inodes, in which case you need to have a read_inode function
which is called whenever an inode is not found and a new one needs to be
initialized. SMBFS is clearly using it's own methods for finding
previously allocated inodes/allocating new ones, as it doesn't have an
read_inode implementation.

Put_inode, delete_inode and clear_inode are all called in different
places when inodes are released or destroyed, and can be used to tear
down FS-private data structures. put_inode is called whenever iput is
called, there might still be other references, so you need to check the
i_count to see how many users there are left. delete_inode is probably
related to deleted files, and clear_inode is only called when an inode
is finally dropped from the inode cache and possibly given off to some
other FS. Coda is able to use clear_inode, because we have a callback
mechanism to invalidate inodes even when they are not in use anymore.
This saves us a few calls to the userspace cachemanager, which are
relatively expensive.

> My second question is around inode_operations:
> Why does none of the network file systems implement the readlink, 
> follow_link, truncate and getattr funtions? Does the server follow 
> the symlink automatically if it is written to the storage medium and 
> show only the resulting file?

The VFS already does that for us, the only necessary function is an
operation that returns the contents of the symbolic link (e.g.
fs/coda/symlink.c).

btw. there is a linux-fsdevel mailinglist at vger.kernel.org where most
FS hackers hang out. I guess that the #kernelnewbies IRC channel at
irc.openprojects.net is also a goof place for these types of questions

Jan

