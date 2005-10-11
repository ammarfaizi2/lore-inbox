Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751143AbVJKVif@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751143AbVJKVif (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Oct 2005 17:38:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751128AbVJKVif
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Oct 2005 17:38:35 -0400
Received: from mx1.redhat.com ([66.187.233.31]:22404 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751117AbVJKVie (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Oct 2005 17:38:34 -0400
Date: Tue, 11 Oct 2005 16:38:11 -0500
From: David Teigland <teigland@redhat.com>
To: Al Viro <viro@ftp.linux.org.uk>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 11/16] GFS: mount and tuning options
Message-ID: <20051011213811.GA15913@redhat.com>
References: <20051010171052.GL22483@redhat.com> <20051010213748.GQ7992@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051010213748.GQ7992@ftp.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 10, 2005 at 10:37:48PM +0100, Al Viro wrote:
> On Mon, Oct 10, 2005 at 12:10:52PM -0500, David Teigland wrote:
> > There are a variety of mount options, tunable parameters, internal
> > statistics, and methods of online file system manipulation.
> 
> Could you explain WTF are you doing with rename here?  This pile of
> ioctls is every bit as bad as sys_reiser4(); kindly provide a detailed
> description of the API you've introduced and explain why nothing saner
> would do...

First some background that I've copied from elsewhere:  The superblock
contains a pointer to a "master" directory that contains various system
inodes.  The inodes in the master directory are:

1) A directory named "jindex" containing all the journal files.  The
   journals are named "journal0", "journal1", ..., "journalX"

2) A directory named "per_node" that contains a bunch of files where
   each node can store data specific to that node.  Each node has
   files "inum_rangeX", "statfs_changeX", "unlinked_tagX", and
   "quota_changeX".  So, there are a set of these four files for each
   journal in the jindex directory.

3) A file named "inum" that contains the next cluster-wide inode number.

4) A file named "statfs" that contains the cluster-wide statfs
   information.

5) A file named "rindex" that contains the locations of all the RGs in
   the filesystem.  (RG's == resource groups == allocation groups)

6) A file named "quota" that contains the quota values (UID and GID)
   for the filesystem.

7) A directory named "root" that is the root directory of the
   user-visible filesystem.

The ioctls "hfile_stat", "hfile_read", "hfile_write", "hfile_trunc" are
used to operate on the hidden system files.  I notice we're not using
trunc, so it can be removed.  stat/read/write could be replaced with a few
specific ioctl's if that's preferred.

The next issue is adding journals (and the associated system files) to a
fs.  The gfs2_jadd command does this with the fs online.  If you created
the fs with 8 journals and you now want 12 machines to mount it at once,
you need to add 4 journals by running "gfs2_jadd -j 4 /path/to/fs".

Say gfs2_jadd is adding a 9th journal (id 8) ...

  creates ordinary file /.gfs2_admin/new_inode
  writes to new_inode initializing it as an inum_range file
  moves .gfs2_admin/new_inode to per_node/inum_range8

  creates ordinary file /.gfs2_admin/new_inode
  writes to new_inode initializing it as a statfs_change file
  moves .gfs2_admin/new_inode to per_node/statfs_change8

  same for unlinked_tag8 and quota_change8

  creates ordinary file /.gfs2_admin/new_inode
  writes to new_inode initializing it as a journal file
  moves .gfs2_admin/new_inode to jindex/journal8

  (keeping in mind that the "per_node" and "jindex" dirs and the files
   under them are in the hidden/system portion of the fs)

The create and write steps use ordinary system calls.  The "move" step
uses the "rename2system" ioctl to move .gfs2_admin/new_inode to the
specified system file.  The new files are synced before being renamed so
in case of a crash only correctly formed files are found in the hidden
dirs.  Only when the final journal file is moved into place is the fs
ready to accept a new mounter.

Next is exapanding the size of the fs.  To do this, gfs2_grow first opens
the device and initializes the new space with RG headers.  Second, it uses
the "resize_add_rgrps" ioctl to add new structures defining the space to
the "rindex" system file.  I'm looking into using hfile_write for this.

Other ioctls:
  get_super - copy struct gfs2_sb to user space
  get_file_stat - copy struct gfs2_dinode to user space for given file
  set_file_flag - set gfs-specific flag in inode
  get_bmap - map file block to disk block
  get_file_meta - return all the metadata for a file or dir
  do_file_flush - sync out all dirty data and drop the cache and lock
  do_quota_sync - sync outstanding quota change (moving to sysfs)
  do_quota_refresh - refresh quota lvb from the quota file (moving to sysfs)
  do_quota_read - read quota values from quota file

Some of these we could do without if they're objectionable.  Regardless,
we'll take a closer look to see if any don't qualify as useful enough.

Finally, how ioctl is implemented.  All the commands above are multiplexed
through one actual ioctl (GFS2_IOCTL_SUPER) that passes in:

struct gfs2_ioctl {
        unsigned int gi_argc;
        char **gi_argv;

        char __user *gi_data;
        unsigned int gi_size;
        uint64_t gi_offset;
};

- argv[0] is the command string, e.g. "set_file_flag", "rename2system",
- argv[x] are other string arguments for the command, e.g. for set_file_flag
  argv[1] is either "set" or "clear".  For rename2system argv[1] is the
  destination directory and argv[2] is the new name.
- gi_data, gi_size, gi_offset - data returned to caller when needed

This could be exchanged, of course, for the more tradition ioctl mess if
that's any saner.

Dave

