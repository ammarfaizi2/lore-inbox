Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932176AbWHCDfJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932176AbWHCDfJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 23:35:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932180AbWHCDfJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 23:35:09 -0400
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:1767 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S932176AbWHCDfH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 23:35:07 -0400
Date: Thu, 3 Aug 2006 12:37:16 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: LHMS <lhms-devel@lists.sourceforge.net>,
       "kmannth@us.ibm.com" <kmannth@us.ibm.com>,
       "y-goto@jp.fujitsu.com" <y-goto@jp.fujitsu.com>,
       Andrew Morton <akpm@osdl.org>
Subject: [PATCH] memory hotadd fixes [5/5] avoid registering res twice
Message-Id: <20060803123716.2e00952a.kamezawa.hiroyu@jp.fujitsu.com>
Organization: Fujitsu
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

both of acpi_memory_enable_device() and acpi_memory_add_device()
may evaluate _CRS method.

We should avoid evaluate device's resource twice if we could get it
successfully in past.

Signed-Off-By: KAMEZWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>

 drivers/acpi/acpi_memhotplug.c |    4 ++++
 1 files changed, 4 insertions(+)

Index: linux-2.6.18-rc3/drivers/acpi/acpi_memhotplug.c
===================================================================
--- linux-2.6.18-rc3.orig/drivers/acpi/acpi_memhotplug.c	2006-08-02 14:12:45.000000000 +0900
+++ linux-2.6.18-rc3/drivers/acpi/acpi_memhotplug.c	2006-08-02 14:24:10.000000000 +0900
@@ -129,11 +129,15 @@
 	struct acpi_memory_info *info, *n;
 
 
+	if (!list_empty(&mem_device->res_list))
+		return 0;
+
 	status = acpi_walk_resources(mem_device->device->handle, METHOD_NAME__CRS,
 				     acpi_memory_get_resource, mem_device);
 	if (ACPI_FAILURE(status)) {
 		list_for_each_entry_safe(info, n, &mem_device->res_list, list)
 			kfree(info);
+		INIT_LIST_HEAD(&mem_device->res_list);
 		return -EINVAL;
 	}
 

