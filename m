Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284147AbRLAQ3Y>; Sat, 1 Dec 2001 11:29:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284150AbRLAQ3T>; Sat, 1 Dec 2001 11:29:19 -0500
Received: from netfinity.realnet.co.sz ([196.28.7.2]:5845 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S284147AbRLAQ3D>; Sat, 1 Dec 2001 11:29:03 -0500
Date: Sat, 1 Dec 2001 18:33:50 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: <zwane@netfinity.realnet.co.sz>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: <sct@redhat.com>
Subject: [PATCH] if (foo) kfree(foo) /fs cleanup + reverted JBD code path
 changes
In-Reply-To: <Pine.LNX.4.33.0112011336040.11026-100000@netfinity.realnet.co.sz>
Message-ID: <Pine.LNX.4.33.0112011830550.14290-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Same /fs kfree cleanup patch with the fs/jbd/commit.c code path changes
reverted as advised by Stephen Tweedie


diff -urN linux-2.5.1-pre4.orig/fs/affs/super.c linux-2.5.1-pre4.kfree/fs/affs/super.c
--- linux-2.5.1-pre4.orig/fs/affs/super.c	Tue Nov 13 19:19:41 2001
+++ linux-2.5.1-pre4.kfree/fs/affs/super.c	Fri Nov 30 23:42:16 2001
@@ -49,8 +49,8 @@
 	}

 	affs_brelse(AFFS_SB->s_bmap_bh);
-	if (AFFS_SB->s_prefix)
-		kfree(AFFS_SB->s_prefix);
+
+	kfree(AFFS_SB->s_prefix);
 	kfree(AFFS_SB->s_bitmap);
 	affs_brelse(AFFS_SB->s_root_bh);

@@ -143,10 +143,11 @@
 			optn = "prefix";
 			if (!value || !*value)
 				goto out_no_arg;
-			if (*prefix) {		/* Free any previous prefix */
-				kfree(*prefix);
-				*prefix = NULL;
-			}
+
+			/* Free any previous prefix */
+			kfree(*prefix);
+			*prefix = NULL;
+
 			*prefix = kmalloc(strlen(value) + 1,GFP_KERNEL);
 			if (!*prefix)
 				return 0;
@@ -427,11 +428,10 @@
 out_error:
 	if (root_inode)
 		iput(root_inode);
-	if (AFFS_SB->s_bitmap)
-		kfree(AFFS_SB->s_bitmap);
+
+	kfree(AFFS_SB->s_bitmap);
 	affs_brelse(root_bh);
-	if (AFFS_SB->s_prefix)
-		kfree(AFFS_SB->s_prefix);
+	kfree(AFFS_SB->s_prefix);
 	return NULL;
 }

