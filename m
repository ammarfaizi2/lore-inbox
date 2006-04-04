Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964893AbWDDACZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964893AbWDDACZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 20:02:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964906AbWDCX7t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 19:59:49 -0400
Received: from wp060.webpack.hosteurope.de ([80.237.132.67]:39095 "EHLO
	wp060.webpack.hosteurope.de") by vger.kernel.org with ESMTP
	id S964902AbWDCX7p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 19:59:45 -0400
Date: Tue, 4 Apr 2006 02:00:26 +0200
From: Hansjoerg Lipp <hjlipp@web.de>
To: Karsten Keil <kkeil@suse.de>
Cc: i4ldeveloper@listserv.isdn4linux.de, linux-usb-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@suse.de>,
       Tilman Schmidt <tilman@imap.cc>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH 9/13] isdn4linux: Siemens Gigaset drivers - mutex conversion
Message-ID: <gigaset307x.2006.04.04.001.9@hjlipp.my-fqdn.de>
References: <gigaset307x.2006.04.04.001.0@hjlipp.my-fqdn.de> <gigaset307x.2006.04.04.001.1@hjlipp.my-fqdn.de> <gigaset307x.2006.04.04.001.2@hjlipp.my-fqdn.de> <gigaset307x.2006.04.04.001.3@hjlipp.my-fqdn.de> <gigaset307x.2006.04.04.001.4@hjlipp.my-fqdn.de> <gigaset307x.2006.04.04.001.5@hjlipp.my-fqdn.de> <gigaset307x.2006.04.04.001.6@hjlipp.my-fqdn.de> <gigaset307x.2006.04.04.001.7@hjlipp.my-fqdn.de> <gigaset307x.2006.04.04.001.8@hjlipp.my-fqdn.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <gigaset307x.2006.04.04.001.8@hjlipp.my-fqdn.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tilman Schmidt <tilman@imap.cc>, Hansjoerg Lipp <hjlipp@web.de>

This patch converts the semaphores used by the Gigaset drivers to
mutexes. Please merge.

Signed-off-by: Hansjoerg Lipp <hjlipp@web.de>
Signed-off-by: Tilman Schmidt <tilman@imap.cc>
---

 drivers/isdn/gigaset/common.c    |   26 ++++++++++++-----------
 drivers/isdn/gigaset/gigaset.h   |    2 -
 drivers/isdn/gigaset/interface.c |   44 +++++++++++++++++++--------------------
 drivers/isdn/gigaset/proc.c      |    6 ++---
 4 files changed, 40 insertions(+), 38 deletions(-)

