Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261310AbTC3Wv7>; Sun, 30 Mar 2003 17:51:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261312AbTC3Wv7>; Sun, 30 Mar 2003 17:51:59 -0500
Received: from dp.samba.org ([66.70.73.150]:44990 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S261310AbTC3Wvv>;
	Sun, 30 Mar 2003 17:51:51 -0500
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16007.30203.540218.423818@nanango.paulus.ozlabs.org>
Date: Mon, 31 Mar 2003 08:55:55 +1000 (EST)
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] update adb driver
X-Mailer: VM 6.75 under Emacs 20.7.2
Reply-To: paulus@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch updates the ADB (Apple desktop bus) driver used on macs and
powermacs.  The main change, from Ben Herrenschmidt, is that handlers
are called without a lock held now.  It also adds a way for userland
to obtain some information about individual ADB devices from the
driver.

Please apply.

Paul.

diff -urN linux-2.5/drivers/macintosh/adb.c linuxppc-2.5/drivers/macintosh/adb.c
--- linux-2.5/drivers/macintosh/adb.c	2003-03-21 19:48:22.000000000 +1100
+++ linuxppc-2.5/drivers/macintosh/adb.c	2003-03-21 20:06:37.000000000 +1100
@@ -102,6 +102,7 @@
 	void (*handler)(unsigned char *, int, struct pt_regs *, int);
 	int original_address;
 	int handler_id;
+	int busy;
 } adb_handler[16];
 
 /*
@@ -134,7 +135,7 @@
 {
 	if (current->pid && adb_probe_task_pid &&
 	  adb_probe_task_pid == current->pid) {
-		current->state = TASK_UNINTERRUPTIBLE;
+		set_task_state(current, TASK_UNINTERRUPTIBLE);
 		schedule_timeout(1 + ms * HZ / 1000);
 	} else
 		mdelay(ms);
@@ -249,7 +250,7 @@
 	strcpy(current->comm, "kadbprobe");
 
 	sigfillset(&blocked);
-	sigprocmask(SIG_BLOCK, &blocked, NULL);	
+	sigprocmask(SIG_BLOCK, &blocked, NULL);
 	flush_signals(current);
 
 	printk(KERN_INFO "adb: starting probe task...\n");
@@ -550,12 +551,17 @@
 	down(&adb_handler_sem);
 	write_lock_irq(&adb_handler_lock);
 	if (adb_handler[index].handler) {
+		while(adb_handler[index].busy) {
+			write_unlock_irq(&adb_handler_lock);
+			yield();
+			write_lock_irq(&adb_handler_lock);
+		}
 		ret = 0;
 		adb_handler[index].handler = 0;
 	}
 	write_unlock_irq(&adb_handler_lock);
 	up(&adb_handler_sem);
-	return 0;
+	return ret;
 }
 
 void
@@ -563,6 +569,8 @@
 {
 	int i, id;
 	static int dump_adb_input = 0;
+	unsigned long flags;
+	
 	void (*handler)(unsigned char *, int, struct pt_regs *, int);
 
 	/* We skip keystrokes and mouse moves when the sleep process
@@ -578,11 +586,17 @@
 			printk(" %x", buf[i]);
 		printk(", id = %d\n", id);
 	}
-	read_lock(&adb_handler_lock);
+	write_lock_irqsave(&adb_handler_lock, flags);
 	handler = adb_handler[id].handler;
-	if (handler != 0)
+	if (handler != NULL)
+		adb_handler[id].busy = 1;
+	write_unlock_irqrestore(&adb_handler_lock, flags);
+	if (handler != NULL) {
 		(*handler)(buf, nb, regs, autopoll);
-	read_unlock(&adb_handler_lock);
+		wmb();
+		adb_handler[id].busy = 0;
+	}
+		
 }
 
 /* Try to change handler to new_id. Will return 1 if successful. */
@@ -671,6 +685,29 @@
 	spin_unlock_irqrestore(&state->lock, flags);
 }
 
+static int
+do_adb_query(struct adb_request *req)
+{
+	int	ret = -EINVAL;
+
+	switch(req->data[1])
+	{
+	case ADB_QUERY_GETDEVINFO:
+		if (req->nbytes < 3)
+			break;
+		down(&adb_handler_sem);
+		req->reply[0] = adb_handler[req->data[2]].original_address;
+		req->reply[1] = adb_handler[req->data[2]].handler_id;
+		up(&adb_handler_sem);
+		req->complete = 1;
+		req->reply_len = 2;
+		adb_write_done(req);
+		ret = 0;
+		break;
+	}
+	return ret;
+}
+
 static int adb_open(struct inode *inode, struct file *file)
 {
 	struct adbdev_state *state;
@@ -806,24 +843,32 @@
 
 	/* If a probe is in progress or we are sleeping, wait for it to complete */
 	down(&adb_probe_mutex);
-	up(&adb_probe_mutex);
 
+	/* Queries are special requests sent to the ADB driver itself */
+	if (req->data[0] == ADB_QUERY) {
+		if (count > 1)
+			ret = do_adb_query(req);
+		else
+			ret = -EINVAL;
+		up(&adb_probe_mutex);
+	}
 	/* Special case for ADB_BUSRESET request, all others are sent to
 	   the controller */
-	if ((req->data[0] == ADB_PACKET)&&(count > 1)
+	else if ((req->data[0] == ADB_PACKET)&&(count > 1)
 		&&(req->data[1] == ADB_BUSRESET)) {
 		ret = do_adb_reset_bus();
+		up(&adb_probe_mutex);
 		atomic_dec(&state->n_pending);
 		if (ret == 0)
 			ret = count;
 		goto out;
 	} else {	
 		req->reply_expected = ((req->data[1] & 0xc) == 0xc);
-
 		if (adb_controller && adb_controller->send_request)
 			ret = adb_controller->send_request(req, 0);
 		else
 			ret = -ENXIO;
+		up(&adb_probe_mutex);
 	}
 
 	if (ret != 0) {
diff -urN linux-2.5/drivers/macintosh/macio-adb.c linuxppc-2.5/drivers/macintosh/macio-adb.c
--- linux-2.5/drivers/macintosh/macio-adb.c	2002-10-13 15:00:41.000000000 +1000
+++ linuxppc-2.5/drivers/macintosh/macio-adb.c	2002-11-22 23:15:30.000000000 +1100
@@ -8,6 +8,7 @@
 #include <linux/delay.h>
 #include <linux/sched.h>
 #include <linux/spinlock.h>
+#include <linux/interrupt.h>
 #include <asm/prom.h>
 #include <linux/adb.h>
 #include <asm/io.h>
