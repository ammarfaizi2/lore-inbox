Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261761AbVBSSGx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261761AbVBSSGx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Feb 2005 13:06:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261766AbVBSSGw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Feb 2005 13:06:52 -0500
Received: from [83.102.214.158] ([83.102.214.158]:56012 "EHLO gw.home.net")
	by vger.kernel.org with ESMTP id S261761AbVBSSGd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Feb 2005 13:06:33 -0500
To: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org,
       alex@clusterfs.com
Subject: Re: [RFC] pdirops: tmpfs patch
References: <m34qg84em2.fsf@bzzz.home.net>
From: Alex Tomas <alex@clusterfs.com>
Organization: ClusterFS Inc.
Date: Sat, 19 Feb 2005 21:05:12 +0300
In-Reply-To: <m34qg84em2.fsf@bzzz.home.net> (Alex Tomas's message of "Sat,
 19 Feb 2005 20:57:25 +0300")
Message-ID: <m3vf8o2zon.fsf@bzzz.home.net>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Index: linux-2.6.10/mm/shmem.c
===================================================================
--- linux-2.6.10.orig/mm/shmem.c	2005-01-28 19:32:16.000000000 +0300
+++ linux-2.6.10/mm/shmem.c	2005-02-19 20:05:32.642599576 +0300
@@ -1849,7 +1849,7 @@
 #endif
 };
 
-static int shmem_parse_options(char *options, int *mode, uid_t *uid, gid_t *gid, unsigned long *blocks, unsigned long *inodes)
+static int shmem_parse_options(char *options, int *mode, uid_t *uid, gid_t *gid, unsigned long *blocks, unsigned long *inodes, struct super_block *sb)
 {
 	char *this_char, *value, *rest;
 
@@ -1858,6 +1858,9 @@
 			continue;
 		if ((value = strchr(this_char,'=')) != NULL) {
 			*value++ = 0;
+		} else if (!strcmp(this_char,"pdirops")) {
+			sb->s_flags |= S_PDIROPS;
+			continue;
 		} else {
 			printk(KERN_ERR
 			    "tmpfs: No value for mount option '%s'\n",
@@ -1928,7 +1931,7 @@
 		max_blocks = sbinfo->max_blocks;
 		max_inodes = sbinfo->max_inodes;
 	}
-	if (shmem_parse_options(data, NULL, NULL, NULL, &max_blocks, &max_inodes))
+	if (shmem_parse_options(data, NULL, NULL, NULL, &max_blocks, &max_inodes, sb))
 		return -EINVAL;
 	/* Keep it simple: disallow limited <-> unlimited remount */
 	if ((max_blocks || max_inodes) == !sbinfo)
@@ -1978,7 +1981,7 @@
 			inodes = blocks;
 
 		if (shmem_parse_options(data, &mode,
-					&uid, &gid, &blocks, &inodes))
+					&uid, &gid, &blocks, &inodes, sb))
 			return -EINVAL;
 	}
 

