Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261300AbULAASY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261300AbULAASY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 19:18:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261310AbULAASK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 19:18:10 -0500
Received: from mail.kroah.org ([69.55.234.183]:49124 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261280AbULAAOY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 19:14:24 -0500
Subject: Re: [PATCH] I2C fixes for 2.6.10-rc2
In-Reply-To: <11018600193088@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 30 Nov 2004 16:13:39 -0800
Message-Id: <11018600191194@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2223.2.5, 2004/11/24 14:25:49-08:00, aris@cathedrallabs.org

[PATCH] i2c-elektor: get rid of cli/sti

this patch get rid of cli()/sti(). while correcting this I found
that when a process wakes by an interrupt, pcf_pending doesn't
come back to 0 and next caller will return imediately. also,
there are other drivers with the exact same problem. if you
don't have any comments on this, I'll do the same for other
drivers.


[I2C] i2c-elektor: getting rid of cli()/sti() usage

Signed-off-by: Aristeu Sergio Rozanski Filho <aris@cathedrallabs.org>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/i2c/busses/i2c-elektor.c |   22 ++++++++++++++++++----
 1 files changed, 18 insertions(+), 4 deletions(-)


diff -Nru a/drivers/i2c/busses/i2c-elektor.c b/drivers/i2c/busses/i2c-elektor.c
--- a/drivers/i2c/busses/i2c-elektor.c	2004-11-30 16:01:05 -08:00
+++ b/drivers/i2c/busses/i2c-elektor.c	2004-11-30 16:01:05 -08:00
@@ -59,6 +59,7 @@
 
 static wait_queue_head_t pcf_wait;
 static int pcf_pending;
+static spinlock_t lock;
 
 /* ----- local functions ----------------------------------------------	*/
 
@@ -111,14 +112,24 @@
 static void pcf_isa_waitforpin(void) {
 
 	int timeout = 2;
+	long flags;
 
 	if (irq > 0) {
-		cli();
+		spin_lock_irqsave(&lock, flags);
 		if (pcf_pending == 0) {
-			interruptible_sleep_on_timeout(&pcf_wait, timeout*HZ );
-		} else
+			spin_unlock_irqrestore(&lock, flags);
+			if (interruptible_sleep_on_timeout(&pcf_wait,
+								timeout*HZ)) {
+				spin_lock_irqsave(&lock, flags);
+				if (pcf_pending == 1) {
+					pcf_pending = 0;
+				}
+				spin_unlock_irqrestore(&lock, flags);
+			}
+		} else {
 			pcf_pending = 0;
-		sti();
+			spin_unlock_irqrestore(&lock, flags);
+		}
 	} else {
 		udelay(100);
 	}
@@ -126,7 +137,9 @@
 
 
 static irqreturn_t pcf_isa_handler(int this_irq, void *dev_id, struct pt_regs *regs) {
+	spin_lock(&lock);
 	pcf_pending = 1;
+	spin_unlock(&lock);
 	wake_up_interruptible(&pcf_wait);
 	return IRQ_HANDLED;
 }
@@ -134,6 +147,7 @@
 
 static int pcf_isa_init(void)
 {
+	spin_lock_init(&lock);
 	if (!mmapped) {
 		if (!request_region(base, 2, "i2c (isa bus adapter)")) {
 			printk(KERN_ERR

