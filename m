Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262509AbVHDM7j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262509AbVHDM7j (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 08:59:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262515AbVHDM7j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 08:59:39 -0400
Received: from ZIVLNX17.UNI-MUENSTER.DE ([128.176.188.79]:51388 "EHLO
	ZIVLNX17.uni-muenster.de") by vger.kernel.org with ESMTP
	id S262509AbVHDM7f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 08:59:35 -0400
From: Borislav Petkov <petkov@uni-muenster.de>
To: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] pmtmr and PRINTK_TIME timings display
Date: Thu, 4 Aug 2005 14:59:43 +0200
User-Agent: KMail/1.7.2
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508041459.43500.petkov@uni-muenster.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

on my laptop ASUS M6B00N PRINTK_TIME is enabled in order to show timing 
information in all the boottime printk's. However, all output looks like this

<snip>
[4294667.997000] CPU: After generic identify, caps: a7e9fbbf 00000000 00000000 
00000000 00000180 00000000 00000000
[4294667.997000] CPU: After vendor identify, caps: a7e9fbbf 00000000 00000000 
00000000 00000180 00000000 00000000
[4294667.997000] CPU: L1 I cache: 32K, L1 D cache: 32K
[4294667.997000] CPU: L2 cache: 1024K
[4294667.997000] CPU: After all inits, caps: a7e9fbbf 00000000 00000000 
00000040 00000180 00000000 00000000
[4294667.997000] CPU: Intel(R) Pentium(R) M processor 1500MHz stepping 05
[4294667.997000] Enabling fast FPU save and restore... done.
[4294667.997000] Enabling unmasked SIMD FPU exception support... done.
[4294667.997000] Checking 'hlt' instruction... OK.
[4294668.041000] ACPI: setting ELCR to 0200 (from 0c30)
</snip>

If I'm not wrong, the time value that gets printed is actually the jiffies_64 
value set to INITIAL_JIFFIES, which in turn is set to wrap 5 minutes after 
boot so that "jiffies wrap bugs show up earlier." This is because 
sched_clock() in <arch/i386/kernel/timers/timer_tsc.c> returns the jiffies_64 
value converted to nanoseconds after checking use_tsc. This, in turn, is 0 
because my machine selects the power management timer as the high-res 
timesource before reading the timestamp counter for printk timing.

My desktop machine however, uses the tsc for printk timing and its boot 
messages look like this:

<snip>
[4294667.296000] mapped APIC to ffffd000 (fee00000)
[4294667.296000] mapped IOAPIC to ffffc000 (fec00000)
[4294667.296000] Initializing CPU#0
[4294667.296000] CPU 0 irqstacks, hard=c0481000 soft=c047f000
[4294667.296000] PID hash table entries: 2048 (order: 11, 32768 bytes)
[    0.000000] Detected 2606.874 MHz processor.
[   20.523785] Using tsc for high-res timesource
[   20.524715] Console: colour VGA+ 80x25
[   20.751678] Dentry cache hash table entries: 131072 (order: 7, 524288 
bytes)
[   20.760133] Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
[   20.778329] Memory: 514964k/524224k available (2127k kernel code, 8776k 
reserved, 1246k data, 180k init, 0k highmem)
</snip>

where you see the deltas between the printk's printed once the tsc timer is 
initialized as opposed to the first bootlog where you see all times relative 
to a single point in time. The python script <scripts/show_delta> in the 
kernel source converts between these two representations but there's a pretty 
simple solution IMHO to make PRINTK_TIME uniform and independent from the 
used timer. The one liner is against 2.6.12.3.

After applying it, printk timing looks like this:

<snip>
[    0.000000] Detected 1500.132 MHz processor.
[    0.000000] Using pmtmr for high-res timesource
[    0.000000] Console: colour VGA+ 80x25
[    1.890000] Dentry cache hash table entries: 131072 (order: 7, 524288 
bytes)
[    1.891000] Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
[    1.906000] Memory: 513756k/523520k available (2839k kernel code, 9276k 
reserved, 1148k data, 152k init, 0k highmem)
[    1.906000] Checking if this processor honours the WP bit even in 
supervisor mode... Ok.
[    1.906000] Calibrating delay loop... 2973.69 BogoMIPS (lpj=1486848)
[    1.928000] Security Framework v1.0.0 initialized
</snip>


Signed-off-by: Borislav Petkov <petkov@uni-muenster.de>

--- arch/i386/kernel/timers/timer_tsc.c.orig	2005-08-04 12:57:37.000000000 
+0200
+++ arch/i386/kernel/timers/timer_tsc.c	2005-08-04 14:19:48.000000000 +0200
@@ -146,7 +146,7 @@ unsigned long long sched_clock(void)
 	if (!use_tsc)
 #endif
 		/* no locking but a rare wrong value is not a big deal */
-		return jiffies_64 * (1000000000 / HZ);
+		return (jiffies_64 - INITIAL_JIFFIES) * (1000000000 / HZ);
 
 	/* Read the Time Stamp Counter */
 	rdtscll(this_offset);


-- 
Regards,
Borislav Petkov.
