Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265628AbTFXCXJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jun 2003 22:23:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265632AbTFXCXJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jun 2003 22:23:09 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:5375 "EHLO e31.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S265628AbTFXCXF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jun 2003 22:23:05 -0400
Subject: [PATCH] linux-2.4.73_amd64-monotonic-clock_A0
From: john stultz <johnstul@us.ibm.com>
To: Andi Kleen <ak@suse.de>
Cc: lkml <linux-kernel@vger.kernel.org>, Joel Becker <Joel.Becker@oracle.com>
Content-Type: text/plain
Organization: 
Message-Id: <1056421780.1028.86.camel@w-jstultz2.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 23 Jun 2003 19:29:40 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi,
	Here is the monotonic_clock() interface for AMD64. This implements the
function for both TSC and HPET time sources. 

thanks
-john

diff -Nru a/arch/x86_64/kernel/time.c b/arch/x86_64/kernel/time.c
--- a/arch/x86_64/kernel/time.c	Mon Jun 23 19:27:28 2003
+++ b/arch/x86_64/kernel/time.c	Mon Jun 23 19:27:29 2003
@@ -47,6 +47,7 @@
 unsigned long hpet_tick;				/* HPET clocks / interrupt */
 unsigned long vxtime_hz = 1193182;
 int report_lost_ticks;				/* command line option */
+unsigned long long monotonic_base;
 
 struct vxtime_data __vxtime __section_vxtime;	/* for vsyscalls */
 
@@ -219,6 +220,47 @@
 	spin_unlock(&rtc_lock);
 }
 
+
+/* monotonic_clock(): returns # of nanoseconds passed since time_init()
+ *		Note: This function is required to return accurate
+ *		time even in the absence of multiple timer ticks.
+ */
+unsigned long long monotonic_clock(void)
+{
+	unsigned long seq;
+ 	u32 last_offset, this_offset, offset;
+	unsigned long long base;
+
+	if (vxtime.mode == VXTIME_HPET) {
+		do {
+			seq = read_seqbegin(&xtime_lock);
+
+			last_offset = vxtime.last;
+			base = monotonic_base;
+			this_offset = hpet_readl(HPET_T0_CMP) - hpet_tick;
+
+		} while (read_seqretry(&xtime_lock, seq));
+		offset = (this_offset - last_offset);
+		offset *=(NSEC_PER_SEC/HZ)/hpet_tick;
+		return base + offset;
+	}else{
+		do {
+			seq = read_seqbegin(&xtime_lock);
+
+			last_offset = vxtime.last_tsc;
+			base = monotonic_base;
+		} while (read_seqretry(&xtime_lock, seq));
+		sync_core();
+		rdtscll(this_offset);
+		offset = (this_offset - last_offset)*1000/cpu_khz; 
+		return base + offset;
+	}
+
+
+}
+EXPORT_SYMBOL(monotonic_clock);
+
+
 static irqreturn_t timer_interrupt(int irq, void *dev_id, struct pt_regs *regs)
 {
 	static unsigned long rtc_update = 0;
@@ -252,6 +294,9 @@
 		if (offset - vxtime.last > hpet_tick) {
 			lost = (offset - vxtime.last) / hpet_tick - 1;
 		}
+		
+		monotonic_base += 
+			(offset - vxtime.last)*(NSEC_PER_SEC/HZ) / hpet_tick;
 
 		vxtime.last = offset;
 	} else {
@@ -265,6 +310,8 @@
 			lost = offset / (USEC_PER_SEC / HZ);
 			offset %= (USEC_PER_SEC / HZ);
 		}
+
+		monotonic_base += (tsc - vxtime.last_tsc)*1000000/cpu_khz ;
 
 		vxtime.last_tsc = tsc - vxtime.quot * delay / vxtime.tsc_quot;
 



