Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265111AbUFHAOg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265111AbUFHAOg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 20:14:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265141AbUFHAOg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 20:14:36 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:57845 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S265111AbUFHAOd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 20:14:33 -0400
Subject: [PATCH]linux-2.6.7-rc3_cyclone-bad-pit_A0
From: john stultz <johnstul@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>
Content-Type: text/plain
Message-Id: <1086653665.2234.192.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Mon, 07 Jun 2004 17:14:26 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All,
	In testing for SLES9, we ran across a bug caused by userspace apps
poking the PIT which caused bad values to be read by the kernel. This
would then trigger the lost tick detection code with insane values and
would then break the SCSI subsystem. 
	
	This patch includes the PIT sanity check from the TSC timesource into
the cyclone timesource code, which catches the bad case described above
and resolves the issue.

Please apply.

thanks
-john

diff -Nru a/arch/i386/kernel/timers/timer_cyclone.c b/arch/i386/kernel/timers/timer_cyclone.c
--- a/arch/i386/kernel/timers/timer_cyclone.c	Mon Jun  7 17:02:41 2004
+++ b/arch/i386/kernel/timers/timer_cyclone.c	Mon Jun  7 17:02:41 2004
@@ -17,6 +17,7 @@
 #include <asm/io.h>
 #include <asm/pgtable.h>
 #include <asm/fixmap.h>
+#include "io_ports.h"
 
 extern spinlock_t i8253_lock;
 
@@ -62,6 +63,17 @@
 
 	count = inb_p(0x40);    /* read the latched count */
 	count |= inb(0x40) << 8;
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
 	spin_unlock(&i8253_lock);
 
 	/* lost tick compensation */


