Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263609AbUAYEtz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jan 2004 23:49:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263618AbUAYEtz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jan 2004 23:49:55 -0500
Received: from dsl081-085-091.lax1.dsl.speakeasy.net ([64.81.85.91]:6786 "EHLO
	mrhankey.megahappy.net") by vger.kernel.org with ESMTP
	id S263609AbUAYEty (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jan 2004 23:49:54 -0500
To: nathans@sgi.com
Subject: [PATCH 2.6.2-rc1-mm3] fs/xfs/xfs_log_recover.c
Cc: linux-kernel@vger.kernel.org
Message-Id: <20040125044859.8A67F13A354@mrhankey.megahappy.net>
Date: Sat, 24 Jan 2004 20:48:59 -0800 (PST)
From: driver@megahappy.net (Bryan Whitehead)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On compile I get this:

fs/xfs/xfs_log_recover.c: In function `xlog_recover_reorder_trans':
fs/xfs/xfs_log_recover.c:1534: warning: `flags' might be used uninitialized in this function

I previously sent this patch and it was wrong.

In the function xlog_recover_reorder_trans the comiler thinks that "flags" might be used uninitialized. This will never happen as the first switch statement takes care of giving flags a value for all CASE statements that will use the flags variable later in the function. To get rid of the warning, flags needs to start off with an initial value. The previous patch merged the 2 switch statements but that would have broken the XFS_LI_BUF case as flags would be overwritten in the XFS_LI_5_3_BUF case.

This patch keeps the same functionality but removes the warning the compiler generates.

--- fs/xfs/xfs_log_recover.c.orig       2004-01-24 20:16:15.726073560 -0800
+++ fs/xfs/xfs_log_recover.c    2004-01-24 20:33:02.720987064 -0800
@@ -1531,7 +1531,7 @@ xlog_recover_reorder_trans(
        xlog_recover_item_t     *first_item, *itemq, *itemq_next;
        xfs_buf_log_format_t    *buf_f;
        xfs_buf_log_format_v1_t *obuf_f;
-       ushort                  flags;
+       ushort                  flags = 0;
                                                                                                             
        first_item = itemq = trans->r_itemq;
        trans->r_itemq = NULL;

--
Bryan Whitehead
driver@megahappy.net
