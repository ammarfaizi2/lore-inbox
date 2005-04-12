Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262157AbVDLT4z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262157AbVDLT4z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 15:56:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262160AbVDLT4K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 15:56:10 -0400
Received: from fire.osdl.org ([65.172.181.4]:43720 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262157AbVDLKbq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 06:31:46 -0400
Message-Id: <200504121031.j3CAVWh1005336@shell0.pdx.osdl.net>
Subject: [patch 053/198] ppc64: remove -fno-omit-frame-pointer
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, anton@samba.org
From: akpm@osdl.org
Date: Tue, 12 Apr 2005 03:31:25 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Anton Blanchard <anton@samba.org>

During some code inspection using gcc 4.0 I noticed a stack frame was being
created for a number of functions that didnt require it.  For example:

c0000000000df944 <._spin_unlock>:
c0000000000df944:       fb e1 ff f0     std     r31,-16(r1)
c0000000000df948:       f8 21 ff c1     stdu    r1,-64(r1)
c0000000000df94c:       7c 3f 0b 78     mr      r31,r1
c0000000000df950:       7c 20 04 ac     lwsync
c0000000000df954:       e8 21 00 00     ld      r1,0(r1)
c0000000000df958:       38 00 00 00     li      r0,0
c0000000000df95c:       90 03 00 00     stw     r0,0(r3)
c0000000000df960:       eb e1 ff f0     ld      r31,-16(r1)
c0000000000df964:       4e 80 00 20     blr

It turns out we are adding -fno-omit-frame-pointer to ppc64 which is
causing the above behaviour.  Removing that flag results in much better
code:

c0000000000d5b30 <._spin_unlock>:
c0000000000d5b30:       7c 20 04 ac     lwsync
c0000000000d5b34:       38 00 00 00     li      r0,0
c0000000000d5b38:       90 03 00 00     stw     r0,0(r3)
c0000000000d5b3c:       4e 80 00 20     blr

We dont require a frame pointer to debug on ppc64, so remove it.

Signed-off-by: Anton Blanchard <anton@samba.org>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/arch/ppc64/Kconfig |    4 ----
 1 files changed, 4 deletions(-)

diff -puN arch/ppc64/Kconfig~ppc64-remove-fno-omit-frame-pointer arch/ppc64/Kconfig
--- 25/arch/ppc64/Kconfig~ppc64-remove-fno-omit-frame-pointer	2005-04-12 03:21:16.157680560 -0700
+++ 25-akpm/arch/ppc64/Kconfig	2005-04-12 03:21:16.160680104 -0700
@@ -40,10 +40,6 @@ config COMPAT
 	bool
 	default y
 
-config FRAME_POINTER
-	bool
-	default y
-
 # We optimistically allocate largepages from the VM, so make the limit
 # large enough (16MB). This badly named config option is actually
 # max order + 1
_
