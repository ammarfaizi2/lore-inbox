Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932487AbVHaIZS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932487AbVHaIZS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 04:25:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932488AbVHaIZS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 04:25:18 -0400
Received: from NS8.Sony.CO.JP ([137.153.0.33]:6855 "EHLO ns8.sony.co.jp")
	by vger.kernel.org with ESMTP id S932487AbVHaIZQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 04:25:16 -0400
Message-ID: <43156963.8020203@sm.sony.co.jp>
Date: Wed, 31 Aug 2005 17:25:07 +0900
From: "Machida, Hiroyuki" <machida@sm.sony.co.jp>
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
X-Accept-Language: ja, en-us, en
MIME-Version: 1.0
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
CC: linux-kernel@vger.kernel.org
Subject: [PATCH][FAT] FAT dirent scan with hin take #3
References: <4313CBEF.9020505@sm.sony.co.jp> <4313E578.8070100@sm.sony.co.jp> <874q979qdj.fsf@devron.myhome.or.jp>
In-Reply-To: <874q979qdj.fsf@devron.myhome.or.jp>
Content-Type: multipart/mixed;
 boundary="------------070001070904050201080008"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070001070904050201080008
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


Sorry, I send out wrong version. I attached the latest patch to 2.6.13.

OGAWA Hirofumi wrote:
> "Machida, Hiroyuki" <machida@sm.sony.co.jp> writes:
> 
> 
>>Here is a revised version of dirent scan patch,  mentioned at
>>following E-mail.
>>
>>This patch addresses performance damages on "ls | xargs xxx" and
>>reverse order scan which are reported to the previous patch.
>>
>>With this patch, fat_search_long() and fat_scan() use hint value
>>as start of scan. For each directory holds multiple hint value entries.
>>The entry would be selected by hash value based on scan target name and
>>PID. Hint value would be calculated based on the entry previously found
>>entry, so that the hint can cover backward neighborhood.
> 
> 
> This patch couldn't compile. I assume you post a wrong patch...?
>
> The code is strange... Is the hint value related to the previously
> accessed entry?
> 
> This seems to be randomly cacheing the recent access position...  Is
> it your intention of this patch?

Right, it looks like TLB, which holds cache "Physical addres"
correponding to "Logical address". In this case, PID and file name
to be looked up, perform role of "Logical address".

I prepared vfat16 fs where over 4000 files in /foo
and 200 files in root, then checked with following cases;


				without patch	with patch
ls-vfat				59.0		2.49
xargs-vfat			61.3		11.9
stat-vfat			41		17
stat-vfat-reverse		56		32

ls-msdos			14.2		0.62
xargs-msdos			16.8		16.7
stat-msdos			21		15
stat-msdos-reverse		22		16
					- all valuses have sec unit

1-1 ls-vat)
mount vfat to /a
/usr/bin/time -p sh -c "/usr/bin/ls -Rl /a > /dev/null"
umount /a

1-2 ls-msdos)
mount msdos to /a
/usr/bin/time -p sh -c "/usr/bin/ls -Rl /a > /dev/null"
umount /a

2-1 xargs-vfat)
mount vfat to /a
cd /a/foo
/usr/bin/time -p sh -c "(/usr/bin/ls | /usr/in/xargs stat) > /dev/null"
umount /a

2-2 xargs-msdos)
mount msdos to /a
cd /a/foo
/usr/bin/time -p sh -c "(/usr/bin/ls | /usr/in/xargs stat) > /dev/null"
umount /a

3-1 stat-vfat)
mount vfat to /a
cd /a/foo
repeat stat files which have located in the last 1024 dir entries
   with incremental order.
umount /a

3-2 stat-vfat-reverse)
do 3-1 with decremental order

3-3 stat-msdos)
do 3-1 with msdos fs

3-4 stat-msdos-reverse)
do 3-2 with msdos fs


-- 
Hiroyuki Machida

--------------070001070904050201080008
Content-Type: text/plain;
 name="fat-dirscan-with-hint_3.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fat-dirscan-with-hint_3.patch"

This patch enables using hint information on scanning dir.
It achieves excellent performance with "ls -l" for over 1000 entries.

* fat-dirscan-with-hint_3.patch for linux 2.6.13

 fs/fat/dir.c             |  130 ++++++++++++++++++++++++++++++++++++++++++++---
 fs/fat/inode.c           |   13 ++++
 include/linux/msdos_fs.h |    2 
 3 files changed, 137 insertions(+), 8 deletions(-)

Signed-off-by: Hiroyuki Machida <machida@sm.sony.co.jp> for CELF

* modified files


