Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030187AbVJ1OLl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030187AbVJ1OLl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 10:11:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030194AbVJ1OLk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 10:11:40 -0400
Received: from mtagate1.de.ibm.com ([195.212.29.150]:50370 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP
	id S1030187AbVJ1OLj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 10:11:39 -0400
Date: Fri, 28 Oct 2005 16:11:45 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, cborntra@de.ibm.com, linux-kernel@vger.kernel.org
Subject: [patch 14/14] s390: fix memory leak in vmcp.
Message-ID: <20051028141145.GN7300@skybase.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christian Borntraeger <cborntra@de.ibm.com>

[patch 14/14] s390: fix memory leak in vmcp.

If vmcp is interrupted by a signal the vmcp command buffer is not
freed. Found by Pete Zaitcev.

Signed-off-by: Christian Borntraeger <cborntra@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/char/vmcp.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletion(-)

diff -urpN linux-2.6/drivers/s390/char/vmcp.c linux-2.6-patched/drivers/s390/char/vmcp.c
--- linux-2.6/drivers/s390/char/vmcp.c	2005-10-28 02:02:08.000000000 +0200
+++ linux-2.6-patched/drivers/s390/char/vmcp.c	2005-10-28 14:04:56.000000000 +0200
@@ -103,8 +103,10 @@ vmcp_write(struct file *file, const char
 	}
 	cmd[count] = '\0';
 	session = (struct vmcp_session *)file->private_data;
-	if (down_interruptible(&session->mutex))
+	if (down_interruptible(&session->mutex)) {
+		kfree(cmd);
 		return -ERESTARTSYS;
+	}
 	if (!session->response)
 		session->response = (char *)__get_free_pages(GFP_KERNEL
 						| __GFP_REPEAT 	| GFP_DMA,
