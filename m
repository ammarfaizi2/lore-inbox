Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261918AbVEWRku@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261918AbVEWRku (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 May 2005 13:40:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261928AbVEWRjh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 May 2005 13:39:37 -0400
Received: from mtagate4.de.ibm.com ([195.212.29.153]:41176 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP id S261926AbVEWRap
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 May 2005 13:30:45 -0400
Subject: [RFC/PATCH 4/4] madvice/fadvice: execute in place (3rd version)
From: Carsten Otte <cotte@de.ibm.com>
Reply-To: cotte@freenet.de
To: linux-kernel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, schwidefsky@de.ibm.com, akpm@osdl.org,
       Christoph Hellwig <hch@infradead.org>
In-Reply-To: <1116866094.12153.12.camel@cotte.boeblingen.de.ibm.com>
References: <1116866094.12153.12.camel@cotte.boeblingen.de.ibm.com>
Content-Type: text/plain
Organization: IBM Deutschland Entwicklung
Date: Mon, 23 May 2005 19:30:42 +0200
Message-Id: <1116869442.12153.34.camel@cotte.boeblingen.de.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[RFC/PATCH 4/4] madvice/fadvice: execute in place (3rd version)

Make sys_madvice/fadvice return sane with xip. Patch is unchanged from
previous version.

Signed-off-by: Carsten Otte <cotte@de.ibm.com>
--- 
diff -ruN linux-git/mm/fadvise.c linux-git-xip/mm/fadvise.c
--- linux-git/mm/fadvise.c	2005-05-23 13:51:17.000000000 +0200
+++ linux-git-xip/mm/fadvise.c	2005-05-23 17:55:49.000000000 +0200
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
--- linux-git/mm/madvise.c	2005-05-23 13:51:17.000000000 +0200
+++ linux-git-xip/mm/madvise.c	2005-05-23 17:55:49.000000000 +0200
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


