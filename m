Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129314AbQLMSC2>; Wed, 13 Dec 2000 13:02:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129345AbQLMSCS>; Wed, 13 Dec 2000 13:02:18 -0500
Received: from smtpde02.sap-ag.de ([194.39.131.53]:4013 "EHLO
	smtpde02.sap-ag.de") by vger.kernel.org with ESMTP
	id <S129314AbQLMSCG>; Wed, 13 Dec 2000 13:02:06 -0500
From: Christoph Rohland <cr@sap.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Rik van Riel <riel@conectiva.com.br>, mingo@elte.hu,
        Alan Cox <alan@redhat.com>, "Stephen C. Tweedie" <sct@redhat.com>,
        Andrea Arcangeli <andrea@suse.de>
Subject: [PATCH] shm cleanup (2)
In-Reply-To: <Pine.LNX.4.10.10011291013110.11951-100000@penguin.transmeta.com>
Organisation: SAP LinuxLab
Date: 13 Dec 2000 18:31:26 +0100
In-Reply-To: Linus Torvalds's message of "Wed, 29 Nov 2000 10:21:36 -0800 (PST)"
Message-ID: <qwwitooi5xt.fsf@sap.com>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Bryce Canyon)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Here is my latest patch. It survived ten hours stress testing on my
8way/870MB without oops. (The highmem stuff is too much io/kmap
limited and I will come back to this if we have the mm cleanup ready
:-( )

It apparently has some race condition left since I had some undead
swap entries afterwards. Also the fs accounting was screwed.

I am pretty unsure how shmem_writepage and shmem_nopage can race and
nopage hold the inode semaphore against races against itself and
truncate. Somebody out there to enlighten me?

Greetings
		Christoph

diff -uNr 4-12-8/drivers/char/mem.c c/drivers/char/mem.c
--- 4-12-8/drivers/char/mem.c	Mon Nov 13 06:55:50 2000
+++ c/drivers/char/mem.c	Mon Dec 11 19:42:33 2000
@@ -438,7 +438,7 @@
 static int mmap_zero(struct file * file, struct vm_area_struct * vma)
 {
 	if (vma->vm_flags & VM_SHARED)
-		return map_zero_setup(vma);
+		return shmem_zero_setup(vma);
 	if (zeromap_page_range(vma->vm_start, vma->vm_end - vma->vm_start, vma->vm_page_prot))
 		return -EAGAIN;
 	return 0;
diff -uNr 4-12-8/include/linux/fs.h c/include/linux/fs.h
--- 4-12-8/include/linux/fs.h	Mon Dec 11 19:41:42 2000
+++ c/include/linux/fs.h	Wed Dec 13 10:33:04 2000
@@ -283,6 +283,7 @@
 #include <linux/efs_fs_i.h>
 #include <linux/coda_fs_i.h>
 #include <linux/romfs_fs_i.h>
+#include <linux/shmem_fs.h>
 #include <linux/smb_fs_i.h>
 #include <linux/hfs_fs_i.h>
 #include <linux/adfs_fs_i.h>
@@ -354,6 +355,7 @@
 struct address_space_operations {
 	int (*writepage)(struct page *);
 	int (*readpage)(struct file *, struct page *);
+	struct page * (*getpage)(struct address_space *, unsigned long); /* readpage with alloc */
 	int (*sync_page)(struct page *);
 	int (*prepare_write)(struct file *, struct page *, unsigned, unsigned);
 	int (*commit_write)(struct file *, struct page *, unsigned, unsigned);
@@ -441,6 +443,7 @@
 		struct ufs_inode_info		ufs_i;
 		struct efs_inode_info		efs_i;
 		struct romfs_inode_info		romfs_i;
+		struct shmem_inode_info		shmem_i;
 		struct coda_inode_info		coda_i;
 		struct smb_inode_info		smbfs_i;
 		struct hfs_inode_info		hfs_i;
@@ -685,6 +688,7 @@
 		struct affs_sb_info	affs_sb;
 		struct ufs_sb_info	ufs_sb;
 		struct efs_sb_info	efs_sb;
+		struct shmem_sb_info	shmem_sb;
 		struct romfs_sb_info	romfs_sb;
 		struct smb_sb_info	smbfs_sb;
 		struct hfs_sb_info	hfs_sb;
diff -uNr 4-12-8/include/linux/mm.h c/include/linux/mm.h
--- 4-12-8/include/linux/mm.h	Mon Dec 11 19:41:42 2000
+++ c/include/linux/mm.h	Wed Dec 13 10:33:05 2000
@@ -129,15 +129,6 @@
 };
 
 /*
- * A swap entry has to fit into a "unsigned long", as
- * the entry is hidden in the "index" field of the
- * swapper address space.
- */
-typedef struct {
-	unsigned long val;
-} swp_entry_t;
-
-/*
  * Try to keep the most commonly accessed fields in single cache lines
  * here (16 bytes or greater).  This ordering should be particularly
  * beneficial on 32-bit processors.
@@ -390,7 +381,10 @@
 
 extern void clear_page_tables(struct mm_struct *, unsigned long, int);
 
-extern int map_zero_setup(struct vm_area_struct *);
+int shmem_swapout(struct page * page, struct file *file);
+struct page * shmem_nopage(struct vm_area_struct * vma, unsigned long address, int no_share);
+struct file *shmem_file_setup(char * name, loff_t size);
+extern int shmem_zero_setup(struct vm_area_struct *);
 
 extern void zap_page_range(struct mm_struct *mm, unsigned long address, unsigned long size);
 extern int copy_page_range(struct mm_struct *dst, struct mm_struct *src, struct vm_area_struct *vma);
diff -uNr 4-12-8/include/linux/pagemap.h c/include/linux/pagemap.h
--- 4-12-8/include/linux/pagemap.h	Mon Dec  4 18:07:05 2000
+++ c/include/linux/pagemap.h	Wed Dec 13 10:33:05 2000
@@ -67,6 +67,8 @@
 
 #define page_hash(mapping,index) (page_hash_table+_page_hashfn(mapping,index))
 
+extern struct page * __find_get_page(struct address_space *mapping,
+				     unsigned long offset, struct page **hash);
 extern struct page * __find_lock_page (struct address_space * mapping,
 				unsigned long index, struct page **hash);
 extern void lock_page(struct page *page);
diff -uNr 4-12-8/include/linux/shmem_fs.h c/include/linux/shmem_fs.h
--- 4-12-8/include/linux/shmem_fs.h	Thu Jan  1 01:00:00 1970
+++ c/include/linux/shmem_fs.h	Wed Dec 13 11:04:22 2000
@@ -0,0 +1,37 @@
+#ifndef __SHMEM_FS_H
+#define __SHMEM_FS_H
+
+/* inode in-kernel data */
+
+#define SHMEM_NR_DIRECT 16
+
+/*
+ * A swap entry has to fit into a "unsigned long", as
+ * the entry is hidden in the "index" field of the
+ * swapper address space.
+ */
+typedef struct {
+	unsigned long val;
+} swp_entry_t;
+
+struct shmem_inode_info {
+	swp_entry_t	i_direct[SHMEM_NR_DIRECT]; /* for the first blocks */
+	swp_entry_t    *i_indirect; /* indirect blocks	  */
+	swp_entry_t   **i_double;   /* doubly indirect blocks */
+	struct list_head	list;
+	spinlock_t	stat_lock; /* This protects the swapped
+                                      field. We need it since
+                                      shmem_writepage has to modify it
+                                      and cannot get inode->i_sem */
+        unsigned long	swapped;
+};
+
+struct shmem_sb_info {
+	unsigned long max_blocks;   /* How many blocks are allowed */
+	unsigned long free_blocks;  /* How many are left for allocation */
+	unsigned long max_inodes;   /* How many inodes are allowed */
+	unsigned long free_inodes;  /* How many are left for allocation */
+	spinlock_t    stat_lock;
+};
+
+#endif
diff -uNr 4-12-8/include/linux/swap.h c/include/linux/swap.h
--- 4-12-8/include/linux/swap.h	Mon Dec 11 19:41:43 2000
+++ c/include/linux/swap.h	Mon Dec 11 19:44:13 2000
@@ -291,6 +291,8 @@
 #define swap_device_lock(p)	spin_lock(&p->sdev_lock)
 #define swap_device_unlock(p)	spin_unlock(&p->sdev_lock)
 
+extern void shmem_unuse(swp_entry_t entry, struct page *page);
+
 #endif /* __KERNEL__*/
 
 #endif /* _LINUX_SWAP_H */
diff -uNr 4-12-8/ipc/shm.c c/ipc/shm.c
--- 4-12-8/ipc/shm.c	Mon Dec 11 19:41:43 2000
+++ c/ipc/shm.c	Wed Dec 13 10:04:00 2000
@@ -9,23 +9,10 @@
  * BIGMEM support, Andrea Arcangeli <andrea@suse.de>
  * SMP thread shm, Jean-Luc Boyard <jean-luc.boyard@siemens.fr>
  * HIGHMEM support, Ingo Molnar <mingo@redhat.com>
- * avoid vmalloc and make shmmax, shmall, shmmni sysctl'able,
- *                         Christoph Rohland <hans-christoph.rohland@sap.com>
  * Shared /dev/zero support, Kanoj Sarcar <kanoj@sgi.com>
- * make it a file system,  Christoph Rohland <hans-christoph.rohland@sap.com>
+ * Move the mm functionality over to mm/shmem.c
+ *					Christoph Rohland <cr@sap.com>
  *
- * The filesystem has the following restrictions/bugs:
- * 1) It only can handle one directory.
- * 2) Private writeable mappings are not supported
- * 3) Read and write are not implemented (should they?)
- * 4) No special nodes are supported
- *
- * There are the following mount options:
- * - nr_blocks (^= shmall) is the number of blocks of size PAGE_SIZE
- *   we are allowed to allocate
- * - nr_inodes (^= shmmni) is the number of files we are allowed to
- *   allocate
- * - mode is the mode for the root directory (default S_IRWXUGO | S_ISVTX)
  */
 
 #include <linux/config.h>
@@ -48,65 +35,24 @@
 
 #include "util.h"
 
-static struct super_block *shm_read_super(struct super_block *,void *, int);
-static void	      shm_put_super  (struct super_block *);
-static int	      shm_remount_fs (struct super_block *, int *, char *);
-static void	      shm_read_inode (struct inode *);
-static int	      shm_statfs   (struct super_block *, struct statfs *);
-static int	      shm_create   (struct inode *,struct dentry *,int);
-static struct dentry *shm_lookup   (struct inode *,struct dentry *);
-static int	      shm_unlink   (struct inode *,struct dentry *);
-static int	      shm_setattr  (struct dentry *dent, struct iattr *attr);
-static void	      shm_delete   (struct inode *);
-static int	      shm_mmap	   (struct file *, struct vm_area_struct *);
-static int	      shm_readdir  (struct file *, void *, filldir_t);
-
-#define SHM_NAME_LEN NAME_MAX
-#define SHM_FMT ".IPC_%08x"
-#define SHM_FMT_LEN 13
-
-/* shm_mode upper byte flags */
-/* SHM_DEST and SHM_LOCKED are used in ipcs(8) */
-#define PRV_DEST	0010000	/* segment will be destroyed on last detach */
-#define PRV_LOCKED	0020000	/* segment will not be swapped */
-#define SHM_UNLK	0040000	/* filename is unlinked */
-#define SHM_SYSV	0100000	/* It is a SYSV shm segment */
-
 struct shmid_kernel /* private to the kernel */
 {	
 	struct kern_ipc_perm	shm_perm;
-	size_t			shm_segsz;
-	unsigned long		shm_nattch;
-	unsigned long		shm_npages; /* size of segment (pages) */
-	pte_t			**shm_dir;  /* ptr to arr of ptrs to frames */ 
+	struct file *		shm_file;
 	int			id;
-	union permap {
-		struct shmem {
-			time_t			atime;
-			time_t			dtime;
-			time_t			ctime;
-			pid_t			cpid;
-			pid_t			lpid;
-			int			nlen;
-			char			nm[0];
-		} shmem;
-		struct zero {
-			struct semaphore	sema;
-			struct list_head	list;
-		} zero;
-	} permap;
+	unsigned long		shm_nattch;
+	unsigned long		shm_segsz;
+	time_t			shm_atim;
+	time_t			shm_dtim;
+	time_t			shm_ctim;
+	pid_t			shm_cprid;
+	pid_t			shm_lprid;
 };
 
-#define shm_atim	permap.shmem.atime
-#define shm_dtim	permap.shmem.dtime
-#define shm_ctim	permap.shmem.ctime
-#define shm_cprid	permap.shmem.cpid
-#define shm_lprid	permap.shmem.lpid
-#define shm_namelen	permap.shmem.nlen
-#define shm_name	permap.shmem.nm
 #define shm_flags	shm_perm.mode
