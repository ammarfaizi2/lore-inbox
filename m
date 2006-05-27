Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751610AbWE0P6L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751610AbWE0P6L (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 May 2006 11:58:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751608AbWE0PwG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 May 2006 11:52:06 -0400
Received: from smtp.ustc.edu.cn ([202.38.64.16]:16861 "HELO ustc.edu.cn")
	by vger.kernel.org with SMTP id S1751610AbWE0Pvm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 May 2006 11:51:42 -0400
Message-ID: <348745099.16246@ustc.edu.cn>
X-EYOUMAIL-SMTPAUTH: wfg@mail.ustc.edu.cn
Message-Id: <20060527155140.035991503@localhost.localdomain>
References: <20060527154849.927021763@localhost.localdomain>
Date: Sat, 27 May 2006 23:49:16 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Wu Fengguang <wfg@mail.ustc.edu.cn>
Subject: [PATCH 27/32] readahead: loop case
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

--- linux-2.6.17-rc4-mm3.orig/drivers/block/loop.c
+++ linux-2.6.17-rc4-mm3/drivers/block/loop.c
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
