Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751100AbWFLUuk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751100AbWFLUuk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 16:50:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751099AbWFLUuk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 16:50:40 -0400
Received: from silver.veritas.com ([143.127.12.111]:12144 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S1751085AbWFLUuj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 16:50:39 -0400
X-BrightmailFiltered: true
X-Brightmail-Tracker: AAAAAA==
X-IronPort-AV: i="4.05,229,1146466800"; 
   d="scan'208"; a="39139845:sNHT21151800"
Date: Mon, 12 Jun 2006 21:50:25 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@blonde.wat.veritas.com
To: Linus Torvalds <torvalds@osdl.org>
cc: "Robin H. Johnson" <robbat2@gentoo.org>, Al Viro <viro@zeniv.linux.org.uk>,
       Andi Kleen <ak@suse.de>, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: [PATCH] tmpfs: time granularity fix for [acm]time going backwards
In-Reply-To: <Pine.LNX.4.64.0606122011020.18760@blonde.wat.veritas.com>
Message-ID: <Pine.LNX.4.64.0606122146090.23556@blonde.wat.veritas.com>
References: <20060611115421.GE26475@curie-int.vc.shawcable.net>
 <Pine.LNX.4.64.0606111833220.15060@blonde.wat.veritas.com>
 <20060612051001.GA18634@curie-int.vc.shawcable.net>
 <Pine.LNX.4.64.0606122011020.18760@blonde.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 12 Jun 2006 20:50:38.0988 (UTC) FILETIME=[DC8DA4C0:01C68E61]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Robin H. Johnson <robbat2@gentoo.org>

I noticed a strange behavior in a tmpfs file system the other day, while
building packages - occasionally, and seemingly at random, make decided to
rebuild a target. However, only on tmpfs.

A file would be created, and if checked, it had a sub-second timestamp.
However, after an utimes related call where sub-seconds should be set, they
were zeroed instead. In the case that a file was created, and utimes(...,NULL)
was used on it in the same second, the timestamp on the file moved backwards.

After some digging, I found that this was being caused by tmpfs not having a
time granularity set, thus inheriting the default 1 second granularity.

Hugh adds: yes, we missed tmpfs when the s_time_gran mods went into 2.6.11.
Unfortunately, the granularity of CURRENT_TIME, often used in filesystems,
does not match the default granularity set by alloc_super.  A few more such
discrepancies have been found, but this is the most important to fix now.

Signed-off-by: Robin H. Johnson <robbat2@gentoo.org>
Acked-by: Andi Kleen <ak@suse.de>
Signed-off-by: Hugh Dickins <hugh@veritas.com>
---
This patch should probably be included for 2.6.17, despite how long the
bug has been around. It's a one-liner, with no side-effects.

 mm/shmem.c |    1 +
 1 file changed, 1 insertion(+)

--- 2.6.17-rc6-git/mm/shmem.c
+++ linux/mm/shmem.c
@@ -2102,6 +2102,7 @@ static int shmem_fill_super(struct super
 	sb->s_blocksize_bits = PAGE_CACHE_SHIFT;
 	sb->s_magic = TMPFS_MAGIC;
 	sb->s_op = &shmem_ops;
+	sb->s_time_gran = 1;
 
 	inode = shmem_get_inode(sb, S_IFDIR | mode, 0);
 	if (!inode)
