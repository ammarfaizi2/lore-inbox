Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265765AbUAKE5N (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jan 2004 23:57:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265766AbUAKE5N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jan 2004 23:57:13 -0500
Received: from smtp811.mail.sc5.yahoo.com ([66.163.170.81]:62820 "HELO
	smtp811.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S265765AbUAKE5L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jan 2004 23:57:11 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Gunter =?iso-8859-1?q?K=F6nigsmann?= <gunter.koenigsmann@gmx.de>,
       Gunter =?iso-8859-1?q?K=F6nigsmann?= <gunter@peterpall.de>
Subject: Re: [PATCH 3/2] Psmouse log and discard timed out bytes - addition
Date: Sat, 10 Jan 2004 23:57:00 -0500
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org, Vojtech Pavlik <vojtech@suse.cz>,
       Andrew Morton <akpm@osdl.org>
References: <Pine.LNX.4.53.0401091101170.1050@calcula.uni-erlangen.de> <200401100345.17211.dtor_core@ameritech.net> <200401100346.04660.dtor_core@ameritech.net>
In-Reply-To: <200401100346.04660.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401102357.03434.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gunter,

I have some additions to the last patch and I'd like you to give it a spin.
Also, could you please define DEBUG symbol in drivers/input/serio/i8042.c
and send me your dmesg with boot data and also when the touchpad loses
sync. I'd like to see it in all gory details :)

Thank you,

Dmitry


===================================================================


ChangeSet@1.1514, 2004-01-10 23:50:51-05:00, dtor_core@ameritech.net
  Input: Change the way timeouts/parity errors are handled:
         - Only complain about errors from keyboard controller if mouse
           is activated
         - Reset packet count to 0 as the next received byte will most
           likely be the first byte of a new packet
         - If expecting an ACK from the mouse set NACK condition


 psmouse-base.c |   12 +++++++++---
 1 files changed, 9 insertions(+), 3 deletions(-)


===================================================================



diff -Nru a/drivers/input/mouse/psmouse-base.c b/drivers/input/mouse/psmouse-base.c
--- a/drivers/input/mouse/psmouse-base.c	Sat Jan 10 23:55:28 2004
+++ b/drivers/input/mouse/psmouse-base.c	Sat Jan 10 23:55:28 2004
@@ -122,9 +122,15 @@
 		goto out;
 
 	if (flags & (SERIO_PARITY|SERIO_TIMEOUT)) {
-		printk(KERN_WARNING "psmouse.c: bad data from KBC -%s%s\n",
-			flags & SERIO_TIMEOUT ? " timeout" : "",
-			flags & SERIO_PARITY ? " bad parity" : "");
+		if (psmouse->state == PSMOUSE_ACTIVATED)
+			printk(KERN_WARNING "psmouse.c: bad data from KBC -%s%s\n",
+				flags & SERIO_TIMEOUT ? " timeout" : "",
+				flags & SERIO_PARITY ? " bad parity" : "");
+		if (psmouse->acking) {
+			psmouse->ack = -1;
+			psmouse->acking = 0;
+		}
+		psmouse->pktcnt = 0;
 		goto out;
 	}
 
