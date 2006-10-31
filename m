Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423666AbWJaVwV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423666AbWJaVwV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 16:52:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423670AbWJaVwV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 16:52:21 -0500
Received: from nf-out-0910.google.com ([64.233.182.185]:14610 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1423666AbWJaVwV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 16:52:21 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=B8paefeQjP6cnOr4tIgamYvK/c/qkpLmzNRk5ahXMYx3hwTfDchu8/bnAaU2T5oOb+oRoCB6jlMINXuj6FSM86bMuXhPhnC4CiQOLlpf6ONhdBLObe3ZrBfu7XbTTWbAxv3uStlQHl3mucmfgY4f0R8EhAueDfgjZCPgmAEzlMs=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH][RFC] potential NULL pointer deref in XFS on failed mount
Date: Tue, 31 Oct 2006 22:54:00 +0100
User-Agent: KMail/1.9.4
Cc: xfs@oss.sgi.com, xfs-masters@oss.sgi.com, nathans@sgi.com,
       Jesper Juhl <jesper.juhl@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610312254.00320.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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


