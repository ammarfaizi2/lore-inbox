Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751972AbWICDUk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751972AbWICDUk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Sep 2006 23:20:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751973AbWICDUj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Sep 2006 23:20:39 -0400
Received: from gateway.insightbb.com ([74.128.0.19]:52638 "EHLO
	asav12.insightbb.com") by vger.kernel.org with ESMTP
	id S1751972AbWICDUj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Sep 2006 23:20:39 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AT0KAFvl+USBUIlZLA
From: Dmitry Torokhov <dtor@insightbb.com>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [RFC/PATCH-mm] i8042: activate panic blink only in X
Date: Sat, 2 Sep 2006 23:20:36 -0400
User-Agent: KMail/1.9.3
Cc: Andrew Morton <akpm@osdl.org>, Grant Coady <gcoady.lk@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609022320.36754.dtor@insightbb.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here is an attempt to make panicblink only active in X so there is a
chance of keyboard still working after panic in text console. Any reason
why is should not be done this way?

-- 
Dmitry

Input: i8042 - blink keyboard LEDs during panic only when in X

This gives keyboard a chance to work in text console so user
can attempt to exctract more useful data form crashed box
(for example some backtraces from SysRq)

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/serio/i8042.c |   10 ++++++++++
 1 files changed, 10 insertions(+)

Index: work/drivers/input/serio/i8042.c
===================================================================
--- work.orig/drivers/input/serio/i8042.c
+++ work/drivers/input/serio/i8042.c
@@ -20,6 +20,7 @@
 #include <linux/err.h>
 #include <linux/rcupdate.h>
 #include <linux/platform_device.h>
+#include <linux/vt_kern.h>
 
 #include <asm/io.h>
 
@@ -831,6 +832,15 @@ static long i8042_panic_blink(long count
 	static char led;
 
 	/*
+	 * Only blink while in X because it messes up scrollback in console
+	 * preventing users to see the entire oops.
+	 */
+#ifdef CONFIG_HW_CONSOLE
+	if (vc_cons[fg_console].d->vc_mode != KD_GRAPHICS)
+		return 0;
+#endif
+
+	/*
 	 * We expect frequency to be about 1/2s. KDB uses about 1s.
 	 * Make sure they are different.
 	 */

-- 
VGER BF report: H 0.00257812
