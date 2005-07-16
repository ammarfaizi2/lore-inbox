Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262075AbVGPDMC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262075AbVGPDMC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Jul 2005 23:12:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262169AbVGPDKY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Jul 2005 23:10:24 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:39835 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S262168AbVGPDH6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Jul 2005 23:07:58 -0400
Subject: [RFC][PATCH - 11/12] NTP cleanup: Introduce PPM adjustment
	variables
From: john stultz <johnstul@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: George Anzinger <george@mvista.com>, frank@tuxrocks.com,
       Anton Blanchard <anton@samba.org>, benh@kernel.crashing.org,
       Nishanth Aravamudan <nacc@us.ibm.com>,
       Roman Zippel <zippel@linux-m68k.org>
In-Reply-To: <1121483202.28638.6.camel@cog.beaverton.ibm.com>
References: <1121482517.25236.29.camel@cog.beaverton.ibm.com>
	 <1121482620.25236.31.camel@cog.beaverton.ibm.com>
	 <1121482672.25236.33.camel@cog.beaverton.ibm.com>
	 <1121482713.25236.35.camel@cog.beaverton.ibm.com>
	 <1121482758.25236.37.camel@cog.beaverton.ibm.com>
	 <1121482804.25236.39.camel@cog.beaverton.ibm.com>
	 <1121482925.25236.42.camel@cog.beaverton.ibm.com>
	 <1121483064.28638.0.camel@cog.beaverton.ibm.com>
	 <1121483101.28638.2.camel@cog.beaverton.ibm.com>
	 <1121483160.28638.4.camel@cog.beaverton.ibm.com>
	 <1121483202.28638.6.camel@cog.beaverton.ibm.com>
Content-Type: text/plain
Date: Fri, 15 Jul 2005 20:07:54 -0700
Message-Id: <1121483274.28638.9.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All,
	This patch introduces variables to keep track of the different NTP
adjustment values in PPM units. It also introduces the
ntp_get_adjustment() interface which returns shifted PPM units. The
patch also changes the ppc64 ppc_adjtimex() function to use
ntp_get_adjustment(). 
	
	This will likely need careful review from the ppc64 folks. There are
some subtle differences between what ntp_get_adjustment() returns and
what ppc_adjtimex() calculates.

Any comments or feedback would be greatly appreciated.

thanks
-john

linux-2.6.13-rc3_timeofday-ntp-part11_B4.patch
============================================
diff --git a/arch/ppc64/kernel/time.c b/arch/ppc64/kernel/time.c
--- a/arch/ppc64/kernel/time.c
+++ b/arch/ppc64/kernel/time.c
@@ -106,8 +106,6 @@ extern struct timezone sys_tz;
 
 void ppc_adjtimex(void);
 
-static unsigned adjusting_time = 0;
-
 unsigned long ppc_proc_freq;
 unsigned long ppc_tb_freq;
 
@@ -355,8 +353,7 @@ int timer_interrupt(struct pt_regs * reg
 			timer_sync_xtime(lpaca->next_jiffy_update_tb);
 			timer_check_rtc();
 			write_sequnlock(&xtime_lock);
-			if ( adjusting_time && (ntp_adjtime_offset == 0) )
-				ppc_adjtimex();
+			ppc_adjtimex();
 		}
 		lpaca->next_jiffy_update_tb += tb_ticks_per_jiffy;
 	}
@@ -582,7 +579,7 @@ void __init time_init(void)
 	systemcfg->stamp_xsec = xtime.tv_sec * XSEC_PER_SEC;
 	systemcfg->tb_to_xs = tb_to_xs;
 
-	ntp_freq = 0;
+	ntp_clear();
 
 	xtime.tv_nsec = 0;
 	last_rtc_update = xtime.tv_sec;
@@ -599,7 +596,7 @@ void __init time_init(void)
  * to microseconds to keep do_gettimeofday synchronized 
  * with ntpd.
  *
- * Use the ntp_adjtime_offset, ntp_freq and ntp_offset computed by adjtimex to 
+ * Use the ntp_get_adjustment computed by adjtimex to 
  * adjust the frequency.
  */
 
