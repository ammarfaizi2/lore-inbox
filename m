Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266192AbUFIXBK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266192AbUFIXBK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 19:01:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266195AbUFIXBK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 19:01:10 -0400
Received: from relay2.EECS.Berkeley.EDU ([169.229.60.28]:14978 "EHLO
	relay2.EECS.Berkeley.EDU") by vger.kernel.org with ESMTP
	id S266192AbUFIXBE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 19:01:04 -0400
Subject: PATCH: 2.6.7-rc3 drivers/message/i2o/i2o_config.c: user/kernel
	pointer bugs
From: "Robert T. Johnson" <rtjohnso@eecs.berkeley.edu>
To: Markus.Lidel@shadowconnect.com
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 09 Jun 2004 16:01:02 -0700
Message-Id: <1086822062.32052.129.camel@dooby.cs.berkeley.edu>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Since arg is a user pointer, accessing values like cmd->iop requires an 
unsafe user pointer dereference.

QUESTION: Does ioctl_passthru mean arg is a kernel pointer?  If so, then
disregard this bug report.

Let me know if you have any questions, and thanks for looking into this.

Best,
Rob


--- linux-2.6.7-rc3-full/drivers/message/i2o/i2o_config.c.orig	Wed Jun  9 12:14:08 2004
+++ linux-2.6.7-rc3-full/drivers/message/i2o/i2o_config.c	Wed Jun  9 12:13:33 2004
@@ -842,10 +842,10 @@ static int ioctl_evt_get(unsigned long a
 
 static int ioctl_passthru(unsigned long arg)
 {
-	struct i2o_cmd_passthru *cmd = (struct i2o_cmd_passthru *) arg;
+	struct i2o_cmd_passthru cmd;
 	struct i2o_controller *c;
 	u32 msg[MSG_FRAME_SIZE];
-	u32 *user_msg = (u32*)cmd->msg;
+	u32 *user_msg;
 	u32 *reply = NULL;
 	u32 *user_reply = NULL;
 	u32 size = 0;
@@ -858,11 +858,16 @@ static int ioctl_passthru(unsigned long 
 	u32 i = 0;
 	ulong p = 0;
 
-	c = i2o_find_controller(cmd->iop);
+	if (copy_from_user(&cmd, (void *)arg, sizeof(cmd)))
+	  return -EFAULT;
+
+	user_msg = cmd.msg;
+
+	c = i2o_find_controller(cmd.iop);
 	if(!c)
                 return -ENXIO;
 
-	memset(&msg, 0, MSG_FRAME_SIZE*4);
+	memset(msg, 0, MSG_FRAME_SIZE*4);
 	if(get_user(size, &user_msg[0]))
 		return -EFAULT;
 	size = size>>16;
@@ -949,7 +954,7 @@ static int ioctl_passthru(unsigned long 
 		int sg_size;
 
 		// re-acquire the original message to handle correctly the sg copy operation
-		memset(&msg, 0, MSG_FRAME_SIZE*4);
+		memset(msg, 0, MSG_FRAME_SIZE*4);
 		// get user msg size in u32s
 		if (get_user(size, &user_msg[0])) {
 			rcode = -EFAULT;


