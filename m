Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265481AbUF3AK4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265481AbUF3AK4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jun 2004 20:10:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266143AbUF3AKz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jun 2004 20:10:55 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:38055 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S265481AbUF3AKt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jun 2004 20:10:49 -0400
Date: Tue, 29 Jun 2004 19:10:46 -0500
From: linas@austin.ibm.com
To: paulus@au1.ibm.com, paulus@samba.org
Cc: linuxppc64-dev@lists.linuxppc.org, linux-kernel@vger.kernel.org
Subject: [PATCH] [2.6] PPC64: log firmware errors during boot.
Message-ID: <20040629191046.Q21634@forte.austin.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="lIrNkN/7tmsD/ALM"
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--lIrNkN/7tmsD/ALM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


Paul,

Here's the fourth patch ... please apply.

Firmware can report errors at any time, and not atypically during boot.
However, these reports were being discarded until th rtasd comes up,
which occurs fairly late in the boot cycle.  As a result, firmware
errors during boot were being silently ignored. 

This patch at least gets them printk'ed so that at least they show 
up in boot.msg/syslog.  There are two other logging mechanisms,
nvram and rtas, that I didn't touch because I don't understand 
the reprecussions.  In particular, nvram logging isn't enabled
until late in the boot ... but what's the point of nvram logging
if not to catch messages that occured very early in boot ?? 

Please apply the patch, and discussion welcome on how nvram
logging works/should work ... 

Signed-off-by: Linas Vepstas <linas@linas.org>

--linas




--lIrNkN/7tmsD/ALM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="rtas-log-boot-msgs.patch"

--- arch/ppc64/kernel/rtasd.c.orig	2004-06-28 15:33:12.000000000 -0500
+++ arch/ppc64/kernel/rtasd.c	2004-06-29 18:51:31.000000000 -0500
@@ -57,6 +57,8 @@ volatile int error_log_cnt = 0;
  */
 static unsigned char logdata[RTAS_ERROR_LOG_MAX];
 
+static int get_eventscan_parms(void);
+		  
 /* To see this info, grep RTAS /var/log/messages and each entry
  * will be collected together with obvious begin/end.
  * There will be a unique identifier on the begin and end lines.
@@ -121,6 +123,9 @@ static int log_rtas_len(char * buf)
 		len += err->extended_log_length;
 	}
 
+	if (rtas_error_log_max == 0) {
+		get_eventscan_parms();
+	}
 	if (len > rtas_error_log_max)
 		len = rtas_error_log_max;
 
@@ -148,7 +153,6 @@ void pSeries_log_error(char *buf, unsign
 	int len = 0;
 
 	DEBUG("logging event\n");
-
 	if (buf == NULL)
 		return;
 
@@ -171,6 +175,13 @@ void pSeries_log_error(char *buf, unsign
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

--lIrNkN/7tmsD/ALM--
