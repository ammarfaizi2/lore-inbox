Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264419AbUG3Ku1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264419AbUG3Ku1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jul 2004 06:50:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267669AbUG3Ku1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jul 2004 06:50:27 -0400
Received: from smtp2.rz.tu-harburg.de ([134.28.205.13]:44736 "EHLO
	smtp2.rz.tu-harburg.de") by vger.kernel.org with ESMTP
	id S264419AbUG3KuO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jul 2004 06:50:14 -0400
Message-ID: <410A27CB.7000400@tu-harburg.de>
Date: Fri, 30 Jul 2004 12:49:47 +0200
From: Jan Blunck <j.blunck@tu-harburg.de>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040306)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: viro@parcelfarce.linux.theplanet.co.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ext2_readdir() filp->f_pos fix
References: <41094D69.9030008@tu-harburg.de> <20040729154625.0a6f48a3.akpm@osdl.org>
In-Reply-To: <20040729154625.0a6f48a3.akpm@osdl.org>
Content-Type: multipart/mixed;
 boundary="------------080309030908090303000102"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080309030908090303000102
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Andrew Morton wrote:
> Interesting.  How did you actually notice this?  Is the same problem not present
> in 2.4?

I noticed this problem because I'm "abusing" the f_pos in a VFS based
implementation of something like union-mount. There are already some
things done but I still need time until its ready for being posted
here.
Didn't checked that for 2.4 cause I'm only working on 2.6 at the moment.

> If the IS_ERR(page) returns true, should we not advance f_pos to skip this
> page?

Ok. I changed that in the attached patch. So when there is a bad page it 
is possible that the f_pos points somewhere to the beginning of the next 
page which might be out of range of the i_size. But I think that is ok 
for a error condition.


--------------080309030908090303000102
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"


 dir.c |   11 ++++++++---
 1 files changed, 8 insertions(+), 3 deletions(-)

--- 1.24/fs/ext2/dir.c	2004-07-29 21:25:31 +02:00
+++ 1.26/fs/ext2/dir.c	2004-07-30 11:54:27 +02:00
@@ -251,7 +251,7 @@
 	loff_t pos = filp->f_pos;
 	struct inode *inode = filp->f_dentry->d_inode;
 	struct super_block *sb = inode->i_sb;
-	unsigned offset = pos & ~PAGE_CACHE_MASK;
+	unsigned int offset = pos & ~PAGE_CACHE_MASK;
 	unsigned long n = pos >> PAGE_CACHE_SHIFT;
 	unsigned long npages = dir_pages(inode);
 	unsigned chunk_mask = ~(ext2_chunk_size(inode)-1);
@@ -270,8 +270,13 @@
 		ext2_dirent *de;
 		struct page *page = ext2_get_page(inode, n);
 
-		if (IS_ERR(page))
+		if (IS_ERR(page)) {
+			ext2_error(sb, __FUNCTION__,
+				   "bad page in #%lu",
+				   inode->i_ino);
+			filp->f_pos += PAGE_CACHE_SIZE - offset;
 			continue;
+		}
 		kaddr = page_address(page);
 		if (need_revalidate) {
 			offset = ext2_validate_entry(kaddr, offset, chunk_mask);
@@ -303,6 +308,7 @@
 					goto success;
 				}
 			}
+			filp->f_pos += le16_to_cpu(de->rec_len);
 		}
 		ext2_put_page(page);
 	}
@@ -310,7 +316,6 @@
 success:
 	ret = 0;
 done:
-	filp->f_pos = (n << PAGE_CACHE_SHIFT) | offset;
 	filp->f_version = inode->i_version;
 	return ret;
 }

--------------080309030908090303000102--
