Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286395AbSAINWg>; Wed, 9 Jan 2002 08:22:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286386AbSAINW1>; Wed, 9 Jan 2002 08:22:27 -0500
Received: from thebsh.namesys.com ([212.16.0.238]:61713 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S286375AbSAINWL>; Wed, 9 Jan 2002 08:22:11 -0500
Date: Wed, 9 Jan 2002 16:22:07 +0300
From: Oleg Drokin <green@namesys.com>
To: marcelo@conectiva.com.br, linux-kernel@vger.kernel.org,
        reiserfs-dev@namesys.com
Subject: [PATCH] certain data corruption may cause reiserfs to panic, fix.
Message-ID: <20020109162207.A15139@namesys.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="HlL+5n6rz5pIUxbD"
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--HlL+5n6rz5pIUxbD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello!

    Purpose of this patch is to catch events of corrupted ITEM_TYPE fields, and report these to user.
    Without this patch, accessing such items will resukt in dereferencing random memory areas in kernel,
    and then ooping (most probably).
    Please apply.

Bye,
    Oleg

--HlL+5n6rz5pIUxbD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="corrupt_items_checks.diff"

--- linux/include/linux/reiserfs_fs.h.orig	Fri Dec 21 17:20:56 2001
+++ linux/include/linux/reiserfs_fs.h	Mon Dec 24 14:07:09 2001
@@ -204,7 +204,15 @@
 #define REISERFS_VALID_FS    1
 #define REISERFS_ERROR_FS    2
 
-
+//
+// there are 5 item types currently
+//
+#define TYPE_STAT_DATA 0
+#define TYPE_INDIRECT 1
+#define TYPE_DIRECT 2
+#define TYPE_DIRENTRY 3 
+#define TYPE_MAXTYPE 3 
+#define TYPE_ANY 15 // FIXME: comment is required
 
 /***************************************************************************/
 /*                       KEY & ITEM HEAD                                   */
@@ -240,7 +248,7 @@
 {
     offset_v2_esafe_overlay tmp = *(offset_v2_esafe_overlay *)v2;
     tmp.linear = le64_to_cpu( tmp.linear );
-    return tmp.offset_v2.k_type;
+    return (tmp.offset_v2.k_type <= TYPE_MAXTYPE)?tmp.offset_v2.k_type:TYPE_ANY;
 }
  
 static inline void set_offset_v2_k_type( struct offset_v2 *v2, int type )
@@ -390,15 +398,6 @@
 #define put_block_num(p, i, v) put_unaligned(cpu_to_le32(v), (p) + (i))
 
 //
-// there are 5 item types currently
-//
-#define TYPE_STAT_DATA 0
-#define TYPE_INDIRECT 1
-#define TYPE_DIRECT 2
-#define TYPE_DIRENTRY 3 
-#define TYPE_ANY 15 // FIXME: comment is required
-
-//
 // in old version uniqueness field shows key type
 //
 #define V1_SD_UNIQUENESS 0
@@ -1365,7 +1364,7 @@
 
 extern struct item_operations stat_data_ops, indirect_ops, direct_ops, 
   direntry_ops;
-extern struct item_operations * item_ops [4];
+extern struct item_operations * item_ops [TYPE_ANY + 1];
 
 #define op_bytes_number(ih,bsize)                    item_ops[le_ih_k_type (ih)]->bytes_number (ih, bsize)
 #define op_is_left_mergeable(key,bsize)              item_ops[le_key_k_type (le_key_version (key), key)]->is_left_mergeable (key, bsize)
--- linux/fs/reiserfs/stree.c.orig	Mon Dec 24 14:14:56 2001
+++ linux/fs/reiserfs/stree.c	Mon Dec 24 14:19:50 2001
@@ -524,6 +524,10 @@
     ih = (struct item_head *)(buf + BLKH_SIZE);
     prev_location = blocksize;
     for (i = 0; i < nr; i ++, ih ++) {
+	if ( le_ih_k_type(ih) == TYPE_ANY) {
+	    reiserfs_warning ("is_leaf: wrong item type for item %h\n",ih);
+	    return 0;
+	}
 	if (ih_location (ih) >= blocksize || ih_location (ih) < IH_SIZE * nr) {
 	    reiserfs_warning ("is_leaf: item location seems wrong: %h\n", ih);
 	    return 0;
--- linux/fs/reiserfs/item_ops.c.orig	Mon Dec 24 13:38:15 2001
+++ linux/fs/reiserfs/item_ops.c	Mon Dec 24 14:07:50 2001
@@ -685,17 +685,110 @@
 
 
 //////////////////////////////////////////////////////////////////////////////
+// Error catching functions to catch errors caused by incorrect item types.
+//
+static int errcatch_bytes_number (struct item_head * ih, int block_size)
+{
+    reiserfs_warning ("green-16001: Invalid item type observed, run fsck ASAP\n");
+    return 0;
+}
+
+static void errcatch_decrement_key (struct cpu_key * key)
+{
+    reiserfs_warning ("green-16002: Invalid item type observed, run fsck ASAP\n");
+}
+
+
+static int errcatch_is_left_mergeable (struct key * key, unsigned long bsize)
+{
+    reiserfs_warning ("green-16003: Invalid item type observed, run fsck ASAP\n");
+    return 0;
+}
+
+
+static void errcatch_print_item (struct item_head * ih, char * item)
+{
+    reiserfs_warning ("green-16004: Invalid item type observed, run fsck ASAP\n");
+}
+
+
+static void errcatch_check_item (struct item_head * ih, char * item)
+{
+    reiserfs_warning ("green-16005: Invalid item type observed, run fsck ASAP\n");
+}
+
+static int errcatch_create_vi (struct virtual_node * vn,
+			       struct virtual_item * vi, 
+			       int is_affected, 
+			       int insert_size)
+{
+    reiserfs_warning ("green-16006: Invalid item type observed, run fsck ASAP\n");
+    return 0;	// We might return -1 here as well, but it won't help as create_virtual_node() from where
+		// this operation is called from is of return type void.
+}
+
+static int errcatch_check_left (struct virtual_item * vi, int free,
+				int start_skip, int end_skip)
+{
+    reiserfs_warning ("green-16007: Invalid item type observed, run fsck ASAP\n");
+    return -1;
+}
+
+
+static int errcatch_check_right (struct virtual_item * vi, int free)
+{
+    reiserfs_warning ("green-16008: Invalid item type observed, run fsck ASAP\n");
+    return -1;
+}
+
+static int errcatch_part_size (struct virtual_item * vi, int first, int count)
+{
+    reiserfs_warning ("green-16009: Invalid item type observed, run fsck ASAP\n");
+    return 0;
+}
+
+static int errcatch_unit_num (struct virtual_item * vi)
+{
+    reiserfs_warning ("green-16010: Invalid item type observed, run fsck ASAP\n");
+    return 0;
+}
+
+static void errcatch_print_vi (struct virtual_item * vi)
+{
+    reiserfs_warning ("green-16011: Invalid item type observed, run fsck ASAP\n");
+}
+
+struct item_operations errcatch_ops = {
+    errcatch_bytes_number,
+    errcatch_decrement_key,
+    errcatch_is_left_mergeable,
+    errcatch_print_item,
+    errcatch_check_item,
+
+    errcatch_create_vi,
+    errcatch_check_left,
+    errcatch_check_right,
+    errcatch_part_size,
+    errcatch_unit_num,
+    errcatch_print_vi
+};
+
+
+
+//////////////////////////////////////////////////////////////////////////////
 //
 //
 #if ! (TYPE_STAT_DATA == 0 && TYPE_INDIRECT == 1 && TYPE_DIRECT == 2 && TYPE_DIRENTRY == 3)
   do not compile
 #endif
 
-struct item_operations * item_ops [4] = {
+struct item_operations * item_ops [TYPE_ANY + 1] = {
   &stat_data_ops,
   &indirect_ops,
   &direct_ops,
-  &direntry_ops
+  &direntry_ops,
+  NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
+  &errcatch_ops		/* This is to catch errors with invalid type (15th entry for TYPE_ANY) */
 };
 
 

--HlL+5n6rz5pIUxbD--
