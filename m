Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264077AbRFES6F>; Tue, 5 Jun 2001 14:58:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264078AbRFES54>; Tue, 5 Jun 2001 14:57:56 -0400
Received: from roc-24-169-102-121.rochester.rr.com ([24.169.102.121]:46342
	"EHLO roc-24-169-102-121.rochester.rr.com") by vger.kernel.org
	with ESMTP id <S264077AbRFES5n>; Tue, 5 Jun 2001 14:57:43 -0400
Date: Tue, 05 Jun 2001 14:57:23 -0400
From: Chris Mason <mason@suse.com>
To: linux-kernel@vger.kernel.org, reiserfs-list@namesys.com
cc: alan@redhat.com
Subject: [PATCH] reiserfs leak in errors paths
Message-ID: <1003650000.991767443@tiny>
X-Mailer: Mulberry/2.0.8 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Hi guys,

A few of the reiserfs errors paths for i/o error neglect to release 
buffer heads.  This patch makes sure things get released properly
and if dirty buffers were prepared for the log, also makes sure
the dirty bits are reset (by using unfix_nodes intead of pathrelse).

Vladimir Saveliev helped out with this one, it was against 2.4.4, but
I just retested under 2.4.5.

Alan, please apply.

-chris

diff -urN linux-2.4.4.tmp/fs/reiserfs/fix_node.c linux-2.4.4/fs/reiserfs/fix_node.c
--- linux-2.4.4.tmp/fs/reiserfs/fix_node.c	Sat Apr 14 05:26:07 2001
+++ linux-2.4.4/fs/reiserfs/fix_node.c	Mon May 14 15:31:52 2001
@@ -2719,12 +2719,6 @@
 {
     int	i;
 
-#ifdef CONFIG_REISERFS_CHECK
-    if ( ! tb->vn_buf )
-	reiserfs_panic (tb->tb_sb,
-			"PAP-16050: unfix_nodes: pointer to the virtual node is NULL");
-#endif
-
     /* Release path buffers. */
     pathrelse_and_restore (tb->tb_sb, tb->tb_path);
 
@@ -2781,7 +2775,8 @@
 	    }
 	}
 #endif /* 0 */
-    reiserfs_kfree (tb->vn_buf, tb->vn_buf_size, tb->tb_sb);
+    if (tb->vn_buf) 
+	reiserfs_kfree (tb->vn_buf, tb->vn_buf_size, tb->tb_sb);
 
 } 
 
diff -urN linux-2.4.4.tmp/fs/reiserfs/stree.c linux-2.4.4/fs/reiserfs/stree.c
--- linux-2.4.4.tmp/fs/reiserfs/stree.c	Sat Apr 14 05:26:07 2001
+++ linux-2.4.4/fs/reiserfs/stree.c	Mon May 14 15:31:52 2001
@@ -1724,7 +1724,7 @@
 	    continue;
 
 	reiserfs_warning ("PAP-5610: reiserfs_cut_from_item: item %K not found\n", p_s_item_key);
-	pathrelse (p_s_path);
+	unfix_nodes (&s_cut_balance);
 	return (n_ret_value == IO_ERROR) ? -EIO : -ENOENT;
     } /* while */
   
@@ -1994,12 +1994,14 @@
     while ( (retval = fix_nodes(M_PASTE, &s_paste_balance, NULL, p_c_body)) == REPEAT_SEARCH ) {
 	/* file system changed while we were in the fix_nodes */
 	retval = search_for_position_by_key (th->t_super, p_s_key, p_s_search_path);
-	if (retval == IO_ERROR)
-	    return -EIO;
+	if (retval == IO_ERROR) {
+	    retval = -EIO ;
+	    goto error_out ;
+	}
 	if (retval == POSITION_FOUND) {
 	    reiserfs_warning ("PAP-5710: reiserfs_paste_into_item: entry or pasted byte (%K) exists", p_s_key);
-	    pathrelse (p_s_search_path);
-	    return -EEXIST;
+	    retval = -EEXIST ;
+	    goto error_out ;
 	}
 	
 #ifdef CONFIG_REISERFS_CHECK
@@ -2013,9 +2015,11 @@
 	do_balance(&s_paste_balance, NULL/*ih*/, p_c_body, M_PASTE);
 	return 0;
     }
-
+    retval = (retval == NO_DISK_SPACE) ? -ENOSPC : -EIO;
+error_out:
+    /* this also releases the path */
     unfix_nodes(&s_paste_balance);
-    return (retval == NO_DISK_SPACE) ? -ENOSPC : -EIO;
+    return retval ;
 }
 
 
@@ -2040,14 +2044,15 @@
     while ( (retval = fix_nodes(M_INSERT, &s_ins_balance, p_s_ih, p_c_body)) == REPEAT_SEARCH) {
 	/* file system changed while we were in the fix_nodes */
 	retval = search_item (th->t_super, key, p_s_path);
-	if (retval == IO_ERROR)
-	    return -EIO;
-
+	if (retval == IO_ERROR) {
+	    retval = -EIO;
+	    goto error_out ;
+	}
 	if (retval == ITEM_FOUND) {
 	    reiserfs_warning ("PAP-5760: reiserfs_insert_item: "
 			      "key %K already exists in the tree\n", key);
-	    pathrelse (p_s_path);
-	    return -EEXIST;
+	    retval = -EEXIST ;
+	    goto error_out; 
 	}
     }
 
@@ -2057,8 +2062,11 @@
 	return 0;
     }
 
+    retval = (retval == NO_DISK_SPACE) ? -ENOSPC : -EIO;
+error_out:
+    /* also releases the path */
     unfix_nodes(&s_ins_balance);
-    return (retval == NO_DISK_SPACE) ? -ENOSPC : -EIO;
+    return retval; 
 }
 
 


