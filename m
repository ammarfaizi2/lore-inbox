Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275899AbSIULLC>; Sat, 21 Sep 2002 07:11:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275900AbSIULLC>; Sat, 21 Sep 2002 07:11:02 -0400
Received: from vti01.vertis.nl ([145.66.4.26]:47632 "EHLO vti01.vertis.nl")
	by vger.kernel.org with ESMTP id <S275899AbSIULLA>;
	Sat, 21 Sep 2002 07:11:00 -0400
Date: Sat, 21 Sep 2002 13:14:47 +0200
From: Rolf Fokkens <fokkensr@fokkensr.vertis.nl>
Message-Id: <200209211114.g8LBEls02361@fokkensr.vertis.nl>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] timer.c negative shift, kernel 2.5.37
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

It appears that kernel time keeping may become unpredictable when HZ is
raised to large values due to negative shift operations in timer.c:

  time_adj = -ltemp << (SHIFT_SCALE - SHIFT_HZ - SHIFT_UPDATE);

Suppose on x86:
        HZ = 2048
and     SHIFT_SCALE = 22
and     SHIFT_UPDATE = (SHIFT_KG + MAXTC) = 12
then
        SHIFT_HZ = 11
and     (SHIFT_SCALE - SHIFT_HZ - SHIFT_UPDATE) = -1

This negative number is a problem for shift operations. The
following patch takes care of it (I hope).

Rolf Fokkens
fokkensr@fokkensr.vertis.nl

(2nd post of this patch)

--- linux-2.5.37.orig/kernel/timer.c	Mon Sep 16 20:43:47 2002
+++ linux-2.5.37/kernel/timer.c	Sat Sep 21 13:08:10 2002
@@ -339,6 +339,11 @@
 	run_task_queue(&tq_immediate);
 }
 
+static inline long signedshift (long val, int nshift)
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
+        time_adj = signedshift (-ltemp, SHIFT_SCALE - SHIFT_HZ - SHIFT_UPDATE);
     } else {
 	ltemp = time_offset;
 	if (!(time_status & STA_FLL))
@@ -426,7 +431,7 @@
 	if (ltemp > (MAXPHASE / MINSEC) << SHIFT_UPDATE)
 	    ltemp = (MAXPHASE / MINSEC) << SHIFT_UPDATE;
 	time_offset -= ltemp;
-	time_adj = ltemp << (SHIFT_SCALE - SHIFT_HZ - SHIFT_UPDATE);
+        time_adj = signedshift (ltemp, SHIFT_SCALE - SHIFT_HZ - SHIFT_UPDATE);
     }
 
     /*
