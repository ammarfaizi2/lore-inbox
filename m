Return-Path: <linux-kernel-owner+w=401wt.eu-S1751116AbXAFCbD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751116AbXAFCbD (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 21:31:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751129AbXAFCbB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 21:31:01 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:36680 "EHLO
	sous-sol.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751125AbXAFCaz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 21:30:55 -0500
Message-Id: <20070106023439.390678000@sous-sol.org>
References: <20070106022753.334962000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Fri, 05 Jan 2007 18:28:24 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, Daniel Drake <dsd@gentoo.org>,
       phillip@lougher.org.uk
Subject: [patch 31/50] corrupted cramfs filesystems cause kernel oops (CVE-2006-5823)
Content-Disposition: inline; filename=corrupted-cramfs-filesystems-cause-kernel-oops.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

From: Phillip Lougher <phillip@lougher.org.uk>

Steve Grubb's fzfuzzer tool (http://people.redhat.com/sgrubb/files/
fsfuzzer-0.6.tar.gz) generates corrupt Cramfs filesystems which cause
Cramfs to kernel oops in cramfs_uncompress_block().  The cause of the oops
is an unchecked corrupted block length field read by cramfs_readpage().

This patch adds a sanity check to cramfs_readpage() which checks that the
block length field is sensible.  The (PAGE_CACHE_SIZE << 1) size check is
intentional, even though the uncompressed data is not going to be larger
than PAGE_CACHE_SIZE, gzip sometimes generates compressed data larger than
the original source data.  Mkcramfs checks that the compressed size is
always less than or equal to PAGE_CACHE_SIZE << 1.  Of course Cramfs could
use the original uncompressed data in this case, but it doesn't.

Signed-off-by: Phillip Lougher <phillip@lougher.org.uk>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Linus Torvalds <torvalds@osdl.org>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---
Date: Thu, 7 Dec 2006 04:37:20 +0000 (-0800)
Subject: [patch 31/50] [PATCH] corrupted cramfs filesystems cause kernel oops
X-Git-Tag: v2.6.20-rc1
X-Git-Url: http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=8bb0269160df2a60764013994d0bc5165406cf4a

 fs/cramfs/inode.c |    2 ++
 1 file changed, 2 insertions(+)

--- linux-2.6.19.1.orig/fs/cramfs/inode.c
+++ linux-2.6.19.1/fs/cramfs/inode.c
@@ -481,6 +481,8 @@ static int cramfs_readpage(struct file *
 		pgdata = kmap(page);
 		if (compr_len == 0)
 			; /* hole */
+		else if (compr_len > (PAGE_CACHE_SIZE << 1))
+			printk(KERN_ERR "cramfs: bad compressed blocksize %u\n", compr_len);
 		else {
 			mutex_lock(&read_mutex);
 			bytes_filled = cramfs_uncompress_block(pgdata,

--
