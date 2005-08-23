Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932376AbVHWU3Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932376AbVHWU3Z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 16:29:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932377AbVHWU3Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 16:29:25 -0400
Received: from sccrmhc11.comcast.net ([63.240.76.21]:28647 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S932376AbVHWU3Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 16:29:25 -0400
Date: Tue, 23 Aug 2005 13:30:29 -0700
From: Deepak Saxena <dsaxena@plexity.net>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2.6.13-git] Fix IXP4xx CLOCK_TICK_RATE
Message-ID: <20050823203029.GA11370@plexity.net>
Reply-To: dsaxena@plexity.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: Plexity Networks
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[RMK is out for the week so sending this direct as it should go into 2.6.13]

As pointed out in the following thread, the CLOCK_TICK_RATE setting for
IXP4xx is incorrect b/c the HW ignores the lowest 2 bits of the LATCH value.

http://lists.arm.linux.org.uk/pipermail/linux-arm-kernel/2005-August/030950.html

Tnx to George Anziger and Egil Hjelmeland for finding the issue.

Signed-off-by: Deepak Saxena <dsaxena@plexity.net>

diff --git a/include/asm-arm/arch-ixp4xx/timex.h b/include/asm-arm/arch-ixp4xx/timex.h
--- a/include/asm-arm/arch-ixp4xx/timex.h
+++ b/include/asm-arm/arch-ixp4xx/timex.h
@@ -7,7 +7,9 @@
 
 /*
  * We use IXP425 General purpose timer for our timer needs, it runs at 
- * 66.66... MHz
+ * 66.66... MHz. We do a convulted calculation of CLOCK_TICK_RATE b/c the
+ * timer register ignores the bottom 2 bits of the LATCH value.
  */
-#define CLOCK_TICK_RATE (66666666)
+#define FREQ 66666666
+#define CLOCK_TICK_RATE (((FREQ / HZ & ~IXP4XX_OST_RELOAD_MASK) + 1) * HZ)
 

-- 
Deepak Saxena - dsaxena@plexity.net - http://www.plexity.net

Even a stopped clock gives the right time twice a day.
