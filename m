Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261236AbVDSA76@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261236AbVDSA76 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Apr 2005 20:59:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261237AbVDSA76
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Apr 2005 20:59:58 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:22747 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S261236AbVDSA7L
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Apr 2005 20:59:11 -0400
Subject: [RFC][PATCH] X86_64: no legacy HPET fix (v. A1)
From: john stultz <johnstul@us.ibm.com>
To: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
Cc: lkml <linux-kernel@vger.kernel.org>, Andi Kleen <ak@suse.de>
In-Reply-To: <20050413192103.A27092@unix-os.sc.intel.com>
References: <1113360197.19541.43.camel@cog.beaverton.ibm.com>
	 <20050413192103.A27092@unix-os.sc.intel.com>
Content-Type: text/plain
Date: Mon, 18 Apr 2005 17:59:06 -0700
Message-Id: <1113872346.19541.128.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-04-13 at 19:21 -0700, Venkatesh Pallipadi wrote:
> 
> This adds another timer combination of PIT/HPET to go with
> HPET/HPET, HPET/TSC and PIT/TSC!
> This system that has HPET and doesn't have Legacy support, does it support
> routing HPET interrupts through IOAPIC in standard routing option? If yes,
> then I think adding support to route HPET interrupts in a non-legacy way
> (using IRQs other than IRQ 0) is another option here. I looked at that 
> when adding initial HPET support on i386, but dropped that idea after looking
> at all the changes required and also due to the reason that all HPET capable
> systems I had also had Legacy Support.

Using HPET interrupts via the IOAPIC would be a possibility, but seems
more invasive then what I'm proposing. 

> Some comments on the patch inlined below..
> 
> On Tue, Apr 12, 2005 at 07:43:16PM -0700, john stultz wrote:
> > 
> > Its likely a similar patch will be necessary for i386.
> Yes. Pretty much similar change will be required in i386 as well..

I've still got that on my list.


