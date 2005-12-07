Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751041AbVLGNNh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751041AbVLGNNh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 08:13:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751046AbVLGNNg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 08:13:36 -0500
Received: from courier.cs.helsinki.fi ([128.214.9.1]:35782 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP
	id S1751041AbVLGNNg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 08:13:36 -0500
Date: Wed, 7 Dec 2005 15:13:28 +0200 (EET)
From: Pekka J Enberg <penberg@cs.Helsinki.FI>
To: Andreas Dilger <adilger@clusterfs.com>
cc: akpm@osdl.org, linux-kernel@vger.kernel.org, sct@redhat.com
Subject: Re: [PATCH] ext3: return FSID for statvfs
In-Reply-To: <20051207124043.GD14509@schatzie.adilger.int>
Message-ID: <Pine.LNX.4.58.0512071512170.21616@sbz-30.cs.Helsinki.FI>
References: <1133900600.3279.7.camel@localhost> <20051207124043.GD14509@schatzie.adilger.int>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andreas,

On Wed, 7 Dec 2005, Andreas Dilger wrote:
> The bug mentions some reasons why this patch is sub-optimal - namely that
> the beginning of the UUID has common fields in it.  It may make more sense
> to e.g. XOR the first 2 * u32 with the last 2 * u32 to reduce the chance
> of an FSID collision.
> 
> Also, there is a tiny memory of a security issue with exposing the FSID
> to applications (something to do with NFS and guessing filehandles or
> similar).  I have no idea if that is even relevant any longer, but
> thought I'd mention it.

Something like this?

This patch changes ext3_statfs() to return a FSID based on 64 bit XOR of the
128 bit filesystem UUID as suggested by Andreas Dilger. This patch is partial
fix for Bugzilla Bug <http://bugzilla.kernel.org/show_bug.cgi?id=136>.

Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>
---

 super.c |    5 +++++
 1 file changed, 5 insertions(+)

Index: 2.6/fs/ext3/super.c
===================================================================
--- 2.6.orig/fs/ext3/super.c
+++ 2.6/fs/ext3/super.c
@@ -2294,6 +2294,7 @@ static int ext3_statfs (struct super_blo
 	struct ext3_super_block *es = EXT3_SB(sb)->s_es;
 	unsigned long overhead;
 	int i;
+	u64 fsid;
 
 	if (test_opt (sb, MINIX_DF))
 		overhead = 0;
@@ -2340,6 +2341,10 @@ static int ext3_statfs (struct super_blo
 	buf->f_files = le32_to_cpu(es->s_inodes_count);
 	buf->f_ffree = ext3_count_free_inodes (sb);
 	buf->f_namelen = EXT3_NAME_LEN;
+	fsid = le64_to_cpup((void *)es->s_uuid) ^
+	       le64_to_cpup((void *)es->s_uuid + sizeof(u64));
+	buf->f_fsid.val[0] = fsid & 0xFFFFFFFFUL;
+	buf->f_fsid.val[1] = (fsid >> 32) & 0xFFFFFFFFUL;
 	return 0;
 }
 
