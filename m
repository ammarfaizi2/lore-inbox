Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129813AbRBMQpM>; Tue, 13 Feb 2001 11:45:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130487AbRBMQpD>; Tue, 13 Feb 2001 11:45:03 -0500
Received: from host217-32-132-155.hg.mdip.bt.net ([217.32.132.155]:32773 "EHLO
	penguin.homenet") by vger.kernel.org with ESMTP id <S129813AbRBMQop>;
	Tue, 13 Feb 2001 11:44:45 -0500
Date: Tue, 13 Feb 2001 16:47:20 +0000 (GMT)
From: Tigran Aivazian <tigran@veritas.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: linux-kernel@vger.kernel.org
Subject: [patch-2.4.1-ac10] unsetting TASK_RUNNING
Message-ID: <Pine.LNX.4.21.0102131640470.1265-100000@penguin.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,

The only case in schedule_timeout() which does not call schedule() does
set tsk->state = TASK_RUNNING explicitly before returning. Therefore, any
code which unconditionally calls schedule_timeout() (and, of course
schedule()) does not need to set TASK_RUNNING afterwards.

I have seen some people setting this TASK_RUNNING incorrectly, based on a
mere observation that "official Linux kernel code does so" -- so the patch
below is not just an optimization but serves for education (i.e. to stop
people copying unnecessary code).

Regards,
Tigran

PS. Btw, I still haven't lost a single character on this laptop (still
running 2.2.19-pre9)

diff -urN -X dontdiff linux/drivers/char/cyclades.c trun/drivers/char/cyclades.c
--- linux/drivers/char/cyclades.c	Wed Nov 15 08:41:03 2000
+++ trun/drivers/char/cyclades.c	Tue Feb 13 15:39:38 2001
@@ -2798,7 +2798,6 @@
     /* Run one more char cycle */
     current->state = TASK_INTERRUPTIBLE;
     schedule_timeout(char_time * 5);
-    current->state = TASK_RUNNING;
 #ifdef CY_DEBUG_WAIT_UNTIL_SENT
     printk("Clean (jiff=%lu)...done\n", jiffies);
 #endif
diff -urN -X dontdiff linux/drivers/char/istallion.c trun/drivers/char/istallion.c
--- linux/drivers/char/istallion.c	Tue Feb 13 15:23:03 2001
+++ trun/drivers/char/istallion.c	Tue Feb 13 15:40:20 2001
@@ -1533,7 +1533,6 @@
 	if (len > 0) {
 		current->state = TASK_INTERRUPTIBLE;
 		schedule_timeout(len);
-		current->state = TASK_RUNNING;
 	}
 }
 
diff -urN -X dontdiff linux/drivers/net/wan/cosa.c trun/drivers/net/wan/cosa.c
--- linux/drivers/net/wan/cosa.c	Tue Feb 13 15:23:06 2001
+++ trun/drivers/net/wan/cosa.c	Tue Feb 13 15:35:35 2001
@@ -523,7 +523,6 @@
 		current->state = TASK_INTERRUPTIBLE;
 		cosa_putstatus(cosa, SR_TX_INT_ENA);
 		schedule_timeout(30);
-		current->state = TASK_RUNNING;
 		irq = probe_irq_off(irqs);
 		/* Disable all IRQs from the card */
 		cosa_putstatus(cosa, 0);
