Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270155AbRHGJTY>; Tue, 7 Aug 2001 05:19:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270157AbRHGJTO>; Tue, 7 Aug 2001 05:19:14 -0400
Received: from smtpde02.sap-ag.de ([194.39.131.53]:9140 "EHLO
	smtpde02.sap-ag.de") by vger.kernel.org with ESMTP
	id <S270155AbRHGJTD>; Tue, 7 Aug 2001 05:19:03 -0400
From: Christoph Rohland <cr@sap.com>
To: Chris Wedgwood <cw@f00f.org>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Rik van Riel <riel@conectiva.com.br>, Ivan Kalvatchev <iive@yahoo.com>,
        linux-kernel@vger.kernel.org
Subject: [Patch2] Re: DoS with tmpfs #3
In-Reply-To: <20010803163409.62191.qmail@web13609.mail.yahoo.com>
	<Pine.LNX.4.33L.0108040303030.2526-100000@imladris.rielhome.conectiva>
	<20010805063657.C20164@weta.f00f.org> <m3ofpturpx.fsf@linux.local>
Organisation: SAP LinuxLab
In-Reply-To: <m3ofpturpx.fsf@linux.local>
Message-ID: <m37kwg5jb1.fsf_-_@linux.local>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: 07 Aug 2001 11:09:47 +0200
X-SAP: out
X-SAP: out
X-SAP: out
X-SAP: out
X-SAP: out
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi ,

On 06 Aug 2001, Christoph Rohland wrote:
> Since there are enough persons having trouble with the current
> behaviour I append a patch (against 2.4.8-pre4) to implement the
> default to be ram/2.

The following patch is needed on top of the previous one to compile
without CONFIG_TMPFS.

Greetings
		Christoph

--- 8-pre4-def/mm/shmem.c	Tue Aug  7 10:43:14 2001
+++ m8-pre4/mm/shmem.c	Tue Aug  7 10:47:38 2001
@@ -537,6 +537,30 @@
 	return inode;
 }
 
+static int shmem_set_size(struct shmem_sb_info *info,
+			  unsigned long max_blocks, unsigned long max_inodes)
+{
+	int error;
+	unsigned long blocks, inodes;
+
+	spin_lock(&info->stat_lock);
+	blocks = info->max_blocks - info->free_blocks;
+	inodes = info->max_inodes - info->free_inodes;
+	error = -EINVAL;
+	if (max_blocks < blocks)
+		goto out;
+	if (max_inodes < inodes)
+		goto out;
+	error = 0;
+	info->max_blocks  = max_blocks;
+	info->free_blocks = max_blocks - blocks;
+	info->max_inodes  = max_inodes;
+	info->free_inodes = max_inodes - inodes;
+out:
+	spin_unlock(&info->stat_lock);
+	return error;
+}
+
 #ifdef CONFIG_TMPFS
 static ssize_t
 shmem_file_write(struct file *file,const char *buf,size_t count,loff_t *ppos)
@@ -1001,30 +1025,6 @@
 			return 1;
 	}
 	return 0;
-}
-
-static int shmem_set_size(struct shmem_sb_info *info,
-			  unsigned long max_blocks, unsigned long max_inodes)
-{
-	int error;
-	unsigned long blocks, inodes;
-
-	spin_lock(&info->stat_lock);
-	blocks = info->max_blocks - info->free_blocks;
-	inodes = info->max_inodes - info->free_inodes;
-	error = -EINVAL;
-	if (max_blocks < blocks)
-		goto out;
-	if (max_inodes < inodes)
-		goto out;
-	error = 0;
-	info->max_blocks  = max_blocks;
-	info->free_blocks = max_blocks - blocks;
-	info->max_inodes  = max_inodes;
-	info->free_inodes = max_inodes - inodes;
-out:
-	spin_unlock(&info->stat_lock);
-	return error;
 }
 
 static int shmem_remount_fs (struct super_block *sb, int *flags, char *data)

