Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261438AbUKOFAa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261438AbUKOFAa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Nov 2004 00:00:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261445AbUKOFA3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Nov 2004 00:00:29 -0500
Received: from ozlabs.org ([203.10.76.45]:41140 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261438AbUKOFAN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Nov 2004 00:00:13 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16792.14539.517355.417004@cargo.ozlabs.ibm.com>
Date: Mon, 15 Nov 2004 16:04:11 +1100
From: Paul Mackerras <paulus@samba.org>
To: akpm@osdl.org
Cc: Jake Moilanen <moilanen@austin.ibm.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] PPC64 rtasd: window when error_log_cnt could get zeroed
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is from Jake Moilanen <moilanen@austin.ibm.com>.

There appears to be a hole that if we get an log_error() call, that we
could zero out our error log count in nvram. 

When rtasd() starts up, it turns on the logging via 'no_more_logging =
0'.  If we get a log_error() call after that is set but before
nvram_read_error_log has actually read nvram to set error_log_cnt, the
log_error() call will write back to nvram a uninitialized error_log_cnt
value, and wipe out our sequence number.

To close the hole, simply move the 'no_more_logging = 0' till after
nvram sets error_log_cnt but before pSeries_log_error is called.

I also changed the 'no_more_logging' variable to be 'no_logging' since
it's not only used when we stop logging now.  I also removed the
"volatile" part of no_more_logging, since it's unneeded. 

Signed-off-by: Jake Moilanen <moilanen@austin.ibm.com>
Signed-off-by: Paul Mackerras <paulus@samba.org>

diff -puN arch/ppc64/kernel/rtasd.c~rtasd-no_more_logging-race arch/ppc64/kernel/rtasd.c
--- linux-2.6-bk/arch/ppc64/kernel/rtasd.c~rtasd-no_more_logging-race	Mon Nov  8 11:51:11 2004
+++ linux-2.6-bk-moilanen/arch/ppc64/kernel/rtasd.c	Mon Nov  8 12:19:47 2004
@@ -48,7 +48,7 @@ static unsigned int rtas_error_log_buffe
 
 static int full_rtas_msgs = 0;
 
-extern volatile int no_more_logging;
+extern int no_logging;
 
 volatile int error_log_cnt = 0;
 
@@ -213,7 +213,7 @@ void pSeries_log_error(char *buf, unsign
 	}
 
 	/* Write error to NVRAM */
-	if (!no_more_logging && !(err_type & ERR_FLAG_BOOT))
+	if (!no_logging && !(err_type & ERR_FLAG_BOOT))
 		nvram_write_error_log(buf, len, err_type);
 
 	/*
@@ -225,8 +225,8 @@ void pSeries_log_error(char *buf, unsign
 		printk_log_rtas(buf, len);
 
 	/* Check to see if we need to or have stopped logging */
-	if (fatal || no_more_logging) {
-		no_more_logging = 1;
+	if (fatal || no_logging) {
+		no_logging = 1;
 		spin_unlock_irqrestore(&rtasd_log_lock, s);
 		return;
 	}
@@ -299,7 +299,7 @@ static ssize_t rtas_log_read(struct file
 
 	spin_lock_irqsave(&rtasd_log_lock, s);
 	/* if it's 0, then we know we got the last one (the one in NVRAM) */
-	if (rtas_log_size == 0 && !no_more_logging)
+	if (rtas_log_size == 0 && !no_logging)
 		nvram_clear_error_log();
 	spin_unlock_irqrestore(&rtasd_log_lock, s);
 
@@ -417,9 +417,6 @@ static int rtasd(void *unused)
 		goto error;
 	}
 
-	/* We can use rtas_log_buf now */
-	no_more_logging = 0;
-
 	printk(KERN_ERR "RTAS daemon started\n");
 
 	DEBUG("will sleep for %d jiffies\n", (HZ*60/rtas_event_scan_rate) / 2);
@@ -428,6 +425,10 @@ static int rtasd(void *unused)
 	memset(logdata, 0, rtas_error_log_max);
 
 	rc = nvram_read_error_log(logdata, rtas_error_log_max, &err_type);
+
+	/* We can use rtas_log_buf now */
+	no_logging = 0;
+
 	if (!rc) {
 		if (err_type != ERR_FLAG_ALREADY_LOGGED) {
 			pSeries_log_error(logdata, err_type | ERR_FLAG_BOOT, 0);
diff -puN arch/ppc64/kernel/nvram.c~rtasd-no_more_logging-race arch/ppc64/kernel/nvram.c
--- linux-2.6-bk/arch/ppc64/kernel/nvram.c~rtasd-no_more_logging-race	Mon Nov  8 11:52:39 2004
+++ linux-2.6-bk-moilanen/arch/ppc64/kernel/nvram.c	Mon Nov  8 12:20:13 2004
@@ -43,9 +43,9 @@ static struct nvram_partition * nvram_pa
 static long nvram_error_log_index = -1;
 static long nvram_error_log_size = 0;
 
-volatile int no_more_logging = 1; /* Until we initialize everything,
-				   * make sure we don't try logging
-				   * anything */
+int no_logging = 1; 	/* Until we initialize everything,
+			 * make sure we don't try logging
+			 * anything */
 
 extern volatile int error_log_cnt;
 
@@ -640,7 +640,7 @@ int nvram_write_error_log(char * buff, i
 	loff_t tmp_index;
 	struct err_log_info info;
 	
-	if (no_more_logging) {
+	if (no_logging) {
 		return -EPERM;
 	}
 
