Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965209AbWECPVp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965209AbWECPVp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 May 2006 11:21:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965210AbWECPVp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 May 2006 11:21:45 -0400
Received: from wr-out-0506.google.com ([64.233.184.236]:60287 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S965209AbWECPVo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 May 2006 11:21:44 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        b=fxlibwHpVPoLlX0lojjbLjk2ZcuLziAmHOY57n40UUZyPpBPSshloLYvaJ6Zs3BNUpe52WnYj6AWf+ipugPITIjRQX8Th6BJMxXi8Ewsdjly25srKbdXG5JIt3Xzlyk63VeGerAd+PFsYdYSY2u3nNcPHrPQkyUSn1AhEBRji4s=
Message-ID: <4458CA7A.1080203@gmail.com>
Date: Wed, 03 May 2006 11:21:30 -0400
From: Jim Cromie <jim.cromie@gmail.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060420)
MIME-Version: 1.0
To: Linux kernel <linux-kernel@vger.kernel.org>
CC: john stultz <johnstul@us.ibm.com>
Subject: [patch 1/1 17-rc3-mm1] generic-time: add macro to simplify/hide mask
 constants
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch compiles clean, and is running and maintaining ntp lock
(across ethernet to a laptop).  I've verified (with objdump) that
macro reduces to constant at compile-time. Also compile-tested with 
allnoconfig.  Please consider for -mm.

---

From: Jim Cromie <jim.cromie@gmail.com>
Date: Wed May  3 10:59:00 EDT 2006


Add a CLOCKSOURCE_MASK macro to simplify initializing the mask for 
a struct clocksource, and use it to replace literal mask constants
in the various clocksource drivers.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>

---

 arch/i386/kernel/hpet.c       |    4 ++--

 arch/i386/kernel/i8253.c      |    2 +-
 arch/i386/kernel/tsc.c        |    2 +-
 drivers/clocksource/acpi_pm.c |    2 +-
 drivers/clocksource/cyclone.c |    4 ++--
 include/linux/clocksource.h   |    2 ++
 localversion-clk              |    1 +		(trimmed out)
 8 files changed, 10 insertions(+), 7 deletions(-)


diff -ruNp -X dontdiff -X exclude-diffs linux-2.6.17-rc3-mm1/arch/i386/kernel/hpet.c clksrc-mask/arch/i386/kernel/hpet.c
--- linux-2.6.17-rc3-mm1/arch/i386/kernel/hpet.c        2006-05-03 08:29:48.000000000 -0400
+++ clksrc-mask/arch/i386/kernel/hpet.c 2006-05-03 09:43:03.000000000 -0400
@@ -6,7 +6,7 @@
 #include <asm/hpet.h>
 #include <asm/io.h>

-#define HPET_MASK      0xFFFFFFFF
+#define HPET_MASK      CLOCKSOURCE_MASK(32)
 #define HPET_SHIFT     22

 /* FSEC = 10^-15 NSEC = 10^-9 */
@@ -23,7 +23,7 @@ static struct clocksource clocksource_hp
        .name           = "hpet",
        .rating         = 250,
        .read           = read_hpet,
-       .mask           = (cycle_t)HPET_MASK,
+       .mask           = HPET_MASK,
        .mult           = 0, /* set below */
        .shift          = HPET_SHIFT,
        .is_continuous  = 1,
diff -ruNp -X dontdiff -X exclude-diffs linux-2.6.17-rc3-mm1/arch/i386/kernel/i8253.c clksrc-mask/arch/i386/kernel/i8253.c
--- linux-2.6.17-rc3-mm1/arch/i386/kernel/i8253.c       2006-05-03 08:29:48.000000000 -0400
+++ clksrc-mask/arch/i386/kernel/i8253.c        2006-05-03 09:45:33.000000000 -0400
@@ -69,7 +69,7 @@ static struct clocksource clocksource_pi
        .name   = "pit",
        .rating = 110,
        .read   = pit_read,