diff -urN linux-2.5.1-pre4.orig/fs/autofs/waitq.c linux-2.5.1-pre4.kfree/fs/autofs/waitq.c
--- linux-2.5.1-pre4.orig/fs/autofs/waitq.c	Fri Feb  9 21:29:44 2001
+++ linux-2.5.1-pre4.kfree/fs/autofs/waitq.c	Sat Dec  1 00:21:04 2001
@@ -150,10 +150,8 @@
 	if ( sbi->catatonic ) {
 		/* We might have slept, so check again for catatonic mode */
 		wq->status = -ENOENT;
-		if ( wq->name ) {
-			kfree(wq->name);
-			wq->name = NULL;
-		}
+		kfree(wq->name);
+		wq->name = NULL;
 	}

 	if ( wq->name ) {
diff -urN linux-2.5.1-pre4.orig/fs/autofs4/inode.c linux-2.5.1-pre4.kfree/fs/autofs4/inode.c
--- linux-2.5.1-pre4.orig/fs/autofs4/inode.c	Sat Nov 10 00:11:14 2001
+++ linux-2.5.1-pre4.kfree/fs/autofs4/inode.c	Sat Dec  1 00:25:08 2001
@@ -21,10 +21,8 @@

 static void ino_lnkfree(struct autofs_info *ino)
 {
-	if (ino->u.symlink) {
-		kfree(ino->u.symlink);
-		ino->u.symlink = NULL;
-	}
+	kfree(ino->u.symlink);
+	ino->u.symlink = NULL;
 }

 struct autofs_info *autofs4_init_ino(struct autofs_info *ino,
diff -urN linux-2.5.1-pre4.orig/fs/autofs4/waitq.c linux-2.5.1-pre4.kfree/fs/autofs4/waitq.c
--- linux-2.5.1-pre4.orig/fs/autofs4/waitq.c	Fri Feb  9 21:29:44 2001
+++ linux-2.5.1-pre4.kfree/fs/autofs4/waitq.c	Sat Dec  1 00:24:35 2001
@@ -187,10 +187,8 @@
 	if ( sbi->catatonic ) {
 		/* We might have slept, so check again for catatonic mode */
 		wq->status = -ENOENT;
-		if ( wq->name ) {
-			kfree(wq->name);
-			wq->name = NULL;
-		}
+		kfree(wq->name);
+		wq->name = NULL;
 	}

 	if ( wq->name ) {
diff -urN linux-2.5.1-pre4.orig/fs/binfmt_elf.c linux-2.5.1-pre4.kfree/fs/binfmt_elf.c
--- linux-2.5.1-pre4.orig/fs/binfmt_elf.c	Sun Oct 21 04:16:59 2001
+++ linux-2.5.1-pre4.kfree/fs/binfmt_elf.c	Sat Dec  1 00:24:11 2001
@@ -793,8 +793,7 @@
 	allow_write_access(interpreter);
 	fput(interpreter);
 out_free_interp:
-	if (elf_interpreter)
-		kfree(elf_interpreter);
+	kfree(elf_interpreter);
 out_free_file:
 	sys_close(elf_exec_fileno);
 out_free_ph:
diff -urN linux-2.5.1-pre4.orig/fs/coda/file.c linux-2.5.1-pre4.kfree/fs/coda/file.c
--- linux-2.5.1-pre4.orig/fs/coda/file.c	Sat Sep 22 20:11:09 2001
+++ linux-2.5.1-pre4.kfree/fs/coda/file.c	Fri Nov 30 23:44:01 2001
@@ -228,11 +228,9 @@
 	fput(cfile);
 	cii->c_container = NULL;

-	if (f->private_data) {
-		kfree(f->private_data);
-		f->private_data = NULL;
-	}
-
+	kfree(f->private_data);
+	f->private_data = NULL;
+
 	unlock_kernel();
 	return err;
 }
diff -urN linux-2.5.1-pre4.orig/fs/coda/inode.c linux-2.5.1-pre4.kfree/fs/coda/inode.c
--- linux-2.5.1-pre4.orig/fs/coda/inode.c	Fri Apr 27 23:09:37 2001
+++ linux-2.5.1-pre4.kfree/fs/coda/inode.c	Fri Nov 30 23:45:08 2001
@@ -164,11 +164,10 @@

  error:
 	EXIT;
-	if (sbi) {
-		kfree(sbi);
-		if(vc)
-			vc->vc_sb = NULL;
-	}
+	kfree(sbi);
+	if (vc)
+		vc->vc_sb = NULL;
+
 	if (root)
                 iput(root);

diff -urN linux-2.5.1-pre4.orig/fs/devfs/base.c linux-2.5.1-pre4.kfree/fs/devfs/base.c
--- linux-2.5.1-pre4.orig/fs/devfs/base.c	Sat Nov  3 20:06:38 2001
+++ linux-2.5.1-pre4.kfree/fs/devfs/base.c	Sat Dec  1 09:16:21 2001
@@ -1446,7 +1446,7 @@
     {
 	de->registered = FALSE;
 	down_write (&symlink_rwsem);
-	if (de->u.symlink.linkname) kfree (de->u.symlink.linkname);
+	kfree (de->u.symlink.linkname);
 	de->u.symlink.linkname = NULL;
 	up_write (&symlink_rwsem);
 	return;
@@ -2818,7 +2818,7 @@
     if ( S_ISLNK (de->mode) )
     {
 	down_write (&symlink_rwsem);
-	if (de->u.symlink.linkname) kfree (de->u.symlink.linkname);
+	kfree (de->u.symlink.linkname);
 	de->u.symlink.linkname = NULL;
 	up_write (&symlink_rwsem);
     }
diff -urN linux-2.5.1-pre4.orig/fs/fat/inode.c linux-2.5.1-pre4.kfree/fs/fat/inode.c
--- linux-2.5.1-pre4.orig/fs/fat/inode.c	Wed Nov 21 00:15:26 2001
+++ linux-2.5.1-pre4.kfree/fs/fat/inode.c	Sat Dec  1 09:11:29 2001
@@ -200,10 +200,8 @@
 	 * Note: the iocharset option might have been specified
 	 * without enabling nls_io, so check for it here.
 	 */
-	if (MSDOS_SB(sb)->options.iocharset) {
-		kfree(MSDOS_SB(sb)->options.iocharset);
-		MSDOS_SB(sb)->options.iocharset = NULL;
-	}
+	kfree(MSDOS_SB(sb)->options.iocharset);
+	MSDOS_SB(sb)->options.iocharset = NULL;
 }


@@ -338,10 +336,9 @@
 			if (len) {
 				char *buffer;

-				if (opts->iocharset != NULL) {
-					kfree(opts->iocharset);
-					opts->iocharset = NULL;
-				}
+				kfree(opts->iocharset);
+				opts->iocharset = NULL;
+
 				buffer = kmalloc(len + 1, GFP_KERNEL);
 				if (buffer != NULL) {
 					opts->iocharset = buffer;
@@ -805,12 +802,10 @@
 			kdevname(sb->s_dev));
 	}
 out_fail:
-	if (opts.iocharset) {
-		printk("FAT: freeing iocharset=%s\n", opts.iocharset);
-		kfree(opts.iocharset);
-	}
-	if(sbi->private_data)
-		kfree(sbi->private_data);
+	printk("FAT: freeing iocharset=%s\n", opts.iocharset);
+	kfree(opts.iocharset);
+
+	kfree(sbi->private_data);
 	sbi->private_data = NULL;

 	return NULL;
diff -urN linux-2.5.1-pre4.orig/fs/hpfs/dnode.c linux-2.5.1-pre4.kfree/fs/hpfs/dnode.c
--- linux-2.5.1-pre4.orig/fs/hpfs/dnode.c	Tue Sep  5 23:07:29 2000
+++ linux-2.5.1-pre4.kfree/fs/hpfs/dnode.c	Fri Nov 30 23:49:33 2001
@@ -236,12 +236,12 @@
 	go_up:
 	if (namelen >= 256) {
 		hpfs_error(i->i_sb, "hpfs_add_to_dnode: namelen == %d", namelen);
-		if (nd) kfree(nd);
+		kfree(nd);
 		kfree(nname);
 		return 1;
 	}
 	if (!(d = hpfs_map_dnode(i->i_sb, dno, &qbh))) {
-		if (nd) kfree(nd);
+		kfree(nd);
 		kfree(nname);
 		return 1;
 	}
@@ -249,7 +249,7 @@
 	if (i->i_sb->s_hpfs_chk)
 		if (hpfs_stop_cycles(i->i_sb, dno, &c1, &c2, "hpfs_add_to_dnode")) {
 			hpfs_brelse4(&qbh);
-			if (nd) kfree(nd);
+			kfree(nd);
 			kfree(nname);
 			return 1;
 		}
@@ -262,7 +262,7 @@
 		for_all_poss(i, hpfs_pos_subst, 5, t + 1);
 		hpfs_mark_4buffers_dirty(&qbh);
 		hpfs_brelse4(&qbh);
-		if (nd) kfree(nd);
+		kfree(nd);
 		kfree(nname);
 		return 0;
 	}
diff -urN linux-2.5.1-pre4.orig/fs/hpfs/super.c linux-2.5.1-pre4.kfree/fs/hpfs/super.c
--- linux-2.5.1-pre4.orig/fs/hpfs/super.c	Thu Oct 25 09:02:26 2001
+++ linux-2.5.1-pre4.kfree/fs/hpfs/super.c	Fri Nov 30 23:51:55 2001
@@ -74,7 +74,7 @@
 		} else if (s->s_flags & MS_RDONLY) printk("; going on - but anything won't be destroyed because it's read-only\n");
 		else printk("; corrupted filesystem mounted read/write - your computer will explode within 20 seconds ... but you wanted it so!\n");
 	} else printk("\n");
