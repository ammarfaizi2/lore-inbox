Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289803AbSBKOcr>; Mon, 11 Feb 2002 09:32:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289802AbSBKOax>; Mon, 11 Feb 2002 09:30:53 -0500
Received: from angband.namesys.com ([212.16.7.85]:18304 "HELO
	angband.namesys.com") by vger.kernel.org with SMTP
	id <S289766AbSBKOZA>; Mon, 11 Feb 2002 09:25:00 -0500
Date: Mon, 11 Feb 2002 17:24:59 +0300
From: Oleg Drokin on behalf of Hans Reiser <reiser@namesys.com>
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org,
        reiserfs-dev@namesys.com
Subject: [PATCH] 2.5 [4 of 8] 04-hash_autodetect_fix.diff
Message-ID: <20020211172459.D1768@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

   Correctly detect and print hash values, when manual hash detection is used.


--- linux/include/linux/reiserfs_fs.h.orig	Mon Feb 11 09:28:48 2002
+++ linux/include/linux/reiserfs_fs.h	Mon Feb 11 10:02:41 2002
@@ -1960,6 +1960,7 @@
 void check_leaf (struct buffer_head * bh);
 void check_internal (struct buffer_head * bh);
 void print_statistics (struct super_block * s);
+char * reiserfs_hashname(int code);
 
 /* lbalance.c */
 int leaf_move_items (int shift_mode, struct tree_balance * tb, int mov_num, int mov_bytes, struct buffer_head * Snew);
--- linux/fs/reiserfs/super.c.orig	Mon Feb 11 09:58:31 2002
+++ linux/fs/reiserfs/super.c	Mon Feb 11 10:08:08 2002
@@ -850,7 +850,9 @@
 
     inode = s->s_root->d_inode;
 
-    while (1) {
+    do { // Some serious "goto"-hater was there ;)
+	u32 teahash, r5hash, yurahash;
+
 	make_cpu_key (&key, inode, ~0, TYPE_DIRENTRY, 3);
 	retval = search_by_entry_key (s, &key, &path, &de);
 	if (retval == IO_ERROR) {
@@ -869,20 +871,30 @@
 	                     "is using the default hash\n");
 	    break;
 	}
-	if (GET_HASH_VALUE(yura_hash (de.de_name, de.de_namelen)) == 
-	    GET_HASH_VALUE(keyed_hash (de.de_name, de.de_namelen))) {
-	    reiserfs_warning ("reiserfs: Could not detect hash function "
-			      "please mount with -o hash={tea,rupasov,r5}\n") ;
-	    hash = UNSET_HASH ;
+	r5hash=GET_HASH_VALUE (r5_hash (de.de_name, de.de_namelen));
+	teahash=GET_HASH_VALUE (keyed_hash (de.de_name, de.de_namelen));
+	yurahash=GET_HASH_VALUE (yura_hash (de.de_name, de.de_namelen));
+	if ( ( (teahash == r5hash) && (GET_HASH_VALUE( deh_offset(&(de.de_deh[de.de_entry_num]))) == r5hash) ) ||
+	     ( (teahash == yurahash) && (yurahash == GET_HASH_VALUE( deh_offset(&(de.de_deh[de.de_entry_num])))) ) ||
+	     ( (r5hash == yurahash) && (yurahash == GET_HASH_VALUE( deh_offset(&(de.de_deh[de.de_entry_num])))) ) ) {
+	    reiserfs_warning("reiserfs: Unable to automatically detect hash"
+		"function for device %s\n"
+		"please mount with -o hash={tea,rupasov,r5}\n", kdevname (s->s_dev));
+	    hash = UNSET_HASH;
 	    break;
 	}
-	if (GET_HASH_VALUE( deh_offset(&(de.de_deh[de.de_entry_num])) ) ==
-	    GET_HASH_VALUE (yura_hash (de.de_name, de.de_namelen)))
+	if (GET_HASH_VALUE( deh_offset(&(de.de_deh[de.de_entry_num])) ) == yurahash)
 	    hash = YURA_HASH;
-	else
+	else if (GET_HASH_VALUE( deh_offset(&(de.de_deh[de.de_entry_num])) ) == teahash)
 	    hash = TEA_HASH;
-	break;
-    }
+	else if (GET_HASH_VALUE( deh_offset(&(de.de_deh[de.de_entry_num])) ) == r5hash)
+	    hash = R5_HASH;
+	else {
+	    reiserfs_warning("reiserfs: Unrecognised hash function for "
+			     "device %s\n", kdevname (s->s_dev));
+	    hash = UNSET_HASH;
+	}
+    } while (0);
 
     pathrelse (&path);
     return hash;
@@ -907,16 +919,16 @@
 	** mount options 
 	*/
 	if (reiserfs_rupasov_hash(s) && code != YURA_HASH) {
-	    printk("REISERFS: Error, tea hash detected, "
-		   "unable to force rupasov hash\n") ;
+	    printk("REISERFS: Error, %s hash detected, "
+		   "unable to force rupasov hash\n", reiserfs_hashname(code)) ;
 	    code = UNSET_HASH ;
 	} else if (reiserfs_tea_hash(s) && code != TEA_HASH) {
-	    printk("REISERFS: Error, rupasov hash detected, "
-		   "unable to force tea hash\n") ;
+	    printk("REISERFS: Error, %s hash detected, "
+		   "unable to force tea hash\n", reiserfs_hashname(code)) ;
 	    code = UNSET_HASH ;
 	} else if (reiserfs_r5_hash(s) && code != R5_HASH) {
-	    printk("REISERFS: Error, r5 hash detected, "
-		   "unable to force r5 hash\n") ;
+	    printk("REISERFS: Error, %s hash detected, "
+		   "unable to force r5 hash\n", reiserfs_hashname(code)) ;
 	    code = UNSET_HASH ;
 	} 
     } else { 
--- linux/fs/reiserfs/prints.c.orig	Mon Feb 11 09:28:48 2002
+++ linux/fs/reiserfs/prints.c	Mon Feb 11 10:09:33 2002
@@ -477,6 +477,17 @@
     return 0;
 }
 
+char * reiserfs_hashname(int code)
+{
+    if ( code == YURA_HASH)
+	return "rupasov";
+    if ( code == TEA_HASH)
+	return "tea";
+    if ( code == R5_HASH)
+	return "r5";
+
+    return "unknown";
+}
 /* return 1 if this is not super block */
 static int print_super_block (struct buffer_head * bh)
 {
@@ -519,8 +530,7 @@
     printk ("Journal orig size %d\n", sb_jp_journal_size(rs));
     printk ("FS state %d\n", sb_fs_state(rs));
     printk ("Hash function \"%s\"\n",
-            sb_hash_function_code(rs) == TEA_HASH ? "tea" :
-	    ( sb_hash_function_code(rs) == YURA_HASH ? "rupasov" : (sb_hash_function_code(rs) == R5_HASH ? "r5" : "unknown")));
+	    reiserfs_hashname(sb_hash_function_code(rs)));
     
     printk ("Tree height %d\n", sb_tree_height(rs));
     return 0;
