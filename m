Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S132276AbQK3Ael>; Wed, 29 Nov 2000 19:34:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S132369AbQK3Aeb>; Wed, 29 Nov 2000 19:34:31 -0500
Received: from hermes.mixx.net ([212.84.196.2]:25107 "HELO hermes.mixx.net")
        by vger.kernel.org with SMTP id <S132276AbQK3AeV>;
        Wed, 29 Nov 2000 19:34:21 -0500
From: Daniel Phillips <news-innominate.list.linux.kernel@innominate.de>
Reply-To: Daniel Phillips <phillips@innominate.de>
X-Newsgroups: innominate.list.linux.kernel
Subject: [PATCH] Re: 2.4.0-test11 ext2 fs corruption
Date: Thu, 30 Nov 2000 01:03:37 +0100
Organization: innominate
Distribution: local
Message-ID: <news2mail-3A259959.89EAD4DE@innominate.de>
In-Reply-To: <E2BA5DE1AE9@vcnet.vc.cvut.cz> <Pine.GSO.4.21.0011281520100.11331-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Trace: mate.bln.innominate.de 975542631 1618 10.0.0.90 (30 Nov 2000 00:03:51 GMT)
X-Complaints-To: news@innominate.de
To: Alexander Viro <viro@math.psu.edu>
X-Mailer: Mozilla 4.72 [de] (X11; U; Linux 2.4.0-test10 i586)
X-Accept-Language: en
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro wrote:
> Bloody hell...

I don't know if this is the bug he's got, in fact I doubt it, but it's a
bug and it needs fixing.  The problem is, ext2_get_group_desc
effectively returns two results; one of them is being assigned from on
conditional paths and the other isn't.  This bug will cause - on very
rare occasions - the wrong group descriptor block to be marked dirty,
and changes might be lost.  I think what we'd see as a result is wrong
block, inode and directory counts.

The fix below is kind of gross.  The way I really want to do the fix is
to remove one parameter from ext2_get_group_desc and thereby get rid of
the troublesome side effect for good, but that kind of change isn't
compatible with 'code freeze'.

(linux.2.4.0-test11)

--- fs/ext2/ialloc.c.old	Thu Nov 30 00:36:02 2000
+++ fs/ext2/ialloc.c	Thu Nov 30 00:36:39 2000
@@ -260,7 +260,7 @@
 {
 	struct super_block * sb;
 	struct buffer_head * bh;
-	struct buffer_head * bh2;
+	struct buffer_head * bh2, * tmpbh2;
 	int i, j, avefreei;
 	struct inode * inode;
 	int bitmap_nr;
@@ -293,10 +293,11 @@
 /* I am not yet convinced that this next bit is necessary.
 		i = dir->u.ext2_i.i_block_group;
 		for (j = 0; j < sb->u.ext2_sb.s_groups_count; j++) {
-			tmp = ext2_get_group_desc (sb, i, &bh2);
+			tmp = ext2_get_group_desc (sb, i, &tmpbh2);
 			if (tmp &&
 			    (le16_to_cpu(tmp->bg_used_dirs_count) << 8) < 
 			     le16_to_cpu(tmp->bg_free_inodes_count)) {
+				bh2 = tmpbh2;
 				gdp = tmp;
 				break;
 			}
@@ -306,7 +307,7 @@
 */
 		if (!gdp) {
 			for (j = 0; j < sb->u.ext2_sb.s_groups_count; j++) {
-				tmp = ext2_get_group_desc (sb, j, &bh2);
+				tmp = ext2_get_group_desc (sb, j, &tmpbh2);
 				if (tmp &&
 				    le16_to_cpu(tmp->bg_free_inodes_count) &&
 				    le16_to_cpu(tmp->bg_free_inodes_count) >= avefreei) {
@@ -314,6 +315,7 @@
 					    (le16_to_cpu(tmp->bg_free_blocks_count) >
 					     le16_to_cpu(gdp->bg_free_blocks_count))) {
 						i = j;
+						bh2 = tmpbh2;
 						gdp = tmp;
 					}
 				}
@@ -326,11 +328,11 @@
 		 * Try to place the inode in its parent directory
 		 */
 		i = dir->u.ext2_i.i_block_group;
-		tmp = ext2_get_group_desc (sb, i, &bh2);
-		if (tmp && le16_to_cpu(tmp->bg_free_inodes_count))
+		tmp = ext2_get_group_desc (sb, i, &tmpbh2);
+		if (tmp && le16_to_cpu(tmp->bg_free_inodes_count)) {
+			bh2 = tmpbh2;
 			gdp = tmp;
-		else
-		{
+		} else {
 			/*
 			 * Use a quadratic hash to find a group with a
 			 * free inode
@@ -339,9 +341,10 @@
 				i += j;
 				if (i >= sb->u.ext2_sb.s_groups_count)
 					i -= sb->u.ext2_sb.s_groups_count;
-				tmp = ext2_get_group_desc (sb, i, &bh2);
+				tmp = ext2_get_group_desc (sb, i, &tmpbh2);
 				if (tmp &&
 				    le16_to_cpu(tmp->bg_free_inodes_count)) {
+					bh2 = tmpbh2;
 					gdp = tmp;
 					break;
 				}
@@ -355,9 +358,10 @@
 			for (j = 2; j < sb->u.ext2_sb.s_groups_count; j++) {
 				if (++i >= sb->u.ext2_sb.s_groups_count)
 					i = 0;
-				tmp = ext2_get_group_desc (sb, i, &bh2);
+				tmp = ext2_get_group_desc (sb, i, &tmpbh2);
 				if (tmp &&
 				    le16_to_cpu(tmp->bg_free_inodes_count)) {
+					bh2 = tmpbh2;
 					gdp = tmp;
 					break;
 				}

--
Daniel
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
