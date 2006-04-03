Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751745AbWDCPu2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751745AbWDCPu2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 11:50:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751746AbWDCPu2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 11:50:28 -0400
Received: from zproxy.gmail.com ([64.233.162.202]:42396 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751747AbWDCPu1 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 11:50:27 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=srAW9WAVHc7dvGhXIWh4VZx6vOi1k2iwVl6F2WFtxqnyLpI2FP0+xJ1Z+89hDq8hK4UzfZyXgdZOClxztj0etRpH/WReMqAQIH8TMsf3m7YoO2NgvRQFMDLNkRB+NM+v25kR5IhxUjRVge+AQ6eUZZSEWjQ8/ljWYMVCm4qr3Ww=
Message-ID: <728201270604030850q1b6a55c0xfd425f7480cde9a3@mail.gmail.com>
Date: Mon, 3 Apr 2006 15:50:26 +0000
From: "Ram Gupta" <ram.gupta5@gmail.com>
To: akpm@osdl.org
Subject: [PATCH]mm: Fixing bug in brk
Cc: "linux mailing-list" <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes a bug in sys_brk . The code checks for newbrk with
oldbrk which are page aligned before  making a check for the memory
limit set of data segment. If the memory limit is not page aligned in
that case it bypasses the test for the limit if the memory allocation
is still for the same page. Please apply

Signed-off-by: Ram Gupta ( ram.gupta5@gmail.com)
----------------------------
--- linux-2.6.16/mm/mmap.c.orig 2006-04-03 10:20:18.000000000 +0000
+++ linux-2.6.16/mm/mmap.c      2006-04-03 09:40:00.000000000 +0000
@@ -220,6 +220,16 @@ asmlinkage unsigned long sys_brk(unsigne

        if (brk < mm->end_code)
                goto out;
+
+       /* Check against rlimit here. If this check is not done here & done
+        * later after the test of oldbrk with newbrk then it can escape the
+        * test & let the data segment grow beyond its set limit  in case
+        * when the limit is not page aligned -Ram Gupta */
+
+       rlim = current->signal->rlim[RLIMIT_DATA].rlim_cur;
+       if (rlim < RLIM_INFINITY && brk - mm->start_data > rlim)
+               goto out;
+
        newbrk = PAGE_ALIGN(brk);
        oldbrk = PAGE_ALIGN(mm->brk);
        if (oldbrk == newbrk)
@@ -232,11 +242,6 @@ asmlinkage unsigned long sys_brk(unsigne
                goto out;
        }

-       /* Check against rlimit.. */
-       rlim = current->signal->rlim[RLIMIT_DATA].rlim_cur;
-       if (rlim < RLIM_INFINITY && brk - mm->start_data > rlim)
-               goto out;
-
        /* Check against existing mmap mappings. */
        if (find_vma_intersection(mm, oldbrk, newbrk+PAGE_SIZE))
                goto out;

Thanks
Ram Gupta
