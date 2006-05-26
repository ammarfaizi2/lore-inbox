Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932453AbWEZLzw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932453AbWEZLzw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 07:55:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932460AbWEZLxg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 07:53:36 -0400
Received: from smtp.ustc.edu.cn ([202.38.64.16]:11483 "HELO ustc.edu.cn")
	by vger.kernel.org with SMTP id S932450AbWEZLxN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 07:53:13 -0400
Message-ID: <348644390.06434@ustc.edu.cn>
X-EYOUMAIL-SMTPAUTH: wfg@mail.ustc.edu.cn
Message-Id: <20060526115315.823465555@localhost.localdomain>
References: <20060526113906.084341801@localhost.localdomain>
Date: Fri, 26 May 2006 19:39:34 +0800
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
