Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267618AbUIVBDw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267618AbUIVBDw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Sep 2004 21:03:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267638AbUIVBDw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Sep 2004 21:03:52 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:50935 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S267618AbUIVBDu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Sep 2004 21:03:50 -0400
Subject: [Patch] ext3_new_inode() failure case fix
From: Mingming Cao <cmm@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200409071302.i87D2Dus030892@sisko.scot.redhat.com>
References: <200409071302.i87D2Dus030892@sisko.scot.redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 21 Sep 2004 18:04:00 -0700
Message-Id: <1095815041.1637.32926.camel@w-ming2.beaverton.ibm.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While I am studying ext3_new_inode() failure code paths, I found the
inode->i_nlink is not cleared to 0 in the first failure path. But it is
cleared to 0 in the second failure path(fail to allocate disk quota). I
think it should be cleared in both cases, because later when
generic_drop_inode() is called by iput(), i_nlink is checked to decide
whether to call generic_delete_inode(). Currently it is calling
generic_forget_inode().

Also the reference to the inode bitmap buffer head should be dropped on
the failure path too.

Mingming

---

 linux-2.6.9-rc1-mm5-ming/fs/ext3/ialloc.c |    2 ++
 1 files changed, 2 insertions(+)

diff -puN fs/ext3/ialloc.c~ext3_new_inode_failure_case_fix fs/ext3/ialloc.c
--- linux-2.6.9-rc1-mm5/fs/ext3/ialloc.c~ext3_new_inode_failure_case_fix	2004-09-22 00:18:18.196012520 -0700
+++ linux-2.6.9-rc1-mm5-ming/fs/ext3/ialloc.c	2004-09-22 00:19:20.063607216 -0700
@@ -622,7 +622,9 @@ got:
 fail:
 	ext3_std_error(sb, err);
 out:
+	inode->i_nlink = 0;
 	iput(inode);
+	brelse(bitmap_bh);
 	ret = ERR_PTR(err);
 really_out:
 	brelse(bitmap_bh);

_

