Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269155AbRHFXIy>; Mon, 6 Aug 2001 19:08:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269133AbRHFXIf>; Mon, 6 Aug 2001 19:08:35 -0400
Received: from vasquez.zip.com.au ([203.12.97.41]:14856 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S269144AbRHFXIZ>; Mon, 6 Aug 2001 19:08:25 -0400
Message-ID: <3B6F24C3.BD3972B4@zip.com.au>
Date: Mon, 06 Aug 2001 16:14:11 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: eddantes@wanadoo.fr
CC: Gregoire Favre <greg@ulima.unil.ch>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.7-ac8 compilation error
In-Reply-To: <20010806230743.A12850@ulima.unil.ch> <5.1.0.14.2.20010806231341.00aa7580@pop.wanadoo.fr>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- linux-2.4.7-ac8/mm/shmem.c	Mon Aug  6 12:05:28 2001
+++ ac/mm/shmem.c	Mon Aug  6 16:02:39 2001
@@ -739,6 +739,30 @@ struct inode *shmem_get_inode(struct sup
 	return inode;
 }
 
+static int shmem_set_size(struct shmem_sb_info *sbinfo,
+			  unsigned long max_blocks, unsigned long max_inodes)
+{
+	int error;
+	unsigned long blocks, inodes;
+
+	spin_lock(&sbinfo->stat_lock);
+	blocks = sbinfo->max_blocks - sbinfo->free_blocks;
+	inodes = sbinfo->max_inodes - sbinfo->free_inodes;
+	error = -EINVAL;
+	if (max_blocks < blocks)
+		goto out;
+	if (max_inodes < inodes)
+		goto out;
+	error = 0;
+	sbinfo->max_blocks  = max_blocks;
+	sbinfo->free_blocks = max_blocks - blocks;
+	sbinfo->max_inodes  = max_inodes;
+	sbinfo->free_inodes = max_inodes - inodes;
+out:
+	spin_unlock(&sbinfo->stat_lock);
+	return error;
+}
+
 #ifdef CONFIG_TMPFS
 
 static struct inode_operations shmem_symlink_inode_operations;
@@ -1242,30 +1266,6 @@ static int shmem_parse_options(char *opt
 			return 1;
 	}
 	return 0;
-}
-
-static int shmem_set_size(struct shmem_sb_info *sbinfo,
-			  unsigned long max_blocks, unsigned long max_inodes)
-{
-	int error;
-	unsigned long blocks, inodes;
-
-	spin_lock(&sbinfo->stat_lock);
-	blocks = sbinfo->max_blocks - sbinfo->free_blocks;
-	inodes = sbinfo->max_inodes - sbinfo->free_inodes;
-	error = -EINVAL;
-	if (max_blocks < blocks)
-		goto out;
-	if (max_inodes < inodes)
-		goto out;
-	error = 0;
-	sbinfo->max_blocks  = max_blocks;
-	sbinfo->free_blocks = max_blocks - blocks;
-	sbinfo->max_inodes  = max_inodes;
-	sbinfo->free_inodes = max_inodes - inodes;
-out:
-	spin_unlock(&sbinfo->stat_lock);
-	return error;
 }
 
 static int shmem_remount_fs (struct super_block *sb, int *flags, char *data)
