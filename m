Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290223AbSBNGUN>; Thu, 14 Feb 2002 01:20:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289850AbSBNGUD>; Thu, 14 Feb 2002 01:20:03 -0500
Received: from ASYNC5-CS1.NET.CS.CMU.EDU ([128.2.188.133]:40967 "EHLO
	mentor.odyssey.cs.cmu.edu") by vger.kernel.org with ESMTP
	id <S290794AbSBNGTz>; Thu, 14 Feb 2002 01:19:55 -0500
Date: Thu, 14 Feb 2002 01:19:33 -0500
To: Uli Martens <um@scientific.de>
Cc: Christoph Rohland <cr@sap.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] tmpfs: incr. link-count on directory rename
Message-ID: <20020214061933.GA17774@mentor.odyssey.cs.cmu.edu>
Mail-Followup-To: Uli Martens <um@scientific.de>,
	Christoph Rohland <cr@sap.com>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <1013648840.2317.5.camel@isax>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1013648840.2317.5.camel@isax>
User-Agent: Mutt/1.3.26i
From: Jan Harkes <jaharkes@cs.cmu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 14, 2002 at 02:07:18AM +0100, Uli Martens wrote:
> When I move a directory into another on a tmpfs filesystem, the
> link-count of the new parent directory isn't getting incremented. 
> (which leads to find getting hickup, which eg. lets dpkg produce a
> "bzip2" binary package without binaries, generally not a nice thing) 

Yeah, that optimization actually breaks on so many filesystems
(AFS/Coda/iso9660/msdos/any filesystem which contains more than 65538
subdirectories in a directory/you name it) that they even provided a
flag to disable it (-noleaf), which in my opinion should always be the
default setting.

Another trick on the 'filesystem side' of things is to set the directory
linkcount to 1. Basically find always subtracts 2 and then as long as
the count is not zero, it will stat the entry to see if it's a
directory. So a directory linkcount of 1 will 'underflow' and find will
work correctly for the first 65535 sub-directories.

It's been on my todo list to use this fix in Coda as we have some link
count issues when we're flipping entries between 'faked' symlinks for
mountpoints/conflicts and real directories.

Jan

> @@ -1085,6 +1085,9 @@
>  {
>         int error = -ENOTEMPTY;
>  
> +       if (S_ISDIR(old_dentry->d_inode->i_mode)) {
> +               new_dir->i_nlink++;
> +       }
>         if (shmem_empty(new_dentry)) {
>                 struct inode *inode = new_dentry->d_inode;
>                 if (inode) {

ps. shouldn't the linkcount of the old_dir get decremented too? Also you
should only change the linkcounts when the operation completed
successfully. i.e. something more like,

--- /tmp/shmem.c.orig	Thu Feb 14 01:17:23 2002
+++ /tmp/shmem.c	Thu Feb 14 01:18:25 2002
@@ -1100,6 +1100,10 @@
 		error = 0;
 		old_dentry->d_inode->i_ctime = old_dir->i_ctime = old_dir->i_mtime = CURRENT_TIME;
 	}
+	if (!error && S_ISDIR(old_dentry->d_inode->i_mode)) {
+	    old_dir->i_nlink--;
+	    new_dir->i_nlink++;
+	}
 	return error;
 }
 
