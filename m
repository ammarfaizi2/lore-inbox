Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268867AbRHFQi6>; Mon, 6 Aug 2001 12:38:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268859AbRHFQit>; Mon, 6 Aug 2001 12:38:49 -0400
Received: from smtpde02.sap-ag.de ([194.39.131.53]:34559 "EHLO
	smtpde02.sap-ag.de") by vger.kernel.org with ESMTP
	id <S268861AbRHFQih>; Mon, 6 Aug 2001 12:38:37 -0400
From: Christoph Rohland <cr@sap.com>
To: Chris Wedgwood <cw@f00f.org>, Linus Torvalds <torvalds@transmeta.com>
Cc: Rik van Riel <riel@conectiva.com.br>, Ivan Kalvatchev <iive@yahoo.com>,
        linux-kernel@vger.kernel.org
Subject: [Patch] Re: DoS with tmpfs #3
In-Reply-To: <20010803163409.62191.qmail@web13609.mail.yahoo.com>
	<Pine.LNX.4.33L.0108040303030.2526-100000@imladris.rielhome.conectiva>
	<20010805063657.C20164@weta.f00f.org>
Organisation: SAP LinuxLab
Message-ID: <m3ofpturpx.fsf@linux.local>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: 06 Aug 2001 18:28:54 +0200
X-SAP: out
X-SAP: out
X-SAP: out
X-SAP: out
X-SAP: out
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chris,

On Sun, 5 Aug 2001, Chris Wedgwood wrote:
> On Sat, Aug 04, 2001 at 03:07:31AM -0300, Rik van Riel wrote:
> 
>     1) you create a tmpfs with a high limit, such that
>        (max size tmpfs) + (user memory) > ram + swap
> 
> maybe, by default, tmpfs should choose a limit of 1/2 ram available
> or something?  if this is too small, people can change it

Actually I would like to give the size mount option a percent
option. So 'mount -t tmpfs -o size=70% ...' would limit the size of
the tmpfs instance to 70% of ram+swap. This would need some changes to
swapoff to first check with tmpfs that there is enough space left and
to swapon to notify tmpfs that there is more room available. This
would make administration really easy but is obviously
2.5 stuff.

Since there are enough persons having trouble with the current
behaviour I append a patch (against 2.4.8-pre4) to implement the
default to be ram/2.

Linus, would you please apply.

Greetings
		Christoph

diff -uNr 8-pre4/mm/shmem.c 8-pre4-def/mm/shmem.c
--- 8-pre4/mm/shmem.c	Sat Jul 21 19:42:11 2001
+++ 8-pre4-def/mm/shmem.c	Mon Aug  6 17:28:31 2001
@@ -754,18 +754,8 @@
 	buf->f_type = TMPFS_MAGIC;
 	buf->f_bsize = PAGE_CACHE_SIZE;
 	spin_lock (&sb->u.shmem_sb.stat_lock);
-	if (sb->u.shmem_sb.max_blocks == ULONG_MAX) {
-		/*
-		 * This is only a guestimate and not honoured.
-		 * We need it to make some programs happy which like to
-		 * test the free space of a file system.
-		 */
-		buf->f_bavail = buf->f_bfree = nr_free_pages() + nr_swap_pages + atomic_read(&buffermem_pages);
-		buf->f_blocks = buf->f_bfree + ULONG_MAX - sb->u.shmem_sb.free_blocks;
-	} else {
-		buf->f_blocks = sb->u.shmem_sb.max_blocks;
-		buf->f_bavail = buf->f_bfree = sb->u.shmem_sb.free_blocks;
-	}
+	buf->f_blocks = sb->u.shmem_sb.max_blocks;
+	buf->f_bavail = buf->f_bfree = sb->u.shmem_sb.free_blocks;
 	buf->f_files = sb->u.shmem_sb.max_inodes;
 	buf->f_ffree = sb->u.shmem_sb.free_inodes;
 	spin_unlock (&sb->u.shmem_sb.stat_lock);
@@ -1013,17 +1003,11 @@
 	return 0;
 }
 
-static int shmem_remount_fs (struct super_block *sb, int *flags, char *data)
+static int shmem_set_size(struct shmem_sb_info *info,
+			  unsigned long max_blocks, unsigned long max_inodes)
 {
 	int error;
-	unsigned long max_blocks, blocks;
-	unsigned long max_inodes, inodes;
-	struct shmem_sb_info *info = &sb->u.shmem_sb;
-
-	max_blocks = info->max_blocks;
-	max_inodes = info->max_inodes;
-	if (shmem_parse_options (data, NULL, &max_blocks, &max_inodes))
-		return -EINVAL;
+	unsigned long blocks, inodes;
 
 	spin_lock(&info->stat_lock);
 	blocks = info->max_blocks - info->free_blocks;
@@ -1043,6 +1027,17 @@
 	return error;
 }
 
+static int shmem_remount_fs (struct super_block *sb, int *flags, char *data)
+{
+	struct shmem_sb_info *info = &sb->u.shmem_sb;
+	unsigned long max_blocks = info->max_blocks;
+	unsigned long max_inodes = info->max_inodes;
+
+	if (shmem_parse_options (data, NULL, &max_blocks, &max_inodes))
+		return -EINVAL;
+	return shmem_set_size(info, max_blocks, max_inodes);
+}
+
 int shmem_sync_file(struct file * file, struct dentry *dentry, int datasync)
 {
 	return 0;
@@ -1053,9 +1048,16 @@
 {
 	struct inode * inode;
 	struct dentry * root;
-	unsigned long blocks = ULONG_MAX;	/* unlimited */
-	unsigned long inodes = ULONG_MAX;	/* unlimited */
+	unsigned long blocks, inodes;
 	int mode   = S_IRWXUGO | S_ISVTX;
+	struct sysinfo si;
+
+	/*
+	 * Per default we only allow half of the physical ram per
+	 * tmpfs instance
+	 */
+	si_meminfo(&si);
+	blocks = inodes = si.totalram / 2;
 
 #ifdef CONFIG_TMPFS
 	if (shmem_parse_options (data, &mode, &blocks, &inodes)) {
@@ -1179,6 +1181,10 @@
 		unregister_filesystem(&tmpfs_fs_type);
 		return PTR_ERR(res);
 	}
+
+	/* The internal instance should not do size checking */
+	if ((error = shmem_set_size(&res->mnt_sb->u.shmem_sb, ULONG_MAX, ULONG_MAX)))
+		printk (KERN_ERR "could not set limits on internal tmpfs\n");
 
 	return 0;
 }

