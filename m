Return-Path: <linux-kernel-owner+w=401wt.eu-S1751132AbXAFCbz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751132AbXAFCbz (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 21:31:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751129AbXAFCbJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 21:31:09 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:36674 "EHLO
	sous-sol.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751123AbXAFCay (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 21:30:54 -0500
Message-Id: <20070106023429.759044000@sous-sol.org>
References: <20070106022753.334962000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Fri, 05 Jan 2007 18:28:23 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, Daniel Drake <dsd@gentoo.org>,
       sandeen@redhat.com, <linux-ext4@vger.kernel.org>
Subject: [patch 30/50] handle ext3 directory corruption better (CVE-2006-6053)
Content-Disposition: inline; filename=handle-ext3-directory-corruption-better.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

From: Eric Sandeen <sandeen@redhat.com>

I've been using Steve Grubb's purely evil "fsfuzzer" tool, at
http://people.redhat.com/sgrubb/files/fsfuzzer-0.4.tar.gz

Basically it makes a filesystem, splats some random bits over it, then
tries to mount it and do some simple filesystem actions.

At best, the filesystem catches the corruption gracefully.  At worst,
things spin out of control.

As you might guess, we found a couple places in ext3 where things spin out
of control :)

First, we had a corrupted directory that was never checked for
consistency...  it was corrupt, and pointed to another bad "entry" of
length 0.  The for() loop looped forever, since the length of
ext3_next_entry(de) was 0, and we kept looking at the same pointer over and
over and over and over...  I modeled this check and subsequent action on
what is done for other directory types in ext3_readdir...

(adding this check adds some computational expense; I am testing a followup
patch to reduce the number of times we check and re-check these directory
entries, in all cases.  Thanks for the idea, Andreas).

Next we had a root directory inode which had a corrupted size, claimed to
be > 200M on a 4M filesystem.  There was only really 1 block in the
directory, but because the size was so large, readdir kept coming back for
more, spewing thousands of printk's along the way.

Per Andreas' suggestion, if we're in this read error condition and we're
trying to read an offset which is greater than i_blocks worth of bytes,
stop trying, and break out of the loop.

With these two changes fsfuzz test survives quite well on ext3.

Signed-off-by: Eric Sandeen <sandeen@redhat.com>
Cc: <linux-ext4@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Linus Torvalds <torvalds@osdl.org>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---
Date: Thu, 7 Dec 2006 04:36:26 +0000 (-0800)
Subject: [patch 30/50] [PATCH] handle ext3 directory corruption better
X-Git-Tag: v2.6.20-rc1
X-Git-Url: http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=40b851348fe9bf49c26025b34261d25142269b60

 fs/ext3/dir.c   |    3 +++
 fs/ext3/namei.c |    9 +++++++++
 2 files changed, 12 insertions(+)

--- linux-2.6.19.1.orig/fs/ext3/dir.c
+++ linux-2.6.19.1/fs/ext3/dir.c
@@ -154,6 +154,9 @@ static int ext3_readdir(struct file * fi
 			ext3_error (sb, "ext3_readdir",
 				"directory #%lu contains a hole at offset %lu",
 				inode->i_ino, (unsigned long)filp->f_pos);
+			/* corrupt size?  Maybe no more blocks to read */
+			if (filp->f_pos > inode->i_blocks << 9)
+				break;
 			filp->f_pos += sb->s_blocksize - offset;
 			continue;
 		}
--- linux-2.6.19.1.orig/fs/ext3/namei.c
+++ linux-2.6.19.1/fs/ext3/namei.c
@@ -552,6 +552,15 @@ static int htree_dirblock_to_tree(struct
 					   dir->i_sb->s_blocksize -
 					   EXT3_DIR_REC_LEN(0));
 	for (; de < top; de = ext3_next_entry(de)) {
+		if (!ext3_check_dir_entry("htree_dirblock_to_tree", dir, de, bh,
+					(block<<EXT3_BLOCK_SIZE_BITS(dir->i_sb))
+						+((char *)de - bh->b_data))) {
+			/* On error, skip the f_pos to the next block. */
+			dir_file->f_pos = (dir_file->f_pos |
+					(dir->i_sb->s_blocksize - 1)) + 1;
+			brelse (bh);
+			return count;
+		}
 		ext3fs_dirhash(de->name, de->name_len, hinfo);
 		if ((hinfo->hash < start_hash) ||
 		    ((hinfo->hash == start_hash) &&

--