-       .mask   = (cycle_t)-1,
+       .mask   = CLOCKSOURCE_MASK(64),
        .mult   = 0,
        .shift  = 20,
 };
diff -ruNp -X dontdiff -X exclude-diffs linux-2.6.17-rc3-mm1/arch/i386/kernel/tsc.c clksrc-mask/arch/i386/kernel/tsc.c
--- linux-2.6.17-rc3-mm1/arch/i386/kernel/tsc.c 2006-05-03 08:29:48.000000000 -0400
+++ clksrc-mask/arch/i386/kernel/tsc.c  2006-05-03 09:42:22.000000000 -0400
@@ -337,7 +337,7 @@ static struct clocksource clocksource_ts
        .name                   = "tsc",
        .rating                 = 300,
        .read                   = read_tsc,
-       .mask                   = (cycle_t)-1,
+       .mask                   = CLOCKSOURCE_MASK(64),
        .mult                   = 0, /* to be set */
        .shift                  = 22,
        .update_callback        = tsc_update_callback,
diff -ruNp -X dontdiff -X exclude-diffs linux-2.6.17-rc3-mm1/drivers/clocksource/acpi_pm.c clksrc-mask/drivers/clocksource/acpi_pm.c
--- linux-2.6.17-rc3-mm1/drivers/clocksource/acpi_pm.c  2006-05-03 08:29:58.000000000 -0400
+++ clksrc-mask/drivers/clocksource/acpi_pm.c   2006-05-03 08:58:53.000000000 -0400
@@ -32,7 +32,7 @@
  */
 u32 pmtmr_ioport __read_mostly;

-#define ACPI_PM_MASK 0xFFFFFF /* limit it to 24 bits */
+#define ACPI_PM_MASK CLOCKSOURCE_MASK(24) /* limit it to 24 bits */

 static inline u32 read_pmtmr(void)
 {
diff -ruNp -X dontdiff -X exclude-diffs linux-2.6.17-rc3-mm1/drivers/clocksource/cyclone.c clksrc-mask/drivers/clocksource/cyclone.c
--- linux-2.6.17-rc3-mm1/drivers/clocksource/cyclone.c  2006-05-03 08:29:58.000000000 -0400
+++ clksrc-mask/drivers/clocksource/cyclone.c   2006-05-03 08:58:53.000000000 -0400
@@ -14,7 +14,7 @@
 #define CYCLONE_MPCS_OFFSET    0x51A8          /* offset to select register */
 #define CYCLONE_MPMC_OFFSET    0x51D0          /* offset to count register */
 #define CYCLONE_TIMER_FREQ     99780000        /* 100Mhz, but not really */
-#define CYCLONE_TIMER_MASK     0xFFFFFFFF      /* 32 bit mask */
+#define CYCLONE_TIMER_MASK     CLOCKSOURCE_MASK(32) /* 32 bit mask */

 int use_cyclone = 0;
 static void __iomem *cyclone_ptr;
@@ -28,7 +28,7 @@ static struct clocksource clocksource_cy
        .name           = "cyclone",
        .rating         = 250,
        .read           = read_cyclone,
-       .mask           = (cycle_t)CYCLONE_TIMER_MASK,
+       .mask           = CYCLONE_TIMER_MASK,
        .mult           = 10,
        .shift          = 0,
        .is_continuous  = 1,
diff -ruNp -X dontdiff -X exclude-diffs linux-2.6.17-rc3-mm1/include/linux/clocksource.h clksrc-mask/include/linux/clocksource.h
--- linux-2.6.17-rc3-mm1/include/linux/clocksource.h    2006-05-03 08:30:25.000000000 -0400
+++ clksrc-mask/include/linux/clocksource.h     2006-05-03 10:35:40.000000000 -0400
@@ -65,6 +65,8 @@ struct clocksource {
        u64 interval_snsecs;
 };

+/* simplify initialization of mask field */
+#define CLOCKSOURCE_MASK(bits) (cycle_t)(bits<64 ? ((1ULL<<bits)-1) : -1)

 /**
  * clocksource_khz2mult - calculates mult from khz and shift


