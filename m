Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288301AbSACUc0>; Thu, 3 Jan 2002 15:32:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288306AbSACUcT>; Thu, 3 Jan 2002 15:32:19 -0500
Received: from age.cs.columbia.edu ([128.59.22.100]:4878 "EHLO
	age.cs.columbia.edu") by vger.kernel.org with ESMTP
	id <S288300AbSACUcC>; Thu, 3 Jan 2002 15:32:02 -0500
Date: Thu, 3 Jan 2002 15:31:58 -0500 (EST)
From: Ion Badulescu <ionut@cs.columbia.edu>
To: Daniel Phillips <phillips@bonn-fries.net>
cc: <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
Subject: Re: [CFT] [JANITORIAL] Unbork fs.h
In-Reply-To: <E16MAp4-00018b-00@starship.berlin>
Message-ID: <Pine.LNX.4.33.0201031311120.27242-100000@age.cs.columbia.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Jan 2002, Daniel Phillips wrote:

> On January 3, 2002 05:05 pm, Ion Badulescu wrote:
> > Daniel Phillips wrote:
> > 
> > > +static struct file_system_type ext2_fs = {
> > > +       owner:          THIS_MODULE,
> > > +       fs_flags:       FS_REQUIRES_DEV,
> > > +       name:           "ext2",
> > > +       read_super:     ext2_read_super,
> > > +       super_size:     sizeof(struct ext2_sb_info),
> > > +       inode_size:     sizeof(struct ext2_inode_info)
> > > +};
> > 
> > While we're at it, can we extend this model to also include details about 
> > the other filesystem data structures with (potential) private info, i.e.
> > struct dentry and struct file? ext2 might not use them, but other 
> > filesystems certainly do.
> 
> Could you be more specific about what you mean, please?

If we're going to have specific slabs for each specific filesystem's inode
and superblock structures, why shouldn't we do the same with the struct
file and struct dentry? Right now, if a filesystem needs to stick some
information in there, it has to allocate and then dereference
file->private_data and dentry->d_fsdata, and I thought this cleanup was
trying to avoid that, right?

Something like this, added to the end of the filesystem declaration:
+       dentry_size:    sizeof(struct ext2_dentry_info),
+       file_size:      sizeof(struct ext2_file_info)

Obviously the above is only an example, since ext2 doesn't have those 
structures -- so it would simply use 0 instead.

>From the filesystems in the tree, only intermezzo actually allocates 
them, so it's not as pressing a matter as it was for inodes. A few others 
(ab)use the private pointer to store an integer value, without actually 
allocating a private structure.

Stackable filesystems, on the other hand, make extensive use of all these 
private data pointers to store the links to the stacking level immediately 
underneath. Alas, they're not in the tree... :-)

> That's good advice and I'm likely to adhere to it - if you can show that 
> having no spaces between the name of the function and its arguments really is 
> the accepted practice.  I've seen both styles on my various travels though 
> the kernel, and I prefer the one with the space.  Much as I prefer to put 
> spaces around '+' (but not around '.', go figure).

Well... I said "minor point" and it degenerated into a full-fledged 
thread, while nobody actually cared much about the real code... :-)

I know the issue has been hashed to death already, but basically the 
common practice I was referring to is to *have* a space after a C keyword 
(for, while, return), but *not* after a function name.

Thanks,
Ion

-- 
  It is better to keep your mouth shut and be thought a fool,
            than to open it and remove all doubt.


