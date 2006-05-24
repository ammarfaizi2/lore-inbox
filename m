Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932709AbWEXLW3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932709AbWEXLW3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 07:22:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932704AbWEXLTr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 07:19:47 -0400
Received: from smtp.ustc.edu.cn ([202.38.64.16]:17538 "HELO ustc.edu.cn")
	by vger.kernel.org with SMTP id S932688AbWEXLTM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 May 2006 07:19:12 -0400
Message-ID: <348469549.07101@ustc.edu.cn>
X-EYOUMAIL-SMTPAUTH: wfg@mail.ustc.edu.cn
Message-Id: <20060524111911.032100160@localhost.localdomain>
References: <20060524111246.420010595@localhost.localdomain>
Date: Wed, 24 May 2006 19:13:14 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Wu Fengguang <wfg@mail.ustc.edu.cn>
Subject: [PATCH 28/33] readahead: loop case
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
