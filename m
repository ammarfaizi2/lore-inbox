Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318344AbSIKFMk>; Wed, 11 Sep 2002 01:12:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318345AbSIKFMj>; Wed, 11 Sep 2002 01:12:39 -0400
Received: from waste.org ([209.173.204.2]:20628 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S318344AbSIKFMg>;
	Wed, 11 Sep 2002 01:12:36 -0400
Date: Wed, 11 Sep 2002 00:17:21 -0500
From: Oliver Xymoron <oxymoron@waste.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH 4/11] Entropy fixes - trust_pct for headless
Message-ID: <20020911051721.GS31597@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This allows adding a bit of entropy for a configurable percentage of
untrusted timer samples, controlled by a new sysctl. This defaults to
0 for safety, but can be used on headless machines without a hardware
RNG to continue to use /dev/random with some confidence.

diff -ur a/drivers/char/random.c b/drivers/char/random.c
--- a/drivers/char/random.c	2002-09-07 19:20:27.000000000 -0500
+++ b/drivers/char/random.c	2002-09-07 19:20:30.000000000 -0500
@@ -679,6 +679,7 @@
 static struct timer_rand_state extract_timer_state;
 static struct timer_rand_state *irq_timer_state[NR_IRQS];
 static struct timer_rand_state *blkdev_timer_state[MAX_BLKDEV];
+static int trust_break=50, trust_pct=0, trust_min=0, trust_max=100;
 
 /*
  * This function adds entropy to the entropy "pool" by using timing
@@ -745,6 +746,17 @@
  
 		entropy = fls((delta>>3) & 0xfff);
 	}
+	else if(trust_pct)
+	{
+		/* Count an untrusted bit as entropy trust_pct% of the time */
+		trust_break+=trust_pct;
+		if(trust_break >= 100)
+		{
+			entropy=1;
+			trust_break-=100;
+		}
+	}
+
 	batch_entropy_store(num^time, entropy);
 }
 
@@ -1833,6 +1845,10 @@
 	{RANDOM_UUID, "uuid",
 	 NULL, 16, 0444, NULL,
 	 &proc_do_uuid, &uuid_strategy},
+	{RANDOM_TRUST_PCT, "trust_pct",
+	 &trust_pct, sizeof(int), 0644, NULL,
+	 &proc_dointvec_minmax, &sysctl_intvec, 0,
+	 &trust_min, &trust_max},
 	{0}
 };
 
diff -ur a/include/linux/sysctl.h b/include/linux/sysctl.h
--- a/include/linux/sysctl.h	2002-09-04 11:28:54.000000000 -0500
+++ b/include/linux/sysctl.h	2002-09-07 19:20:30.000000000 -0500
@@ -183,7 +183,8 @@
 	RANDOM_READ_THRESH=3,
 	RANDOM_WRITE_THRESH=4,
 	RANDOM_BOOT_ID=5,
-	RANDOM_UUID=6
+	RANDOM_UUID=6,
+	RANDOM_TRUST_PCT=7
 };
 
 /* /proc/sys/bus/isa */


-- 
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.." 
