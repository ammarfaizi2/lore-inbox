Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266371AbSKGFeX>; Thu, 7 Nov 2002 00:34:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266374AbSKGFeX>; Thu, 7 Nov 2002 00:34:23 -0500
Received: from bozo.vmware.com ([65.113.40.131]:59663 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id <S266371AbSKGFeV>; Thu, 7 Nov 2002 00:34:21 -0500
Message-ID: <3C77B405ABE6D611A93A00065B3FFBBA36A494@PA-EXCH2>
From: Christopher Li <chrisl@vmware.com>
To: "'Theodore Ts'o '" <tytso@mit.edu>,
       "'Alexander Viro '" <viro@math.psu.edu>
Cc: Christopher Li <chrisl@vmware.com>,
       "'Jeremy Fitzhardinge '" <jeremy@goop.org>,
       "'Ext2 devel '" <ext2-devel@lists.sourceforge.net>,
       "'Linux Kernel List '" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] Fix bug in ext3 htree rename: doesn't delete old name
	, leaves ino with bad nlink
Date: Wed, 6 Nov 2002 21:40:57 -0800 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2655.55)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The revised patch:

--- namei.c     2002/11/06 07:19:11     1.2
+++ namei.c     2002/11/07 05:24:46
@@ -2167,8 +2167,25 @@
        /*
         * ok, that's it
         */
-       ext3_delete_entry(handle, old_dir, old_de, old_bh);
-
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

Chris

-----Original Message-----
From: Theodore Ts'o
To: Alexander Viro
Cc: Christopher Li; Jeremy Fitzhardinge; Ext2 devel; Linux Kernel List
Sent: 11/6/02 6:44 PM
Subject: Re: [PATCH] Fix bug in ext3 htree rename: doesn't delete old name,
leaves ino with bad nlink

On Wed, Nov 06, 2002 at 05:47:40PM -0500, Alexander Viro wrote:
> 
> HUH?
> 
> ->rename() holds ->i_sem on both directories.  So do all other
directory
> methods.  What the hell is going on there?

What's going on is that had a brain-fart, and forgot about inode
semaphore that's held by the VFS layer.  Chris, sorry about that;
there is no need retry multiple times.  We only need to retry once, in
the case where the node gets split.

						- Ted


