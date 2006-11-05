Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965828AbWKEECG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965828AbWKEECG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Nov 2006 23:02:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965829AbWKEECG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Nov 2006 23:02:06 -0500
Received: from out-mta12.ai270.net ([83.244.130.52]:54209 "EHLO
	out-mta10.ai270.net") by vger.kernel.org with ESMTP id S965828AbWKEECF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Nov 2006 23:02:05 -0500
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <70103A46-EDED-41CF-876F-8CFDC344C5ED@lougher.org.uk>
Cc: akpm@osdl.org
Content-Transfer-Encoding: 7bit
From: Phillip Lougher <phillip@lougher.org.uk>
Subject: [PATCH] corrupted cramfs filesystems cause kernel oops
Date: Sun, 5 Nov 2006 04:02:00 +0000
To: linux-kernel@vger.kernel.org
X-Mailer: Apple Mail (2.752.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steve Grubb's fzfuzzer tool (http://people.redhat.com/sgrubb/files/ 
fsfuzzer-0.6.tar.gz) generates corrupt Cramfs filesystems which cause  
Cramfs to kernel oops in cramfs_uncompress_block().  The cause of the  
oops is an unchecked corrupted block length field read by  
cramfs_readpage().

This patch adds a sanity check to cramfs_readpage() which checks that  
the block length field is sensible.   The (PAGE_CACHE_SIZE << 1) size  
check is intentional, even though the uncompressed data is not going  
to be larger than PAGE_CACHE_SIZE, gzip sometimes generates  
compressed data larger than the original source data. Mkcramfs checks  
that the compressed size is always less than or equal to  
PAGE_CACHE_SIZE << 1.  Of course Cramfs could use the original  
uncompressed data in this case, but it doesn't.

Patch is against 2.6.19-rc4.

Signed-off-by:  Phillip Lougher <phillip <at> lougher.org.uk>

diff -Nurp a/fs/cramfs/inode.c b/fs/cramfs/inode.c
--- a/fs/cramfs/inode.c	2006-11-05 00:59:53.000000000 +0000
+++ b/fs/cramfs/inode.c	2006-11-05 03:17:43.000000000 +0000
@@ -481,6 +481,8 @@ static int cramfs_readpage(struct file *
		pgdata = kmap(page);
		if (compr_len == 0)
			; /* hole */
+		else if (compr_len > (PAGE_CACHE_SIZE << 1))
+			printk(KERN_ERR "cramfs: bad compressed blocksize %u\n", compr_len);
		else {
			mutex_lock(&read_mutex);
			bytes_filled = cramfs_uncompress_block(pgdata,


