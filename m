Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265714AbTGDCPU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jul 2003 22:15:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265672AbTGDB5b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jul 2003 21:57:31 -0400
Received: from granite.he.net ([216.218.226.66]:27150 "EHLO granite.he.net")
	by vger.kernel.org with ESMTP id S265667AbTGDByz convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jul 2003 21:54:55 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10572845553898@kroah.com>
Subject: Re: [PATCH] PCI and sysfs fixes for 2.5.74
In-Reply-To: <10572845552315@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Thu, 3 Jul 2003 19:09:15 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1378, 2003/07/03 17:52:16-07:00, greg@kroah.com

Merge kroah.com:/home/linux/BK/bleed-2.5
into kroah.com:/home/linux/BK/pci-2.5


 arch/i386/kernel/timers/timer_cyclone.c |    2 +-
 arch/i386/kernel/timers/timer_tsc.c     |   15 +++++++++++++--
 2 files changed, 14 insertions(+), 3 deletions(-)


diff -Nru a/arch/i386/kernel/timers/timer_cyclone.c b/arch/i386/kernel/timers/timer_cyclone.c
--- a/arch/i386/kernel/timers/timer_cyclone.c	Thu Jul  3 18:15:27 2003
+++ b/arch/i386/kernel/timers/timer_cyclone.c	Thu Jul  3 18:15:27 2003
@@ -88,7 +88,7 @@
 	 * between cyclone and pit reads (as noted when 
 	 * usec delta is > 90% # of usecs/tick)
 	 */
-	if (abs(delay - delay_at_last_interrupt) > (900000/HZ)) 
+	if (lost && abs(delay - delay_at_last_interrupt) > (900000/HZ))
 		jiffies++;
 }
 
diff -Nru a/arch/i386/kernel/timers/timer_tsc.c b/arch/i386/kernel/timers/timer_tsc.c
--- a/arch/i386/kernel/timers/timer_tsc.c	Thu Jul  3 18:15:27 2003
+++ b/arch/i386/kernel/timers/timer_tsc.c	Thu Jul  3 18:15:27 2003
@@ -124,6 +124,7 @@
 	int countmp;
 	static int count1 = 0;
 	unsigned long long this_offset, last_offset;
+	static int lost_count = 0;
 	
 	write_lock(&monotonic_lock);
 	last_offset = ((unsigned long long)last_tsc_high<<32)|last_tsc_low;
@@ -178,9 +179,19 @@
 	delta += delay_at_last_interrupt;
 	lost = delta/(1000000/HZ);
 	delay = delta%(1000000/HZ);
-	if (lost >= 2)
+	if (lost >= 2) {
 		jiffies += lost-1;
 
+		/* sanity check to ensure we're not always loosing ticks */
+		if (lost_count++ > 100) {
+			printk(KERN_WARNING "Loosing too many ticks!\n");
+			printk(KERN_WARNING "TSC cannot be used as a timesource."
+					" (Are you running with SpeedStep?)\n");
+			printk(KERN_WARNING "Falling back to a sane timesource.\n");
+			clock_fallback();
+		}
+	} else
+		lost_count = 0;
 	/* update the monotonic base value */
 	this_offset = ((unsigned long long)last_tsc_high<<32)|last_tsc_low;
 	monotonic_base += cycles_2_ns(this_offset - last_offset);
@@ -194,7 +205,7 @@
 	 * between tsc and pit reads (as noted when 
 	 * usec delta is > 90% # of usecs/tick)
 	 */
-	if (abs(delay - delay_at_last_interrupt) > (900000/HZ))
+	if (lost && abs(delay - delay_at_last_interrupt) > (900000/HZ))
 		jiffies++;
 }
 

