Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265245AbSKFIQK>; Wed, 6 Nov 2002 03:16:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265285AbSKFIQK>; Wed, 6 Nov 2002 03:16:10 -0500
Received: from 12-234-207-200.client.attbi.com ([12.234.207.200]:3456 "EHLO
	chrisl-um.vmware.com") by vger.kernel.org with ESMTP
	id <S265245AbSKFIQH>; Wed, 6 Nov 2002 03:16:07 -0500
Date: Wed, 6 Nov 2002 00:25:00 -0800
From: chrisl@vmware.com
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Ext2 devel <ext2-devel@lists.sourceforge.net>,
       Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: [PATCH] Fix bug in ext3 htree rename: doesn't delete old name, leaves ino with bad nlink
Message-ID: <20021106082500.GA3680@vmware.com>
References: <1036471670.21855.15.camel@ixodes.goop.org> <20021105212415.GB1472@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021105212415.GB1472@vmware.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This should fix the ext3 htree rename problem. Please try it again.

Thanks

Chris

--- namei.c     2002/11/06 07:19:11     1.2
+++ namei.c     2002/11/06 08:17:31
@@ -2091,7 +2091,7 @@
        old_bh = new_bh = dir_bh = NULL;
 
        handle = ext3_journal_start(old_dir, 2 * EXT3_DATA_TRANS_BLOCKS +
-                                       EXT3_INDEX_EXTRA_TRANS_BLOCKS + 2);
+                                       EXT3_INDEX_EXTRA_TRANS_BLOCKS + 3);
        if (IS_ERR(handle)) {
                return PTR_ERR(handle);
        }
@@ -2167,8 +2167,30 @@
        /*
         * ok, that's it
         */
-       ext3_delete_entry(handle, old_dir, old_de, old_bh);
+       retval = ext3_delete_entry(handle, old_dir, old_de, old_bh);
+       if (retval == -ENOENT) {
+               /*
+                * old_de can be moved during ext3_add_entry.
+                */
+               struct buffer_head * old_bh2;
+               struct ext3_dir_entry_2 * old_de2;
+               old_bh2 = ext3_find_entry (old_dentry, &old_de2);
+               if (old_bh2) {
+                       retval = ext3_delete_entry(handle, old_dir, old_de2,
+                                                  old_bh2);
+                       brelse(old_bh2);
+               } else {
+                       ext3_warning(old_dir->i_sb, "ext3_rename",
+                                    "Deleting old file not found (%lu), %d",
+                                    old_dir->i_ino, old_dir->i_nlink);
+               }
 
+       }
+       if (retval) {
+               ext3_warning (old_dir->i_sb, "ext3_rename",
+                             "Deleting old file (%lu), %d, error=%d",
+                             old_dir->i_ino, old_dir->i_nlink, retval);
+       }
        if (new_inode) {
                new_inode->i_nlink--;
                new_inode->i_ctime = CURRENT_TIME;



On Tue, Nov 05, 2002 at 01:24:16PM -0800, chrisl@vmware.com wrote:
> Thanks again for the nice bug report.
> 
> I think I understand the problem now. What happen was, in ext3_rename,
> it will first add the new entry to directory and then remove the
> old entry. In this case, when add a new entry to the directory
> cause a leaf node split. And the old entry is in the very same
> leaf node. After split, the old entry have been move to another
> leaf node. But ext3_rename still holding the old pointer and bh
> to the old leaf node.
> 
> It will try to delete the entry from old leaf node, and of course,
> it can't find it.
> 
> You know the rest of the story then.
> 
> The old ext3 code is OK because it only append new blocks, it
> will not change the previous block.
> 
> This also raise an interesting question, after split leave node,
> do we need to update the dentry cache for the change?
> 
> I will try to post a patch tonight (pacific time) to fix this problem.
> 
> Cheers.
> 
> Chris
> 
> On Mon, Nov 04, 2002 at 08:47:50PM -0800, Jeremy Fitzhardinge wrote:
> > I've isolated the problem to rename not removing the old name under some
> > circumstances, leaving two names for a file with an nlink of 1.  This
> > will reliably reproduce the problem for me, under 2.4.19-ac4 and 2.4.19
> > (stock) w/ patch-ext3-dxdir-2.4.19-4.
> > 
> > Generate a new filesystem: this will create htree-bug.fs
> > $ sh genfs
> > 
> > # mkdir m
> > # mount -o loop htree-bug.fs m
> > 
> > $ gcc -o tickle tickle.c
> > $ ./tickle m/test
> > *** rename("drivers/scsi/psi240i.h", "drivers/scsi/psi240i.h.orig") failure:
> > stating drivers/scsi/psi240i.h
> >   ino=294
> >   nlink=1
> > stating drivers/scsi/psi240i.h.orig
> >   ino=294
> >   nlink=1
> > *** rename("drivers/scsi/sun3_scsi.h", "drivers/scsi/sun3_scsi.h.orig") failure:
> > stating drivers/scsi/sun3_scsi.h
> >   ino=350
> >   nlink=1
> > stating drivers/scsi/sun3_scsi.h.orig
> >   ino=350
> >   nlink=1
> > 
> > # umount m
> > 
> > $ e2fsck -f htree-bug.fs
> > e2fsck 1.30-WIP (30-Sep-2002)
> > Pass 1: Checking inodes, blocks, and sizes
> > Pass 2: Checking directory structure
> > Pass 3: Checking directory connectivity
> > Pass 4: Checking reference counts
> > Inode 294 ref count is 1, should be 2.  Fix<y>? yes
> > 
> > Inode 350 ref count is 1, should be 2.  Fix<y>? yes
> > 
> > Pass 5: Checking group summary information
> > 
> > htree-bug.fs: ***** FILE SYSTEM WAS MODIFIED *****
> > htree-bug.fs: 541/10240 files (0.2% non-contiguous), 1369/10240 blocks
> > exit status 1
> > $ debugfs htree-bug.fs 
> > debugfs 1.30-WIP (30-Sep-2002)
> > debugfs:  ncheck 294
> > Inode   Pathname
> > 294     /test/drivers/scsi/psi240i.h
> > debugfs:  ncheck 350
> > Inode   Pathname
> > 350     /test/drivers/scsi/sun3_scsi.h
> > 
> > 
> > I've put all the bits needed to reproduce the bug (genfs, tickle) at
> > http://www.goop.org/~jeremy/htree/
> > 
> > 
> >         J
> > 
> > 
> > 
> > -------------------------------------------------------
> > This SF.net email is sponsored by: ApacheCon, November 18-21 in
> > Las Vegas (supported by COMDEX), the only Apache event to be
> > fully supported by the ASF. http://www.apachecon.com
> > _______________________________________________
> > Ext2-devel mailing list
> > Ext2-devel@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/ext2-devel
> 
> 
> 
> 
> -------------------------------------------------------
> This sf.net email is sponsored by: See the NEW Palm 
> Tungsten T handheld. Power & Color in a compact size!
> http://ads.sourceforge.net/cgi-bin/redirect.pl?palm0001en
> _______________________________________________
> Ext2-devel mailing list
> Ext2-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ext2-devel
