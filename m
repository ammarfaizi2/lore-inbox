Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964772AbWAZQ2u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964772AbWAZQ2u (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 11:28:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964776AbWAZQ2u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 11:28:50 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:32906 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S964772AbWAZQ2u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 11:28:50 -0500
Date: Thu, 26 Jan 2006 17:29:22 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Arjan van de Ven <arjan@infradead.org>
Subject: [patch] drivers/block/floppy.c: dont free_irq() from irq context
Message-ID: <20060126162922.GA5135@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.2
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.2 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.6 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

free_irq() should not be executed from softirq context.

Found by the lock validator:

  ============================
  [ BUG: illegal lock usage! ]
  ----------------------------
  illegal {enabled-softirqs} -> {used-in-softirq} usage.
  rcu_torture_rea/265 [HC0[0]:SC1[2]:HE1:SE0] takes:
   {proc_subdir_lock} [<c0198163>] remove_proc_entry+0x33/0x1f0
  {enabled-softirqs} state was registered at:
   [<c0122c09>] irq_exit+0x39/0x50
  hardirqs last enabled at: [<c04da025>] _spin_unlock_irqrestore+0x25/0x30
  softirqs last enabled at: [<c0122c09>] irq_exit+0x39/0x50
  
  other info that might help us debug this:
  locks held by rcu_torture_rea/265:
  
  stack backtrace:
   [<c010432d>] show_trace+0xd/0x10
   [<c0104347>] dump_stack+0x17/0x20
   [<c01380f4>] print_usage_bug+0x1c4/0x1e0
   [<c0138971>] mark_lock+0x221/0x2c0
   [<c0138cc2>] debug_lock_chain+0x2b2/0xd40
   [<c013978d>] debug_lock_chain_spin+0x3d/0x60
   [<c0266a1d>] _raw_spin_lock+0x2d/0x90
   [<c04d9e88>] _spin_lock+0x8/0x10
   [<c0198163>] remove_proc_entry+0x33/0x1f0
   [<c0142ca9>] unregister_handler_proc+0x19/0x20
   [<c014246b>] free_irq+0x7b/0xe0
   [<c02f3632>] floppy_release_irq_and_dma+0x1b2/0x210
   [<c02f1b27>] set_dor+0xc7/0x1b0
   [<c02f4ba1>] motor_off_callback+0x21/0x30
   [<c0127605>] run_timer_softirq+0xf5/0x1f0
   [<c0122f57>] __do_softirq+0x97/0x130
   [<c0105519>] do_softirq+0x69/0x100
   =======================

the fix is to push fd_free_irq() into keventd. The code validates fine 
with this patch applied.

Signed-off-by: Ingo Molnar <mingo@elte.hu>

----

Index: linux/drivers/block/floppy.c
===================================================================
--- linux.orig/drivers/block/floppy.c
+++ linux/drivers/block/floppy.c
@@ -251,6 +251,18 @@ static int irqdma_allocated;
 #include <linux/cdrom.h>	/* for the compatibility eject ioctl */
 #include <linux/completion.h>
 
+/*
+ * Interrupt freeing also means /proc VFS work - dont do it
+ * from interrupt context. We push this work into keventd:
+ */
+static void fd_free_irq_fn(void *data)
+{
+	fd_free_irq();
+}
+
+static DECLARE_WORK(fd_free_irq_work, fd_free_irq_fn, NULL);
+
+
 static struct request *current_req;
 static struct request_queue *floppy_queue;
 static void do_fd_request(request_queue_t * q);
@@ -4434,6 +4446,13 @@ static int floppy_grab_irq_and_dma(void)
 		return 0;
 	}
 	spin_unlock_irqrestore(&floppy_usage_lock, flags);
+
+	/*
+	 * We might have scheduled a free_irq(), wait it to
+	 * drain first:
+	 */
+	flush_scheduled_work();
+
 	if (fd_request_irq()) {
 		DPRINT("Unable to grab IRQ%d for the floppy driver\n",
 		       FLOPPY_IRQ);
@@ -4523,7 +4542,7 @@ static void floppy_release_irq_and_dma(v
 	if (irqdma_allocated) {
 		fd_disable_dma();
 		fd_free_dma();
-		fd_free_irq();
+		schedule_work(&fd_free_irq_work);
 		irqdma_allocated = 0;
 	}
 	set_dor(0, ~0, 8);
