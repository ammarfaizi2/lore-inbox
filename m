Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751376AbWCSCmx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751376AbWCSCmx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Mar 2006 21:42:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751291AbWCSCls
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Mar 2006 21:41:48 -0500
Received: from ns.ustc.edu.cn ([202.38.64.1]:43202 "EHLO mx1.ustc.edu.cn")
	by vger.kernel.org with ESMTP id S1751289AbWCSCef (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Mar 2006 21:34:35 -0500
Message-Id: <20060319023458.060047000@localhost.localdomain>
References: <20060319023413.305977000@localhost.localdomain>
Date: Sun, 19 Mar 2006 10:34:32 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Wu Fengguang <wfg@mail.ustc.edu.cn>
Subject: [PATCH 19/23] readahead: loop case
Content-Disposition: inline; filename=readahead-loop-case.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Disable look-ahead for loop file.

Loopback files normally contain filesystems, in which case there are already
proper look-aheads in the upper layer, more look-aheads on the loopback file
only ruins the read-ahead hit rate.

Signed-off-by: Wu Fengguang <wfg@mail.ustc.edu.cn>
---

I'd like to thank Tero Grundstr?m for uncovering the loopback problem.

 drivers/block/loop.c |    6 ++++++
 1 files changed, 6 insertions(+)

--- linux-2.6.16-rc6-mm2.orig/drivers/block/loop.c
+++ linux-2.6.16-rc6-mm2/drivers/block/loop.c
@@ -779,6 +779,12 @@ static int loop_set_fd(struct loop_devic
 	mapping = file->f_mapping;
 	inode = mapping->host;
 
+	/*
+	 * The upper layer should already do proper look-ahead,
+	 * one more look-ahead here only ruins the cache hit rate.
+	 */
+	file->f_ra.flags |= RA_FLAG_NO_LOOKAHEAD;
+
 	if (!(file->f_mode & FMODE_WRITE))
 		lo_flags |= LO_FLAGS_READ_ONLY;
 

--
