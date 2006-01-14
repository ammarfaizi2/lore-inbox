Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751769AbWANOv1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751769AbWANOv1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 09:51:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751758AbWANOv1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 09:51:27 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:21940 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751763AbWANOvZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 09:51:25 -0500
Date: Sat, 14 Jan 2006 15:51:32 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org,
       dwmw2@infradead.org
Subject: [patch 2.6.15-mm4] sem2mutex: JFFS2
Message-ID: <20060114145132.GB18567@elte.hu>
References: <20060114142633.GA17012@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060114142633.GA17012@elte.hu>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.1 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.7 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ingo Molnar <mingo@elte.hu>

semaphore to mutex conversion.

the conversion was generated via scripts, and the result was validated
automatically via a script as well.

build tested.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
----

 fs/jffs2/background.c       |    2 -
 fs/jffs2/debug.c            |    8 +++---
 fs/jffs2/dir.c              |   58 ++++++++++++++++++++++----------------------
 fs/jffs2/erase.c            |    4 +--
 fs/jffs2/file.c             |   16 ++++++------
 fs/jffs2/fs.c               |   26 +++++++++----------
 fs/jffs2/gc.c               |   40 +++++++++++++++---------------
 fs/jffs2/nodemgmt.c         |   30 +++++++++++-----------
 fs/jffs2/readinode.c        |   24 +++++++++---------
 fs/jffs2/super.c            |   14 +++++-----
 fs/jffs2/symlink.c          |    4 +--
 fs/jffs2/wbuf.c             |   46 +++++++++++++++++-----------------
 fs/jffs2/write.c            |   48 ++++++++++++++++++------------------
 include/linux/jffs2_fs_i.h  |    4 +--
 include/linux/jffs2_fs_sb.h |    9 +++---
 15 files changed, 168 insertions(+), 165 deletions(-)

