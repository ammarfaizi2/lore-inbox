Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266310AbUANNHB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 08:07:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266315AbUANNHB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 08:07:01 -0500
Received: from smtp814.mail.sc5.yahoo.com ([66.163.170.84]:25473 "HELO
	smtp814.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S266310AbUANNG6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 08:06:58 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: 2.6.1-mm3
Date: Wed, 14 Jan 2004 08:06:41 -0500
User-Agent: KMail/1.5.4
References: <20040114014846.78e1a31b.akpm@osdl.org>
In-Reply-To: <20040114014846.78e1a31b.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401140806.43510.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 14 January 2004 04:48 am, Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.1/2.6

> +psmouse-drop-timed-out-bytes.patch

Andrew,

Could you please queue this one for your next -mm - first attempt was too
eager at complaining - it's ok to have timeout while we probing ports, etc.
so warnings should only be produced if mouse is in active state.


The patch depends on the one you have.

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
 
