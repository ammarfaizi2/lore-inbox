Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262378AbUCHNLZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Mar 2004 08:11:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262485AbUCHNLZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Mar 2004 08:11:25 -0500
Received: from [218.22.21.1] ([218.22.21.1]:58382 "EHLO mx1.ustc.edu.cn")
	by vger.kernel.org with ESMTP id S262378AbUCHNLX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Mar 2004 08:11:23 -0500
Date: Mon, 8 Mar 2004 21:06:46 +0800
To: linux-kernel@vger.kernel.org
Subject: [PATCH] fadvise invalidating range fix
Message-ID: <20040308130646.GA4826@mail.ustc.edu.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
From: WU Fengguang <wfg@mail.ustc.edu.cn>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew

I noticed fadvise(POSIX_FADV_DONTNEED) was invalidating more parts of the file
than I expected. Here is the patch.

Notes for change in fadvise.c/sys_fadvise64_64():

- It should be noticed that the 'end' param of invalidate_mapping_pages()
  is inclusive;

- When 'offset' and/or 'offset+len' do no align to page boundary, we must
  decide whether to abandon the partial page at the beginning/end of the range. 
  My patch assumes that the application is scanning forward,
  which is the most common case.
  So 'end_index' is set to the page just before the ending partial page.

- Manual pages for posix_fadvise() mentioned the case of 'len=0', which
  is not handled by the code. Perhaps the handling of 'len=0' is useless,
  so I leaved that alone.

Notes for change in truncate.c/invalidate_mapping_pages():

- Is there any reason that I din't know to free any page outside of [begin,end]?
  The origin code will abandon useful trailing pages when there's hole
  in the range, which may cause series of unecessary disk I/O in
  streaming applications.

best regards, Wu Fengguang


diff -Naur linux-2.6.4-rc2/mm/fadvise.c linux-2.6.4-rc2_fadvise_fix/mm/fadvise.c
--- linux-2.6.4-rc2/mm/fadvise.c	2004-02-18 03:57:30.000000000 +0000
+++ linux-2.6.4-rc2_fadvise_fix/mm/fadvise.c	2004-03-08 12:20:06.000000000 +0000
@@ -66,8 +66,7 @@
 		if (!bdi_write_congested(mapping->backing_dev_info))
 			filemap_flush(mapping);
 		start_index = offset >> PAGE_CACHE_SHIFT;
-		end_index = (offset + len + PAGE_CACHE_SIZE - 1) >>
-						PAGE_CACHE_SHIFT;
+		end_index = ((offset + len) >> PAGE_CACHE_SHIFT) - 1;
 		invalidate_mapping_pages(mapping, start_index, end_index);
 		break;
 	default:
diff -Naur linux-2.6.4-rc2/mm/truncate.c linux-2.6.4-rc2_fadvise_fix/mm/truncate.c
--- linux-2.6.4-rc2/mm/truncate.c	2004-02-18 03:59:34.000000000 +0000
+++ linux-2.6.4-rc2_fadvise_fix/mm/truncate.c	2004-03-08 12:20:06.000000000 +0000
@@ -219,6 +219,8 @@
 			ret += invalidate_complete_page(mapping, page);
 unlock:
 			unlock_page(page);
+			if (next > end)
+				break;
 		}
 		pagevec_release(&pvec);
 		cond_resched();