Index: linux/fs/jffs2/background.c
===================================================================
--- linux.orig/fs/jffs2/background.c
+++ linux/fs/jffs2/background.c
@@ -101,7 +101,7 @@ static int jffs2_garbage_collect_thread(
 
 		cond_resched();
 
-		/* Put_super will send a SIGKILL and then wait on the sem.
+		/* Put_super will send a SIGKILL and then wait on the mutex.
 		 */
 		while (signal_pending(current)) {
 			siginfo_t info;
Index: linux/fs/jffs2/debug.c
===================================================================
--- linux.orig/fs/jffs2/debug.c
+++ linux/fs/jffs2/debug.c
@@ -63,9 +63,9 @@ __jffs2_dbg_acct_sanity_check(struct jff
 void
 __jffs2_dbg_fragtree_paranoia_check(struct jffs2_inode_info *f)
 {
-	down(&f->sem);
+	mutex_lock(&f->mutex);
 	__jffs2_dbg_fragtree_paranoia_check_nolock(f);
-	up(&f->sem);
+	mutex_unlock(&f->mutex);
 }
 
 void
@@ -533,9 +533,9 @@ __jffs2_dbg_dump_block_lists_nolock(stru
 void
 __jffs2_dbg_dump_fragtree(struct jffs2_inode_info *f)
 {
-	down(&f->sem);
+	mutex_lock(&f->mutex);
 	jffs2_dbg_dump_fragtree_nolock(f);
-	up(&f->sem);
+	mutex_unlock(&f->mutex);
 }
 
 void
Index: linux/fs/jffs2/dir.c
===================================================================
--- linux.orig/fs/jffs2/dir.c
+++ linux/fs/jffs2/dir.c
@@ -80,7 +80,7 @@ static struct dentry *jffs2_lookup(struc
 	dir_f = JFFS2_INODE_INFO(dir_i);
 	c = JFFS2_SB_INFO(dir_i->i_sb);
 
-	down(&dir_f->sem);
+	mutex_lock(&dir_f->mutex);
 
 	/* NB: The 2.2 backport will need to explicitly check for '.' and '..' here */
 	for (fd_list = dir_f->dents; fd_list && fd_list->nhash <= target->d_name.hash; fd_list = fd_list->next) {
@@ -93,7 +93,7 @@ static struct dentry *jffs2_lookup(struc
 	}
 	if (fd)
 		ino = fd->ino;
-	up(&dir_f->sem);
+	mutex_unlock(&dir_f->mutex);
 	if (ino) {
 		inode = iget(dir_i->i_sb, ino);
 		if (!inode) {
@@ -140,7 +140,7 @@ static int jffs2_readdir(struct file *fi
 	}
 
 	curofs=1;
-	down(&f->sem);
+	mutex_lock(&f->mutex);
 	for (fd = f->dents; fd; fd = fd->next) {
 
 		curofs++;
@@ -160,7 +160,7 @@ static int jffs2_readdir(struct file *fi
 			break;
 		offset++;
 	}
-	up(&f->sem);
+	mutex_unlock(&f->mutex);
  out:
 	filp->f_pos = offset;
 	return 0;
@@ -268,9 +268,9 @@ static int jffs2_link (struct dentry *ol
 	ret = jffs2_do_link(c, dir_f, f->inocache->ino, type, dentry->d_name.name, dentry->d_name.len, now);
 
 	if (!ret) {
-		down(&f->sem);
+		mutex_lock(&f->mutex);
 		old_dentry->d_inode->i_nlink = ++f->inocache->nlink;
-		up(&f->sem);
+		mutex_unlock(&f->mutex);
 		d_instantiate(dentry, old_dentry->d_inode);
 		dir_i->i_mtime = dir_i->i_ctime = ITIME(now);
 		atomic_inc(&old_dentry->d_inode->i_count);
@@ -344,7 +344,7 @@ static int jffs2_symlink (struct inode *
 
 	if (IS_ERR(fn)) {
 		/* Eeek. Wave bye bye */
-		up(&f->sem);
+		mutex_unlock(&f->mutex);
 		jffs2_complete_reservation(c);
 		jffs2_clear_inode(inode);
 		return PTR_ERR(fn);
@@ -354,7 +354,7 @@ static int jffs2_symlink (struct inode *
 	f->target = kmalloc(targetlen + 1, GFP_KERNEL);
 	if (!f->target) {
 		printk(KERN_WARNING "Can't allocate %d bytes of memory\n", targetlen + 1);
-		up(&f->sem);
+		mutex_unlock(&f->mutex);
 		jffs2_complete_reservation(c);
 		jffs2_clear_inode(inode);
 		return -ENOMEM;
@@ -367,7 +367,7 @@ static int jffs2_symlink (struct inode *
 	   obsoleted by the first data write
 	*/
 	f->metadata = fn;
-	up(&f->sem);
+	mutex_unlock(&f->mutex);
 
 	jffs2_complete_reservation(c);
 	ret = jffs2_reserve_space(c, sizeof(*rd)+namelen, &phys_ofs, &alloclen,
@@ -387,7 +387,7 @@ static int jffs2_symlink (struct inode *
 	}
 
 	dir_f = JFFS2_INODE_INFO(dir_i);
-	down(&dir_f->sem);
+	mutex_lock(&dir_f->mutex);
 
 	rd->magic = cpu_to_je16(JFFS2_MAGIC_BITMASK);
 	rd->nodetype = cpu_to_je16(JFFS2_NODETYPE_DIRENT);
@@ -410,7 +410,7 @@ static int jffs2_symlink (struct inode *
 		   as if it were the final unlink() */
 		jffs2_complete_reservation(c);
 		jffs2_free_raw_dirent(rd);
-		up(&dir_f->sem);
+		mutex_unlock(&dir_f->mutex);
 		jffs2_clear_inode(inode);
 		return PTR_ERR(fd);
 	}
@@ -423,7 +423,7 @@ static int jffs2_symlink (struct inode *
 	   one if necessary. */
 	jffs2_add_fd_to_list(c, fd, &dir_f->dents);
 
-	up(&dir_f->sem);
+	mutex_unlock(&dir_f->mutex);
 	jffs2_complete_reservation(c);
 
 	d_instantiate(dentry, inode);
@@ -488,7 +488,7 @@ static int jffs2_mkdir (struct inode *di
 
 	if (IS_ERR(fn)) {
 		/* Eeek. Wave bye bye */
-		up(&f->sem);
+		mutex_unlock(&f->mutex);
 		jffs2_complete_reservation(c);
 		jffs2_clear_inode(inode);
 		return PTR_ERR(fn);
@@ -497,7 +497,7 @@ static int jffs2_mkdir (struct inode *di
 	   obsoleted by the first data write
 	*/
 	f->metadata = fn;
-	up(&f->sem);
+	mutex_unlock(&f->mutex);
 
 	jffs2_complete_reservation(c);
 	ret = jffs2_reserve_space(c, sizeof(*rd)+namelen, &phys_ofs, &alloclen,
@@ -517,7 +517,7 @@ static int jffs2_mkdir (struct inode *di
 	}
 
 	dir_f = JFFS2_INODE_INFO(dir_i);
-	down(&dir_f->sem);
+	mutex_lock(&dir_f->mutex);
 
 	rd->magic = cpu_to_je16(JFFS2_MAGIC_BITMASK);
 	rd->nodetype = cpu_to_je16(JFFS2_NODETYPE_DIRENT);
@@ -540,7 +540,7 @@ static int jffs2_mkdir (struct inode *di
 		   as if it were the final unlink() */
 		jffs2_complete_reservation(c);
 		jffs2_free_raw_dirent(rd);
-		up(&dir_f->sem);
+		mutex_unlock(&dir_f->mutex);
 		jffs2_clear_inode(inode);
 		return PTR_ERR(fd);
 	}
@@ -554,7 +554,7 @@ static int jffs2_mkdir (struct inode *di
 	   one if necessary. */
 	jffs2_add_fd_to_list(c, fd, &dir_f->dents);
 
-	up(&dir_f->sem);
+	mutex_unlock(&dir_f->mutex);
 	jffs2_complete_reservation(c);
 
 	d_instantiate(dentry, inode);
@@ -644,7 +644,7 @@ static int jffs2_mknod (struct inode *di
 
 	if (IS_ERR(fn)) {
 		/* Eeek. Wave bye bye */
-		up(&f->sem);
+		mutex_unlock(&f->mutex);
 		jffs2_complete_reservation(c);
 		jffs2_clear_inode(inode);
 		return PTR_ERR(fn);
@@ -653,7 +653,7 @@ static int jffs2_mknod (struct inode *di
 	   obsoleted by the first data write
 	*/
 	f->metadata = fn;
-	up(&f->sem);
+	mutex_unlock(&f->mutex);
 
 	jffs2_complete_reservation(c);
 	ret = jffs2_reserve_space(c, sizeof(*rd)+namelen, &phys_ofs, &alloclen,
@@ -673,7 +673,7 @@ static int jffs2_mknod (struct inode *di
 	}
 
 	dir_f = JFFS2_INODE_INFO(dir_i);
-	down(&dir_f->sem);
+	mutex_lock(&dir_f->mutex);
 
 	rd->magic = cpu_to_je16(JFFS2_MAGIC_BITMASK);
 	rd->nodetype = cpu_to_je16(JFFS2_NODETYPE_DIRENT);
@@ -699,7 +699,7 @@ static int jffs2_mknod (struct inode *di
 		   as if it were the final unlink() */
 		jffs2_complete_reservation(c);
 		jffs2_free_raw_dirent(rd);
-		up(&dir_f->sem);
+		mutex_unlock(&dir_f->mutex);
 		jffs2_clear_inode(inode);
 		return PTR_ERR(fd);
 	}
@@ -712,7 +712,7 @@ static int jffs2_mknod (struct inode *di
 	   one if necessary. */
 	jffs2_add_fd_to_list(c, fd, &dir_f->dents);
 
-	up(&dir_f->sem);
+	mutex_unlock(&dir_f->mutex);
 	jffs2_complete_reservation(c);
 
 	d_instantiate(dentry, inode);
@@ -739,14 +739,14 @@ static int jffs2_rename (struct inode *o
 		if (S_ISDIR(new_dentry->d_inode->i_mode)) {
 			struct jffs2_full_dirent *fd;
 
-			down(&victim_f->sem);
+			mutex_lock(&victim_f->mutex);
 			for (fd = victim_f->dents; fd; fd = fd->next) {
 				if (fd->ino) {
-					up(&victim_f->sem);
+					mutex_unlock(&victim_f->mutex);
 					return -ENOTEMPTY;
 				}
 			}
-			up(&victim_f->sem);
+			mutex_unlock(&victim_f->mutex);
 		}
 	}
 
@@ -775,9 +775,9 @@ static int jffs2_rename (struct inode *o
 		/* Don't oops if the victim was a dirent pointing to an
 		   inode which didn't exist. */
 		if (victim_f->inocache) {
-			down(&victim_f->sem);
+			mutex_lock(&victim_f->mutex);
 			victim_f->inocache->nlink--;
-			up(&victim_f->sem);
+			mutex_unlock(&victim_f->mutex);
 		}
 	}
 
@@ -795,11 +795,11 @@ static int jffs2_rename (struct inode *o
 	if (ret) {
 		/* Oh shit. We really ought to make a single node which can do both atomically */
 		struct jffs2_inode_info *f = JFFS2_INODE_INFO(old_dentry->d_inode);
-		down(&f->sem);
+		mutex_lock(&f->mutex);
 		old_dentry->d_inode->i_nlink++;
 		if (f->inocache)
 			f->inocache->nlink++;
-		up(&f->sem);
+		mutex_unlock(&f->mutex);
 
 		printk(KERN_NOTICE "jffs2_rename(): Link succeeded, unlink failed (err %d). You now have a hard link\n", ret);
 		/* Might as well let the VFS know */
Index: linux/fs/jffs2/erase.c
===================================================================
--- linux.orig/fs/jffs2/erase.c
+++ linux/fs/jffs2/erase.c
@@ -108,7 +108,7 @@ void jffs2_erase_pending_blocks(struct j
 {
 	struct jffs2_eraseblock *jeb;
 
-	down(&c->erase_free_sem);
+	mutex_lock(&c->erase_free_mutex);
 
 	spin_lock(&c->erase_completion_lock);
 
@@ -155,7 +155,7 @@ void jffs2_erase_pending_blocks(struct j
  done:
 	D1(printk(KERN_DEBUG "jffs2_erase_pending_blocks completed\n"));
 
-	up(&c->erase_free_sem);
+	mutex_unlock(&c->erase_free_mutex);
 }
 
 static void jffs2_erase_succeeded(struct jffs2_sb_info *c, struct jffs2_eraseblock *jeb)
Index: linux/fs/jffs2/file.c
===================================================================
--- linux.orig/fs/jffs2/file.c
+++ linux/fs/jffs2/file.c
@@ -107,9 +107,9 @@ static int jffs2_readpage (struct file *
 	struct jffs2_inode_info *f = JFFS2_INODE_INFO(pg->mapping->host);
 	int ret;
 
-	down(&f->sem);
+	mutex_lock(&f->mutex);
 	ret = jffs2_do_readpage_unlock(pg->mapping->host, pg);
-	up(&f->sem);
+	mutex_unlock(&f->mutex);
 	return ret;
 }
 
@@ -138,7 +138,7 @@ static int jffs2_prepare_write (struct f
 		if (ret)
 			return ret;
 
-		down(&f->sem);
+		mutex_lock(&f->mutex);
 		memset(&ri, 0, sizeof(ri));
 
 		ri.magic = cpu_to_je16(JFFS2_MAGIC_BITMASK);
@@ -165,7 +165,7 @@ static int jffs2_prepare_write (struct f
 		if (IS_ERR(fn)) {
 			ret = PTR_ERR(fn);
 			jffs2_complete_reservation(c);
-			up(&f->sem);
+			mutex_unlock(&f->mutex);
 			return ret;
 		}
 		ret = jffs2_add_full_dnode_to_inode(c, f, fn);
@@ -179,19 +179,19 @@ static int jffs2_prepare_write (struct f
 			jffs2_mark_node_obsolete(c, fn->raw);
 			jffs2_free_full_dnode(fn);
 			jffs2_complete_reservation(c);
-			up(&f->sem);
+			mutex_unlock(&f->mutex);
 			return ret;
 		}
 		jffs2_complete_reservation(c);
 		inode->i_size = pageofs;
-		up(&f->sem);
+		mutex_unlock(&f->mutex);
 	}
 
 	/* Read in the page if it wasn't already present, unless it's a whole page */
 	if (!PageUptodate(pg) && (start || end < PAGE_CACHE_SIZE)) {
-		down(&f->sem);
+		mutex_lock(&f->mutex);
 		ret = jffs2_do_readpage_nolock(inode, pg);
-		up(&f->sem);
+		mutex_unlock(&f->mutex);
 	}
 	D1(printk(KERN_DEBUG "end prepare_write(). pg->flags %lx\n", pg->flags));
 	return ret;
Index: linux/fs/jffs2/fs.c
===================================================================
--- linux.orig/fs/jffs2/fs.c
+++ linux/fs/jffs2/fs.c
@@ -83,7 +83,7 @@ static int jffs2_do_setattr (struct inod
 			 kfree(mdata);
 		return ret;
 	}
-	down(&f->sem);
+	mutex_lock(&f->mutex);
 	ivalid = iattr->ia_valid;
 
 	ri->magic = cpu_to_je16(JFFS2_MAGIC_BITMASK);
@@ -134,7 +134,7 @@ static int jffs2_do_setattr (struct inod
 	if (IS_ERR(new_metadata)) {
 		jffs2_complete_reservation(c);
 		jffs2_free_raw_inode(ri);
-		up(&f->sem);
+		mutex_unlock(&f->mutex);
 		return PTR_ERR(new_metadata);
 	}
 	/* It worked. Update the inode */
@@ -164,10 +164,10 @@ static int jffs2_do_setattr (struct inod
 	}
 	jffs2_free_raw_inode(ri);
 
-	up(&f->sem);
+	mutex_unlock(&f->mutex);
 	jffs2_complete_reservation(c);
 
-	/* We have to do the vmtruncate() without f->sem held, since
+	/* We have to do the vmtruncate() without f->mutex held, since
 	   some pages may be locked and waiting for it in readpage().
 	   We are protected from a simultaneous write() extending i_size
 	   back past iattr->ia_size, because do_truncate() holds the
@@ -235,13 +235,13 @@ void jffs2_read_inode (struct inode *ino
 	c = JFFS2_SB_INFO(inode->i_sb);
 
 	jffs2_init_inode_info(f);
-	down(&f->sem);
+	mutex_lock(&f->mutex);
 
 	ret = jffs2_do_read_inode(c, f, inode->i_ino, &latest_node);
 
 	if (ret) {
 		make_bad_inode(inode);
-		up(&f->sem);
+		mutex_unlock(&f->mutex);
 		return;
 	}
 	inode->i_mode = jemode_to_cpu(latest_node.mode);
@@ -296,7 +296,7 @@ void jffs2_read_inode (struct inode *ino
 		if (jffs2_read_dnode(c, f, f->metadata, (char *)&rdev, 0, sizeof(rdev)) < 0) {
 			/* Eep */
 			printk(KERN_NOTICE "Read device numbers for inode %lu failed\n", (unsigned long)inode->i_ino);
-			up(&f->sem);
+			mutex_unlock(&f->mutex);
 			jffs2_do_clear_inode(c, f);
 			make_bad_inode(inode);
 			return;
@@ -313,7 +313,7 @@ void jffs2_read_inode (struct inode *ino
 		printk(KERN_WARNING "jffs2_read_inode(): Bogus imode %o for ino %lu\n", inode->i_mode, (unsigned long)inode->i_ino);
 	}
 
-	up(&f->sem);
+	mutex_unlock(&f->mutex);
 
 	D1(printk(KERN_DEBUG "jffs2_read_inode() returning\n"));
 }
@@ -353,9 +353,9 @@ int jffs2_remount_fs (struct super_block
 	   Flush the writebuffer, if neccecary, else we loose it */
 	if (!(sb->s_flags & MS_RDONLY)) {
 		jffs2_stop_garbage_collect_thread(c);
-		down(&c->alloc_sem);
+		mutex_lock(&c->alloc_mutex);
 		jffs2_flush_wbuf_pad(c);
-		up(&c->alloc_sem);
+		mutex_unlock(&c->alloc_mutex);
 	}
 
 	if (!(*flags & MS_RDONLY))
@@ -402,7 +402,7 @@ struct inode *jffs2_new_inode (struct in
 
 	f = JFFS2_INODE_INFO(inode);
 	jffs2_init_inode_info(f);
-	down(&f->sem);
+	mutex_lock(&f->mutex);
 
 	memset(ri, 0, sizeof(*ri));
 	/* Set OS-specific defaults for new inodes */
@@ -556,7 +556,7 @@ struct jffs2_inode_info *jffs2_gc_fetch_
 		   instead of iget().
 
 		   The nlink can't _become_ zero at this point because we're
-		   holding the alloc_sem, and jffs2_do_unlink() would also
+		   holding the alloc_mutex, and jffs2_do_unlink() would also
 		   need that while decrementing nlink on any inode.
 		*/
 		inode = ilookup(OFNI_BS_2SFFJ(c), inum);
@@ -584,7 +584,7 @@ struct jffs2_inode_info *jffs2_gc_fetch_
 		}
 	} else {
 		/* Inode has links to it still; they're not going away because
-		   jffs2_do_unlink() would need the alloc_sem and we have it.
+		   jffs2_do_unlink() would need the alloc_mutex and we have it.
 		   Just iget() it, and if read_inode() is necessary that's OK.
 		*/
 		inode = iget(OFNI_BS_2SFFJ(c), inum);
Index: linux/fs/jffs2/gc.c
===================================================================
--- linux.orig/fs/jffs2/gc.c
+++ linux/fs/jffs2/gc.c
@@ -126,7 +126,7 @@ int jffs2_garbage_collect_pass(struct jf
 	struct jffs2_raw_node_ref *raw;
 	int ret = 0, inum, nlink;
 
-	if (down_interruptible(&c->alloc_sem))
+	if (mutex_lock_interruptible(&c->alloc_mutex))
 		return -EINTR;
 
 	for (;;) {
@@ -137,7 +137,7 @@ int jffs2_garbage_collect_pass(struct jf
 		/* We can't start doing GC yet. We haven't finished checking
 		   the node CRCs etc. Do it now. */
 
-		/* checked_ino is protected by the alloc_sem */
+		/* checked_ino is protected by the alloc_mutex */
 		if (c->checked_ino > c->highest_ino) {
 			printk(KERN_CRIT "Checked all inodes but still 0x%x bytes of unchecked space?\n",
 			       c->unchecked_size);
@@ -181,7 +181,7 @@ int jffs2_garbage_collect_pass(struct jf
 			   and trigger the BUG() above while we haven't yet
 			   finished checking all its nodes */
 			D1(printk(KERN_DEBUG "Waiting for ino #%u to finish reading\n", ic->ino));
-			up(&c->alloc_sem);
+			mutex_unlock(&c->alloc_mutex);
 			sleep_on_spinunlock(&c->inocache_wq, &c->inocache_lock);
 			return 0;
 
@@ -201,7 +201,7 @@ int jffs2_garbage_collect_pass(struct jf
 			printk(KERN_WARNING "Returned error for crccheck of ino #%u. Expect badness...\n", ic->ino);
 
 		jffs2_set_inocache_state(c, ic, INO_STATE_CHECKEDABSENT);
-		up(&c->alloc_sem);
+		mutex_unlock(&c->alloc_mutex);
 		return ret;
 	}
 
@@ -214,7 +214,7 @@ int jffs2_garbage_collect_pass(struct jf
 	if (!jeb) {
 		D1 (printk(KERN_NOTICE "jffs2: Couldn't find erase block to garbage collect!\n"));
 		spin_unlock(&c->erase_completion_lock);
-		up(&c->alloc_sem);
+		mutex_unlock(&c->alloc_mutex);
 		return -EIO;
 	}
 
@@ -223,7 +223,7 @@ int jffs2_garbage_collect_pass(struct jf
 	   printk(KERN_DEBUG "Nextblock at  %08x, used_size %08x, dirty_size %08x, wasted_size %08x, free_size %08x\n", c->nextblock->offset, c->nextblock->used_size, c->nextblock->dirty_size, c->nextblock->wasted_size, c->nextblock->free_size));
 
 	if (!jeb->used_size) {
-		up(&c->alloc_sem);
+		mutex_unlock(&c->alloc_mutex);
 		goto eraseit;
 	}
 
@@ -238,7 +238,7 @@ int jffs2_garbage_collect_pass(struct jf
 			       jeb->offset, jeb->free_size, jeb->dirty_size, jeb->used_size);
 			jeb->gc_node = raw;
 			spin_unlock(&c->erase_completion_lock);
-			up(&c->alloc_sem);
+			mutex_unlock(&c->alloc_mutex);
 			BUG();
 		}
 	}
@@ -252,7 +252,7 @@ int jffs2_garbage_collect_pass(struct jf
 		   we don't grok that has JFFS2_NODETYPE_RWCOMPAT_COPY, we should do so */
 		spin_unlock(&c->erase_completion_lock);
 		jffs2_mark_node_obsolete(c, raw);
-		up(&c->alloc_sem);
+		mutex_unlock(&c->alloc_mutex);
 		goto eraseit_lock;
 	}
 
@@ -299,12 +299,12 @@ int jffs2_garbage_collect_pass(struct jf
 	case INO_STATE_GC:
 		/* Should never happen. We should have finished checking
 		   by the time we actually start doing any GC, and since
-		   we're holding the alloc_sem, no other garbage collection
+		   we're holding the alloc_mutex, no other garbage collection
 		   can happen.
 		*/
 		printk(KERN_CRIT "Inode #%u already in state %d in jffs2_garbage_collect_pass()!\n",
 		       ic->ino, ic->state);
-		up(&c->alloc_sem);
+		mutex_unlock(&c->alloc_mutex);
 		spin_unlock(&c->inocache_lock);
 		BUG();
 
@@ -312,14 +312,14 @@ int jffs2_garbage_collect_pass(struct jf
 		/* Someone's currently trying to read it. We must wait for
 		   them to finish and then go through the full iget() route
 		   to do the GC. However, sometimes read_inode() needs to get
-		   the alloc_sem() (for marking nodes invalid) so we must
-		   drop the alloc_sem before sleeping. */
+		   the alloc_mutex() (for marking nodes invalid) so we must
+		   drop the alloc_mutex before sleeping. */
 
-		up(&c->alloc_sem);
+		mutex_unlock(&c->alloc_mutex);
 		D1(printk(KERN_DEBUG "jffs2_garbage_collect_pass() waiting for ino #%u in state %d\n",
 			  ic->ino, ic->state));
 		sleep_on_spinunlock(&c->inocache_wq, &c->inocache_lock);
-		/* And because we dropped the alloc_sem we must start again from the
+		/* And because we dropped the alloc_mutex we must start again from the
 		   beginning. Ponder chance of livelock here -- we're returning success
 		   without actually making any progress.
 
@@ -380,7 +380,7 @@ int jffs2_garbage_collect_pass(struct jf
 	jffs2_gc_release_inode(c, f);
 
  release_sem:
-	up(&c->alloc_sem);
+	mutex_unlock(&c->alloc_mutex);
 
  eraseit_lock:
 	/* If we've finished this block, start it erasing */
@@ -409,7 +409,7 @@ static int jffs2_garbage_collect_live(st
 	uint32_t start = 0, end = 0, nrfrags = 0;
 	int ret = 0;
 
-	down(&f->sem);
+	mutex_lock(&f->mutex);
 
 	/* Now we have the lock for this inode. Check that it's still the one at the head
 	   of the list. */
@@ -489,7 +489,7 @@ static int jffs2_garbage_collect_live(st
 		}
 	}
  upnout:
-	up(&f->sem);
+	mutex_unlock(&f->mutex);
 
 	return ret;
 }
@@ -831,7 +831,7 @@ static int jffs2_garbage_collect_deletio
 		/* Prevent the erase code from nicking the obsolete node refs while
 		   we're looking at them. I really don't like this extra lock but
 		   can't see any alternative. Suggestions on a postcard to... */
-		down(&c->erase_free_sem);
+		mutex_lock(&c->erase_free_mutex);
 
 		for (raw = f->inocache->nodes; raw != (void *)f->inocache; raw = raw->next_in_ino) {
 
@@ -882,7 +882,7 @@ static int jffs2_garbage_collect_deletio
 			/* OK. The name really does match. There really is still an older node on
 			   the flash which our deletion dirent obsoletes. So we have to write out
 			   a new deletion dirent to replace it */
-			up(&c->erase_free_sem);
+			mutex_unlock(&c->erase_free_mutex);
 
 			D1(printk(KERN_DEBUG "Deletion dirent at %08x still obsoletes real dirent \"%s\" at %08x for ino #%u\n",
 				  ref_offset(fd->raw), fd->name, ref_offset(raw), je32_to_cpu(rd->ino)));
@@ -891,7 +891,7 @@ static int jffs2_garbage_collect_deletio
 			return jffs2_garbage_collect_dirent(c, jeb, f, fd);
 		}
 
-		up(&c->erase_free_sem);
+		mutex_unlock(&c->erase_free_mutex);
 		kfree(rd);
 	}
 
Index: linux/fs/jffs2/nodemgmt.c
===================================================================
--- linux.orig/fs/jffs2/nodemgmt.c
+++ linux/fs/jffs2/nodemgmt.c
@@ -51,9 +51,9 @@ int jffs2_reserve_space(struct jffs2_sb_
 	minsize = PAD(minsize);
 
 	D1(printk(KERN_DEBUG "jffs2_reserve_space(): Requested 0x%x bytes\n", minsize));
-	down(&c->alloc_sem);
+	mutex_lock(&c->alloc_mutex);
 
-	D1(printk(KERN_DEBUG "jffs2_reserve_space(): alloc sem got\n"));
+	D1(printk(KERN_DEBUG "jffs2_reserve_space(): alloc mutex got\n"));
 
 	spin_lock(&c->erase_completion_lock);
 
@@ -85,7 +85,7 @@ int jffs2_reserve_space(struct jffs2_sb_
 					  dirty, c->unchecked_size, c->sector_size));
 
 				spin_unlock(&c->erase_completion_lock);
-				up(&c->alloc_sem);
+				mutex_unlock(&c->alloc_mutex);
 				return -ENOSPC;
 			}
 
@@ -108,11 +108,11 @@ int jffs2_reserve_space(struct jffs2_sb_
 				D1(printk(KERN_DEBUG "max. available size 0x%08x  < blocksneeded * sector_size 0x%08x, returning -ENOSPC\n",
 					  avail, blocksneeded * c->sector_size));
 				spin_unlock(&c->erase_completion_lock);
-				up(&c->alloc_sem);
+				mutex_unlock(&c->alloc_mutex);
 				return -ENOSPC;
 			}
 
-			up(&c->alloc_sem);
+			mutex_unlock(&c->alloc_mutex);
 
 			D1(printk(KERN_DEBUG "Triggering GC pass. nr_free_blocks %d, nr_erasing_blocks %d, free_size 0x%08x, dirty_size 0x%08x, wasted_size 0x%08x, used_size 0x%08x, erasing_size 0x%08x, bad_size 0x%08x (total 0x%08x of 0x%08x)\n",
 				  c->nr_free_blocks, c->nr_erasing_blocks, c->free_size, c->dirty_size, c->wasted_size, c->used_size, c->erasing_size, c->bad_size,
@@ -128,7 +128,7 @@ int jffs2_reserve_space(struct jffs2_sb_
 			if (signal_pending(current))
 				return -EINTR;
 
-			down(&c->alloc_sem);
+			mutex_lock(&c->alloc_mutex);
 			spin_lock(&c->erase_completion_lock);
 		}
 
@@ -139,7 +139,7 @@ int jffs2_reserve_space(struct jffs2_sb_
 	}
 	spin_unlock(&c->erase_completion_lock);
 	if (ret)
-		up(&c->alloc_sem);
+		mutex_unlock(&c->alloc_mutex);
 	return ret;
 }
 
@@ -258,7 +258,7 @@ static int jffs2_find_nextblock(struct j
 	return 0;
 }
 
-/* Called with alloc sem _and_ erase_completion_lock */
+/* Called with alloc mutex _and_ erase_completion_lock */
 static int jffs2_do_reserve_space(struct jffs2_sb_info *c, uint32_t minsize, uint32_t *ofs, uint32_t *len, uint32_t sumsize)
 {
 	struct jffs2_eraseblock *jeb = c->nextblock;
@@ -379,7 +379,7 @@ static int jffs2_do_reserve_space(struct
  *	Should only be used to report nodes for which space has been allocated
  *	by jffs2_reserve_space.
  *
- *	Must be called with the alloc_sem held.
+ *	Must be called with the alloc_mutex held.
  */
 
 int jffs2_add_physical_node_ref(struct jffs2_sb_info *c, struct jffs2_raw_node_ref *new)
@@ -446,7 +446,7 @@ void jffs2_complete_reservation(struct j
 {
 	D1(printk(KERN_DEBUG "jffs2_complete_reservation()\n"));
 	jffs2_garbage_collect_trigger(c);
-	up(&c->alloc_sem);
+	mutex_unlock(&c->alloc_mutex);
 }
 
 static inline int on_list(struct list_head *obj, struct list_head *head)
@@ -494,7 +494,7 @@ void jffs2_mark_node_obsolete(struct jff
 		   any jffs2_raw_node_refs. So we don't need to stop erases from
 		   happening, or protect against people holding an obsolete
 		   jffs2_raw_node_ref without the erase_completion_lock. */
-		down(&c->erase_free_sem);
+		mutex_lock(&c->erase_free_mutex);
 	}
 
 	spin_lock(&c->erase_completion_lock);
@@ -560,7 +560,7 @@ void jffs2_mark_node_obsolete(struct jff
 		   marked obsolete on the flash at the time they _became_
 		   obsolete, there was probably a reason for that. */
 		spin_unlock(&c->erase_completion_lock);
-		/* We didn't lock the erase_free_sem */
+		/* We didn't lock the erase_free_mutex */
 		return;
 	}
 
@@ -615,11 +615,11 @@ void jffs2_mark_node_obsolete(struct jff
 
 	if (!jffs2_can_mark_obsolete(c) || jffs2_is_readonly(c) ||
 		(c->flags & JFFS2_SB_FLAG_BUILDING)) {
-		/* We didn't lock the erase_free_sem */
+		/* We didn't lock the erase_free_mutex */
 		return;
 	}
 
-	/* The erase_free_sem is locked, and has been since before we marked the node obsolete
+	/* The erase_free_mutex is locked, and has been since before we marked the node obsolete
 	   and potentially put its eraseblock onto the erase_pending_list. Thus, we know that
 	   the block hasn't _already_ been erased, and that 'ref' itself hasn't been freed yet
 	   by jffs2_free_all_node_refs() in erase.c. Which is nice. */
@@ -729,7 +729,7 @@ void jffs2_mark_node_obsolete(struct jff
 		spin_unlock(&c->erase_completion_lock);
 	}
  out_erase_sem:
-	up(&c->erase_free_sem);
+	mutex_unlock(&c->erase_free_mutex);
 }
 
 int jffs2_thread_should_wake(struct jffs2_sb_info *c)
Index: linux/fs/jffs2/readinode.c
===================================================================
--- linux.orig/fs/jffs2/readinode.c
+++ linux/fs/jffs2/readinode.c
@@ -740,7 +740,7 @@ static int jffs2_do_read_inode_internal(
 		JFFS2_ERROR("failed to read from flash: error %d, %zd of %zd bytes read\n",
 			ret, retlen, sizeof(*latest_node));
 		/* FIXME: If this fails, there seems to be a memory leak. Find it. */
-		up(&f->sem);
+		mutex_unlock(&f->mutex);
 		jffs2_do_clear_inode(c, f);
 		return ret?ret:-EIO;
 	}
@@ -749,7 +749,7 @@ static int jffs2_do_read_inode_internal(
 	if (crc != je32_to_cpu(latest_node->node_crc)) {
 		JFFS2_ERROR("CRC failed for read_inode of inode %u at physical location 0x%x\n",
 			f->inocache->ino, ref_offset(fn->raw));
-		up(&f->sem);
+		mutex_unlock(&f->mutex);
 		jffs2_do_clear_inode(c, f);
 		return -EIO;
 	}
@@ -784,7 +784,7 @@ static int jffs2_do_read_inode_internal(
 			f->target = kmalloc(je32_to_cpu(latest_node->csize) + 1, GFP_KERNEL);
 			if (!f->target) {
 				JFFS2_ERROR("can't allocate %d bytes of memory for the symlink target path cache\n", je32_to_cpu(latest_node->csize));
-				up(&f->sem);
+				mutex_unlock(&f->mutex);
 				jffs2_do_clear_inode(c, f);
 				return -ENOMEM;
 			}
@@ -797,7 +797,7 @@ static int jffs2_do_read_inode_internal(
 					ret = -EIO;
 				kfree(f->target);
 				f->target = NULL;
-				up(&f->sem);
+				mutex_unlock(&f->mutex);
 				jffs2_do_clear_inode(c, f);
 				return -ret;
 			}
@@ -815,14 +815,14 @@ static int jffs2_do_read_inode_internal(
 		if (f->metadata) {
 			JFFS2_ERROR("Argh. Special inode #%u with mode 0%o had metadata node\n",
 			       f->inocache->ino, jemode_to_cpu(latest_node->mode));
-			up(&f->sem);
+			mutex_unlock(&f->mutex);
 			jffs2_do_clear_inode(c, f);
 			return -EIO;
 		}
 		if (!frag_first(&f->fragtree)) {
 			JFFS2_ERROR("Argh. Special inode #%u with mode 0%o has no fragments\n",
 			       f->inocache->ino, jemode_to_cpu(latest_node->mode));
-			up(&f->sem);
+			mutex_unlock(&f->mutex);
 			jffs2_do_clear_inode(c, f);
 			return -EIO;
 		}
@@ -831,7 +831,7 @@ static int jffs2_do_read_inode_internal(
 			JFFS2_ERROR("Argh. Special inode #%u with mode 0x%x had more than one node\n",
 			       f->inocache->ino, jemode_to_cpu(latest_node->mode));
 			/* FIXME: Deal with it - check crc32, check for duplicate node, check times and discard the older one */
-			up(&f->sem);
+			mutex_unlock(&f->mutex);
 			jffs2_do_clear_inode(c, f);
 			return -EIO;
 		}
@@ -922,12 +922,14 @@ int jffs2_do_crccheck_inode(struct jffs2
 		return -ENOMEM;
 
 	memset(f, 0, sizeof(*f));
-	init_MUTEX_LOCKED(&f->sem);
+	mutex_init(&f->mutex);
+
+	mutex_lock(&f->mutex);
 	f->inocache = ic;
 
 	ret = jffs2_do_read_inode_internal(c, f, &n);
 	if (!ret) {
-		up(&f->sem);
+		mutex_unlock(&f->mutex);
 		jffs2_do_clear_inode(c, f);
 	}
 	kfree (f);
@@ -939,7 +941,7 @@ void jffs2_do_clear_inode(struct jffs2_s
 	struct jffs2_full_dirent *fd, *fds;
 	int deleted;
 
-	down(&f->sem);
+	mutex_lock(&f->mutex);
 	deleted = f->inocache && !f->inocache->nlink;
 
 	if (f->inocache && f->inocache->state != INO_STATE_CHECKING)
@@ -971,5 +973,5 @@ void jffs2_do_clear_inode(struct jffs2_s
 			jffs2_del_ino_cache(c, f->inocache);
 	}
 
-	up(&f->sem);
+	mutex_unlock(&f->mutex);
 }
Index: linux/fs/jffs2/super.c
===================================================================
--- linux.orig/fs/jffs2/super.c
+++ linux/fs/jffs2/super.c
@@ -51,7 +51,7 @@ static void jffs2_i_init_once(void * foo
 
 	if ((flags & (SLAB_CTOR_VERIFY|SLAB_CTOR_CONSTRUCTOR)) ==
 	    SLAB_CTOR_CONSTRUCTOR) {
-		init_MUTEX(&ei->sem);
+		mutex_init(&ei->mutex);
 		inode_init_once(&ei->vfs_inode);
 	}
 }
@@ -60,9 +60,9 @@ static int jffs2_sync_fs(struct super_bl
 {
 	struct jffs2_sb_info *c = JFFS2_SB_INFO(sb);
 
-	down(&c->alloc_sem);
+	mutex_lock(&c->alloc_mutex);
 	jffs2_flush_wbuf_pad(c);
-	up(&c->alloc_sem);
+	mutex_unlock(&c->alloc_mutex);
 	return 0;
 }
 
@@ -142,8 +142,8 @@ static struct super_block *jffs2_get_sb_
 
 	/* Initialize JFFS2 superblock locks, the further initialization will be
 	 * done later */
-	init_MUTEX(&c->alloc_sem);
-	init_MUTEX(&c->erase_free_sem);
+	mutex_init(&c->alloc_mutex);
+	mutex_init(&c->erase_free_mutex);
 	init_waitqueue_head(&c->erase_wait);
 	init_waitqueue_head(&c->inocache_wq);
 	spin_lock_init(&c->erase_completion_lock);
@@ -279,9 +279,9 @@ static void jffs2_put_super (struct supe
 
 	D2(printk(KERN_DEBUG "jffs2: jffs2_put_super()\n"));
 
-	down(&c->alloc_sem);
+	mutex_lock(&c->alloc_mutex);
 	jffs2_flush_wbuf_pad(c);
-	up(&c->alloc_sem);
+	mutex_unlock(&c->alloc_mutex);
 
 	jffs2_sum_exit(c);
 
Index: linux/fs/jffs2/symlink.c
===================================================================
--- linux.orig/fs/jffs2/symlink.c
+++ linux/fs/jffs2/symlink.c
@@ -33,7 +33,7 @@ static void *jffs2_follow_link(struct de
 	char *p = (char *)f->target;
 
 	/*
-	 * We don't acquire the f->sem mutex here since the only data we
+	 * We don't acquire the f->mutex mutex here since the only data we
 	 * use is f->target.
 	 *
 	 * 1. If we are here the inode has already built and f->target has
@@ -54,7 +54,7 @@ static void *jffs2_follow_link(struct de
 	nd_set_link(nd, p);
 
 	/*
-	 * We will unlock the f->sem mutex but VFS will use the f->target string. This is safe
+	 * We will unlock the f->mutex mutex but VFS will use the f->target string. This is safe
 	 * since the only way that may cause f->target to be changed is iput() operation.
 	 * But VFS will not use f->target after iput() has been called.
 	 */
Index: linux/fs/jffs2/wbuf.c
===================================================================
--- linux.orig/fs/jffs2/wbuf.c
+++ linux/fs/jffs2/wbuf.c
@@ -420,9 +420,9 @@ static int __jffs2_flush_wbuf(struct jff
 	if (!jffs2_is_writebuffered(c))
 		return 0;
 
-	if (!down_trylock(&c->alloc_sem)) {
-		up(&c->alloc_sem);
-		printk(KERN_CRIT "jffs2_flush_wbuf() called with alloc_sem not locked!\n");
+	if (!!mutex_trylock(&c->alloc_mutex)) {
+		mutex_unlock(&c->alloc_mutex);
+		printk(KERN_CRIT "jffs2_flush_wbuf() called with alloc_mutex not locked!\n");
 		BUG();
 	}
 
@@ -537,10 +537,10 @@ int jffs2_flush_wbuf_gc(struct jffs2_sb_
 	if (!c->wbuf)
 		return 0;
 
-	down(&c->alloc_sem);
+	mutex_lock(&c->alloc_mutex);
 	if (!jffs2_wbuf_pending_for_ino(c, ino)) {
 		D1(printk(KERN_DEBUG "Ino #%d not pending in wbuf. Returning\n", ino));
-		up(&c->alloc_sem);
+		mutex_unlock(&c->alloc_mutex);
 		return 0;
 	}
 
@@ -550,39 +550,39 @@ int jffs2_flush_wbuf_gc(struct jffs2_sb_
 	if (c->unchecked_size) {
 		/* GC won't make any progress for a while */
 		D1(printk(KERN_DEBUG "jffs2_flush_wbuf_gc() padding. Not finished checking\n"));
-		down_write(&c->wbuf_sem);
+		down_write(&c->wbuf_mutex);
 		ret = __jffs2_flush_wbuf(c, PAD_ACCOUNTING);
 		/* retry flushing wbuf in case jffs2_wbuf_recover
 		   left some data in the wbuf */
 		if (ret)
 			ret = __jffs2_flush_wbuf(c, PAD_ACCOUNTING);
-		up_write(&c->wbuf_sem);
+		up_write(&c->wbuf_mutex);
 	} else while (old_wbuf_len &&
 		      old_wbuf_ofs == c->wbuf_ofs) {
 
-		up(&c->alloc_sem);
+		mutex_unlock(&c->alloc_mutex);
 
 		D1(printk(KERN_DEBUG "jffs2_flush_wbuf_gc() calls gc pass\n"));
 
 		ret = jffs2_garbage_collect_pass(c);
 		if (ret) {
 			/* GC failed. Flush it with padding instead */
-			down(&c->alloc_sem);
-			down_write(&c->wbuf_sem);
+			mutex_lock(&c->alloc_mutex);
+			down_write(&c->wbuf_mutex);
 			ret = __jffs2_flush_wbuf(c, PAD_ACCOUNTING);
 			/* retry flushing wbuf in case jffs2_wbuf_recover
 			   left some data in the wbuf */
 			if (ret)
 				ret = __jffs2_flush_wbuf(c, PAD_ACCOUNTING);
-			up_write(&c->wbuf_sem);
+			up_write(&c->wbuf_mutex);
 			break;
 		}
-		down(&c->alloc_sem);
+		mutex_lock(&c->alloc_mutex);
 	}
 
 	D1(printk(KERN_DEBUG "jffs2_flush_wbuf_gc() ends...\n"));
 
-	up(&c->alloc_sem);
+	mutex_unlock(&c->alloc_mutex);
 	return ret;
 }
 
@@ -594,12 +594,12 @@ int jffs2_flush_wbuf_pad(struct jffs2_sb
 	if (!c->wbuf)
 		return 0;
 
-	down_write(&c->wbuf_sem);
+	down_write(&c->wbuf_mutex);
 	ret = __jffs2_flush_wbuf(c, PAD_NOACCOUNT);
 	/* retry - maybe wbuf recover left some data in wbuf. */
 	if (ret)
 		ret = __jffs2_flush_wbuf(c, PAD_NOACCOUNT);
-	up_write(&c->wbuf_sem);
+	up_write(&c->wbuf_mutex);
 
 	return ret;
 }
@@ -620,7 +620,7 @@ int jffs2_flash_writev(struct jffs2_sb_i
 	if (!jffs2_is_writebuffered(c))
 		return jffs2_flash_direct_writev(c, invecs, count, to, retlen);
 
-	down_write(&c->wbuf_sem);
+	down_write(&c->wbuf_mutex);
 
 	/* If wbuf_ofs is not initialized, set it to target address */
 	if (c->wbuf_ofs == 0xFFFFFFFF) {
@@ -838,7 +838,7 @@ alldone:
 	ret = 0;
 
 exit:
-	up_write(&c->wbuf_sem);
+	up_write(&c->wbuf_mutex);
 	return ret;
 }
 
@@ -870,7 +870,7 @@ int jffs2_flash_read(struct jffs2_sb_inf
 		return c->mtd->read(c->mtd, ofs, len, retlen, buf);
 
 	/* Read flash */
-	down_read(&c->wbuf_sem);
+	down_read(&c->wbuf_mutex);
 	if (jffs2_cleanmarker_oob(c))
 		ret = c->mtd->read_ecc(c->mtd, ofs, len, retlen, buf, NULL, c->oobinfo);
 	else
@@ -919,7 +919,7 @@ int jffs2_flash_read(struct jffs2_sb_inf
 		memcpy(buf+orbf,c->wbuf+owbf,lwbf);
 
 exit:
-	up_read(&c->wbuf_sem);
+	up_read(&c->wbuf_mutex);
 	return ret;
 }
 
@@ -1164,7 +1164,7 @@ int jffs2_nand_flash_setup(struct jffs2_
 	int res;
 
 	/* Initialise write buffer */
-	init_rwsem(&c->wbuf_sem);
+	init_rwsem(&c->wbuf_mutex);
 	c->wbuf_pagesize = c->mtd->oobblock;
 	c->wbuf_ofs = 0xFFFFFFFF;
 
@@ -1195,7 +1195,7 @@ int jffs2_dataflash_setup(struct jffs2_s
 	c->cleanmarker_size = 0;		/* No cleanmarkers needed */
 
 	/* Initialize write buffer */
-	init_rwsem(&c->wbuf_sem);
+	init_rwsem(&c->wbuf_mutex);
 
 
 	c->wbuf_pagesize =  c->mtd->erasesize;
@@ -1241,7 +1241,7 @@ int jffs2_nor_ecc_flash_setup(struct jff
 	c->cleanmarker_size = 16;
 
 	/* Initialize write buffer */
-	init_rwsem(&c->wbuf_sem);
+	init_rwsem(&c->wbuf_mutex);
 	c->wbuf_pagesize = c->mtd->eccsize;
 	c->wbuf_ofs = 0xFFFFFFFF;
 
@@ -1261,7 +1261,7 @@ int jffs2_nor_wbuf_flash_setup(struct jf
 	c->cleanmarker_size = MTD_PROGREGION_SIZE(c->mtd);
 
 	/* Initialize write buffer */
-	init_rwsem(&c->wbuf_sem);
+	init_rwsem(&c->wbuf_mutex);
 	c->wbuf_pagesize = MTD_PROGREGION_SIZE(c->mtd);
 	c->wbuf_ofs = 0xFFFFFFFF;
 
Index: linux/fs/jffs2/write.c
===================================================================
--- linux.orig/fs/jffs2/write.c
+++ linux/fs/jffs2/write.c
@@ -157,12 +157,12 @@ struct jffs2_full_dnode *jffs2_write_dno
 							&dummy, JFFS2_SUMMARY_INODE_SIZE);
 			} else {
 				/* Locking pain */
-				up(&f->sem);
+				mutex_unlock(&f->mutex);
 				jffs2_complete_reservation(c);
 
 				ret = jffs2_reserve_space(c, sizeof(*ri) + datalen, &flash_ofs,
 							&dummy, alloc_mode, JFFS2_SUMMARY_INODE_SIZE);
-				down(&f->sem);
+				mutex_lock(&f->mutex);
 			}
 
 			if (!ret) {
@@ -305,12 +305,12 @@ struct jffs2_full_dirent *jffs2_write_di
 							&dummy, JFFS2_SUMMARY_DIRENT_SIZE(namelen));
 			} else {
 				/* Locking pain */
-				up(&f->sem);
+				mutex_unlock(&f->mutex);
 				jffs2_complete_reservation(c);
 
 				ret = jffs2_reserve_space(c, sizeof(*rd) + namelen, &flash_ofs,
 							&dummy, alloc_mode, JFFS2_SUMMARY_DIRENT_SIZE(namelen));
-				down(&f->sem);
+				mutex_lock(&f->mutex);
 			}
 
 			if (!ret) {
@@ -372,7 +372,7 @@ int jffs2_write_inode_range(struct jffs2
 			D1(printk(KERN_DEBUG "jffs2_reserve_space returned %d\n", ret));
 			break;
 		}
-		down(&f->sem);
+		mutex_lock(&f->mutex);
 		datalen = min_t(uint32_t, writelen, PAGE_CACHE_SIZE - (offset & (PAGE_CACHE_SIZE-1)));
 		cdatalen = min_t(uint32_t, alloclen - sizeof(*ri), datalen);
 
@@ -400,7 +400,7 @@ int jffs2_write_inode_range(struct jffs2
 
 		if (IS_ERR(fn)) {
 			ret = PTR_ERR(fn);
-			up(&f->sem);
+			mutex_unlock(&f->mutex);
 			jffs2_complete_reservation(c);
 			if (!retried) {
 				/* Write error to be retried */
@@ -422,11 +422,11 @@ int jffs2_write_inode_range(struct jffs2
 			jffs2_mark_node_obsolete(c, fn->raw);
 			jffs2_free_full_dnode(fn);
 
-			up(&f->sem);
+			mutex_unlock(&f->mutex);
 			jffs2_complete_reservation(c);
 			break;
 		}
-		up(&f->sem);
+		mutex_unlock(&f->mutex);
 		jffs2_complete_reservation(c);
 		if (!datalen) {
 			printk(KERN_WARNING "Eep. We didn't actually write any data in jffs2_write_inode_range()\n");
@@ -458,7 +458,7 @@ int jffs2_do_create(struct jffs2_sb_info
 				JFFS2_SUMMARY_INODE_SIZE);
 	D1(printk(KERN_DEBUG "jffs2_do_create(): reserved 0x%x bytes\n", alloclen));
 	if (ret) {
-		up(&f->sem);
+		mutex_unlock(&f->mutex);
 		return ret;
 	}
 
@@ -473,7 +473,7 @@ int jffs2_do_create(struct jffs2_sb_info
 	if (IS_ERR(fn)) {
 		D1(printk(KERN_DEBUG "jffs2_write_dnode() failed\n"));
 		/* Eeek. Wave bye bye */
-		up(&f->sem);
+		mutex_unlock(&f->mutex);
 		jffs2_complete_reservation(c);
 		return PTR_ERR(fn);
 	}
@@ -482,7 +482,7 @@ int jffs2_do_create(struct jffs2_sb_info
 	*/
 	f->metadata = fn;
 
-	up(&f->sem);
+	mutex_unlock(&f->mutex);
 	jffs2_complete_reservation(c);
 	ret = jffs2_reserve_space(c, sizeof(*rd)+namelen, &phys_ofs, &alloclen,
 				ALLOC_NORMAL, JFFS2_SUMMARY_DIRENT_SIZE(namelen));
@@ -500,7 +500,7 @@ int jffs2_do_create(struct jffs2_sb_info
 		return -ENOMEM;
 	}
 
-	down(&dir_f->sem);
+	mutex_lock(&dir_f->mutex);
 
 	rd->magic = cpu_to_je16(JFFS2_MAGIC_BITMASK);
 	rd->nodetype = cpu_to_je16(JFFS2_NODETYPE_DIRENT);
@@ -524,7 +524,7 @@ int jffs2_do_create(struct jffs2_sb_info
 		/* dirent failed to write. Delete the inode normally
 		   as if it were the final unlink() */
 		jffs2_complete_reservation(c);
-		up(&dir_f->sem);
+		mutex_unlock(&dir_f->mutex);
 		return PTR_ERR(fd);
 	}
 
@@ -533,7 +533,7 @@ int jffs2_do_create(struct jffs2_sb_info
 	jffs2_add_fd_to_list(c, fd, &dir_f->dents);
 
 	jffs2_complete_reservation(c);
-	up(&dir_f->sem);
+	mutex_unlock(&dir_f->mutex);
 
 	return 0;
 }
@@ -563,7 +563,7 @@ int jffs2_do_unlink(struct jffs2_sb_info
 			return ret;
 		}
 
-		down(&dir_f->sem);
+		mutex_lock(&dir_f->mutex);
 
 		/* Build a deletion node */
 		rd->magic = cpu_to_je16(JFFS2_MAGIC_BITMASK);
@@ -586,18 +586,18 @@ int jffs2_do_unlink(struct jffs2_sb_info
 
 		if (IS_ERR(fd)) {
 			jffs2_complete_reservation(c);
-			up(&dir_f->sem);
+			mutex_unlock(&dir_f->mutex);
 			return PTR_ERR(fd);
 		}
 
 		/* File it. This will mark the old one obsolete. */
 		jffs2_add_fd_to_list(c, fd, &dir_f->dents);
-		up(&dir_f->sem);
+		mutex_unlock(&dir_f->mutex);
 	} else {
 		struct jffs2_full_dirent **prev = &dir_f->dents;
 		uint32_t nhash = full_name_hash(name, namelen);
 
-		down(&dir_f->sem);
+		mutex_lock(&dir_f->mutex);
 
 		while ((*prev) && (*prev)->nhash <= nhash) {
 			if ((*prev)->nhash == nhash &&
@@ -615,7 +615,7 @@ int jffs2_do_unlink(struct jffs2_sb_info
 			}
 			prev = &((*prev)->next);
 		}
-		up(&dir_f->sem);
+		mutex_unlock(&dir_f->mutex);
 	}
 
 	/* dead_f is NULL if this was a rename not a real unlink */
@@ -623,7 +623,7 @@ int jffs2_do_unlink(struct jffs2_sb_info
 	   pointing to an inode which didn't exist. */
 	if (dead_f && dead_f->inocache) {
 
-		down(&dead_f->sem);
+		mutex_lock(&dead_f->mutex);
 
 		if (S_ISDIR(OFNI_EDONI_2SFFJ(dead_f)->i_mode)) {
 			while (dead_f->dents) {
@@ -646,7 +646,7 @@ int jffs2_do_unlink(struct jffs2_sb_info
 
 		dead_f->inocache->nlink--;
 		/* NB: Caller must set inode nlink if appropriate */
-		up(&dead_f->sem);
+		mutex_unlock(&dead_f->mutex);
 	}
 
 	jffs2_complete_reservation(c);
@@ -673,7 +673,7 @@ int jffs2_do_link (struct jffs2_sb_info 
 		return ret;
 	}
 
-	down(&dir_f->sem);
+	mutex_lock(&dir_f->mutex);
 
 	/* Build a deletion node */
 	rd->magic = cpu_to_je16(JFFS2_MAGIC_BITMASK);
@@ -698,7 +698,7 @@ int jffs2_do_link (struct jffs2_sb_info 
 
 	if (IS_ERR(fd)) {
 		jffs2_complete_reservation(c);
-		up(&dir_f->sem);
+		mutex_unlock(&dir_f->mutex);
 		return PTR_ERR(fd);
 	}
 
@@ -706,7 +706,7 @@ int jffs2_do_link (struct jffs2_sb_info 
 	jffs2_add_fd_to_list(c, fd, &dir_f->dents);
 
 	jffs2_complete_reservation(c);
-	up(&dir_f->sem);
+	mutex_unlock(&dir_f->mutex);
 
 	return 0;
 }
Index: linux/include/linux/jffs2_fs_i.h
===================================================================
--- linux.orig/include/linux/jffs2_fs_i.h
+++ linux/include/linux/jffs2_fs_i.h
@@ -5,7 +5,7 @@
 
 #include <linux/version.h>
 #include <linux/rbtree.h>
-#include <asm/semaphore.h>
+#include <linux/mutex.h>
 
 struct jffs2_inode_info {
 	/* We need an internal mutex similar to inode->i_mutex.
@@ -14,7 +14,7 @@ struct jffs2_inode_info {
 	   before letting GC proceed. Or we'd have to put ugliness
 	   into the GC code so it didn't attempt to obtain the i_mutex
 	   for the inode(s) which are already locked */
-	struct semaphore sem;
+	struct mutex mutex;
 
 	/* The highest (datanode) version number used for this ino */
 	uint32_t highest_version;
Index: linux/include/linux/jffs2_fs_sb.h
===================================================================
--- linux.orig/include/linux/jffs2_fs_sb.h
+++ linux/include/linux/jffs2_fs_sb.h
@@ -4,10 +4,11 @@
 #define _JFFS2_FS_SB
 
 #include <linux/types.h>
+#include <linux/mutex.h>
 #include <linux/spinlock.h>
 #include <linux/workqueue.h>
 #include <linux/completion.h>
-#include <asm/semaphore.h>
+#include <linux/mutex.h>
 #include <linux/timer.h>
 #include <linux/wait.h>
 #include <linux/list.h>
@@ -35,7 +36,7 @@ struct jffs2_sb_info {
 	struct completion gc_thread_start; /* GC thread start completion */
 	struct completion gc_thread_exit; /* GC thread exit completion port */
 
-	struct semaphore alloc_sem;	/* Used to protect all the following
+	struct mutex alloc_mutex;	/* Used to protect all the following
 					   fields, and also to protect against
 					   out-of-order writing of nodes. And GC. */
 	uint32_t cleanmarker_size;	/* Size of an _inline_ CLEANMARKER
@@ -93,7 +94,7 @@ struct jffs2_sb_info {
 	/* Sem to allow jffs2_garbage_collect_deletion_dirent to
 	   drop the erase_completion_lock while it's holding a pointer
 	   to an obsoleted node. I don't like this. Alternatives welcomed. */
-	struct semaphore erase_free_sem;
+	struct mutex erase_free_mutex;
 
 	uint32_t wbuf_pagesize; /* 0 for NOR and other flashes with no wbuf */
 
@@ -104,7 +105,7 @@ struct jffs2_sb_info {
 	uint32_t wbuf_len;
 	struct jffs2_inodirty *wbuf_inodes;
 
-	struct rw_semaphore wbuf_sem;	/* Protects the write buffer */
+	struct rw_semaphore wbuf_mutex;	/* Protects the write buffer */
 
 	/* Information about out-of-band area usage... */
 	struct nand_oobinfo *oobinfo;
