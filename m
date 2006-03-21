Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964775AbWCUB1G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964775AbWCUB1G (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 20:27:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964928AbWCUB1F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 20:27:05 -0500
Received: from mail.parknet.jp ([210.171.160.80]:33028 "EHLO parknet.jp")
	by vger.kernel.org with ESMTP id S964956AbWCUB1B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 20:27:01 -0500
X-AuthUser: hirofumi@parknet.jp
To: Con Kolivas <kernel@kolivas.org>
Cc: Andreas Mohr <andi@rhlx01.fht-esslingen.de>,
       bert hubert <bert.hubert@netherlabs.nl>, linux-kernel@vger.kernel.org,
       george@mvista.com
Subject: Re: gettimeofday order of magnitude slower with pmtimer, which is default
References: <20060320122449.GA29718@outpost.ds9a.nl>
	<20060320145047.GA12332@rhlx01.fht-esslingen.de>
	<200603210224.23540.kernel@kolivas.org>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Tue, 21 Mar 2006 10:26:48 +0900
In-Reply-To: <200603210224.23540.kernel@kolivas.org> (Con Kolivas's message of "Tue, 21 Mar 2006 02:24:23 +1100")
Message-ID: <87wteo37vr.fsf@duaron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas <kernel@kolivas.org> writes:

> On Tuesday 21 March 2006 01:50, Andreas Mohr wrote:
>
>> I think it's crazy to do a safe tripled readout (with *very* expensive
>> I/O!) of the PM timer unconditionally on *all* systems when only a
>> (albeit not that small) subset of systems is affected by buggy (un-latched)
>> PM timers.
>> I want to improve things there; I can see three ways to do it:
>> a) maintain a blacklist (or probably better a whitelist) of systems that
>>    are (not) affected
>> b) detect long-time timer accuracy, then switch to fast readout if timer
>>    is verified to be accurate (no white/blacklist needed this way)
>> c) give up on PM timer completely
>>
>> Any comments on which way and how this could/should be done?
>
> The pm timer is very fast when the timer is latched and that strange loop uses 
> hardly any cpu time. The same can't be said about the unlatched timer case 
> where absurd amounts of cpu seem the norm. You have a catch 22 situation if 
> you depend on the accuracy of the pm timer only to end up wasting time trying 
> to actually use that timer. 

Actually, pmtmr not seems very fast, rather it's slow like usual I/O port.

Simple userland test

	rdtsc(l1, h1);
	val = inl(0x808); /* 0x808 is PMTMR address */
	asm volatile("lfence");
	rdtsc(l2, h2);

is about 1us.

And the following is test of gettimeofday(). Probably, we need a patch. Umm....

2.6.16 (pmtmr)
Simple gettimeofday: 3.6532 microseconds
Simple gettimeofday: 3.6502 microseconds
Simple gettimeofday: 3.6522 microseconds
Simple gettimeofday: 3.6486 microseconds
Simple gettimeofday: 3.6539 microseconds

2.6.16+patch (pmtmr)
Simple gettimeofday: 1.4582 microseconds
Simple gettimeofday: 1.4593 microseconds
Simple gettimeofday: 1.4671 microseconds
Simple gettimeofday: 1.4650 microseconds

2.6.16 (tsc)
Simple gettimeofday: 0.4037 microseconds
Simple gettimeofday: 0.4037 microseconds
Simple gettimeofday: 0.4040 microseconds
Simple gettimeofday: 0.4037 microseconds
Simple gettimeofday: 0.4038 microseconds
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>


Signed-off-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
---

 arch/i386/kernel/timers/timer_pm.c |   74 ++++++++++++++++++++++++++++++-------
 1 file changed, 60 insertions(+), 14 deletions(-)

diff -puN arch/i386/kernel/timers/timer_pm.c~pm-kill-workaround arch/i386/kernel/timers/timer_pm.c
--- linux-2.6/arch/i386/kernel/timers/timer_pm.c~pm-kill-workaround	2006-03-21 04:20:27.000000000 +0900
+++ linux-2.6-hirofumi/arch/i386/kernel/timers/timer_pm.c	2006-03-21 04:31:48.000000000 +0900
@@ -15,6 +15,7 @@
 #include <linux/module.h>
 #include <linux/device.h>
 #include <linux/init.h>
