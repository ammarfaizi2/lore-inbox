Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030362AbWFCXYx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030362AbWFCXYx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jun 2006 19:24:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030364AbWFCXYx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jun 2006 19:24:53 -0400
Received: from wr-out-0506.google.com ([64.233.184.239]:51262 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1030362AbWFCXYx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jun 2006 19:24:53 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=Av5FfcHpJ7x42aUIQJGIZo5M7GKzfIs8VYZ37A6wHCmVU+eATAEgrZaLkOd4djnc6Xt+xUXmclc6yl9b+BK4lzvMEWoWunoQQXMI6GRR+aYf9eDRGSm8fZAzpSGrjAe96Vv/KI9uoGXNCLVE2G0WVCax3OwsEgJ/BZVfp+yFUZ4=
Message-ID: <44821B82.1040406@gmail.com>
Date: Sat, 03 Jun 2006 19:30:10 -0400
From: Florin Malita <fmalita@gmail.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Alexey Dobriyan <adobriyan@gmail.com>
CC: mark.fasheh@oracle.com, kurt.hackel@oracle.com,
       linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] ocfs2: dereference before NULL check in ocfs2_direct_IO_get_blocks()
References: <4481AC0F.6040805@gmail.com> <20060603191558.GA7268@martell.zuzino.mipt.ru>
In-Reply-To: <20060603191558.GA7268@martell.zuzino.mipt.ru>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexey Dobriyan wrote:
> AFAICS, the patch is BS, as usual with this type of patches.
>   
You missed the full purpose: the patch makes a function consistent about
its own assumptions (but leaves them in place since they're on the
better-safe-than-sorry side). It addresses assumptions inconsistency
(confusing for both human readers and static analysis tools) just as
much as it addresses a possible bug. Regardless of whether "inode" &
"bh_result" can be NULL, I don't think the following is OK (coding-wise):

	unsigned long max_blocks = bh_result->b_size >> inode->i_blkbits;

	if (!inode || !bh_result) {
		mlog(ML_ERROR, "inode or bh_result is null\n");
		return -EIO;
	}


> Can "inode" and "bh_result" be NULL here? I bet they can't
Great, then the NULL branch is dead code and we can fix consistency
differently:

Signed-off-by: Florin Malita <fmalita@gmail.com>
---

 fs/ocfs2/aops.c |    9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/fs/ocfs2/aops.c b/fs/ocfs2/aops.c
index 47152bf..370c241 100644
--- a/fs/ocfs2/aops.c
+++ b/fs/ocfs2/aops.c
@@ -558,16 +558,9 @@ static int ocfs2_direct_IO_get_blocks(st
 	u64 vbo_max; /* file offset, max_blocks from iblock */
 	u64 p_blkno;
 	int contig_blocks;
-	unsigned char blocksize_bits;
+	unsigned char blocksize_bits = inode->i_sb->s_blocksize_bits;
 	unsigned long max_blocks = bh_result->b_size >> inode->i_blkbits;
 
-	if (!inode || !bh_result) {
-		mlog(ML_ERROR, "inode or bh_result is null\n");
-		return -EIO;
-	}
-
-	blocksize_bits = inode->i_sb->s_blocksize_bits;
-
 	/* This function won't even be called if the request isn't all
 	 * nicely aligned and of the right size, so there's no need
 	 * for us to check any of that. */


