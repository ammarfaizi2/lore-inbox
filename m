Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030294AbVINRbr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030294AbVINRbr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 13:31:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965257AbVINRbr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 13:31:47 -0400
Received: from mtagate3.de.ibm.com ([195.212.29.152]:57253 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP id S965243AbVINRbq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 13:31:46 -0400
Subject: Re: [patch 2/7] s390: 3270 fullscreen view.
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
To: Christoph Hellwig <hch@infradead.org>
Cc: akpm@osdl.org, rbh00@utsglobal.com, linux-kernel@vger.kernel.org
In-Reply-To: <20050914161022.GA4230@infradead.org>
References: <20050914155345.GA11478@skybase.boeblingen.de.ibm.com>
	 <20050914161022.GA4230@infradead.org>
Content-Type: text/plain
Date: Wed, 14 Sep 2005 19:31:46 +0200
Message-Id: <1126719107.4908.29.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-09-14 at 17:10 +0100, Christoph Hellwig wrote:
> On Wed, Sep 14, 2005 at 05:53:45PM +0200, Martin Schwidefsky wrote:
> > diff -urpN linux-2.6/arch/s390/kernel/compat_ioctl.c linux-2.6-patched/arch/s390/kernel/compat_ioctl.c
> > --- linux-2.6/arch/s390/kernel/compat_ioctl.c	2005-08-29 01:41:01.000000000 +0200
> > +++ linux-2.6-patched/arch/s390/kernel/compat_ioctl.c	2005-09-14 16:48:15.000000000 +0200
> > @@ -18,6 +18,8 @@
> >  #include <asm/dasd.h>
> >  #include <asm/cmb.h>
> >  #include <asm/tape390.h>
> > +#include <asm/ccwdev.h>
> > +#include "../../../drivers/s390/char/raw3270.h"
> 
> Umm, no.  Please implement a compat_ioctl methods for the driver instead.
> a volunteer ;-)

True. And I should use unlocked_ioctl. Then the function
for .unlocked_ioctl and .compat_ioctl can be the same.
Thanks for the nudge. New patch.

Now that you mention it: looks like the dasd ioctls could be converted
to unlocked_ioctl / compat_ioctl as well. I'll ask Horst..

-- 
blue skies,
   Martin

Martin Schwidefsky
Linux for zSeries Development & Services
IBM Deutschland Entwicklung GmbH

-----
[patch 2/7] s390: 3270 fullscreen view.

From: Richard Hitt <rbh00@utsglobal.com>
From: Martin Schwidefsky <schwidefsky@de.ibm.com>

Fix fullscreen view of the 3270 device driver.

Signed-off-by: Richard Hitt <rbh00@utsglobal.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

diffstat:
 drivers/s390/char/con3270.c |    7 -
 drivers/s390/char/fs3270.c  |  255 +++++++++++++++++++++++++++++++++++---------
 drivers/s390/char/raw3270.c |  100 +++++++++++++++--
 drivers/s390/char/raw3270.h |    7 +
 drivers/s390/char/tty3270.c |   27 ++--
 5 files changed, 318 insertions(+), 78 deletions(-)

diff -urpN linux-2.6/drivers/s390/char/con3270.c linux-2.6-patched/drivers/s390/char/con3270.c
--- linux-2.6/drivers/s390/char/con3270.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6-patched/drivers/s390/char/con3270.c	2005-09-14 19:16:30.000000000 +0200
@@ -213,6 +213,9 @@ con3270_update(struct con3270 *cp)
 	struct string *s, *n;
 	int rc;
 
