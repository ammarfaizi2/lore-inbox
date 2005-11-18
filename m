Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751338AbVKRBDc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751338AbVKRBDc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 20:03:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751335AbVKRBDb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 20:03:31 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:13752 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751330AbVKRBDO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 20:03:14 -0500
Date: Thu, 17 Nov 2005 17:03:07 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: akpm@osdl.org
Cc: lhms-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       Christoph Lameter <clameter@sgi.com>
Message-Id: <20051118010307.22328.49242.sendpatchset@schroedinger.engr.sgi.com>
In-Reply-To: <20051118010257.22328.49524.sendpatchset@schroedinger.engr.sgi.com>
References: <20051118010257.22328.49524.sendpatchset@schroedinger.engr.sgi.com>
Subject: [PATCH 3/4] SwapMig: Drop unused pages immediately
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Drop unused pages immediately

If a page is encountered that is only referenced by the migration code
then there is no reason to swap or migrate the page. Release
the page by calling move_to_lru().

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.15-rc1-mm1/mm/vmscan.c
===================================================================
--- linux-2.6.15-rc1-mm1.orig/mm/vmscan.c	2005-11-17 15:59:07.000000000 -0800
+++ linux-2.6.15-rc1-mm1/mm/vmscan.c	2005-11-17 16:05:18.000000000 -0800
@@ -700,6 +700,11 @@ redo:
 	list_for_each_entry_safe(page, page2, l, lru) {
 		cond_resched();
 
+		if (page_count(page) == 1) {
+			/* page was freed from under us. So we are done. */
+			move_to_lru(page);
+			continue;
+		}
 		/*
 		 * Skip locked pages during the first two passes to give the
 		 * functions holding the lock time to release the page. Later we
