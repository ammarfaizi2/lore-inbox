Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262063AbVCaXcl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262063AbVCaXcl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 18:32:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262066AbVCaXbv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 18:31:51 -0500
Received: from mail.kroah.org ([69.55.234.183]:25824 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262063AbVCaXYF convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 18:24:05 -0500
Cc: domen@coderock.org
Subject: [PATCH] i2c/i2c-elektor: remove interruptible_sleep_on_timeout() usage
In-Reply-To: <11123113891852@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Thu, 31 Mar 2005 15:23:09 -0800
Message-Id: <11123113893610@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2323, 2005/03/31 14:05:31-08:00, domen@coderock.org

[PATCH] i2c/i2c-elektor: remove interruptible_sleep_on_timeout() usage

Replace deprecated interruptible_sleep_on_timeout() with direct
wait-queue usage. Patch is compile-tested.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
Signed-off-by: Domen Puncer <domen@coderock.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>


 drivers/i2c/busses/i2c-elektor.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)


diff -Nru a/drivers/i2c/busses/i2c-elektor.c b/drivers/i2c/busses/i2c-elektor.c
--- a/drivers/i2c/busses/i2c-elektor.c	2005-03-31 15:19:14 -08:00
+++ b/drivers/i2c/busses/i2c-elektor.c	2005-03-31 15:19:14 -08:00
@@ -110,7 +110,7 @@
 }
 
 static void pcf_isa_waitforpin(void) {
-
+	DEFINE_WAIT(wait);
 	int timeout = 2;
 	long flags;
 
@@ -118,14 +118,15 @@
 		spin_lock_irqsave(&lock, flags);
 		if (pcf_pending == 0) {
 			spin_unlock_irqrestore(&lock, flags);
-			if (interruptible_sleep_on_timeout(&pcf_wait,
-								timeout*HZ)) {
+			prepare_to_wait(&pcf_wait, &wait, TASK_INTERRUPTIBLE);
+			if (schedule_timeout(timeout*HZ)) {
 				spin_lock_irqsave(&lock, flags);
 				if (pcf_pending == 1) {
 					pcf_pending = 0;
 				}
 				spin_unlock_irqrestore(&lock, flags);
 			}
+			finish_wait(&pcf_wait, &wait);
 		} else {
 			pcf_pending = 0;
 			spin_unlock_irqrestore(&lock, flags);

