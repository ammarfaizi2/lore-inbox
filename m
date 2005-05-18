Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262225AbVEROB1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262225AbVEROB1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 10:01:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262222AbVEROAS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 10:00:18 -0400
Received: from mtagate4.de.ibm.com ([195.212.29.153]:19404 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP id S262206AbVERNyL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 09:54:11 -0400
Subject: [RFC/PATCH 5/5] madvice/fadvice: execute in place (V2)
From: Carsten Otte <cotte@de.ibm.com>
Reply-To: cotte@freenet.de
To: linux-kernel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, schwidefsky@de.ibm.com, akpm@osdl.org
In-Reply-To: <1116422644.2202.1.camel@cotte.boeblingen.de.ibm.com>
References: <1116422644.2202.1.camel@cotte.boeblingen.de.ibm.com>
Content-Type: text/plain
Organization: IBM Deutschland Entwicklung
Date: Wed, 18 May 2005 15:54:05 +0200
Message-Id: <1116424446.2202.20.camel@cotte.boeblingen.de.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[RFC/PATCH 5/5] madvice/fadvice: execute in place (V2)
This patch makes sys_madvice and sys_fadvice return 0 on advices to
cache data assoctiated with files that do have get_xip_page. Since the
data for those is in memory anyway, we can just ignore the advice...

This patch is unchanged from previous version.

Signed-off-by: Carsten Otte <cotte@de.ibm.com>
--- 
diff -ruN linux-git/mm/fadvise.c linux-git-xip/mm/fadvise.c
--- linux-git/mm/fadvise.c	2005-05-17 14:23:36.000000000 +0200
+++ linux-git-xip/mm/fadvise.c	2005-05-17 20:16:40.000000000 +0200
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
diff -ruN linux-git/mm/madvise.c linux-git-xip/mm/madvise.c
--- linux-git/mm/madvise.c	2005-05-17 14:23:36.000000000 +0200
+++ linux-git-xip/mm/madvise.c	2005-05-17 20:16:40.000000000 +0200
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


