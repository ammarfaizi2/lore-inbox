Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932179AbWHCDd6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932179AbWHCDd6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 23:33:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932223AbWHCDd6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 23:33:58 -0400
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:25269 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S932179AbWHCDdy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 23:33:54 -0400
Date: Thu, 3 Aug 2006 12:36:04 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: LHMS <lhms-devel@lists.sourceforge.net>,
       "kmannth@us.ibm.com" <kmannth@us.ibm.com>,
       "y-goto@jp.fujitsu.com" <y-goto@jp.fujitsu.com>,
       Andrew Morton <akpm@osdl.org>
Subject: [PATCH] memory hotadd fixes [4/5] avoid check in acpi
Message-Id: <20060803123604.0f909208.kamezawa.hiroyu@jp.fujitsu.com>
Organization: Fujitsu
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


add_memory() does all necessary check to avoid collision.
then, acpi layer doesn't have to check region by itself.

(*) pfn_valid() just returns page struct is valid or not. It returns 0
    if a section has been already added even is ioresource is not added.
    ioresource collision check in mm/memory_hotplug.c can do more precise
    collistion check.
    added enabled bit check just for sanity check..

Signed-Off-By: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>


 drivers/acpi/acpi_memhotplug.c |    9 +--------
 1 files changed, 1 insertion(+), 8 deletions(-)

Index: linux-2.6.18-rc3/drivers/acpi/acpi_memhotplug.c
===================================================================
--- linux-2.6.18-rc3.orig/drivers/acpi/acpi_memhotplug.c	2006-08-01 16:11:47.000000000 +0900
+++ linux-2.6.18-rc3/drivers/acpi/acpi_memhotplug.c	2006-08-02 14:12:45.000000000 +0900
@@ -230,17 +230,10 @@
 	 * (i.e. memory-hot-remove function)
 	 */
 	list_for_each_entry(info, &mem_device->res_list, list) {
-		u64 start_pfn, end_pfn;
-
-		start_pfn = info->start_addr >> PAGE_SHIFT;
-		end_pfn = (info->start_addr + info->length - 1) >> PAGE_SHIFT;
-
-		if (pfn_valid(start_pfn) || pfn_valid(end_pfn)) {
-			/* already enabled. try next area */
+		if (info->enabled) { /* just sanity check...*/
 			num_enabled++;
 			continue;
 		}
-
 		result = add_memory(node, info->start_addr, info->length);
 		if (result)
 			continue;