-	if (buf) kfree(buf);
+	kfree(buf);
 	s->s_hpfs_was_error = 1;
 }

@@ -100,8 +100,8 @@

 void hpfs_put_super(struct super_block *s)
 {
-	if (s->s_hpfs_cp_table) kfree(s->s_hpfs_cp_table);
-	if (s->s_hpfs_bmp_dir) kfree(s->s_hpfs_bmp_dir);
+	kfree(s->s_hpfs_cp_table);
+	kfree(s->s_hpfs_bmp_dir);
 	unmark_dirty(s);
 }

@@ -563,8 +563,8 @@
 bail2:	brelse(bh0);
 bail1:
 bail0:
-	if (s->s_hpfs_bmp_dir) kfree(s->s_hpfs_bmp_dir);
-	if (s->s_hpfs_cp_table) kfree(s->s_hpfs_cp_table);
+	kfree(s->s_hpfs_bmp_dir);
+	kfree(s->s_hpfs_cp_table);
 	return NULL;
 }

Binary files linux-2.5.1-pre4.orig/fs/isofs/.inode.c.swp and linux-2.5.1-pre4.kfree/fs/isofs/.inode.c.swp differ
diff -urN linux-2.5.1-pre4.orig/fs/isofs/inode.c linux-2.5.1-pre4.kfree/fs/isofs/inode.c
--- linux-2.5.1-pre4.orig/fs/isofs/inode.c	Thu Oct 25 22:53:53 2001
+++ linux-2.5.1-pre4.kfree/fs/isofs/inode.c	Sat Dec  1 12:12:06 2001
@@ -1112,8 +1112,7 @@
 			goto out_toomany;
 	} while(more_entries);
 out:
