Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030196AbVLSAa0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030196AbVLSAa0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Dec 2005 19:30:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030197AbVLSAa0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Dec 2005 19:30:26 -0500
Received: from gate.crashing.org ([63.228.1.57]:64990 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1030196AbVLSAaZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Dec 2005 19:30:25 -0500
Subject: [PATCH] powerpc: g5 thermal overtemp bug
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Markus Rothe <markus@unixforces.net>,
       Owen Stampflee <ostampflee@terrasoftsolutions.com>,
       linuxppc64-dev <linuxppc64-dev@ozlabs.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Mon, 19 Dec 2005 11:24:53 +1100
Message-Id: <1134951893.6102.126.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The g5 thermal control for liquid cooled machines has a small bug, when
the temperatures gets too high, it boosts all fans to the max, but
incorrectly sets the liquids pump to the min instead of the max speed,
thus causing the overtemp condition not to clear and the machine to shut
down after a while. This fixes it to set the pumps to max speed instead.
This problem might explain some of the reports of random shutdowns that
some g5 users have been reporting in the past.

Many thanks to Marcus Rothe for spending a lot of time trying various
patches & sending log logs before I found out that typo. Note that
overtemp handling is still not perfect and the machine might still
shutdown, that patch should reduce if not eliminate such occcurences in
"normal" conditions with high load. I'll implement a better handling
with proper slowing down of the CPUs later.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Index: linux-work/drivers/macintosh/therm_pm72.c
===================================================================
--- linux-work.orig/drivers/macintosh/therm_pm72.c	2005-11-10 08:20:14.000000000 +1100
+++ linux-work/drivers/macintosh/therm_pm72.c	2005-12-19 11:20:39.000000000 +1100
@@ -933,7 +933,7 @@
 	if (state0->overtemp > 0) {
 		state0->rpm = state0->mpu.rmaxn_exhaust_fan;
 		state0->intake_rpm = intake = state0->mpu.rmaxn_intake_fan;
-		pump = state0->pump_min;
+		pump = state0->pump_max;
 		goto do_set_fans;
 	}
 


