Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262578AbUJ0TN5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262578AbUJ0TN5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 15:13:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262641AbUJ0TKm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 15:10:42 -0400
Received: from mx1.redhat.com ([66.187.233.31]:12941 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262660AbUJ0TF1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 15:05:27 -0400
Date: Wed, 27 Oct 2004 15:05:59 -0400 (EDT)
From: Jason Baron <jbaron@redhat.com>
X-X-Sender: jbaron@dhcp83-105.boston.redhat.com
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix altsysrq deadlock
In-Reply-To: <20041026194043.5f39e140.akpm@osdl.org>
Message-ID: <Pine.LNX.4.44.0410271453340.28907-100000@dhcp83-105.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 26 Oct 2004, Andrew Morton wrote:

> Jason Baron <jbaron@redhat.com> wrote:
> >
> > 
> > This patch fixes a deadlock in the handle_sysrq function.
> > ...
> >> -	__sysrq_lock_table();
> > +	if(!__sysrq_trylock_table()) {
> > +		if(in_interrupt())
> > +			return;
> > +		else
> > +			__sysrq_lock_table();
> > +	}
> > +
> 
> This is only a partial solution - __sysrq_trylock_table() is exported to
> modules which do who know what with it and they don't know how to handle
> locking failures - they'll just go ahead and do a spin_unlock() of an
> unlocked lock and mayhem will ensue.

__sysrq_trylock_table was added by the proposed patch and not not exported 
to modules. 

> 
> What we need to do is to move all those inlined functions out of sysrq.h,
> into sysrq.c then withdraw all those exported-to-modules helper functions
> then remove __sysrq_trylock_table() altogether and then use
> spin_lock_irqsave() in the appropriate places.
> 

I was reluctant to use the spin_lock_irqsave() approach b/c alt-sysrq
operations have high latency in my experience, so I didn't want to disable
interrupts across them. In fact, I implemented the above suggestion (patch
below) and while running 'echo t > /proc/sysrq-trigger' in a tight loop I
did in fact get irq timeouts:
 
Oct 27 14:48:55 foo kernel: ide-cd: cmd 0x3 timed out
Oct 27 14:48:55 foo kernel: hda: irq timeout: status=0xd0 { Busy }
Oct 27 14:48:55 foo kernel: hda: irq timeout: error=0xd0LastFailedSense 
0x0d
Oct 27 14:48:55 foo kernel: hda: ATAPI reset complete

However, I would consider this scenario a bit contrived. 

thanks,

-Jason


--- linux-2.6.9/drivers/char/sysrq.c	Wed Oct 27 12:14:08 2004
+++ linux-2.6.9-sysrq/drivers/char/sysrq.c	Wed Oct 27 12:25:20 2004
@@ -295,14 +295,6 @@ static int sysrq_key_table_key2index(int
 }
 
 /*
- * table lock and unlocking functions, exposed to modules
- */
-
-void __sysrq_lock_table (void) { spin_lock(&sysrq_key_table_lock); }
-
-void __sysrq_unlock_table (void) { spin_unlock(&sysrq_key_table_lock); }
-
-/*
  * get and put functions for the table, exposed to modules.
  */
 
@@ -334,8 +326,9 @@ void __handle_sysrq(int key, struct pt_r
 	struct sysrq_key_op *op_p;
 	int orig_log_level;
 	int i, j;
+	unsigned long flags;
 
-	__sysrq_lock_table();
+	spin_lock_irqsave(&sysrq_key_table_lock, flags);
 	orig_log_level = console_loglevel;
 	console_loglevel = 7;
 	printk(KERN_INFO "SysRq : ");
@@ -357,7 +350,7 @@ void __handle_sysrq(int key, struct pt_r
 		printk ("\n");
 		console_loglevel = orig_log_level;
 	}
-	__sysrq_unlock_table();
+	spin_unlock_irqrestore(&sysrq_key_table_lock, flags);
 }
 
 /*
@@ -372,8 +365,34 @@ void handle_sysrq(int key, struct pt_reg
 	__handle_sysrq(key, pt_regs, tty);
 }
 
+int __sysrq_swap_key_ops(int key, struct sysrq_key_op *insert_op_p,
+                                struct sysrq_key_op *remove_op_p) {
+
+	int retval;
+	unsigned long flags;
+
+	spin_lock_irqsave(&sysrq_key_table_lock, flags);
+	if (__sysrq_get_key_op(key) == remove_op_p) {
+		__sysrq_put_key_op(key, insert_op_p);
+		retval = 0;
+	} else {
+		retval = -1;
+	}
+	spin_unlock_irqrestore(&sysrq_key_table_lock, flags);
+
+	return retval;
+}
+
+int register_sysrq_key(int key, struct sysrq_key_op *op_p)
+{
+	return __sysrq_swap_key_ops(key, op_p, NULL);
+}
+
+int unregister_sysrq_key(int key, struct sysrq_key_op *op_p)
+{
+	return __sysrq_swap_key_ops(key, NULL, op_p);
+}
+
 EXPORT_SYMBOL(handle_sysrq);
-EXPORT_SYMBOL(__sysrq_lock_table);
-EXPORT_SYMBOL(__sysrq_unlock_table);
-EXPORT_SYMBOL(__sysrq_get_key_op);
-EXPORT_SYMBOL(__sysrq_put_key_op);
+EXPORT_SYMBOL(register_sysrq_key);
+EXPORT_SYMBOL(unregister_sysrq_key);
--- linux-2.6.9/include/linux/sysrq.h	Mon Oct 18 17:53:06 2004
+++ linux-2.6.9-sysrq/include/linux/sysrq.h	Wed Oct 27 12:20:58 2004
@@ -31,49 +31,8 @@ struct sysrq_key_op {
 
 void handle_sysrq(int, struct pt_regs *, struct tty_struct *);
 void __handle_sysrq(int, struct pt_regs *, struct tty_struct *);
-
-/*
- * Sysrq registration manipulation functions
- */
-
-void __sysrq_lock_table (void);
-void __sysrq_unlock_table (void);
-struct sysrq_key_op *__sysrq_get_key_op (int key);
-void __sysrq_put_key_op (int key, struct sysrq_key_op *op_p);
-
-extern __inline__ int
-__sysrq_swap_key_ops_nolock(int key, struct sysrq_key_op *insert_op_p,
-				struct sysrq_key_op *remove_op_p)
-{
-	int retval;
-	if (__sysrq_get_key_op(key) == remove_op_p) {
-		__sysrq_put_key_op(key, insert_op_p);
-		retval = 0;
-	} else {
-                retval = -1;
-	}
-	return retval;
-}
-
-extern __inline__ int
-__sysrq_swap_key_ops(int key, struct sysrq_key_op *insert_op_p,
-				struct sysrq_key_op *remove_op_p) {
-	int retval;
-	__sysrq_lock_table();
-	retval = __sysrq_swap_key_ops_nolock(key, insert_op_p, remove_op_p);
-	__sysrq_unlock_table();
-	return retval;
-}
-	
-static inline int register_sysrq_key(int key, struct sysrq_key_op *op_p)
-{
-	return __sysrq_swap_key_ops(key, op_p, NULL);
-}
-
-static inline int unregister_sysrq_key(int key, struct sysrq_key_op *op_p)
-{
-	return __sysrq_swap_key_ops(key, NULL, op_p);
-}
+int register_sysrq_key(int, struct sysrq_key_op *);
+int unregister_sysrq_key(int, struct sysrq_key_op *);
 
 #else
 

