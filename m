Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030231AbWFTLuz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030231AbWFTLuz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 07:50:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030225AbWFTLuX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 07:50:23 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:39041 "EHLO
	sequoia.sous-sol.org") by vger.kernel.org with ESMTP
	id S1030227AbWFTLuU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 07:50:20 -0400
Message-Id: <20060620114722.456380000@sous-sol.org>
References: <20060620114527.934114000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Tue, 20 Jun 2006 00:00:06 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Hugh Dickins <hugh@veritas.com>,
       "Robin H. Johnson" <robbat2@gentoo.org>, Andi Kleen <ak@suse.de>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 06/13] tmpfs: time granularity fix for [acm]time going backwards
Content-Disposition: inline; filename=tmpfs-time-granularity-fix-for-time-going-backwards.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

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
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 mm/shmem.c |    1 +
 1 file changed, 1 insertion(+)

--- linux-2.6.16.21.orig/mm/shmem.c
+++ linux-2.6.16.21/mm/shmem.c
@@ -2100,6 +2100,7 @@ static int shmem_fill_super(struct super
 	sb->s_blocksize_bits = PAGE_CACHE_SHIFT;
 	sb->s_magic = TMPFS_MAGIC;
 	sb->s_op = &shmem_ops;
+	sb->s_time_gran = 1;
 
 	inode = shmem_get_inode(sb, S_IFDIR | mode, 0);
 	if (!inode)

--
