Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936359AbWK3NlW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936359AbWK3NlW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 08:41:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936385AbWK3NlW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 08:41:22 -0500
Received: from mx1.mandriva.com ([212.85.150.183]:35510 "EHLO mx1.mandriva.com")
	by vger.kernel.org with ESMTP id S936394AbWK3NlV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 08:41:21 -0500
Date: Thu, 30 Nov 2006 11:29:20 -0200
From: Arnaldo Carvalho de Melo <acme@mandriva.com>
To: Andrew Morton <akpm@osdl.org>, Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH][INODE]: Save some bytes in struct inode
Message-ID: <20061130132920.GA4416@mandriva.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[acme@newtoy net-2.6.20]$ pahole --cacheline 64 fs/inode.o inode
/* /pub/scm/linux/kernel/git/acme/net-2.6.20/include/linux/dcache.h:86 */
struct inode {
        struct hlist_node          i_hash;               /*     0     8 */
        struct list_head           i_list;               /*     8     8 */
        struct list_head           i_sb_list;            /*    16     8 */
        struct list_head           i_dentry;             /*    24     8 */
        long unsigned int          i_ino;                /*    32     4 */
        atomic_t                   i_count;              /*    36     4 */
        umode_t                    i_mode;               /*    40     2 */

        /* XXX 2 bytes hole, try to pack */

        unsigned int               i_nlink;              /*    44     4 */
        uid_t                      i_uid;                /*    48     4 */
        gid_t                      i_gid;                /*    52     4 */
        dev_t                      i_rdev;               /*    56     4 */
        loff_t                     i_size;               /*    60     8 */
        struct timespec            i_atime;              /*    68     8 */
        struct timespec            i_mtime;              /*    76     8 */
        struct timespec            i_ctime;              /*    84     8 */
        unsigned int               i_blkbits;            /*    92     4 */
        long unsigned int          i_version;            /*    96     4 */
        blkcnt_t                   i_blocks;             /*   100     4 */
        short unsigned int         i_bytes;              /*   104     2 */

        /* XXX 2 bytes hole, try to pack */

        spinlock_t                 i_lock;               /*   108    40 */
        struct mutex               i_mutex;              /*   148    76 */
        struct rw_semaphore        i_alloc_sem;          /*   224    64 */
        struct inode_operations *  i_op;                 /*   288     4 */
        const struct file_operations  * i_fop;           /*   292     4 */
        struct super_block *       i_sb;                 /*   296     4 */
        struct file_lock *         i_flock;              /*   300     4 */
        struct address_space *     i_mapping;            /*   304     4 */
        struct address_space       i_data;               /*   308   188 */
        struct list_head           i_devices;            /*   496     8 */
        union                      ;                     /*   504     4 */
        int                        i_cindex;             /*   508     4 */
        __u32                      i_generation;         /*   512     4 */
        /* ---------- cacheline 8 boundary ---------- */
        long unsigned int          i_dnotify_mask;       /*   516     4 */
        struct dnotify_struct *    i_dnotify;            /*   520     4 */
        struct list_head           inotify_watches;      /*   524     8 */
        struct mutex               inotify_mutex;        /*   532    76 */
        long unsigned int          i_state;              /*   608     4 */
        long unsigned int          dirtied_when;         /*   612     4 */
        unsigned int               i_flags;              /*   616     4 */
        atomic_t                   i_writecount;         /*   620     4 */
        void *                     i_security;           /*   624     4 */
        void *                     i_private;            /*   628     4 */
}; /* size: 632, sum members: 628, holes: 2, sum holes: 4 */

[acme@newtoy net-2.6.20]$

So just moving i_mode to after i_bytes we save 4 bytes by nuking both holes:

[acme@newtoy net-2.6.20]$ codiff -V /tmp/inode.o.before fs/inode.o
/pub/scm/linux/kernel/git/acme/net-2.6.20/fs/inode.c:
  struct inode |   -4
    i_mode;
     from: umode_t               /*    40(0)     2(0) */
     to:   umode_t               /*   102(0)     2(0) */
 1 struct changed