@@ -609,62 +606,14 @@ void ppc_adjtimex(void)
 {
 	unsigned long den, new_tb_ticks_per_sec, tb_ticks, old_xsec, new_tb_to_xs, new_xsec, new_stamp_xsec;
 	unsigned long tb_ticks_per_sec_delta;
-	long delta_freq, ltemp;
+	long delta_freq;
 	struct div_result divres; 
 	unsigned long flags;
 	struct gettimeofday_vars * temp_varp;
 	unsigned temp_idx;
-	long singleshot_ppm = 0;
 
-	/* Compute parts per million frequency adjustment to accomplish the time adjustment
-	   implied by ntp_offset to be applied over the elapsed time indicated by ntp_constant.
-	   Use SHIFT_USEC to get it into the same units as ntp_freq. */
-	if ( ntp_offset < 0 ) {
-		ltemp = -ntp_offset;
-		ltemp <<= SHIFT_USEC - SHIFT_UPDATE;
-		ltemp >>= SHIFT_KG + ntp_constant;
-		ltemp = -ltemp;
-	}
-	else {
-		ltemp = ntp_offset;
-		ltemp <<= SHIFT_USEC - SHIFT_UPDATE;
-		ltemp >>= SHIFT_KG + ntp_constant;
-	}
-	
-	/* If there is a single shot time adjustment in progress */
-	if ( ntp_adjtime_offset ) {
-#ifdef DEBUG_PPC_ADJTIMEX
-		printk("ppc_adjtimex: ");
-		if ( adjusting_time == 0 )
-			printk("starting ");
-		printk("single shot ntp_adjtime_offset = %ld\n", ntp_adjtime_offset);
-#endif	
-	
-		adjusting_time = 1;
-		
-		/* Compute parts per million frequency adjustment to match ntp_adjtime_offset */
-		singleshot_ppm = tickadj * HZ;	
-		/*
-		 * The adjustment should be tickadj*HZ to match the code in
-		 * linux/kernel/timer.c, but experiments show that this is too
-		 * large. 3/4 of tickadj*HZ seems about right
-		 */
-		singleshot_ppm -= singleshot_ppm / 4;
-		/* Use SHIFT_USEC to get it into the same units as ntp_freq */	
-		singleshot_ppm <<= SHIFT_USEC;
-		if ( ntp_adjtime_offset < 0 )
-			singleshot_ppm = -singleshot_ppm;
-	}
-	else {
-#ifdef DEBUG_PPC_ADJTIMEX
-		if ( adjusting_time )
-			printk("ppc_adjtimex: ending single shot ntp_adjtime_offset\n");
-#endif
-		adjusting_time = 0;
-	}
-	
 	/* Add up all of the frequency adjustments */
-	delta_freq = ntp_freq + ltemp + singleshot_ppm;
+	delta_freq = ntp_get_adjustment();
 	
 	/* Compute a new value for tb_ticks_per_sec based on the frequency adjustment */
 	den = 1000000 * (1 << (SHIFT_USEC - 8));
@@ -678,7 +627,7 @@ void ppc_adjtimex(void)
 	}
 	
 #ifdef DEBUG_PPC_ADJTIMEX
-	printk("ppc_adjtimex: ltemp = %ld, ntp_freq = %ld, singleshot_ppm = %ld\n", ltemp, ntp_freq, singleshot_ppm);
+	printk("ppc_adjtimex: delta_freq = %ld\n", delta_freq);
 	printk("ppc_adjtimex: tb_ticks_per_sec - base = %ld  new = %ld\n", tb_ticks_per_sec, new_tb_ticks_per_sec);
 #endif
 				
diff --git a/include/linux/ntp.h b/include/linux/ntp.h
--- a/include/linux/ntp.h
+++ b/include/linux/ntp.h
@@ -15,14 +15,10 @@ int ntp_adjtimex(struct timex*);
 int ntp_leapsecond(struct timespec now);
 void ntp_clear(void);
 int ntp_synced(void);
+long ntp_get_adjustment(void);
 
-/* Due to ppc64 having its own NTP  code,
- * these variables cannot be made static just yet
- */
+/* these variables cannot be made static just yet */
 extern int tickadj;
-extern long ntp_offset;
-extern long ntp_freq;
 extern long ntp_adjtime_offset;
-extern long ntp_constant;
 
 #endif
diff --git a/kernel/ntp.c b/kernel/ntp.c
--- a/kernel/ntp.c
+++ b/kernel/ntp.c
@@ -41,6 +41,7 @@
 *
 *********************************************************************/
 
+#include <linux/kernel.h>
 #include <linux/ntp.h>
 #include <linux/jiffies.h>
 #include <linux/errno.h>
@@ -53,15 +54,15 @@ static long time_adj;                   
 /* Chapter 5: Kernel Variables [RFC 1589 pg. 28] */
 /* 5.1 Interface Variables */
 static int ntp_status = STA_UNSYNC;             /* status */
-long ntp_offset;                                /* usec */
-long ntp_constant = 2;                          /* ntp magic? */
+static long ntp_offset;                         /* usec */
+static long ntp_constant = 2;                   /* ntp magic? */
 static long ntp_maxerror = NTP_PHASE_LIMIT;     /* usec */
 static long ntp_esterror = NTP_PHASE_LIMIT;     /* usec */
 static const long ntp_tolerance	= MAXFREQ;      /* shifted ppm */
 static const long ntp_precision	= 1;            /* constant */
 
 /* 5.2 Phase-Lock Loop Variables */
