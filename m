Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265178AbTFEVTP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jun 2003 17:19:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265179AbTFEVTO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jun 2003 17:19:14 -0400
Received: from ahmler3.mail.eds.com ([192.85.154.74]:34198 "EHLO
	ahmler3.mail.eds.com") by vger.kernel.org with ESMTP
	id S265178AbTFEVTK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jun 2003 17:19:10 -0400
Message-ID: <7FD257BF8564D4119DA800508BDF07AA0B0AAA21@usahm012.exmi01.exch.eds.com>
From: "Bailey, Scott" <scott.bailey@eds.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Cc: "'torvalds@transmeta.com'" <torvalds@transmeta.com>,
       "'marcelo@conectiva.com.br'" <marcelo@conectiva.com.br>,
       "Bailey, Scott" <scott.bailey@eds.com>
Subject: [PATCH] arch/alpha/kernel/time.c - override bogus clock freq gues
	ses
Date: Thu, 5 Jun 2003 17:32:30 -0400 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2656.59)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is targeted at 2.4.20, but should apply cleanly to any of the 2.5
kernels too.

The clock frequency found in the Alpha HWRPB may be significantly off from
the actual frequency. The existing test is not stringent enough to weed out
errors that will swamp ntp; this patch reduces the allowable error from 1%
(10,000 PPM) to 250 PPM.

Kudos to Hal Murray <hmurray@suespammers.org> for insightful guidance;
tested on
my 3-way Alphaserver 4100 5/466 with very happy results. :-)

--- kernel-source-2.4.20/arch/alpha/kernel/time.c	2002-02-27
05:12:19.000000000 -0500
+++ rsb-patch/arch/alpha/kernel/time.c	2003-06-05 12:51:10.000000000 -0400
@@ -24,6 +24,8 @@
  * 2000-08-13	Jan-Benedict Glaw <jbglaw@lug-owl.de>
  * 	Fixed time_init to be aware of epoches != 1900. This prevents
  * 	booting up in 2048 for me;) Code is stolen from rtc.c.
+ * 2003-06-03	R. Scott Bailey <scott.bailey@eds.com>
+ *	Tighten sanity in time_init from 1% (10,000 PPM) to 250 PPM
  */
 #include <linux/config.h>
 #include <linux/errno.h>
@@ -288,7 +290,7 @@
 time_init(void)
 {
 	unsigned int year, mon, day, hour, min, sec, cc1, cc2, epoch;
-	unsigned long cycle_freq, one_percent;
+	unsigned long cycle_freq, tolerance;
 	long diff;
 
 	/* Calibrate CPU clock -- attempt #1.  */
@@ -306,13 +308,13 @@
 
 	cycle_freq = hwrpb->cycle_freq;
 	if (est_cycle_freq) {
-		/* If the given value is within 1% of what we calculated, 
+		/* If the given value is within 250 PPM of what we
calculated,
 		   accept it.  Otherwise, use what we found.  */
-		one_percent = cycle_freq / 100;
+		tolerance = cycle_freq / 4000;
 		diff = cycle_freq - est_cycle_freq;
 		if (diff < 0)
 			diff = -diff;
-		if (diff > one_percent) {
+		if (diff > tolerance) {
 			cycle_freq = est_cycle_freq;
 			printk("HWRPB cycle frequency bogus.  "
 			       "Estimated %lu Hz\n", cycle_freq);
