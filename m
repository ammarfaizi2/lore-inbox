Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751060AbWIWFbi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751060AbWIWFbi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Sep 2006 01:31:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751064AbWIWFbi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Sep 2006 01:31:38 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:51670
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751056AbWIWFbh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Sep 2006 01:31:37 -0400
Date: Fri, 22 Sep 2006 22:31:36 -0700 (PDT)
Message-Id: <20060922.223136.41635862.davem@davemloft.net>
To: linux-kernel@vger.kernel.org
CC: torvalds@osdl.org, herbert@gondor.apana.org
Subject: [PATCH]: Fix ALIGN() macro
From: David Miller <davem@davemloft.net>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


A regression or two were added by the crypto-2.6 tree merge.

I've tracked down one of them, and it's caused by the ALIGN()
macro truncating things down to "int".  Some of Herbert's new
code is aligning pointers using ALIGN() and this thus explodes
on 64-bit since the top 32-bits get chopped off.

It is arguable that perhaps we should make a special macro
for pointer aligning, but even in that case ALIGN() as a general
purpose macro should use the largest natural integer size in
order to not cause surprises for people.

I'm still trying to track down the other regression added by
the crypto merge.  I have it git bisected down to a single
changeset, but I haven't determined what's really wrong yet.
I should be able to kill that over the weekend.  I want to fix
this before merging my networking tree so I can be absolutely
sure that IPSEC doesn't break because of something in my tree :)

[KERNEL]: Do not truncate to 'int' in ALIGN() macro.

Signed-off-by: David S. Miller <davem@davemloft.net>

diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index 851aa1b..2b2ae4f 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -31,7 +31,7 @@ #define ULLONG_MAX	(~0ULL)
 #define STACK_MAGIC	0xdeadbeef
 
 #define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
-#define ALIGN(x,a) (((x)+(a)-1)&~((a)-1))
+#define ALIGN(x,a) (((x)+(a)-1UL)&~((a)-1UL))
 #define FIELD_SIZEOF(t, f) (sizeof(((t*)0)->f))
 #define roundup(x, y) ((((x) + ((y) - 1)) / (y)) * (y))
 
