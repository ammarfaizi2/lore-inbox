Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129092AbQKMACX>; Sun, 12 Nov 2000 19:02:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129178AbQKMACN>; Sun, 12 Nov 2000 19:02:13 -0500
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.29]:28167 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S129092AbQKMABx>; Sun, 12 Nov 2000 19:01:53 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Linus Torvalds <torvalds@transmeta.com>
Date: Mon, 13 Nov 2000 11:01:41 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14863.12133.48270.462858@notabene.cse.unsw.edu.au>
cc: linux-kernel@vger.kernel.org
Subject: PATCH - highmem support for ramdisk and raid5
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


While reading a recent discussion of highmem support in ramfs, I was
reminded that my recent patch to rd.c removed highmem support (as that
support came through the create_bounce call in __make_request, and
with my change, rd requests no longer go though __make_request).

The following patch rectifies this and also addresses the same problem
in raid5, which currently will not work reliably with highmem.
(Other raid levels are not affected as  they never actually touch the
data, raid5 does touch it to do parity calculations).

What the patch does is introduce "bh_kmap" and "bh_kunmap", which are
like kmap and kunmap, but take account the offset of the buffer within
the page.  Without CONFIG_HIGHMEM, bh_kmap just returns b_data, and
bh_kunmap becomes a NO-OP.

Every memcpy which would previously refer to b_data in a bh that could
be in highmem now is preceeded by a call to bh_kmap, and followed by
a call to bh_kunmap.

I don't have a highmem machine that I can do testing on, but it seems
fine on a non-highmem machine, and it *looks* right :-)

NeilBrown



--- ./include/linux/highmem.h	2000/11/12 22:10:43	1.1
+++ ./include/linux/highmem.h	2000/11/12 23:45:24	1.2
@@ -93,4 +93,22 @@
 	kunmap(to);
 }
 
+/* get mapping for a buffer_head */
+
+static inline char *bh_kmap(struct buffer_head *bh)
+{
+	void *vaddr;
+	if (!PageHighMem(bh->b_page))
+		return bh->b_data;
+	vaddr = kmap(bh->b_page);
+	return ((char*)vaddr) + bh_offset(bh);
+}
+
+static inline void bh_kunmap(struct buffer_head *bh)
+{
+	if (PageHighMem(bh->b_page))
+		kunmap(bh->b_page);
+}
+
+
 #endif /* _LINUX_HIGHMEM_H */
--- ./drivers/block/rd.c	2000/11/12 22:10:44	1.1
+++ ./drivers/block/rd.c	2000/11/12 23:45:24	1.2
@@ -199,6 +199,7 @@
 	unsigned int minor;
 	unsigned long offset, len;
 	struct buffer_head *rbh;
+	char *bdata;
 
 	
 	minor = MINOR(sbh->b_rdev);
@@ -221,12 +222,17 @@
 	}
 
 	rbh = getblk(sbh->b_rdev, sbh->b_rsector/(sbh->b_size>>9), sbh->b_size);
+	/* I think that it is safe to assume that rbh is not in HighMem, though
+	 * sbh might be - NeilBrown
+	 */
+	bdata = bh_kmap(sbh);
 	if (rw == READ) {
 		if (sbh != rbh)
-			memcpy(sbh->b_data, rbh->b_data, rbh->b_size);
+			memcpy(bdata, rbh->b_data, rbh->b_size);
 	} else
 		if (sbh != rbh)
-			memcpy(rbh->b_data, sbh->b_data, rbh->b_size);
+			memcpy(rbh->b_data, bdata, rbh->b_size);
+	bh_kunmap(sbh);
 	mark_buffer_protected(rbh);
 	brelse(rbh);
 
--- ./drivers/md/raid5.c	2000/11/12 22:10:44	1.1
+++ ./drivers/md/raid5.c	2000/11/12 23:45:24	1.2
@@ -858,13 +858,16 @@
 
 	PRINTK("compute_parity, stripe %lu, method %d\n", sh->sector, method);
 	for (i = 0; i < disks; i++) {
+		char *bdata;
 		if (i == pd_idx || !sh->bh_new[i])
 			continue;
 		if (!sh->bh_copy[i])
 			sh->bh_copy[i] = raid5_alloc_buffer(sh, sh->size);
 		raid5_build_block(sh, sh->bh_copy[i], i);
 		atomic_set_buffer_dirty(sh->bh_copy[i]);
-		memcpy(sh->bh_copy[i]->b_data, sh->bh_new[i]->b_data, sh->size);
+		bdata = bh_kmap(sh->bh_new[i]);
+		memcpy(sh->bh_copy[i]->b_data, bdata, sh->size);
+		bh_kunmap(sh->bh_new[i]);
 	}
 	if (sh->bh_copy[pd_idx] == NULL) {
 		sh->bh_copy[pd_idx] = raid5_alloc_buffer(sh, sh->size);
@@ -965,12 +968,14 @@
 			if (!sh->new[i]) {
 #if 0
 				if (sh->cmd == STRIPE_WRITE) {
-					if (memcmp(sh->bh_new[i]->b_data, sh->bh_copy[i]->b_data, sh->size)) {
+					char *bdata = bh_kmap(sh->bh_new[i]);
+					if (memcmp(bdata, sh->bh_copy[i]->b_data, sh->size)) {
 						printk("copy differs, %s, sector %lu ",
 							test_bit(BH_Dirty, &sh->bh_new[i]->b_state) ? "dirty" : "clean",
 							sh->sector);
 					} else if (test_bit(BH_Dirty, &sh->bh_new[i]->b_state))
 						printk("sector %lu dirty\n", sh->sector);
+					bh_kunmap(sh->bh_new[i]);
 				}
 #endif
 				if (sh->cmd == STRIPE_WRITE)
@@ -1136,11 +1141,14 @@
 	if (!method1 || (method1 == 1 && nr_cache == disks - 1)) {
 		PRINTK("read %lu completed from cache\n", sh->sector);
 		for (i = 0; i < disks; i++) {
+			char *bdata;
 			if (!sh->bh_new[i])
 				continue;
 			if (!sh->bh_old[i])
 				compute_block(sh, i);
-			memcpy(sh->bh_new[i]->b_data, sh->bh_old[i]->b_data, sh->size);
+			bdata = bh_kmap(sh->bh_new[i]);
+			memcpy(bdata, sh->bh_old[i]->b_data, sh->size);
+			bh_kunmap(sh->bh_new[i]);
 		}
 		complete_stripe(sh);
 		return;
@@ -1168,7 +1176,9 @@
 		if (!sh->bh_new[i])
 			continue;
 		if (sh->bh_old[i]) {
-			memcpy(sh->bh_new[i]->b_data, sh->bh_old[i]->b_data, sh->size);
+			char *bdata = bh_kmap(sh->bh_new[i]);
+			memcpy(bdata, sh->bh_old[i]->b_data, sh->size);
+			bh_kunmap(sh->bh_new[i]);
 			continue;
 		}
 #if RAID5_PARANOIA
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