-	if (tmpde)
-		kfree(tmpde);
+	kfree(tmpde);
 	if (bh)
 		brelse(bh);
 	return 0;
@@ -1125,8 +1124,7 @@

 out_noread:
 	printk(KERN_INFO "ISOFS: unable to read i-node block %lu\n", block);
-	if (tmpde)
-		kfree(tmpde);
+	kfree(tmpde);
 	return -EIO;

 out_toomany:
@@ -1329,8 +1327,7 @@
 					   kdev_t_to_nr(inode->i_rdev));
 	}
  out:
-	if (tmpde)
-		kfree(tmpde);
+	kfree(tmpde);
 	if (bh)
 		brelse(bh);
 	return;
diff -urN linux-2.5.1-pre4.orig/fs/isofs/rock.c linux-2.5.1-pre4.kfree/fs/isofs/rock.c
--- linux-2.5.1-pre4.orig/fs/isofs/rock.c	Thu Oct 25 22:53:53 2001
+++ linux-2.5.1-pre4.kfree/fs/isofs/rock.c	Sat Dec  1 00:19:09 2001
@@ -60,7 +60,7 @@
 }

 #define MAYBE_CONTINUE(LABEL,DEV) \
-  {if (buffer) kfree(buffer); \
+  {kfree(buffer); \
   if (cont_extent){ \
     int block, offset, offset1; \
     struct buffer_head * pbh; \
@@ -149,7 +149,7 @@
   MAYBE_CONTINUE(repeat, inode);
   return retval;
  out:
-  if(buffer) kfree(buffer);
+  kfree(buffer);
   return retval;
 }

@@ -213,7 +213,7 @@
 	retnamlen += rr->len - 5;
 	break;
       case SIG('R','E'):
-	if (buffer) kfree(buffer);
+	kfree(buffer);
 	return -1;
       default:
 	break;
@@ -223,7 +223,7 @@
   MAYBE_CONTINUE(repeat,inode);
   return retnamlen; /* If 0, this file did not have a NM field */
  out:
-  if(buffer) kfree(buffer);
+  kfree(buffer);
   return 0;
 }

@@ -415,7 +415,7 @@
   MAYBE_CONTINUE(repeat,inode);
   return 0;
  out:
-  if(buffer) kfree(buffer);
+  kfree(buffer);
   return 0;
 }

@@ -571,8 +571,7 @@

 	/* error exit from macro */
       out:
