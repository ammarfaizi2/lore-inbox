Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131410AbRCPWPG>; Fri, 16 Mar 2001 17:15:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131412AbRCPWOq>; Fri, 16 Mar 2001 17:14:46 -0500
Received: from mozart.stat.wisc.edu ([128.105.5.24]:50958 "EHLO
	mozart.stat.wisc.edu") by vger.kernel.org with ESMTP
	id <S131410AbRCPWOo>; Fri, 16 Mar 2001 17:14:44 -0500
To: torvalds@transmeta.com (Linus Torvalds)
cc: linux-kernel@vger.kernel.org
Subject: PATCH against 2.4.2: TTY hangup on PPP channel corrupts kernel memory
From: buhr@stat.wisc.edu (Kevin Buhr)
Date: 16 Mar 2001 16:14:01 -0600
Message-ID: <vbaofv1nyza.fsf@mozart.stat.wisc.edu>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus:

This one was tough to find.  I think I triggered it maybe four times
over the space of six months and almost chalked it up to an electrical
problem with the modem.

If there's a hangup in the TTY layer on an async PPP channel,
do_tty_hangup shuts down the PPP line discipline, and, in ppp_async.c,
the function ppp_asynctty_close unregisteres the channel.  In
ppp_generic.c, ppp_unregister_channel merrily wakes up the rwait
queue, then proceeds to destroy the channel, freeing the "struct
channel" which contains the "struct ppp_file" that contains the
"wait_queue_head_t rwait".  When the waiting process wakes up, it
removes itself from the wait queue, modifying freed memory.

(In my case, it turns out that the "struct channel" in ppp_generic.c
and "struct shmid_kernel" are both in the size-128 slab cache.  My
desktop pager uses the X SHM extension to snapshot the desktop and
does many SHM allocations per second.  In the occasional case that the
allocation beats the rwaiting process, a modem hangup sends the X
server spinning on a random piece of memory way down in
"valid_swaphandles", and the other CPU locks up in some unrelated
place waiting on the kernel lock.)

A patch against 2.4.2 follows.  I've overloaded the "refcnt" in
"struct ppp_file" to also keep track of rwaiters.  The last refcnt
user destroys the channel and decreases the module use count.  I've
tested this with printks in all the right places, and it seems to fix
the problem correctly.

I don't use any other PPP drivers besides async, but it looks like the
same bug exists (and will be fixed by this patch) in ppp_synctty.c.

The FILEVERSION at the top of ppp_generic may need to be fixed, but 

Thanks.

Kevin <buhr@stat.wisc.edu>

                        *       *       *

--- linux-2.4.2/drivers/net/ppp_generic.c	Sun Mar  4 20:09:19 2001
+++ linux-2.4.2-local/drivers/net/ppp_generic.c	Fri Mar 16 14:50:28 2001
@@ -72,7 +72,7 @@
 	struct sk_buff_head xq;		/* pppd transmit queue */
 	struct sk_buff_head rq;		/* receive queue for pppd */
 	wait_queue_head_t rwait;	/* for poll on reading /dev/ppp */
-	atomic_t	refcnt;		/* # refs (incl /dev/ppp attached) */
+	atomic_t	refcnt;		/* # refs (attaches and rwaiters) */
 	int		hdrlen;		/* space to leave for headers */
 	struct list_head list;		/* link in all_* list */
 	int		index;		/* interface unit / channel number */
@@ -316,6 +316,28 @@
 	return 0;
 }
 
+/*
+ * For ppp_async, a (true) hangup in the TTY layer will shut down the
+ * current line discipline, unregistering the channel, so...
+ *
+ * We must ppp_file_acquire before waiting on rwait to keep the
+ * channel around, then ppp_file_release after waiting to release
+ * resources if we're the last user.
+ */
+#define ppp_file_acquire(pf) atomic_inc(&(pf)->refcnt)
+static void ppp_file_release(struct ppp_file *pf) {
+	if (atomic_dec_and_test(&pf->refcnt)) {
+		switch (pf->kind) {
+		case INTERFACE:
+			ppp_destroy_interface(PF_TO_PPP(pf));
+			break;
+		case CHANNEL:
+			ppp_destroy_channel(PF_TO_CHANNEL(pf));
+			break;
+		}
+	}
+}
+
 static int ppp_release(struct inode *inode, struct file *file)
 {
 	struct ppp_file *pf = (struct ppp_file *) file->private_data;
@@ -323,16 +345,7 @@
 	lock_kernel();
 	if (pf != 0) {
 		file->private_data = 0;
-		if (atomic_dec_and_test(&pf->refcnt)) {
-			switch (pf->kind) {
-			case INTERFACE:
-				ppp_destroy_interface(PF_TO_PPP(pf));
-				break;
-			case CHANNEL:
-				ppp_destroy_channel(PF_TO_CHANNEL(pf));
-				break;
-			}
-		}
+		ppp_file_release(pf);
 	}
 	unlock_kernel();
 	return 0;
@@ -357,6 +370,7 @@
 	if (pf == 0)
 		goto out;		/* not currently attached */
 
+	ppp_file_acquire(pf);
 	add_wait_queue(&pf->rwait, &wait);
 	current->state = TASK_INTERRUPTIBLE;
 	for (;;) {
@@ -376,6 +390,7 @@
 	}
 	current->state = TASK_RUNNING;
 	remove_wait_queue(&pf->rwait, &wait);
+	ppp_file_release(pf);
 
 	if (skb == 0)
 		goto out;
@@ -448,6 +463,7 @@
 
 	if (pf == 0)
 		return 0;
+	ppp_file_acquire(pf);
 	poll_wait(file, &pf->rwait, wait);
 	mask = POLLOUT | POLLWRNORM;
 	if (skb_peek(&pf->rq) != 0)
@@ -457,6 +473,7 @@
 		if (pch->chan == 0)
 			mask |= POLLHUP;
 	}
+	ppp_file_release(pf);
 	return mask;
 }
 
@@ -1788,9 +1805,12 @@
 	spin_lock_bh(&all_channels_lock);
 	list_del(&pch->file.list);
 	spin_unlock_bh(&all_channels_lock);
+	/*
+	 * If refcnt goes to zero, there are no attachments *and*
+	 * no rwaiters, so destruction is safe.
+	 */
 	if (atomic_dec_and_test(&pch->file.refcnt))
 		ppp_destroy_channel(pch);
-	MOD_DEC_USE_COUNT;
 }
 
 /*
@@ -1840,9 +1860,11 @@
 
 	mask = POLLOUT | POLLWRNORM;
 	if (pch != 0) {
+		ppp_file_acquire(&pch->file);
 		poll_wait(file, &pch->file.rwait, wait);
 		if (skb_peek(&pch->file.rq) != 0)
 			mask |= POLLIN | POLLRDNORM;
+		ppp_file_release(&pch->file);
 	}
 	return mask;
 }
@@ -2221,6 +2243,7 @@
 	}
 
 	list_add(&ppp->file.list, list->prev);
+	MOD_INC_USE_COUNT;
  out:
 	spin_unlock(&all_ppp_lock);
 	*retp = ret;
@@ -2286,6 +2309,7 @@
 		kfree(ppp);
 
 	spin_unlock(&all_ppp_lock);
+	MOD_DEC_USE_COUNT;
 }
 
 /*
@@ -2407,6 +2431,7 @@
 	skb_queue_purge(&pch->file.xq);
 	skb_queue_purge(&pch->file.rq);
 	kfree(pch);
+	MOD_DEC_USE_COUNT;
 }
 
 static void __exit ppp_cleanup(void)
