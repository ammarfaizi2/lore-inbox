Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265955AbTFSVHW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jun 2003 17:07:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265943AbTFSVFb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jun 2003 17:05:31 -0400
Received: from zero.aec.at ([193.170.194.10]:44301 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S265951AbTFSVEl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jun 2003 17:04:41 -0400
Date: Thu, 19 Jun 2003 23:18:19 +0200
From: Andi Kleen <ak@muc.de>
To: torvalds@transmeta.com
Cc: akpm@digeo.com, linux-kernel@vger.kernel.org, rusty@rustcorp.com.au
Subject: [PATCH] Remove spinlock workaround for pre 2.95 gccs
Message-ID: <20030619211819.GA12716@averell>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Remove the empty initializer workaround that was added for egcs 1.1.
Only 2.95+ is supported now, so all compilers should support empty
structures.

The if just checked for __GNUC__, which means that 2.95 got
the workaround (and the incompatibility) too even though it didn't need it.

Advantage is that gcc 2.95 and 3.x compiled kernels are now binary
compatible. Unfortunately module loading still checks the compiler
version, but I guess that could be taken out now. As far as I know
there should be no compiler related incompatibilities now.

-Andi

--- linux-2.5.72-work/include/linux/spinlock.h-RES	2003-06-14 23:43:05.000000000 +0200
+++ linux-2.5.72-work/include/linux/spinlock.h	2003-06-19 23:11:55.000000000 +0200
@@ -146,13 +146,8 @@
 /*
  * gcc versions before ~2.95 have a nasty bug with empty initializers.
  */
-#if (__GNUC__ > 2)
-  typedef struct { } spinlock_t;
-  #define SPIN_LOCK_UNLOCKED (spinlock_t) { }
-#else
-  typedef struct { int gcc_is_buggy; } spinlock_t;
-  #define SPIN_LOCK_UNLOCKED (spinlock_t) { 0 }
-#endif
+typedef struct { } spinlock_t;
+#define SPIN_LOCK_UNLOCKED (spinlock_t) { }
 
 /*
  * If CONFIG_SMP is unset, declare the _raw_* definitions as nops


