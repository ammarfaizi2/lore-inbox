Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262257AbTEUTzK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 May 2003 15:55:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262258AbTEUTzJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 May 2003 15:55:09 -0400
Received: from smtp3.wanadoo.fr ([193.252.22.25]:17395 "EHLO
	mwinf0603.wanadoo.fr") by vger.kernel.org with ESMTP
	id S262257AbTEUTzI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 May 2003 15:55:08 -0400
From: Duncan Sands <baldrick@wanadoo.fr>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] spin_lock_irq debugging
Date: Wed, 21 May 2003 22:08:09 +0200
User-Agent: KMail/1.5.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200305212208.09376.baldrick@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Of course the real problem is the corresponding spin_unlock_irq
enabling local irqs when they should have been left disabled, but
this is easier to check for.  Your logs will fill up.

diff -Nru a/include/linux/spinlock.h b/include/linux/spinlock.h
--- a/include/linux/spinlock.h	Wed May 21 22:04:29 2003
+++ b/include/linux/spinlock.h	Wed May 21 22:04:29 2003
@@ -261,6 +261,10 @@
 
 #define spin_lock_irq(lock) \
 do { \
+	if (unlikely(irqs_disabled())) { \
+		printk(KERN_ERR "bad: spin_lock_irq with irqs disabled!\n"); \
+		dump_stack(); \
+	} \
 	local_irq_disable(); \
 	preempt_disable(); \
 	_raw_spin_lock(lock); \

