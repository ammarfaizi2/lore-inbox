Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129431AbRAJCYQ>; Tue, 9 Jan 2001 21:24:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129764AbRAJCYG>; Tue, 9 Jan 2001 21:24:06 -0500
Received: from roc-24-95-203-215.rochester.rr.com ([24.95.203.215]:11784 "EHLO
	d185fcbd7.rochester.rr.com") by vger.kernel.org with ESMTP
	id <S129431AbRAJCXw>; Tue, 9 Jan 2001 21:23:52 -0500
Date: Tue, 09 Jan 2001 21:23:44 -0500
From: Chris Mason <mason@suse.com>
To: Marc Lehmann <pcg@goof.com>
cc: reiserfs-list@namesys.com, linux-kernel@vger.kernel.org,
        vs@namesys.botik.ru
Subject: Re: [reiserfs-list] major security bug in reiserfs (may affect SuSE Linux)
Message-ID: <75150000.979093424@tiny>
In-Reply-To: <20010110023208.B296@cerebro.laendle>
X-Mailer: Mulberry/2.0.6b1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wednesday, January 10, 2001 02:32:09 AM +0100 Marc Lehmann <pcg@goof.com> wrote:

>>> EIP; c013f911 <filldir+20b/221>   <=====
> Trace; c013f706 <filldir+0/221>
> Trace; c0136e01 <reiserfs_getblk+2a/16d>

The buffer reiserfs is sending to filldir is big enough for
the huge file name, so I think the real fix should be done in VFSland.

But, in the interest of providing a quick, obviously correct fix, this
reiserfs only patch will refuse to create file names larger 
than 255 chars, and skip over any directory entries larger than 
255 chars.

--- linux/include/linux/reiserfs_fs.h.1	Tue Jan  9 21:56:18 2001
+++ linux/include/linux/reiserfs_fs.h	Tue Jan  9 21:56:33 2001
@@ -467,7 +467,7 @@
 /* name by bh, ih and entry_num */
 #define B_I_E_NAME(entry_num,bh,ih) ((char *)(bh->b_data + ih->ih_item_location + (B_I_DEH(bh,ih)+(entry_num))->deh_location))
 
-#define REISERFS_MAX_NAME_LEN(block_size) (block_size - BLKH_SIZE - IH_SIZE - DEH_SIZE)	/* -SD_SIZE when entry will contain stat data */
+#define REISERFS_MAX_NAME_LEN(block_size) 255
 
 /* this structure is used for operations on directory entries. It is not a disk structure. */
 /* When reiserfs_find_entry or search_by_entry_key find directory entry, they return filled reiserfs_dir_entry structure */
--- linux/fs/reiserfs/dir.c.1	Tue Jan  9 22:06:06 2001
+++ linux/fs/reiserfs/dir.c	Tue Jan  9 22:15:17 2001
@@ -159,6 +159,10 @@
 		d_name = B_I_DEH_ENTRY_FILE_NAME (bh, ih, deh);
 		d_off = deh->deh_offset;
 		d_ino = deh->deh_objectid;
+		if (d_reclen > REISERFS_MAX_NAME_LEN(inode->i_sb->s_blocksize)){
+		    /* it is too big to send back to VFS */
+		    continue ;
+		}
 		if (d_reclen <= 32) {
 		    local_buf = small_buf ;
 		} else {

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
