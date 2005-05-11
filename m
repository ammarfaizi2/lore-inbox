Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261971AbVEKOeI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261971AbVEKOeI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 May 2005 10:34:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261975AbVEKOdF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 May 2005 10:33:05 -0400
Received: from mtagate3.de.ibm.com ([195.212.29.152]:30176 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP id S261968AbVEKOaj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 May 2005 10:30:39 -0400
Message-ID: <4282170B.8060907@de.ibm.com>
Date: Wed, 11 May 2005 16:30:35 +0200
From: Carsten Otte <cotte@de.ibm.com>
Reply-To: cotte@freenet.de
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: cotte@freenet.de
CC: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       schwidefsky@de.ibm.com, akpm@osdl.org
Subject: [RFC/PATCH 5/5] madvice/fadvice: add execute in place support
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[RFC/PATCH 5/5] madvice/fadvice: add execute in place support
This patch makes sys_madvice and sys_fadvice return 0 on advices to
cache data assoctiated with files that do have get_xip_page. Since the
data for those is in memory anyway, we can just ignore the advice...

Signed-off-by: Carsten Otte <cotte@de.ibm.com>
---
diff -ruN linux-2.6-git/mm/fadvise.c linux-2.6-git-xip/mm/fadvise.c
--- linux-2.6-git/mm/fadvise.c	2005-05-10 11:17:27.000000000 +0200
+++ linux-2.6-git-xip/mm/fadvise.c	2005-05-10 13:39:55.886811280 +0200
@@ -43,6 +43,10 @@
 		goto out;
 	}

+	if (mapping->a_ops->get_xip_page)
+		/* no bad return value, but ignore advice */
+		goto out;
+
 	/* Careful about overflows. Len == 0 means "as much as possible" */
 	endbyte = offset + len;
 	if (!len || endbyte < len)
diff -ruN linux-2.6-git/mm/madvise.c linux-2.6-git-xip/mm/madvise.c
--- linux-2.6-git/mm/madvise.c	2005-05-10 11:17:27.000000000 +0200
+++ linux-2.6-git-xip/mm/madvise.c	2005-05-10 13:39:55.894810064 +0200
@@ -65,6 +65,10 @@
 	if (!file)
 		return -EBADF;

+	if (file->f_mapping->a_ops->get_xip_page)
+		/* no bad return value, but ignore advice */
+		return 0;
+
 	start = ((start - vma->vm_start) >> PAGE_SHIFT) + vma->vm_pgoff;
 	if (end > vma->vm_end)
 		end = vma->vm_end;


