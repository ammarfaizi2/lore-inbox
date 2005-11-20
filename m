Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751256AbVKTP3a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751256AbVKTP3a (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Nov 2005 10:29:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751257AbVKTP3a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Nov 2005 10:29:30 -0500
Received: from pne-smtpout2-sn2.hy.skanova.net ([81.228.8.164]:54415 "EHLO
	pne-smtpout2-sn2.hy.skanova.net") by vger.kernel.org with ESMTP
	id S1751256AbVKTP3a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Nov 2005 10:29:30 -0500
Message-ID: <43809652.8000904@comhem.se>
Date: Sun, 20 Nov 2005 16:29:22 +0100
From: =?ISO-8859-1?Q?Daniel_Marjam=E4ki?= <daniel.marjamaki@comhem.se>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030313
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: =?ISO-8859-1?Q?Daniel_Marjam=E4ki?= <daniel.marjamaki@comhem.se>
Subject: I made a patch and would like feedback/testers (drivers/cdrom/aztcd.c)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello!

I made a patch and I would like feedback.
If you can test the patch.. please let me know.

Background:
There are busy loops that time out after 8 million repetitions.
I made these improvements:
* Sleep during the busy loops
* Time out is based on elapsed time

If this patch is accepted, AZT_TIMEOUT can be removed.

Best regards,
Daniel Marjamäki

diff -up a/drivers/cdrom/aztcd.c b/drivers/cdrom/aztcd.c

--- a/drivers/cdrom/aztcd.c	2005-11-17 11:39:53.000000000 +0100
+++ b/drivers/cdrom/aztcd.c	2005-11-19 17:14:58.000000000 +0100
@@ -179,6 +179,7 @@
  #include <linux/ioport.h>
  #include <linux/string.h>
  #include <linux/major.h>
+#include <linux/jiffies.h>

  #include <linux/init.h>

@@ -308,7 +309,7 @@ static char aztDiskChanged = 1;
  static char aztTocUpToDate = 0;

  static unsigned char aztIndatum;
-static unsigned long aztTimeOutCount;
+static unsigned long aztTimeOutCount, aztTimeOut;
  static int aztCmd = 0;

  static DEFINE_SPINLOCK(aztSpin);
@@ -361,14 +362,14 @@ static int azt_bcd2bin(unsigned char bcd
  # define OP_OK op_ok()
  static void op_ok(void)
  {
-	aztTimeOutCount = 0;
+	aztTimeOut = jiffies + 2;
  	do {
  		aztIndatum = inb(DATA_PORT);
-		aztTimeOutCount++;
-		if (aztTimeOutCount >= AZT_TIMEOUT) {
+		if (time_after(jiffies, aztTimeOut)) {
  			printk("aztcd: Error Wait OP_OK\n");
  			break;
  		}
+		schedule_timeout_interruptible(1);
  	} while (aztIndatum != AFL_OP_OK);
  }

@@ -377,14 +378,14 @@ static void op_ok(void)
  # define PA_OK pa_ok()
  static void pa_ok(void)
  {
-	aztTimeOutCount = 0;
+	aztTimeOut = jiffies + 2;
  	do {
  		aztIndatum = inb(DATA_PORT);
-		aztTimeOutCount++;
-		if (aztTimeOutCount >= AZT_TIMEOUT) {
+		if (time_after(jiffies, aztTimeOut)) {
  			printk("aztcd: Error Wait PA_OK\n");
  			break;
  		}
+		schedule_timeout_interruptible(1);
  	} while (aztIndatum != AFL_PA_OK);
  }
  #endif
@@ -393,17 +394,17 @@ static void pa_ok(void)
  # define STEN_LOW  sten_low()
  static void sten_low(void)
  {
-	aztTimeOutCount = 0;
+	aztTimeOut = jiffies + 2;
  	do {
  		aztIndatum = inb(STATUS_PORT);
-		aztTimeOutCount++;
-		if (aztTimeOutCount >= AZT_TIMEOUT) {
+		if (time_after(jiffies, aztTimeOut)) {
  			if (azt_init_end)
  				printk
  				    ("aztcd: Error Wait STEN_LOW commands:%x\n",
  				     aztCmd);
  			break;
  		}
+		schedule_timeout_interruptible(1);
  	} while (aztIndatum & AFL_STATUS);
  }

@@ -411,14 +412,14 @@ static void sten_low(void)
  # define DTEN_LOW dten_low()
  static void dten_low(void)
  {
-	aztTimeOutCount = 0;
+	aztTimeOut = jiffies + 2;
  	do {
  		aztIndatum = inb(STATUS_PORT);
-		aztTimeOutCount++;
-		if (aztTimeOutCount >= AZT_TIMEOUT) {
+		if (time_after(jiffies, aztTimeOut)) {
  			printk("aztcd: Error Wait DTEN_OK\n");
  			break;
  		}
+		schedule_timeout_interruptible(1);
  	} while (aztIndatum & AFL_DATA);
  }



