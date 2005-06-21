Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262360AbVFUW2S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262360AbVFUW2S (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 18:28:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262307AbVFUW2R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 18:28:17 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:7166 "EHLO e33.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S262549AbVFUVj0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 17:39:26 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH 2/11] ppc64: rename pSeries rtc functions into rtas_*
Date: Tue, 21 Jun 2005 23:13:11 +0200
User-Agent: KMail/1.7.2
Cc: linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org
References: <200506212310.54156.arnd@arndb.de> <200506212311.36010.arnd@arndb.de>
In-Reply-To: <200506212311.36010.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506212313.12090.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The rtc rtas functions are not pSeries specific but can
also be used by BPA and other SLOF based platforms

Signed-off-by: Arnd Bergmann <arndb@de.ibm.com>

--
 arch/ppc64/kernel/pSeries_setup.c |    9 +++------
 arch/ppc64/kernel/rtc.c           |    6 +++---
 include/asm-ppc64/rtas.h          |    5 +++++
 3 files changed, 11 insertions(+), 9 deletions(-)

--- linux-cg.orig/arch/ppc64/kernel/pSeries_setup.c	2005-06-21 03:15:26.961012552 -0400
+++ linux-cg/arch/ppc64/kernel/pSeries_setup.c	2005-06-21 03:15:27.004006016 -0400
@@ -73,9 +73,6 @@
 
 extern void pSeries_final_fixup(void);
 
-extern void pSeries_get_boot_time(struct rtc_time *rtc_time);
-extern void pSeries_get_rtc_time(struct rtc_time *rtc_time);
-extern int  pSeries_set_rtc_time(struct rtc_time *rtc_time);
 extern void find_udbg_vterm(void);
 extern void system_reset_fwnmi(void);	/* from head.S */
 extern void machine_check_fwnmi(void);	/* from head.S */
@@ -534,9 +531,9 @@ struct machdep_calls __initdata pSeries_
 	.halt			= rtas_halt,
 	.panic			= rtas_os_term,
 	.cpu_die		= pSeries_mach_cpu_die,
-	.get_boot_time		= pSeries_get_boot_time,
-	.get_rtc_time		= pSeries_get_rtc_time,
-	.set_rtc_time		= pSeries_set_rtc_time,
+	.get_boot_time		= rtas_get_boot_time,
+	.get_rtc_time		= rtas_get_rtc_time,
+	.set_rtc_time		= rtas_set_rtc_time,
 	.calibrate_decr		= generic_calibrate_decr,
 	.progress		= pSeries_progress,
 	.check_legacy_ioport	= pSeries_check_legacy_ioport,
--- linux-cg.orig/arch/ppc64/kernel/rtc.c	2005-06-21 03:15:21.762997888 -0400
+++ linux-cg/arch/ppc64/kernel/rtc.c	2005-06-21 03:15:27.005005864 -0400
@@ -303,7 +303,7 @@ void iSeries_get_boot_time(struct rtc_ti
 #ifdef CONFIG_PPC_RTAS
 #define MAX_RTC_WAIT 5000	/* 5 sec */
 #define RTAS_CLOCK_BUSY (-2)
-void pSeries_get_boot_time(struct rtc_time *rtc_tm)
+void rtas_get_boot_time(struct rtc_time *rtc_tm)
 {
 	int ret[8];
 	int error, wait_time;
@@ -338,7 +338,7 @@ void pSeries_get_boot_time(struct rtc_ti
  * and if a delay is needed to read the clock.  In this case we just
  * silently return without updating rtc_tm.
  */
-void pSeries_get_rtc_time(struct rtc_time *rtc_tm)
+void rtas_get_rtc_time(struct rtc_time *rtc_tm)
 {
         int ret[8];
 	int error, wait_time;
@@ -373,7 +373,7 @@ void pSeries_get_rtc_time(struct rtc_tim
 	rtc_tm->tm_year = ret[0] - 1900;
 }
 
-int pSeries_set_rtc_time(struct rtc_time *tm)
+int rtas_set_rtc_time(struct rtc_time *tm)
 {
 	int error, wait_time;
 	unsigned long max_wait_tb;
--- linux-cg.orig/include/asm-ppc64/rtas.h	2005-06-21 03:15:24.090910336 -0400
+++ linux-cg/include/asm-ppc64/rtas.h	2005-06-21 03:15:44.352891944 -0400
@@ -188,6 +188,11 @@ extern int rtas_set_power_level(int powe
 extern int rtas_set_indicator(int indicator, int index, int new_value);
 extern void rtas_initialize(void);
 
+struct rtc_time;
+extern void rtas_get_boot_time(struct rtc_time *rtc_time);
+extern void rtas_get_rtc_time(struct rtc_time *rtc_time);
+extern int rtas_set_rtc_time(struct rtc_time *rtc_time);
+
 /* Given an RTAS status code of 9900..9905 compute the hinted delay */
 unsigned int rtas_extended_busy_delay_time(int status);
 static inline int rtas_is_extended_busy(int status)