--- linux-2.6.16-gig-from_user/drivers/isdn/gigaset/gigaset.h	2006-04-02 18:43:01.000000000 +0200
+++ linux-2.6.16-gig-mutex/drivers/isdn/gigaset/gigaset.h	2006-04-02 18:43:41.000000000 +0200
@@ -497,7 +497,7 @@ struct cardstate {
 	int cs_init;
 	int ignoreframes;		/* frames to ignore after setting up the
 					   B channel */
-	struct semaphore sem;		/* locks this structure:
+	struct mutex mutex;		/* locks this structure:
 					 *   connected is not changed,
 					 *   hardware_up is not changed,
 					 *   MState is not changed to or from
--- linux-2.6.16-gig-from_user/drivers/isdn/gigaset/common.c	2006-04-02 18:43:01.000000000 +0200
+++ linux-2.6.16-gig-mutex/drivers/isdn/gigaset/common.c	2006-04-02 18:43:41.000000000 +0200
@@ -408,7 +408,7 @@ void gigaset_freecs(struct cardstate *cs
 	if (!cs)
 		return;
 
-	down(&cs->sem);
+	mutex_lock(&cs->mutex);
 
 	if (!cs->bcs)
 		goto f_cs;
@@ -459,7 +459,7 @@ void gigaset_freecs(struct cardstate *cs
 f_bcs:	gig_dbg(DEBUG_INIT, "freeing bcs[]");
 	kfree(cs->bcs);
 f_cs:	gig_dbg(DEBUG_INIT, "freeing cs");
-	up(&cs->sem);
+	mutex_unlock(&cs->mutex);
 	free_cs(cs);
 }
 EXPORT_SYMBOL_GPL(gigaset_freecs);
@@ -652,7 +652,9 @@ struct cardstate *gigaset_initcs(struct 
 	spin_lock_init(&cs->ev_lock);
 	atomic_set(&cs->ev_tail, 0);
 	atomic_set(&cs->ev_head, 0);
-	init_MUTEX_LOCKED(&cs->sem);
+	mutex_init(&cs->mutex);
+	mutex_lock(&cs->mutex);
+	
 	tasklet_init(&cs->event_tasklet, &gigaset_handle_event,
 		     (unsigned long) cs);
 	atomic_set(&cs->commands_pending, 0);
@@ -729,11 +731,11 @@ struct cardstate *gigaset_initcs(struct 
 	add_timer(&cs->timer);
 
 	gig_dbg(DEBUG_INIT, "cs initialized");
-	up(&cs->sem);
+	mutex_unlock(&cs->mutex);
 	return cs;
 
 error:	if (cs)
-		up(&cs->sem);
+		mutex_unlock(&cs->mutex);
 	gig_dbg(DEBUG_INIT, "failed");
 	gigaset_freecs(cs);
 	return NULL;
@@ -831,7 +833,7 @@ static void cleanup_cs(struct cardstate 
 
 int gigaset_start(struct cardstate *cs)
 {
-	if (down_interruptible(&cs->sem))
+	if (mutex_lock_interruptible(&cs->mutex))
 		return 0;
 
 	atomic_set(&cs->connected, 1);
@@ -861,18 +863,18 @@ int gigaset_start(struct cardstate *cs)
 	/* set up device sysfs */
 	gigaset_init_dev_sysfs(cs);
 
-	up(&cs->sem);
+	mutex_unlock(&cs->mutex);
 	return 1;
 
 error:
-	up(&cs->sem);
+	mutex_unlock(&cs->mutex);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(gigaset_start);
 
 void gigaset_shutdown(struct cardstate *cs)
 {
-	down(&cs->sem);
+	mutex_lock(&cs->mutex);
 
 	cs->waiting = 1;
 
@@ -902,13 +904,13 @@ void gigaset_shutdown(struct cardstate *
 	cleanup_cs(cs);
 
 exit:
-	up(&cs->sem);
+	mutex_unlock(&cs->mutex);
 }
 EXPORT_SYMBOL_GPL(gigaset_shutdown);
 
 void gigaset_stop(struct cardstate *cs)
 {
-	down(&cs->sem);
+	mutex_lock(&cs->mutex);
 
 	/* clear device sysfs */
 	gigaset_free_dev_sysfs(cs);
@@ -936,7 +938,7 @@ void gigaset_stop(struct cardstate *cs)
 	cleanup_cs(cs);
 
 exit:
-	up(&cs->sem);
+	mutex_unlock(&cs->mutex);
 }
 EXPORT_SYMBOL_GPL(gigaset_stop);
 
--- linux-2.6.16-gig-from_user/drivers/isdn/gigaset/interface.c	2006-04-02 18:43:01.000000000 +0200
+++ linux-2.6.16-gig-mutex/drivers/isdn/gigaset/interface.c	2006-04-02 18:43:41.000000000 +0200
@@ -160,7 +160,7 @@ static int if_open(struct tty_struct *tt
 	if (!cs)
 		return -ENODEV;
 
-	if (down_interruptible(&cs->sem))
+	if (mutex_lock_interruptible(&cs->mutex))
 		return -ERESTARTSYS; // FIXME -EINTR?
 	tty->driver_data = cs;
 
@@ -173,7 +173,7 @@ static int if_open(struct tty_struct *tt
 		tty->low_latency = 1; //FIXME test
 	}
 
-	up(&cs->sem);
+	mutex_unlock(&cs->mutex);
 	return 0;
 }
 
@@ -190,7 +190,7 @@ static void if_close(struct tty_struct *
 
 	gig_dbg(DEBUG_IF, "%u: %s()", cs->minor_index, __func__);
 
-	down(&cs->sem);
+	mutex_lock(&cs->mutex);
 
 	if (!cs->open_count)
 		warn("%s: device not opened", __func__);
@@ -202,7 +202,7 @@ static void if_close(struct tty_struct *
 		}
 	}
 
-	up(&cs->sem);
+	mutex_unlock(&cs->mutex);
 }
 
 static int if_ioctl(struct tty_struct *tty, struct file *file,
@@ -222,7 +222,7 @@ static int if_ioctl(struct tty_struct *t
 
 	gig_dbg(DEBUG_IF, "%u: %s(0x%x)", cs->minor_index, __func__, cmd);
 
-	if (down_interruptible(&cs->sem))
+	if (mutex_lock_interruptible(&cs->mutex))
 		return -ERESTARTSYS; // FIXME -EINTR?
 
 	if (!cs->open_count)
@@ -279,7 +279,7 @@ static int if_ioctl(struct tty_struct *t
 		}
 	}
 
-	up(&cs->sem);
+	mutex_unlock(&cs->mutex);
 
 	return retval;
 }
@@ -297,13 +297,13 @@ static int if_tiocmget(struct tty_struct
 
 	gig_dbg(DEBUG_IF, "%u: %s()", cs->minor_index, __func__);
 
-	if (down_interruptible(&cs->sem))
+	if (mutex_lock_interruptible(&cs->mutex))
 		return -ERESTARTSYS; // FIXME -EINTR?
 
 	// FIXME read from device?
 	retval = cs->control_state & (TIOCM_RTS|TIOCM_DTR);
 
-	up(&cs->sem);
+	mutex_unlock(&cs->mutex);
 
 	return retval;
 }
@@ -324,7 +324,7 @@ static int if_tiocmset(struct tty_struct
 	gig_dbg(DEBUG_IF, "%u: %s(0x%x, 0x%x)",
 		cs->minor_index, __func__, set, clear);
 
-	if (down_interruptible(&cs->sem))
+	if (mutex_lock_interruptible(&cs->mutex))
 		return -ERESTARTSYS; // FIXME -EINTR?
 
 	if (!atomic_read(&cs->connected)) {
@@ -336,7 +336,7 @@ static int if_tiocmset(struct tty_struct
 		cs->control_state = mc;
 	}
 
-	up(&cs->sem);
+	mutex_unlock(&cs->mutex);
 
 	return retval;
 }
@@ -354,7 +354,7 @@ static int if_write(struct tty_struct *t
 
 	gig_dbg(DEBUG_IF, "%u: %s()", cs->minor_index, __func__);
 
-	if (down_interruptible(&cs->sem))
+	if (mutex_lock_interruptible(&cs->mutex))
 		return -ERESTARTSYS; // FIXME -EINTR?
 
 	if (!cs->open_count)
@@ -370,7 +370,7 @@ static int if_write(struct tty_struct *t
 					    &cs->if_wake_tasklet);
 	}
 
-	up(&cs->sem);
+	mutex_unlock(&cs->mutex);
 
 	return retval;
 }
@@ -388,7 +388,7 @@ static int if_write_room(struct tty_stru
 
 	gig_dbg(DEBUG_IF, "%u: %s()", cs->minor_index, __func__);
 
-	if (down_interruptible(&cs->sem))
+	if (mutex_lock_interruptible(&cs->mutex))
 		return -ERESTARTSYS; // FIXME -EINTR?
 
 	if (!cs->open_count)
@@ -402,7 +402,7 @@ static int if_write_room(struct tty_stru
 	} else
 		retval = cs->ops->write_room(cs);
 
-	up(&cs->sem);
+	mutex_unlock(&cs->mutex);
 
 	return retval;
 }
@@ -420,7 +420,7 @@ static int if_chars_in_buffer(struct tty
 
 	gig_dbg(DEBUG_IF, "%u: %s()", cs->minor_index, __func__);
 
-	if (down_interruptible(&cs->sem))
+	if (mutex_lock_interruptible(&cs->mutex))
 		return -ERESTARTSYS; // FIXME -EINTR?
 
 	if (!cs->open_count)
@@ -434,7 +434,7 @@ static int if_chars_in_buffer(struct tty
 	} else
 		retval = cs->ops->chars_in_buffer(cs);
 
-	up(&cs->sem);
+	mutex_unlock(&cs->mutex);
 
 	return retval;
 }
@@ -451,7 +451,7 @@ static void if_throttle(struct tty_struc
 
 	gig_dbg(DEBUG_IF, "%u: %s()", cs->minor_index, __func__);
 
-	down(&cs->sem);
+	mutex_lock(&cs->mutex);
 
 	if (!cs->open_count)
 		warn("%s: device not opened", __func__);
@@ -459,7 +459,7 @@ static void if_throttle(struct tty_struc
 		//FIXME
 	}
 
-	up(&cs->sem);
+	mutex_unlock(&cs->mutex);
 }
 
 static void if_unthrottle(struct tty_struct *tty)
@@ -474,7 +474,7 @@ static void if_unthrottle(struct tty_str
 
 	gig_dbg(DEBUG_IF, "%u: %s()", cs->minor_index, __func__);
 
-	down(&cs->sem);
+	mutex_lock(&cs->mutex);
 
 	if (!cs->open_count)
 		warn("%s: device not opened", __func__);
@@ -482,7 +482,7 @@ static void if_unthrottle(struct tty_str
 		//FIXME
 	}
 
-	up(&cs->sem);
+	mutex_unlock(&cs->mutex);
 }
 
 static void if_set_termios(struct tty_struct *tty, struct termios *old)
@@ -501,7 +501,7 @@ static void if_set_termios(struct tty_st
 
 	gig_dbg(DEBUG_IF, "%u: %s()", cs->minor_index, __func__);
 
-	down(&cs->sem);
+	mutex_lock(&cs->mutex);
 
 	if (!cs->open_count) {
 		warn("%s: device not opened", __func__);
@@ -586,7 +586,7 @@ static void if_set_termios(struct tty_st
 	cs->control_state = control_state;
 
 out:
-	up(&cs->sem);
+	mutex_unlock(&cs->mutex);
 }
 
 
--- linux-2.6.16-gig-from_user/drivers/isdn/gigaset/proc.c	2006-04-02 18:41:27.000000000 +0200
+++ linux-2.6.16-gig-mutex/drivers/isdn/gigaset/proc.c	2006-04-02 18:43:41.000000000 +0200
@@ -37,14 +37,14 @@ static ssize_t set_cidmode(struct device
 	if (value < 0 || value > 1)
 			return -EINVAL;
 
-	if (down_interruptible(&cs->sem))
+	if (mutex_lock_interruptible(&cs->mutex))
 		return -ERESTARTSYS; // FIXME -EINTR?
 
 	cs->waiting = 1;
 	if (!gigaset_add_event(cs, &cs->at_state, EV_PROC_CIDMODE,
 			       NULL, value, NULL)) {
 		cs->waiting = 0;
-		up(&cs->sem);
+		mutex_unlock(&cs->mutex);
 		return -ENOMEM;
 	}
 
@@ -53,7 +53,7 @@ static ssize_t set_cidmode(struct device
 
 	wait_event(cs->waitqueue, !cs->waiting);
 
-	up(&cs->sem);
+	mutex_unlock(&cs->mutex);
 
 	return count;
 }