-	if (buffer)
-		kfree(buffer);
+	kfree(buffer);
 	goto fail;
       out_noread:
 	printk("unable to read i-node block");
diff -urN linux-2.5.1-pre4.orig/fs/jbd/transaction.c linux-2.5.1-pre4.kfree/fs/jbd/transaction.c
--- linux-2.5.1-pre4.orig/fs/jbd/transaction.c	Sat Nov 10 00:25:04 2001
+++ linux-2.5.1-pre4.kfree/fs/jbd/transaction.c	Fri Nov 30 23:29:20 2001
@@ -739,8 +739,7 @@
 	journal_cancel_revoke(handle, jh);

 out_unlocked:
-	if (frozen_buffer)
-		kfree(frozen_buffer);
+	kfree(frozen_buffer);

 	JBUFFER_TRACE(jh, "exit");
 	return error;
diff -urN linux-2.5.1-pre4.orig/fs/jffs/intrep.c linux-2.5.1-pre4.kfree/fs/jffs/intrep.c
--- linux-2.5.1-pre4.orig/fs/jffs/intrep.c	Fri Oct  5 00:13:18 2001
+++ linux-2.5.1-pre4.kfree/fs/jffs/intrep.c	Fri Nov 30 23:54:38 2001
@@ -1670,8 +1670,7 @@
 		}
 		printk("jffs_find_child(): Didn't find the file \"%s\".\n",
 		       (copy ? copy : ""));
-		if (copy) {
-			kfree(copy);
+		kfree(copy);
 		}
 	});

diff -urN linux-2.5.1-pre4.orig/fs/jffs2/file.c linux-2.5.1-pre4.kfree/fs/jffs2/file.c
--- linux-2.5.1-pre4.orig/fs/jffs2/file.c	Fri Oct  5 00:13:18 2001
+++ linux-2.5.1-pre4.kfree/fs/jffs2/file.c	Sat Dec  1 00:16:42 2001
@@ -449,8 +449,7 @@
 		}
 		if (comprtype == JFFS2_COMPR_NONE) {
 			/* Either compression failed, or the allocation of comprbuf failed */
-			if (comprbuf)
-				kfree(comprbuf);
+			kfree(comprbuf);
 			comprbuf = page_address(pg) + (file_ofs & (PAGE_CACHE_SIZE -1));
 			datalen = cdatalen;
 		}
diff -urN linux-2.5.1-pre4.orig/fs/jffs2/gc.c linux-2.5.1-pre4.kfree/fs/jffs2/gc.c
--- linux-2.5.1-pre4.orig/fs/jffs2/gc.c	Fri Oct  5 00:13:18 2001
+++ linux-2.5.1-pre4.kfree/fs/jffs2/gc.c	Sat Dec  1 00:15:43 2001
@@ -649,7 +649,7 @@
 			f->metadata = NULL;
 		}
 	}
-	if (comprbuf) kfree(comprbuf);
+	kfree(comprbuf);

 	kunmap(pg);
 	/* XXX: Does the page get freed automatically? */
diff -urN linux-2.5.1-pre4.orig/fs/namespace.c linux-2.5.1-pre4.kfree/fs/namespace.c
--- linux-2.5.1-pre4.orig/fs/namespace.c	Sun Nov 11 21:23:14 2001
+++ linux-2.5.1-pre4.kfree/fs/namespace.c	Sat Dec  1 00:22:41 2001
@@ -1082,8 +1082,7 @@
 	spin_lock(&dcache_lock);
 	attach_mnt(old_rootmnt, &nd);
 	if (new_devname) {
-		if (old_rootmnt->mnt_devname)
-			kfree(old_rootmnt->mnt_devname);
+		kfree(old_rootmnt->mnt_devname);
 		old_rootmnt->mnt_devname = new_devname;
 	}
 	spin_unlock(&dcache_lock);
