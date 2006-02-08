Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030386AbWBHSLI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030386AbWBHSLI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 13:11:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030397AbWBHSLI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 13:11:08 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:9161 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1030386AbWBHSLH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 13:11:07 -0500
Date: Wed, 8 Feb 2006 10:11:04 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: linux-kernel@vger.kernel.org
Subject: cpusets: only wakeup kswapd for zones in the current cpuset
Message-ID: <Pine.LNX.4.62.0602081010440.2648@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


---------- Forwarded message ----------
Date: Wed, 8 Feb 2006 09:45:03 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: akpm@osdl.org
Cc: pj@sgi.com
Subject: cpusets: only wakeup kswapd for zones in the current cpuset

If we get under some memory pressure in a cpuset (we only scan zones
that are in the cpuset for memory) then kswapd is woken
up for all zones. This patch only wakes up kswapd in zones that are
part of the current cpuset.

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.16-rc2/mm/page_alloc.c
===================================================================
--- linux-2.6.16-rc2.orig/mm/page_alloc.c	2006-02-02 22:03:08.000000000 -0800
+++ linux-2.6.16-rc2/mm/page_alloc.c	2006-02-08 00:05:09.000000000 -0800
@@ -923,7 +923,8 @@ restart:
 		goto got_pg;
 
 	do {
-		wakeup_kswapd(*z, order);
+		if (cpuset_zone_allowed(*z, gfp_mask))
+			wakeup_kswapd(*z, order);
 	} while (*(++z));
 
 	/*

