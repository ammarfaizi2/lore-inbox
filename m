Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264258AbTLTNSp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Dec 2003 08:18:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264259AbTLTNSp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Dec 2003 08:18:45 -0500
Received: from collab.or8.net ([209.94.128.81]:60944 "EHLO collab.or8.net")
	by vger.kernel.org with ESMTP id S264258AbTLTNSn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Dec 2003 08:18:43 -0500
Date: Sat, 20 Dec 2003 08:18:43 -0500 (EST)
From: Chris Bajumpaa <cbajumpa@or8.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 2.6] via686a/KX133 TSC failure 
Message-ID: <20031220074515.D50545@collab.or8.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

	This patch fixes a problem with the TSC failing on via686a/KX133
motherboards either reverting to using the pit or deadlocking the
machine alltogether under heavy load. (Specifically Abit KA7/KA7-100).

Message from the log:
Dec 18 18:20:37 grinder kernel: Losing too many ticks!
Dec 18 18:20:37 grinder kernel: TSC cannot be used as a timesource. (Are
you running with SpeedStep?)
Dec 18 18:20:37 grinder kernel: Falling back to a sane timesource.

The snippet of code that was missing from timer_tsc.c comes from
timer_pit.c. Please apply this patch.

8< patch starts here:
--- linux-2.6.0-vanilla/arch/i386/kernel/timers/timer_tsc.c	Wed Nov 26 15:44:45 2003
+++ linux-2.6.0-cjb/arch/i386/kernel/timers/timer_tsc.c	Sat Dec 20 07:27:24 2003
@@ -184,6 +184,18 @@

 	count = inb_p(PIT_CH0);    /* read the latched count */
 	count |= inb(PIT_CH0) << 8;
+
+	/*
+	 * VIA686a test code... reset the latch if count > max + 1
+	 * from timer_pit.c - cjb
+	 */
+	if (count > LATCH) {
+		outb_p(0x34, PIT_MODE);
+		outb_p(LATCH & 0xff, PIT_CH0);
+		outb(LATCH >> 8, PIT_CH0);
+		count = LATCH - 1;
+	}
+
 	spin_unlock(&i8253_lock);

 	if (pit_latch_buggy) {
