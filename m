Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317589AbSIENwp>; Thu, 5 Sep 2002 09:52:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317590AbSIENwp>; Thu, 5 Sep 2002 09:52:45 -0400
Received: from angband.namesys.com ([212.16.7.85]:21161 "HELO
	angband.namesys.com") by vger.kernel.org with SMTP
	id <S317589AbSIENwk>; Thu, 5 Sep 2002 09:52:40 -0400
Date: Thu, 5 Sep 2002 17:57:11 +0400
From: Oleg Drokin <green@namesys.com>
To: mason@suse.com
Cc: szepe@pinerecords.com, linux-kernel@vger.kernel.org,
       reiserfs-dev@namesys.com
Subject: Re: [reiserfs-dev] Re: [PATCH] sparc32: wrong type of nlink_t
Message-ID: <20020905175711.B32687@namesys.com>
References: <3D76A6FF.509@namesys.com> <1031186951.1684.205.camel@tiny> <20020905054008.GH24323@louise.pinerecords.com> <20020904.223651.79770866.davem@redhat.com> <20020905135442.A19682@namesys.com> <20020905174902.A32687@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20020905174902.A32687@namesys.com>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Thu, Sep 05, 2002 at 05:49:02PM +0400, Oleg Drokin wrote:

> > Ok, since I really like this approach, below is the patch (for 2.4) that
> > demonstrates my solution.
> > Also it correctly calculates maximal number given type may hold ( does not work
> > with unsigned long long, though) with my own way ;)
> Version that actually works is now here ;)

