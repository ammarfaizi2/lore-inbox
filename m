Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270855AbTG0QSq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jul 2003 12:18:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270856AbTG0QSq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jul 2003 12:18:46 -0400
Received: from mail.parknet.co.jp ([210.171.160.6]:50189 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S270855AbTG0QSR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jul 2003 12:18:17 -0400
To: Ren <l.s.r@web.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Consolidate dot-stripping code
References: <20030727171002.3f8eaed5.l.s.r@web.de>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Mon, 28 Jul 2003 01:33:23 +0900
In-Reply-To: <20030727171002.3f8eaed5.l.s.r@web.de>
Message-ID: <871xwcvsj0.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ren <l.s.r@web.de> writes:

> Hi,
> 
> there are several places inside fs/vfat/namei.c where the length of a
> struct qstr without any trailing dots is calculated. The patch below
> adds a function vfat_qstrlen() which does that and makes use of it.
> 
> This cuts down on code size. Binary size is unchanged, because
> vfat_qstrlen() is inline'd. It could be un-inline'd later.

Thanks. Looks good to me. But vfat_qstrlen is bit bogus name. I
renamed it to vfat_striptail_len, and it un-inlined.

What do you think of this?
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

diff -puN fs/vfat/namei.c~vfat_striptail fs/vfat/namei.c
--- linux-2.6.0-test1/fs/vfat/namei.c~vfat_striptail	2003-07-28 01:18:18.000000000 +0900
+++ linux-2.6.0-test1-hirofumi/fs/vfat/namei.c	2003-07-28 01:27:17.000000000 +0900
@@ -114,6 +114,17 @@ vfat_strnicmp(struct nls_table *t, const
 	return 0;
 }
 
+/* returns the length of a struct qstr, ignoring trailing dots */
+static unsigned int vfat_striptail_len(struct qstr *qstr)
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
@@ -122,15 +133,7 @@ vfat_strnicmp(struct nls_table *t, const
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
+	qstr->hash = full_name_hash(qstr->name, vfat_striptail_len(qstr));
 
 	return 0;
 }
@@ -145,13 +148,11 @@ static int vfat_hashi(struct dentry *den
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
+	len = vfat_striptail_len(qstr);
 
 	hash = init_name_hash();
 	while (len--)
@@ -167,15 +168,11 @@ static int vfat_hashi(struct dentry *den
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
+	alen = vfat_striptail_len(a);
+	blen = vfat_striptail_len(b);
 	if (alen == blen) {
 		if (vfat_strnicmp(t, a->name, b->name, alen) == 0)
 			return 0;
@@ -188,15 +185,11 @@ static int vfat_cmpi(struct dentry *dent
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
+	alen = vfat_striptail_len(a);
+	blen = vfat_striptail_len(b);
 	if (alen == blen) {
 		if (strncmp(a->name, b->name, alen) == 0)
 			return 0;
@@ -761,7 +754,7 @@ static int vfat_add_entry(struct inode *
 	struct msdos_dir_slot *dir_slots;
 	loff_t offset;
 	int slots, slot;
-	int res, len;
+	int res;
 	struct msdos_dir_entry *dummy_de;
 	struct buffer_head *dummy_bh;
 	loff_t dummy_i_pos;
@@ -771,10 +764,7 @@ static int vfat_add_entry(struct inode *
 	if (dir_slots == NULL)
 		return -ENOMEM;
 
-	len = qname->len;
-	while (len && qname->name[len-1] == '.')
-		len--;
-	res = vfat_build_slots(dir, qname->name, len,
+	res = vfat_build_slots(dir, qname->name, vfat_striptail_len(qname),
 			       dir_slots, &slots, is_dir);
 	if (res < 0)
 		goto cleanup;
@@ -825,12 +815,9 @@ static int vfat_find(struct inode *dir,s
 {
 	struct super_block *sb = dir->i_sb;
 	loff_t offset;
-	int res,len;
+	int res;
 
-	len = qname->len;
-	while (len && qname->name[len-1] == '.') 
-		len--;
-	res = fat_search_long(dir, qname->name, len,
+	res = fat_search_long(dir, qname->name, vfat_striptail_len(qname),
 			(MSDOS_SB(sb)->options.name_check != 's'),
 			&offset,&sinfo->longname_offset);
 	if (res>0) {

_
