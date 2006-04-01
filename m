Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932287AbWDAVWf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932287AbWDAVWf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Apr 2006 16:22:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932288AbWDAVWf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Apr 2006 16:22:35 -0500
Received: from mail.parknet.jp ([210.171.160.80]:50184 "EHLO parknet.jp")
	by vger.kernel.org with ESMTP id S932287AbWDAVWe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Apr 2006 16:22:34 -0500
X-AuthUser: hirofumi@parknet.jp
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Don't pass offset == 0 && endbyte == 0 to do_sync_file_range()
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Sun, 02 Apr 2006 06:22:12 +0900
Message-ID: <87fykx0z5n.fsf@duaron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If user is specifying offset == 0 and nbytes == 1, current code uses
wbc->start == 0 && wbc->end == 0 to flush the range.

However, wbc->start == 0 && wbc->end == 0 is special range, not 0th page.
[If wbc->sync_mode == WB_SYNC_NODE, it uses prev offset.  Otherwise it
uses whole of file.]

It may confuse user, so, don't export that behavior to userland.

Signed-off-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
---

 fs/sync.c |   10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff -puN fs/sync.c~sync_file_range-fix fs/sync.c
--- linux-2.6/fs/sync.c~sync_file_range-fix	2006-04-02 06:20:52.000000000 +0900
+++ linux-2.6-hirofumi/fs/sync.c	2006-04-02 06:20:52.000000000 +0900
@@ -101,8 +101,14 @@ asmlinkage long sys_sync_file_range(int 
 
 	if (nbytes == 0)
 		endbyte = -1;
-	else
-		endbyte--;		/* inclusive */
+	else {
+		/*
+		 * wbc->start == 0 && wbc->end == 0 is a special range,
+		 * so this avoids using it.
+		 */
+		if (endbyte > 1)
+			endbyte--;		/* inclusive */
+	}
 
 	ret = -EBADF;
 	file = fget_light(fd, &fput_needed);
_
