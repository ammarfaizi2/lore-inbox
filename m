Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314675AbSEKKu3>; Sat, 11 May 2002 06:50:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314676AbSEKKu3>; Sat, 11 May 2002 06:50:29 -0400
Received: from gans.physik3.uni-rostock.de ([139.30.44.2]:23045 "EHLO
	gans.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id <S314675AbSEKKu2>; Sat, 11 May 2002 06:50:28 -0400
Date: Sat, 11 May 2002 12:50:25 +0200 (CEST)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: Linus Torvalds <torvalds@transmeta.com>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] 4a/6: 64 bit accounting 
In-Reply-To: <Pine.LNX.4.33.0205111227290.26626-100000@gans.physik3.uni-rostock.de>
Message-ID: <Pine.LNX.4.33.0205111247460.26874-100000@gans.physik3.uni-rostock.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, PATCH] 4/6: 64 bit accounting had a wrong description.
Same patch again, but this time described correctly (I hope):

comp_t as used by the accounting code is able to export values up to
(2^34-2^21). So lets use the two extra bits to export elapsed time
correctly after 32 bit jiffies wrap.

Applications not aware of this change will probably overflow when
expanding comp_t into a 32 bit variable, thus see no difference
with this patch.

Start time is reported in seconds, and now is correct even after
32 bit jiffies wrap.

Per process user and system times are still 32 bit, but are less likely to
overflow than the elapsed time.


Maybe accounting isn't worth of major changes, so I'll post an alternate
patch (4b/6) where etime just maxes out at the highest representable
32 bit value for the benefit of older, 32 bit applications.


--- linux-2.5.15/kernel/acct.c	Sun May  5 08:32:04 2002
+++ linux-2.5.15-j64/kernel/acct.c	Thu May  9 18:14:24 2002
@@ -50,6 +50,7 @@
 #include <linux/file.h>
 #include <linux/tty.h>
 #include <asm/uaccess.h>
+#include <asm/div64.h>
 
 /*
  * These constants control the amount of freespace that suspend and
@@ -248,20 +249,24 @@
  *  This routine has been adopted from the encode_comp_t() function in
  *  the kern_acct.c file of the FreeBSD operating system. The encoding
  *  is a 13-bit fraction with a 3-bit (base 8) exponent.
+ *
+ *  Bumped up to encode 64 bit values. Unfortunately the result may
+ *  overflow now.
  */
 
 #define	MANTSIZE	13			/* 13 bit mantissa. */
-#define	EXPSIZE		3			/* Base 8 (3 bit) exponent. */
+#define	EXPSIZE		3			/* 3 bit exponent. */
+#define	EXPBASE		3			/* Base 8 (3 bit) exponent. */
 #define	MAXFRACT	((1 << MANTSIZE) - 1)	/* Maximum fractional value. */
 
-static comp_t encode_comp_t(unsigned long value)
+static comp_t encode_comp_t(u64 value)
 {
 	int exp, rnd;
 
 	exp = rnd = 0;
 	while (value > MAXFRACT) {
-		rnd = value & (1 << (EXPSIZE - 1));	/* Round up? */
-		value >>= EXPSIZE;	/* Base 8 exponent == 3 bit shift. */
+		rnd = value & (1 << (EXPBASE - 1));	/* Round up? */
+		value >>= EXPBASE;	/* Base 8 exponent == 3 bit shift. */
 		exp++;
 	}
 
@@ -269,16 +274,21 @@
          * If we need to round up, do it (and handle overflow correctly).
          */
 	if (rnd && (++value > MAXFRACT)) {
-		value >>= EXPSIZE;
+		value >>= EXPBASE;
 		exp++;
 	}
 
 	/*
          * Clean it up and polish it off.
          */
-	exp <<= MANTSIZE;		/* Shift the exponent into place */
-	exp += value;			/* and add on the mantissa. */
-	return exp;
+	if (exp >= (1 << EXPSIZE)) {
+		/* Overflow. Return largest representable number instead. */
+		return (1ul << (MANTSIZE + EXPSIZE)) - 1;
+	} else {
+		exp <<= MANTSIZE;	/* Shift the exponent into place */
+		exp += value;		/* and add on the mantissa. */
+		return exp;
+	}
 }
 
 /*
@@ -299,6 +309,7 @@
 	mm_segment_t fs;
 	unsigned long vsize;
 	unsigned long flim;
+	u64 elapsed;
 
 	/*
 	 * First check to see if there is enough free_space to continue
@@ -316,9 +327,10 @@
 	strncpy(ac.ac_comm, current->comm, ACCT_COMM);
 	ac.ac_comm[ACCT_COMM - 1] = '\0';
 
-	ac.ac_btime = CT_TO_SECS(current->start_time) +
-		(xtime.tv_sec - (jiffies / HZ));
-	ac.ac_etime = encode_comp_t(jiffies - current->start_time);
+	elapsed = get_jiffies64() - current->start_time;
+	ac.ac_etime = encode_comp_t(elapsed);
+	do_div(elapsed, HZ);
+	ac.ac_btime = xtime.tv_sec - elapsed;
 	ac.ac_utime = encode_comp_t(current->times.tms_utime);
 	ac.ac_stime = encode_comp_t(current->times.tms_stime);
 	ac.ac_uid = current->uid;