-#define zsem		permap.zero.sema
-#define zero_list	permap.zero.list
+
+static struct file_operations shm_file_operations;
+static struct vm_operations_struct shm_vm_ops;
 
 static struct ipc_ids shm_ids;
 
@@ -118,207 +64,27 @@
 #define shm_buildid(id, seq) \
 	ipc_buildid(&shm_ids, id, seq)
 
-static int newseg (key_t key, const char *name, int namelen, int shmflg, size_t size);
-static void seg_free(struct shmid_kernel *shp, int doacc);
+static int newseg (key_t key, int shmflg, size_t size);
 static void shm_open (struct vm_area_struct *shmd);
 static void shm_close (struct vm_area_struct *shmd);
-static int shm_remove_name(int id);
-static struct page * shm_nopage(struct vm_area_struct *, unsigned long, int);
-static int shm_swapout(struct page *, struct file *);
 #ifdef CONFIG_PROC_FS
 static int sysvipc_shm_read_proc(char *buffer, char **start, off_t offset, int length, int *eof, void *data);
 #endif
 
-static void zmap_unuse(swp_entry_t entry, struct page *page);
-static void shmzero_open(struct vm_area_struct *shmd);
-static void shmzero_close(struct vm_area_struct *shmd);
-static struct page *shmzero_nopage(struct vm_area_struct * shmd, unsigned long address, int no_share);
-static int zero_id;
-static struct shmid_kernel zshmid_kernel;
-static struct dentry *zdent;
-
-#define SHM_FS_MAGIC 0x02011994
-
-static struct super_block * shm_sb;
-
-static DECLARE_FSTYPE(shm_fs_type, "shm", shm_read_super, FS_SINGLE);
-
-static struct super_operations shm_sops = {
-	read_inode:	shm_read_inode,
-	delete_inode:	shm_delete,
-	put_super:	shm_put_super,
-	statfs:		shm_statfs,
-	remount_fs:	shm_remount_fs,
-};
-
-static struct file_operations shm_root_operations = {
-	readdir:	shm_readdir,
-};
-
-static struct inode_operations shm_root_inode_operations = {
-	create:		shm_create,
-	lookup:		shm_lookup,
-	unlink:		shm_unlink,
-};
-
-static struct file_operations shm_file_operations = {
-	mmap:	shm_mmap,
-};
-
-static struct inode_operations shm_inode_operations = {
-	setattr:	shm_setattr,
-};
-
-static struct vm_operations_struct shm_vm_ops = {
-	open:	shm_open,	/* callback for a new vm-area open */
-	close:	shm_close,	/* callback for when the vm-area is released */
-	nopage:	shm_nopage,
-	swapout:shm_swapout,
-};
-
-size_t shm_ctlmax = SHMMAX;
-
-/* These parameters should be part of the superblock */
-static int shm_ctlall;
-static int shm_ctlmni;
-static int shm_mode;
+size_t	shm_ctlmax = SHMMAX;
+size_t 	shm_ctlall = SHMALL;
+int 	shm_ctlmni = SHMMNI;
 
 static int shm_tot; /* total number of shared memory pages */
-static int shm_rss; /* number of shared memory pages that are in memory */
-static int shm_swp; /* number of shared memory pages that are in swap */
-
-/* locks order:
-	pagecache_lock
-	shm_lock()/shm_lockall()
-	kernel lock
-	inode->i_sem
-	sem_ids.sem
-	mmap_sem
-
-  SMP assumptions:
-  - swap_free() never sleeps
-  - add_to_swap_cache() never sleeps
-  - add_to_swap_cache() doesn't acquire the big kernel lock.
-  - shm_unuse() is called with the kernel lock acquired.
- */
-
-/* some statistics */
-static ulong swap_attempts;
-static ulong swap_successes;
 
 void __init shm_init (void)
 {
-	struct vfsmount *res;
 	ipc_init_ids(&shm_ids, 1);
-
-	register_filesystem (&shm_fs_type);
-	res = kern_mount(&shm_fs_type);
-	if (IS_ERR(res)) {
-		unregister_filesystem(&shm_fs_type);
-		return;
-	}
-#ifdef CONFIG_PROC_FS
 	create_proc_read_entry("sysvipc/shm", 0, 0, sysvipc_shm_read_proc, NULL);
-#endif
-	zero_id = ipc_addid(&shm_ids, &zshmid_kernel.shm_perm, 1);
-	shm_unlock(zero_id);
-	INIT_LIST_HEAD(&zshmid_kernel.zero_list);
-	zdent = d_alloc_root(get_empty_inode());
-	return;
-}
-
-static int shm_parse_options(char *options)
-{
-	int blocks = shm_ctlall;
-	int inodes = shm_ctlmni;
-	umode_t mode = shm_mode;
-	char *this_char, *value;
-
-	this_char = NULL;
-	if ( options )
-		this_char = strtok(options,",");
-	for ( ; this_char; this_char = strtok(NULL,",")) {
-		if ((value = strchr(this_char,'=')) != NULL)
-			*value++ = 0;
-		if (!strcmp(this_char,"nr_blocks")) {
-			if (!value || !*value)
-				return 1;
-			blocks = simple_strtoul(value,&value,0);
-			if (*value)
-				return 1;
-		}
-		else if (!strcmp(this_char,"nr_inodes")) {
-			if (!value || !*value)
-				return 1;
-			inodes = simple_strtoul(value,&value,0);
-			if (*value)
-				return 1;
-		}
-		else if (!strcmp(this_char,"mode")) {
-			if (!value || !*value)
-				return 1;
-			mode = simple_strtoul(value,&value,8);
-			if (*value)
-				return 1;
-		}
-		else
-			return 1;
-	}
-	shm_ctlmni = inodes;
-	shm_ctlall = blocks;
-	shm_mode   = mode;
-
-	return 0;
-}
-
-static struct super_block *shm_read_super(struct super_block *s,void *data, 
-					  int silent)
-{
-	struct inode * root_inode;
-
-	shm_ctlall = SHMALL;
-	shm_ctlmni = SHMMNI;
-	shm_mode   = S_IRWXUGO | S_ISVTX;
-	if (shm_parse_options (data)) {
-		printk(KERN_ERR "shm fs invalid option\n");
-		goto out_unlock;
-	}
-
-	s->s_blocksize = PAGE_SIZE;
-	s->s_blocksize_bits = PAGE_SHIFT;
-	s->s_magic = SHM_FS_MAGIC;
-	s->s_op = &shm_sops;
-	root_inode = iget (s, SEQ_MULTIPLIER);
-	if (!root_inode)
-		goto out_no_root;
-	root_inode->i_op = &shm_root_inode_operations;
-	root_inode->i_sb = s;
-	root_inode->i_nlink = 2;
-	root_inode->i_mode = S_IFDIR | shm_mode;
-	s->s_root = d_alloc_root(root_inode);
-	if (!s->s_root)
-		goto out_no_root;
-	shm_sb = s;
-	return s;
-
-out_no_root:
-	printk(KERN_ERR "shm_read_super: get root inode failed\n");
-	iput(root_inode);
-out_unlock:
-	return NULL;
-}
-
-static int shm_remount_fs (struct super_block *sb, int *flags, char *data)
-{
-	if (shm_parse_options (data))
-		return -EINVAL;
-	return 0;
 }
 
 static inline int shm_checkid(struct shmid_kernel *s, int id)
 {
-	if (!(s->shm_flags & SHM_SYSV))
-		return -EINVAL;
 	if (ipc_checkid(&shm_ids,&s->shm_perm,id))
 		return -EIDRM;
 	return 0;
@@ -334,460 +100,137 @@
 	return ipc_addid(&shm_ids, &shp->shm_perm, shm_ctlmni+1);
 }
 
-static void shm_put_super(struct super_block *sb)
-{
-	int i;
-	struct shmid_kernel *shp;
-
-	down(&shm_ids.sem);
-	for(i = 0; i <= shm_ids.max_id; i++) {
-		if (i == zero_id)
-			continue;
-		if (!(shp = shm_lock (i)))
-			continue;
-		if (shp->shm_nattch)
-			printk(KERN_DEBUG "shm_nattch = %ld\n", shp->shm_nattch);
-		shp = shm_rmid(i);
-		shm_unlock(i);
-		seg_free(shp, 1);
-	}
-	dput (sb->s_root);
-	up(&shm_ids.sem);
-}
-
-static int shm_statfs(struct super_block *sb, struct statfs *buf)
-{
-	buf->f_type = SHM_FS_MAGIC;
-	buf->f_bsize = PAGE_SIZE;
-	buf->f_blocks = shm_ctlall;
-	buf->f_bavail = buf->f_bfree = shm_ctlall - shm_tot;
-	buf->f_files = shm_ctlmni;
-	shm_lockall();
-	buf->f_ffree = shm_ctlmni - shm_ids.in_use + 1;
-	shm_unlockall();
-	buf->f_namelen = SHM_NAME_LEN;
-	return 0;
-}
-
-static void shm_read_inode(struct inode * inode)
-{
-	int id;
-	struct shmid_kernel *shp;
-
-	id = inode->i_ino;
-	inode->i_mode = 0;
-	inode->i_mtime = inode->i_atime = inode->i_ctime = CURRENT_TIME;
-
-	if (id < SEQ_MULTIPLIER) {
-		if (!(shp = shm_lock (id))) {
-			make_bad_inode(inode);
-			return;
-		}
-		inode->i_mode = (shp->shm_flags & S_IALLUGO) | S_IFREG;
-		inode->i_uid  = shp->shm_perm.uid;
-		inode->i_gid  = shp->shm_perm.gid;
-		inode->i_size = shp->shm_segsz;
-		shm_unlock (id);
-		inode->i_op  = &shm_inode_operations;
-		inode->i_fop = &shm_file_operations;
-		return;
-	}
-	inode->i_op    = &shm_root_inode_operations;
-	inode->i_fop   = &shm_root_operations;
-	inode->i_sb    = shm_sb;
-	inode->i_nlink = 2;
-	inode->i_mode  = S_IFDIR | shm_mode;
-	inode->i_uid   = inode->i_gid = 0;
-
-}
-
-static int shm_create (struct inode *dir, struct dentry *dent, int mode)
-{
-	int id, err;
-	struct inode * inode;
-
-	down(&shm_ids.sem);
-	err = id = newseg (IPC_PRIVATE, dent->d_name.name, dent->d_name.len, mode, 0);
-	if (err < 0)
-		goto out;
-
-	err = -ENOMEM;
-	inode = iget (shm_sb, id % SEQ_MULTIPLIER);
-	if (!inode)
-		goto out;
 
-	err = 0;
-	down (&inode->i_sem);
-	inode->i_mode = mode | S_IFREG;
-	inode->i_op   = &shm_inode_operations;
-	d_instantiate(dent, inode);
-	up (&inode->i_sem);
-
-out:
-	up(&shm_ids.sem);
-	return err;
-}
 
