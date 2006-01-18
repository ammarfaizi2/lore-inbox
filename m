Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932324AbWARQzF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932324AbWARQzF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 11:55:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751332AbWARQzE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 11:55:04 -0500
Received: from mtagate2.de.ibm.com ([195.212.29.151]:45716 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751271AbWARQzD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 11:55:03 -0500
Date: Wed, 18 Jan 2006 17:54:49 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>,
       Jan Glauber <jan.glauber@de.ibm.com>
Subject: [PATCH 4/7] s390: hangcheck timer support.
Message-ID: <20060118165449.GD29266@osiris.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: mutt-ng/devel (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jan Glauber <jan.glauber@de.ibm.com>

Remove useless s390 define from hangcheck-timer, remove wrong definition
of a TOD second and other s390 ifdefs. Use monotonic_clock instead.

Add hangcheck-timer option, copied from drivers/char/Kconfig.
This is ugly but unless we have a big Kconfig cleanup we cannot
include drivers/char/Kconfig...

Signed-off-by: Jan Glauber <jan.glauber@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---

 drivers/char/Kconfig           |    2 +-
 drivers/char/hangcheck-timer.c |   12 +-----------
 drivers/s390/Kconfig           |    7 +++++++
 3 files changed, 9 insertions(+), 12 deletions(-)

diff -urpN linux-2.6/drivers/char/hangcheck-timer.c linux-2.6-patched/drivers/char/hangcheck-timer.c
--- linux-2.6/drivers/char/hangcheck-timer.c	2006-01-18 17:25:20.000000000 +0100
+++ linux-2.6-patched/drivers/char/hangcheck-timer.c	2006-01-18 17:25:51.000000000 +0100
@@ -117,12 +117,9 @@ __setup("hcheck_reboot", hangcheck_parse
 __setup("hcheck_dump_tasks", hangcheck_parse_dump_tasks);
 #endif /* not MODULE */
 
-#if defined(CONFIG_X86)
+#if defined(CONFIG_X86) || defined(CONFIG_S390)
 # define HAVE_MONOTONIC
 # define TIMER_FREQ 1000000000ULL
-#elif defined(CONFIG_S390)
-/* FA240000 is 1 Second in the IBM time universe (Page 4-38 Principles of Op for zSeries */
-# define TIMER_FREQ 0xFA240000ULL
 #elif defined(CONFIG_IA64)
 # define TIMER_FREQ ((unsigned long long)local_cpu_data->itc_freq)
 #elif defined(CONFIG_PPC64)
@@ -134,12 +131,7 @@ extern unsigned long long monotonic_cloc
 #else
 static inline unsigned long long monotonic_clock(void)
 {
-# ifdef __s390__
-	/* returns the TOD.  see 4-38 Principles of Op of zSeries */
-	return get_clock();
-# else
 	return get_cycles();
-# endif  /* __s390__ */
 }
 #endif  /* HAVE_MONOTONIC */
 
@@ -188,8 +180,6 @@ static int __init hangcheck_init(void)
 	       VERSION_STR, hangcheck_tick, hangcheck_margin);
 #if defined (HAVE_MONOTONIC)
 	printk("Hangcheck: Using monotonic_clock().\n");
-#elif defined(__s390__)
-	printk("Hangcheck: Using TOD.\n");
 #else
 	printk("Hangcheck: Using get_cycles().\n");
 #endif  /* HAVE_MONOTONIC */
diff -urpN linux-2.6/drivers/char/Kconfig linux-2.6-patched/drivers/char/Kconfig
--- linux-2.6/drivers/char/Kconfig	2006-01-18 17:25:20.000000000 +0100
+++ linux-2.6-patched/drivers/char/Kconfig	2006-01-18 17:25:51.000000000 +0100
@@ -992,7 +992,7 @@ config HPET_MMAP
 
 config HANGCHECK_TIMER
 	tristate "Hangcheck timer"
-	depends on X86 || IA64 || PPC64 || S390
+	depends on X86 || IA64 || PPC64
 	help
 	  The hangcheck-timer module detects when the system has gone
 	  out to lunch past a certain margin.  It can reboot the system
diff -urpN linux-2.6/drivers/s390/Kconfig linux-2.6-patched/drivers/s390/Kconfig
--- linux-2.6/drivers/s390/Kconfig	2006-01-03 04:21:10.000000000 +0100
+++ linux-2.6-patched/drivers/s390/Kconfig	2006-01-18 17:25:51.000000000 +0100
@@ -51,6 +51,13 @@ config UNIX98_PTY_COUNT
 	  When not in use, each additional set of 256 PTYs occupy
 	  approximately 8 KB of kernel memory on 32-bit architectures.
 
+config HANGCHECK_TIMER
+	tristate "Hangcheck timer"
+	help
+	  The hangcheck-timer module detects when the system has gone
+	  out to lunch past a certain margin.  It can reboot the system
+	  or merely print a warning.
+
 source "drivers/char/watchdog/Kconfig"
 
 comment "S/390 character device drivers"
