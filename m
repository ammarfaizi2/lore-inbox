Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262780AbSIPTRI>; Mon, 16 Sep 2002 15:17:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262782AbSIPTRI>; Mon, 16 Sep 2002 15:17:08 -0400
Received: from vti01.vertis.nl ([145.66.4.26]:19208 "EHLO vti01.vertis.nl")
	by vger.kernel.org with ESMTP id <S262780AbSIPTRH>;
	Mon, 16 Sep 2002 15:17:07 -0400
Date: Mon, 16 Sep 2002 21:20:42 +0200
From: Rolf Fokkens <fokkensr@fokkensr.vertis.nl>
Message-Id: <200209161920.g8GJKgL04828@fokkensr.vertis.nl>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] [2.5.35] USER_HZ & NTP problem (II)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

As said in previous postings I experimented with HZ=2048 (I actually
tried HZ=4096, don't tell anybody), and the following problem emerged:

Suppose
	HZ = 2048
and	SHIFT_SCALE = 22
and	SHIFT_UPDATE = (SHIFT_KG + MAXTC) = 12
then
	SHIFT_HZ = 11
and	(SHIFT_SCALE - SHIFT_HZ - SHIFT_UPDATE) = -1

This negative number seems te be a problem for shift operations. The
following patch takes care of the problem (I hope).

Rolf

--- linux-2.5.35.orig/kernel/timer.c	Mon Sep 16 20:43:47 2002
+++ linux-2.5.35/kernel/timer.c	Mon Sep 16 21:01:41 2002
@@ -339,6 +339,11 @@
 	run_task_queue(&tq_immediate);
 }
 
+static inline long negleftshift (long val, int nshift)
+{
+    return (nshift > 0 ? val << nshift : val >> -nshift);
+}
+
 /*
  * this routine handles the overflow of the microsecond field
  *
@@ -418,7 +423,7 @@
 	if (ltemp > (MAXPHASE / MINSEC) << SHIFT_UPDATE)
 	    ltemp = (MAXPHASE / MINSEC) << SHIFT_UPDATE;
 	time_offset += ltemp;
-	time_adj = -ltemp << (SHIFT_SCALE - SHIFT_HZ - SHIFT_UPDATE);
+        time_adj = negleftshift (-ltemp, SHIFT_SCALE - SHIFT_HZ - SHIFT_UPDATE);
     } else {
 	ltemp = time_offset;
 	if (!(time_status & STA_FLL))
@@ -426,7 +431,7 @@
 	if (ltemp > (MAXPHASE / MINSEC) << SHIFT_UPDATE)
 	    ltemp = (MAXPHASE / MINSEC) << SHIFT_UPDATE;
 	time_offset -= ltemp;
-	time_adj = ltemp << (SHIFT_SCALE - SHIFT_HZ - SHIFT_UPDATE);
+        time_adj = negleftshift (ltemp, SHIFT_SCALE - SHIFT_HZ - SHIFT_UPDATE);
     }
 
     /*
