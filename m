Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261254AbULAAST@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261254AbULAAST (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 19:18:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261156AbULAAQQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 19:16:16 -0500
Received: from mail.kroah.org ([69.55.234.183]:34020 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261195AbULAAOO convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 19:14:14 -0500
Subject: Re: [PATCH] I2C fixes for 2.6.10-rc2
In-Reply-To: <1101860019530@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 30 Nov 2004 16:13:39 -0800
Message-Id: <11018600193653@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2223.2.9, 2004/11/29 15:07:15-08:00, aris@cathedrallabs.org

[PATCH] i2c-ite: get rid of cli()/sti()

I found only this one. Next time I'll try to make better grep
expressions :^)

[I2C] i2c-ite: get rid of cli()/sti()

Signed-off-by: Aristeu Sergio Rozanski Filho <aris@cathedrallabs.org>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/i2c/busses/i2c-ite.c |   31 +++++++++++++++++++++++--------
 1 files changed, 23 insertions(+), 8 deletions(-)


diff -Nru a/drivers/i2c/busses/i2c-ite.c b/drivers/i2c/busses/i2c-ite.c
--- a/drivers/i2c/busses/i2c-ite.c	2004-11-30 16:00:43 -08:00
+++ b/drivers/i2c/busses/i2c-ite.c	2004-11-30 16:00:43 -08:00
@@ -62,6 +62,7 @@
 static struct iic_ite gpi;
 static wait_queue_head_t iic_wait;
 static int iic_pending;
+static spinlock_t lock;
 
 /* ----- local functions ----------------------------------------------	*/
 
@@ -108,6 +109,7 @@
 static void iic_ite_waitforpin(void) {
 
    int timeout = 2;
+   long flags;
 
    /* If interrupts are enabled (which they are), then put the process to
     * sleep.  This process will be awakened by two events -- either the
@@ -116,24 +118,36 @@
     * of time and return.
     */
    if (gpi.iic_irq > 0) {
-	cli();
+	spin_lock_irqsave(&lock, flags);
 	if (iic_pending == 0) {
-		interruptible_sleep_on_timeout(&iic_wait, timeout*HZ );
-	} else
+		spin_unlock_irqrestore(&lock, flags);
+		if (interruptible_sleep_on_timeout(&iic_wait, timeout*HZ)) {
+			spin_lock_irqsave(&lock, flags);
+			if (iic_pending == 1) {
+				iic_pending = 0;
+			}
+			spin_unlock_irqrestore(&lock, flags);
+		}
+	} else {
 		iic_pending = 0;
-	sti();
+		spin_unlock_irqrestore(&lock, flags);
+	}
    } else {
       udelay(100);
    }
 }
 
 
-static void iic_ite_handler(int this_irq, void *dev_id, struct pt_regs *regs) 
+static irqreturn_t iic_ite_handler(int this_irq, void *dev_id,
+							struct pt_regs *regs)
 {
-	
-   iic_pending = 1;
+	spin_lock(&lock);
+	iic_pending = 1;
+	spin_unlock(&lock);
+
+	wake_up_interruptible(&iic_wait);
 
-   wake_up_interruptible(&iic_wait);
+	return IRQ_HANDLED;
 }
 
 
@@ -221,6 +235,7 @@
 
 	iic_ite_data.data = (void *)piic;
 	init_waitqueue_head(&iic_wait);
+	spin_lock_init(&lock);
 	if (iic_hw_resrc_init() == 0) {
 		if (i2c_iic_add_bus(&iic_ite_ops) < 0)
 			return -ENODEV;

