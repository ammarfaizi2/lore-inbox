Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424555AbWKPVQh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424555AbWKPVQh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 16:16:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424633AbWKPVQh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 16:16:37 -0500
Received: from nf-out-0910.google.com ([64.233.182.186]:37585 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1424555AbWKPVQg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 16:16:36 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-disposition:message-id:content-type:content-transfer-encoding;
        b=owGlxAYCKFJQjKufbgM7OvuMvSpbh/Erq6DdBwixUti9DBOz94kkqcQBX7GxJcPHou4b44umMz1fSae/i9VkDInBsDjwHnmrQ0pDvyIj/BjvhO+hCkfzN2brIa9cC2FnLqlZxMXP6RhLT1anwcW+u8pTAiSZTaU5bTUGARU/3IA=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH][RFC][resend] potential NULL pointer deref in XFS on failed mount
Date: Thu, 16 Nov 2006 22:18:26 +0100
User-Agent: KMail/1.9.4
Cc: xfs@oss.sgi.com, xfs-masters@oss.sgi.com, nathans@sgi.com,
       Jesper Juhl <jesper.juhl@gmail.com>, Andrew Morton <akpm@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200611162218.26945.jesper.juhl@gmail.com>
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(got no reply on this when I originally send it on 20061031, so resending
 now that a bit of time has passed.  The patch still applies cleanly to
 Linus' git tree as of today.)


The Coverity checker spotted a potential problem in XFS.

The problem is that if, in xfs_mount(), this code triggers:

	...
	if (!mp->m_logdev_targp)
		goto error0;
	...

Then we'll end up calling xfs_unmountfs_close() with a NULL 
'mp->m_logdev_targp'. 
This in turn will result in a call to xfs_free_buftarg() with its 'btp' 
argument == NULL. xfs_free_buftarg() dereferences 'btp' leading to
a NULL pointer dereference and crash.

I think this can happen, since the fatal call to xfs_free_buftarg() 
happens when 'm_logdev_targp != m_ddev_targp' and due to a check of
'm_ddev_targp' against NULL in xfs_mount() (and subsequent return if it is 
NULL) the two will never both be NULL when we hit the error0 label from 
the two lines cited above.

Comments welcome (please keep me on Cc: on replies).

Here's a proposed patch to fix this by testing 'btp' against NULL in 
xfs_free_buftarg().


Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

 fs/xfs/linux-2.6/xfs_buf.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/fs/xfs/linux-2.6/xfs_buf.c b/fs/xfs/linux-2.6/xfs_buf.c
index db5f5a3..6ef1860 100644
--- a/fs/xfs/linux-2.6/xfs_buf.c
+++ b/fs/xfs/linux-2.6/xfs_buf.c
@@ -1450,6 +1450,9 @@ xfs_free_buftarg(
 	xfs_buftarg_t		*btp,
 	int			external)
 {
+	if (unlikely(!btp))
+		return;
+
 	xfs_flush_buftarg(btp, 1);
 	if (external)
 		xfs_blkdev_put(btp->bt_bdev);