--- linux-2.6.13/fs/fat/dir.c	2005-08-29 08:41:01.000000000 +0900
+++ linux-2.6.13-work/fs/fat/dir.c	2005-08-31 13:48:01.001119437 +0900
@@ -201,6 +201,88 @@ fat_shortname2uni(struct nls_table *nls,
  * Return values: negative -> error, 0 -> not found, positive -> found,
  * value is the total amount of slots, including the shortname entry.
  */
+
+#define FAT_SCAN_SHIFT	4			/* 2x8 way scan hints  */
+#define FAT_SCAN_NWAY	(1<<FAT_SCAN_SHIFT)
+
+inline
+static int hint_allocate(struct inode *dir)
+{
+	loff_t *hints;
+	int err = 0;
+
+	if (!MSDOS_I(dir)->scan_hints) {
+		hints = kcalloc(FAT_SCAN_NWAY, sizeof(loff_t), GFP_KERNEL);
+		if (!hints) 
+			err = -ENOMEM;
+
+		down(&MSDOS_I(dir)->scan_lock);
+		if (MSDOS_I(dir)->scan_hints)
+			err = -EINVAL;
+		if (!err)
+			MSDOS_I(dir)->scan_hints = hints;
+		up(&MSDOS_I(dir)->scan_lock);
+		if (err == -EINVAL) {
+			kfree(hints);
+			err = 0;
+		}
+	}
+	return err;
+}
+
+
+inline
+static void hint_record(struct inode *dir, struct fat_slot_info *sinfo, 
+			  int hindex)
+{
+	loff_t under_scan_off, nent;
+
+	nent = (dir->i_size > PAGE_SIZE ? dir->i_size : PAGE_SIZE)
+		/ sizeof(struct msdos_dir_entry);
+
+	/* educational guess; try to cover 1/4 previous range */
+	nent >>= (FAT_SCAN_SHIFT + 2);
+	under_scan_off = nent * sizeof(struct msdos_dir_entry);
+
+	if (sinfo->slot_off > under_scan_off) 
+		MSDOS_I(dir)->scan_hints[hindex] =
+			sinfo->slot_off - under_scan_off;  
+	else
+		MSDOS_I(dir)->scan_hints[hindex] = 0;  
+}
+
+
+inline 
+static int hint_index_body(const unsigned char *name, int name_len, int check_null)
+{
+	int i;
+	int val = 0;
+	unsigned char *p = (unsigned char *) name;
+	int id = current->pid;
+	
+	for (i=0; i<name_len; i++) {
+		if (check_null && !*p) break;
+		val = ((val << 1) & 0xfe) | ((val & 0x80) ? 1 : 0);
+		val ^= *p;
+		p ++;
+	}
+	id = ((id >> 8) & 0xf) ^ (id & 0xf);
+	val = (val << 1) | (id & 1);
+	return val & (FAT_SCAN_NWAY-1);
+}
+
+inline 
+static int lfn_hint_index(const unsigned char *name, int name_len)
+{
+	return hint_index_body(name, name_len, 0);
+}
+
+inline 
+static int hint_index(const unsigned char *name)
+{
+	return hint_index_body(name, MSDOS_NAME, 1);
+}
+
 int fat_search_long(struct inode *inode, const unsigned char *name,
 		    int name_len, struct fat_slot_info *sinfo)
 {
@@ -218,13 +300,26 @@ int fat_search_long(struct inode *inode,
 	int utf8 = sbi->options.utf8;
 	int anycase = (sbi->options.name_check != 's');
 	unsigned short opt_shortname = sbi->options.shortname;
-	loff_t cpos = 0;
 	int chl, i, j, last_u, err;
+	loff_t cpos, start_off;
+	int reach_bottom = 0;
+	int hindex;
+	int ret;
+
+	ret = hint_allocate(inode); 
+	if (ret < 0) return ret;
+	hindex = lfn_hint_index(name, name_len);
+	start_off = cpos =  MSDOS_I(inode)->scan_hints[hindex];
 
 	err = -ENOENT;
 	while(1) {
-		if (fat_get_entry(inode, &cpos, &bh, &de) == -1)
-			goto EODir;
+Top:
+		if (reach_bottom && cpos >= start_off) goto EODir;
+		if (fat_get_entry(inode, &cpos, &bh, &de) == -1) {
+			if (!start_off) goto EODir;
+			reach_bottom ++; cpos = 0;
+			continue;
+		}
 parse_record:
 		nr_slots = 0;
 		if (de->name[0] == DELETED_FLAG)
@@ -274,8 +369,11 @@ parse_long:
 				if (ds->id & 0x40) {
 					unicode[offset + 13] = 0;
 				}
-				if (fat_get_entry(inode, &cpos, &bh, &de) < 0)
-					goto EODir;
+				if (fat_get_entry(inode, &cpos, &bh, &de) <0 ) {
+					if (!start_off) goto EODir;
+					reach_bottom ++; cpos = 0;
+					goto Top;
+				}
 				if (slot == 0)
 					break;
 				ds = (struct msdos_dir_slot *) de;
@@ -363,6 +461,7 @@ Found:
 	sinfo->de = de;
 	sinfo->bh = bh;
 	sinfo->i_pos = fat_make_i_pos(sb, sinfo->bh, sinfo->de);
+	hint_record(inode, sinfo, hindex);
 	err = 0;
 EODir:
 	if (unicode)
@@ -838,17 +937,32 @@ int fat_scan(struct inode *dir, const un
 	     struct fat_slot_info *sinfo)
 {
 	struct super_block *sb = dir->i_sb;
+	loff_t	start_off;
+	int	hindex;
+	int	ret;
+	int reach_bottom = 0;
+
+	ret = hint_allocate(dir); 
+	if (ret < 0) return ret;
+	hindex = hint_index(name);
 
-	sinfo->slot_off = 0;
+	sinfo->slot_off = start_off = MSDOS_I(dir)->scan_hints[hindex];
 	sinfo->bh = NULL;
-	while (fat_get_short_entry(dir, &sinfo->slot_off, &sinfo->bh,
-				   &sinfo->de) >= 0) {
+	while (1) {
+		if (fat_get_short_entry(dir, &sinfo->slot_off, 
+				        &sinfo->bh, &sinfo->de) <0 ) { 
+			if (!start_off) break;
+			sinfo->slot_off = 0LL; reach_bottom ++;
+			continue;
+		}
 		if (!strncmp(sinfo->de->name, name, MSDOS_NAME)) {
 			sinfo->slot_off -= sizeof(*sinfo->de);
 			sinfo->nr_slots = 1;
 			sinfo->i_pos = fat_make_i_pos(sb, sinfo->bh, sinfo->de);
+			hint_record(dir, sinfo, hindex);
 			return 0;
 		}
+		if (reach_bottom && (start_off <= sinfo->slot_off)) break;
 	}
 	return -ENOENT;
 }
--- linux-2.6.13/fs/fat/inode.c	2005-08-29 08:41:01.000000000 +0900
+++ linux-2.6.13-work/fs/fat/inode.c	2005-08-31 12:59:54.292274060 +0900
@@ -242,6 +242,8 @@ static int fat_fill_inode(struct inode *
 	inode->i_version++;
 	inode->i_generation = get_seconds();
 
+	init_MUTEX(&MSDOS_I(inode)->scan_lock);
+	MSDOS_I(inode)->scan_hints = 0;
 	if ((de->attr & ATTR_DIR) && !IS_FREE(de->name)) {
 		inode->i_generation &= ~1;
 		inode->i_mode = MSDOS_MKMODE(de->attr,
@@ -345,6 +347,15 @@ static void fat_delete_inode(struct inod
 static void fat_clear_inode(struct inode *inode)
 {
 	struct msdos_sb_info *sbi = MSDOS_SB(inode->i_sb);
+	loff_t *hints;
+
+	down(&MSDOS_I(inode)->scan_lock);
+	hints = (MSDOS_I(inode)->scan_hints);
+	if (hints) {
+		MSDOS_I(inode)->scan_hints = NULL;
+	}
+	up(&MSDOS_I(inode)->scan_lock);
+	kfree(hints);
 
 	if (is_bad_inode(inode))
 		return;
@@ -1011,6 +1022,8 @@ static int fat_read_root(struct inode *i
 	struct msdos_sb_info *sbi = MSDOS_SB(sb);
 	int error;
 
+	init_MUTEX(&MSDOS_I(inode)->scan_lock);
+	MSDOS_I(inode)->scan_hints = 0;
 	MSDOS_I(inode)->i_pos = 0;
 	inode->i_uid = sbi->options.fs_uid;
 	inode->i_gid = sbi->options.fs_gid;
--- linux-2.6.13/include/linux/msdos_fs.h	2005-08-29 08:41:01.000000000 +0900
+++ linux-2.6.13-work/include/linux/msdos_fs.h	2005-08-31 12:58:30.090265918 +0900
@@ -255,6 +255,8 @@ struct msdos_inode_info {
 	/* for avoiding the race between fat_free() and fat_get_cluster() */
 	unsigned int cache_valid_id;
 
+	struct semaphore scan_lock;	/* lock for dirscan hints */
+	loff_t *scan_hints;	/* dirscan hints */
 	loff_t mmu_private;
 	int i_start;		/* first cluster or 0 */
 	int i_logstart;		/* logical first cluster */

--------------070001070904050201080008--
