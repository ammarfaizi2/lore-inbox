Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263453AbTHWGdW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Aug 2003 02:33:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262179AbTHWGb6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Aug 2003 02:31:58 -0400
Received: from smtp809.mail.sc5.yahoo.com ([66.163.168.188]:11877 "HELO
	smtp809.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261711AbTHWGbx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Aug 2003 02:31:53 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 2.6] 1/3 Serio: claim serio early
Date: Sat, 23 Aug 2003 01:31:50 -0500
User-Agent: KMail/1.5.1
MIME-Version: 1.0
Content-Disposition: inline
Cc: Vojtech Pavlik <vojtech@suse.cz>
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200308230131.50388.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, 

I think that serio_dev in serio_open should claim serio before calling 
"open" function as it has already been decided that (in case of success)
this serio belongs to that serio_dev. Otherwise it might try to find an
owner on its own, like i8042 module that calls serio_interrupt which in 
turn will do serio_rescan. From that point on 2 instances may start 
fighting over the same serio.

What you think about the patch below?

Dmitry

diff -urN --exclude-from=/usr/src/exclude 2.6.0-test4/drivers/input/serio/serio.c linux-2.6.0-test4/drivers/input/serio/serio.c
--- 2.6.0-test4/drivers/input/serio/serio.c	2003-08-22 21:53:29.000000000 -0500
+++ linux-2.6.0-test4/drivers/input/serio/serio.c	2003-08-22 22:58:37.000000000 -0500
@@ -204,9 +204,11 @@
 /* called from serio_dev->connect/disconnect methods under serio_sem */
 int serio_open(struct serio *serio, struct serio_dev *dev)
 {
-	if (serio->open(serio))
-		return -1;
 	serio->dev = dev;
+	if (serio->open(serio)) {
+		serio->dev = NULL;
+		return -1;
+	}
 	return 0;
 }
 