-static int shm_readdir (struct file *filp, void *dirent, filldir_t filldir)
-{
-	struct inode * inode = filp->f_dentry->d_inode;
+static inline void shm_inc (int id) {
 	struct shmid_kernel *shp;
-	off_t nr;
-
-	nr = filp->f_pos;
-
-	switch(nr)
-	{
-	case 0:
-		if (filldir(dirent, ".", 1, nr, inode->i_ino, DT_DIR) < 0)
-			return 0;
-		filp->f_pos = ++nr;
-		/* fall through */
-	case 1:
-		if (filldir(dirent, "..", 2, nr, inode->i_ino, DT_DIR) < 0)
-			return 0;
-		filp->f_pos = ++nr;
-		/* fall through */
-	default:
-		down(&shm_ids.sem);
-		for (; nr-2 <= shm_ids.max_id; nr++ ) {
-			if (nr-2 == zero_id)
-				continue;
-			if (!(shp = shm_get (nr-2))) 
-				continue;
-			if (shp->shm_flags & SHM_UNLK)
-				continue;
-			if (filldir(dirent, shp->shm_name, shp->shm_namelen, nr, nr, DT_REG) < 0 )
-				break;;
-		}
-		filp->f_pos = nr;
-		up(&shm_ids.sem);
-		break;
-	}
-
-	UPDATE_ATIME(inode);
-	return 0;
-}
-
-static struct dentry *shm_lookup (struct inode *dir, struct dentry *dent)
-{
-	int i, err = 0;
-	struct shmid_kernel* shp;
-	struct inode *inode = NULL;
-
-	if (dent->d_name.len > SHM_NAME_LEN)
-		return ERR_PTR(-ENAMETOOLONG);
-
-	down(&shm_ids.sem);
-	for(i = 0; i <= shm_ids.max_id; i++) {
-		if (i == zero_id)
-			continue;
-		if (!(shp = shm_lock(i)))
-			continue;
-		if (!(shp->shm_flags & SHM_UNLK) &&
-		    dent->d_name.len == shp->shm_namelen &&
-		    strncmp(dent->d_name.name, shp->shm_name, shp->shm_namelen) == 0)
-			goto found;
-		shm_unlock(i);
-	}
 
-	/*
-	 * prevent the reserved names as negative dentries. 
-	 * This also prevents object creation through the filesystem
-	 */
-	if (dent->d_name.len == SHM_FMT_LEN &&
-	    memcmp (SHM_FMT, dent->d_name.name, SHM_FMT_LEN - 8) == 0)
-		err = -EINVAL;	/* EINVAL to give IPC_RMID the right error */
-
-	goto out;
-
-found:
-	shm_unlock(i);
-	inode = iget(dir->i_sb, i);
-
-	if (!inode)
-		err = -EACCES;
-out:
-	if (err == 0)
-		d_add (dent, inode);
-	up (&shm_ids.sem);
-	return ERR_PTR(err);
+	if(!(shp = shm_lock(id)))
+		BUG();
+	shp->shm_atim = CURRENT_TIME;
+	shp->shm_lprid = current->pid;
+	shm_unlock(id);
 }
 
-static int shm_unlink (struct inode *dir, struct dentry *dent)
+/* This is called by fork, once for every shm attach. */
+static void shm_open (struct vm_area_struct *shmd)
 {
-	struct inode * inode = dent->d_inode;
-	struct shmid_kernel *shp;
-
-	down (&shm_ids.sem);
-	if (!(shp = shm_lock (inode->i_ino)))
-		BUG();
-	shp->shm_flags |= SHM_UNLK | PRV_DEST;
-	shp->shm_perm.key = IPC_PRIVATE; /* Do not find it any more */
-	shm_unlock (inode->i_ino);
-	up (&shm_ids.sem);
-	inode->i_nlink -= 1;
-	/*
-	 * If it's a reserved name we have to drop the dentry instead
-	 * of creating a negative dentry
-	 */
-	if (dent->d_name.len == SHM_FMT_LEN &&
-	    memcmp (SHM_FMT, dent->d_name.name, SHM_FMT_LEN - 8) == 0)
-		d_drop (dent);
-	return 0;
+	shm_inc (shmd->vm_file->f_dentry->d_inode->i_ino);
 }
 
 /*
- * We cannot use kmalloc for shm_alloc since this restricts the
- * maximum size of the segments.
- *
- * We also cannot use vmalloc, since this uses too much of the vmalloc
- * space and we run out of this on highend machines.
+ * shm_destroy - free the struct shmid_kernel
  *
- * So we have to use this complicated indirect scheme to alloc the shm
- * page tables.
+ * @shp: struct to free
  *
+ * It has to be called with shp and shm_ids.sem locked and will
+ * release them
  */
-
-#ifdef PTE_INIT
-static inline void init_ptes (pte_t *pte, int number) {
-	while (number--)
-		PTE_INIT (pte++);
-}
-#else
-static inline void init_ptes (pte_t *pte, int number) {
-	memset (pte, 0, number*sizeof(*pte));
-}
-#endif
-
-#define PTES_PER_PAGE (PAGE_SIZE/sizeof(pte_t))
-#define SHM_ENTRY(shp, index) (shp)->shm_dir[(index)/PTES_PER_PAGE][(index)%PTES_PER_PAGE]
-
-static pte_t **shm_alloc(unsigned long pages, int doacc)
-{
-	unsigned short dir  = pages / PTES_PER_PAGE;
-	unsigned short last = pages % PTES_PER_PAGE;
-	pte_t **ret, **ptr;
-
-	if (pages == 0)
-		return NULL;
-
-	ret = kmalloc ((dir+1) * sizeof(pte_t *), GFP_USER);
-	if (!ret)
-		goto nomem;
-
-	for (ptr = ret; ptr < ret+dir ; ptr++)
-	{
-		*ptr = (pte_t *)__get_free_page (GFP_USER);
-		if (!*ptr)
-			goto free;
-		init_ptes (*ptr, PTES_PER_PAGE);
-	}
-
-	/* The last one is probably not of PAGE_SIZE: we use kmalloc */
-	if (last) {
-		*ptr = kmalloc (last*sizeof(pte_t), GFP_USER);
-		if (!*ptr)
-			goto free;
-		init_ptes (*ptr, last);
-	}
-	if (doacc) {
-		shm_lockall();
-		shm_tot += pages;
-		shm_unlockall();
-	}
-	return ret;
-
-free:
-	/* The last failed: we decrement first */
-	while (--ptr >= ret)
-		free_page ((unsigned long)*ptr);
-
-	kfree (ret);
-nomem:
-	return ERR_PTR(-ENOMEM);
-}
-
-static void shm_free(pte_t** dir, unsigned long pages, int doacc)
+static void shm_destroy (struct shmid_kernel *shp)
 {
-	int i, rss, swp;
-	pte_t **ptr = dir+pages/PTES_PER_PAGE;
-
-	if (!dir)
-		return;
-
-	for (i = 0, rss = 0, swp = 0; i < pages ; i++) {
-		pte_t pte;
-		pte = dir[i/PTES_PER_PAGE][i%PTES_PER_PAGE];
-		if (pte_none(pte))
-			continue;
-		if (pte_present(pte)) {
-			__free_page (pte_page(pte));
-			rss++;
-		} else {
-			swap_free(pte_to_swp_entry(pte));
-			swp++;
-		}
-	}
-
-	/* first the last page */
-	if (pages%PTES_PER_PAGE)
-		kfree (*ptr);
-	/* now the whole pages */
-	while (--ptr >= dir)
-		if (*ptr)
-			free_page ((unsigned long)*ptr);
-
-	/* Now the indirect block */
-	kfree (dir);
+	struct file * file = shp->shm_file;
 
-	if (doacc) {
-		shm_lockall();
-		shm_rss -= rss;
-		shm_swp -= swp;
-		shm_tot -= pages;
-		shm_unlockall();
-	}
+	shp->shm_file = NULL;
+	shm_tot -= (shp->shm_segsz + PAGE_SIZE - 1) >> PAGE_SHIFT;
+	shm_unlock (shp->id);
+	shm_rmid (shp->id);
+	kfree (shp);
+	up (&shm_ids.sem);
+	/* put the file outside the critical path to prevent recursion */
+	fput (file);
 }
 
-static 	int shm_setattr (struct dentry *dentry, struct iattr *attr)
+/*
+ * remove the attach descriptor shmd.
+ * free memory for segment if it is marked destroyed.
+ * The descriptor has already been removed from the current->mm->mmap list
+ * and will later be kfree()d.
+ */
+static void shm_close (struct vm_area_struct *shmd)
 {
-	int error;
-	struct inode *inode = dentry->d_inode;
+	struct file * file = shmd->vm_file;
+	int id = file->f_dentry->d_inode->i_ino;
 	struct shmid_kernel *shp;
-	unsigned long new_pages, old_pages;
-	pte_t **new_dir, **old_dir;
-
-	error = inode_change_ok(inode, attr);
-	if (error)
-		return error;
-	if (!(attr->ia_valid & ATTR_SIZE))
-		goto set_attr;
-	if (attr->ia_size > shm_ctlmax)
-		return -EFBIG;
-
-	/* We set old_pages and old_dir for easier cleanup */
-	old_pages = new_pages = (attr->ia_size  + PAGE_SIZE - 1) >> PAGE_SHIFT;
-	old_dir = new_dir = shm_alloc(new_pages, 1);
-	if (IS_ERR(new_dir))
-		return PTR_ERR(new_dir);
 
-	if (!(shp = shm_lock(inode->i_ino)))
-		BUG();
-	error = -ENOSPC;
-	if (shm_tot - shp->shm_npages >= shm_ctlall)
-		goto size_out;
-	error = 0;
-	if (shp->shm_segsz == attr->ia_size)
-		goto size_out;
-	/* Now we set them to the real values */
-	old_dir = shp->shm_dir;
-	old_pages = shp->shm_npages;
-	if (old_dir){
-		pte_t *swap;
-		int i,j;
-		i = old_pages < new_pages ? old_pages : new_pages;
-		j = i % PTES_PER_PAGE;
-		i /= PTES_PER_PAGE;
-		if (j)
-			memcpy (new_dir[i], old_dir[i], j * sizeof (pte_t));
-		while (i--) {
-			swap = new_dir[i];
-			new_dir[i] = old_dir[i];
-			old_dir[i] = swap;
-		}
-	}
-	shp->shm_dir = new_dir;
-	shp->shm_npages = new_pages;
-	shp->shm_segsz = attr->ia_size;
-size_out:
-	shm_unlock(inode->i_ino);
-	shm_free (old_dir, old_pages, 1);
-
-set_attr:
-	if (!(shp = shm_lock(inode->i_ino)))
+	down (&shm_ids.sem);
+	/* remove from the list of attaches of the shm segment */
+	if(!(shp = shm_lock(id)))
 		BUG();
-	if (attr->ia_valid & ATTR_MODE)
-		shp->shm_perm.mode = attr->ia_mode;
-	if (attr->ia_valid & ATTR_UID)
-		shp->shm_perm.uid = attr->ia_uid;
-	if (attr->ia_valid & ATTR_GID)
-		shp->shm_perm.gid = attr->ia_gid;
-	shm_unlock (inode->i_ino);
+	shp->shm_lprid = current->pid;
+	shp->shm_dtim = CURRENT_TIME;
+	if(shp->shm_flags & SHM_DEST &&
+	   file_count (file) == 2) /* shp and the vma have the last
+                                      references*/
+		return shm_destroy (shp);
 
-	inode_setattr(inode, attr);
-	return error;
+	shm_unlock(id);
+	up (&shm_ids.sem);
 }
 
-static struct shmid_kernel *seg_alloc(int numpages, size_t namelen)
+static int shm_mmap(struct file * file, struct vm_area_struct * vma)
 {
-	struct shmid_kernel *shp;
-	pte_t		   **dir;
-
-	shp = (struct shmid_kernel *) kmalloc (sizeof (*shp) + namelen, GFP_USER);
-	if (!shp)
-		return ERR_PTR(-ENOMEM);
-
-	dir = shm_alloc (numpages, namelen);
-	if (IS_ERR(dir)) {
-		kfree(shp);
-		return ERR_PTR(PTR_ERR(dir));
-	}
-	shp->shm_dir    = dir;
-	shp->shm_npages = numpages;
-	shp->shm_nattch = 0;
-	shp->shm_namelen = namelen;
-	return(shp);
+	UPDATE_ATIME(file->f_dentry->d_inode);
+	vma->vm_ops = &shm_vm_ops;
+	shm_inc(file->f_dentry->d_inode->i_ino);
+	return 0;
 }
 
-static void seg_free(struct shmid_kernel *shp, int doacc)
-{
-	shm_free (shp->shm_dir, shp->shm_npages, doacc);
-	kfree(shp);
-}
+static struct file_operations shm_file_operations = {
+	mmap:		shm_mmap
+};
 
-static int newseg (key_t key, const char *name, int namelen,
-		   int shmflg, size_t size)
+static struct vm_operations_struct shm_vm_ops = {
+	open:	shm_open,	/* callback for a new vm-area open */
+	close:	shm_close,	/* callback for when the vm-area is released */
+	nopage:	shmem_nopage,
+	swapout:shmem_swapout,
+};
+
+static int newseg (key_t key, int shmflg, size_t size)
 {
+	int error;
 	struct shmid_kernel *shp;
 	int numpages = (size + PAGE_SIZE -1) >> PAGE_SHIFT;
+	struct file * file;
+	char name[13];
 	int id;
 
-	if (namelen > SHM_NAME_LEN)
-		return -ENAMETOOLONG;
-
-	if (size > shm_ctlmax)
-		return -EINVAL;
-		
 	if (shm_tot + numpages >= shm_ctlall)
 		return -ENOSPC;
 
-	shp = seg_alloc(numpages, namelen ? namelen : SHM_FMT_LEN + 1);
-	if (IS_ERR(shp))
-		return PTR_ERR(shp);
+	shp = (struct shmid_kernel *) kmalloc (sizeof (*shp), GFP_USER);
+	if (!shp)
+		return -ENOMEM;
+	sprintf (name, "SYSV%08x", key);
+	file = shmem_file_setup(name, size);
+	error = PTR_ERR(file);
+	if (IS_ERR(file))
+		goto no_file;
+
+	error = -ENOSPC;
 	id = shm_addid(shp);
-	if(id == -1) {
-		seg_free(shp, 1);
-		return -ENOSPC;
-	}
+	if(id == -1) 
+		goto no_id;
 	shp->shm_perm.key = key;
 	shp->shm_flags = (shmflg & S_IRWXUGO);
-	shp->shm_segsz = size;
 	shp->shm_cprid = current->pid;
 	shp->shm_lprid = 0;
 	shp->shm_atim = shp->shm_dtim = 0;
 	shp->shm_ctim = CURRENT_TIME;
+	shp->shm_segsz = size;
 	shp->id = shm_buildid(id,shp->shm_perm.seq);
-	if (namelen != 0) {
-		shp->shm_namelen = namelen;
-		memcpy (shp->shm_name, name, namelen);		  
-	} else {
-		shp->shm_flags |= SHM_SYSV;
-		shp->shm_namelen = sprintf (shp->shm_name, SHM_FMT, shp->id);
-	}
-	shm_unlock(id);
-	
+	shp->shm_file = file;
+	file->f_dentry->d_inode->i_ino = id;
+	file->f_op = &shm_file_operations;
+	shm_tot += numpages;
+	shm_unlock (id);
 	return shp->id;
+
+no_id:
+	fput(file);
+no_file:
+	kfree(shp);
+	return error;
 }
 
 asmlinkage long sys_shmget (key_t key, size_t size, int shmflg)
@@ -795,17 +238,17 @@
 	struct shmid_kernel *shp;
 	int err, id = 0;
 
-	if (size < SHMMIN)
+	if (size < SHMMIN || size > shm_ctlmax)
 		return -EINVAL;
 
 	down(&shm_ids.sem);
 	if (key == IPC_PRIVATE) {
-		err = newseg(key, NULL, 0, shmflg, size);
-	} else if ((id = ipc_findkey(&shm_ids,key)) == -1) {
+		err = newseg(key, shmflg, size);
+	} else if ((id = ipc_findkey(&shm_ids, key)) == -1) {
 		if (!(shmflg & IPC_CREAT))
 			err = -ENOENT;
 		else
-			err = newseg(key, NULL, 0, shmflg, size);
+			err = newseg(key, shmflg, size);
 	} else if ((shmflg & IPC_CREAT) && (shmflg & IPC_EXCL)) {
 		err = -EEXIST;
 	} else {
@@ -824,24 +267,6 @@
 	return err;
 }
 
-/* FIXME: maybe we need lock_kernel() here */
-static void shm_delete (struct inode *ino)
-{
-	int shmid = ino->i_ino;
-	struct shmid_kernel *shp;
-
-	down(&shm_ids.sem);
-	shp = shm_lock(shmid);
-	if(shp==NULL) {
-		BUG();
-	}
-	shp = shm_rmid(shmid);
-	shm_unlock(shmid);
-	up(&shm_ids.sem);
-	seg_free(shp, 1);
-	clear_inode(ino);
-}
-
 static inline unsigned long copy_shmid_to_user(void *buf, struct shmid64_ds *in, int version)
 {
 	switch(version) {
@@ -933,6 +358,30 @@
 	}
 }
 
+static void shm_get_stat (unsigned long *rss, unsigned long *swp) 
+{
+	int i;
+
+	*rss = 0;
+	*swp = 0;
+
+	for(i = 0; i <= shm_ids.max_id; i++) {
+		struct shmid_kernel* shp;
+		struct inode * inode;
+
+		shp = shm_get(i);
+		if(shp == NULL || shp->shm_file == NULL)
+			continue;
+		inode = shp->shm_file->f_dentry->d_inode;
+		down (&inode->i_sem);
+		*rss += inode->i_mapping->nrpages;
+		spin_lock (&inode->u.shmem_i.stat_lock);
+		*swp += inode->u.shmem_i.swapped;
+		spin_unlock (&inode->u.shmem_i.stat_lock);
+		up (&inode->i_sem);
+	}
+}
+
 asmlinkage long sys_shmctl (int shmid, int cmd, struct shmid_ds *buf)
 {
 	struct shm_setbuf setbuf;
@@ -968,15 +417,16 @@
 		struct shm_info shm_info;
 
 		memset(&shm_info,0,sizeof(shm_info));
+		down(&shm_ids.sem);
 		shm_lockall();
-		shm_info.used_ids = shm_ids.in_use - 1; /* correct the /dev/zero hack */
-		shm_info.shm_rss = shm_rss;
+		shm_info.used_ids = shm_ids.in_use;
+		shm_get_stat (&shm_info.shm_rss, &shm_info.shm_swp);
 		shm_info.shm_tot = shm_tot;
-		shm_info.shm_swp = shm_swp;
-		shm_info.swap_attempts = swap_attempts;
-		shm_info.swap_successes = swap_successes;
+		shm_info.swap_attempts = 0;
+		shm_info.swap_successes = 0;
 		err = shm_ids.max_id;
 		shm_unlockall();
+		up(&shm_ids.sem);
 		if(copy_to_user (buf, &shm_info, sizeof(shm_info)))
 			return -EFAULT;
 
@@ -987,16 +437,13 @@
 	{
 		struct shmid64_ds tbuf;
 		int result;
-		if ((shmid % SEQ_MULTIPLIER) == zero_id)
-			return -EINVAL;
 		memset(&tbuf, 0, sizeof(tbuf));
 		shp = shm_lock(shmid);
 		if(shp==NULL)
 			return -EINVAL;
 		if(cmd==SHM_STAT) {
 			err = -EINVAL;
-			if (!(shp->shm_flags & SHM_SYSV) ||
-			    shmid > shm_ids.max_id)
+			if (shmid > shm_ids.max_id)
 				goto out_unlock;
 			result = shm_buildid(shmid, shp->shm_perm.seq);
 		} else {
@@ -1009,20 +456,13 @@
 		if (ipcperms (&shp->shm_perm, S_IRUGO))
 			goto out_unlock;
 		kernel_to_ipc64_perm(&shp->shm_perm, &tbuf.shm_perm);
-		/* ugly hack to keep binary compatibility for ipcs */
-		tbuf.shm_flags &= PRV_DEST | PRV_LOCKED | S_IRWXUGO;
-		if (tbuf.shm_flags & PRV_DEST)
-			tbuf.shm_flags |= SHM_DEST;
-		if (tbuf.shm_flags & PRV_LOCKED)
-			tbuf.shm_flags |= SHM_LOCKED;
-		tbuf.shm_flags &= SHM_DEST | SHM_LOCKED | S_IRWXUGO;
 		tbuf.shm_segsz	= shp->shm_segsz;
 		tbuf.shm_atime	= shp->shm_atim;
 		tbuf.shm_dtime	= shp->shm_dtim;
 		tbuf.shm_ctime	= shp->shm_ctim;
 		tbuf.shm_cpid	= shp->shm_cprid;
 		tbuf.shm_lpid	= shp->shm_lprid;
-		tbuf.shm_nattch	= shp->shm_nattch;
+		tbuf.shm_nattch	= file_count (shp->shm_file) - 1;
 		shm_unlock(shmid);
 		if(copy_shmid_to_user (buf, &tbuf, version))
 			return -EFAULT;
@@ -1034,8 +474,6 @@
 /* Allow superuser to lock segment in memory */
 /* Should the pages be faulted in here or leave it to user? */
 /* need to determine interaction with current->swappable */
-		if ((shmid % SEQ_MULTIPLIER)== zero_id)
-			return -EINVAL;
 		if (!capable(CAP_IPC_LOCK))
 			return -EPERM;
 
@@ -1045,10 +483,13 @@
 		err = shm_checkid(shp,shmid);
 		if(err)
 			goto out_unlock;
-		if(cmd==SHM_LOCK)
-			shp->shm_flags |= PRV_LOCKED;
-		else
-			shp->shm_flags &= ~PRV_LOCKED;
+		if(cmd==SHM_LOCK) {
+			shp->shm_file->private_data = (void*) -1;
+			shp->shm_flags |= SHM_LOCKED;
+		} else {
+			shp->shm_file->private_data = 0;
+			shp->shm_flags &= ~SHM_LOCKED;
+		}
 		shm_unlock(shmid);
 		return err;
 	}
@@ -1064,29 +505,18 @@
 		 *	Instead we set a destroyed flag, and then blow
 		 *	the name away when the usage hits zero.
 		 */
-		if ((shmid % SEQ_MULTIPLIER) == zero_id)
-			return -EINVAL;
 		down(&shm_ids.sem);
 		shp = shm_lock(shmid);
-		if (shp == NULL) {
-			up(&shm_ids.sem);
-			return -EINVAL;
-		}
+		err = -EINVAL;
+		if (shp == NULL) 
+			goto out_up;
 		err = shm_checkid(shp, shmid);
 		if (err == 0) {
-			if (shp->shm_nattch == 0 && 
-			    !(shp->shm_flags & SHM_UNLK)) {
-				int id=shp->id;
-				shm_unlock(shmid);
-				up(&shm_ids.sem);
-				/*
-				 * We can't hold shm_lock here else we
-				 * will deadlock in shm_lookup when we
-				 * try to recursively grab it.
-				 */
-				return shm_remove_name(id);
+			if (file_count (shp->shm_file) == 1) {
+				shm_destroy (shp);
+				return 0;
 			}
-			shp->shm_flags |= PRV_DEST;
+			shp->shm_flags |= SHM_DEST;
 			/* Do not find it any more */
 			shp->shm_perm.key = IPC_PRIVATE;
 		}
@@ -1098,12 +528,6 @@
 
 	case IPC_SET:
 	{
-		struct dentry * dentry;
-		char name[SHM_FMT_LEN+1];
-
-		if ((shmid % SEQ_MULTIPLIER)== zero_id)
-			return -EINVAL;
-
 		if(copy_shmid_from_user (&setbuf, buf, version))
 			return -EFAULT;
 		down(&shm_ids.sem);
@@ -1126,27 +550,7 @@
 		shp->shm_flags = (shp->shm_flags & ~S_IRWXUGO)
 			| (setbuf.mode & S_IRWXUGO);
 		shp->shm_ctim = CURRENT_TIME;
-		shm_unlock(shmid);
-		up(&shm_ids.sem);
-
-		sprintf (name, SHM_FMT, shmid);
-		dentry = lookup_one(name, lock_parent(shm_sb->s_root));
-		unlock_dir(shm_sb->s_root);
-		err = PTR_ERR(dentry);
-		if (IS_ERR(dentry))
-			goto bad_dentry;
-		err = -ENOENT;
-		if (dentry->d_inode) {
-			struct inode *ino = dentry->d_inode;
-			ino->i_uid   = setbuf.uid;
-			ino->i_gid   = setbuf.gid;
-			ino->i_mode  = (setbuf.mode & S_IRWXUGO) | (ino->i_mode & ~S_IALLUGO);;
-			ino->i_atime = ino->i_mtime = ino->i_ctime = CURRENT_TIME;
-			err = 0;
-		}
-		dput (dentry);
-	bad_dentry:
-		return err;
+		break;
 	}
 
 	default:
@@ -1164,27 +568,6 @@
 	return err;
 }
 
-static inline void shm_inc (int id) {
-	struct shmid_kernel *shp;
-
-	if(!(shp = shm_lock(id)))
-		BUG();
-	shp->shm_atim = CURRENT_TIME;
-	shp->shm_lprid = current->pid;
-	shp->shm_nattch++;
-	shm_unlock(id);
-}
-
-static int shm_mmap(struct file * file, struct vm_area_struct * vma)
-{
-	if ((vma->vm_flags & VM_WRITE) && !(vma->vm_flags & VM_SHARED))
-		return -EINVAL; /* we cannot do private writable mappings */
-	UPDATE_ATIME(file->f_dentry->d_inode);
-	vma->vm_ops = &shm_vm_ops;
-	shm_inc(file->f_dentry->d_inode->i_ino);
-	return 0;
-}
-
 /*
  * Fix shmaddr, allocate descriptor, map shm, add attach descriptor to lists.
  */
@@ -1198,11 +581,9 @@
 	unsigned long prot;
 	unsigned long o_flags;
 	int acc_mode;
-	struct dentry *dentry;
-	char   name[SHM_FMT_LEN+1];
 	void *user_addr;
 
-	if (!shm_sb || shmid < 0 || (shmid % SEQ_MULTIPLIER) == zero_id)
+	if (shmid < 0)
 		return -EINVAL;
 
 	if ((addr = (ulong)shmaddr)) {
@@ -1231,123 +612,26 @@
 	 * aditional creator id...
 	 */
 	shp = shm_lock(shmid);
-	if(shp==NULL)
+	if(shp == NULL)
 		return -EINVAL;
-	err = ipcperms(&shp->shm_perm, acc_mode);
-	shm_unlock(shmid);
-	if (err)
+	if (ipcperms(&shp->shm_perm, acc_mode)) {
+		shm_unlock(shmid);
 		return -EACCES;
+	}
+	file = shp->shm_file;
+	get_file (file);
+	shm_unlock(shmid);
 
-	sprintf (name, SHM_FMT, shmid);
-
-	mntget(shm_fs_type.kern_mnt);
-	dentry = lookup_one(name, lock_parent(shm_sb->s_root));
-	unlock_dir(shm_sb->s_root);
-	err = PTR_ERR(dentry);
-	if (IS_ERR(dentry))
-		goto bad_file;
-	err = -ENOENT;
-	if (!dentry->d_inode)
-		goto bad_file;
-	file = dentry_open(dentry, shm_fs_type.kern_mnt, o_flags);
-	err = PTR_ERR(file);
-	if (IS_ERR (file))
-		goto bad_file1;
 	down(&current->mm->mmap_sem);
 	user_addr = (void *) do_mmap (file, addr, file->f_dentry->d_inode->i_size, prot, flags, 0);
 	up(&current->mm->mmap_sem);
+	fput (file);
 	*raddr = (unsigned long) user_addr;
 	err = 0;
 	if (IS_ERR(user_addr))
 		err = PTR_ERR(user_addr);
-	fput (file);
-	return err;
-
-bad_file1:
-	dput(dentry);
-bad_file:
-	mntput(shm_fs_type.kern_mnt);
-	if (err == -ENOENT)
-		return -EINVAL;
 	return err;
-}
-
-/* This is called by fork, once for every shm attach. */
-static void shm_open (struct vm_area_struct *shmd)
-{
-	shm_inc (shmd->vm_file->f_dentry->d_inode->i_ino);
-}
-
-/*
- *	Remove a name.
- */
- 
-static int shm_remove_name(int id)
-{
-	struct dentry *dir;
-	struct dentry *dentry;
-	int error;
-	char name[SHM_FMT_LEN+1];
 
-	sprintf (name, SHM_FMT, id);
-	dir = lock_parent(shm_sb->s_root);
-	dentry = lookup_one(name, dir);
-	error = PTR_ERR(dentry);
-	if (!IS_ERR(dentry)) {
-		/*
-		 * We have to do our own unlink to prevent the vfs
-		 * permission check. The SYSV IPC layer has already
-		 * checked the permissions which do not comply to the
-		 * vfs rules.
-		 */
-		struct inode *inode = dir->d_inode;
-		down(&inode->i_zombie);
-		error = shm_unlink(inode, dentry);
-		if (!error)
-			d_delete(dentry);
-		up(&inode->i_zombie);
-		dput(dentry);
-	}
-	unlock_dir(dir);
-	return error;
-}
-
-/*
- * remove the attach descriptor shmd.
- * free memory for segment if it is marked destroyed.
- * The descriptor has already been removed from the current->mm->mmap list
- * and will later be kfree()d.
- */
-static void shm_close (struct vm_area_struct *shmd)
-{
-	int id = shmd->vm_file->f_dentry->d_inode->i_ino;
-	struct shmid_kernel *shp;
-
-	/* remove from the list of attaches of the shm segment */
-	if(!(shp = shm_lock(id)))
-		BUG();
-	shp->shm_lprid = current->pid;
-	shp->shm_dtim = CURRENT_TIME;
-	shp->shm_nattch--;
-	if(shp->shm_nattch == 0 && 
-	   shp->shm_flags & PRV_DEST &&
-	   !(shp->shm_flags & SHM_UNLK)) {
-		int pid=shp->id;
-		int err;
-		shm_unlock(id);
-
-		/* The kernel lock prevents new attaches from
-		 * being happening.  We can't hold shm_lock here
-		 * else we will deadlock in shm_lookup when we
-		 * try to recursively grab it.
-		 */
-		err = shm_remove_name(pid);
-		if(err && err != -EINVAL && err != -ENOENT) 
-			printk(KERN_ERR "Unlink of SHM id %d failed (%d).\n", pid, err);
-
-	} else {
-		shm_unlock(id);
-	}
 }
 
 /*
@@ -1370,189 +654,6 @@
 	return 0;
 }
 
-/*
- * Enter the shm page into the SHM data structures.
- *
- * This turns the physical page into a swap cache entry.
- */
-static int shm_swapout(struct page * page, struct file *file)
-{
-	struct shmid_kernel *shp;
-	struct inode * inode = file->f_dentry->d_inode;
-	swp_entry_t entry;
-	unsigned int idx;
-
-	idx = page->index;
-	entry = get_swap_page();
-	if (!entry.val)
-		return -ENOMEM;
-
-	/* Add it to the swap cache */
-	add_to_swap_cache(page, entry);
-	SetPageDirty(page);
-
-	/* Add it to the shm data structures */
-	swap_duplicate(entry);		/* swap-cache and SHM_ENTRY */
-	shp = shm_lock(inode->i_ino);
-	SHM_ENTRY (shp, idx) = swp_entry_to_pte(entry);
-	shm_unlock(inode->i_ino);
-
-	/*
-	 * We had one extra page count for the SHM_ENTRY.
-	 * We just overwrote it, so we should free that
-	 * count too (the VM layer will do an additional
-	 * free that free's the page table count that
-	 * it got rid of itself).
-	 */
-	page_cache_free(page);
-
-	return 0;
-}
-
-/*
- * page not present ... go through shm_dir
- */
-static struct page * shm_nopage_core(struct shmid_kernel *shp, unsigned int idx, int *swp, int *rss, unsigned long address)
-{
-	pte_t pte;
-	struct page * page;
-
-	if (idx >= shp->shm_npages)
-		return NOPAGE_SIGBUS;
-
-repeat:
-	/* Do we already have the page in memory? */
-	pte = SHM_ENTRY(shp,idx);
-	if (pte_present(pte)) {	
-		/* Yes - just increment the page count */
-		page = pte_page(pte);
-		page_cache_get(page);
-		return page;
-	}
-
-	/* No, but maybe we ahve a page cache entry for it? */
-	if (!pte_none(pte)) {
-		swp_entry_t entry = pte_to_swp_entry(pte);
-
-		shm_unlock(shp->id);
-
-		/* Look it up or read it in.. */
-		page = lookup_swap_cache(entry);
-		if (!page) {
-			lock_kernel();
-			swapin_readahead(entry);
-			page = read_swap_cache(entry);
-			unlock_kernel();
-			if (!page)
-				goto oom;
-		}
-		if ((shp != shm_lock(shp->id)) && (shp->id != zero_id))
-			BUG();
-		(*swp)--;
-		return page;
-	}
-
-	/* Ok, get a new page */
-	shm_unlock(shp->id);
-	page = page_cache_alloc();
-	if (!page)
-		goto oom;
-	clear_user_highpage(page, address);
-	if ((shp != shm_lock(shp->id)) && (shp->id != zero_id))
-		BUG();
-
-	page->index = idx;
-	/* Did somebody else allocate it while we slept? */
-	if (!pte_none(SHM_ENTRY(shp, idx))) {
-		page_cache_free(page);
-		goto repeat;
-	}
-
-	pte = pte_mkdirty(mk_pte(page, PAGE_SHARED));
-	SHM_ENTRY(shp, idx) = pte;
-	page_cache_get(page);	/* one for the page table, once more for SHM_ENTRY */
-	return page;
-
-oom:
-	shm_lock(shp->id);
-	return NOPAGE_OOM;
-}
-
-static struct page * shm_nopage(struct vm_area_struct * shmd, unsigned long address, int no_share)
-{
-	struct page * page;
-	struct shmid_kernel *shp;
-	unsigned int idx;
-	struct inode * inode = shmd->vm_file->f_dentry->d_inode;
-
-	idx = (address - shmd->vm_start) >> PAGE_SHIFT;
-	idx += shmd->vm_pgoff;
-
-	down(&inode->i_sem);
-	if(!(shp = shm_lock(inode->i_ino)))
-		BUG();
-	page = shm_nopage_core(shp, idx, &shm_swp, &shm_rss, address);
-	shm_unlock(inode->i_ino);
-	up(&inode->i_sem);
-	return(page);
-}
-
-
-/*
- * Free the swap entry and set the new pte for the shm page.
- */
-static void shm_unuse_page(struct shmid_kernel *shp, unsigned long idx,
-			   swp_entry_t entry, struct page *page)
-{
-	pte_t pte;
-
-	pte = pte_mkdirty(mk_pte(page, PAGE_SHARED));
-	SHM_ENTRY(shp, idx) = pte;
-	page_cache_get(page);
-	shm_rss++;
-
-	shm_swp--;
-
-	swap_free(entry);
-}
-
-static int shm_unuse_core(struct shmid_kernel *shp, swp_entry_t entry, struct page *page)
-{
-	int n;
-
-	for (n = 0; n < shp->shm_npages; n++) {
-		if (pte_none(SHM_ENTRY(shp,n)))
-			continue;
-		if (pte_present(SHM_ENTRY(shp,n)))
-			continue;
-		if (pte_to_swp_entry(SHM_ENTRY(shp,n)).val == entry.val) {
-			shm_unuse_page(shp, n, entry, page);
-			return 1;
-		}
-	}
-	return 0;
-}
-
-/*
- * unuse_shm() search for an eventually swapped out shm page.
- */
-void shm_unuse(swp_entry_t entry, struct page *page)
-{
-	int i;
-
-	shm_lockall();
-	for (i = 0; i <= shm_ids.max_id; i++) {
-		struct shmid_kernel *shp = shm_get(i);
-		if(shp==NULL)
-			continue;
-		if (shm_unuse_core(shp, entry, page))
-			goto out;
-	}
-out:
-	shm_unlockall();
-	zmap_unuse(entry, page);
-}
-
 #ifdef CONFIG_PROC_FS
 static int sysvipc_shm_read_proc(char *buffer, char **start, off_t offset, int length, int *eof, void *data)
 {
@@ -1561,17 +662,15 @@
 	int i, len = 0;
 
 	down(&shm_ids.sem);
-	len += sprintf(buffer, "       key      shmid perms       size  cpid  lpid nattch   uid   gid  cuid  cgid      atime      dtime      ctime name\n");
+	len += sprintf(buffer, "       key      shmid perms       size  cpid  lpid nattch   uid   gid  cuid  cgid      atime      dtime      ctime\n");
 
 	for(i = 0; i <= shm_ids.max_id; i++) {
 		struct shmid_kernel* shp;
 
-		if (i == zero_id)
-			continue;
 		shp = shm_lock(i);
 		if(shp!=NULL) {
-#define SMALL_STRING "%10d %10d  %4o %10u %5u %5u  %5d %5u %5u %5u %5u %10lu %10lu %10lu %.*s%s\n"
-#define BIG_STRING   "%10d %10d  %4o %21u %5u %5u  %5d %5u %5u %5u %5u %10lu %10lu %10lu %.*s%s\n"
+#define SMALL_STRING "%10d %10d  %4o %10u %5u %5u  %5d %5u %5u %5u %5u %10lu %10lu %10lu\n"
+#define BIG_STRING   "%10d %10d  %4o %21u %5u %5u  %5d %5u %5u %5u %5u %10lu %10lu %10lu\n"
 			char *format;
 
 			if (sizeof(size_t) <= sizeof(int))
@@ -1585,17 +684,14 @@
 				shp->shm_segsz,
 				shp->shm_cprid,
 				shp->shm_lprid,
-				shp->shm_nattch,
+				file_count (shp->shm_file) - 1,
 				shp->shm_perm.uid,
 				shp->shm_perm.gid,
 				shp->shm_perm.cuid,
 				shp->shm_perm.cgid,
 				shp->shm_atim,
 				shp->shm_dtim,
-				shp->shm_ctim,
-				shp->shm_namelen,
-				shp->shm_name,
-				shp->shm_flags & SHM_UNLK ? " (deleted)" : "");
+				shp->shm_ctim);
 			shm_unlock(i);
 
 			pos += len;
@@ -1619,153 +715,3 @@
 	return len;
 }
 #endif
-
-#define VMA_TO_SHP(vma)		((vma)->vm_file->private_data)
-
-static spinlock_t zmap_list_lock = SPIN_LOCK_UNLOCKED;
-static struct shmid_kernel *zswap_shp = &zshmid_kernel;
-static int zshm_rss;
-
-static struct vm_operations_struct shmzero_vm_ops = {
-	open:		shmzero_open,
-	close:		shmzero_close,
-	nopage:		shmzero_nopage,
-	swapout:	shm_swapout,
-};
-
-/*
- * In this implementation, the "unuse" and "swapout" interfaces are
- * interlocked out via the kernel_lock, as well as shm_lock(zero_id).
- * "unuse" and "nopage/swapin", as well as "swapout" and "nopage/swapin"
- * interlock via shm_lock(zero_id). All these interlocks can be based
- * on a per mapping lock instead of being a global lock.
- */
-/*
- * Reference (existance) counting on the file/dentry/inode is done
- * by generic vm_file code. The zero code does not hold any reference 
- * on the pseudo-file. This is possible because the open/close calls
- * are bracketed by the file count update calls.
- */
-static struct file *file_setup(struct file *fzero, struct shmid_kernel *shp)
-{
-	struct file *filp;
-	struct inode *inp;
-
-	if ((filp = get_empty_filp()) == 0)
-		return(filp);
-	if ((inp = get_empty_inode()) == 0) {
-		put_filp(filp);
-		return(0);
-	}
-	if ((filp->f_dentry = d_alloc(zdent, &(const struct qstr) { "dev/zero", 
-				8, 0 })) == 0) {
-		iput(inp);
-		put_filp(filp);
-		return(0);
-	}
-	filp->f_vfsmnt = mntget(shm_fs_type.kern_mnt);
-	d_instantiate(filp->f_dentry, inp);
-
-	/*
-	 * Copy over dev/ino for benefit of procfs. Use
-	 * ino to indicate seperate mappings.
-	 */
-	filp->f_dentry->d_inode->i_dev = shm_fs_type.kern_mnt->mnt_sb->s_dev;
-	filp->f_dentry->d_inode->i_ino = (unsigned long)shp;
-	if (fzero)
-		fput(fzero);	/* release /dev/zero file */
-	return(filp);
-}
-
-int map_zero_setup(struct vm_area_struct *vma)
-{
-	extern int vm_enough_memory(long pages);
-	struct shmid_kernel *shp;
-	struct file *filp;
-
-	if (!vm_enough_memory((vma->vm_end - vma->vm_start) >> PAGE_SHIFT))
-		return -ENOMEM;
-	if (IS_ERR(shp = seg_alloc((vma->vm_end - vma->vm_start) / PAGE_SIZE, 0)))
-		return PTR_ERR(shp);
-	if ((filp = file_setup(vma->vm_file, shp)) == 0) {
-		seg_free(shp, 0);
-		return -ENOMEM;
-	}
-	vma->vm_file = filp;
-	VMA_TO_SHP(vma) = (void *)shp;
-	shp->id = zero_id;
-	init_MUTEX(&shp->zsem);
-	vma->vm_ops = &shmzero_vm_ops;
-	shmzero_open(vma);
-	spin_lock(&zmap_list_lock);
-	list_add(&shp->zero_list, &zshmid_kernel.zero_list);
-	spin_unlock(&zmap_list_lock);
-	return 0;
-}
-
-static void shmzero_open(struct vm_area_struct *shmd)
-{
-	struct shmid_kernel *shp;
-
-	shp = VMA_TO_SHP(shmd);
-	down(&shp->zsem);
-	shp->shm_nattch++;
-	up(&shp->zsem);
-}
-
-static void shmzero_close(struct vm_area_struct *shmd)
-{
-	int done = 0;
-	struct shmid_kernel *shp;
-
-	shp = VMA_TO_SHP(shmd);
-	down(&shp->zsem);
-	if (--shp->shm_nattch == 0)
-		done = 1;
-	up(&shp->zsem);
-	if (done) {
-		spin_lock(&zmap_list_lock);
-		if (shp == zswap_shp)
-			zswap_shp = list_entry(zswap_shp->zero_list.next, 
-						struct shmid_kernel, zero_list);
-		list_del(&shp->zero_list);
-		spin_unlock(&zmap_list_lock);
-		seg_free(shp, 0);
-	}
-}
-
-static struct page * shmzero_nopage(struct vm_area_struct * shmd, unsigned long address, int no_share)
-{
-	struct page *page;
-	struct shmid_kernel *shp;
-	unsigned int idx;
-	int dummy;
-
-	idx = (address - shmd->vm_start) >> PAGE_SHIFT;
-	idx += shmd->vm_pgoff;
-
-	shp = VMA_TO_SHP(shmd);
-	down(&shp->zsem);
-	shm_lock(zero_id);
-	page = shm_nopage_core(shp, idx, &dummy, &zshm_rss, address);
-	shm_unlock(zero_id);
-	up(&shp->zsem);
-	return(page);
-}
-
-static void zmap_unuse(swp_entry_t entry, struct page *page)
-{
-	struct shmid_kernel *shp;
-
-	spin_lock(&zmap_list_lock);
-	shm_lock(zero_id);
-	for (shp = list_entry(zshmid_kernel.zero_list.next, struct shmid_kernel, 
-			zero_list); shp != &zshmid_kernel;
-			shp = list_entry(shp->zero_list.next, struct shmid_kernel,
-								zero_list)) {
-		if (shm_unuse_core(shp, entry, page))
-			break;
-	}
-	shm_unlock(zero_id);
-	spin_unlock(&zmap_list_lock);
-}
diff -uNr 4-12-8/ipc/util.c c/ipc/util.c
--- 4-12-8/ipc/util.c	Thu Jun 22 16:09:45 2000
+++ c/ipc/util.c	Mon Dec 11 19:42:35 2000
@@ -345,11 +345,6 @@
     return;
 }
 
-int shm_swap (int prio, int gfp_mask)
-{
-    return 0;
-}
-
 asmlinkage long sys_semget (key_t key, int nsems, int semflg)
 {
 	return -ENOSYS;
@@ -404,15 +399,6 @@
 asmlinkage long sys_shmctl (int shmid, int cmd, struct shmid_ds *buf)
 {
 	return -ENOSYS;
-}
-
-void shm_unuse(swp_entry_t entry, struct page *page)
-{
-}
-
-int map_zero_setup(struct vm_area_struct *vma)
-{
-	return -EINVAL;
 }
 
 #endif /* CONFIG_SYSVIPC */
diff -uNr 4-12-8/kernel/sysctl.c c/kernel/sysctl.c
--- 4-12-8/kernel/sysctl.c	Mon Dec 11 19:41:43 2000
+++ c/kernel/sysctl.c	Mon Dec 11 19:42:35 2000
@@ -63,6 +63,8 @@
 #endif
 #ifdef CONFIG_SYSVIPC
 extern size_t shm_ctlmax;
+extern size_t shm_ctlall;
+extern int shm_ctlmni;
 extern int msg_ctlmax;
 extern int msg_ctlmnb;
 extern int msg_ctlmni;
@@ -208,6 +210,10 @@
 #ifdef CONFIG_SYSVIPC
 	{KERN_SHMMAX, "shmmax", &shm_ctlmax, sizeof (size_t),
 	 0644, NULL, &proc_doulongvec_minmax},
+	{KERN_SHMALL, "shmall", &shm_ctlall, sizeof (size_t),
+	 0644, NULL, &proc_doulongvec_minmax},
+	{KERN_SHMMNI, "shmmni", &shm_ctlmni, sizeof (int),
+	 0644, NULL, &proc_dointvec},
 	{KERN_MSGMAX, "msgmax", &msg_ctlmax, sizeof (int),
 	 0644, NULL, &proc_dointvec},
 	{KERN_MSGMNI, "msgmni", &msg_ctlmni, sizeof (int),
diff -uNr 4-12-8/mm/Makefile c/mm/Makefile
--- 4-12-8/mm/Makefile	Sun Oct  8 17:57:35 2000
+++ c/mm/Makefile	Mon Dec 11 19:42:35 2000
@@ -10,7 +10,8 @@
 O_TARGET := mm.o
 O_OBJS	 := memory.o mmap.o filemap.o mprotect.o mlock.o mremap.o \
 	    vmalloc.o slab.o bootmem.o swap.o vmscan.o page_io.o \
-	    page_alloc.o swap_state.o swapfile.o numa.o oom_kill.o
+	    page_alloc.o swap_state.o swapfile.o numa.o oom_kill.o \
+	    shmem.o
 
 ifeq ($(CONFIG_HIGHMEM),y)
 O_OBJS += highmem.o
diff -uNr 4-12-8/mm/filemap.c c/mm/filemap.c
--- 4-12-8/mm/filemap.c	Mon Dec 11 19:41:43 2000
+++ c/mm/filemap.c	Mon Dec 11 19:42:35 2000
@@ -542,8 +542,8 @@
  * a rather lightweight function, finding and getting a reference to a
  * hashed page atomically, waiting for it if it's locked.
  */
-static struct page * __find_get_page(struct address_space *mapping,
-				unsigned long offset, struct page **hash)
+struct page * __find_get_page(struct address_space *mapping,
+			      unsigned long offset, struct page **hash)
 {
 	struct page *page;
 
diff -uNr 4-12-8/mm/mmap.c c/mm/mmap.c
--- 4-12-8/mm/mmap.c	Sun Nov 12 04:02:40 2000
+++ c/mm/mmap.c	Mon Dec 11 19:42:35 2000
@@ -333,7 +333,7 @@
 		if (error)
 			goto unmap_and_free_vma;
 	} else if (flags & MAP_SHARED) {
-		error = map_zero_setup(vma);
+		error = shmem_zero_setup(vma);
 		if (error)
 			goto free_vma;
 	}
diff -uNr 4-12-8/mm/shmem.c c/mm/shmem.c
--- 4-12-8/mm/shmem.c	Thu Jan  1 01:00:00 1970
+++ c/mm/shmem.c	Wed Dec 13 11:04:25 2000
@@ -0,0 +1,897 @@
+/*
+ * Resizable simple shmem filesystem for Linux.
+ *
+ * Copyright (C) 2000 Linus Torvalds.
+ *               2000 Transmeta Corp.
+ *               2000 Christoph Rohland
+ * 
+ * This file is released under the GPL.
+ */
+
+/*
+ * This shared memory handling is heavily based on the ramfs. It
+ * extends the ramfs by the ability to use swap which would makes it a
+ * completely usable filesystem.
+ *
+ * But read and write are not supported (yet)
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/devfs_fs_kernel.h>
+#include <linux/fs.h>
+#include <linux/mm.h>
+#include <linux/file.h>
+#include <linux/swap.h>
+#include <linux/pagemap.h>
+#include <linux/init.h>
+#include <linux/string.h>
+#include <linux/locks.h>
+#include <asm/smplock.h>
+
+#include <asm/uaccess.h>
+
+#define SHMEM_MAGIC	0x01021994
+
+#define ENTRIES_PER_PAGE (PAGE_SIZE/sizeof(unsigned long))
+#define NR_SINGLE (ENTRIES_PER_PAGE + SHMEM_NR_DIRECT)
+
+static struct super_operations shmem_ops;
+static struct address_space_operations shmem_aops;
+static struct file_operations shmem_file_operations;
+static struct inode_operations shmem_inode_operations;
+static struct file_operations shmem_dir_operations;
+static struct inode_operations shmem_dir_inode_operations;
+static struct vm_operations_struct shmem_vm_ops;
+
+LIST_HEAD (shmem_inodes);
+static spinlock_t shmem_ilock = SPIN_LOCK_UNLOCKED;
+
+static inline swp_entry_t * shmem_swp_entry (struct shmem_inode_info *info, unsigned long index) 
+{
+	if (index < SHMEM_NR_DIRECT)
+		return info->i_direct+index;
+
+	index -= SHMEM_NR_DIRECT;
+	if (index < ENTRIES_PER_PAGE) {
+		if (!info->i_indirect){
+                        info->i_indirect = (swp_entry_t *) get_zeroed_page(GFP_USER);
+                        if (!info->i_indirect)
+                                return NULL;
+                }
+		
+		return info->i_indirect+index;
+	}
+	
+	index -= ENTRIES_PER_PAGE;
+	if (index >= ENTRIES_PER_PAGE*ENTRIES_PER_PAGE)
+		return NULL;
+
+	if (!info->i_double) {
+                info->i_double = (swp_entry_t **) get_zeroed_page(GFP_USER);
+                if (!info->i_double)
+                        return NULL;
+        }
+        if(!(info->i_double[index/ENTRIES_PER_PAGE])) {
+                info->i_double[index/ENTRIES_PER_PAGE] = (swp_entry_t *) get_zeroed_page(GFP_USER);
+                if (!info->i_double[index/ENTRIES_PER_PAGE])
+                        return NULL;
+        }
+	
+	return info->i_double[index/ENTRIES_PER_PAGE]+index%ENTRIES_PER_PAGE;
+}
+
+static int shmem_free_swp(swp_entry_t *dir, unsigned int count)
+{
+	swp_entry_t *ptr;
+	struct page * page;
+        int freed = 0;
+
+	for (ptr = dir; ptr < dir + count; ptr++) {
+		if (!ptr->val)
+			continue;
+		swap_free (*ptr);
+		if (!(page = lookup_swap_cache(*ptr)))
+			continue;
+                freed--;
+		delete_from_swap_cache(page);
+		page_cache_release(page);
+	}
+        return freed;
+}
+
+/*
+ * shmem_truncate_part - free a bunch of swap entries
+ *
+ * @dir:	pointer to swp_entries 
+ * @size:	number of entries in dir
+ * @start:	offset to start from
+ * @inode:	inode for statistics
+ *
+ * It frees the swap entries from dir+start til dir+size
+ *
+ * returns 0 if it truncated something, else (offset-size)
+ */
+
+static unsigned long 
+shmem_truncate_part (swp_entry_t * dir, unsigned long size, 
+		     unsigned long start, struct inode * inode) {
+	unsigned long freed = 0;
+	if (start > size)
+		return start - size;
+	if (dir) {
+		freed = shmem_free_swp (dir+start, size-start);
+		memset(dir+start, 0, (size-start) * sizeof (swp_entry_t));
+	}
+	
+	spin_lock (&inode->u.shmem_i.stat_lock);
+	inode->u.shmem_i.swapped -= freed;
+	spin_unlock (&inode->u.shmem_i.stat_lock);
+	return 0;
+}
+
+static void shmem_truncate (struct inode * inode)
+{
+	int clear_base;
+	unsigned long start;
+	unsigned long freed = 0;
+	swp_entry_t **base, **ptr;
+	struct shmem_inode_info * info = &inode->u.shmem_i;
+
+	start = (inode->i_size + PAGE_CACHE_SIZE - 1) >> PAGE_CACHE_SHIFT;
+
+	start = shmem_truncate_part (info->i_direct, SHMEM_NR_DIRECT, start, inode);
+
+	if (start) {
+		start = shmem_truncate_part (info->i_indirect, ENTRIES_PER_PAGE, start, inode);
+	} else if (info->i_indirect) {
+		freed += shmem_free_swp (info->i_indirect, ENTRIES_PER_PAGE);
+		free_page ((unsigned long) info->i_indirect);
+		info->i_indirect = 0;
+	}
+
+	if (!(base = info->i_double))
+		goto out;;
+
+	clear_base = 1;
+	for (ptr = base; ptr < base + ENTRIES_PER_PAGE; ptr++) {
+		if (!start) {
+			if (!*ptr)
+				continue;
+			freed += shmem_free_swp (*ptr, ENTRIES_PER_PAGE);
+			free_page ((unsigned long) *ptr);
+			*ptr = 0;
+			continue;
+		}
+		clear_base = 0;
+		start = shmem_truncate_part (info->i_indirect, ENTRIES_PER_PAGE, start, inode);
+	}
+
+	if (!clear_base)
+		goto out;
+
+	free_page ((unsigned long)base);
+	info->i_double = 0;
+
+out:
+	spin_lock (&info->stat_lock);
+	info->swapped -= freed;
+	spin_unlock (&info->stat_lock);
+	inode->i_blocks -= freed;
+
+        /*
+	 * We have to calculate the free blocks since we do not know
+	 * how many pages the mm discarded
+	 *
+	 * But we know that normally
+	 * inodes->i_blocks == inode->i_mapping->nrpages + info->swapped
+	 *
+	 * So the mm freed 
+	 * inodes->i_blocks - (inode->i_mapping->nrpages + info->swapped)
+	 */
+
+	spin_lock (&pagecache_lock); /* protect inode->i_mapping->nrpages */
+	freed = inode->i_blocks - (inode->i_mapping->nrpages + info->swapped);
+	inode->i_blocks -= freed;
+	spin_unlock (&pagecache_lock);
+
+	spin_lock (&inode->i_sb->u.shmem_sb.stat_lock);
+	inode->i_sb->u.shmem_sb.free_blocks += freed;
+	spin_unlock (&inode->i_sb->u.shmem_sb.stat_lock);
+}
+
+static void shmem_delete_inode(struct inode * inode)
+{
+	struct shmem_sb_info *info = &inode->i_sb->u.shmem_sb;
+
+	spin_lock (&shmem_ilock);
+	list_del (&inode->u.shmem_i.list);
+	spin_unlock (&shmem_ilock);
+        inode->i_size = 0;
+	shmem_truncate (inode);
+	spin_lock (&info->stat_lock);
+	info->free_inodes++;
+	spin_unlock (&info->stat_lock);
+        clear_inode(inode);
+}
+
+struct inode *shmem_get_inode(struct super_block *sb, int mode, int dev)
+{
+	struct inode * inode;
+
+	spin_lock (&sb->u.shmem_sb.stat_lock);
+	if (!sb->u.shmem_sb.free_inodes) {
+		spin_unlock (&sb->u.shmem_sb.stat_lock);
+		return NULL;
+	}
+	sb->u.shmem_sb.free_inodes--;
+	spin_unlock (&sb->u.shmem_sb.stat_lock);
+
+	inode = new_inode(sb);
+	if (inode) {
+		inode->i_mode = mode;
+		inode->i_uid = current->fsuid;
+		inode->i_gid = current->fsgid;
+		inode->i_blksize = PAGE_CACHE_SIZE;
+		inode->i_blocks = 0;
+		inode->i_rdev = to_kdev_t(dev);
+		inode->i_mapping->a_ops = &shmem_aops;
+		inode->i_atime = inode->i_mtime = inode->i_ctime = CURRENT_TIME;
+		spin_lock_init (&inode->u.shmem_i.stat_lock);
+		switch (mode & S_IFMT) {
+		default:
+			init_special_inode(inode, mode, dev);
+			break;
+		case S_IFREG:
+			inode->i_op = &shmem_inode_operations;
+			inode->i_fop = &shmem_file_operations;
+			break;
+		case S_IFDIR:
+			inode->i_op = &shmem_dir_inode_operations;
+			inode->i_fop = &shmem_dir_operations;
+			break;
+		case S_IFLNK:
+			inode->i_op = &page_symlink_inode_operations;
+			break;
+		}
+		spin_lock (&shmem_ilock);
+		list_add (&inode->u.shmem_i.list, &shmem_inodes);
+		spin_unlock (&shmem_ilock);
+	}
+	return inode;
+}
+
+static int shmem_statfs(struct super_block *sb, struct statfs *buf)
+{
+	buf->f_type = SHMEM_MAGIC;
+	buf->f_bsize = PAGE_CACHE_SIZE;
+	spin_lock (&sb->u.shmem_sb.stat_lock);
+	if (sb->u.shmem_sb.max_blocks != ULONG_MAX || 
+	    sb->u.shmem_sb.max_inodes != ULONG_MAX) {
+		buf->f_blocks = sb->u.shmem_sb.max_blocks;
+		buf->f_bavail = buf->f_bfree = sb->u.shmem_sb.free_blocks;
+		buf->f_files = sb->u.shmem_sb.max_inodes;
+		buf->f_ffree = sb->u.shmem_sb.free_inodes;
+	}
+	spin_unlock (&sb->u.shmem_sb.stat_lock);
+	buf->f_namelen = 255;
+	return 0;
+}
+
+/*
+ * Lookup the data. This is trivial - if the dentry didn't already
+ * exist, we know it is negative.
+ */
+static struct dentry * shmem_lookup(struct inode *dir, struct dentry *dentry)
+{
+	d_add(dentry, NULL);
+	return NULL;
+}
+
+/*
+ * File creation. Allocate an inode, and we're done..
+ */
+static int shmem_mknod(struct inode *dir, struct dentry *dentry, int mode, int dev)
+{
+	struct inode * inode = shmem_get_inode(dir->i_sb, mode, dev);
+	int error = -ENOSPC;
+
+	if (inode) {
+		d_instantiate(dentry, inode);
+		dget(dentry);		/* Extra count - pin the dentry in core */
+		error = 0;
+	}
+	return error;
+}
+
+static int shmem_mkdir(struct inode * dir, struct dentry * dentry, int mode)
+{
+	return shmem_mknod(dir, dentry, mode | S_IFDIR, 0);
+}
+
+static int shmem_create(struct inode *dir, struct dentry *dentry, int mode)
+{
+	return shmem_mknod(dir, dentry, mode | S_IFREG, 0);
+}
+
+/*
+ * Link a file..
+ */
+static int shmem_link(struct dentry *old_dentry, struct inode * dir, struct dentry * dentry)
+{
+	struct inode *inode = old_dentry->d_inode;
+
+	if (S_ISDIR(inode->i_mode))
+		return -EPERM;
+
+	inode->i_nlink++;
+	atomic_inc(&inode->i_count);	/* New dentry reference */
+	dget(dentry);		/* Extra pinning count for the created dentry */
+	d_instantiate(dentry, inode);
+	return 0;
+}
+
+static inline int shmem_positive(struct dentry *dentry)
+{
+	return dentry->d_inode && !d_unhashed(dentry);
+}
+
+/*
+ * Check that a directory is empty (this works
+ * for regular files too, they'll just always be
+ * considered empty..).
+ *
+ * Note that an empty directory can still have
+ * children, they just all have to be negative..
+ */
+static int shmem_empty(struct dentry *dentry)
+{
+	struct list_head *list;
+
+	spin_lock(&dcache_lock);
+	list = dentry->d_subdirs.next;
+
+	while (list != &dentry->d_subdirs) {
+		struct dentry *de = list_entry(list, struct dentry, d_child);
+
+		if (shmem_positive(de)) {
+			spin_unlock(&dcache_lock);
+			return 0;
+		}
+		list = list->next;
+	}
+	spin_unlock(&dcache_lock);
+	return 1;
+}
+
+/*
+ * This works for both directories and regular files.
+ * (non-directories will always have empty subdirs)
+ */
+static int shmem_unlink(struct inode * dir, struct dentry *dentry)
+{
+	int retval = -ENOTEMPTY;
+
+	if (shmem_empty(dentry)) {
+		struct inode *inode = dentry->d_inode;
+
+		inode->i_nlink--;
+		dput(dentry);	/* Undo the count from "create" - this does all the work */
+		retval = 0;
+	}
+	return retval;
+}
+
+#define shmem_rmdir shmem_unlink
+
+/*
+ * The VFS layer already does all the dentry stuff for rename,
+ * we just have to decrement the usage count for the target if
+ * it exists so that the VFS layer correctly free's it when it
+ * gets overwritten.
+ */
+static int shmem_rename(struct inode * old_dir, struct dentry *old_dentry, struct inode * new_dir,struct dentry *new_dentry)
+{
+	int error = -ENOTEMPTY;
+
+	if (shmem_empty(new_dentry)) {
+		struct inode *inode = new_dentry->d_inode;
+		if (inode) {
+			inode->i_nlink--;
+			dput(new_dentry);
+		}
+		error = 0;
+	}
+	return error;
+}
+
+static int shmem_symlink(struct inode * dir, struct dentry *dentry, const char * symname)
+{
+	int error;
+
+	error = shmem_mknod(dir, dentry, S_IFLNK | S_IRWXUGO, 0);
+	if (!error) {
+		int l = strlen(symname)+1;
+		struct inode *inode = dentry->d_inode;
+		error = block_symlink(inode, symname, l);
+	}
+	return error;
+}
+
+static int shmem_mmap(struct file * file, struct vm_area_struct * vma)
+{
+	UPDATE_ATIME(file->f_dentry->d_inode);
+	vma->vm_ops = &shmem_vm_ops;
+	return 0;
+}
+
+/*
+ * We mark int dirty so the vm will not simply drop it
+ * The real work is done in shmem_writepage
+ */
+
+int shmem_swapout(struct page * page, struct file *file)
+{
+	SetPageDirty (page);
+	if (file->private_data)	/* hack for SHM_LOCK */
+		return -EPERM;
+	return 0;
+}
+
+/*
+ * Move the page from the page cache to the swap cache
+ */
+static int shmem_writepage(struct page * page)
+{
+        struct inode *inode = (struct inode *)page->mapping->host;
+        swp_entry_t *entry;
+
+	entry = shmem_swp_entry (&inode->u.shmem_i, page->index);
+	if (!entry)	/* this had been allocted on page allocation */
+		BUG();
+	if (entry->val)
+		BUG();
+
+	*entry = __get_swap_page(2);
+	if (!entry->val)
+		return -ENOMEM;
+
+	/* Remove it from the page cache */
+	lru_cache_del(page);
+	remove_inode_page(page);
+	/* Add it to the swap cache */
+	add_to_swap_cache(page, *entry);
+	page_cache_release(page);
+	SetPageDirty(page);
+	UnlockPage(page);
+	spin_lock(&inode->u.shmem_i.stat_lock);
+        inode->u.shmem_i.swapped++;
+	spin_unlock(&inode->u.shmem_i.stat_lock);
+	return 0;
+}
+
+/*
+ * shmem_nopage - either get the page from swap or allocate a new one
+ *
+ * If we allocate a new one we do not mark it dirty. That's up to the
+ * vm. If we swap it in we mark it dirty since we also free the swap
+ * entry since a page cannot live in both the swap and page cache
+ */
+struct page * shmem_nopage(struct vm_area_struct * vma, unsigned long address, int no_share)
+{
+	unsigned long size;
+	struct page * page;
+	unsigned int idx;
+	swp_entry_t *entry;
+	struct inode * inode = vma->vm_file->f_dentry->d_inode;
+	struct address_space * mapping = inode->i_mapping;
+
+	idx = (address - vma->vm_start) >> PAGE_SHIFT;
+	idx += vma->vm_pgoff;
+
+	size = (inode->i_size + PAGE_CACHE_SIZE - 1) >> PAGE_CACHE_SHIFT;
+	if ((idx >= size) && (vma->vm_mm == current->mm))
+		return NULL;
+
+#ifdef notyet
+	/* Do we already have the page in memory? */
+	page = __find_get_page(mapping, idx, page_hash (mapping, idx));
+	if (page)
+		return page;
+#endif
+
+	down (&inode->i_sem);
+	/* retry, we may have slept */
+	page = __find_lock_page(mapping, idx, page_hash (mapping, idx));
+	if (page)
+		goto out;
+
+	entry = shmem_swp_entry (&inode->u.shmem_i, idx);
+	if (!entry)
+		goto oom;
+	if (entry->val) {
+		unsigned long flags;
+
+		/* Look it up and read it in.. */
+		page = lookup_swap_cache(*entry);
+		if (!page) {
+			lock_kernel();
+			swapin_readahead(*entry);
+			page = read_swap_cache(*entry);
+			unlock_kernel();
+			if (!page) 
+				goto oom;
+		}
+
+		swap_free(*entry);
+		/* We have to this with page locked to prevent races
+                   with shmem_writepage */
+		lock_page(page);
+ 		delete_from_swap_cache_nolock(page);
+		*entry = (swp_entry_t) {0};
+		flags = page->flags & ~((1 << PG_uptodate) | (1 << PG_error) | (1 << PG_referenced) | (1 << PG_arch_1));
+		page->flags = flags | (1 << PG_dirty);
+		add_to_page_cache_locked(page, mapping, idx);
+		spin_lock (&inode->u.shmem_i.stat_lock);
+		inode->u.shmem_i.swapped--;
+		spin_unlock (&inode->u.shmem_i.stat_lock);
+	} else {
+		spin_lock (&inode->i_sb->u.shmem_sb.stat_lock);
+		if (inode->i_sb->u.shmem_sb.free_blocks == 0)
+			goto no_space;
+		inode->i_sb->u.shmem_sb.free_blocks--;
+		spin_unlock (&inode->i_sb->u.shmem_sb.stat_lock);
+		/* Ok, get a new page */
+		page = page_cache_alloc();
+		if (!page)
+			goto oom;
+		clear_user_highpage(page, address);
+                inode->i_blocks++;
+ 		add_to_page_cache (page, mapping, idx);
+	}
+	/* We have the page */
+	SetPageUptodate (page);
+out:
+	UnlockPage (page);
+	up(&inode->i_sem);
+
+	if (no_share) {
+		struct page *new_page = page_cache_alloc();
+
+		if (new_page) {
+			copy_user_highpage(new_page, page, address);
+			flush_page_to_ram(new_page);
+		} else
+			new_page = NOPAGE_OOM;
+		page_cache_release(page);
+		return new_page;
+	}
+
+        flush_page_to_ram (page);
+	return(page);
+no_space:
+	spin_unlock (&inode->i_sb->u.shmem_sb.stat_lock);
+oom:
+	printk ("shmem oom\n");
+	page = NOPAGE_OOM;
+	up(&inode->i_sem);
+	return page;
+}
+
+static int shmem_parse_options(char *options, int *mode, unsigned long * blocks, unsigned long *inodes)
+{
+	char *this_char, *value;
+
+	this_char = NULL;
+	if ( options )
+		this_char = strtok(options,",");
+	for ( ; this_char; this_char = strtok(NULL,",")) {
+		if ((value = strchr(this_char,'=')) != NULL)
+			*value++ = 0;
+		if (!strcmp(this_char,"nr_blocks")) {
+			if (!value || !*value || !blocks)
+				return 1;
+			*blocks = simple_strtoul(value,&value,0);
+			if (*value)
+				return 1;
+		} else if (!strcmp(this_char,"nr_inodes")) {
+			if (!value || !*value || !inodes)
+				return 1;
+			*inodes = simple_strtoul(value,&value,0);
+			if (*value)
+				return 1;
+		} else if (!strcmp(this_char,"mode")) {
+			if (!value || !*value || !mode)
+				return 1;
+			*mode = simple_strtoul(value,&value,8);
+			if (*value)
+				return 1;
+		}
+		else
+			return 1;
+	}
+
+	return 0;
+}
+
+static struct super_block *shmem_read_super(struct super_block * sb, void * data, int silent)
+{
+	struct inode * inode;
+	struct dentry * root;
+	unsigned long blocks = ULONG_MAX;	/* unlimited */
+	unsigned long inodes = ULONG_MAX;	/* unlimited */
+	int mode   = S_IRWXUGO | S_ISVTX;
+
+	if (shmem_parse_options (data, &mode, &blocks, &inodes)) {
+		printk(KERN_ERR "shmem fs invalid option\n");
+		return NULL;
+	}
+
+	spin_lock_init (&sb->u.shmem_sb.stat_lock);
+	sb->u.shmem_sb.max_blocks = blocks;
+	sb->u.shmem_sb.free_blocks = blocks;
+	sb->u.shmem_sb.max_inodes = inodes;
+	sb->u.shmem_sb.free_inodes = inodes;
+	sb->s_blocksize = PAGE_CACHE_SIZE;
+	sb->s_blocksize_bits = PAGE_CACHE_SHIFT;
+	sb->s_magic = SHMEM_MAGIC;
+	sb->s_op = &shmem_ops;
+	inode = shmem_get_inode(sb, S_IFDIR | mode, 0);
+	if (!inode)
+		return NULL;
+
+	root = d_alloc_root(inode);
+	if (!root) {
+		iput(inode);
+		return NULL;
+	}
+	sb->s_root = root;
+	return sb;
+}
+
+static int shmem_remount_fs (struct super_block *sb, int *flags, char *data)
+{
+	int error;
+	unsigned long max_blocks, blocks;
+	unsigned long max_inodes, inodes;
+	struct shmem_sb_info *info = &sb->u.shmem_sb;
+
+	if (shmem_parse_options (data, NULL, &max_blocks, &max_inodes))
+		return -EINVAL;
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
+static struct address_space_operations shmem_aops = {
+	writepage: shmem_writepage
+};
+
+static struct file_operations shmem_file_operations = {
+	mmap:		shmem_mmap
+};
+
+static struct inode_operations shmem_inode_operations = {
+	truncate:	shmem_truncate,
+};
+
+static struct file_operations shmem_dir_operations = {
+	read:		generic_read_dir,
+	readdir:	dcache_readdir,
+};
+
+static struct inode_operations shmem_dir_inode_operations = {
+	create:		shmem_create,
+	lookup:		shmem_lookup,
+	link:		shmem_link,
+	unlink:		shmem_unlink,
+	symlink:	shmem_symlink,
+	mkdir:		shmem_mkdir,
+	rmdir:		shmem_rmdir,
+	mknod:		shmem_mknod,
+	rename:		shmem_rename,
+};
+
+static struct super_operations shmem_ops = {
+	statfs:		shmem_statfs,
+	remount_fs:	shmem_remount_fs,
+        delete_inode:	shmem_delete_inode,
+	put_inode:	force_delete,	
+};
+
+
+static struct vm_operations_struct shmem_vm_ops = {
+	nopage:	shmem_nopage,
+	swapout:shmem_swapout,
+};
+
+static DECLARE_FSTYPE(shmem_fs_type, "shm", shmem_read_super, FS_LITTER);
+
+static int __init init_shmem_fs(void)
+{
+	int error;
+	struct vfsmount * res;
+
+	if ((error = register_filesystem(&shmem_fs_type))) {
+		printk (KERN_ERR "Could not register shmem fs\n");
+		return error;
+	}
+
+	res = kern_mount(&shmem_fs_type);
+	if (IS_ERR (res)) {
+		printk (KERN_ERR "could not kern_mount shmem fs\n");
+		unregister_filesystem(&shmem_fs_type);
+		return PTR_ERR(res);
+	}
+
+	devfs_mk_dir (NULL, "shm", NULL);
+	return 0;
+}
+
+static void __exit exit_shmem_fs(void)
+{
+	unregister_filesystem(&shmem_fs_type);
+}
+
+module_init(init_shmem_fs)
+module_exit(exit_shmem_fs)
+
+static int shmem_clear_swp (swp_entry_t entry, swp_entry_t *ptr, int size) {
+	swp_entry_t *test;
+
+	for (test = ptr; test < ptr + size; test++) {
+		if (test->val == entry.val) {
+			swap_free (entry);
+			*test = (swp_entry_t) {0};
+			return test - ptr;
+		}
+	}
+	return -1;
+}
+
+static int shmem_unuse_inode (struct inode *inode, swp_entry_t entry, struct page *page)
+{
+	swp_entry_t **base, **ptr;
+	unsigned long idx;
+	int offset;
+	
+	idx = 0;
+	if ((offset = shmem_clear_swp (entry, inode->u.shmem_i.i_direct, SHMEM_NR_DIRECT)) >= 0)
+		goto found;
+
+	idx = SHMEM_NR_DIRECT;
+	if (inode->u.shmem_i.i_indirect &&
+	    (offset = shmem_clear_swp (entry, inode->u.shmem_i.i_indirect, ENTRIES_PER_PAGE)) >= 0)
+		goto found;
+
+	if (!(base = inode->u.shmem_i.i_double))
+		return 0;
+
+	idx = SHMEM_NR_DIRECT + ENTRIES_PER_PAGE;
+	for (ptr = base; ptr < base + ENTRIES_PER_PAGE; ptr++) {
+		if (*ptr &&
+		    (offset = shmem_clear_swp (entry, *ptr, ENTRIES_PER_PAGE)) >= 0)
+			goto found;
+		idx += ENTRIES_PER_PAGE;
+	}
+	return 0;
+found:
+	delete_from_swap_cache (page);
+	add_to_page_cache (page, inode->i_mapping, idx);
+	SetPageDirty (page);
+	SetPageUptodate (page);
+	UnlockPage (page);
+	spin_lock (&inode->u.shmem_i.stat_lock);
+        inode->u.shmem_i.swapped--;
+	spin_unlock (&inode->u.shmem_i.stat_lock);
+	return 1;
+}
+
+/*
+ * unuse_shmem() search for an eventually swapped out shmem page.
+ */
+void shmem_unuse(swp_entry_t entry, struct page *page)
+{
+	struct list_head *p;
+	struct inode * inode;
+
+	spin_lock (&shmem_ilock);
+	list_for_each(p, &shmem_inodes) {
+		inode = list_entry(p, struct inode, u.shmem_i.list);
+
+		if (shmem_unuse_inode(inode, entry, page))
+			break;
+	}
+	spin_unlock (&shmem_ilock);
+}
+
+
+/*
+ * shmem_file_setup - get an unlinked file living in shmem fs
+ *
+ * @name: name for dentry (to be seen in /proc/<pid>/maps
+ * @size: size to be set for the file
+ *
+ */
+struct file *shmem_file_setup(char * name, loff_t size)
+{
+	int error;
+	struct file *file;
+	struct inode * inode;
+	struct dentry *dentry, *root;
+	struct qstr this;
+	int vm_enough_memory(long pages);
+
+	error = -ENOMEM;
+	if (!vm_enough_memory((size) >> PAGE_SHIFT))
+		goto out;
+
+	this.name = name;
+	this.len = strlen(name);
+	this.hash = 0; /* will go */
+	root = shmem_fs_type.kern_mnt->mnt_root;
+	dentry = d_alloc(root, &this);
+	if (!dentry)
+		goto out;
+
+	error = -ENFILE;
+	file = get_empty_filp();
+	if (!file)
+		goto put_dentry;
+
+	error = -ENOSPC;
+	inode = shmem_get_inode(root->d_sb, S_IFREG | S_IRWXUGO, 0);
+	if (!inode) 
+                goto close_file;
+
+        d_instantiate(dentry, inode);
+	dentry->d_inode->i_size = size;
+	file->f_vfsmnt = mntget(shmem_fs_type.kern_mnt);
+	file->f_dentry = dentry;
+	file->f_op = &shmem_file_operations;
+	file->f_mode = FMODE_WRITE | FMODE_READ;
+        inode->i_nlink = 0;     /* It is unlinked */
+	return(file);
+
+close_file:
+	put_filp(file);
+put_dentry:
+        dput (dentry);
+out:
+	return ERR_PTR(error);	
+}
+/*
+ * shmem_zero_setup - setup a shared anonymous mapping
+ *
+ * @vma: the vma to be mmapped is prepared by do_mmap_pgoff
+ */
+int shmem_zero_setup(struct vm_area_struct *vma)
+{
+	struct file *file;
+	loff_t size = vma->vm_end - vma->vm_start;
+	
+	file = shmem_file_setup("dev/zero", size);
+	if (IS_ERR(file))
+		return PTR_ERR(file);
+
+        if (vma->vm_file)
+                fput (vma->vm_file);
+	vma->vm_file = file;
+	vma->vm_ops = &shmem_vm_ops;
+	return 0;
+}
diff -uNr 4-12-8/mm/swapfile.c c/mm/swapfile.c
--- 4-12-8/mm/swapfile.c	Fri Dec  1 23:42:45 2000
+++ c/mm/swapfile.c	Mon Dec 11 19:42:35 2000
@@ -375,7 +375,7 @@
 		for_each_task(p)
 			unuse_process(p->mm, entry, page);
 		read_unlock(&tasklist_lock);
-		shm_unuse(entry, page);
+		shmem_unuse(entry, page);
 		/* Now get rid of the extra reference to the temporary
                    page we've been using. */
 		if (PageSwapCache(page))
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
