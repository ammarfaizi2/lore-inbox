Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131746AbRCOO7n>; Thu, 15 Mar 2001 09:59:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131748AbRCOO7f>; Thu, 15 Mar 2001 09:59:35 -0500
Received: from roc-24-169-102-121.rochester.rr.com ([24.169.102.121]:18700
	"EHLO roc-24-169-102-121.rochester.rr.com") by vger.kernel.org
	with ESMTP id <S131746AbRCOO7b>; Thu, 15 Mar 2001 09:59:31 -0500
Date: Thu, 15 Mar 2001 09:58:51 -0500
From: Chris Mason <mason@suse.com>
To: Andreas Klein <asklein@cip.physik.uni-wuerzburg.de>,
        linux-kernel@vger.kernel.org, reiserfs-list@namesys.com
Subject: Re: reiserfs-oops; kernel 2.4.3-pre4
Message-ID: <319210000.984668331@tiny>
In-Reply-To: <Pine.GHP.4.21.0103151342010.7504-100000@wpax13.physik.uni-wuerzburg.de>
X-Mailer: Mulberry/2.0.6b4 (Linux/x86)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="==========2123499384=========="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==========2123499384==========
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


On Thursday, March 15, 2001 02:00:11 PM +0100 Andreas Klein
<asklein@cip.physik.uni-wuerzburg.de> wrote:

[ oops ]

>>> EIP; c016f090 <comp_short_keys+10/40>   <=====
> Trace; c0160046 <reiserfs_iget+6a/a4>
> Trace; c015c8a8 <reiserfs_lookup+94/c4>
> 
> The machine is running linux-2.4.3-pre4 including the reiserfs-patches
> from  Alexander Zarochentcev. 

Ah, I see.  objectid-sharing.diff will pass a null inode to comp_short_keys
if iget4 returns a bad_inode.

Looks like you were using NFS, you'll want to look through the docs on
www.reiserfs.org for the additional patches required to make NFS and
reiserfs play nice.

The attached patch replaces objectid-sharing.diff.  The bug was not present
in pure 2.4.x or 2.4.x-ac kernels.

-chris

--==========2123499384==========
Content-Type: text/plain; charset=us-ascii; name="objectid-sharing-2.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="objectid-sharing-2.diff"; size=804

--- diff/linux/fs/reiserfs/inode.c	Thu Mar 15 09:47:18 2001
+++ linux/fs/reiserfs/inode.c	Thu Mar 15 09:39:06 2001
@@ -1159,11 +1159,17 @@
     if (!inode) 
       return inode ;
 
-    //    if (comp_short_keys (INODE_PKEY (inode), key)) {
     if (is_bad_inode (inode)) {
 	reiserfs_warning ("vs-13048: reiserfs_iget: "
 			  "bad_inode. Stat data of (%lu %lu) not found\n",
 			  key->on_disk_key.k_dir_id, key->on_disk_key.k_objectid);
+	iput (inode);
+	inode = 0;
+    } else if (comp_short_keys (INODE_PKEY (inode), key)) {
+	reiserfs_warning ("vs-13049: reiserfs_iget: "
+			  "Looking for (%lu %lu), found inode of (%lu %lu)\n",
+			  key->on_disk_key.k_dir_id, key->on_disk_key.k_objectid,
+			  INODE_PKEY (inode)->k_dir_id, INODE_PKEY (inode)->k_objectid);
 	iput (inode);
 	inode = 0;
     }

--==========2123499384==========--

