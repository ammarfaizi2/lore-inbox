Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268577AbUHRCS3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268577AbUHRCS3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 22:18:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266921AbUHRCS3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 22:18:29 -0400
Received: from ozlabs.org ([203.10.76.45]:58824 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S268577AbUHRCS1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 22:18:27 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16674.48073.317282.385177@cargo.ozlabs.ibm.com>
Date: Wed, 18 Aug 2004 12:15:37 +1000
From: Paul Mackerras <paulus@samba.org>
To: akpm@osdl.org
Cc: anton@samba.org, linas@austin.ibm.com, linux-kernel@vger.kernel.org
Subject: [PATCH] PPC64 log firmware errors during boot
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Firmware can report errors at any time, and not atypically during boot.
However, these reports were being discarded until th rtasd comes up,
which occurs fairly late in the boot cycle.  As a result, firmware
errors during boot were being silently ignored.

Signed-off-by: Linas Vepstas <linas@linas.org>
Signed-off-by: Paul Mackerras <paulus@samba.org>

diff -urN akpm-17aug/arch/ppc64/kernel/rtasd.c akpm/arch/ppc64/kernel/rtasd.c
--- akpm-17aug/arch/ppc64/kernel/rtasd.c	2004-08-03 08:07:43.000000000 +1000
+++ akpm/arch/ppc64/kernel/rtasd.c	2004-08-18 11:54:31.977939936 +1000
@@ -57,6 +57,8 @@
  */
 static unsigned char logdata[RTAS_ERROR_LOG_MAX];
 
+static int get_eventscan_parms(void);
+
 /* To see this info, grep RTAS /var/log/messages and each entry
  * will be collected together with obvious begin/end.
  * There will be a unique identifier on the begin and end lines.
@@ -121,6 +123,9 @@
 		len += err->extended_log_length;
 	}
 
+	if (rtas_error_log_max == 0) {
+		get_eventscan_parms();
+	}
 	if (len > rtas_error_log_max)
 		len = rtas_error_log_max;
 
@@ -148,7 +153,6 @@
 	int len = 0;
 
 	DEBUG("logging event\n");
-
 	if (buf == NULL)
 		return;
 
@@ -171,6 +175,13 @@
 	if (!no_more_logging && !(err_type & ERR_FLAG_BOOT))
 		nvram_write_error_log(buf, len, err_type);
 
+	/* rtas errors can occur during boot, and we do want to capture
+	 * those somewhere, even if nvram isn't ready (why not?), and even
+	 * if rtasd isn't ready. Put them into the boot log, at least.  */
+	if ((err_type & ERR_TYPE_MASK) == ERR_TYPE_RTAS_LOG) {
+		printk_log_rtas(buf, len);
+	}
+
 	/* Check to see if we need to or have stopped logging */
 	if (fatal || no_more_logging) {
 		no_more_logging = 1;