[acme@newtoy net-2.6.20]$

I've prunned all the other offset changes, only this one is of interest here.

So now we have:

[acme@newtoy net-2.6.20]$ pahole --cacheline 64 ../OUTPUT/qemu/net-2.6.20/fs/inode.o inode
/* /pub/scm/linux/kernel/git/acme/net-2.6.20/include/linux/dcache.h:86 */
struct inode {
        struct hlist_node          i_hash;               /*     0     8 */
        struct list_head           i_list;               /*     8     8 */
        struct list_head           i_sb_list;            /*    16     8 */
        struct list_head           i_dentry;             /*    24     8 */
        long unsigned int          i_ino;                /*    32     4 */
        atomic_t                   i_count;              /*    36     4 */
        unsigned int               i_nlink;              /*    40     4 */
        uid_t                      i_uid;                /*    44     4 */
        gid_t                      i_gid;                /*    48     4 */
        dev_t                      i_rdev;               /*    52     4 */
        loff_t                     i_size;               /*    56     8 */
        /* ---------- cacheline 1 boundary ---------- */
        struct timespec            i_atime;              /*    64     8 */
        struct timespec            i_mtime;              /*    72     8 */
        struct timespec            i_ctime;              /*    80     8 */
        unsigned int               i_blkbits;            /*    88     4 */
        long unsigned int          i_version;            /*    92     4 */
        blkcnt_t                   i_blocks;             /*    96     4 */
        short unsigned int         i_bytes;              /*   100     2 */
        umode_t                    i_mode;               /*   102     2 */
        spinlock_t                 i_lock;               /*   104    40 */
        struct mutex               i_mutex;              /*   144    76 */
        struct rw_semaphore        i_alloc_sem;          /*   220    64 */
        struct inode_operations *  i_op;                 /*   284     4 */
        const struct file_operations  * i_fop;           /*   288     4 */
        struct super_block *       i_sb;                 /*   292     4 */
        struct file_lock *         i_flock;              /*   296     4 */
        struct address_space *     i_mapping;            /*   300     4 */
        struct address_space       i_data;               /*   304   188 */
        struct list_head           i_devices;            /*   492     8 */
        union                      ;                     /*   500     4 */
        int                        i_cindex;             /*   504     4 */
        __u32                      i_generation;         /*   508     4 */
        /* ---------- cacheline 8 boundary ---------- */
        long unsigned int          i_dnotify_mask;       /*   512     4 */
        struct dnotify_struct *    i_dnotify;            /*   516     4 */
        struct list_head           inotify_watches;      /*   520     8 */
        struct mutex               inotify_mutex;        /*   528    76 */
        long unsigned int          i_state;              /*   604     4 */
        long unsigned int          dirtied_when;         /*   608     4 */
        unsigned int               i_flags;              /*   612     4 */
        atomic_t                   i_writecount;         /*   616     4 */
        void *                     i_security;           /*   620     4 */
        void *                     i_private;            /*   624     4 */
}; /* size: 628 */

[acme@newtoy net-2.6.20]$

Signed-off-by: Arnaldo Carvalho de Melo <acme@mandriva.com>
---
 fs.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 2fe6e3f..dc7456d 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -543,7 +543,6 @@ struct inode {
 	struct list_head	i_dentry;
 	unsigned long		i_ino;
 	atomic_t		i_count;
-	umode_t			i_mode;
 	unsigned int		i_nlink;
 	uid_t			i_uid;
 	gid_t			i_gid;
@@ -556,6 +555,7 @@ struct inode {
 	unsigned long		i_version;
 	blkcnt_t		i_blocks;
 	unsigned short          i_bytes;
+	umode_t			i_mode;
 	spinlock_t		i_lock;	/* i_blocks, i_bytes, maybe i_size */
 	struct mutex		i_mutex;
 	struct rw_semaphore	i_alloc_sem;
