Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161441AbWATAnh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161441AbWATAnh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 19:43:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161422AbWATAnh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 19:43:37 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:53203
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1161441AbWATAng (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 19:43:36 -0500
Date: Thu, 19 Jan 2006 16:40:42 -0800 (PST)
Message-Id: <20060119.164042.74751188.davem@davemloft.net>
To: torvalds@osdl.org
CC: dwmw2@infradead.org, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH]: Fix regression added by ppoll/pselect code.
From: "David S. Miller" <davem@davemloft.net>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The compat layer timeout handling changes in:

9f72949f679df06021c9e43886c9191494fdb007

are busted.  This is most easily seen with an X application
that uses sub-second select/poll timeout such as emacs.  You
hit a key and it takes a second or so before the app responds.

The two ROUND_UP() calls upon entry are using {tv,ts}_sec where it
should instead be using {tv_usec,ts_nsec}, which perfectly explains
the observed incorrect behavior.

Another bug shot down with git bisect.

Signed-off-by: David S. Miller <davem@davemloft.net>

diff --git a/fs/compat.c b/fs/compat.c
index 18b21b4..ff0bafc 100644
--- a/fs/compat.c
+++ b/fs/compat.c
@@ -1743,7 +1743,7 @@ asmlinkage long compat_sys_select(int n,
 		if ((u64)tv.tv_sec >= (u64)MAX_INT64_SECONDS)
 			timeout = -1;	/* infinite */
 		else {
-			timeout = ROUND_UP(tv.tv_sec, 1000000/HZ);
+			timeout = ROUND_UP(tv.tv_usec, 1000000/HZ);
 			timeout += tv.tv_sec * HZ;
 		}
 	}
@@ -1884,7 +1884,7 @@ asmlinkage long compat_sys_ppoll(struct 
 		/* We assume that ts.tv_sec is always lower than
 		   the number of seconds that can be expressed in
 		   an s64. Otherwise the compiler bitches at us */
-		timeout = ROUND_UP(ts.tv_sec, 1000000000/HZ);
+		timeout = ROUND_UP(ts.tv_nsec, 1000000000/HZ);
 		timeout += ts.tv_sec * HZ;
 	}
 
