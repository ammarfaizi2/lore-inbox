Return-Path: <linux-kernel-owner+willy=40w.ods.org-S968683AbWLEUh6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S968683AbWLEUh6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 15:37:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968684AbWLEUh5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 15:37:57 -0500
Received: from wylie.me.uk ([82.68.155.89]:33959 "EHLO mail.wylie.me.uk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S968683AbWLEUh4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 15:37:56 -0500
From: "Alan J. Wylie" <alan@wylie.me.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17781.55454.538734.421950@wylie.me.uk>
Date: Tue, 5 Dec 2006 20:37:50 +0000
To: linux-kernel@vger.kernel.org
Subject: [PATCH 2.6.19 1/1] atkb: supress repeated warning messages
In-Reply-To: <17777.34301.958405.967354@wylie.me.uk>
References: <17777.34301.958405.967354@wylie.me.uk>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2 Dec 2006 13:56:13 +0000, "Alan J. Wylie" <alan@wylie.me.uk> said:

> I was presented with a continous stream of error messages:

> atkbd.c: Spurious ACK on isa0060/serio Some program might be trying
> to access hardware directly.

> These seem to be as a result of the keyboard LEDs being flashed.

> They cause the real error message:

> Cannot open root device

> and the preceding kernel messages which show a lack of detection of
> the SATA hard drive to be rapidly scrolled off screen.

> The atkbd message should at the very least be rate limited.

Here is an ugly hack that limits the above error message.

--- linux/drivers/input/keyboard/atkbd.c.orig	2006-12-05 20:34:50.000000000 +0000
+++ linux/drivers/input/keyboard/atkbd.c	2006-12-03 13:43:13.000000000 +0000
@@ -412,9 +412,16 @@
 			goto out;
 		case ATKBD_RET_ACK:
 		case ATKBD_RET_NAK:
-			printk(KERN_WARNING "atkbd.c: Spurious %s on %s. "
-			       "Some program might be trying access hardware directly.\n",
-			       data == ATKBD_RET_ACK ? "ACK" : "NAK", serio->phys);
+			{
+				static int warned = 0;
+
+				if (!warned) {
+					printk(KERN_WARNING "atkbd.c: Spurious %s on %s. "
+					       "Some program might be trying access hardware directly.\n",
+					       data == ATKBD_RET_ACK ? "ACK" : "NAK", serio->phys);
+					warned = 1;
+				}
+			}
 			goto out;
 		case ATKBD_RET_HANGEUL:
 		case ATKBD_RET_HANJA:


Signed-off-by: Alan J. Wylie <alan@wylie.me.uk>

-- 
Alan J. Wylie                                          http://www.wylie.me.uk/
"Perfection [in design] is achieved not when there is nothing left to add,
but rather when there is nothing left to take away."
  -- Antoine de Saint-Exupery
