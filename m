Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751662AbWJTD0J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751662AbWJTD0J (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 23:26:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946141AbWJTDZ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 23:25:57 -0400
Received: from cantor2.suse.de ([195.135.220.15]:18838 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751651AbWJTDZs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 23:25:48 -0400
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Fri, 20 Oct 2006 13:25:40 +1000
Message-Id: <1061020032540.1699@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 003 of 4] md: Endian annotation for v1 superblock access.
References: <20061020120612.29297.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Includes a couple of bugfixed found by sparse.

Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./drivers/md/md.c           |   13 +++++----
 ./include/linux/raid/md_p.h |   58 ++++++++++++++++++++++----------------------
 2 files changed, 36 insertions(+), 35 deletions(-)

diff .prev/drivers/md/md.c ./drivers/md/md.c
--- .prev/drivers/md/md.c	2006-10-20 11:49:17.000000000 +1000
+++ ./drivers/md/md.c	2006-10-20 12:00:57.000000000 +1000
@@ -974,12 +974,13 @@ static void super_90_sync(mddev_t *mddev
  * version 1 superblock
  */
 
-static unsigned int calc_sb_1_csum(struct mdp_superblock_1 * sb)
+static __le32 calc_sb_1_csum(struct mdp_superblock_1 * sb)
 {
-	unsigned int disk_csum, csum;
+	__le32 disk_csum;
+	u32 csum;
 	unsigned long long newcsum;
 	int size = 256 + le32_to_cpu(sb->max_dev)*2;
-	unsigned int *isuper = (unsigned int*)sb;
+	__le32 *isuper = (__le32*)sb;
 	int i;
 
 	disk_csum = sb->sb_csum;
@@ -989,7 +990,7 @@ static unsigned int calc_sb_1_csum(struc
 		newcsum += le32_to_cpu(*isuper++);
 
 	if (size == 2)
-		newcsum += le16_to_cpu(*(unsigned short*) isuper);
+		newcsum += le16_to_cpu(*(__le16*) isuper);
 
 	csum = (newcsum & 0xffffffff) + (newcsum >> 32);
 	sb->sb_csum = disk_csum;
@@ -1106,7 +1107,7 @@ static int super_1_load(mdk_rdev_t *rdev
 	if (le32_to_cpu(sb->chunksize))
 		rdev->size &= ~((sector_t)le32_to_cpu(sb->chunksize)/2 - 1);
 
-	if (le32_to_cpu(sb->size) > rdev->size*2)
+	if (le64_to_cpu(sb->size) > rdev->size*2)
 		return -EINVAL;
 	return ret;
 }
@@ -1228,7 +1229,7 @@ static void super_1_sync(mddev_t *mddev,
 	else
 		sb->resync_offset = cpu_to_le64(0);
 
-	sb->cnt_corrected_read = atomic_read(&rdev->corrected_errors);
+	sb->cnt_corrected_read = cpu_to_le32(atomic_read(&rdev->corrected_errors));
 
 	sb->raid_disks = cpu_to_le32(mddev->raid_disks);
 	sb->size = cpu_to_le64(mddev->size<<1);

diff .prev/include/linux/raid/md_p.h ./include/linux/raid/md_p.h
--- .prev/include/linux/raid/md_p.h	2006-10-20 11:41:01.000000000 +1000
+++ ./include/linux/raid/md_p.h	2006-10-20 12:00:57.000000000 +1000
@@ -206,52 +206,52 @@ static inline __u64 md_event(mdp_super_t
  */
 struct mdp_superblock_1 {
 	/* constant array information - 128 bytes */
-	__u32	magic;		/* MD_SB_MAGIC: 0xa92b4efc - little endian */
-	__u32	major_version;	/* 1 */
-	__u32	feature_map;	/* bit 0 set if 'bitmap_offset' is meaningful */
-	__u32	pad0;		/* always set to 0 when writing */
+	__le32	magic;		/* MD_SB_MAGIC: 0xa92b4efc - little endian */
+	__le32	major_version;	/* 1 */
+	__le32	feature_map;	/* bit 0 set if 'bitmap_offset' is meaningful */
+	__le32	pad0;		/* always set to 0 when writing */
 
 	__u8	set_uuid[16];	/* user-space generated. */
 	char	set_name[32];	/* set and interpreted by user-space */
 
-	__u64	ctime;		/* lo 40 bits are seconds, top 24 are microseconds or 0*/
-	__u32	level;		/* -4 (multipath), -1 (linear), 0,1,4,5 */
-	__u32	layout;		/* only for raid5 and raid10 currently */
-	__u64	size;		/* used size of component devices, in 512byte sectors */
-
-	__u32	chunksize;	/* in 512byte sectors */
-	__u32	raid_disks;
-	__u32	bitmap_offset;	/* sectors after start of superblock that bitmap starts
+	__le64	ctime;		/* lo 40 bits are seconds, top 24 are microseconds or 0*/
+	__le32	level;		/* -4 (multipath), -1 (linear), 0,1,4,5 */
+	__le32	layout;		/* only for raid5 and raid10 currently */
+	__le64	size;		/* used size of component devices, in 512byte sectors */
+
+	__le32	chunksize;	/* in 512byte sectors */
+	__le32	raid_disks;
+	__le32	bitmap_offset;	/* sectors after start of superblock that bitmap starts
 				 * NOTE: signed, so bitmap can be before superblock
 				 * only meaningful of feature_map[0] is set.
 				 */
 
 	/* These are only valid with feature bit '4' */
-	__u32	new_level;	/* new level we are reshaping to		*/
-	__u64	reshape_position;	/* next address in array-space for reshape */
-	__u32	delta_disks;	/* change in number of raid_disks		*/
-	__u32	new_layout;	/* new layout					*/
-	__u32	new_chunk;	/* new chunk size (bytes)			*/
+	__le32	new_level;	/* new level we are reshaping to		*/
+	__le64	reshape_position;	/* next address in array-space for reshape */
+	__le32	delta_disks;	/* change in number of raid_disks		*/
+	__le32	new_layout;	/* new layout					*/
+	__le32	new_chunk;	/* new chunk size (bytes)			*/
 	__u8	pad1[128-124];	/* set to 0 when written */
 
 	/* constant this-device information - 64 bytes */
-	__u64	data_offset;	/* sector start of data, often 0 */
-	__u64	data_size;	/* sectors in this device that can be used for data */
-	__u64	super_offset;	/* sector start of this superblock */
-	__u64	recovery_offset;/* sectors before this offset (from data_offset) have been recovered */
-	__u32	dev_number;	/* permanent identifier of this  device - not role in raid */
-	__u32	cnt_corrected_read; /* number of read errors that were corrected by re-writing */
+	__le64	data_offset;	/* sector start of data, often 0 */
+	__le64	data_size;	/* sectors in this device that can be used for data */
+	__le64	super_offset;	/* sector start of this superblock */
+	__le64	recovery_offset;/* sectors before this offset (from data_offset) have been recovered */
+	__le32	dev_number;	/* permanent identifier of this  device - not role in raid */
+	__le32	cnt_corrected_read; /* number of read errors that were corrected by re-writing */
 	__u8	device_uuid[16]; /* user-space setable, ignored by kernel */
 	__u8	devflags;	/* per-device flags.  Only one defined...*/
 #define	WriteMostly1	1	/* mask for writemostly flag in above */
 	__u8	pad2[64-57];	/* set to 0 when writing */
 
 	/* array state information - 64 bytes */
-	__u64	utime;		/* 40 bits second, 24 btes microseconds */
-	__u64	events;		/* incremented when superblock updated */
-	__u64	resync_offset;	/* data before this offset (from data_offset) known to be in sync */
-	__u32	sb_csum;	/* checksum upto devs[max_dev] */
-	__u32	max_dev;	/* size of devs[] array to consider */
+	__le64	utime;		/* 40 bits second, 24 btes microseconds */
+	__le64	events;		/* incremented when superblock updated */
+	__le64	resync_offset;	/* data before this offset (from data_offset) known to be in sync */
+	__le32	sb_csum;	/* checksum upto devs[max_dev] */
+	__le32	max_dev;	/* size of devs[] array to consider */
 	__u8	pad3[64-32];	/* set to 0 when writing */
 
 	/* device state information. Indexed by dev_number.
@@ -260,7 +260,7 @@ struct mdp_superblock_1 {
 	 * into the 'roles' value.  If a device is spare or faulty, then it doesn't
 	 * have a meaningful role.
 	 */
-	__u16	dev_roles[0];	/* role in array, or 0xffff for a spare, or 0xfffe for faulty */
+	__le16	dev_roles[0];	/* role in array, or 0xffff for a spare, or 0xfffe for faulty */
 };
 
 /* feature_map bits */
