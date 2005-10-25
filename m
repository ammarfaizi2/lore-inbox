Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751170AbVJYNGg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751170AbVJYNGg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Oct 2005 09:06:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751188AbVJYNGg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Oct 2005 09:06:36 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:24806 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S1751170AbVJYNGg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Oct 2005 09:06:36 -0400
Message-ID: <435E2DBE.70901@namesys.com>
Date: Tue, 25 Oct 2005 17:06:06 +0400
From: "Vladimir V. Saveliev" <vs@namesys.com>
Organization: Namesys
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050511
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>, andrea@suse.de
CC: LKML <linux-kernel@vger.kernel.org>
Subject: fix-nr_unused-accounting-and-avoid-recursing-in-iput-with-i_will_free-set.patch
X-Enigmail-Version: 0.91.0.0
Content-Type: multipart/mixed;
 boundary="------------050208090305070908080406"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050208090305070908080406
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hello

The patch mentioned in the subject checks I_WILL_FREE bit in inode->i_flags,
while generic_forget_inode sets it in inode->i_state.
Is it really supposed to be so?
If not, does the attached patch look correct?

--------------050208090305070908080406
Content-Type: text/plain;
 name="writeback_single_inode-warn-fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="writeback_single_inode-warn-fix.patch"


generic_forget_inode sets I_WILL_FREE bit in inode->i_state.
__writeback_single_inode checks that bit in inode->i_flags.
This patch changes __writeback_single_inode to check inode->i_state.


 fs/fs-writeback.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff -puN fs/fs-writeback.c~writeback_single_inode-warn-fix fs/fs-writeback.c
--- linux-2.6.14-rc5-mm1/fs/fs-writeback.c~writeback_single_inode-warn-fix	2005-10-25 15:52:13.857616000 +0400
+++ linux-2.6.14-rc5-mm1-root/fs/fs-writeback.c	2005-10-25 15:52:37.051065500 +0400
@@ -248,9 +248,9 @@ __writeback_single_inode(struct inode *i
 	wait_queue_head_t *wqh;
 
 	if (!atomic_read(&inode->i_count))
-		WARN_ON(!(inode->i_flags & I_WILL_FREE));
+		WARN_ON(!(inode->i_state & I_WILL_FREE));
 	else
-		WARN_ON(inode->i_flags & I_WILL_FREE);
+		WARN_ON(inode->i_state & I_WILL_FREE);
 
 	if ((wbc->sync_mode != WB_SYNC_ALL) && (inode->i_state & I_LOCK)) {
 		list_move(&inode->i_list, &inode->i_sb->s_dirty);

_

--------------050208090305070908080406--
