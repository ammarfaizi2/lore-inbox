Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933584AbWKWK5O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933584AbWKWK5O (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Nov 2006 05:57:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933590AbWKWK5O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Nov 2006 05:57:14 -0500
Received: from pfx2.jmh.fr ([194.153.89.55]:25008 "EHLO pfx2.jmh.fr")
	by vger.kernel.org with ESMTP id S933584AbWKWK5N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Nov 2006 05:57:13 -0500
From: Eric Dumazet <dada1@cosmosbay.com>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH] fs : reorder some 'struct inode' fields to speedup i_size manipulations
Date: Thu, 23 Nov 2006 11:57:29 +0100
User-Agent: KMail/1.9.5
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Daniel McNeil <daniel@osdl.org>
References: <20061120151700.4a4f9407@frecb000686> <20061123092805.1408b0c6@frecb000686> <20061123004053.76114a75.akpm@osdl.org>
In-Reply-To: <20061123004053.76114a75.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_Z6XZF9ew/6xXyvN"
Message-Id: <200611231157.30056.dada1@cosmosbay.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_Z6XZF9ew/6xXyvN
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On 32bits SMP platforms, 64bits i_size is protected by a seqcount 
(i_size_seqcount).

When i_size is read or written, i_size_seqcount is read/written as well, so it 
make sense to group these two fields together in the same cache line.

Before this patch, accessing i_size needed 3 cache lines (2 for i_size, one 
for i_size_seqcount). After, only one cache line is needed/ (dirtied on a 
i_size change).

This patch moves i_size_seqcount next to i_size, and also moves i_version to 
let offsetof(struct inode, i_size) being 0x40 instead of 0x3c (for 32bits 
platforms). 

For 64 bits platforms, i_size_seqcount doesnt exist, and the move of a 'long 
i_version' should not introduce a new hole because of padding.

Signed-off-by: Eric Dumazet <dada1@cosmosbay.com>

--Boundary-00=_Z6XZF9ew/6xXyvN
Content-Type: text/plain;
  charset="iso-8859-1";
  name="move_i_size_seqcount.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="move_i_size_seqcount.patch"

--- linux-2.6.19-rc6/include/linux/fs.h	2006-11-23 10:47:53.000000000 +0100
+++ linux-2.6.19-rc6-ed/include/linux/fs.h	2006-11-23 11:13:36.000000000 +0100
@@ -548,12 +548,15 @@ struct inode {
 	uid_t			i_uid;
 	gid_t			i_gid;
 	dev_t			i_rdev;
+	unsigned long		i_version;
 	loff_t			i_size;
+#ifdef __NEED_I_SIZE_ORDERED
+	seqcount_t		i_size_seqcount;
+#endif
 	struct timespec		i_atime;
 	struct timespec		i_mtime;
 	struct timespec		i_ctime;
 	unsigned int		i_blkbits;
-	unsigned long		i_version;
 	blkcnt_t		i_blocks;
 	unsigned short          i_bytes;
 	spinlock_t		i_lock;	/* i_blocks, i_bytes, maybe i_size */
@@ -598,9 +601,6 @@ struct inode {
 	void			*i_security;
 #endif
 	void			*i_private; /* fs or device private pointer */
-#ifdef __NEED_I_SIZE_ORDERED
-	seqcount_t		i_size_seqcount;
-#endif
 };
 
 /*

--Boundary-00=_Z6XZF9ew/6xXyvN--
