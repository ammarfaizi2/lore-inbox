Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277352AbRJELT2>; Fri, 5 Oct 2001 07:19:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277353AbRJELTS>; Fri, 5 Oct 2001 07:19:18 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:15122 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S277352AbRJELTP>; Fri, 5 Oct 2001 07:19:15 -0400
Date: Fri, 5 Oct 2001 13:19:41 +0200
From: Jan Kara <jack@suse.cz>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: Quota inode counting bugfix in UDF, UFS
Message-ID: <20011005131941.I18477@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hello,

  I'm sending you patch which should fix problems with inode counting
in UDF and UFS. Please apply. I already sent you this patch a few days
ago but it doesn't seem to get it into kernel...

								Honza

--
Jan Kara <jack@suse.cz>
SuSE CR Labs

-----------------------------<cut>-------------------------------------
diff -ru -X /home/jack/.kerndiffexclude linux-2.4.10/fs/udf/ialloc.c linux-2.4.10-fix/fs/udf/ialloc.c
--- linux-2.4.10/fs/udf/ialloc.c	Sat Sep 22 17:28:51 2001
+++ linux-2.4.10-fix/fs/udf/ialloc.c	Sat Sep 22 17:31:20 2001
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
diff -ru -X /home/jack/.kerndiffexclude linux-2.4.10/fs/ufs/ialloc.c linux-2.4.10-fix/fs/ufs/ialloc.c
--- linux-2.4.10/fs/ufs/ialloc.c	Sat Sep 22 17:41:36 2001
+++ linux-2.4.10-fix/fs/ufs/ialloc.c	Sat Sep 22 17:42:10 2001
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
