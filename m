Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275888AbSIUKuA>; Sat, 21 Sep 2002 06:50:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275894AbSIUKuA>; Sat, 21 Sep 2002 06:50:00 -0400
Received: from vti01.vertis.nl ([145.66.4.26]:35343 "EHLO vti01.vertis.nl")
	by vger.kernel.org with ESMTP id <S275888AbSIUKt7>;
	Sat, 21 Sep 2002 06:49:59 -0400
Date: Sat, 21 Sep 2002 12:53:30 +0200
From: Rolf Fokkens <fokkensr@fokkensr.vertis.nl>
Message-Id: <200209211053.g8LArUp02243@fokkensr.vertis.nl>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] sg.c and USER_HZ, kernel 2.5.37
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Since the introduction of USER_HZ the SG_[GS]ET_TIMEOUT ioctls may have
a serious BUG as userspace uses a different HZ from the HZ in kernelspace.

In x86 HZ=1000 and USER_HZ=100, resulting in confusing timouts as the
kernel measures time 10 times as fast as userspace.

This patch is an attempt to fix this by transforming USER_HZ based timing to
HZ based timing before storing it in timeout. To make sure that SG_GET_TIMEOUT
and SG_SET_TIMEOUT behave consistently a field timeout_user is added which
stores the exact value that's passed by SG_SET_TIMEOUT and it's returned on
SG_GET_TIMEOUT.

Rolf Fokkens
fokkensr@fokkensr.vertis.nl

P.S. this is the second post of this patch

--- linux-2.5.37.orig/drivers/scsi/sg.c	Sun Sep  8 09:00:32 2002
+++ linux-2.5.37/drivers/scsi/sg.c	Sat Sep 21 00:31:23 2002
@@ -82,6 +82,19 @@
 
 #define SG_MAX_DEVS_MASK ((1U << KDEV_MINOR_BITS) - 1)
 
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
+#define SG_DEFAULT_TIMEOUT MULDIV(SG_DEFAULT_TIMEOUT_USER, HZ, USER_HZ)
+
 int sg_big_buff = SG_DEF_RESERVED_SIZE;
 /* N.B. This variable is readable and writeable via
    /proc/scsi/sg/def_reserved_size . Each time sg_open() is called a buffer
@@ -150,7 +163,8 @@
 	struct sg_device *parentdp;	/* owning device */
 	wait_queue_head_t read_wait;	/* queue read until command done */
 	rwlock_t rq_list_lock;	/* protect access to list in req_arr */
-	int timeout;		/* defaults to SG_DEFAULT_TIMEOUT */
+	int timeout;		/* defaults to SG_DEFAULT_TIMEOUT      */
+	int timeout_user;	/* defaults to SG_DEFAULT_TIMEOUT_USER */
 	Sg_scatter_hold reserve;	/* buffer held for this file descriptor */
 	unsigned save_scat_len;	/* original length of trunc. scat. element */
 	Sg_request *headrp;	/* head of request slist, NULL->empty */
@@ -790,10 +804,15 @@
 			return result;
 		if (val < 0)
 			return -EIO;
-		sfp->timeout = val;
+		if (val >= MULDIV (INT_MAX, USER_HZ, HZ))
+		    val = MULDIV (INT_MAX, USER_HZ, HZ);
+		sfp->timeout_user = val;
+		sfp->timeout = MULDIV (val, HZ, USER_HZ);
+
 		return 0;
 	case SG_GET_TIMEOUT:	/* N.B. User receives timeout as return value */
-		return sfp->timeout;	/* strange ..., for backward compatibility */
+				/* strange ..., for backward compatibility */
+		return sfp->timeout_user;
 	case SG_SET_FORCE_LOW_DMA:
 		result = get_user(val, (int *) arg);
 		if (result)
@@ -2431,6 +2450,7 @@
 	sfp->rq_list_lock = RW_LOCK_UNLOCKED;
 
 	sfp->timeout = SG_DEFAULT_TIMEOUT;
+	sfp->timeout_user = SG_DEFAULT_TIMEOUT_USER;
 	sfp->force_packid = SG_DEF_FORCE_PACK_ID;
 	sfp->low_dma = (SG_DEF_FORCE_LOW_DMA == 0) ?
 	    sdp->device->host->unchecked_isa_dma : 1;
--- linux-2.5.37.orig/include/scsi/sg.h	Sun Sep  8 09:00:19 2002
+++ linux-2.5.37/include/scsi/sg.h	Sat Sep 21 00:31:23 2002
@@ -304,7 +304,12 @@
 
 
 /* Defaults, commented if they differ from original sg driver */
-#define SG_DEFAULT_TIMEOUT (60*HZ) /* HZ == 'jiffies in 1 second' */
+#ifdef __KERNEL__
+#define SG_DEFAULT_TIMEOUT_USER	(60*USER_HZ) /* HZ == 'jiffies in 1 second' */
+#else
+#define SG_DEFAULT_TIMEOUT	(60*HZ)	     /* HZ == 'jiffies in 1 second' */
+#endif
+
 #define SG_DEF_COMMAND_Q 0     /* command queuing is always on when
 				  the new interface is used */
 #define SG_DEF_UNDERRUN_FLAG 0
