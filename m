Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265040AbSKAPAY>; Fri, 1 Nov 2002 10:00:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265042AbSKAPAY>; Fri, 1 Nov 2002 10:00:24 -0500
Received: from host194.steeleye.com ([66.206.164.34]:64017 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S265040AbSKAPAV>; Fri, 1 Nov 2002 10:00:21 -0500
Message-Id: <200211011506.gA1F6fL02859@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: torvalds@transmeta.com
cc: linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,
       Paul.Clements@SteelEye.com
Subject: Minor fixes for nbd for 2.5.45
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 01 Nov 2002 10:06:41 -0500
From: James Bottomley <James.Bottomley@steeleye.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

These are the fixes steeleye makes to use nbd for block device replication in 
a production environment (they've been field tested for at least six months 
now on various 2.4 kernels):

-  make nbd daemon killable
  
-  make signals clean up the queues correctly (otherwise the queue will be in 
an
   insane state if the deamon exits normally with a signal pending)
  
-  increase the device size to 2TB

We've OK'd them with Pavel Machek, if you could apply them.

Thanks,

James Bottomley

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.856, 2002-11-01 09:59:57-05:00, Paul.Clements@steeleye.com
  Minor fixes and cleanups to nbd:
  
  make nbd daemon killable
  
  make signals clean up the queues correctly (otherwise the queue will be in an
  insane state if the deamon exits normally with a signal pending)
  
  increase the device size to 2TB


 nbd.c |   69 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++---
-
 1 files changed, 65 insertions(+), 4 deletions(-)


diff -Nru a/drivers/block/nbd.c b/drivers/block/nbd.c
--- a/drivers/block/nbd.c	Fri Nov  1 10:02:08 2002
+++ b/drivers/block/nbd.c	Fri Nov  1 10:02:08 2002
@@ -26,6 +26,8 @@
  *   reduce number of partial TCP segments sent. <steve@chygwyn.com>
  * 01-12-6 Fix deadlock condition by making queue locks independant of
  *   the transmit lock. <steve@chygwyn.com>
+ * 02-10-11 Allow hung xmit to be aborted via SIGKILL & various fixes.
+ *   <Paul.Clements@SteelEye.com> <James.Bottomley@SteelEye.com>
  *
  * possible FIXME: make set_sock / set_blksize / set_size / do_it one syscall
  * why not: would need verify_area and friends, would share yet another 
@@ -91,10 +93,12 @@
 
 	oldfs = get_fs();
 	set_fs(get_ds());
-
+	/* Allow interception of SIGKILL only
+	 * Don't allow other signals to interrupt the transmission */
 	spin_lock_irqsave(&current->sig->siglock, flags);
 	oldset = current->blocked;
 	sigfillset(&current->blocked);
+	sigdelsetmask(&current->blocked, sigmask(SIGKILL));
 	recalc_sigpending();
 	spin_unlock_irqrestore(&current->sig->siglock, flags);
 
@@ -117,6 +121,17 @@
 		else
 			result = sock_recvmsg(sock, &msg, size, 0);
 
+		if (signal_pending(current)) {
+			siginfo_t info;
+			spin_lock_irqsave(&current->sig->siglock, flags);
+			printk(KERN_WARNING "NBD (pid %d: %s) got signal %d\n",
+				current->pid, current->comm, 
+				dequeue_signal(&current->blocked, &info));
+			spin_unlock_irqrestore(&current->sig->siglock, flags);
+			result = -EINTR;
+			break;
+		}
+
 		if (result <= 0) {
 #ifdef PARANOIA
 			printk(KERN_ERR "NBD: %s - sock=%ld at buf=%ld, size=%d returned %d.\n",
@@ -156,6 +171,10 @@
 
 	down(&lo->tx_lock);
 
+	if (!sock || !lo->sock) {
+		FAIL("Attempted sendmsg to closed socket\n");
+	}
+
 	result = nbd_xmit(1, sock, (char *) &request, sizeof(request), nbd_cmd(req) 
== NBD_CMD_WRITE ? MSG_MORE : 0);
 	if (result <= 0)
 		FAIL("Sendmsg failed for control.");
@@ -343,11 +362,31 @@
 		spin_unlock_irq(q->queue_lock);
 
 		spin_lock(&lo->queue_lock);
+
+		if (!lo->file) {
+			spin_unlock(&lo->queue_lock);
+			printk(KERN_ERR "nbd: failed between accept and semaphore, file lost\n");
+			req->errors++;
+			nbd_end_request(req);
+			spin_lock_irq(q->queue_lock);
+			continue;
+		}
+
 		list_add(&req->queuelist, &lo->queue_head);
 		spin_unlock(&lo->queue_lock);
 
 		nbd_send_req(lo, req);
 
+		if (req->errors) {
+			printk(KERN_ERR "nbd: nbd_send_req failed\n");
+			spin_lock(&lo->queue_lock);
+			list_del(&req->queuelist);
+			spin_unlock(&lo->queue_lock);
+			nbd_end_request(req);
+			spin_lock_irq(q->queue_lock);
+			continue;
+		}
+
 		spin_lock_irq(q->queue_lock);
 		continue;
 
@@ -390,12 +429,14 @@
 			printk(KERN_ERR "nbd: Some requests are in progress -> can not turn 
off.\n");
 			return -EBUSY;
 		}
-		spin_unlock(&lo->queue_lock);
 		file = lo->file;
-		if (!file)
+		if (!file) {
+			spin_unlock(&lo->queue_lock);
 			return -EINVAL;
+		}
 		lo->file = NULL;
 		lo->sock = NULL;
+		spin_unlock(&lo->queue_lock);
 		fput(file);
 		return 0;
 	case NBD_SET_SOCK:
@@ -439,6 +480,26 @@
 		if (!lo->file)
 			return -EINVAL;
 		nbd_do_it(lo);
+		/* on return tidy up in case we have a signal */
+		/* Forcibly shutdown the socket causing all listeners
+		 * to error
+		 *
+		 * FIXME: This code is duplicated from sys_shutdown, but
+		 * there should be a more generic interface rather than
+		 * calling socket ops directly here */
+		down(&lo->tx_lock);
+		printk(KERN_WARNING "nbd: shutting down socket\n");
+		lo->sock->ops->shutdown(lo->sock, SEND_SHUTDOWN|RCV_SHUTDOWN);
+		lo->sock = NULL;
+		up(&lo->tx_lock);
+		spin_lock(&lo->queue_lock);
+		file = lo->file;
+		lo->file = NULL;
+		spin_unlock(&lo->queue_lock);
+		nbd_clear_que(lo);
+		printk(KERN_WARNING "nbd: queue cleared\n");
+		if (file)
+			fput(file);
 		return lo->harderror;
 	case NBD_CLEAR_QUE:
 		nbd_clear_que(lo);
@@ -517,7 +578,7 @@
 		init_MUTEX(&nbd_dev[i].tx_lock);
 		nbd_dev[i].blksize = 1024;
 		nbd_dev[i].blksize_bits = 10;
-		nbd_dev[i].bytesize = 0x7ffffc00; /* 2GB */
+		nbd_dev[i].bytesize = ((u64)0x7ffffc00) << 10; /* 2TB */
 		disk->major = MAJOR_NR;
 		disk->first_minor = i;
 		disk->fops = &nbd_fops;

===================================================================


This BitKeeper patch contains the following changesets:
+
## Wrapped with gzip_uu ##


begin 664 bkpatch2828
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
7.&'AA<J2W8#YK<"K4><?L7%3&44.````
`
end