Heh, diffed against wrong tree :(
Corrected diff is here.

Also I trimmed CC list since I afraid Marcelo, DaveM adn jfs people are not very
interested in this reiserfs only patch.

Bye,
    Oleg

===== fs/reiserfs/inode.c 1.35 vs edited =====
--- 1.35/fs/reiserfs/inode.c	Fri Aug  9 19:22:33 2002
+++ edited/fs/reiserfs/inode.c	Thu Sep  5 13:43:26 2002
@@ -891,7 +891,8 @@
 	set_inode_item_key_version (inode, KEY_FORMAT_3_5);
         set_inode_sd_version (inode, STAT_DATA_V1);
 	inode->i_mode  = sd_v1_mode(sd);
-	inode->i_nlink = sd_v1_nlink(sd);
+	inode->i_nlink = ( sd_v1_nlink(sd) > REISERFS_LINK_MAX ) ? REISERFS_LINK_MAX:sd_v1_nlink(sd);
+	inode->u.reiserfs_i.i_nlink_real = sd_v1_nlink(sd);
 	inode->i_uid   = sd_v1_uid(sd);
 	inode->i_gid   = sd_v1_gid(sd);
 	inode->i_size  = sd_v1_size(sd);
@@ -923,7 +924,8 @@
 	struct stat_data * sd = (struct stat_data *)B_I_PITEM (bh, ih);
 
 	inode->i_mode   = sd_v2_mode(sd);
-	inode->i_nlink  = sd_v2_nlink(sd);
+	inode->i_nlink  = (sd_v2_nlink(sd)>REISERFS_LINK_MAX)?REISERFS_LINK_MAX:sd_v2_nlink(sd);
+	inode->u.reiserfs_i.i_nlink_real = sd_v2_nlink(sd);
 	inode->i_uid    = sd_v2_uid(sd);
 	inode->i_size   = sd_v2_size(sd);
 	inode->i_gid    = sd_v2_gid(sd);
@@ -975,7 +977,7 @@
     __u16 flags;
 
     set_sd_v2_mode(sd_v2, inode->i_mode );
-    set_sd_v2_nlink(sd_v2, inode->i_nlink );
+    set_sd_v2_nlink(sd_v2, inode->u.reiserfs_i.i_nlink_real );
     set_sd_v2_uid(sd_v2, inode->i_uid );
     set_sd_v2_size(sd_v2, inode->i_size );
     set_sd_v2_gid(sd_v2, inode->i_gid );
@@ -1001,7 +1003,7 @@
     set_sd_v1_mode(sd_v1, inode->i_mode );
     set_sd_v1_uid(sd_v1, inode->i_uid );
     set_sd_v1_gid(sd_v1, inode->i_gid );
-    set_sd_v1_nlink(sd_v1, inode->i_nlink );
+    set_sd_v1_nlink(sd_v1, inode->u.reiserfs_i.i_nlink_real );
     set_sd_v1_size(sd_v1, inode->i_size );
     set_sd_v1_atime(sd_v1, inode->i_atime );
     set_sd_v1_ctime(sd_v1, inode->i_ctime );
@@ -1537,7 +1539,7 @@
 
     /* fill stat data */
     inode->i_mode = mode;
-    inode->i_nlink = (S_ISDIR (mode) ? 2 : 1);
+    inode->u.reiserfs_i.i_nlink_real = inode->i_nlink = (S_ISDIR (mode) ? 2 : 1);
     inode->i_uid = current->fsuid;
     if (dir->i_mode & S_ISGID) {
 	inode->i_gid = dir->i_gid;
===== fs/reiserfs/namei.c 1.24 vs edited =====
--- 1.24/fs/reiserfs/namei.c	Fri Aug  9 19:22:33 2002
+++ edited/fs/reiserfs/namei.c	Thu Sep  5 16:33:04 2002
@@ -8,8 +8,16 @@
 #include <linux/reiserfs_fs.h>
 #include <linux/smp_lock.h>
 
-#define INC_DIR_INODE_NLINK(i) if (i->i_nlink != 1) { i->i_nlink++; if (i->i_nlink >= REISERFS_LINK_MAX) i->i_nlink=1; }
-#define DEC_DIR_INODE_NLINK(i) if (i->i_nlink != 1) i->i_nlink--;
+#define INC_INODE_NLINK(i) { if (i->i_nlink < REISERFS_LINK_MAX) i->i_nlink++; i->u.reiserfs_i.i_nlink_real++; }
+#define DEC_INODE_NLINK(i) {if ( --i->u.reiserfs_i.i_nlink_real < REISERFS_LINK_MAX) i->i_nlink--;}
+
+// v3.5 files have 16bit nlink_t, v3.6 files have 32bit nlink_t.
+#define CAN_INCREASE_NLINK(i) ( i->u.reiserfs_i.i_nlink_real < ((get_inode_sd_version (i) != KEY_FORMAT_3_5)?MAX_UL_INT:MAX_US_INT)) 
+
+// Compatibility stuff with old trick that allowed to have lots of subdirs in
+// one dir. Such dirs had 1 as their nlink count.
+#define INC_DIR_INODE_NLINK(i) { if (i->i_nlink != 1) INC_INODE_NLINK(i);}
+#define DEC_DIR_INODE_NLINK(i) { if (i->i_nlink != 1) DEC_INODE_NLINK(i);}
 
 // directory item contains array of entry headers. This performs
 // binary search through that array
@@ -518,7 +526,7 @@
     retval = reiserfs_add_entry (&th, dir, dentry->d_name.name, dentry->d_name.len, 
 				inode, 1/*visible*/);
     if (retval) {
-	inode->i_nlink--;
+	DEC_INODE_NLINK(inode);
 	reiserfs_update_sd (&th, inode);
 	pop_journal_writer(windex) ;
 	// FIXME: should we put iput here and have stat data deleted
@@ -569,7 +577,7 @@
     retval = reiserfs_add_entry (&th, dir, dentry->d_name.name, dentry->d_name.len, 
 				 inode, 1/*visible*/);
     if (retval) {
-	inode->i_nlink--;
+	DEC_INODE_NLINK(inode);
 	reiserfs_update_sd (&th, inode);
 	pop_journal_writer(windex) ;
 	journal_end(&th, dir->i_sb, jbegin_count) ;
@@ -592,6 +600,9 @@
     struct reiserfs_transaction_handle th ;
     int jbegin_count = JOURNAL_PER_BALANCE_CNT * 3; 
 
+    if ( !CAN_INCREASE_NLINK(dir) )
+	return -EMLINK;
+
     if (!(inode = new_inode(dir->i_sb))) {
 	return -ENOMEM ;
     }
@@ -613,7 +624,7 @@
 				dentry, inode, &retval);
     if (!inode) {
 	pop_journal_writer(windex) ;
-	dir->i_nlink-- ;
+	DEC_DIR_INODE_NLINK(dir);
 	journal_end(&th, dir->i_sb, jbegin_count) ;
 	return retval;
     }
@@ -627,7 +638,7 @@
     retval = reiserfs_add_entry (&th, dir, dentry->d_name.name, dentry->d_name.len, 
 				inode, 1/*visible*/);
     if (retval) {
-	inode->i_nlink = 0;
+	inode->u.reiserfs_i.i_nlink_real = inode->i_nlink = 0;
 	DEC_DIR_INODE_NLINK(dir);
 	reiserfs_update_sd (&th, inode);
 	pop_journal_writer(windex) ;
@@ -711,7 +722,7 @@
     if ( inode->i_nlink != 2 && inode->i_nlink != 1 )
 	printk ("reiserfs_rmdir: empty directory has nlink != 2 (%d)\n", inode->i_nlink);
 
-    inode->i_nlink = 0;
+    inode->u.reiserfs_i.i_nlink_real = inode->i_nlink = 0;
     inode->i_ctime = dir->i_ctime = dir->i_mtime = CURRENT_TIME;
     reiserfs_update_sd (&th, inode);
 
@@ -780,14 +791,14 @@
     if (!inode->i_nlink) {
 	printk("reiserfs_unlink: deleting nonexistent file (%s:%lu), %d\n",
 	       kdevname(inode->i_dev), inode->i_ino, inode->i_nlink);
-	inode->i_nlink = 1;
+	inode->u.reiserfs_i.i_nlink_real = inode->i_nlink = 1;
     }
 
     retval = reiserfs_cut_from_item (&th, &path, &(de.de_entry_key), dir, NULL, 0);
     if (retval < 0)
 	goto end_unlink;
 
-    inode->i_nlink--;
+    DEC_INODE_NLINK(inode);
     inode->i_ctime = CURRENT_TIME;
     reiserfs_update_sd (&th, inode);
 
@@ -868,7 +879,7 @@
     retval = reiserfs_add_entry (&th, parent_dir, dentry->d_name.name, dentry->d_name.len, 
 				 inode, 1/*visible*/);
     if (retval) {
-	inode->i_nlink--;
+	DEC_INODE_NLINK(inode);
 	reiserfs_update_sd (&th, inode);
 	pop_journal_writer(windex) ;
 	journal_end(&th, parent_dir->i_sb, jbegin_count) ;
@@ -896,8 +907,7 @@
     if (S_ISDIR(inode->i_mode))
 	return -EPERM;
   
-    if (inode->i_nlink >= REISERFS_LINK_MAX) {
-	//FIXME: sd_nlink is 32 bit for new files
+    if (!CAN_INCREASE_NLINK(inode)) {
 	return -EMLINK;
     }
 
@@ -917,7 +927,7 @@
 	return retval;
     }
 
-    inode->i_nlink++;
+    INC_INODE_NLINK(inode);
     ctime = CURRENT_TIME;
     inode->i_ctime = ctime;
     reiserfs_update_sd (&th, inode);
@@ -1021,6 +1031,8 @@
 	// and that its new parent directory has not too many links
 	// already
 
+	if ( !CAN_INCREASE_NLINK(new_dir) )
+	    return -EMLINK;
 	if (new_dentry_inode) {
 	    if (!reiserfs_empty_dir(new_dentry_inode)) {
 		return -ENOTEMPTY;
@@ -1157,9 +1169,9 @@
     if (new_dentry_inode) {
 	// adjust link number of the victim
 	if (S_ISDIR(new_dentry_inode->i_mode)) {
-	    new_dentry_inode->i_nlink  = 0;
+	    new_dentry_inode->u.reiserfs_i.i_nlink_real = new_dentry_inode->i_nlink  = 0;
 	} else {
-	    new_dentry_inode->i_nlink--;
+	    DEC_INODE_NLINK(new_dentry_inode);
 	}
 	ctime = CURRENT_TIME;
 	new_dentry_inode->i_ctime = ctime;
===== include/linux/reiserfs_fs.h 1.22 vs edited =====
--- 1.22/include/linux/reiserfs_fs.h	Tue Aug 20 13:40:53 2002
+++ edited/include/linux/reiserfs_fs.h	Thu Sep  5 17:52:50 2002
@@ -1163,7 +1163,6 @@
 #define INODE_PKEY(inode) ((struct key *)((inode)->u.reiserfs_i.i_key))
 
 #define MAX_UL_INT 0xffffffff
-#define MAX_INT    0x7ffffff
 #define MAX_US_INT 0xffff
 
 // reiserfs version 2 has max offset 60 bits. Version 1 - 32 bit offset
@@ -1186,8 +1185,9 @@
 #define MAX_FC_NUM MAX_US_INT
 
 
-/* the purpose is to detect overflow of an unsigned short */
-#define REISERFS_LINK_MAX (MAX_US_INT - 1000)
+/* Find maximal number, that nlink_t can hold. GCC is able to calculate this
+   value at compile time, so do not worry about extra CPU overhead. */
+#define REISERFS_LINK_MAX (nlink_t)((((nlink_t) -1) > 0)?~0:((1u<<(sizeof(nlink_t)*8-1))-1))
 
 
 /* The following defines are used in reiserfs_insert_item and reiserfs_append_item  */
===== include/linux/reiserfs_fs_i.h 1.8 vs edited =====
--- 1.8/include/linux/reiserfs_fs_i.h	Fri Aug  9 19:22:34 2002
+++ edited/include/linux/reiserfs_fs_i.h	Thu Sep  5 13:41:01 2002
@@ -53,6 +53,8 @@
     ** flushed */
     unsigned long i_trans_id ;
     unsigned long i_trans_index ;
+    unsigned int i_nlink_real; /* We store real nlink number since field in
+				  struct inode is too short for us */
 };
 
 #endif
