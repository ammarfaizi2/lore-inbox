Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261193AbTLHSRF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Dec 2003 13:17:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261217AbTLHSRF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Dec 2003 13:17:05 -0500
Received: from smtp807.mail.sc5.yahoo.com ([66.163.168.186]:45647 "HELO
	smtp807.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261193AbTLHSRB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Dec 2003 13:17:01 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Peter Berg Larsen <pebl@math.ku.dk>
Subject: Re: Synaptics PS/2 driver and 2.6.0-test11
Date: Mon, 8 Dec 2003 13:16:46 -0500
User-Agent: KMail/1.5.4
Cc: Santiago Garcia Mantinan <manty@manty.net>,
       Lukas Hejtmanek <xhejtman@mail.muni.cz>,
       Michal Jaegermann <michal@harddata.com>, <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.40.0312081021080.10795-100000@shannon.math.ku.dk>
In-Reply-To: <Pine.LNX.4.40.0312081021080.10795-100000@shannon.math.ku.dk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312081316.47899.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 08 December 2003 04:54 am, Peter Berg Larsen wrote:
> On Sun, 7 Dec 2003, Dmitry Torokhov wrote:
> > The difference is that GPM (I assume you are using it to get
> > Synaptics support) only logs "protocol violations" when in debug
> > mode, and then it only checks 2 first bytes.
>
> No, gpm checks the first byte and decide whether to read the following
> 5 bytes (or trough the byte away). The synaptics driver itself does the
> same tests as the kernelcode (and reports an error).
>
> Peter

You are right, Synaptics does check entire packet and reports it, 
unfortunately many (most) distributions kill almost all GPM messages
because it's too noisy.

Anyway, I wonder if the patch below will help sync problem. If it does
then we can kill the warning message later.

The patch should apply to -test11 although will complain about offset
as I have some extra stuff in my tree.

Dmitry

===== drivers/input/mouse/psmouse-base.c 1.40 vs edited =====
--- 1.40/drivers/input/mouse/psmouse-base.c	Sun Dec  7 02:05:20 2003
+++ edited/drivers/input/mouse/psmouse-base.c	Mon Dec  8 13:05:05 2003
@@ -125,6 +125,13 @@
 	if (psmouse->state == PSMOUSE_IGNORE)
 		goto out;
 
+	if (flags & (SERIO_PARITY|SERIO_TIMEOUT)) {
+		printk(KERN_WARNING "psmouse: bad data from KBC -%s%s\n",
+		 	flags & SERIO_TIMEOUT ? " timeout" : "",
+			flags & SERIO_PARITY ? " bad parity" : "");
+		goto out;
+	}
+
 	if (psmouse->acking) {
 		switch (data) {
 			case PSMOUSE_RET_ACK:
