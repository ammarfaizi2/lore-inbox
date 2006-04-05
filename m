Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750754AbWDEXsM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750754AbWDEXsM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Apr 2006 19:48:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751195AbWDEXsM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Apr 2006 19:48:12 -0400
Received: from mx1.redhat.com ([66.187.233.31]:43979 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750754AbWDEXsK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Apr 2006 19:48:10 -0400
Message-ID: <44345731.5020205@redhat.com>
Date: Wed, 05 Apr 2006 19:48:01 -0400
From: Hideo AOKI <haoki@redhat.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: akpm@osdl.org
CC: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [patch 2/3] mm: An enhancement of OVERCOMMIT_GUESS
Content-Type: multipart/mixed;
 boundary="------------070201020507040406020606"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070201020507040406020606
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This patch is the main part of this enhancement.
Additionally, the patch includes better error handling in __vm_enough_memory().

---
Hideo Aoki, Hitachi Computer Products (America) Inc.

--------------070201020507040406020606
Content-Type: text/x-patch;
 name="mm-consider_rsvpgs.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mm-consider_rsvpgs.patch"

This patch is an enhancement of OVERCOMMIT_GUESS algorithm in
__vm_enough_memory() in mm/mmap.c.

 When the OVERCOMMIT_GUESS algorithm calculates the number of free
 pages, the algorithm subtracts the number of reserved pages from
 the result nr_free_pages().

Signed-off-by: Hideo Aoki <haoki@redhat.com>
---

 mmap.c |   18 +++++++++++++++---
 1 files changed, 15 insertions(+), 3 deletions(-)

diff -purN linux-2.6.17-rc1-mm1/mm/mmap.c linux-2.6.17-rc1-mm1-idea6/mm/mmap.c
--- linux-2.6.17-rc1-mm1/mm/mmap.c	2006-04-04 10:43:57.000000000 -0400
+++ linux-2.6.17-rc1-mm1-idea6/mm/mmap.c	2006-04-04 14:56:51.000000000 -0400
@@ -121,14 +121,26 @@ int __vm_enough_memory(long pages, int c
 		 * only call if we're about to fail.
 		 */
 		n = nr_free_pages();
+
+		/*
+		 * Leave reserved pages. The pages are not for anonymous pages.
+		 */
+		if (n <= totalreserve_pages)
+			goto error;
+		else
+			n -= totalreserve_pages;
+
+		/*
+		 * Leave the last 3% for root
+		 */
 		if (!cap_sys_admin)
 			n -= n / 32;
 		free += n;
 
 		if (free > pages)
 			return 0;
-		vm_unacct_memory(pages);
-		return -ENOMEM;
+
+		goto error;
 	}
 
 	allowed = (totalram_pages - hugetlb_total_pages())
@@ -150,7 +162,7 @@ int __vm_enough_memory(long pages, int c
 	 */
 	if (atomic_read(&vm_committed_space) < (long)allowed)
 		return 0;
-
+error:
 	vm_unacct_memory(pages);
 
 	return -ENOMEM;

--------------070201020507040406020606--