-long ntp_freq;                                  /* shifted ppm */
+static long ntp_freq;                           /* shifted ppm */
 static long ntp_reftime;                        /* sec */
 
 /* Extra values */
@@ -69,9 +70,16 @@ static int ntp_state    = TIME_OK;      
 long ntp_adjtime_offset;
 static long ntp_next_adjtime_offset;
 
+static long singleshot_adj; /* +/- MAX_SINGLESHOT_ADJ (ppm)*/
+static long tick_adj;       /* txc->tick adjustment (ppm) */
+static long offset_adj;     /* offset adjustment (ppm) */
+
+static long shifted_ppm_sum; /* ppm<<SHIFT_USEC sum of total freq adj */
+
 /* lock for the above variables */
 static seqlock_t ntp_lock = SEQLOCK_UNLOCKED;
 
+#define MAX_SINGLESHOT_ADJ 500 /* (ppm) */
 #define SEC_PER_DAY 86400
 
 /* Required to safely shift negative values */
@@ -82,6 +90,7 @@ int ntp_advance(unsigned long interval_n
 	static unsigned long interval_sum = 0;
 	long time_adjust_step, delta_nsec;
 	unsigned long flags;
+	static long ss_adj = 0;
 
 	write_seqlock_irqsave(&ntp_lock, flags);
 
@@ -119,11 +128,11 @@ int ntp_advance(unsigned long interval_n
 		next_adj = min(next_adj, (MAXPHASE / MINSEC) << SHIFT_UPDATE);
 		next_adj = max(next_adj, -(MAXPHASE / MINSEC) << SHIFT_UPDATE);
 		ntp_offset -= next_adj;
+		offset_adj = shiftR(next_adj, SHIFT_UPDATE); /* ppm */
 
-		time_adj = next_adj << (SHIFT_SCALE - SHIFT_HZ - SHIFT_UPDATE);
 
+		time_adj = next_adj << (SHIFT_SCALE - SHIFT_HZ - SHIFT_UPDATE);
 		time_adj += shiftR(ntp_freq, (SHIFT_USEC + SHIFT_HZ - SHIFT_SCALE));
-
 #if HZ == 100
     	/* Compensate for (HZ==100) != (1 << SHIFT_HZ).
 	     * Add 25% and 3.125% to get 128.125;
@@ -138,9 +147,17 @@ int ntp_advance(unsigned long interval_n
 	     */
 		time_adj += shiftR(time_adj,6) + shiftR(time_adj,7);
 #endif
-
+		/* Set ss_adj for the next second */
+		ss_adj = min_t(unsigned long, singleshot_adj, MAX_SINGLESHOT_ADJ);
+		singleshot_adj -= ss_adj;
 	}
 
+	/* calculate total shifted ppm adjustment for the next interval */
+	shifted_ppm_sum = tick_adj<<SHIFT_USEC;
+	shifted_ppm_sum += offset_adj << SHIFT_USEC;
+	shifted_ppm_sum += ntp_freq; /* already shifted by SHIFT_USEC */
+	shifted_ppm_sum += ss_adj << SHIFT_USEC;
+
 
 	if ( (time_adjust_step = ntp_adjtime_offset) != 0 ) {
 	    /* We are doing an adjtime thing.
@@ -334,11 +351,17 @@ int ntp_adjtimex(struct timex *txc)
 			/* adjtime() is independent from ntp_adjtime() */
 			if ((ntp_next_adjtime_offset = txc->offset) == 0)
 				ntp_adjtime_offset = 0;
+			singleshot_adj = txc->offset;
 		} else if (ntp_hardupdate(txc->offset, txc->time))
 			result = TIME_ERROR;
 	}
 
 	if (txc->modes & ADJ_TICK) {
+		/* first calculate usec/user_tick offset */
+		tick_adj = ((USEC_PER_SEC + USER_HZ/2)/USER_HZ) - txc->tick;
+		/* multiply by user_hz to get usec/sec => ppm */
+		tick_adj *= USER_HZ;
+
 		tick_usec = txc->tick;
 		tick_nsec = TICK_USEC_TO_NSEC(tick_usec);
 	}
@@ -456,6 +479,9 @@ void ntp_clear(void)
 	ntp_status |= STA_UNSYNC;
 	ntp_maxerror = NTP_PHASE_LIMIT;
 	ntp_esterror = NTP_PHASE_LIMIT;
+	singleshot_adj = 0;
+	tick_adj = 0;
+	offset_adj =0;
 
 	write_sequnlock_irqrestore(&ntp_lock, flags);
 }
@@ -469,3 +495,12 @@ int ntp_synced(void)
 	return !(ntp_status & STA_UNSYNC);
 }
 
+
+/**
+ * ntp_get_adjustment - Returns Shifted PPM adjustment
+ *
+ */
+long ntp_get_adjustment(void)
+{
+	return shifted_ppm_sum;
+}


