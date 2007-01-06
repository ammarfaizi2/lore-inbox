Return-Path: <linux-kernel-owner+w=401wt.eu-S1751124AbXAFCb4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751124AbXAFCb4 (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 21:31:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751127AbXAFCbE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 21:31:04 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:36679 "EHLO
	sous-sol.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751124AbXAFCaz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 21:30:55 -0500
Message-Id: <20070106023449.914553000@sous-sol.org>
References: <20070106022753.334962000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Fri, 05 Jan 2007 18:28:25 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, Daniel Drake <dsd@gentoo.org>,
       sandeen@redhat.com
Subject: [patch 32/50] ext2: skip pages past number of blocks in ext2_find_entry (CVE-2006-6054)
Content-Disposition: inline; filename=ext2-skip-pages-past-number-of-blocks-in-ext2_find_entry.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

From: Eric Sandeen <sandeen@redhat.com>

This one was pointed out on the MOKB site:
http://kernelfun.blogspot.com/2006/11/mokb-09-11-2006-linux-26x-ext2checkpage.html

If a directory's i_size is corrupted, ext2_find_entry() will keep processing
pages until the i_size is reached, even if there are no more blocks associated
with the directory inode.  This patch puts in some minimal sanity-checking
so that we don't keep checking pages (and issuing errors) if we know there
can be no more data to read, based on the block count of the directory inode.

This is somewhat similar in approach to the ext3 patch I sent earlier this
year.

Signed-off-by: Eric Sandeen <sandeen@redhat.com>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---
Not upstream yet

 fs/ext2/dir.c |    8 ++++++++
 1 file changed, 8 insertions(+)

--- linux-2.6.19.1.orig/fs/ext2/dir.c
+++ linux-2.6.19.1/fs/ext2/dir.c
@@ -368,6 +368,14 @@ struct ext2_dir_entry_2 * ext2_find_entr
 		}
 		if (++n >= npages)
 			n = 0;
+		/* next page is past the blocks we've got */
+		if (unlikely(n > (dir->i_blocks >> (PAGE_CACHE_SHIFT - 9)))) {
+			ext2_error(dir->i_sb, __FUNCTION__,
+				"dir %lu size %lld exceeds block count %llu",
+				dir->i_ino, dir->i_size,
+				(unsigned long long)dir->i_blocks);
+				goto out;
+		}
 	} while (n != start);
 out:
 	return NULL;

--
