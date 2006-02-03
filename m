Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030223AbWBCW0q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030223AbWBCW0q (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 17:26:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030235AbWBCW0q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 17:26:46 -0500
Received: from e32.co.us.ibm.com ([32.97.110.150]:28820 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030223AbWBCW0p
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 17:26:45 -0500
Subject: [PATCH] ibmasm driver: don't use previously freed pointer
From: Max Asbock <masbock@us.ibm.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1139005598.7521.68.camel@w-amax>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Fri, 03 Feb 2006 14:26:38 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ibmasm driver:
Fix the command_put() function which uses a pointer for a spinlock that
can be freed before dereferencing it.

Signed-off-by: Max Asbock masbock@us.ibm.com

---

diff -burpN linux-2.6.16-rc1/drivers/misc/ibmasm/ibmasm.h linux-2.6.16-rc1.ibmasm/drivers/misc/ibmasm/ibmasm.h
--- linux-2.6.16-rc1/drivers/misc/ibmasm/ibmasm.h	2006-02-01 11:50:01.000000000 -0800
+++ linux-2.6.16-rc1.ibmasm/drivers/misc/ibmasm/ibmasm.h	2006-02-03 13:57:42.000000000 -0800
@@ -101,10 +101,11 @@ struct command {
 static inline void command_put(struct command *cmd)
 {
 	unsigned long flags;
+	spinlock_t *lock = cmd->lock;
 
-	spin_lock_irqsave(cmd->lock, flags);
+	spin_lock_irqsave(lock, flags);
         kobject_put(&cmd->kobj);
-	spin_unlock_irqrestore(cmd->lock, flags);
+	spin_unlock_irqrestore(lock, flags);
 }
 
 static inline void command_get(struct command *cmd)