+#include <linux/pci.h>
 #include <asm/types.h>
 #include <asm/timer.h>
 #include <asm/smp.h>
@@ -35,6 +36,7 @@
  * in arch/i386/acpi/boot.c */
 u32 pmtmr_ioport = 0;
 
+static int pmtmr_need_workaround __read_mostly = 1;
 
 /* value of the Power timer at last timer interrupt */
 static u32 offset_tick;
@@ -45,24 +47,68 @@ static seqlock_t monotonic_lock = SEQLOC
 
 #define ACPI_PM_MASK 0xFFFFFF /* limit it to 24 bits */
 
+#ifdef CONFIG_PCI
+/*
+ * PIIX4 Errata:
+ *
+ * The power management timer may return improper result when read.
+ * Although the timer value settles properly after incrementing,
+ * while incrementing there is a 3 ns window every 69.8 ns where the
+ * timer value is indeterminate (a 4.2% chance that the data will be
+ * incorrect when read). As a result, the ACPI free running count up
+ * timer specification is violated due to erroneous reads.
+ */
+static int __init pmtmr_bug_check(void)
+{
+	struct pci_dev *dev;
+	int pmtmr_has_bug = 0;
+	u8 rev;
+
+	dev = pci_get_device(PCI_VENDOR_ID_INTEL,
+			     PCI_DEVICE_ID_INTEL_82371AB_3, NULL);
+	if (dev) {
+		pci_read_config_byte(dev, PCI_REVISION_ID, &rev);
+		/* the bug has been fixed in PIIX4M */
+		if (rev < 3)
+			pmtmr_has_bug = 1;
+		pci_dev_put(dev);
+	}
+
+	if (pmtmr_has_bug)
+		printk(KERN_INFO
+		       "*** Found PM-Timer Bug on this chip. For workarounds a bug, this timer\n"
+		       "*** source is slow. Use other timer source (clock=).\n");
+	else
+		pmtmr_need_workaround = 0;
+
+	return 0;
+}
+device_initcall(pmtmr_bug_check);
+#endif
+
 /*helper function to safely read acpi pm timesource*/
 static inline u32 read_pmtmr(void)
 {
-	u32 v1=0,v2=0,v3=0;
-	/* It has been reported that because of various broken
-	 * chipsets (ICH4, PIIX4 and PIIX4E) where the ACPI PM time
-	 * source is not latched, so you must read it multiple
-	 * times to insure a safe value is read.
-	 */
-	do {
-		v1 = inl(pmtmr_ioport);
-		v2 = inl(pmtmr_ioport);
-		v3 = inl(pmtmr_ioport);
-	} while ((v1 > v2 && v1 < v3) || (v2 > v3 && v2 < v1)
-			|| (v3 > v1 && v3 < v2));
+	if (unlikely(pmtmr_need_workaround)) {
+		u32 v1, v2, v3;
+
+		/* It has been reported that because of various broken
+		 * chipsets (ICH4, PIIX4 and PIIX4E) where the ACPI PM time
+		 * source is not latched, so you must read it multiple
+		 * times to insure a safe value is read.
+		 */
+		do {
+			v1 = inl(pmtmr_ioport);
+			v2 = inl(pmtmr_ioport);
+			v3 = inl(pmtmr_ioport);
+		} while ((v1 > v2 && v1 < v3) || (v2 > v3 && v2 < v1)
+			 || (v3 > v1 && v3 < v2));
+
+		/* mask the output to 24 bits */
+		return v2 & ACPI_PM_MASK;
+	}
 
-	/* mask the output to 24 bits */
-	return v2 & ACPI_PM_MASK;
+	return inl(pmtmr_ioport) & ACPI_PM_MASK;
 }
 
 
_
