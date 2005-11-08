Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750821AbVKHETs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750821AbVKHETs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 23:19:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750877AbVKHETr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 23:19:47 -0500
Received: from smtp.osdl.org ([65.172.181.4]:4766 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750821AbVKHETq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 23:19:46 -0500
Date: Mon, 7 Nov 2005 20:19:34 -0800
From: Andrew Morton <akpm@osdl.org>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/6] fat: Support a truncate() for expanding size
Message-Id: <20051107201934.4c01a472.akpm@osdl.org>
In-Reply-To: <87ek5rx1ur.fsf@devron.myhome.or.jp>
References: <87hdaotlci.fsf@devron.myhome.or.jp>
	<87d5lctl5y.fsf@devron.myhome.or.jp>
	<878xw0tl3r.fsf_-_@devron.myhome.or.jp>
	<874q6otl0q.fsf_-_@devron.myhome.or.jp>
	<87zmogs6cs.fsf_-_@devron.myhome.or.jp>
	<87vez4s6b7.fsf_-_@devron.myhome.or.jp>
	<87r79ss658.fsf_-_@devron.myhome.or.jp>
	<20051107170626.4d08e8d6.akpm@osdl.org>
	<87ek5rx1ur.fsf@devron.myhome.or.jp>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OGAWA Hirofumi <hirofumi@mail.parknet.co.jp> wrote:
>
> Andrew Morton <akpm@osdl.org> writes:
> 
> > OGAWA Hirofumi <hirofumi@mail.parknet.co.jp> wrote:
> >>
> >> +static int fat_cont_expand(struct inode *inode, loff_t size)
> >
> > Is it not possible to extend generic_cont_expand() so that fatfs can use it?
> 
> The generic_cont_expand() is too generic.

But can it be fixed??

> If "size" is block boundary, generic_cont_expand() expands the
> ->i_size to "size + 1", after it, the caller of it will truncate to
> "size" by vmtruncate().

Something like this?

--- devel/fs/buffer.c~a	2005-11-07 20:17:49.000000000 -0800
+++ devel-akpm/fs/buffer.c	2005-11-07 20:18:59.000000000 -0800
@@ -2160,7 +2160,7 @@ int block_read_full_page(struct page *pa
  * truncates.  Uses prepare/commit_write to allow the filesystem to
  * deal with the hole.  
  */
-int generic_cont_expand(struct inode *inode, loff_t size)
+static int __generic_cont_expand(struct inode *inode, loff_t size, int dont_do_that)
 {
 	struct address_space *mapping = inode->i_mapping;
 	struct page *page;
@@ -2182,9 +2182,8 @@ int generic_cont_expand(struct inode *in
 	** skip the prepare.  make sure we never send an offset for the start
 	** of a block
 	*/
-	if ((offset & (inode->i_sb->s_blocksize - 1)) == 0) {
+	if (!dont_do_that &&  (offset & (inode->i_sb->s_blocksize - 1)) == 0)
 		offset++;
-	}
 	index = size >> PAGE_CACHE_SHIFT;
 	err = -ENOMEM;
 	page = grab_cache_page(mapping, index);
@@ -2202,6 +2201,16 @@ out:
 	return err;
 }
 
+int generic_cont_expand(struct inode *inode, loff_t size)
+{
+	return __generic_cont_expand(inode, size, 0);
+}
+
+int generic_cont_expand_dont_do_that(struct inode *inode, loff_t size)
+{
+	return __generic_cont_expand(inode, size, 1);
+}
+
 /*
  * For moronic filesystems that do not allow holes in file.
  * We may have to extend the file.
_