diff -urN linux-2.5.1-pre4.orig/fs/nfs/flushd.c linux-2.5.1-pre4.kfree/fs/nfs/flushd.c
--- linux-2.5.1-pre4.orig/fs/nfs/flushd.c	Sat Nov 10 00:28:15 2001
+++ linux-2.5.1-pre4.kfree/fs/nfs/flushd.c	Fri Nov 30 23:37:51 2001
@@ -141,10 +141,8 @@

 void nfs_reqlist_free(struct nfs_server *server)
 {
-	if (server->rw_requests) {
-		kfree(server->rw_requests);
-		server->rw_requests = NULL;
-	}
+	kfree(server->rw_requests);
+	server->rw_requests = NULL;
 }

 #define NFS_FLUSHD_TIMEOUT	(30*HZ)
diff -urN linux-2.5.1-pre4.orig/fs/nfs/unlink.c linux-2.5.1-pre4.kfree/fs/nfs/unlink.c
--- linux-2.5.1-pre4.orig/fs/nfs/unlink.c	Thu Aug 16 18:39:37 2001
+++ linux-2.5.1-pre4.kfree/fs/nfs/unlink.c	Fri Nov 30 23:28:26 2001
@@ -52,8 +52,7 @@
 {
 	if (--data->count == 0) {
 		nfs_detach_unlinkdata(data);
-		if (data->name.name != NULL)
-			kfree(data->name.name);
+		kfree(data->name.name);
 		kfree(data);
 	}
 }
diff -urN linux-2.5.1-pre4.orig/fs/nfsd/nfsctl.c linux-2.5.1-pre4.kfree/fs/nfsd/nfsctl.c
--- linux-2.5.1-pre4.orig/fs/nfsd/nfsctl.c	Sun Oct 21 19:32:33 2001
+++ linux-2.5.1-pre4.kfree/fs/nfsd/nfsctl.c	Fri Nov 30 23:57:09 2001
@@ -295,10 +295,8 @@
 		copy_to_user(resp, res, respsize);

 done:
-	if (arg)
-		kfree(arg);
-	if (res)
-		kfree(res);
+	kfree(arg);
+	kfree(res);

 	unlock_kernel ();
 	MOD_DEC_USE_COUNT;
diff -urN linux-2.5.1-pre4.orig/fs/openpromfs/inode.c linux-2.5.1-pre4.kfree/fs/openpromfs/inode.c
--- linux-2.5.1-pre4.orig/fs/openpromfs/inode.c	Sun Nov 11 20:13:25 2001
+++ linux-2.5.1-pre4.kfree/fs/openpromfs/inode.c	Sat Dec  1 09:17:50 2001
@@ -1044,8 +1044,7 @@
 	unregister_filesystem(&openprom_fs_type);
 	free_pages ((unsigned long)nodes, alloced);
 	for (i = 0; i < aliases_nodes; i++)
-		if (alias_names [i])
-			kfree (alias_names [i]);
+		kfree (alias_names [i]);
 	nodes = NULL;
 }

diff -urN linux-2.5.1-pre4.orig/fs/ufs/super.c linux-2.5.1-pre4.kfree/fs/ufs/super.c
--- linux-2.5.1-pre4.orig/fs/ufs/super.c	Tue Nov 20 00:55:46 2001
+++ linux-2.5.1-pre4.kfree/fs/ufs/super.c	Sat Dec  1 09:13:00 2001
@@ -381,13 +381,13 @@
 	return 1;

 failed:
-	if (base) kfree (base);
+	kfree (base);
 	if (sb->u.ufs_sb.s_ucg) {
 		for (i = 0; i < uspi->s_ncg; i++)
 			if (sb->u.ufs_sb.s_ucg[i]) brelse (sb->u.ufs_sb.s_ucg[i]);
 		kfree (sb->u.ufs_sb.s_ucg);
 		for (i = 0; i < UFS_MAX_GROUP_LOADED; i++)
-			if (sb->u.ufs_sb.s_ucpi[i]) kfree (sb->u.ufs_sb.s_ucpi[i]);
+			kfree (sb->u.ufs_sb.s_ucpi[i]);
 	}
 	UFSD(("EXIT (FAILED)\n"))
 	return 0;
@@ -804,7 +804,7 @@

 failed:
 	if (ubh) ubh_brelse_uspi (uspi);
-	if (uspi) kfree (uspi);
+	kfree (uspi);
 	UFSD(("EXIT (FAILED)\n"))
 	return(NULL);
 }

