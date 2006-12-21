Return-Path: <linux-kernel-owner+w=401wt.eu-S1422900AbWLUJTK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422900AbWLUJTK (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 04:19:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422899AbWLUJSj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 04:18:39 -0500
Received: from dea.vocord.ru ([217.67.177.50]:47316 "EHLO
	kano.factory.vocord.ru" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1422906AbWLUJPM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 04:15:12 -0500
Cc: David Miller <davem@davemloft.net>, Ulrich Drepper <drepper@redhat.com>,
       Andrew Morton <akpm@osdl.org>, Evgeniy Polyakov <johnpol@2ka.mipt.ru>,
       netdev <netdev@vger.kernel.org>, Zach Brown <zach.brown@oracle.com>,
       Christoph Hellwig <hch@infradead.org>,
       Chase Venters <chase.venters@clientec.com>,
       Johann Borck <johann.borck@densedata.com>, linux-kernel@vger.kernel.org,
       Jeff Garzik <jeff@garzik.org>
Subject: [take28-resend_1->0 6/8] kevent: Pipe notifications.
In-Reply-To: <1166692457438@2ka.mipt.ru>
X-Mailer: gregkh_patchbomb
Date: Thu, 21 Dec 2006 12:14:17 +0300
Message-Id: <1166692457991@2ka.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Content-Transfer-Encoding: 7BIT
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Pipe notifications.


diff --git a/fs/pipe.c b/fs/pipe.c
index f3b6f71..aeaee9c 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -16,6 +16,7 @@
 #include <linux/uio.h>
 #include <linux/highmem.h>
 #include <linux/pagemap.h>
+#include <linux/kevent.h>
 
 #include <asm/uaccess.h>
 #include <asm/ioctls.h>
@@ -312,6 +313,7 @@ redo:
 			break;
 		}
 		if (do_wakeup) {
+			kevent_pipe_notify(inode, KEVENT_SOCKET_SEND);
 			wake_up_interruptible_sync(&pipe->wait);
  			kill_fasync(&pipe->fasync_writers, SIGIO, POLL_OUT);
 		}
@@ -321,6 +323,7 @@ redo:
 
 	/* Signal writers asynchronously that there is more room. */
 	if (do_wakeup) {
+		kevent_pipe_notify(inode, KEVENT_SOCKET_SEND);
 		wake_up_interruptible(&pipe->wait);
 		kill_fasync(&pipe->fasync_writers, SIGIO, POLL_OUT);
 	}
@@ -490,6 +493,7 @@ redo2:
 			break;
 		}
 		if (do_wakeup) {
+			kevent_pipe_notify(inode, KEVENT_SOCKET_RECV);
 			wake_up_interruptible_sync(&pipe->wait);
 			kill_fasync(&pipe->fasync_readers, SIGIO, POLL_IN);
 			do_wakeup = 0;
@@ -501,6 +505,7 @@ redo2:
 out:
 	mutex_unlock(&inode->i_mutex);
 	if (do_wakeup) {
+		kevent_pipe_notify(inode, KEVENT_SOCKET_RECV);
 		wake_up_interruptible(&pipe->wait);
 		kill_fasync(&pipe->fasync_readers, SIGIO, POLL_IN);
 	}
@@ -605,6 +610,7 @@ pipe_release(struct inode *inode, int decr, int decw)
 		free_pipe_info(inode);
 	} else {
 		wake_up_interruptible(&pipe->wait);
+		kevent_pipe_notify(inode, KEVENT_SOCKET_SEND|KEVENT_SOCKET_RECV);
 		kill_fasync(&pipe->fasync_readers, SIGIO, POLL_IN);
 		kill_fasync(&pipe->fasync_writers, SIGIO, POLL_OUT);
 	}
diff --git a/kernel/kevent/kevent_pipe.c b/kernel/kevent/kevent_pipe.c
new file mode 100644
index 0000000..91dc1eb
--- /dev/null
+++ b/kernel/kevent/kevent_pipe.c
@@ -0,0 +1,123 @@
+/*
+ * 	kevent_pipe.c
+ * 
+ * 2006 Copyright (c) Evgeniy Polyakov <johnpol@2ka.mipt.ru>
+ * All rights reserved.
+ * 
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+#include <linux/kernel.h>
+#include <linux/types.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+#include <linux/file.h>
+#include <linux/fs.h>
+#include <linux/kevent.h>
+#include <linux/pipe_fs_i.h>
+
+static int kevent_pipe_callback(struct kevent *k)
+{
+	struct inode *inode = k->st->origin;
+	struct pipe_inode_info *pipe = inode->i_pipe;
+	int nrbufs = pipe->nrbufs;
+
+	if (k->event.event & KEVENT_SOCKET_RECV && nrbufs > 0) {
+		if (!pipe->writers)
+			return -1;
+		return 1;
+	}
+	
+	if (k->event.event & KEVENT_SOCKET_SEND && nrbufs < PIPE_BUFFERS) {
+		if (!pipe->readers)
+			return -1;
+		return 1;
+	}
+
+	return 0;
+}
+
+int kevent_pipe_enqueue(struct kevent *k)
+{
+	struct file *pipe;
+	int err = -EBADF;
+	struct inode *inode;
+
+	pipe = fget(k->event.id.raw[0]);
+	if (!pipe)
+		goto err_out_exit;
+
+	inode = igrab(pipe->f_dentry->d_inode);
+	if (!inode)
+		goto err_out_fput;
+
+	err = -EINVAL;
+	if (!S_ISFIFO(inode->i_mode))
+		goto err_out_iput;
+
+	err = kevent_storage_enqueue(&inode->st, k);
+	if (err)
+		goto err_out_iput;
+
+	if (k->event.req_flags & KEVENT_REQ_ALWAYS_QUEUE) {
+		kevent_requeue(k);
+		err = 0;
+	} else {
+		err = k->callbacks.callback(k);
+		if (err)
+			goto err_out_dequeue;
+	}
+
+	fput(pipe);
+
+	return err;
+
+err_out_dequeue:
+	kevent_storage_dequeue(k->st, k);
+err_out_iput:
+	iput(inode);
+err_out_fput:
+	fput(pipe);
+err_out_exit:
+	return err;
+}
+
+int kevent_pipe_dequeue(struct kevent *k)
+{
+	struct inode *inode = k->st->origin;
+
+	kevent_storage_dequeue(k->st, k);
+	iput(inode);
+
+	return 0;
+}
+
+void kevent_pipe_notify(struct inode *inode, u32 event)
+{
+	kevent_storage_ready(&inode->st, NULL, event);
+}
+
+static int __init kevent_init_pipe(void)
+{
+	struct kevent_callbacks sc = {
+		.callback = &kevent_pipe_callback,
+		.enqueue = &kevent_pipe_enqueue,
+		.dequeue = &kevent_pipe_dequeue,
+		.flags = 0,
+	};
+
+	return kevent_add_callbacks(&sc, KEVENT_PIPE);
+}
+module_init(kevent_init_pipe);

