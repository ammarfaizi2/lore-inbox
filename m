Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319655AbSIMTjP>; Fri, 13 Sep 2002 15:39:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319667AbSIMTjP>; Fri, 13 Sep 2002 15:39:15 -0400
Received: from vti01.vertis.nl ([145.66.4.26]:57872 "EHLO vti01.vertis.nl")
	by vger.kernel.org with ESMTP id <S319655AbSIMTjO>;
	Fri, 13 Sep 2002 15:39:14 -0400
Date: Fri, 13 Sep 2002 21:42:57 +0200
From: Rolf Fokkens <fokkensr@fokkensr.vertis.nl>
Message-Id: <200209131942.g8DJgv005332@fokkensr.vertis.nl>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] USER_HZ & SG problem [timeouts]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

One of the places in the kernel where HZ is interfaced with userspace
is in the SG driver. With HZ different from USER_HZ this may result
in all kinds of unexpected timeouts when using SG.

This patch is an attempt to fix this by transforming USER_HZ based timing to
HZ based timing an v.v. A problem I know of is the fact that SG_GET_TIMEOUT
may return a different value than the value that was passed on with
SG_SET_TIMEOUT.  Depending on its impact this may need to be solved by
adding a field "user_timeout" to Sg_fd which contains the USER_HZ based value.

Cheers,

Rolf

--- linux-2.5.34.orig/drivers/scsi/sg.c	Sun Sep  8 09:00:32 2002
+++ linux-2.5.34/drivers/scsi/sg.c	Fri Sep 13 21:30:24 2002
@@ -731,6 +731,17 @@
 	return 0;
 }
 
+/*
+ * Suppose you want to calculate the formula muldiv(x,m,d)=int(x * m / d)
+ * Then when using 32 bit integers x * m may overflow during the calculation.
+ * Replacing muldiv(x) by muldiv(x)=((x % d) * m) / d + int(x / d) * m
+ * calculates the same, but prevents the overflow when both m and d
+ * are "small" numbers (like HZ and USER_HZ).
+ * Of course an overflow is inavoidable if the result of muldiv doesn't fit
+ * in 32 bits.
+ */
+#define MULDIV(X,MUL,DIV) ((((X % DIV) * MUL) / DIV) + ((X / DIV) * MUL))
+
 static int
 sg_ioctl(struct inode *inode, struct file *filp,
 	 unsigned int cmd_in, unsigned long arg)
@@ -790,10 +801,15 @@
 			return result;
 		if (val < 0)
 			return -EIO;
-		sfp->timeout = val;
+		if (val >= MULDIV (INT_MAX, USER_HZ, HZ))
+		    val = MULDIV (INT_MAX, USER_HZ, HZ);
+		sfp->timeout = MULDIV (val, HZ, USER_HZ);
+
 		return 0;
 	case SG_GET_TIMEOUT:	/* N.B. User receives timeout as return value */
-		return sfp->timeout;	/* strange ..., for backward compatibility */
+		val = sfp->timeout;
+		val = MULDIV (val, USER_HZ, HZ);
+		return val;	/* strange ..., for backward compatibility */
 	case SG_SET_FORCE_LOW_DMA:
 		result = get_user(val, (int *) arg);
 		if (result)
