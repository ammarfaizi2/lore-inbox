Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261738AbSI2THo>; Sun, 29 Sep 2002 15:07:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261748AbSI2THo>; Sun, 29 Sep 2002 15:07:44 -0400
Received: from vti01.vertis.nl ([145.66.4.26]:28423 "EHLO vti01.vertis.nl")
	by vger.kernel.org with ESMTP id <S261738AbSI2THm>;
	Sun, 29 Sep 2002 15:07:42 -0400
Date: Sun, 29 Sep 2002 21:12:12 +0200
From: Rolf Fokkens <fokkensr@fokkensr.vertis.nl>
Message-Id: <200209291912.g8TJCCH04519@fokkensr.vertis.nl>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] timer.c negative shift, kernel 2.5.39
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

Currently include/linux/timex.h prohibits HZ values greater than 1536,
which in turn prevents the case described above... though this is only
because of the values of SHIFT_SCALE, SHIFT_KG and MAXTC. This patch
allows values of HZ up to 3072.


Rolf Fokkens
fokkensr@fokkensr.vertis.nl

(3d post of this patch)


diff -ruN linux-2.5.39.orig/kernel/timer.c linux-2.5.39.signedshift/kernel/timer.c
--- linux-2.5.39.orig/kernel/timer.c	Sat Sep 28 14:42:56 2002
+++ linux-2.5.39.signedshift/kernel/timer.c	Sun Sep 29 18:33:33 2002
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
diff -ruN linux-2.5.39.orig/include/linux/timex.h linux-2.5.39.signedshift/include/linux/timex.h
--- linux-2.5.39.orig/include/linux/timex.h	Mon Sep 16 20:43:47 2002
+++ linux-2.5.39.signedshift/include/linux/timex.h	Sun Sep 29 18:39:23 2002
@@ -75,6 +75,8 @@
 # define SHIFT_HZ	9
 #elif HZ >= 768 && HZ < 1536
 # define SHIFT_HZ	10
+#elif HZ >= 1536 && HZ < 3072
+# define SHIFT_HZ	11
 #else
 # error You lose.
 #endif
