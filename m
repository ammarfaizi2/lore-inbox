Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316208AbSEKL3q>; Sat, 11 May 2002 07:29:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316209AbSEKL3q>; Sat, 11 May 2002 07:29:46 -0400
Received: from gans.physik3.uni-rostock.de ([139.30.44.2]:24581 "EHLO
	gans.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id <S316208AbSEKL3p>; Sat, 11 May 2002 07:29:45 -0400
Date: Sat, 11 May 2002 13:29:42 +0200 (CEST)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: Linus Torvalds <torvalds@transmeta.com>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] 4b/6: better 32 bit accounting
Message-ID: <Pine.LNX.4.33.0205111328410.27137-100000@gans.physik3.uni-rostock.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alternative to [PATCH] 4a/6: 64 bit accounting.

Max out elapsed time at highest representable (unsigned long) value.
While we could stuff two more bits into comp_t on 32 bit platforms, this
should keep old applications happy that expand it into unsigned long
variables.

Compute job start time correctly after 32 bit jiffies wrap.


--- linux-2.5.15-j64/kernel/acct.c	Sun May  5 08:32:04 2002
+++ linux-2.5.15-j64/kernel/acct.c	Sat May 11 13:16:34 2002
@@ -50,6 +50,7 @@
 #include <linux/file.h>
 #include <linux/tty.h>
 #include <asm/uaccess.h>
+#include <asm/div64.h>
 
 /*
  * These constants control the amount of freespace that suspend and
@@ -299,6 +300,7 @@
 	mm_segment_t fs;
 	unsigned long vsize;
 	unsigned long flim;
+	u64 elapsed;
 
 	/*
 	 * First check to see if there is enough free_space to continue
@@ -316,9 +318,11 @@
 	strncpy(ac.ac_comm, current->comm, ACCT_COMM);
 	ac.ac_comm[ACCT_COMM - 1] = '\0';
 
-	ac.ac_btime = CT_TO_SECS(current->start_time) +
-		(xtime.tv_sec - (jiffies / HZ));
-	ac.ac_etime = encode_comp_t(jiffies - current->start_time);
+	elapsed = get_jiffies64() - current->start_time;
+	ac.ac_etime = encode_comp_t(elapsed > (unsigned long) -1l ?
+	                       (unsigned long) -1l : (unsigned long) elapsed);
+	do_div(elapsed, HZ);
+	ac.ac_btime = xtime.tv_sec - elapsed;
 	ac.ac_utime = encode_comp_t(current->times.tms_utime);
 	ac.ac_stime = encode_comp_t(current->times.tms_stime);
 	ac.ac_uid = current->uid;

