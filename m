Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268095AbUJJDuz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268095AbUJJDuz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Oct 2004 23:50:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268101AbUJJDuy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Oct 2004 23:50:54 -0400
Received: from ozlabs.org ([203.10.76.45]:57506 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S268095AbUJJDuw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Oct 2004 23:50:52 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16744.45392.781083.565926@cargo.ozlabs.ibm.com>
Date: Sun, 10 Oct 2004 13:49:36 +1000
From: Paul Mackerras <paulus@samba.org>
To: akpm@osdl.org, torvalds@osdl.org
Cc: benh@kernel.crashing.org, linux-kernel@vger.kernel.org
Subject: [PATCH] PPC32: Fix cpu voltage change delay
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes a problem where my new powerbook would sometimes hang
or crash when changing CPU speed.  We had schedule_timeout(HZ/1000) in
there, intended to provide a delay of one millisecond.  However, even
with HZ=1000, it was (I believe) only waiting for the next jiffy
before proceeding, which could be less than a millisecond.  Changing
the code to use msleep, and specifying a time of 1 jiffy + 1ms has
fixed the problem.  (When I looked at the msleep code, it appeared to
me that msleep(1) with HZ=1000 would sleep for between 0 and 1ms.)

Ben also asked me to remove the code that changes the AACK delay
enable, after looking in the Darwin sources and seeing that Darwin
does not change this in its corresponding code.

Signed-off-by: Paul Mackerras <paulus@samba.org>

diff -urN linux-2.5/arch/ppc/platforms/pmac_cpufreq.c pmac-2.5/arch/ppc/platforms/pmac_cpufreq.c
--- linux-2.5/arch/ppc/platforms/pmac_cpufreq.c	2004-09-24 15:23:06.000000000 +1000
+++ pmac-2.5/arch/ppc/platforms/pmac_cpufreq.c	2004-10-10 11:23:43.000000000 +1000
@@ -140,11 +140,8 @@
 	if (low_speed == 0) {
 		/* ramping up, set voltage first */
 		pmac_call_feature(PMAC_FTR_WRITE_GPIO, NULL, voltage_gpio, 0x05);
-		set_current_state(TASK_UNINTERRUPTIBLE);
-		schedule_timeout(HZ/1000);
-	} else {
-		/* ramping down, enable aack delay first */
-		pmac_call_feature(PMAC_FTR_AACK_DELAY_ENABLE, NULL, 1, 0);
+		/* Make sure we sleep for at least 1ms */
+		msleep(1 + jiffies_to_msecs(1));
 	}
 
 	/* set frequency */
@@ -153,11 +150,7 @@
 	if (low_speed == 1) {
 		/* ramping down, set voltage last */
 		pmac_call_feature(PMAC_FTR_WRITE_GPIO, NULL, voltage_gpio, 0x04);
-		set_current_state(TASK_UNINTERRUPTIBLE);
-		schedule_timeout(HZ/1000);
-	} else {
-		/* ramping up, disable aack delay last */
-		pmac_call_feature(PMAC_FTR_AACK_DELAY_ENABLE, NULL, 0, 0);
+		msleep(1 + jiffies_to_msecs(1));
 	}
 
 	return 0;