> > linux-2.6.12-rc2_hpet-nolegacy-fix_A0
> > =====================================
> > diff -Nru a/arch/x86_64/kernel/time.c b/arch/x86_64/kernel/time.c
> > --- a/arch/x86_64/kernel/time.c	2005-04-12 19:31:50 -07:00
> > +++ b/arch/x86_64/kernel/time.c	2005-04-12 19:31:50 -07:00
> > @@ -373,8 +374,10 @@
> >  
> >  	write_seqlock(&xtime_lock);
> >  
> > -	if (vxtime.hpet_address) {
> > -		offset = hpet_readl(HPET_T0_CMP) - hpet_tick;
> > +	if (vxtime.hpet_address)
> > +		offset = hpet_readl(HPET_COUNTER);
> > +
> > +	if (hpet_use_timer) {
> >  		delay = hpet_readl(HPET_COUNTER) - offset;
> 
> Probably this has to change to use HPET_T0_CMP for offset, when hpet_use_timer.
> Otherwise we will always have delay close to zero in case of hpet_use_timer,
> which is a change in behaviour.

Ok, done. 


> >  	} else {
> >  		spin_lock(&i8253_lock);
> > @@ -732,7 +735,7 @@
> >  	struct hpet_data	hd;
> >  	unsigned int 		ntimer;
> >  
> > -	if (!vxtime.hpet_address)
> > +	if (!hpet_use_timer)
> >            return -1;
> 
> We may need to do some initialization here even in case of !hpet_use_timer.
> Like reserving particular HPET timer for timer use. Otherwise, someone
> else (/dev/hpet) can overwrite the counter. I think we just need to skip 
> setting the interupts part.

I just went back to leaving that change out, then.

Let me know if you have any further comments on the updated patch
(included below). If not I'll submit it to Andrew and the Distros.

thanks
-john

linux-2.6.12-rc2_hpet-nolegacy-fix_A1
=====================================
diff -Nru a/arch/x86_64/kernel/time.c b/arch/x86_64/kernel/time.c
--- a/arch/x86_64/kernel/time.c	2005-04-18 10:00:44 -07:00
+++ b/arch/x86_64/kernel/time.c	2005-04-18 10:00:44 -07:00
@@ -60,6 +60,7 @@
 unsigned int cpu_khz;					/* TSC clocks / usec, not used here */
 static unsigned long hpet_period;			/* fsecs / HPET clock */
 unsigned long hpet_tick;				/* HPET clocks / interrupt */
+static int hpet_use_timer;
 unsigned long vxtime_hz = PIT_TICK_RATE;
 int report_lost_ticks;				/* command line option */
 unsigned long long monotonic_base;
@@ -297,7 +298,7 @@
 
 			last_offset = vxtime.last;
 			base = monotonic_base;
-			this_offset = hpet_readl(HPET_T0_CMP) - hpet_tick;
+			this_offset = hpet_readl(HPET_COUNTER);
 
 		} while (read_seqretry(&xtime_lock, seq));
 		offset = (this_offset - last_offset);
@@ -373,7 +374,14 @@
 
 	write_seqlock(&xtime_lock);
 
-	if (vxtime.hpet_address) {
+	if (vxtime.hpet_address)
+		offset = hpet_readl(HPET_COUNTER);
+
+	if (hpet_use_timer) {
+		/* if we're using the hpet timer functionality, 
+		 * we can more accurately know the counter value 
+		 * when the timer interrupt occured.
+		 */
 		offset = hpet_readl(HPET_T0_CMP) - hpet_tick;
 		delay = hpet_readl(HPET_COUNTER) - offset;
 	} else {
@@ -794,17 +802,18 @@
  * Set up timer 0, as periodic with first interrupt to happen at hpet_tick,
  * and period also hpet_tick.
  */
-
-	hpet_writel(HPET_TN_ENABLE | HPET_TN_PERIODIC | HPET_TN_SETVAL |
+	if (hpet_use_timer) {
+		hpet_writel(HPET_TN_ENABLE | HPET_TN_PERIODIC | HPET_TN_SETVAL |
 		    HPET_TN_32BIT, HPET_T0_CFG);
-	hpet_writel(hpet_tick, HPET_T0_CMP);
-	hpet_writel(hpet_tick, HPET_T0_CMP); /* AK: why twice? */
-
+		hpet_writel(hpet_tick, HPET_T0_CMP);
+		hpet_writel(hpet_tick, HPET_T0_CMP); /* AK: why twice? */
+		cfg |= HPET_CFG_LEGACY;
+	}
 /*
  * Go!
  */
 
-	cfg |= HPET_CFG_ENABLE | HPET_CFG_LEGACY;
+	cfg |= HPET_CFG_ENABLE;
 	hpet_writel(cfg, HPET_CFG);
 
 	return 0;
@@ -825,8 +834,7 @@
 
 	id = hpet_readl(HPET_ID);
 
-	if (!(id & HPET_ID_VENDOR) || !(id & HPET_ID_NUMBER) ||
-	    !(id & HPET_ID_LEGSUP))
+	if (!(id & HPET_ID_VENDOR) || !(id & HPET_ID_NUMBER))
 		return -1;
 
 	hpet_period = hpet_readl(HPET_PERIOD);
@@ -836,6 +844,8 @@
 	hpet_tick = (1000000000L * (USEC_PER_SEC / HZ) + hpet_period / 2) /
 		hpet_period;
 
+	hpet_use_timer = (id & HPET_ID_LEGSUP);
+
 	return hpet_timer_stop_set_go(hpet_tick);
 }
 
@@ -892,9 +902,11 @@
 	set_normalized_timespec(&wall_to_monotonic,
 	                        -xtime.tv_sec, -xtime.tv_nsec);
 
-	if (!hpet_init()) {
+	if (!hpet_init())
                 vxtime_hz = (1000000000000000L + hpet_period / 2) /
 			hpet_period;
+			
+	if (hpet_use_timer) {
 		cpu_khz = hpet_calibrate_tsc();
 		timename = "HPET";
 	} else {
@@ -940,12 +952,12 @@
 	if (oem_force_hpet_timer())
 		notsc = 1;
 	if (vxtime.hpet_address && notsc) {
-		timetype = "HPET";
+		timetype = hpet_use_timer ? "HPET" : "PIT/HPET";
 		vxtime.last = hpet_readl(HPET_T0_CMP) - hpet_tick;
 		vxtime.mode = VXTIME_HPET;
 		do_gettimeoffset = do_gettimeoffset_hpet;
 	} else {
-		timetype = vxtime.hpet_address ? "HPET/TSC" : "PIT/TSC";
+		timetype = hpet_use_timer ? "HPET/TSC" : "PIT/TSC";
 		vxtime.mode = VXTIME_TSC;
 	}
 


