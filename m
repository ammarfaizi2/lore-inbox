Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263259AbTKWEWW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Nov 2003 23:22:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263260AbTKWEWV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Nov 2003 23:22:21 -0500
Received: from adsl-68-90-157-65.dsl.okcyok.swbell.net ([68.90.157.65]:29160
	"HELO homer.d-oh.org") by vger.kernel.org with SMTP id S263259AbTKWEWS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Nov 2003 23:22:18 -0500
Date: Sat, 22 Nov 2003 22:22:16 -0600
From: Alex Adriaanse <alex_a@caltech.edu>
To: Vladimir Saveliev <vs@namesys.com>
Cc: Hans Reiser <reiser@namesys.com>, reiserfs-dev@namesys.com,
       linux-kernel@vger.kernel.org
Subject: Re: ReiserFS patch for updating ctimes of renamed files
Message-ID: <20031123042216.GA32152@homer.d-oh.org>
References: <JIEIIHMANOCFHDAAHBHOMENJDAAA.alex_a@caltech.edu> <3FBBA8A7.7090802@namesys.com> <200311201746.15843.vs@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200311201746.15843.vs@namesys.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vladimir,

I must've messed something up when testing the updates of ctime during a
rename on ext2, because when looking at the ext2 code the ctime of a
renamed file doesn't normally get updated.  Maybe I simply forgot to
test it on ext2 and only tested out tmpfs.  Oops. :)  Sorry for the
confusion.  Based on my findings below, ext2's (or minix or ufs for that
matter) behavior seems also inconsistent with some of the other FSes I
mentioned below (ext2/minix/ufs also seem to share a lot of code in
their rename functions).

When glancing through the 2.6.0-test9 source code, I verified that ext3
updates the ctime (fs/ext3/namei.c:2244, with the comment, "Like most
other Unix systems, set the ctime for inodes on a rename."), JFS updates
ctime (fs/jfs/namei.c:1231), xfs updates it (xfs/xfs_rename.c:480), etc.
I believe all these updates are made for both directories and
non-directories, so it appears that your patch which updates only a
directory's ctime needs to cover non-directories as well (at least if
you're trying to be consistent across other Linux filesystems like
ext3/jfs/xfs).

Alex

On Thu, Nov 20, 2003 at 05:46:15PM +0300, Vladimir Saveliev wrote:
> Hi
> 
> Sorry for delay with this.
> I looked over linux's renames and they seem to be doing exactly what reiserfs does: 
> do not change anything (neither ctime nor mtime) renaming not-directory. Quick test confirms that.
> Please, look at its log:
> <LOG>
> tribesman:/rescue # mount
> /dev/hda2 on / type reiserfs (rw)
> proc on /proc type proc (rw)
> devpts on /dev/pts type devpts (rw,mode=0620,gid=5)
> /dev/hda1 on /rescue type ext2 (rw)
> shmfs on /dev/shm type shm (rw)
> tribesman:/rescue # stat bigfile
>   File: `bigfile'
>   Size: 1099511627777   Blocks: 198896     IO Block: 4096   regular file
> Device: 301h/769d       Inode: 187         Links: 1
> Access: (0644/-rw-r--r--)  Uid: (    0/    root)   Gid: (    0/    root)
> Access: 2003-02-13 19:56:51.000000000 +0300
> Modify: 2003-02-13 19:56:10.000000000 +0300
> Change: 2003-02-13 19:56:10.000000000 +0300
> 
> tribesman:/rescue # mv bigfile tmp/
> tribesman:/rescue # stat tmp/bigfile
>   File: `tmp/bigfile'
>   Size: 1099511627777   Blocks: 198896     IO Block: 4096   regular file
> Device: 301h/769d       Inode: 187         Links: 1
> Access: (0644/-rw-r--r--)  Uid: (    0/    root)   Gid: (    0/    root)
> Access: 2003-02-13 19:56:51.000000000 +0300
> Modify: 2003-02-13 19:56:10.000000000 +0300
> Change: 2003-02-13 19:56:10.000000000 +0300
> </LOG>
> 
> 
> However, renaming directory reiserfs did not update its ctime and mtime. Patch to fix that is attached.
> Alex, does it cause tar to behave on reiserfs similar to ext2, ext3, etc?
> 
> Thanks,
> vs
> 
> 
> On Wednesday 19 November 2003 20:30, Hans Reiser wrote:
> > Alex Adriaanse wrote:
> > 
> > >Hi Hans & Vladimir,
> > >
> > >Is there any chance that this patch will make it into 2.4.24 (or 2.6.0 for
> > >that matter)? 
> > >
> > > I'm just curious.
> > >
> > >Thanks,
> > >
> > >Alex
> > >
> > >Alex Adriaanse wrote:
> > >>Hi Hans,
> > >>
> > >>I updated my patch to include Andrew's suggestion of eliminating extra
> > >>    
> > >>
> > >calls
> > >  
> > >
> > >>to CURRENT_TIME.  I also finally got a chance to test it out, and it seems
> > >>to work.  After applying this patch, ctime gets updated after a rename, and
> > >>GNU tar now backs things up properly.  I also could not detect any
> > >>filesystem corruption after doing some renames.
> > >>
> > >>Alex
> > >>
> > >>--- fs/reiserfs/namei.c.orig    Mon Aug 25 06:44:43 2003
> > >>+++ fs/reiserfs/namei.c Fri Oct 24 17:16:33 2003
> > >>@@ -1205,8 +1205,11 @@
> > >>
> > >>    mark_de_hidden (old_de.de_deh + old_de.de_entry_num);
> > >>    journal_mark_dirty (&th, old_dir->i_sb, old_de.de_bh);
> > >>-    old_dir->i_ctime = old_dir->i_mtime = CURRENT_TIME;
> > >>-    new_dir->i_ctime = new_dir->i_mtime = CURRENT_TIME;
> > >>+    ctime = CURRENT_TIME;
> > >>+    old_dir->i_ctime = old_dir->i_mtime = ctime;
> > >>+    new_dir->i_ctime = new_dir->i_mtime = ctime;
> > >>+    old_inode->i_ctime = ctime;
> > >>+    reiserfs_update_sd (&th, old_inode);
> > >>
> > >>    if (new_dentry_inode) {
> > >>       // adjust link number of the victim
> > >>@@ -1215,7 +1218,6 @@
> > >>       } else {
> > >>           new_dentry_inode->i_nlink--;
> > >>       }
> > >>-       ctime = CURRENT_TIME;
> > >>       new_dentry_inode->i_ctime = ctime;
> > >>       savelink = new_dentry_inode->i_nlink;
> > >>    }
> > >>
> > >>
