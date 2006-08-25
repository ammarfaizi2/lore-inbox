Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422790AbWHYS3M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422790AbWHYS3M (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 14:29:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422787AbWHYSZY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 14:25:24 -0400
Received: from mx.pathscale.com ([64.160.42.68]:41346 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1422739AbWHYSZS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 14:25:18 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 5 of 23] IB/ipath - drop requirement that PIO buffers be
	mmaped write-only
X-Mercurial-Node: f57aaab357b7fb0c0c393cb523ae070448dec0d0
Message-Id: <f57aaab357b7fb0c0c39.1156530270@eng-12.pathscale.com>
In-Reply-To: <patchbomb.1156530265@eng-12.pathscale.com>
Date: Fri, 25 Aug 2006 11:24:30 -0700
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: rdreier@cisco.com
Cc: openib-general@openib.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some userlands try to mmap these pages read-write, so accommodate them.

Signed-off-by: Bryan O'Sullivan <bryan.osullivan@qlogic.com>

diff --git a/drivers/infiniband/hw/ipath/ipath_file_ops.c b/drivers/infiniband/hw/ipath/ipath_file_ops.c
--- a/drivers/infiniband/hw/ipath/ipath_file_ops.c	Fri Aug 25 11:19:44 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_file_ops.c	Fri Aug 25 11:19:44 2006 -0700
@@ -992,15 +992,10 @@ static int mmap_piobufs(struct vm_area_s
 	pgprot_val(vma->vm_page_prot) &= ~_PAGE_GUARDED;
 #endif
 
-	if (vma->vm_flags & VM_READ) {
-		dev_info(&dd->pcidev->dev,
-			 "Can't map piobufs as readable (flags=%lx)\n",
-			 vma->vm_flags);
-		ret = -EPERM;
-		goto bail;
-	}
-
-	/* don't allow them to later change to readable with mprotect */
+	/*
+	 * don't allow them to later change to readable with mprotect (for when
+	 * not initially mapped readable, as is normally the case)
+	 */
 	vma->vm_flags &= ~VM_MAYREAD;
 	vma->vm_flags |= VM_DONTCOPY | VM_DONTEXPAND;
 
