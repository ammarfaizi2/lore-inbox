Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755881AbWKVNsd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755881AbWKVNsd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 08:48:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755886AbWKVNsd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 08:48:33 -0500
Received: from relay.2ka.mipt.ru ([194.85.82.65]:53449 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S1755881AbWKVNsb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 08:48:31 -0500
Date: Wed, 22 Nov 2006 16:46:53 +0300
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Ulrich Drepper <drepper@redhat.com>
Cc: David Miller <davem@davemloft.net>, Andrew Morton <akpm@osdl.org>,
       netdev <netdev@vger.kernel.org>, Zach Brown <zach.brown@oracle.com>,
       Christoph Hellwig <hch@infradead.org>,
       Chase Venters <chase.venters@clientec.com>,
       Johann Borck <johann.borck@densedata.com>, linux-kernel@vger.kernel.org,
       Jeff Garzik <jeff@garzik.org>, Alexander Viro <aviro@redhat.com>
Subject: Re: [take24 0/6] kevent: Generic event handling mechanism.
Message-ID: <20061122134653.GA23241@2ka.mipt.ru>
References: <20061113105458.GA8182@2ka.mipt.ru> <4560F07B.10608@redhat.com> <20061120082500.GA25467@2ka.mipt.ru> <4562102B.5010503@redhat.com> <20061121095302.GA15210@2ka.mipt.ru> <45633049.2000209@redhat.com> <20061121174334.GA25518@2ka.mipt.ru> <4563FD53.7030307@redhat.com> <20061122120933.GA32681@2ka.mipt.ru> <20061122121516.GA7229@2ka.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20061122121516.GA7229@2ka.mipt.ru>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Wed, 22 Nov 2006 16:46:54 +0300 (MSK)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 22, 2006 at 03:15:16PM +0300, Evgeniy Polyakov (johnpol@2ka.mipt.ru) wrote:
> On Wed, Nov 22, 2006 at 03:09:34PM +0300, Evgeniy Polyakov (johnpol@2ka.mipt.ru) wrote:
> > Ok, to solve the problem in the way which should be good for both I
> > decided to implement additional syscall which will allow to mark any
> > event as ready and thus wake up appropriate threads. If userspace will
> > request zero events to be marked as ready, syscall will just
> > interrupt/wakeup one of the listeners parked in syscall.
> 
> Btw, what about putting aditional multiplexer into add/remove/modify
> switch? There will be logical 'ready' addon?

Something like this.

Signed-off-by: Evgeniy Polyakov <johnpol@2ka.mipt.ru>

diff --git a/include/linux/kevent.h b/include/linux/kevent.h
index c909c62..7afb3d6 100644
--- a/include/linux/kevent.h
+++ b/include/linux/kevent.h
@@ -99,6 +99,8 @@ struct kevent_user
 	struct mutex		ctl_mutex;
 	/* Wait until some events are ready. */
 	wait_queue_head_t	wait;
+	/* Exit from syscall if someone wants us to do it */
+	int			need_exit;
 
 	/* Reference counter, increased for each new kevent. */
 	atomic_t		refcnt;
@@ -132,6 +134,8 @@ void kevent_storage_fini(struct kevent_s
 int kevent_storage_enqueue(struct kevent_storage *st, struct kevent *k);
 void kevent_storage_dequeue(struct kevent_storage *st, struct kevent *k);
 
+void kevent_ready(struct kevent *k, int ret);
+
 int kevent_user_add_ukevent(struct ukevent *uk, struct kevent_user *u);
 
 #ifdef CONFIG_KEVENT_POLL
diff --git a/include/linux/ukevent.h b/include/linux/ukevent.h
index 0680fdf..6bc0c79 100644
--- a/include/linux/ukevent.h
+++ b/include/linux/ukevent.h
@@ -174,5 +174,6 @@ struct kevent_ring
 #define	KEVENT_CTL_ADD 		0
 #define	KEVENT_CTL_REMOVE	1
 #define	KEVENT_CTL_MODIFY	2
+#define	KEVENT_CTL_READY	3
 
 #endif /* __UKEVENT_H */
diff --git a/kernel/kevent/kevent.c b/kernel/kevent/kevent.c
index 4d2d878..d1770a1 100644
--- a/kernel/kevent/kevent.c
+++ b/kernel/kevent/kevent.c
@@ -91,10 +91,10 @@ int kevent_init(struct kevent *k)
 	spin_lock_init(&k->ulock);
 	k->flags = 0;
 
-	if (unlikely(k->event.type >= KEVENT_MAX)
+	if (unlikely(k->event.type >= KEVENT_MAX))
 		return kevent_break(k);
 
-	if (!kevent_registered_callbacks[k->event.type].callback)) {
+	if (!kevent_registered_callbacks[k->event.type].callback) {
 		kevent_break(k);
 		return -ENOSYS;
 	}
@@ -142,16 +142,10 @@ void kevent_storage_dequeue(struct keven
 	spin_unlock_irqrestore(&st->lock, flags);
 }
 
-/*
- * Call kevent ready callback and queue it into ready queue if needed.
- * If kevent is marked as one-shot, then remove it from storage queue.
- */
-static int __kevent_requeue(struct kevent *k, u32 event)
+void kevent_ready(struct kevent *k, int ret)
 {
-	int ret, rem;
 	unsigned long flags;
-
-	ret = k->callbacks.callback(k);
+	int rem;
 
 	spin_lock_irqsave(&k->ulock, flags);
 	if (ret > 0)
@@ -178,6 +172,19 @@ static int __kevent_requeue(struct keven
 		spin_unlock_irqrestore(&k->user->ready_lock, flags);
 		wake_up(&k->user->wait);
 	}
+}
+
+/*
+ * Call kevent ready callback and queue it into ready queue if needed.
+ * If kevent is marked as one-shot, then remove it from storage queue.
+ */
+static int __kevent_requeue(struct kevent *k, u32 event)
+{
+	int ret;
+
+	ret = k->callbacks.callback(k);
+
+	kevent_ready(k, ret);
 
 	return ret;
 }
diff --git a/kernel/kevent/kevent_user.c b/kernel/kevent/kevent_user.c
index 2cd8c99..3d1ea6b 100644
--- a/kernel/kevent/kevent_user.c
+++ b/kernel/kevent/kevent_user.c
@@ -47,8 +47,9 @@ static unsigned int kevent_user_poll(str
 	poll_wait(file, &u->wait, wait);
 	mask = 0;
 
-	if (u->ready_num)
+	if (u->ready_num || u->need_exit)
 		mask |= POLLIN | POLLRDNORM;
+	u->need_exit = 0;
 
 	return mask;
 }
@@ -136,6 +137,7 @@ static struct kevent_user *kevent_user_a
 
 	mutex_init(&u->ctl_mutex);
 	init_waitqueue_head(&u->wait);
+	u->need_exit = 0;
 
 	atomic_set(&u->refcnt, 1);
 
@@ -487,6 +489,97 @@ static struct ukevent *kevent_get_user(u
 	return ukev;
 }
 
+static int kevent_mark_ready(struct ukevent *uk, struct kevent_user *u)
+{
+	struct kevent *k;
+	int err = -ENODEV;
+	unsigned long flags;
+
+	spin_lock_irqsave(&u->kevent_lock, flags);
+	k = __kevent_search(&uk->id, u);
+	if (k) {
+		spin_lock(&k->st->lock);
+		kevent_ready(k, 1);
+		spin_unlock(&k->st->lock);
+		err = 0;
+	}
+	spin_unlock_irqrestore(&u->kevent_lock, flags);
+
+	return err;
+}
+
+/*
+ * Mark appropriate kevents as ready.
+ * If number of events is zero just wake up one listener.
+ */
+static int kevent_user_ctl_ready(struct kevent_user *u, unsigned int num, void __user *arg)
+{
+	int err = -EINVAL, cerr = 0, rnum = 0, i;
+	void __user *orig = arg;
+	struct ukevent uk;
+
+	if (num > u->kevent_num)
+		return err;
+	
+	if (!num) {
+		u->need_exit = 1;
+		wake_up(&u->wait);
+		return 0;
+	}
+
+	mutex_lock(&u->ctl_mutex);
+
+	if (num > KEVENT_MIN_BUFFS_ALLOC) {
+		struct ukevent *ukev;
+
+		ukev = kevent_get_user(num, arg);
+		if (ukev) {
+			for (i = 0; i < num; ++i) {
+				err = kevent_mark_ready(&ukev[i], u);
+				if (err) {
+					if (i != rnum)
+						memcpy(&ukev[rnum], &ukev[i], sizeof(struct ukevent));
+					rnum++;
+				}
+			}
+			if (copy_to_user(orig, ukev, rnum*sizeof(struct ukevent)))
+				cerr = -EFAULT;
+			kfree(ukev);
+			goto out_setup;
+		}
+	}
+
+	for (i = 0; i < num; ++i) {
+		if (copy_from_user(&uk, arg, sizeof(struct ukevent))) {
+			cerr = -EFAULT;
+			break;
+		}
+		arg += sizeof(struct ukevent);
+
+		err = kevent_mark_ready(&uk, u);
+		if (err) {
+			if (copy_to_user(orig, &uk, sizeof(struct ukevent))) {
+				cerr = -EFAULT;
+				break;
+			}
+			orig += sizeof(struct ukevent);
+			rnum++;
+		}
+	}
+
+out_setup:
+	if (cerr < 0) {
+		err = cerr;
+		goto out_remove;
+	}
+
+	err = num - rnum;
+out_remove:
+	mutex_unlock(&u->ctl_mutex);
+
+	return err;
+}
+
 /*
  * Read from userspace all ukevents and modify appropriate kevents.
  * If provided number of ukevents is more that threshold, it is faster
@@ -779,9 +872,10 @@ static int kevent_user_wait(struct file
 
 	if (!(file->f_flags & O_NONBLOCK)) {
 		wait_event_interruptible_timeout(u->wait,
-			u->ready_num >= min_nr,
+			(u->ready_num >= min_nr) || u->need_exit,
 			clock_t_to_jiffies(nsec_to_clock_t(timeout)));
 	}
+	u->need_exit = 0;
 
 	while (num < max_nr && ((k = kevent_dequeue_ready(u)) != NULL)) {
 		if (copy_to_user(buf + num*sizeof(struct ukevent),
@@ -819,6 +913,9 @@ static int kevent_ctl_process(struct fil
 	case KEVENT_CTL_MODIFY:
 		err = kevent_user_ctl_modify(u, num, arg);
 		break;
+	case KEVENT_CTL_READY:
+		err = kevent_user_ctl_ready(u, num, arg);
+		break;
 	default:
 		err = -EINVAL;
 		break;
@@ -994,9 +1091,10 @@ asmlinkage long sys_kevent_wait(int ctl_
 
 	if (!(file->f_flags & O_NONBLOCK)) {
 		wait_event_interruptible_timeout(u->wait,
-			((u->ready_num >= 1) && (kevent_ring_space(u))),
+			((u->ready_num >= 1) && kevent_ring_space(u)) || u->need_exit,
 			clock_t_to_jiffies(nsec_to_clock_t(timeout)));
 	}
+	u->need_exit = 0;
 
 	for (i=0; i<num; ++i) {
 		k = kevent_dequeue_ready_ring(u);

-- 
	Evgeniy Polyakov
