Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751255AbVHLTmT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751255AbVHLTmT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 15:42:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751128AbVHLTmS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 15:42:18 -0400
Received: from de01egw01.freescale.net ([192.88.165.102]:27282 "EHLO
	de01egw01.freescale.net") by vger.kernel.org with ESMTP
	id S1751255AbVHLTmR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 15:42:17 -0400
Date: Fri, 12 Aug 2005 14:41:53 -0500 (CDT)
From: Kumar Gala <galak@freescale.com>
X-X-Sender: galak@nylon.am.freescale.net
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org,
       linuxppc-embedded <linuxppc-embedded@ozlabs.org>, msm@freescale.com
Subject: [PATCH] ppc32: Cleaned up global namespace of Book-E watchdog
 variables
Message-ID: <Pine.LNX.4.61.0508121441100.18633@nylon.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Renamed global variables used to convey if the watchdog is enabled and
periodicity of the timer and moved the declarations into a header for these
variables

Signed-off-by: Matt McClintock <msm@freescale.com>
Signed-off-by: Kumar Gala <kumar.gala@freescale.com>

---
commit 9aa56fc06c3b2cbd116fa42c3fee5f227c3ff27c
tree 331dbfbfda8463f584578ad788411cb0aabcd746
parent d6dee08c314c1952921adc99e8f5ff6c332341ef
author Kumar K. Gala <kumar.gala@freescale.com> Fri, 12 Aug 2005 14:39:28 -0500
committer Kumar K. Gala <kumar.gala@freescale.com> Fri, 12 Aug 2005 14:39:28 -0500

 arch/ppc/kernel/setup.c           |    8 ++------
 drivers/char/watchdog/Kconfig     |    3 +++
 drivers/char/watchdog/booke_wdt.c |   23 ++++++++++++-----------
 include/asm-ppc/system.h          |    4 ++++
 4 files changed, 21 insertions(+), 17 deletions(-)

diff --git a/arch/ppc/kernel/setup.c b/arch/ppc/kernel/setup.c
--- a/arch/ppc/kernel/setup.c
+++ b/arch/ppc/kernel/setup.c
@@ -619,10 +619,8 @@ machine_init(unsigned long r3, unsigned 
 /* Checks wdt=x and wdt_period=xx command-line option */
 int __init early_parse_wdt(char *p)
 {
-	extern u32 wdt_enable;
-
 	if (p && strncmp(p, "0", 1) != 0)
-	       wdt_enable = 1;
+	       booke_wdt_enabled = 1;
 
 	return 0;
 }
@@ -630,10 +628,8 @@ early_param("wdt", early_parse_wdt);
 
 int __init early_parse_wdt_period (char *p)
 {
-	extern u32 wdt_period;
-
 	if (p)
-		wdt_period = simple_strtoul(p, NULL, 0);
+		booke_wdt_period = simple_strtoul(p, NULL, 0);
 
 	return 0;
 }
diff --git a/drivers/char/watchdog/Kconfig b/drivers/char/watchdog/Kconfig
--- a/drivers/char/watchdog/Kconfig
+++ b/drivers/char/watchdog/Kconfig
@@ -349,6 +349,9 @@ config 8xx_WDT
 config BOOKE_WDT
 	tristate "PowerPC Book-E Watchdog Timer"
 	depends on WATCHDOG && (BOOKE || 4xx)
+	---help---
+	  Please see Documentation/watchdog/watchdog-api.txt for
+	  more information.
 
 # MIPS Architecture
 
diff --git a/drivers/char/watchdog/booke_wdt.c b/drivers/char/watchdog/booke_wdt.c
--- a/drivers/char/watchdog/booke_wdt.c
+++ b/drivers/char/watchdog/booke_wdt.c
@@ -23,6 +23,7 @@
 
 #include <asm/reg_booke.h>
 #include <asm/uaccess.h>
+#include <asm/system.h>
 
 /* If the kernel parameter wdt_enable=1, the watchdog will be enabled at boot.
  * Also, the wdt_period sets the watchdog timer period timeout.
@@ -38,8 +39,8 @@
 #define WDT_PERIOD_DEFAULT 4	/* Refer to the PPC40x and PPC4xx manuals */
 #endif				/* for timing information */
 
-u32 wdt_enable = 0;
-u32 wdt_period = WDT_PERIOD_DEFAULT;
+u32 booke_wdt_enabled = 0;
+u32 booke_wdt_period = WDT_PERIOD_DEFAULT;
 
 #ifdef	CONFIG_FSL_BOOKE
 #define WDTP(x)		((((63-x)&0x3)<<30)|(((63-x)&0x3c)<<15))
@@ -55,7 +56,7 @@ static __inline__ void booke_wdt_enable(
 	u32 val;
 
 	val = mfspr(SPRN_TCR);
-	val |= (TCR_WIE|TCR_WRC(WRC_CHIP)|WDTP(wdt_period));
+	val |= (TCR_WIE|TCR_WRC(WRC_CHIP)|WDTP(booke_wdt_period));
 
 	mtspr(SPRN_TCR, val);
 }
@@ -108,12 +109,12 @@ static int booke_wdt_ioctl (struct inode
 		booke_wdt_ping();
 		return 0;
 	case WDIOC_SETTIMEOUT:
-		if (get_user(wdt_period, (u32 *) arg))
+		if (get_user(booke_wdt_period, (u32 *) arg))
 			return -EFAULT;
-		mtspr(SPRN_TCR, (mfspr(SPRN_TCR)&~WDTP(0))|WDTP(wdt_period));
+		mtspr(SPRN_TCR, (mfspr(SPRN_TCR)&~WDTP(0))|WDTP(booke_wdt_period));
 		return 0;
 	case WDIOC_GETTIMEOUT:
-		return put_user(wdt_period, (u32 *) arg);
+		return put_user(booke_wdt_period, (u32 *) arg);
 	case WDIOC_SETOPTIONS:
 		if (get_user(tmp, (u32 *) arg))
 			return -EINVAL;
@@ -134,11 +135,11 @@ static int booke_wdt_ioctl (struct inode
  */
 static int booke_wdt_open (struct inode *inode, struct file *file)
 {
-	if (wdt_enable == 0) {
-		wdt_enable = 1;
+	if (booke_wdt_enabled == 0) {
+		booke_wdt_enabled = 1;
 		booke_wdt_enable();
 		printk (KERN_INFO "PowerPC Book-E Watchdog Timer Enabled (wdt_period=%d)\n",
-				wdt_period);
+				booke_wdt_period);
 	}
 
 	return 0;
@@ -180,9 +181,9 @@ static int __init booke_wdt_init(void)
 		return ret;
 	}
 
-	if (wdt_enable == 1) {
+	if (booke_wdt_enabled == 1) {
 		printk (KERN_INFO "PowerPC Book-E Watchdog Timer Enabled (wdt_period=%d)\n",
-				wdt_period);
+				booke_wdt_period);
 		booke_wdt_enable();
 	}
 
diff --git a/include/asm-ppc/system.h b/include/asm-ppc/system.h
--- a/include/asm-ppc/system.h
+++ b/include/asm-ppc/system.h
@@ -87,6 +87,10 @@ extern void cacheable_memzero(void *p, u
 extern int do_page_fault(struct pt_regs *, unsigned long, unsigned long);
 extern void bad_page_fault(struct pt_regs *, unsigned long, int);
 extern void die(const char *, struct pt_regs *, long);
+#ifdef CONFIG_BOOKE_WDT
+extern u32 booke_wdt_enabled;
+extern u32 booke_wdt_period;
+#endif /* CONFIG_BOOKE_WDT */
 
 struct device_node;
 extern void note_scsi_host(struct device_node *, void *);
