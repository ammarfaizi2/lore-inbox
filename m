Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261209AbVCETbp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261209AbVCETbp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Mar 2005 14:31:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261175AbVCETao
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 14:30:44 -0500
Received: from mail.parknet.co.jp ([210.171.160.6]:27397 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S261207AbVCETLa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 14:11:30 -0500
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 23/29] FAT: Remove the multiple MSDOS_SB() call
References: <87ll92rl6a.fsf@devron.myhome.or.jp>
	<87d5uerl2j.fsf_-_@devron.myhome.or.jp>
	<878y52rl17.fsf_-_@devron.myhome.or.jp>
	<87zmxiq6ef.fsf_-_@devron.myhome.or.jp>
	<87vf86q6d2.fsf_-_@devron.myhome.or.jp>
	<87r7iuq6af.fsf_-_@devron.myhome.or.jp>
	<87mztiq69f.fsf_-_@devron.myhome.or.jp>
	<87is46q68d.fsf_-_@devron.myhome.or.jp>
	<87ekeuq672.fsf_-_@devron.myhome.or.jp>
	<87acpiq665.fsf_-_@devron.myhome.or.jp>
	<876506q653.fsf_-_@devron.myhome.or.jp>
	<871xauq63z.fsf_-_@devron.myhome.or.jp>
	<87wtsmorii.fsf_-_@devron.myhome.or.jp>
	<87sm3aorho.fsf_-_@devron.myhome.or.jp>
	<87oedyorgu.fsf_-_@devron.myhome.or.jp>
	<87k6olq60a.fsf_-_@devron.myhome.or.jp>
	<87fyz9q5z7.fsf_-_@devron.myhome.or.jp>
	<87br9xq5y8.fsf_-_@devron.myhome.or.jp>
	<877jklq5x7.fsf_-_@devron.myhome.or.jp>
	<873bv9q5vx.fsf_-_@devron.myhome.or.jp>
	<87y8d1orah.fsf_-_@devron.myhome.or.jp>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Sun, 06 Mar 2005 03:56:51 +0900
In-Reply-To: <87y8d1orah.fsf_-_@devron.myhome.or.jp> (OGAWA Hirofumi's
 message of "Sun, 06 Mar 2005 03:56:22 +0900")
Message-ID: <87u0npor9o.fsf_-_@devron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Since MSDOS_SB() is inline function, it increases text size at each calls.
I don't know whether there is __attribute__ for avoiding this.

This removes the multiple call.

Signed-off-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
---

 fs/fat/dir.c    |   30 ++++++++++++++++--------------
 fs/vfat/namei.c |    8 ++++----
 2 files changed, 20 insertions(+), 18 deletions(-)

