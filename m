Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750910AbVLGByf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750910AbVLGByf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 20:54:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030319AbVLGByf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 20:54:35 -0500
Received: from e31.co.us.ibm.com ([32.97.110.149]:56027 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750888AbVLGBye
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 20:54:34 -0500
Message-ID: <439640A1.3030300@us.ibm.com>
Date: Tue, 06 Dec 2005 17:53:37 -0800
From: Haren Myneni <haren@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050328 Fedora/1.7.6-1.2.5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, linuxppc64-dev@ozlabs.org
Subject: [PATCH] Trivial fix in __alloc_bootmem_core() when there is no free
 page in first node's memory
Content-Type: multipart/mixed;
 boundary="------------010407060102010300050006"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010407060102010300050006
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,
    Hitting BUG_ON() in __alloc_bootmem_core() when there is no free 
page available in the first node's memory. For the case of kdump on 
PPC64 (Power 4 machine), the captured kernel is used two memory regions 
- memory for TCE tables (tce-base and tce-size at top of RAM and 
reserved) and captured kernel memory region (crashk_base and 
crashk_size). Since we reserve the memory for the first node, we should 
be returning from __alloc_bootmem_core() to search for the next node 
(pg_dat).

Currently, find_next_zero_bit() is returning the n^th bit (eidx) when 
there is no free page. Then, test_bit() is failed since we set 0xff only 
for the actual size initially (init_bootmem_core()) even though rounded 
up to one page for bdata->node_bootmem_map. We are hitting the BUG_ON 
after failing to enter second "for" loop.

Please apply.

Thanks
Haren

Signed-off-by: Haren Myneni <haren@us.ibm.com>





--------------010407060102010300050006
Content-Type: text/x-patch;
 name="bootmem_bug_on_fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="bootmem_bug_on_fix.patch"

--- 2.6.15-rc5-git1/mm/bootmem.c.orig	2005-12-14 21:28:46.000000000 -0800
+++ 2.6.15-rc5-git1/mm/bootmem.c	2005-12-14 21:35:54.000000000 -0800
@@ -204,6 +204,8 @@ restart_scan:
 		unsigned long j;
 		i = find_next_zero_bit(bdata->node_bootmem_map, eidx, i);
 		i = ALIGN(i, incr);
+		if (i >= eidx)
+			break;
 		if (test_bit(i, bdata->node_bootmem_map))
 			continue;
 		for (j = i + 1; j < i + areasize; ++j) {

--------------010407060102010300050006--
