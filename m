Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932323AbWCVStg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932323AbWCVStg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 13:49:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932326AbWCVStg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 13:49:36 -0500
Received: from mail.parknet.jp ([210.171.160.80]:42246 "EHLO parknet.jp")
	by vger.kernel.org with ESMTP id S932323AbWCVStf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 13:49:35 -0500
X-AuthUser: hirofumi@parknet.jp
To: Con Kolivas <kernel@kolivas.org>
Cc: john stultz <johnstul@us.ibm.com>,
       Andreas Mohr <andi@rhlx01.fht-esslingen.de>,
       bert hubert <bert.hubert@netherlabs.nl>, linux-kernel@vger.kernel.org,
       george@mvista.com, Andrew Morton <akpm@osdl.org>
Subject: [PATCH] PM-Timer: doesn't use workaround if chipset is not buggy
References: <20060320122449.GA29718@outpost.ds9a.nl>
	<1142968999.4281.4.camel@leatherman>
	<8764m7xzqg.fsf@duaron.myhome.or.jp>
	<200603221121.16168.kernel@kolivas.org>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Thu, 23 Mar 2006 03:49:18 +0900
In-Reply-To: <200603221121.16168.kernel@kolivas.org> (Con Kolivas's message of "Wed, 22 Mar 2006 11:21:15 +1100")
Message-ID: <87hd5qmi1d.fsf_-_@duaron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas <kernel@kolivas.org> writes:

> Looks good. Just some minor grammar comments

Thanks a lot for doing it. Fixed.

And finally, I added "if (cur_timer != &timer_pmtmr)" to pmtmr_bug_check()
to avoid incorrect warning.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>


Current timer_pm.c reads I/O port triple times, in order to avoid the
bug of chipset. But I/O port is slow.

2.6.16 (pmtmr)
Simple gettimeofday: 3.6532 microseconds

2.6.16+patch (pmtmr)
Simple gettimeofday: 1.4582 microseconds

[if chip is buggy, probably it will be 7us or more in 4.2% of probability.]


This patch adds blacklist of buggy chip, and if chip is not buggy,
this uses fast normal version instead of slow workaround version.

If chip is buggy, warnings "pmtmr is slow". But sounds like there is
gray zone. I found the PIIX4 errata, but I couldn't find the ICH4
errata.  But some motherboard seems to have problem.

So, if found a ICH4, also warnings, and uses a workaround version.  If
user's ICH4 is good actually, user can specify the "pmtmr_good" boot
parameter to use fast version.


Acked-by: John Stultz <johnstul@us.ibm.com>
Signed-off-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
---

 arch/i386/kernel/timers/timer_pm.c |   98 +++++++++++++++++++++++++++++++------
 1 file changed, 84 insertions(+), 14 deletions(-)

diff -puN arch/i386/kernel/timers/timer_pm.c~pm-kill-workaround arch/i386/kernel/timers/timer_pm.c
--- linux-2.6/arch/i386/kernel/timers/timer_pm.c~pm-kill-workaround	2006-03-23 01:29:42.000000000 +0900
+++ linux-2.6-hirofumi/arch/i386/kernel/timers/timer_pm.c	2006-03-23 01:51:01.000000000 +0900
@@ -15,6 +15,7 @@
 #include <linux/module.h>
 #include <linux/device.h>
 #include <linux/init.h>
+#include <linux/pci.h>
 #include <asm/types.h>
 #include <asm/timer.h>
 #include <asm/smp.h>
@@ -45,24 +46,31 @@ static seqlock_t monotonic_lock = SEQLOC
 
 #define ACPI_PM_MASK 0xFFFFFF /* limit it to 24 bits */
 
+static int pmtmr_need_workaround __read_mostly = 1;
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
+	if (pmtmr_need_workaround) {
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
 
 
@@ -263,6 +271,68 @@ struct init_timer_opts __initdata timer_
 	.opts = &timer_pmtmr,
 };
 
+#ifdef CONFIG_PCI
+/*
+ * PIIX4 Errata:
+ *
+ * The power management timer may return improper results when read.
+ * Although the timer value settles properly after incrementing,
+ * while incrementing there is a 3 ns window every 69.8 ns where the
+ * timer value is indeterminate (a 4.2% chance that the data will be
+ * incorrect when read). As a result, the ACPI free running count up
+ * timer specification is violated due to erroneous reads.
+ */
+static int __init pmtmr_bug_check(void)
+{
+	static struct pci_device_id gray_list[] __initdata = {
+		/* these chipsets may have bug. */
+		{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801DB_0) },
+		{ },
+	};
+	struct pci_dev *dev;
+	int pmtmr_has_bug = 0;
+	u8 rev;
+
+	if (cur_timer != &timer_pmtmr || !pmtmr_need_workaround)
+		return 0;
+
+	dev = pci_get_device(PCI_VENDOR_ID_INTEL,
+			     PCI_DEVICE_ID_INTEL_82371AB_3, NULL);
+	if (dev) {
+		pci_read_config_byte(dev, PCI_REVISION_ID, &rev);
+		/* the bug has been fixed in PIIX4M */
+		if (rev < 3) {
+			printk(KERN_WARNING
+			       "* Found PM-Timer Bug on this chipset. Due to workarounds for a bug,\n"
+			       "* this time source is slow. Consider trying other time sources (clock=)\n");
+			pmtmr_has_bug = 1;
+		}
+		pci_dev_put(dev);
+	}
+
+	if (pci_dev_present(gray_list)) {
+		printk(KERN_WARNING
+		       "* This chipset may have PM-Timer Bug. Due to workarounds for a bug,\n"
+		       "* this time source is slow. If you are sure your timer does not have\n"
+		       "* this bug, please use \"pmtmr_good\" to disable the workaround\n");
+		pmtmr_has_bug = 1;
+	}
+
+	if (!pmtmr_has_bug)
+		pmtmr_need_workaround = 0;
+
+	return 0;
+}
+device_initcall(pmtmr_bug_check);
+#endif
+
+static int __init pmtr_good_setup(char *__str)
+{
+	pmtmr_need_workaround = 0;
+	return 0;
+}
+__setup("pmtmr_good", pmtr_good_setup);
+
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Dominik Brodowski <linux@brodo.de>");
 MODULE_DESCRIPTION("Power Management Timer (PMTMR) as primary timing source for x86");
_
