Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319036AbSHWS1U>; Fri, 23 Aug 2002 14:27:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319046AbSHWS1U>; Fri, 23 Aug 2002 14:27:20 -0400
Received: from waste.org ([209.173.204.2]:22188 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S319036AbSHWS1S>;
	Fri, 23 Aug 2002 14:27:18 -0400
Date: Fri, 23 Aug 2002 13:31:28 -0500
From: Oliver Xymoron <oxymoron@waste.org>
To: Linus Torvalds <torvalds@transmeta.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] (4/7) trust_pct
Message-ID: <20020823183128.GD2224@waste.org>
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

RML's patch to turn on SA_SAMPLE_RANDOM for most NICs is safe after
this patch.

diff -ur a/drivers/char/random.c b/drivers/char/random.c
--- a/drivers/char/random.c	2002-08-23 12:43:24.000000000 -0500
+++ b/drivers/char/random.c	2002-08-23 12:43:27.000000000 -0500
@@ -694,6 +694,7 @@
 static struct timer_rand_state extract_timer_state;
 static struct timer_rand_state *irq_timer_state[NR_IRQS];
 static struct timer_rand_state *blkdev_timer_state[MAX_BLKDEV];
+static int trust_break=50, trust_pct=0, trust_min=0, trust_max=100;
 
 /*
  * This function adds entropy to the entropy "pool" by using timing
@@ -761,6 +762,17 @@
 
 		entropy = int_log2_16bits(delta);
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
 
@@ -1849,6 +1861,10 @@
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
--- a/include/linux/sysctl.h	2002-08-17 00:30:00.000000000 -0500
+++ b/include/linux/sysctl.h	2002-08-23 12:43:27.000000000 -0500
@@ -182,7 +182,8 @@
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
