Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161089AbVKYB5w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161089AbVKYB5w (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Nov 2005 20:57:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161090AbVKYB5w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Nov 2005 20:57:52 -0500
Received: from mail.renesas.com ([202.234.163.13]:3719 "EHLO
	mail03.idc.renesas.com") by vger.kernel.org with ESMTP
	id S1161089AbVKYB5v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Nov 2005 20:57:51 -0500
Date: Fri, 25 Nov 2005 10:57:46 +0900 (JST)
Message-Id: <20051125.105746.304103491.takata.hirokazu@renesas.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, takata@linux-m32r.org,
       Yamamoto.Hitoshi@ap.MitsubishiElectric.co.jp
Subject: [PATCH 2.6.15-rc2] m32r: Fix sys_tas() syscall
From: Hirokazu Takata <takata@linux-m32r.org>
X-Mailer: Mew version 3.3 on XEmacs 21.4.17 (Jumbo Shrimp)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This patch fixes a deadlock problem of the m32r SMP kernel.

In the m32r kernel, sys_tas() system call is provided as a test-and-set
function for userspace, for backward compatibility.  

In some multi-threading application program, deadlocks were rarely caused
at sys_tas() funcion.
Such a deadlock was caused due to a collision of __pthread_lock() and
__pthread_unlock() operations.

The "tas" syscall is repeatedly called by pthread_mutex_lock() to get
a lock, while a lock variable's value is not 0. 
On the other hand, pthead_mutex_unlock() sets the lock variable to 0
for unlocking.

In the previous implementation of sys_tas() routine, there was a possibility
that a unlock operation was ignored in the following case:

- Assume a lock variable (*addr) was equal to 1 before sys_tas() execution.
- __pthread_unlock() operation is executed by the other processor
  and the lock variable (*addr) is set to 0, between a read operation
  ("oldval = *addr;") and the following write operation ("*addr = 1;")
  during a execution of sys_tas().

In this case, the following write operation ("*addr = 1;") overwrites
the __pthread_unlock() result, and sys_tas() fails to get a lock in the
next turn and after that.

According to the attatched patch, sys_tas() returns 0 value in the next turn
and deadlocks never happen.

Signed-off-by: Hitoshi Yamamoto <Yamamoto.Hitoshi@ap.MitsubishiElectric.co.jp>
Signed-off-by: Hirokazu Takata <takata@linux-m32r.org>
---

 arch/m32r/kernel/sys_m32r.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

Index: linux-2.6.14-mm1/arch/m32r/kernel/sys_m32r.c
===================================================================
--- linux-2.6.14-mm1.orig/arch/m32r/kernel/sys_m32r.c	2005-11-07 19:31:23.404878304 +0900
+++ linux-2.6.14-mm1/arch/m32r/kernel/sys_m32r.c	2005-11-07 19:33:04.991434800 +0900
@@ -41,7 +41,8 @@ asmlinkage int sys_tas(int *addr)
 		return -EFAULT;
 	local_irq_save(flags);
 	oldval = *addr;
-	*addr = 1;
+	if (!oldval)
+		*addr = 1;
 	local_irq_restore(flags);
 	return oldval;
 }
@@ -59,7 +60,8 @@ asmlinkage int sys_tas(int *addr)
 
 	_raw_spin_lock(&tas_lock);
 	oldval = *addr;
-	*addr = 1;
+	if (!oldval)
+		*addr = 1;
 	_raw_spin_unlock(&tas_lock);
 
 	return oldval;

--
Hirokazu Takata <takata@linux-m32r.org>
Linux/M32R Project:  http://www.linux-m32r.org/
