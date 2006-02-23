Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751788AbWBWWLP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751788AbWBWWLP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 17:11:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751789AbWBWWLP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 17:11:15 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:29109 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751788AbWBWWLO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 17:11:14 -0500
Date: Thu, 23 Feb 2006 14:11:10 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, davem@davemloft.net
Subject: time_interpolator: Use readq_relaxed() instead of readq().
Message-ID: <Pine.LNX.4.64.0602231409110.14640@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On some platforms readq performs additional work to make sure I/O is done in
a coherent way. This is not needed for time retrieval as done by the time interpolator.
So we can use readq_relaxed instead which will improve performance.

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.16-rc4/kernel/timer.c
===================================================================
--- linux-2.6.16-rc4.orig/kernel/timer.c	2006-02-17 14:23:45.000000000 -0800
+++ linux-2.6.16-rc4/kernel/timer.c	2006-02-23 14:03:02.000000000 -0800
@@ -1351,10 +1351,10 @@ static inline u64 time_interpolator_get_
 			return x();
 
 		case TIME_SOURCE_MMIO64	:
-			return readq((void __iomem *) time_interpolator->addr);
+			return readq_relaxed((void __iomem *) time_interpolator->addr);
 
 		case TIME_SOURCE_MMIO32	:
-			return readl((void __iomem *) time_interpolator->addr);
+			return readl_relaxed((void __iomem *) time_interpolator->addr);
 
 		default: return get_cycles();
 	}
