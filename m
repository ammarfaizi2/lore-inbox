Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270813AbTG0PFG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jul 2003 11:05:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270815AbTG0PFG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jul 2003 11:05:06 -0400
Received: from smtp02.web.de ([217.72.192.151]:61976 "EHLO smtp.web.de")
	by vger.kernel.org with ESMTP id S270813AbTG0PEz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jul 2003 11:04:55 -0400
Date: Sun, 27 Jul 2003 17:10:02 +0200
From: =?ISO-8859-1?B?UmVu?= <l.s.r@web.de>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Consolidate dot-stripping code
Message-Id: <20030727171002.3f8eaed5.l.s.r@web.de>
X-Mailer: Sylpheed version 0.7.4 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

there are several places inside fs/vfat/namei.c where the length of a
struct qstr without any trailing dots is calculated. The patch below
adds a function vfat_qstrlen() which does that and makes use of it.

This cuts down on code size. Binary size is unchanged, because
vfat_qstrlen() is inline'd. It could be un-inline'd later.

Please consider applying this cleanup.

René



diff -u ./fs/vfat/namei.c~ ./fs/vfat/namei.c
--- linux-2.6.0-test1-bk3/fs/vfat/namei.c~	2003-07-27 16:41:36.000000000 +0200
+++ linux-2.6.0-test1-bk3/fs/vfat/namei.c	2003-07-27 16:47:54.000000000 +0200
@@ -114,6 +114,17 @@
 	return 0;
 }
 
+/* returns the length of a struct qstr, ignoring trailing dots */
+static inline unsigned int vfat_qstrlen(struct qstr *qstr)
+{
+	unsigned int len = qstr->len;
+	
+	while (len && qstr->name[len-1] == '.')
+		len--;
+	
+	return len;
+}
+
 /*
  * Compute the hash for the vfat name corresponding to the dentry.
  * Note: if the name is invalid, we leave the hash code unchanged so
@@ -122,15 +133,7 @@
  */
 static int vfat_hash(struct dentry *dentry, struct qstr *qstr)
 {
-	const unsigned char *name;
-	int len;
-
-	len = qstr->len;
-	name = qstr->name;
-	while (len && name[len-1] == '.')
-		len--;
-
-	qstr->hash = full_name_hash(name, len);
+	qstr->hash = full_name_hash(qstr->name, vfat_qstrlen(qstr));
 
 	return 0;
 }
@@ -145,13 +148,11 @@
 {
 	struct nls_table *t = MSDOS_SB(dentry->d_inode->i_sb)->nls_io;
 	const unsigned char *name;
-	int len;
+	unsigned int len;
 	unsigned long hash;
 
-	len = qstr->len;
 	name = qstr->name;
-	while (len && name[len-1] == '.')
-		len--;
+	len = vfat_qstrlen(qstr);
 
 	hash = init_name_hash();
 	while (len--)
@@ -167,15 +168,11 @@
 static int vfat_cmpi(struct dentry *dentry, struct qstr *a, struct qstr *b)
 {
 	struct nls_table *t = MSDOS_SB(dentry->d_inode->i_sb)->nls_io;
-	int alen, blen;
+	unsigned int alen, blen;
 
 	/* A filename cannot end in '.' or we treat it like it has none */
-	alen = a->len;
-	blen = b->len;
-	while (alen && a->name[alen-1] == '.')
-		alen--;
-	while (blen && b->name[blen-1] == '.')
-		blen--;
+	alen = vfat_qstrlen(a);
+	blen = vfat_qstrlen(b);
 	if (alen == blen) {
 		if (vfat_strnicmp(t, a->name, b->name, alen) == 0)
 			return 0;
@@ -188,15 +185,11 @@
  */
 static int vfat_cmp(struct dentry *dentry, struct qstr *a, struct qstr *b)
 {
-	int alen, blen;
+	unsigned int alen, blen;
 
 	/* A filename cannot end in '.' or we treat it like it has none */
-	alen = a->len;
-	blen = b->len;
-	while (alen && a->name[alen-1] == '.')
-		alen--;
-	while (blen && b->name[blen-1] == '.')
-		blen--;
+	alen = vfat_qstrlen(a);
+	blen = vfat_qstrlen(b);
 	if (alen == blen) {
 		if (strncmp(a->name, b->name, alen) == 0)
 			return 0;
@@ -761,7 +754,7 @@
 	struct msdos_dir_slot *dir_slots;
 	loff_t offset;
 	int slots, slot;
-	int res, len;
+	int res;
 	struct msdos_dir_entry *dummy_de;
 	struct buffer_head *dummy_bh;
 	loff_t dummy_i_pos;
@@ -771,10 +764,7 @@
 	if (dir_slots == NULL)
 		return -ENOMEM;
 
-	len = qname->len;
-	while (len && qname->name[len-1] == '.')
-		len--;
-	res = vfat_build_slots(dir, qname->name, len,
+	res = vfat_build_slots(dir, qname->name, vfat_qstrlen(qname),
 			       dir_slots, &slots, is_dir);
 	if (res < 0)
 		goto cleanup;
@@ -825,12 +815,9 @@
 {
 	struct super_block *sb = dir->i_sb;
 	loff_t offset;
-	int res,len;
+	int res;
 
-	len = qname->len;
-	while (len && qname->name[len-1] == '.') 
-		len--;
-	res = fat_search_long(dir, qname->name, len,
+	res = fat_search_long(dir, qname->name, vfat_qstrlen(qname),
 			(MSDOS_SB(sb)->options.name_check != 's'),
 			&offset,&sinfo->longname_offset);
 	if (res>0) {
