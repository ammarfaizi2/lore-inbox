Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262840AbTI1Xii (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Sep 2003 19:38:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262743AbTI1XdB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Sep 2003 19:33:01 -0400
Received: from hera.cwi.nl ([192.16.191.8]:19951 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S262796AbTI1Xal (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Sep 2003 19:30:41 -0400
From: Andries.Brouwer@cwi.nl
Date: Mon, 29 Sep 2003 01:30:37 +0200 (MEST)
Message-Id: <UTC200309282330.h8SNUbA03817.aeb@smtp.cwi.nl>
To: torvalds@osdl.org
Subject: [PATCH] hfs sparse fixes
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --recursive --new-file -X /linux/dontdiff a/fs/hfs/file.c b/fs/hfs/file.c
--- a/fs/hfs/file.c	Mon Sep 29 01:05:41 2003
+++ b/fs/hfs/file.c	Mon Sep 29 01:12:49 2003
@@ -25,10 +25,10 @@
 
 /*================ Forward declarations ================*/
 
-static hfs_rwret_t hfs_file_read(struct file *, char *, hfs_rwarg_t,
+static hfs_rwret_t hfs_file_read(struct file *, char __user *, hfs_rwarg_t,
 				 loff_t *);
-static hfs_rwret_t hfs_file_write(struct file *, const char *, hfs_rwarg_t,
-				  loff_t *);
+static hfs_rwret_t hfs_file_write(struct file *, const char __user *,
+				  hfs_rwarg_t, loff_t *);
 static void hfs_file_truncate(struct inode *);
 
 /*================ Global variables ================*/
@@ -139,7 +139,7 @@
  * user-space at the address 'buf'.  Returns the number of bytes
  * successfully transferred.  This function checks the arguments, does
  * some setup and then calls hfs_do_read() to do the actual transfer.  */
-static hfs_rwret_t hfs_file_read(struct file * filp, char * buf, 
+static hfs_rwret_t hfs_file_read(struct file *filp, char __user *buf, 
 				 hfs_rwarg_t count, loff_t *ppos)
 {
         struct inode *inode = filp->f_dentry->d_inode;
@@ -181,7 +181,7 @@
  * 'file->f_pos' from user-space at the address 'buf'.  The return
  * value is the number of bytes actually transferred.
  */
-static hfs_rwret_t hfs_file_write(struct file * filp, const char * buf,
+static hfs_rwret_t hfs_file_write(struct file *filp, const char __user *buf,
 				  hfs_rwarg_t count, loff_t *ppos)
 {
         struct inode    *inode = filp->f_dentry->d_inode;
@@ -242,7 +242,7 @@
  *
  * Like copy_to_user() while translating CR->NL.
  */
-static inline void xlate_to_user(char *buf, const char *data, int count)
+static inline void xlate_to_user(char __user *buf, const char *data, int count)
 {
 	char ch;
 
@@ -257,7 +257,8 @@
  *
  * Like copy_from_user() while translating NL->CR;
  */
-static inline int xlate_from_user(char *data, const char *buf, int count)
+static inline
+int xlate_from_user(char *data, const char __user *buf, int count)
 {
 	int i;
 
@@ -290,8 +291,8 @@
  * This is based on Linus's minix_file_read().
  * It has been changed to take into account that HFS files have no holes.
  */
-hfs_s32 hfs_do_read(struct inode *inode, struct hfs_fork * fork, hfs_u32 pos,
-		    char * buf, hfs_u32 count)
+hfs_s32 hfs_do_read(struct inode *inode, struct hfs_fork *fork, hfs_u32 pos,
+		    char __user *buf, hfs_u32 count)
 {
 	hfs_s32 size, chars, offset, block, blocks, read = 0;
 	int bhrequest, uptodate;
@@ -436,8 +437,8 @@
  * 
  * This is just a minor edit of Linus's minix_file_write().
  */
-hfs_s32 hfs_do_write(struct inode *inode, struct hfs_fork * fork, hfs_u32 pos,
-		     const char * buf, hfs_u32 count)
+hfs_s32 hfs_do_write(struct inode *inode, struct hfs_fork *fork, hfs_u32 pos,
+		     const char __user *buf, hfs_u32 count)
 {
 	hfs_s32 written, c;
 	struct buffer_head * bh;
diff -u --recursive --new-file -X /linux/dontdiff a/fs/hfs/file_cap.c b/fs/hfs/file_cap.c
--- a/fs/hfs/file_cap.c	Mon Sep 29 01:05:41 2003
+++ b/fs/hfs/file_cap.c	Mon Sep 29 01:12:49 2003
@@ -29,9 +29,9 @@
 /*================ Forward declarations ================*/
 static loff_t      cap_info_llseek(struct file *, loff_t,
                                    int);
-static hfs_rwret_t cap_info_read(struct file *, char *,
+static hfs_rwret_t cap_info_read(struct file *, char __user *,
 				 hfs_rwarg_t, loff_t *);
-static hfs_rwret_t cap_info_write(struct file *, const char *,
+static hfs_rwret_t cap_info_write(struct file *, const char __user *,
 				  hfs_rwarg_t, loff_t *);
 /*================ Function-like macros ================*/
 
@@ -121,7 +121,7 @@
  * 'file->f_pos' to user-space at the address 'buf'.  The return value
  * is the number of bytes actually transferred.
  */
-static hfs_rwret_t cap_info_read(struct file *filp, char *buf,
+static hfs_rwret_t cap_info_read(struct file *filp, char __user *buf,
 				 hfs_rwarg_t count, loff_t *ppos)
 {
 	struct inode *inode = filp->f_dentry->d_inode;
@@ -189,7 +189,7 @@
  * '*ppos' from user-space at the address 'buf'.
  * The return value is the number of bytes actually transferred.
  */
-static hfs_rwret_t cap_info_write(struct file *filp, const char *buf, 
+static hfs_rwret_t cap_info_write(struct file *filp, const char __user *buf, 
 				  hfs_rwarg_t count, loff_t *ppos)
 {
         struct inode *inode = filp->f_dentry->d_inode;
diff -u --recursive --new-file -X /linux/dontdiff a/fs/hfs/file_hdr.c b/fs/hfs/file_hdr.c
--- a/fs/hfs/file_hdr.c	Mon Sep 29 01:05:41 2003
+++ b/fs/hfs/file_hdr.c	Mon Sep 29 01:12:49 2003
@@ -41,8 +41,9 @@
 
 /*================ Forward declarations ================*/
 static loff_t      hdr_llseek(struct file *, loff_t, int);
-static hfs_rwret_t hdr_read(struct file *, char *, hfs_rwarg_t, loff_t *);
-static hfs_rwret_t hdr_write(struct file *, const char *,
+static hfs_rwret_t hdr_read(struct file *, char __user *,
+			    hfs_rwarg_t, loff_t *);
+static hfs_rwret_t hdr_write(struct file *, const char __user *,
 			     hfs_rwarg_t, loff_t *);
 /*================ Global variables ================*/
 
@@ -382,7 +383,7 @@
  * successfully transferred.
  */
 /* XXX: what about the entry count changing on us? */
-static hfs_rwret_t hdr_read(struct file * filp, char * buf, 
+static hfs_rwret_t hdr_read(struct file *filp, char __user *buf, 
 			    hfs_rwarg_t count, loff_t *ppos)
 {
 	struct inode *inode = filp->f_dentry->d_inode;
@@ -633,7 +634,7 @@
  * '*ppos' from user-space at the address 'buf'.
  * The return value is the number of bytes actually transferred.
  */
-static hfs_rwret_t hdr_write(struct file *filp, const char *buf,
+static hfs_rwret_t hdr_write(struct file *filp, const char __user *buf,
 			     hfs_rwarg_t count, loff_t *ppos)
 {
 	struct inode *inode = filp->f_dentry->d_inode;
diff -u --recursive --new-file -X /linux/dontdiff a/include/linux/hfs_fs.h b/include/linux/hfs_fs.h
--- a/include/linux/hfs_fs.h	Mon Sep 29 01:05:41 2003
+++ b/include/linux/hfs_fs.h	Mon Sep 29 01:12:49 2003
@@ -267,9 +267,9 @@
 
 /* file.c */
 extern hfs_s32 hfs_do_read(struct inode *, struct hfs_fork *, hfs_u32,
-			   char *, hfs_u32);
+			   char __user *, hfs_u32);
 extern hfs_s32 hfs_do_write(struct inode *, struct hfs_fork *, hfs_u32,
-			    const char *, hfs_u32);
+			    const char __user *, hfs_u32);
 extern void hfs_file_fix_mode(struct hfs_cat_entry *entry);
 extern struct inode_operations hfs_file_inode_operations;
 extern struct file_operations hfs_file_operations;
