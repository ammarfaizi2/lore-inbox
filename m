Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262065AbVATHLi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262065AbVATHLi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 02:11:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262067AbVATHLe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 02:11:34 -0500
Received: from fmr14.intel.com ([192.55.52.68]:12764 "EHLO
	fmsfmr002.fm.intel.com") by vger.kernel.org with ESMTP
	id S262065AbVATHLc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 02:11:32 -0500
Subject: [Patch]Fix an error in copy_page_range
From: Zou Nan hai <nanhai.zou@intel.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@akpm
Content-Type: text/plain
Organization: 
Message-Id: <1106199886.9401.19.camel@linux-znh>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 20 Jan 2005 13:44:46 +0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, 

There is a bug in copy_page_range in current 2.6.11-rc1 with 4 level
page table change. copy_page_range do a continue without adding pgds and
addr when pgd_none(*src_pgd) or pgd_bad(*src_pgd).

I think it's wrong in logic, copy_page_range will run into infinite loop
when when pgd_none(*src_pgd) or pgd_bad(*src_pgd).

Although maybe this bug does not break anything currently..., 


Signed-off-by: Zou Nan hai <nanhai.zou@intel.com>

--- a/mm/memory.c	2005-01-21 01:21:18.000000000 +0800
+++ b/mm/memory.c	2005-01-21 04:49:13.000000000 +0800
@@ -442,17 +442,18 @@ int copy_page_range(struct mm_struct *ds
 		if (next > end || next <= addr)
 			next = end;
 		if (pgd_none(*src_pgd))
-			continue;
+			goto next_pgd;
 		if (pgd_bad(*src_pgd)) {
 			pgd_ERROR(*src_pgd);
 			pgd_clear(src_pgd);
-			continue;
+			goto next_pgd;
 		}
 		err = copy_pud_range(dst, src, dst_pgd, src_pgd,
 							vma, addr, next);
 		if (err)
 			break;
 
+next_pgd:
 		src_pgd++;
 		dst_pgd++;
 		addr = next;



