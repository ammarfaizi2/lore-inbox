Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129431AbRAJClP>; Tue, 9 Jan 2001 21:41:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129764AbRAJClG>; Tue, 9 Jan 2001 21:41:06 -0500
Received: from roc-24-95-203-215.rochester.rr.com ([24.95.203.215]:22280 "EHLO
	d185fcbd7.rochester.rr.com") by vger.kernel.org with ESMTP
	id <S129431AbRAJCk4>; Tue, 9 Jan 2001 21:40:56 -0500
Date: Tue, 09 Jan 2001 21:40:46 -0500
From: Chris Mason <mason@suse.com>
To: Marc Lehmann <pcg@goof.com>
cc: reiserfs-list@namesys.com, linux-kernel@vger.kernel.org,
        vs@namesys.botik.ru
Subject: Re: [reiserfs-list] major security bug in reiserfs (may affect SuSE Linux)
Message-ID: <85470000.979094446@tiny>
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
> 

Here is a patch against our 2.4 code (3.6.25) that does the
same as the patch posted for 3.5.29:

-chris

--- linux/include/linux/reiserfs_fs.h.1	Tue Jan  9 21:22:27 2001
+++ linux/include/linux/reiserfs_fs.h	Tue Jan  9 21:22:55 2001
@@ -926,8 +926,7 @@
 //((block_size - BLKH_SIZE - IH_SIZE - DEH_SIZE * 2) / 2)
 
 // two entries per block (at least)
-#define REISERFS_MAX_NAME_LEN(block_size) \
-((block_size - BLKH_SIZE - IH_SIZE - DEH_SIZE))
+#define REISERFS_MAX_NAME_LEN(block_size) 255
 
 
 
--- linux/fs/reiserfs/dir.c.1	Tue Jan  9 21:22:19 2001
+++ linux/fs/reiserfs/dir.c	Tue Jan  9 21:21:02 2001
@@ -142,6 +142,10 @@
 		if (!d_name[d_reclen - 1])
 		    d_reclen = strlen (d_name);
 	
+		if (d_reclen > REISERFS_MAX_NAME_LEN(inode->i_sb->s_blocksize)){
+		    /* too big to send back to VFS */
+		    continue ;
+		}
 		d_off = deh_offset (deh);
 		filp->f_pos = d_off ;
 		d_ino = deh_objectid (deh);


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
