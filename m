Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261341AbUJZR0u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261341AbUJZR0u (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 13:26:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261342AbUJZR0u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 13:26:50 -0400
Received: from mx1.redhat.com ([66.187.233.31]:41921 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261341AbUJZR0h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 13:26:37 -0400
Date: Tue, 26 Oct 2004 13:27:11 -0400 (EDT)
From: Jason Baron <jbaron@redhat.com>
X-X-Sender: jbaron@dhcp83-105.boston.redhat.com
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] fix altsysrq deadlock
Message-ID: <Pine.LNX.4.44.0410261325120.12088-100000@dhcp83-105.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


hi,

This patch fixes a deadlock in the handle_sysrq function. The handle_sysrq
function is called in both process as well as interrupt context.  The
__sysrq_lock_table() function does not disable interrupts when taking the
sysrq_key_table_lock. Thus, it is fairly easy to to do a keyboard
sys-altrq-foo, while a 'echo foo > /proc/sysrq-trigger' is running and
cause a deadlock. It can be annoying to have the machine lockup exactly
when you are trying to debug something else.

Usually a spin_lock_irqsave would be used. However, I don't think that is
appropriate here because some of the altsysrq functions can take a while 
to run.

Thus, the patch below simply uses a spin_trylock and on failure does not
spin if we are in interrupt context. A trylock in all cases would be ok
too, but this patch preserves existing behavior as much as possible.  An
altsyrq that produces no output might seem troublesome, but it is
primarily used as a debugging tool, so trying it again seems reasonable.

Please apply.

-Jason 

--- linux/drivers/char/sysrq.c.orig	Tue Oct 26 12:49:59 2004
+++ linux/drivers/char/sysrq.c	Tue Oct 26 12:54:51 2004
@@ -291,6 +291,8 @@ void __sysrq_lock_table (void) { spin_lo
 
 void __sysrq_unlock_table (void) { spin_unlock(&sysrq_key_table_lock); }
 
+#define __sysrq_trylock_table() spin_trylock(&sysrq_key_table_lock)
+
 /*
  * get and put functions for the table, exposed to modules.
  */
@@ -324,7 +326,13 @@ void __handle_sysrq(int key, struct pt_r
 	int orig_log_level;
 	int i, j;
 
-	__sysrq_lock_table();
+	if(!__sysrq_trylock_table()) {
+		if(in_interrupt())
+			return;
+		else
+			__sysrq_lock_table();
+	}
+
 	orig_log_level = console_loglevel;
 	console_loglevel = 7;
 	printk(KERN_INFO "SysRq : ");


