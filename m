Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267746AbUHJWTh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267746AbUHJWTh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 18:19:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267774AbUHJWTh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 18:19:37 -0400
Received: from ozlabs.org ([203.10.76.45]:41420 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S267746AbUHJWTd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 18:19:33 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16665.18932.292154.756992@cargo.ozlabs.ibm.com>
Date: Wed, 11 Aug 2004 08:19:32 +1000
From: Paul Mackerras <paulus@samba.org>
To: akpm@osdl.org
Cc: anton@samba.org, olh@suse.de, linux-kernel@vger.kernel.org
Subject: [PATCH] PPC64 Set time-related systemcfg fields
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Somewhere along the line we lost the code that updates some fields of
the systemcfg structure that are used for translating timebase values
to time of day.  I want to get rid of the systemcfg structure
eventually, but applications are using it (and in particular these
fields) and I don't want to break the ABI in a stable kernel series.

Please apply.

Signed-off-by: Paul Mackerras <paulus@samba.org>

diff -urN linux-2.5/arch/ppc64/kernel/smp.c ppc64/arch/ppc64/kernel/smp.c
--- linux-2.5/arch/ppc64/kernel/smp.c	2004-08-06 07:15:01.000000000 +1000
+++ ppc64/arch/ppc64/kernel/smp.c	2004-08-11 08:11:22.080930712 +1000
@@ -843,6 +843,7 @@
 	 * number of msecs off until someone does a settimeofday()
 	 */
 	do_gtod.tb_orig_stamp = tb_last_stamp;
+	systemcfg->tb_orig_stamp = tb_last_stamp;
 
 	look_for_more_cpus();
 #endif
diff -urN linux-2.5/arch/ppc64/kernel/time.c ppc64/arch/ppc64/kernel/time.c
--- linux-2.5/arch/ppc64/kernel/time.c	2004-07-05 11:49:19.000000000 +1000
+++ ppc64/arch/ppc64/kernel/time.c	2004-08-11 08:08:53.345044408 +1000
@@ -101,6 +101,8 @@
 extern unsigned long lpevent_count;
 extern int smp_tb_synchronized;
 
+extern struct timezone sys_tz;
+
 void ppc_adjtimex(void);
 
 static unsigned adjusting_time = 0;
@@ -233,6 +235,8 @@
 				do_gtod.tb_ticks_per_sec = tb_ticks_per_sec;
 				tb_to_xs = divres.result_low;
 				do_gtod.varp->tb_to_xs = tb_to_xs;
+				systemcfg->tb_ticks_per_sec = tb_ticks_per_sec;
+				systemcfg->tb_to_xs = tb_to_xs;
 			}
 			else {
 				printk( "Titan recalibrate: FAILED (difference > 4 percent)\n"
@@ -408,6 +412,7 @@
 	new_xsec += new_sec * XSEC_PER_SEC;
 	if ( new_xsec > delta_xsec ) {
 		do_gtod.varp->stamp_xsec = new_xsec - delta_xsec;
+		systemcfg->stamp_xsec = new_xsec - delta_xsec;
 	}
 	else {
 		/* This is only for the case where the user is setting the time
@@ -416,8 +421,13 @@
 		 * the time to Jan 5, 1970 */
 		do_gtod.varp->stamp_xsec = new_xsec;
 		do_gtod.tb_orig_stamp = tb_last_stamp;
+		systemcfg->stamp_xsec = new_xsec;
+		systemcfg->tb_orig_stamp = tb_last_stamp;
 	}
 
+	systemcfg->tz_minuteswest = sys_tz.tz_minuteswest;
+	systemcfg->tz_dsttime = sys_tz.tz_dsttime;
+
 	write_sequnlock_irqrestore(&xtime_lock, flags);
 	clock_was_set();
 	return 0;
@@ -520,6 +530,11 @@
 	do_gtod.tb_ticks_per_sec = tb_ticks_per_sec;
 	do_gtod.varp->tb_to_xs = tb_to_xs;
 	do_gtod.tb_to_us = tb_to_us;
+	systemcfg->tb_orig_stamp = tb_last_stamp;
+	systemcfg->tb_update_count = 0;
+	systemcfg->tb_ticks_per_sec = tb_ticks_per_sec;
+	systemcfg->stamp_xsec = xtime.tv_sec * XSEC_PER_SEC;
+	systemcfg->tb_to_xs = tb_to_xs;
 
 	xtime_sync_interval = tb_ticks_per_sec - (tb_ticks_per_sec/8);
 	next_xtime_sync_tb = tb_last_stamp + xtime_sync_interval;
@@ -655,6 +670,22 @@
 	do_gtod.varp = temp_varp;
 	do_gtod.var_idx = temp_idx;
 
+	/*
+	 * tb_update_count is used to allow the problem state gettimeofday code
+	 * to assure itself that it sees a consistent view of the tb_to_xs and
+	 * stamp_xsec variables.  It reads the tb_update_count, then reads
+	 * tb_to_xs and stamp_xsec and then reads tb_update_count again.  If
+	 * the two values of tb_update_count match and are even then the
+	 * tb_to_xs and stamp_xsec values are consistent.  If not, then it
+	 * loops back and reads them again until this criteria is met.
+	 */
+	++(systemcfg->tb_update_count);
+	wmb();
+	systemcfg->tb_to_xs = new_tb_to_xs;
+	systemcfg->stamp_xsec = new_stamp_xsec;
+	wmb();
+	++(systemcfg->tb_update_count);
+
 	write_sequnlock_irqrestore( &xtime_lock, flags );
 
 }