+	if (cp->view.dev)
+		raw3270_activate_view(&cp->view);
+
 	wrq = xchg(&cp->write, 0);
 	if (!wrq) {
 		con3270_set_timer(cp, 1);
@@ -489,8 +492,6 @@ con3270_write(struct console *co, const 
 	unsigned char c;
 
 	cp = condev;
-	if (cp->view.dev)
-		raw3270_activate_view(&cp->view);
 	spin_lock_irqsave(&cp->view.lock, flags);
 	while (count-- > 0) {
 		c = *str++;
@@ -620,7 +621,7 @@ con3270_init(void)
 		     (void (*)(unsigned long)) con3270_read_tasklet,
 		     (unsigned long) condev->read);
 
-	raw3270_add_view(&condev->view, &con3270_fn, 0);
+	raw3270_add_view(&condev->view, &con3270_fn, 1);
 
 	INIT_LIST_HEAD(&condev->freemem);
 	for (i = 0; i < CON3270_STRING_PAGES; i++) {
diff -urpN linux-2.6/drivers/s390/char/fs3270.c linux-2.6-patched/drivers/s390/char/fs3270.c
--- linux-2.6/drivers/s390/char/fs3270.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6-patched/drivers/s390/char/fs3270.c	2005-09-14 19:16:30.000000000 +0200
@@ -33,8 +33,11 @@ struct fs3270 {
 	int read_command;		/* ccw command to use for reads. */
 	int write_command;		/* ccw command to use for writes. */
 	int attention;			/* Got attention. */
-	struct raw3270_request *clear;	/* single clear request. */
-	wait_queue_head_t attn_wait;	/* Attention wait queue. */
+	int active;			/* Fullscreen view is active. */
+	struct raw3270_request *init;	/* single init request. */
+	wait_queue_head_t wait;		/* Init & attention wait queue. */
+	struct idal_buffer *rdbuf;	/* full-screen-deactivate buffer */
+	size_t rdbuf_size;		/* size of data returned by RDBUF */
 };
 
 static void
@@ -43,58 +46,172 @@ fs3270_wake_up(struct raw3270_request *r
 	wake_up((wait_queue_head_t *) data);
 }
 
+static inline int
+fs3270_working(struct fs3270 *fp)
+{
+	/*
+	 * The fullscreen view is in working order if the view
+	 * has been activated AND the initial request is finished.
+	 */
+	return fp->active && raw3270_request_final(fp->init);
+}
+
 static int
 fs3270_do_io(struct raw3270_view *view, struct raw3270_request *rq)
 {
-	wait_queue_head_t wq;
+	struct fs3270 *fp;
 	int rc;
 
-	init_waitqueue_head(&wq);
+	fp = (struct fs3270 *) view;
 	rq->callback = fs3270_wake_up;
-	rq->callback_data = &wq;
-	rc = raw3270_start(view, rq);
-	if (rc)
-		return rc;
-	/* Started sucessfully. Now wait for completion. */
-	wait_event(wq, raw3270_request_final(rq));
-	return rq->rc;
+	rq->callback_data = &fp->wait;
+
+	do {
+		if (!fs3270_working(fp)) {
+			/* Fullscreen view isn't ready yet. */
+			rc = wait_event_interruptible(fp->wait,
+						      fs3270_working(fp));
+			if (rc != 0)
+				break;
+		}
+		rc = raw3270_start(view, rq);
+		if (rc == 0) {
+			/* Started sucessfully. Now wait for completion. */
+			wait_event(fp->wait, raw3270_request_final(rq));
+		}
+	} while (rc == -EACCES);
+	return rc;
 }
 
+/*
+ * Switch to the fullscreen view.
+ */
 static void
 fs3270_reset_callback(struct raw3270_request *rq, void *data)
 {
+	struct fs3270 *fp;
+
+	fp = (struct fs3270 *) rq->view;
 	raw3270_request_reset(rq);
+	wake_up(&fp->wait);
+}
+
+static void
+fs3270_restore_callback(struct raw3270_request *rq, void *data)
+{
+	struct fs3270 *fp;
+
+	fp = (struct fs3270 *) rq->view;
+	if (rq->rc != 0 || rq->rescnt != 0) {
+		if (fp->fs_pid)
+			kill_proc(fp->fs_pid, SIGHUP, 1);
+	}
+	fp->rdbuf_size = 0;
+	raw3270_request_reset(rq);
+	wake_up(&fp->wait);
 }
 
-/*
- * Switch to the fullscreen view.
- */
 static int
 fs3270_activate(struct raw3270_view *view)
 {
 	struct fs3270 *fp;
+	char *cp;
+	int rc;
 
 	fp = (struct fs3270 *) view;
-	raw3270_request_set_cmd(fp->clear, TC_EWRITEA);
-	fp->clear->callback = fs3270_reset_callback;
-	return raw3270_start(view, fp->clear);
+
+	/* If an old init command is still running just return. */
+	if (!raw3270_request_final(fp->init))
+		return 0;
+
+	if (fp->rdbuf_size == 0) {
+		/* No saved buffer. Just clear the screen. */
+		raw3270_request_set_cmd(fp->init, TC_EWRITEA);
+		fp->init->callback = fs3270_reset_callback;
+	} else {
+		/* Restore fullscreen buffer saved by fs3270_deactivate. */
+		raw3270_request_set_cmd(fp->init, TC_EWRITEA);
+		raw3270_request_set_idal(fp->init, fp->rdbuf);
+		fp->init->ccw.count = fp->rdbuf_size;
+		cp = fp->rdbuf->data[0];
+		cp[0] = TW_KR;
+		cp[1] = TO_SBA;
+		cp[2] = cp[6];
+		cp[3] = cp[7];
+		cp[4] = TO_IC;
+		cp[5] = TO_SBA;
+		cp[6] = 0x40;
+		cp[7] = 0x40;
+		fp->init->rescnt = 0;
+		fp->init->callback = fs3270_restore_callback;
+	}
+	rc = fp->init->rc = raw3270_start_locked(view, fp->init);
+	if (rc)
+		fp->init->callback(fp->init, NULL);
+	else
+		fp->active = 1;
+	return rc;
 }
 
 /*
  * Shutdown fullscreen view.
  */
 static void
+fs3270_save_callback(struct raw3270_request *rq, void *data)
+{
+	struct fs3270 *fp;
+
+	fp = (struct fs3270 *) rq->view;
+
+	/* Correct idal buffer element 0 address. */
+	fp->rdbuf->data[0] -= 5;
+	fp->rdbuf->size += 5;
+
+	/*
+	 * If the rdbuf command failed or the idal buffer is
+	 * to small for the amount of data returned by the
+	 * rdbuf command, then we have no choice but to send
+	 * a SIGHUP to the application.
+	 */
+	if (rq->rc != 0 || rq->rescnt == 0) {
+		if (fp->fs_pid)
+			kill_proc(fp->fs_pid, SIGHUP, 1);
+		fp->rdbuf_size = 0;
+	} else
+		fp->rdbuf_size = fp->rdbuf->size - rq->rescnt;
+	raw3270_request_reset(rq);
+	wake_up(&fp->wait);
+}
+
+static void
 fs3270_deactivate(struct raw3270_view *view)
 {
-	// FIXME: is this a good idea? The user program using fullscreen 3270
-	// will die just because a console message appeared. On the other
-	// hand the fullscreen device is unoperational now.
 	struct fs3270 *fp;
 
 	fp = (struct fs3270 *) view;
-	if (fp->fs_pid != 0)
-		kill_proc(fp->fs_pid, SIGHUP, 1);
-	fp->fs_pid = 0;
+	fp->active = 0;
+
+	/* If an old init command is still running just return. */
+	if (!raw3270_request_final(fp->init))
+		return;
+
+	/* Prepare read-buffer request. */
+	raw3270_request_set_cmd(fp->init, TC_RDBUF);
+	/*
+	 * Hackish: skip first 5 bytes of the idal buffer to make
+	 * room for the TW_KR/TO_SBA/<address>/<address>/TO_IC sequence
+	 * in the activation command.
+	 */
+	fp->rdbuf->data[0] += 5;
+	fp->rdbuf->size -= 5;
+	raw3270_request_set_idal(fp->init, fp->rdbuf);
+	fp->init->rescnt = 0;
+	fp->init->callback = fs3270_save_callback;
+
+	/* Start I/O to read in the 3270 buffer. */
+	fp->init->rc = raw3270_start_locked(view, fp->init);
+	if (fp->init->rc)
+		fp->init->callback(fp->init, NULL);
 }
 
 static int
@@ -103,7 +220,7 @@ fs3270_irq(struct fs3270 *fp, struct raw
 	/* Handle ATTN. Set indication and wake waiters for attention. */
 	if (irb->scsw.dstat & DEV_STAT_ATTENTION) {
 		fp->attention = 1;
-		wake_up(&fp->attn_wait);
+		wake_up(&fp->wait);
 	}
 
 	if (rq) {
@@ -125,7 +242,7 @@ fs3270_read(struct file *filp, char *dat
 	struct fs3270 *fp;
 	struct raw3270_request *rq;
 	struct idal_buffer *ib;
-	int rc;
+	ssize_t rc;
 	
 	if (count == 0 || count > 65535)
 		return -EINVAL;
@@ -133,7 +250,7 @@ fs3270_read(struct file *filp, char *dat
 	if (!fp)
 		return -ENODEV;
 	ib = idal_buffer_alloc(count, 0);
-	if (!ib)
+	if (IS_ERR(ib))
 		return -ENOMEM;
 	rq = raw3270_request_alloc(0);
 	if (!IS_ERR(rq)) {
@@ -141,10 +258,19 @@ fs3270_read(struct file *filp, char *dat
 			fp->read_command = 6;
 		raw3270_request_set_cmd(rq, fp->read_command ? : 2);
 		raw3270_request_set_idal(rq, ib);
-		wait_event(fp->attn_wait, fp->attention);
-		rc = fs3270_do_io(&fp->view, rq);
-		if (rc == 0 && idal_buffer_to_user(ib, data, count))
-			rc = -EFAULT;
+		rc = wait_event_interruptible(fp->wait, fp->attention);
+		fp->attention = 0;
+		if (rc == 0) {
+			rc = fs3270_do_io(&fp->view, rq);
+			if (rc == 0) {
+				count -= rq->rescnt;
+				if (idal_buffer_to_user(ib, data, count) != 0)
+					rc = -EFAULT;
+				else
+					rc = count;
+
+			}
+		}
 		raw3270_request_free(rq);
 	} else
 		rc = PTR_ERR(rq);
@@ -162,13 +288,13 @@ fs3270_write(struct file *filp, const ch
 	struct raw3270_request *rq;
 	struct idal_buffer *ib;
 	int write_command;
-	int rc;
+	ssize_t rc;
 
 	fp = filp->private_data;
 	if (!fp)
 		return -ENODEV;
 	ib = idal_buffer_alloc(count, 0);
-	if (!ib)
+	if (IS_ERR(ib))
 		return -ENOMEM;
 	rq = raw3270_request_alloc(0);
 	if (!IS_ERR(rq)) {
@@ -179,6 +305,8 @@ fs3270_write(struct file *filp, const ch
 			raw3270_request_set_cmd(rq, write_command);
 			raw3270_request_set_idal(rq, ib);
 			rc = fs3270_do_io(&fp->view, rq);
+			if (rc == 0)
+				rc = count - rq->rescnt;
 		} else
 			rc = -EFAULT;
 		raw3270_request_free(rq);
@@ -191,9 +319,8 @@ fs3270_write(struct file *filp, const ch
 /*
  * process ioctl commands for the tube driver
  */
-static int
-fs3270_ioctl(struct inode *inode, struct file *filp,
-	     unsigned int cmd, unsigned long arg)
+static long
+fs3270_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 {
 	struct fs3270 *fp;
 	struct raw3270_iocb iocb;
@@ -227,12 +354,15 @@ fs3270_ioctl(struct inode *inode, struct
 				 sizeof(struct raw3270_iocb)))
 			rc = -EFAULT;
 		break;
+	default:
+		rc = -ENOIOCTLCMD;
+		break;
 	}
 	return rc;
 }
 
 /*
- * Allocate tty3270 structure.
+ * Allocate fs3270 structure.
  */
 static struct fs3270 *
 fs3270_alloc_view(void)
@@ -243,8 +373,8 @@ fs3270_alloc_view(void)
 	if (!fp)
 		return ERR_PTR(-ENOMEM);
 	memset(fp, 0, sizeof(struct fs3270));
-	fp->clear = raw3270_request_alloc(0);
-	if (!IS_ERR(fp->clear)) {
+	fp->init = raw3270_request_alloc(0);
+	if (IS_ERR(fp->init)) {
 		kfree(fp);
 		return ERR_PTR(-ENOMEM);
 	}
@@ -252,12 +382,17 @@ fs3270_alloc_view(void)
 }
 
 /*
- * Free tty3270 structure.
+ * Free fs3270 structure.
  */
 static void
 fs3270_free_view(struct raw3270_view *view)
 {
-	raw3270_request_free(((struct fs3270 *) view)->clear);
+	struct fs3270 *fp;
+
+	fp = (struct fs3270 *) view;
+	if (fp->rdbuf)
+		idal_buffer_free(fp->rdbuf);
+	raw3270_request_free(((struct fs3270 *) view)->init);
 	kfree(view);
 }
 
@@ -285,11 +420,20 @@ static int
 fs3270_open(struct inode *inode, struct file *filp)
 {
 	struct fs3270 *fp;
+	struct idal_buffer *ib;
 	int minor, rc;
 
 	if (imajor(filp->f_dentry->d_inode) != IBM_FS3270_MAJOR)
 		return -ENODEV;
 	minor = iminor(filp->f_dentry->d_inode);
+	/* Check for minor 0 multiplexer. */
+	if (minor == 0) {
+		if (!current->signal->tty)
+			return -ENODEV;
+		if (current->signal->tty->driver->major != IBM_TTY3270_MAJOR)
+			return -ENODEV;
+		minor = current->signal->tty->index + RAW3270_FIRSTMINOR;
+	}
 	/* Check if some other program is already using fullscreen mode. */
 	fp = (struct fs3270 *) raw3270_find_view(&fs3270_fn, minor);
 	if (!IS_ERR(fp)) {
@@ -301,7 +445,7 @@ fs3270_open(struct inode *inode, struct 
 	if (IS_ERR(fp))
 		return PTR_ERR(fp);
 
-	init_waitqueue_head(&fp->attn_wait);
+	init_waitqueue_head(&fp->wait);
 	fp->fs_pid = current->pid;
 	rc = raw3270_add_view(&fp->view, &fs3270_fn, minor);
 	if (rc) {
@@ -309,8 +453,18 @@ fs3270_open(struct inode *inode, struct 
 		return rc;
 	}
 
+	/* Allocate idal-buffer. */
+	ib = idal_buffer_alloc(2*fp->view.rows*fp->view.cols + 5, 0);
+	if (IS_ERR(ib)) {
+		raw3270_put_view(&fp->view);
+		raw3270_del_view(&fp->view);
+		return PTR_ERR(fp);
+	}
+	fp->rdbuf = ib;
+
 	rc = raw3270_activate_view(&fp->view);
 	if (rc) {
+		raw3270_put_view(&fp->view);
 		raw3270_del_view(&fp->view);
 		return rc;
 	}
@@ -329,18 +483,23 @@ fs3270_close(struct inode *inode, struct
 
 	fp = filp->private_data;
 	filp->private_data = 0;
-	if (fp)
+	if (fp) {
+		fp->fs_pid = 0;
+		raw3270_reset(&fp->view);
+		raw3270_put_view(&fp->view);
 		raw3270_del_view(&fp->view);
+	}
 	return 0;
 }
 
 static struct file_operations fs3270_fops = {
-	.owner	 = THIS_MODULE,		/* owner */
-	.read	 = fs3270_read,		/* read */
-	.write	 = fs3270_write,	/* write */
-	.ioctl	 = fs3270_ioctl,	/* ioctl */
-	.open	 = fs3270_open,		/* open */
-	.release = fs3270_close,	/* release */
+	.owner = THIS_MODULE,
+	.read = fs3270_read,
+	.write = fs3270_write,
+	.open = fs3270_open,
+	.release = fs3270_close,
+	.unlocked_ioctl = fs3270_ioctl,
+	.compat_ioctl = fs3270_ioctl,
 };
 
 /*
diff -urpN linux-2.6/drivers/s390/char/raw3270.c linux-2.6-patched/drivers/s390/char/raw3270.c
--- linux-2.6/drivers/s390/char/raw3270.c	2005-09-14 19:16:15.000000000 +0200
+++ linux-2.6-patched/drivers/s390/char/raw3270.c	2005-09-14 19:16:30.000000000 +0200
@@ -25,6 +25,12 @@
 
 #include "raw3270.h"
 
+#include <linux/major.h>
+#include <linux/kdev_t.h>
+#include <linux/device.h>
+
+struct class *class3270;
+
 /* The main 3270 data structure. */
 struct raw3270 {
 	struct list_head list;
@@ -41,6 +47,8 @@ struct raw3270 {
 	struct timer_list timer;	/* Device timer. */
 
 	unsigned char *ascebc;		/* ascii -> ebcdic table */
+	struct class_device *clttydev;	/* 3270-class tty device ptr */
+	struct class_device *cltubdev;	/* 3270-class tub device ptr */
 };
 
 /* raw3270->flags */
@@ -317,6 +325,22 @@ raw3270_start(struct raw3270_view *view,
 }
 
 int
+raw3270_start_locked(struct raw3270_view *view, struct raw3270_request *rq)
+{
+	struct raw3270 *rp;
+	int rc;
+
+	rp = view->dev;
+	if (!rp || rp->view != view)
+		rc = -EACCES;
+	else if (!test_bit(RAW3270_FLAGS_READY, &rp->flags))
+		rc = -ENODEV;
+	else
+		rc =  __raw3270_start(rp, view, rq);
+	return rc;
+}
+
+int
 raw3270_start_irq(struct raw3270_view *view, struct raw3270_request *rq)
 {
 	struct raw3270 *rp;
@@ -744,6 +768,22 @@ raw3270_reset_device(struct raw3270 *rp)
 	return rc;
 }
 
+int
+raw3270_reset(struct raw3270_view *view)
+{
+	struct raw3270 *rp;
+	int rc;
+
+	rp = view->dev;
+	if (!rp || rp->view != view)
+		rc = -EACCES;
+	else if (!test_bit(RAW3270_FLAGS_READY, &rp->flags))
+		rc = -ENODEV;
+	else
+		rc = raw3270_reset_device(view->dev);
+	return rc;
+}
+
 /*
  * Setup new 3270 device.
  */
@@ -774,11 +814,12 @@ raw3270_setup_device(struct ccw_device *
 
 	/*
 	 * Add device to list and find the smallest unused minor
-	 * number for it.
+	 * number for it. Note: there is no device with minor 0,
+	 * see special case for fs3270.c:fs3270_open().
 	 */
 	down(&raw3270_sem);
 	/* Keep the list sorted. */
-	minor = 0;
+	minor = RAW3270_FIRSTMINOR;
 	rp->minor = -1;
 	list_for_each(l, &raw3270_devices) {
 		tmp = list_entry(l, struct raw3270, list);
@@ -789,7 +830,7 @@ raw3270_setup_device(struct ccw_device *
 		}
 		minor++;
 	}
-	if (rp->minor == -1 && minor < RAW3270_MAXDEVS) {
+	if (rp->minor == -1 && minor < RAW3270_MAXDEVS + RAW3270_FIRSTMINOR) {
 		rp->minor = minor;
 		list_add_tail(&rp->list, &raw3270_devices);
 	}
@@ -941,11 +982,12 @@ raw3270_deactivate_view(struct raw3270_v
 		list_add_tail(&view->list, &rp->view_list);
 		/* Try to activate another view. */
 		if (test_bit(RAW3270_FLAGS_READY, &rp->flags)) {
-			list_for_each_entry(view, &rp->view_list, list)
-				if (view->fn->activate(view) == 0) {
-					rp->view = view;
+			list_for_each_entry(view, &rp->view_list, list) {
+				rp->view = view;
+				if (view->fn->activate(view) == 0)
 					break;
-				}
+				rp->view = 0;
+			}
 		}
 	}
 	spin_unlock_irqrestore(get_ccwdev_lock(rp->cdev), flags);
@@ -961,6 +1003,8 @@ raw3270_add_view(struct raw3270_view *vi
 	struct raw3270 *rp;
 	int rc;
 
+	if (minor <= 0)
+		return -ENODEV;
 	down(&raw3270_sem);
 	rc = -ENODEV;
 	list_for_each_entry(rp, &raw3270_devices, list) {
@@ -976,7 +1020,7 @@ raw3270_add_view(struct raw3270_view *vi
 			view->cols = rp->cols;
 			view->ascebc = rp->ascebc;
 			spin_lock_init(&view->lock);
-			list_add_tail(&view->list, &rp->view_list);
+			list_add(&view->list, &rp->view_list);
 			rc = 0;
 		}
 		spin_unlock_irqrestore(get_ccwdev_lock(rp->cdev), flags);
@@ -1039,7 +1083,7 @@ raw3270_del_view(struct raw3270_view *vi
 	if (!rp->view && test_bit(RAW3270_FLAGS_READY, &rp->flags)) {
 		/* Try to activate another view. */
 		list_for_each_entry(nv, &rp->view_list, list) {
-			if (nv->fn->activate(view) == 0) {
+			if (nv->fn->activate(nv) == 0) {
 				rp->view = nv;
 				break;
 			}
@@ -1063,6 +1107,12 @@ raw3270_delete_device(struct raw3270 *rp
 
 	/* Remove from device chain. */
 	down(&raw3270_sem);
+	if (rp->clttydev)
+		class_device_destroy(class3270,
+				     MKDEV(IBM_TTY3270_MAJOR, rp->minor));
+	if (rp->cltubdev)
+		class_device_destroy(class3270,
+				     MKDEV(IBM_FS3270_MAJOR, rp->minor));
 	list_del_init(&rp->list);
 	up(&raw3270_sem);
 
@@ -1129,6 +1179,16 @@ raw3270_create_attributes(struct raw3270
 {
 	//FIXME: check return code
 	sysfs_create_group(&rp->cdev->dev.kobj, &raw3270_attr_group);
+	rp->clttydev =
+		class_device_create(class3270,
+				    MKDEV(IBM_TTY3270_MAJOR, rp->minor),
+				    &rp->cdev->dev, "tty%s",
+				    rp->cdev->dev.bus_id);
+	rp->cltubdev =
+		class_device_create(class3270,
+				    MKDEV(IBM_FS3270_MAJOR, rp->minor),
+				    &rp->cdev->dev, "tub%s",
+				    rp->cdev->dev.bus_id);
 }
 
 /*
@@ -1189,13 +1249,13 @@ raw3270_set_online (struct ccw_device *c
 		return PTR_ERR(rp);
 	rc = raw3270_reset_device(rp);
 	if (rc)
-		return rc;
+		goto failure;
 	rc = raw3270_size_device(rp);
 	if (rc)
-		return rc;
+		goto failure;
 	rc = raw3270_reset_device(rp);
 	if (rc)
-		return rc;
+		goto failure;
 	raw3270_create_attributes(rp);
 	set_bit(RAW3270_FLAGS_READY, &rp->flags);
 	down(&raw3270_sem);
@@ -1203,6 +1263,10 @@ raw3270_set_online (struct ccw_device *c
 		np->notifier(rp->minor, 1);
 	up(&raw3270_sem);
 	return 0;
+
+failure:
+	raw3270_delete_device(rp);
+	return rc;
 }
 
 /*
@@ -1217,6 +1281,14 @@ raw3270_remove (struct ccw_device *cdev)
 	struct raw3270_notifier *np;
 
 	rp = cdev->dev.driver_data;
+	/*
+	 * _remove is the opposite of _probe; it's probe that
+	 * should set up rp.  raw3270_remove gets entered for
+	 * devices even if they haven't been varied online.
+	 * Thus, rp may validly be NULL here.
+	 */
+	if (rp == NULL)
+      return;
 	clear_bit(RAW3270_FLAGS_READY, &rp->flags);
 
 	sysfs_remove_group(&cdev->dev.kobj, &raw3270_attr_group);
@@ -1301,6 +1373,7 @@ raw3270_init(void)
 	if (rc == 0) {
 		/* Create attributes for early (= console) device. */
 		down(&raw3270_sem);
+		class3270 = class_create(THIS_MODULE, "3270");
 		list_for_each_entry(rp, &raw3270_devices, list) {
 			get_device(&rp->cdev->dev);
 			raw3270_create_attributes(rp);
@@ -1314,6 +1387,7 @@ static void
 raw3270_exit(void)
 {
 	ccw_driver_unregister(&raw3270_ccw_driver);
+	class_destroy(class3270);
 }
 
 MODULE_LICENSE("GPL");
@@ -1335,7 +1409,9 @@ EXPORT_SYMBOL(raw3270_find_view);
 EXPORT_SYMBOL(raw3270_activate_view);
 EXPORT_SYMBOL(raw3270_deactivate_view);
 EXPORT_SYMBOL(raw3270_start);
+EXPORT_SYMBOL(raw3270_start_locked);
 EXPORT_SYMBOL(raw3270_start_irq);
+EXPORT_SYMBOL(raw3270_reset);
 EXPORT_SYMBOL(raw3270_register_notifier);
 EXPORT_SYMBOL(raw3270_unregister_notifier);
 EXPORT_SYMBOL(raw3270_wait_queue);
diff -urpN linux-2.6/drivers/s390/char/raw3270.h linux-2.6-patched/drivers/s390/char/raw3270.h
--- linux-2.6/drivers/s390/char/raw3270.h	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6-patched/drivers/s390/char/raw3270.h	2005-09-14 19:16:30.000000000 +0200
@@ -21,6 +21,7 @@
 
 /* Local Channel Commands */
 #define TC_WRITE	0x01		/* Write */
+#define TC_RDBUF	0x02		/* Read Buffer */
 #define TC_EWRITE	0x05		/* Erase write */
 #define TC_READMOD	0x06		/* Read modified */
 #define TC_EWRITEA	0x0d		/* Erase write alternate */
@@ -76,7 +77,8 @@
 #define TW_KR		0xc2		/* Keyboard restore */
 #define TW_PLUSALARM	0x04		/* Add this bit for alarm */
 
-#define RAW3270_MAXDEVS	256
+#define RAW3270_FIRSTMINOR	1	/* First minor number */
+#define RAW3270_MAXDEVS		255	/* Max number of 3270 devices */
 
 /* For TUBGETMOD and TUBSETMOD. Should include. */
 struct raw3270_iocb {
@@ -166,7 +168,10 @@ void raw3270_del_view(struct raw3270_vie
 void raw3270_deactivate_view(struct raw3270_view *);
 struct raw3270_view *raw3270_find_view(struct raw3270_fn *, int);
 int raw3270_start(struct raw3270_view *, struct raw3270_request *);
+int raw3270_start_locked(struct raw3270_view *, struct raw3270_request *);
 int raw3270_start_irq(struct raw3270_view *, struct raw3270_request *);
+int raw3270_reset(struct raw3270_view *);
+struct raw3270_view *raw3270_view(struct raw3270_view *);
 
 /* Reference count inliner for view structures. */
 static inline void
diff -urpN linux-2.6/drivers/s390/char/tty3270.c linux-2.6-patched/drivers/s390/char/tty3270.c
--- linux-2.6/drivers/s390/char/tty3270.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6-patched/drivers/s390/char/tty3270.c	2005-09-14 19:16:30.000000000 +0200
@@ -653,18 +653,12 @@ tty3270_activate(struct raw3270_view *vi
 	tp->update_flags = TTY_UPDATE_ALL;
 	tty3270_set_timer(tp, 1);
 	spin_unlock_irqrestore(&tp->view.lock, flags);
-	start_tty(tp->tty);
 	return 0;
 }
 
 static void
 tty3270_deactivate(struct raw3270_view *view)
 {
-	struct tty3270 *tp;
-
-	tp = (struct tty3270 *) view;
-	if (tp && tp->tty)
-		stop_tty(tp->tty);
 }
 
 static int
@@ -716,13 +710,13 @@ tty3270_alloc_view(void)
 				  tp->freemem_pages[pages], PAGE_SIZE);
 	}
 	tp->write = raw3270_request_alloc(TTY3270_OUTPUT_BUFFER_SIZE);
-	if (!tp->write)
+	if (IS_ERR(tp->write))
 		goto out_pages;
 	tp->read = raw3270_request_alloc(0);
-	if (!tp->read)
+	if (IS_ERR(tp->read))
 		goto out_write;
 	tp->kreset = raw3270_request_alloc(1);
-	if (!tp->kreset)
+	if (IS_ERR(tp->kreset))
 		goto out_read;
 	tp->kbd = kbd_alloc();
 	if (!tp->kbd)
@@ -845,7 +839,8 @@ tty3270_del_views(void)
 	int i;
 
 	for (i = 0; i < tty3270_max_index; i++) {
-		tp = (struct tty3270 *) raw3270_find_view(&tty3270_fn, i);
+		tp = (struct tty3270 *)
+			raw3270_find_view(&tty3270_fn, i + RAW3270_FIRSTMINOR);
 		if (!IS_ERR(tp))
 			raw3270_del_view(&tp->view);
 	}
@@ -871,7 +866,9 @@ tty3270_open(struct tty_struct *tty, str
 	if (tty->count > 1)
 		return 0;
 	/* Check if the tty3270 is already there. */
-	tp = (struct tty3270 *) raw3270_find_view(&tty3270_fn, tty->index);
+	tp = (struct tty3270 *)
+		raw3270_find_view(&tty3270_fn,
+				  tty->index + RAW3270_FIRSTMINOR);
 	if (!IS_ERR(tp)) {
 		tty->driver_data = tp;
 		tty->winsize.ws_row = tp->view.rows - 2;
@@ -903,7 +900,8 @@ tty3270_open(struct tty_struct *tty, str
 		     (void (*)(unsigned long)) tty3270_read_tasklet,
 		     (unsigned long) tp->read);
 
-	rc = raw3270_add_view(&tp->view, &tty3270_fn, tty->index);
+	rc = raw3270_add_view(&tp->view, &tty3270_fn,
+			      tty->index + RAW3270_FIRSTMINOR);
 	if (rc) {
 		tty3270_free_view(tp);
 		return rc;
@@ -911,8 +909,8 @@ tty3270_open(struct tty_struct *tty, str
 
 	rc = tty3270_alloc_screen(tp);
 	if (rc) {
-		raw3270_del_view(&tp->view);
 		raw3270_put_view(&tp->view);
+		raw3270_del_view(&tp->view);
 		return rc;
 	}
 
@@ -1780,7 +1778,7 @@ tty3270_init(void)
 	struct tty_driver *driver;
 	int ret;
 
-	driver = alloc_tty_driver(256);
+	driver = alloc_tty_driver(RAW3270_MAXDEVS);
 	if (!driver)
 		return -ENOMEM;
 
@@ -1794,6 +1792,7 @@ tty3270_init(void)
 	driver->driver_name = "ttyTUB";
 	driver->name = "ttyTUB";
 	driver->major = IBM_TTY3270_MAJOR;
+	driver->minor_start = RAW3270_FIRSTMINOR;
 	driver->type = TTY_DRIVER_TYPE_SYSTEM;
 	driver->subtype = SYSTEM_TYPE_TTY;
 	driver->init_termios = tty_std_termios;


