Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751330AbVIWWka@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751330AbVIWWka (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Sep 2005 18:40:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751331AbVIWWka
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Sep 2005 18:40:30 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:52356 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751330AbVIWWk3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Sep 2005 18:40:29 -0400
Date: Fri, 23 Sep 2005 17:40:18 -0500 (CDT)
From: Brent Casavant <bcasavan@sgi.com>
Reply-To: Brent Casavant <bcasavan@sgi.com>
To: linux-kernel@vger.kernel.org
cc: Andrew Morton <akpm@osdl.org>
Subject: [PATCH] ioc4_serial: Remove bogus error message
Message-ID: <20050923173530.G4371@chenjesu.americas.sgi.com>
Organization: "Silicon Graphics, Inc."
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This change removes a bogus error message from the IOC4 serial driver
interrupt handler.

This error message is bogus for two reasons.  First, it can never occur
given that current code takes care to initialize IOC4 in such a way that
these "unknown" interrupts could never occur.   Second, this code fails
to take into account that other drivers can share the IOC4 interrupt
mechanism through SA_SHIRQ, and thus this driver is not in-fact "all-knowing".

Finally, this error message triggers every time some "unknown" interrupt
occurs -- it's not rate limited or repetition limited in any way,
thereby effectively denying use of the console device.  Given its
bogosity in the first place, it's best to just get rid of it entirely.

Acked-by: Pat Gefre <pfg@sgi.com>
Signed-off-by: Brent Casavant <bcasavan@sgi.com>

 ioc4_serial.c |   12 ------------
 1 files changed, 12 deletions(-)

diff --git a/drivers/serial/ioc4_serial.c b/drivers/serial/ioc4_serial.c
--- a/drivers/serial/ioc4_serial.c
+++ b/drivers/serial/ioc4_serial.c
@@ -973,18 +973,6 @@ static irqreturn_t ioc4_intr(int irq, vo
 				this_ir &= ~this_mir;
 			}
 		}
-		if (this_ir) {
-			printk(KERN_ERR
-			       "unknown IOC4 %s interrupt 0x%x, sio_ir = 0x%x,"
-				" sio_ies = 0x%x, other_ir = 0x%x :"
-				"other_ies = 0x%x\n",
-			       (intr_type == IOC4_SIO_INTR_TYPE) ? "sio" :
-			       "other", this_ir,
-			       readl(&soft->is_ioc4_misc_addr->sio_ir.raw),
-			       readl(&soft->is_ioc4_misc_addr->sio_ies.raw),
-			       readl(&soft->is_ioc4_misc_addr->other_ir.raw),
-			       readl(&soft->is_ioc4_misc_addr->other_ies.raw));
-		}
 	}
 #ifdef DEBUG_INTERRUPTS
 	{
