Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751178AbWJHN7V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751178AbWJHN7V (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Oct 2006 09:59:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751179AbWJHN7U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Oct 2006 09:59:20 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:133 "EHLO ZenIV.linux.org.uk")
	by vger.kernel.org with ESMTP id S1751178AbWJHN7U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Oct 2006 09:59:20 -0400
Date: Sun, 8 Oct 2006 14:59:19 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] missed ia64 pt_regs fixes
Message-ID: <20061008135919.GS29920@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/ia64/hp/sim/simeth.c      |    4 ++--
 arch/ia64/hp/sim/simserial.c   |   10 +++++-----
 arch/ia64/sn/kernel/xpc_main.c |    7 ++-----
 include/asm-ia64/sn/xpc.h      |    2 +-
 4 files changed, 10 insertions(+), 13 deletions(-)

diff --git a/arch/ia64/hp/sim/simeth.c b/arch/ia64/hp/sim/simeth.c
index e1a1b11..be769ef 100644
--- a/arch/ia64/hp/sim/simeth.c
+++ b/arch/ia64/hp/sim/simeth.c
@@ -54,7 +54,7 @@ static int simeth_close(struct net_devic
 static int simeth_tx(struct sk_buff *skb, struct net_device *dev);
 static int simeth_rx(struct net_device *dev);
 static struct net_device_stats *simeth_get_stats(struct net_device *dev);
-static irqreturn_t simeth_interrupt(int irq, void *dev_id, struct pt_regs * regs);
+static irqreturn_t simeth_interrupt(int irq, void *dev_id);
 static void set_multicast_list(struct net_device *dev);
 static int simeth_device_event(struct notifier_block *this,unsigned long event, void *ptr);
 
@@ -497,7 +497,7 @@ #endif
  * Interrupt handler (Yes, we can do it too !!!)
  */
 static irqreturn_t
-simeth_interrupt(int irq, void *dev_id, struct pt_regs * regs)
+simeth_interrupt(int irq, void *dev_id)
 {
 	struct net_device *dev = dev_id;
 
diff --git a/arch/ia64/hp/sim/simserial.c b/arch/ia64/hp/sim/simserial.c
index 246eb3d..77819ac 100644
--- a/arch/ia64/hp/sim/simserial.c
+++ b/arch/ia64/hp/sim/simserial.c
@@ -130,7 +130,7 @@ #ifdef SIMSERIAL_DEBUG
 #endif
 }
 
-static  void receive_chars(struct tty_struct *tty, struct pt_regs *regs)
+static  void receive_chars(struct tty_struct *tty)
 {
 	unsigned char ch;
 	static unsigned char seen_esc = 0;
@@ -152,7 +152,7 @@ #ifdef CONFIG_MAGIC_SYSRQ
 						ch = ia64_ssc(0, 0, 0, 0,
 							      SSC_GETCHAR);
 					while (!ch);
-					handle_sysrq(ch, regs, NULL);
+					handle_sysrq(ch, NULL);
 				}
 #endif
 				seen_esc = 0;
@@ -170,7 +170,7 @@ #endif
 /*
  * This is the serial driver's interrupt routine for a single port
  */
-static irqreturn_t rs_interrupt_single(int irq, void *dev_id, struct pt_regs * regs)
+static irqreturn_t rs_interrupt_single(int irq, void *dev_id)
 {
 	struct async_struct * info;
 
@@ -187,7 +187,7 @@ static irqreturn_t rs_interrupt_single(i
 	 * pretty simple in our case, because we only get interrupts
 	 * on inbound traffic
 	 */
-	receive_chars(info->tty, regs);
+	receive_chars(info->tty);
 	return IRQ_HANDLED;
 }
 
@@ -714,7 +714,7 @@ startup(struct async_struct *info)
 {
 	unsigned long flags;
 	int	retval=0;
-	irqreturn_t (*handler)(int, void *, struct pt_regs *);
+	irqreturn_t (*handler)(int, void *);
 	struct serial_state *state= info->state;
 	unsigned long page;
 
diff --git a/arch/ia64/sn/kernel/xpc_main.c b/arch/ia64/sn/kernel/xpc_main.c
index 4d026f9..fa96dfc 100644
--- a/arch/ia64/sn/kernel/xpc_main.c
+++ b/arch/ia64/sn/kernel/xpc_main.c
@@ -222,7 +222,7 @@ xpc_timeout_partition_disengage_request(
  * Notify the heartbeat check thread that an IRQ has been received.
  */
 static irqreturn_t
-xpc_act_IRQ_handler(int irq, void *dev_id, struct pt_regs *regs)
+xpc_act_IRQ_handler(int irq, void *dev_id)
 {
 	atomic_inc(&xpc_act_IRQ_rcvd);
 	wake_up_interruptible(&xpc_act_IRQ_wq);
@@ -607,12 +607,9 @@ xpc_activate_partition(struct xpc_partit
  *	irq - Interrupt ReQuest number. NOT USED.
  *
  *	dev_id - partid of IPI's potential sender.
- *
- *	regs - processor's context before the processor entered
- *	       interrupt code. NOT USED.
  */
 irqreturn_t
-xpc_notify_IRQ_handler(int irq, void *dev_id, struct pt_regs *regs)
+xpc_notify_IRQ_handler(int irq, void *dev_id)
 {
 	partid_t partid = (partid_t) (u64) dev_id;
 	struct xpc_partition *part = &xpc_partitions[partid];
diff --git a/include/asm-ia64/sn/xpc.h b/include/asm-ia64/sn/xpc.h
index 35e1386..1d45e15 100644
--- a/include/asm-ia64/sn/xpc.h
+++ b/include/asm-ia64/sn/xpc.h
@@ -669,7 +669,7 @@ extern struct device *xpc_part;
 extern struct device *xpc_chan;
 extern int xpc_disengage_request_timelimit;
 extern int xpc_disengage_request_timedout;
-extern irqreturn_t xpc_notify_IRQ_handler(int, void *, struct pt_regs *);
+extern irqreturn_t xpc_notify_IRQ_handler(int, void *);
 extern void xpc_dropped_IPI_check(struct xpc_partition *);
 extern void xpc_activate_partition(struct xpc_partition *);
 extern void xpc_activate_kthreads(struct xpc_channel *, int);
-- 
1.4.2.GIT

