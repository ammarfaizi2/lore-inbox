Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264318AbRFOKFu>; Fri, 15 Jun 2001 06:05:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264319AbRFOKFk>; Fri, 15 Jun 2001 06:05:40 -0400
Received: from smtpde02.sap-ag.de ([194.39.131.53]:6376 "EHLO
	smtpde02.sap-ag.de") by vger.kernel.org with ESMTP
	id <S264318AbRFOKFf> convert rfc822-to-8bit; Fri, 15 Jun 2001 06:05:35 -0400
From: Christoph Rohland <cr@sap.com>
To: Alan Cox <alan@redhat.com>
Cc: Dieter =?iso-8859-1?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>,
        Joris van Rantwijk <joris@deadlock.et.tudelft.nl>,
        Oliver Paukstadt <pstadt@stud.fh-heilbronn.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.5-ac14
In-Reply-To: <20010615022033Z261561-17720+4111@vger.kernel.org>
Organisation: SAP LinuxLab
Date: 15 Jun 2001 12:01:42 +0200
In-Reply-To: Dieter =?iso-8859-1?q?N=FCtzel's?= message of "Fri, 15 Jun 2001 04:33:22 +0200"
Message-ID: <m3bsnq83jt.fsf@linux.local>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
X-SAP: out
X-SAP: out
X-SAP: out
X-SAP: out
X-SAP: out
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dieter,

On Fri, 15 Jun 2001, Dieter Nützel wrote:
> I see 4.29 GB under shm with your latest try.
> something wrong?

Yes, this is nasty. The appended patch fixes that. (I am not really
happy to need the PG_marker flag for writepage.)

The patch also fixes two other problems:
- shmem_file_setup has to check the given size. Else we can corrupt
  kernel memory on 64bit machines. (Thanks to Oliver Paukstadt for
  detecting this)
- shmem_remount_fs does not initialize the parameters and thus
  corrupts the sizes (detected by Joris van Rantwijk)

Alan, please apply.

Greetings
		Christoph

diff -uNr 5-ac14/include/linux/mm.h 5-ac14-fix/include/linux/mm.h
--- 5-ac14/include/linux/mm.h	Fri Jun 15 10:37:21 2001
+++ 5-ac14-fix/include/linux/mm.h	Fri Jun 15 11:24:06 2001
@@ -357,6 +357,7 @@
 
 #define PageMarker(page)	test_bit(PG_marker, &(page)->flags)
 #define SetPageMarker(page)	set_bit(PG_marker, &(page)->flags)
+#define ClearPageMarker(page)	clear_bit(PG_marker, &(page)->flags)
 
 #ifdef CONFIG_HIGHMEM
 #define PageHighMem(page)		test_bit(PG_highmem, &(page)->flags)
diff -uNr 5-ac14/mm/shmem.c 5-ac14-fix/mm/shmem.c
--- 5-ac14/mm/shmem.c	Fri Jun 15 10:09:21 2001
+++ 5-ac14-fix/mm/shmem.c	Fri Jun 15 11:37:44 2001
@@ -34,6 +34,7 @@
 #define TMPFS_MAGIC	0x01021994
 
 #define ENTRIES_PER_PAGE (PAGE_SIZE/sizeof(unsigned long))
+#define SHMEM_MAX_BLOCKS (SHMEM_NR_DIRECT + ENTRIES_PER_PAGE*ENTRIES_PER_PAGE)
 
 #define SHMEM_SB(sb) (&sb->u.shmem_sb)
 
@@ -56,10 +57,12 @@
 	struct inode *inode = (struct inode *)page->mapping->host;
 	struct shmem_sb_info * sbinfo = SHMEM_SB(inode->i_sb);
 
-	inode->i_blocks -= BLOCKS_PER_PAGE;
-	spin_lock (&sbinfo->stat_lock);
-	sbinfo->free_blocks++;
-	spin_unlock (&sbinfo->stat_lock);
+	if (!PageMarker(page)) {
+		inode->i_blocks -= BLOCKS_PER_PAGE;
+		spin_lock (&sbinfo->stat_lock);
+		sbinfo->free_blocks++;
+		spin_unlock (&sbinfo->stat_lock);
+	}
 	atomic_dec(&shmem_nrpages);
 }
 
@@ -241,9 +244,10 @@
 	*entry = swap;
 	error = 0;
 	/* Remove the page from the page cache */
-	atomic_dec(&shmem_nrpages);
 	lru_cache_del(page);
+	SetPageMarker(page);
 	remove_inode_page(page);
+	ClearPageMarker(page);
 
 	/* Add it to the swap cache */
 	add_to_swap_cache(page, swap);
@@ -1062,6 +1066,8 @@
 	unsigned long max_inodes, inodes;
 	struct shmem_sb_info *sbinfo = SHMEM_SB(sb);
 
+	max_blocks = sbinfo->max_blocks;
+	max_inodes = sbinfo->max_inodes;
 	if (shmem_parse_options (data, NULL, &max_blocks, &max_inodes))
 		return -EINVAL;
 
@@ -1110,7 +1116,7 @@
 	sbinfo->free_blocks = blocks;
 	sbinfo->max_inodes = inodes;
 	sbinfo->free_inodes = inodes;
-	sb->s_maxbytes = (unsigned long long)(SHMEM_NR_DIRECT + (ENTRIES_PER_PAGE*ENTRIES_PER_PAGE)) << PAGE_CACHE_SHIFT;
+	sb->s_maxbytes = (unsigned long long) SHMEM_MAX_BLOCKS << PAGE_CACHE_SHIFT;
 	sb->s_blocksize = PAGE_CACHE_SIZE;
 	sb->s_blocksize_bits = PAGE_CACHE_SHIFT;
 	sb->s_magic = TMPFS_MAGIC;
@@ -1311,9 +1317,11 @@
 	struct qstr this;
 	int vm_enough_memory(long pages);
 
-	error = -ENOMEM;
+	if (size > (unsigned long long) SHMEM_MAX_BLOCKS << PAGE_CACHE_SHIFT)
+		return ERR_PTR(-EINVAL);
+
 	if (!vm_enough_memory((size) >> PAGE_SHIFT))
-		goto out;
+		return ERR_PTR(-ENOMEM);
 
 	this.name = name;
 	this.len = strlen(name);
@@ -1321,7 +1329,7 @@
 	root = tmpfs_fs_type.kern_mnt->mnt_root;
 	dentry = d_alloc(root, &this);
 	if (!dentry)
-		goto out;
+		return ERR_PTR(-ENOMEM);
 
 	error = -ENFILE;
 	file = get_empty_filp();
@@ -1347,7 +1355,6 @@
 	put_filp(file);
 put_dentry:
 	dput (dentry);
-out:
 	return ERR_PTR(error);	
 }
 /*

