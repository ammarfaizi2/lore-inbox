Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267326AbUJRUl2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267326AbUJRUl2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Oct 2004 16:41:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266901AbUJRUkj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Oct 2004 16:40:39 -0400
Received: from 41.150.104.212.access.eclipse.net.uk ([212.104.150.41]:28546
	"EHLO ladymac.shadowen.org") by vger.kernel.org with ESMTP
	id S267170AbUJRUiB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Oct 2004 16:38:01 -0400
To: apkm@osdl.org
Subject: [PATCH] vm_dirty_ration goes to zero
Cc: linux-kernel@vger.kernel.org
Message-Id: <E1CJeGV-0000f4-LB@ladymac.shadowen.org>
From: Andy Whitcroft <apw@shadowen.org>
Date: Mon, 18 Oct 2004 21:37:59 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When a 32 system has a very large imbalance of overall memory size
to ZONE_NORMAL (for example when large amounts of numa remap space
are in use) page_writeback_init() may incorrectly set vm_dirty_ratio
and dirty_background_ratio to zero; leading to divide by zero errors
elsewhere.  This patch bounds these at 1%.

Revision: $Rev: 721 $

Signed-off-by: Andy Whitcroft <apw@shadowen.org>

diffstat 500-vm_dirty_ratio-goes-to-zero
---

diff -X /home/apw/brief/lib/vdiff.excl -rupN reference/mm/page-writeback.c current/mm/page-writeback.c
--- reference/mm/page-writeback.c
+++ current/mm/page-writeback.c
@@ -506,6 +506,11 @@ void __init page_writeback_init(void)
 		dirty_background_ratio /= 100;
 		vm_dirty_ratio *= correction;
 		vm_dirty_ratio /= 100;
+
+		if (dirty_background_ratio <= 0) 
+			dirty_background_ratio = 1;
+		if (vm_dirty_ratio <= 0) 
+			vm_dirty_ratio = 1;
 	}
 	mod_timer(&wb_timer, jiffies + (dirty_writeback_centisecs * HZ) / 100);
 	set_ratelimit();
