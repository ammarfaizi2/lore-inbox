Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261282AbVFDWu4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261282AbVFDWu4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Jun 2005 18:50:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261425AbVFDWu4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Jun 2005 18:50:56 -0400
Received: from mta07-winn.ispmail.ntl.com ([81.103.221.47]:49442 "EHLO
	mta07-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S261282AbVFDWuv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Jun 2005 18:50:51 -0400
Message-ID: <42A23047.5000600@ntlworld.com>
Date: Sat, 04 Jun 2005 23:50:47 +0100
From: Matt <matthew.keenan@ntlworld.com>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH] BUG #3054 madvise doesn't fail for exceding RSS limit.
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch that fixes bug #3054. Compiles, tests ok.

--- linux-2.6.11.10/mm/madvise.c 2005-05-12 15:58:30.000000000 +0100
+++ linux/mm/madvise.c  2005-06-04 23:25:03.000000000 +0100
@@ -70,6 +70,17 @@
                end = vma->vm_end;
        end = ((end - vma->vm_start) >> PAGE_SHIFT) + vma->vm_pgoff;

+       /*
+        * This doesn't account for pages that may already be mapped
+        * due to readahead, but since this is merely a hint to the
+        * kernel no real harm should be done, it will just make things
+        * run a little slower. Sometimes less is more! More than enough
+        * code for this minor corner case.
+        */
+       if (((max_sane_readahead(end-start) << 
PAGE_SHIFT)+current->mm->rss)>
+           current->signal->rlim[RLIMIT_RSS].rlim_cur)
+               return -ENOMEM;
+
        force_page_cache_readahead(file->f_mapping,
                        file, start, max_sane_readahead(end - start));
        return 0;