diff -puN fs/fat/dir.c~sync08-fat_tweak3 fs/fat/dir.c
--- linux-2.6.11/fs/fat/dir.c~sync08-fat_tweak3	2005-03-06 02:37:18.000000000 +0900
+++ linux-2.6.11-hirofumi/fs/fat/dir.c	2005-03-06 02:37:18.000000000 +0900
@@ -205,18 +205,19 @@ int fat_search_long(struct inode *inode,
 		    int name_len, struct fat_slot_info *sinfo)
 {
 	struct super_block *sb = inode->i_sb;
+	struct msdos_sb_info *sbi = MSDOS_SB(sb);
 	struct buffer_head *bh = NULL;
 	struct msdos_dir_entry *de;
-	struct nls_table *nls_io = MSDOS_SB(sb)->nls_io;
-	struct nls_table *nls_disk = MSDOS_SB(sb)->nls_disk;
+	struct nls_table *nls_io = sbi->nls_io;
+	struct nls_table *nls_disk = sbi->nls_disk;
 	wchar_t bufuname[14];
 	unsigned char xlate_len, nr_slots;
 	wchar_t *unicode = NULL;
 	unsigned char work[8], bufname[260];	/* 256 + 4 */
-	int uni_xlate = MSDOS_SB(sb)->options.unicode_xlate;
-	int utf8 = MSDOS_SB(sb)->options.utf8;
-	int anycase = (MSDOS_SB(sb)->options.name_check != 's');
-	unsigned short opt_shortname = MSDOS_SB(sb)->options.shortname;
+	int uni_xlate = sbi->options.unicode_xlate;
+	int utf8 = sbi->options.utf8;
+	int anycase = (sbi->options.name_check != 's');
+	unsigned short opt_shortname = sbi->options.shortname;
 	loff_t cpos = 0;
 	int chl, i, j, last_u, err;
 
@@ -386,10 +387,11 @@ static int fat_readdirx(struct inode *in
 			filldir_t filldir, int short_only, int both)
 {
 	struct super_block *sb = inode->i_sb;
+	struct msdos_sb_info *sbi = MSDOS_SB(sb);
 	struct buffer_head *bh;
 	struct msdos_dir_entry *de;
-	struct nls_table *nls_io = MSDOS_SB(sb)->nls_io;
-	struct nls_table *nls_disk = MSDOS_SB(sb)->nls_disk;
+	struct nls_table *nls_io = sbi->nls_io;
+	struct nls_table *nls_disk = sbi->nls_disk;
 	unsigned char long_slots;
 	const char *fill_name;
 	int fill_len;
@@ -397,11 +399,11 @@ static int fat_readdirx(struct inode *in
 	wchar_t *unicode = NULL;
 	unsigned char c, work[8], bufname[56], *ptname = bufname;
 	unsigned long lpos, dummy, *furrfu = &lpos;
-	int uni_xlate = MSDOS_SB(sb)->options.unicode_xlate;
-	int isvfat = MSDOS_SB(sb)->options.isvfat;
-	int utf8 = MSDOS_SB(sb)->options.utf8;
-	int nocase = MSDOS_SB(sb)->options.nocase;
-	unsigned short opt_shortname = MSDOS_SB(sb)->options.shortname;
+	int uni_xlate = sbi->options.unicode_xlate;
+	int isvfat = sbi->options.isvfat;
+	int utf8 = sbi->options.utf8;
+	int nocase = sbi->options.nocase;
+	unsigned short opt_shortname = sbi->options.shortname;
 	unsigned long inum;
 	int chi, chl, i, i2, j, last, last_u, dotoffset = 0;
 	loff_t cpos;
@@ -513,7 +515,7 @@ ParseLong:
 			long_slots = 0;
 	}
 
-	if (MSDOS_SB(sb)->options.dotsOK) {
+	if (sbi->options.dotsOK) {
 		ptname = bufname;
 		dotoffset = 0;
 		if (de->attr & ATTR_HIDDEN) {
diff -puN fs/vfat/namei.c~sync08-fat_tweak3 fs/vfat/namei.c
--- linux-2.6.11/fs/vfat/namei.c~sync08-fat_tweak3	2005-03-06 02:37:18.000000000 +0900
+++ linux-2.6.11-hirofumi/fs/vfat/namei.c	2005-03-06 02:37:18.000000000 +0900
@@ -301,6 +301,7 @@ static int vfat_create_shortname(struct 
 				 wchar_t *uname, int ulen,
 				 unsigned char *name_res, unsigned char *lcase)
 {
+	struct fat_mount_options *opts = &MSDOS_SB(dir->i_sb)->options;
 	wchar_t *ip, *ext_start, *end, *name_start;
 	unsigned char base[9], ext[4], buf[8], *p;
 	unsigned char charbuf[NLS_MAX_CHARSET_SIZE];
@@ -308,7 +309,6 @@ static int vfat_create_shortname(struct 
 	int sz = 0, extlen, baselen, i, numtail_baselen, numtail2_baselen;
 	int is_shortname;
 	struct shortname_info base_info, ext_info;
-	unsigned short opt_shortname = MSDOS_SB(dir->i_sb)->options.shortname;
 
 	is_shortname = 1;
 	INIT_SHORTNAME_INFO(&base_info);
@@ -421,9 +421,9 @@ static int vfat_create_shortname(struct 
 		if (vfat_find_form(dir, name_res) == 0)
 			return -EEXIST;
 
-		if (opt_shortname & VFAT_SFN_CREATE_WIN95) {
+		if (opts->shortname & VFAT_SFN_CREATE_WIN95) {
 			return (base_info.upper && ext_info.upper);
-		} else if (opt_shortname & VFAT_SFN_CREATE_WINNT) {
+		} else if (opts->shortname & VFAT_SFN_CREATE_WINNT) {
 			if ((base_info.upper || base_info.lower) &&
 			    (ext_info.upper || ext_info.lower)) {
 				if (!base_info.upper && base_info.lower)
@@ -438,7 +438,7 @@ static int vfat_create_shortname(struct 
 		}
 	}
 
-	if (MSDOS_SB(dir->i_sb)->options.numtail == 0)
+	if (opts->numtail == 0)
 		if (vfat_find_form(dir, name_res) < 0)
 			return 0;
 
_
