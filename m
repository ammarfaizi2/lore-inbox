Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262070AbVAZCb1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262070AbVAZCb1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 21:31:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262075AbVAZCb1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 21:31:27 -0500
Received: from fmr17.intel.com ([134.134.136.16]:15276 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S262070AbVAZCbY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 21:31:24 -0500
Subject: [PATCH 2.6] Fix mincore cornercases: overflow caused by large "len"
From: "Jin, Gordon" <gordon.jin@intel.com>
To: akpm@osdl.org, torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1106706431.3604.80.camel@yjin3-dev.sh.intel.com.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 26 Jan 2005 10:27:11 +0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes 2 cornercases of overflow caused by argument len in
sys_mincore():

Case 1: len is so large that will overflow to 0 after page alignment.
E.g. len=(size_t)(-1), i.e. 0xff...ff.
Expected result: it's overflow and return ENOMEM.
Current result: len is aligned to 0, then treated the same as len=0 and
return succeed.
This cornercase has been fixed in do_mmap_pgoff(), and here
sys_mincore() also needs this fix.

Case 2: len is a large number but will not overflow after alignment. But
start+len will overflow.
E.g. len=(size_t)(-PAGE_SIZE), and start>0.
Expected result: it's overflow and return ENOMEM.
Current result: return EINVAL. Looks like considering len as a
non-positive value, probably influenced by manpage. But since the type
of len is size_t, i.e. unsigned, it shouldn't be considered as
non-positive value.
I've also reported this inconsistency to manpage mincore.

Signed-off-by: Gordon Jin <gordon.jin@intel.com>

Index: linux-2.6.10/mm/mincore.c
===================================================================
--- linux-2.6.10.orig/mm/mincore.c	2005-01-12 06:59:09.000000000 +0800
+++ linux-2.6.10/mm/mincore.c	2005-01-18 17:29:34.432160185 +0800
@@ -97,8 +97,7 @@ static long mincore_vma(struct vm_area_s
  * return values:
  *  zero    - success
  *  -EFAULT - vec points to an illegal address
- *  -EINVAL - addr is not a multiple of PAGE_CACHE_SIZE,
- *		or len has a nonpositive value
+ *  -EINVAL - addr is not a multiple of PAGE_CACHE_SIZE
  *  -ENOMEM - Addresses in the range [addr, addr + len] are
  *		invalid for the address space of this process, or
  *		specify one or more pages which are not currently
@@ -114,13 +113,18 @@ asmlinkage long sys_mincore(unsigned lon
 	int unmapped_error = 0;
 	long error = -EINVAL;
 
+	if (!len)
+		return 0;
+
 	down_read(&current->mm->mmap_sem);
 
 	if (start & ~PAGE_CACHE_MASK)
 		goto out;
+
+	error = -ENOMEM;
 	len = (len + ~PAGE_CACHE_MASK) & PAGE_CACHE_MASK;
 	end = start + len;
-	if (end < start)
+	if (end <= start)	/* overflow */
 		goto out;
 
 	error = -EFAULT;


