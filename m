Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262098AbVCNKAa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262098AbVCNKAa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 05:00:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262095AbVCNKAa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 05:00:30 -0500
Received: from fmr17.intel.com ([134.134.136.16]:6792 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S262096AbVCNKAV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 05:00:21 -0500
Subject: [PATCH 2.6] fix mprotect() with len=(size_t)(-1) to return -ENOMEM
From: Gordon Jin <gordon.jin@intel.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, michael.fu@intel.com
Content-Type: text/plain
Message-Id: <1110794148.26254.45.camel@yjin3-dev.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 14 Mar 2005 17:55:48 +0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes a corner case in sys_mprotect(): 

Case: len is so large that will overflow to 0 after page alignment.
E.g. len=(size_t)(-1), i.e. 0xff...ff.
Expected result: POSIX spec says it should return -ENOMEM.
Current result: len is aligned to 0, then treated the same as len=0 and
return success.

--- linux-2.6.11.3/mm/mprotect.c.orig	2005-03-14 13:40:28.000000000
-0800
+++ linux-2.6.11.3/mm/mprotect.c	2005-03-14 13:42:41.000000000 -0800
@@ -232,14 +232,14 @@ sys_mprotect(unsigned long start, size_t
 
 	if (start & ~PAGE_MASK)
 		return -EINVAL;
+	if (!len)
+		return 0;
 	len = PAGE_ALIGN(len);
 	end = start + len;
-	if (end < start)
+	if (end <= start)
 		return -ENOMEM;
 	if (prot & ~(PROT_READ | PROT_WRITE | PROT_EXEC | PROT_SEM))
 		return -EINVAL;
-	if (end == start)
-		return 0;
 	/*
 	 * Does the application expect PROT_READ to imply PROT_EXEC:
 	 */


