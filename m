Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129562AbRAID2n>; Mon, 8 Jan 2001 22:28:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129324AbRAID2f>; Mon, 8 Jan 2001 22:28:35 -0500
Received: from ns.mtu.ru ([195.34.32.10]:51153 "HELO mtu.ru")
	by vger.kernel.org with SMTP id <S129226AbRAID2V>;
	Mon, 8 Jan 2001 22:28:21 -0500
X-Recipient: linux-kernel@vger.kernel.org
From: Dmitry Potapov <dpotapov@capitalsoft.com>
Date: Tue, 9 Jan 2001 06:28:00 +0300
To: linux-kernel@vger.kernel.org
Subject: AHA1542 driver does not accept command-line options
Message-ID: <20010109062800.A644@potapov.private>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When I switch to 2.4 kernel my SCSI card does not detect anymore,
because AHA1542 driver does not accept kernel command-line options.

I send small patch to fix that.

I'm not subscribed at the kernel mail list, so please send any 
question/answer to my personal mail address.

Thanks,
Dmitry Potapov

--- drivers/scsi/aha1542.c.orig	Thu Nov 23 20:33:36 2000
+++ drivers/scsi/aha1542.c	Tue Jan  9 04:45:12 2001
@@ -947,11 +947,12 @@
 	return 0;
 }
 
-/* called from init/main.c */
+#ifndef MODULE
+static int setup_idx = 0;
+
 void __init aha1542_setup(char *str, int *ints)
 {
 	const char *ahausage = "aha1542: usage: aha1542=<PORTBASE>[,<BUSON>,<BUSOFF>[,<DMASPEED>]]\n";
-	static int setup_idx = 0;
 	int setup_portbase;
 
 	if (setup_idx >= MAXBOARDS) {
@@ -1004,6 +1005,21 @@
 
 	++setup_idx;
 }
+
+static int __init do_setup(char *str)
+{
+	int ints[4];
+
+	int count=setup_idx;
+
+	get_options(str, sizeof(ints)/sizeof(int), ints);
+	aha1542_setup(str,ints);
+
+	return count<setup_idx;
+}
+
+__setup("aha1542=",do_setup);
+#endif
 
 /* return non-zero on detection */
 int aha1542_detect(Scsi_Host_Template * tpnt)
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
