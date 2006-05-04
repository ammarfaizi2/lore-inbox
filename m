Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751483AbWEDKY2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751483AbWEDKY2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 May 2006 06:24:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751488AbWEDKY1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 May 2006 06:24:27 -0400
Received: from ylpvm15-ext.prodigy.net ([207.115.57.46]:43477 "EHLO
	ylpvm15.prodigy.net") by vger.kernel.org with ESMTP
	id S1751483AbWEDKY1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 May 2006 06:24:27 -0400
X-ORBL: [67.117.73.34]
Date: Thu, 4 May 2006 03:24:16 -0700
From: Tony Lindgren <tony@atomide.com>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, tony.luck@intel.com,
       Nick Piggin <nickpiggin@yahoo.com.au>
Subject: [PATCH] Fix CONFIG_PRINTK_TIME hangs on some systems
Message-ID: <20060504102415.GL8664@atomide.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="EgVrEAR5UttbsTXg"
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--EgVrEAR5UttbsTXg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

This issue has been discussed earlier on LKML, but AFAIK
there has not been any better solution available:

http://lkml.org/lkml/2005/8/18/173

Regards,

Tony

--EgVrEAR5UttbsTXg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename=patch-printk-time-hangs

Fix CONFIG_PRINTK_TIME hangs on systems where sched_clock() does
not work before timer is initialized.

Signed-off-by: Tony Lindgren <tony@atomide.com>

--- a/kernel/printk.c
+++ b/kernel/printk.c
@@ -431,11 +431,23 @@ static void zap_locks(void)
 	init_MUTEX(&console_sem);
 }
 
-#if defined(CONFIG_PRINTK_TIME)
-static int printk_time = 1;
-#else
 static int printk_time = 0;
-#endif
+
+#ifdef CONFIG_PRINTK_TIME
+
+/*
+ * Initialize printk time. Note that on some systems sched_clock()
+ * does not work until timer is initialized.
+ */
+static int __init printk_time_init(void)
+{
+	printk_time = 1;
+
+	return 0;
+}
+subsys_initcall(printk_time_init);
+
+#else
 
 static int __init printk_time_setup(char *str)
 {
@@ -447,6 +459,8 @@ static int __init printk_time_setup(char
 
 __setup("time", printk_time_setup);
 
+#endif
+
 __attribute__((weak)) unsigned long long printk_clock(void)
 {
 	return sched_clock();

--EgVrEAR5UttbsTXg--
