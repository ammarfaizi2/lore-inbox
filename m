Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263171AbTFGMY2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jun 2003 08:24:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263176AbTFGMY2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jun 2003 08:24:28 -0400
Received: from smtp03.web.de ([217.72.192.158]:43788 "EHLO smtp.web.de")
	by vger.kernel.org with ESMTP id S263171AbTFGMY1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jun 2003 08:24:27 -0400
Date: Sat, 7 Jun 2003 14:55:32 +0200
From: =?ISO-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
Subject: [PATCH] hugetlbfs: fix error reporting in case of invalid mount
 options
Message-Id: <20030607145532.2bc66f38.l.s.r@web.de>
X-Mailer: Sylpheed version 0.9.1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

there is not much point in trying to print the mount options after
hugetlbfs_parse_options() went over them.

Since it employs strsep(), it cuts the option string into pieces by
replacing all commas with NUL characters. A following printk() will
always show the first option, only, which could be confusing.

The patch below changes hugetlbfs to not try to echo the string of
mount options in case of an error at all. It wouldn't tell us anything
we didn't know before, anyway.

René



diff -u ./fs/hugetlbfs/inode.c~ ./fs/hugetlbfs/inode.c
--- ./fs/hugetlbfs/inode.c~	2003-06-07 14:21:29.000000000 +0200
+++ ./fs/hugetlbfs/inode.c	2003-06-07 14:21:49.000000000 +0200
@@ -525,7 +525,7 @@
 
 	ret = hugetlbfs_parse_options(data, &config);
 	if (ret) {
-		printk("hugetlbfs: invalid mount options: %s.\n", data);
+		printk(KERN_ERR "hugetlbfs: invalid mount options.\n");
 		return ret;
 	}
 	sb->s_blocksize = PAGE_CACHE_SIZE;