@@ -822,7 +821,6 @@
 		if (signal_pending(current) && chan->rx_status == 0) {
 			chan->rx_status = 1;
 			remove_wait_queue(&chan->rxwaitq, &wait);
-			current->state = TASK_RUNNING;
 			spin_unlock_irqrestore(&cosa->lock, flags);
 			up(&chan->rsem);
 			return -ERESTARTSYS;
@@ -907,7 +905,6 @@
 		if (signal_pending(current) && chan->tx_status == 0) {
 			chan->tx_status = 1;
 			remove_wait_queue(&chan->txwaitq, &wait);
-			current->state = TASK_RUNNING;
 			chan->tx_status = 1;
 			spin_unlock_irqrestore(&cosa->lock, flags);
 			return -ERESTARTSYS;
@@ -1542,7 +1539,6 @@
 #ifdef MODULE
 	current->state = TASK_INTERRUPTIBLE;
 	schedule_timeout(HZ/2);
-	current->state = TASK_RUNNING;
 #else
 	udelay(5*100000);
 #endif
diff -urN -X dontdiff linux/drivers/scsi/scsi.c trun/drivers/scsi/scsi.c
--- linux/drivers/scsi/scsi.c	Tue Feb 13 15:23:08 2001
+++ trun/drivers/scsi/scsi.c	Tue Feb 13 15:35:35 2001
@@ -441,11 +441,6 @@
 
                         remove_wait_queue(&device->scpnt_wait, &wait);
                         /*
-                         * FIXME - Isn't this redundant??  Someone
-                         * else will have forced the state back to running.
-                         */
-                        set_current_state(TASK_RUNNING);
-                        /*
                          * In the event that a signal has arrived that we need
                          * to consider, then simply return NULL.  Everyone
                          * that calls us should be prepared for this
diff -urN -X dontdiff linux/fs/devfs/base.c trun/fs/devfs/base.c
--- linux/fs/devfs/base.c	Tue Feb 13 15:23:09 2001
+++ trun/fs/devfs/base.c	Tue Feb 13 15:35:35 2001
@@ -3177,7 +3177,6 @@
 	if ( signal_pending (current) )
 	{
 	    remove_wait_queue (&fs_info->devfsd_wait_queue, &wait);
-	    current->state = TASK_RUNNING;
 	    return -EINTR;
 	}
 	set_current_state(TASK_INTERRUPTIBLE);
diff -urN -X dontdiff linux/fs/locks.c trun/fs/locks.c
--- linux/fs/locks.c	Tue Feb 13 15:23:10 2001
+++ trun/fs/locks.c	Tue Feb 13 15:35:35 2001
@@ -590,7 +590,6 @@
 	if (signal_pending(current))
 		result = -ERESTARTSYS;
 	remove_wait_queue(fl_wait, &wait);
-	current->state = TASK_RUNNING;
 	return result;
 }
 
diff -urN -X dontdiff linux/fs/ncpfs/sock.c trun/fs/ncpfs/sock.c
--- linux/fs/ncpfs/sock.c	Sat Jan 20 16:51:51 2001
+++ trun/fs/ncpfs/sock.c	Tue Feb 13 15:35:35 2001
@@ -153,7 +153,6 @@
 			}
 			timed_out = !schedule_timeout(timeout);
 			poll_freewait(&wait_table);
-			current->state = TASK_RUNNING;
 			if (signal_pending(current)) {
 				result = -ERESTARTSYS;
 				break;
@@ -288,7 +287,6 @@
 		if (!(sock->ops->poll(file, sock, &wait_table) & POLLIN)) {
 			init_timeout = schedule_timeout(init_timeout);
 			poll_freewait(&wait_table);
-			current->state = TASK_RUNNING;
 			if (signal_pending(current)) {
 				return -ERESTARTSYS;
 			}
diff -urN -X dontdiff linux/fs/nfsd/vfs.c trun/fs/nfsd/vfs.c
--- linux/fs/nfsd/vfs.c	Tue Feb 13 15:23:10 2001
+++ trun/fs/nfsd/vfs.c	Tue Feb 13 15:35:35 2001
@@ -730,7 +730,6 @@
 /* FIXME: Olaf commented this out [gam3] */
 			set_current_state(TASK_UNINTERRUPTIBLE);
 			schedule_timeout((HZ+99)/100);
-			current->state = TASK_RUNNING;
 			dprintk("nfsd: write resume %d\n", current->pid);
 #endif
 		}
diff -urN -X dontdiff linux/fs/pipe.c trun/fs/pipe.c
--- linux/fs/pipe.c	Tue Feb 13 15:23:10 2001
+++ trun/fs/pipe.c	Tue Feb 13 15:35:35 2001
@@ -32,7 +32,6 @@
 	up(PIPE_SEM(*inode));
 	schedule();
 	remove_wait_queue(PIPE_WAIT(*inode), &wait);
-	current->state = TASK_RUNNING;
 	down(PIPE_SEM(*inode));
 }
 
diff -urN -X dontdiff linux/ipc/msg.c trun/ipc/msg.c
--- linux/ipc/msg.c	Tue Feb 13 15:23:11 2001
+++ trun/ipc/msg.c	Tue Feb 13 15:35:35 2001
@@ -668,7 +668,6 @@
 		ss_add(msq, &s);
 		msg_unlock(msqid);
 		schedule();
-		current->state = TASK_RUNNING;
 
 		msq = msg_lock(msqid);
 		err = -EIDRM;
@@ -806,9 +805,7 @@
 		msr_d.r_msg = ERR_PTR(-EAGAIN);
 		current->state = TASK_INTERRUPTIBLE;
 		msg_unlock(msqid);
-
 		schedule();
-		current->state = TASK_RUNNING;
 
 		msg = (struct msg_msg*) msr_d.r_msg;
 		if (!IS_ERR(msg)) 
diff -urN -X dontdiff linux/net/core/dev.c trun/net/core/dev.c
--- linux/net/core/dev.c	Tue Feb 13 15:23:12 2001
+++ trun/net/core/dev.c	Tue Feb 13 15:35:35 2001
@@ -2562,7 +2562,6 @@
 		}
 		current->state = TASK_INTERRUPTIBLE;
 		schedule_timeout(HZ/4);
-		current->state = TASK_RUNNING;
 		if ((jiffies - warning_time) > 10*HZ) {
 			printk(KERN_EMERG "unregister_netdevice: waiting for %s to "
 					"become free. Usage count = %d\n",
diff -urN -X dontdiff linux/net/core/sock.c trun/net/core/sock.c
--- linux/net/core/sock.c	Tue Feb 13 15:23:12 2001
+++ trun/net/core/sock.c	Tue Feb 13 15:35:35 2001
@@ -833,7 +833,6 @@
 		if(!sk->lock.users)
 			break;
 	}
-	current->state = TASK_RUNNING;
 	remove_wait_queue(&sk->lock.wq, &wait);
 }
 
diff -urN -X dontdiff linux/net/ipv4/tcp.c trun/net/ipv4/tcp.c
--- linux/net/ipv4/tcp.c	Tue Feb 13 15:23:12 2001
+++ trun/net/ipv4/tcp.c	Tue Feb 13 15:35:35 2001
@@ -660,7 +660,6 @@
 		*timeo_p = schedule_timeout(*timeo_p);
 		lock_sock(sk);
 
-		__set_task_state(tsk, TASK_RUNNING);
 		remove_wait_queue(sk->sleep, &wait);
 		sk->tp_pinfo.af_tcp.write_pending--;
 	}

