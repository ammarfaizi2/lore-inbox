Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161041AbWHDFsq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161041AbWHDFsq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 01:48:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030341AbWHDFoy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 01:44:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:7344 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1030319AbWHDFol (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 01:44:41 -0400
Date: Thu, 3 Aug 2006 22:40:03 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org, torvalds@osdl.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, pbadari@us.ibm.com,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 15/23] ext3 -nobh option causes oops
Message-ID: <20060804054003.GP769@kroah.com>
References: <20060804053258.391158155@quad.kroah.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="ext3-nobh-option-causes-oops.patch"
In-Reply-To: <20060804053807.GA769@kroah.com>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------
From: Badari Pulavarty <pbadari@us.ibm.com>

For files other than IFREG, nobh option doesn't make sense.  Modifications
to them are journalled and needs buffer heads to do that.  Without this
patch, we get kernel oops in page_buffers().

Signed-off-by: Badari Pulavarty <pbadari@us.ibm.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 fs/ext3/inode.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- linux-2.6.17.7.orig/fs/ext3/inode.c
+++ linux-2.6.17.7/fs/ext3/inode.c
@@ -1159,7 +1159,7 @@ retry:
 		ret = PTR_ERR(handle);
 		goto out;
 	}
-	if (test_opt(inode->i_sb, NOBH))
+	if (test_opt(inode->i_sb, NOBH) && ext3_should_writeback_data(inode))
 		ret = nobh_prepare_write(page, from, to, ext3_get_block);
 	else
 		ret = block_prepare_write(page, from, to, ext3_get_block);
@@ -1245,7 +1245,7 @@ static int ext3_writeback_commit_write(s
 	if (new_i_size > EXT3_I(inode)->i_disksize)
 		EXT3_I(inode)->i_disksize = new_i_size;
 
-	if (test_opt(inode->i_sb, NOBH))
+	if (test_opt(inode->i_sb, NOBH) && ext3_should_writeback_data(inode))
 		ret = nobh_commit_write(file, page, from, to);
 	else
 		ret = generic_commit_write(file, page, from, to);
@@ -1495,7 +1495,7 @@ static int ext3_writeback_writepage(stru
 		goto out_fail;
 	}
 
-	if (test_opt(inode->i_sb, NOBH))
+	if (test_opt(inode->i_sb, NOBH) && ext3_should_writeback_data(inode))
 		ret = nobh_writepage(page, ext3_get_block, wbc);
 	else
 		ret = block_write_full_page(page, ext3_get_block, wbc);

--
