Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267880AbUJTAhE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267880AbUJTAhE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 20:37:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267363AbUJTAdI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 20:33:08 -0400
Received: from mail.kroah.org ([69.55.234.183]:10164 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S267739AbUJTATc convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 20:19:32 -0400
Subject: Re: [PATCH] I2C update for 2.6.9
In-Reply-To: <10982315052653@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 19 Oct 2004 17:18:25 -0700
Message-Id: <10982315053127@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1867.7.8, 2004/09/21 16:40:19-07:00, nacc@us.ibm.com

[PATCH] i2c/i2c-mpc: replace schedule_timeout() with msleep_interruptible()

Properly orders set_current_state() and add_wait_queue().  Uses
msleep_interruptible() in place of schedule_timeout() to guarantee the
task delays as expected. Uses set_current_state() instead of direct
assignment of current->state.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/i2c/busses/i2c-mpc.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)


diff -Nru a/drivers/i2c/busses/i2c-mpc.c b/drivers/i2c/busses/i2c-mpc.c
--- a/drivers/i2c/busses/i2c-mpc.c	2004-10-19 16:54:50 -07:00
+++ b/drivers/i2c/busses/i2c-mpc.c	2004-10-19 16:54:50 -07:00
@@ -23,6 +23,7 @@
 #include <asm/ocp.h>
 #include <linux/i2c.h>
 #include <linux/interrupt.h>
+#include <linux/delay.h>
 
 #define MPC_I2C_ADDR  0x00
 #define MPC_I2C_FDR 	0x04
@@ -91,9 +92,9 @@
 		x = readb(i2c->base + MPC_I2C_SR);
 		writeb(0, i2c->base + MPC_I2C_SR);
 	} else {
+		set_current_state(TASK_INTERRUPTIBLE);
 		add_wait_queue(&i2c->queue, &wait);
 		while (!(i2c->interrupt & CSR_MIF)) {
-			set_current_state(TASK_INTERRUPTIBLE);
 			if (signal_pending(current)) {
 				pr_debug("I2C: Interrupted\n");
 				result = -EINTR;
@@ -104,9 +105,9 @@
 				result = -EIO;
 				break;
 			}
-			schedule_timeout(timeout);
+			msleep_interruptible(jiffies_to_msecs(timeout));
 		}
-		current->state = TASK_RUNNING;
+		set_current_state(TASK_RUNNING);
 		remove_wait_queue(&i2c->queue, &wait);
 		x = i2c->interrupt;
 		i2c->interrupt = 0;

