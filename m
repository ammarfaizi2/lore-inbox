Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274076AbRIXRkI>; Mon, 24 Sep 2001 13:40:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274080AbRIXRjq>; Mon, 24 Sep 2001 13:39:46 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:26885 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S274076AbRIXRji>; Mon, 24 Sep 2001 13:39:38 -0400
Date: Mon, 24 Sep 2001 19:40:00 +0200
From: Jan Kara <jack@suse.cz>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: UDF, UFS quota patch
Message-ID: <20010924194000.B3184@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="H+4ONPRPur6+Ovig"
Content-Disposition: inline
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--H+4ONPRPur6+Ovig
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

  Hello,

  Attached patch should fix quota in UDF & UFS (it's just the same
bug as was in ext2).
							Honza

--
Jan Kara <jack@suse.cz>
SuSE Labs

--H+4ONPRPur6+Ovig
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="quotaiput-fix.diff"

Only in linux-2.4.10-pre11-fix/fs/udf: .balloc.c.swp
diff -ru -X /home/jack/.kerndiffexclude linux-2.4.10-pre11/fs/udf/ialloc.c linux-2.4.10-pre11-fix/fs/udf/ialloc.c
--- linux-2.4.10-pre11/fs/udf/ialloc.c	Sat Sep 22 17:28:51 2001
+++ linux-2.4.10-pre11-fix/fs/udf/ialloc.c	Sat Sep 22 17:31:20 2001
@@ -155,7 +155,8 @@
 	unlock_super(sb);
 	if (DQUOT_ALLOC_INODE(sb, inode))
 	{
-		sb->dq_op->drop(inode);
+		DQUOT_DROP(inode);
+		inode->i_flags |= S_NOQUOTA;
 		inode->i_nlink = 0;
 		iput(inode);
 		*err = -EDQUOT;
diff -ru -X /home/jack/.kerndiffexclude linux-2.4.10-pre11/fs/ufs/ialloc.c linux-2.4.10-pre11-fix/fs/ufs/ialloc.c
--- linux-2.4.10-pre11/fs/ufs/ialloc.c	Sat Sep 22 17:41:36 2001
+++ linux-2.4.10-pre11-fix/fs/ufs/ialloc.c	Sat Sep 22 17:42:10 2001
@@ -279,7 +279,8 @@
 	unlock_super (sb);
 
 	if(DQUOT_ALLOC_INODE(sb, inode)) {
-		sb->dq_op->drop(inode);
+		DQUOT_DROP(inode);
+		inode->i_flags |= S_NOQUOTA;
 		inode->i_nlink = 0;
 		iput(inode);
 		*err = -EDQUOT;
@@ -293,6 +294,7 @@
 
 failed:
 	unlock_super (sb);
+	make_bad_inode(inode);
 	iput (inode);
 	UFSD(("EXIT (FAILED)\n"))
 	return NULL;

--H+4ONPRPur6+Ovig--
