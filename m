Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261825AbTL1Rzr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Dec 2003 12:55:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261837AbTL1Rzr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Dec 2003 12:55:47 -0500
Received: from 80-219-102-241.dclient.hispeed.ch ([80.219.102.241]:22788 "EHLO
	ritz.dnsalias.org") by vger.kernel.org with ESMTP id S261825AbTL1Rzj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Dec 2003 12:55:39 -0500
From: Daniel Ritz <daniel.ritz@gmx.ch>
Reply-To: daniel.ritz@gmx.ch
To: Russell King <rmk@arm.linux.org.uk>,
       "linux-pcmcia" <linux-pcmcia@lists.infradead.org>,
       "linux-kernel" <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.6] fix use-after-free in ds.c
Date: Sun, 28 Dec 2003 18:52:01 +0100
User-Agent: KMail/1.5.2
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200312281852.01685.daniel.ritz@gmx.ch>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

fixes a use-after-free in ds.c seen when doing:

  # cardctl eject
  # rmmod yenta_socket
  # killall cardmgr

this is russell king's patch from october plus removes some unused vars.
(original see: http://lists.infradead.org/pipermail/linux-pcmcia/2003-October/000303.html )

against 2.6.0, please enqueue.



--- 1.39/drivers/pcmcia/ds.c	Sat Sep 27 11:11:05 2003
+++ edited/drivers/pcmcia/ds.c	Sun Dec 28 17:30:54 2003
@@ -51,6 +51,8 @@
 #include <linux/list.h>
 #include <linux/workqueue.h>
 
+#include <asm/atomic.h>
+
 #include <pcmcia/version.h>
 #include <pcmcia/cs_types.h>
 #include <pcmcia/cs.h>
@@ -95,10 +97,12 @@
     int			event_head, event_tail;
     event_t		event[MAX_EVENTS];
     struct user_info_t	*next;
+    struct pcmcia_bus_socket *socket;
 } user_info_t;
 
 /* Socket state information */
 struct pcmcia_bus_socket {
+	atomic_t		refcount;
 	client_handle_t		handle;
 	int			state;
 	user_info_t		*user;
@@ -113,6 +117,7 @@
 #define SOCKET_PRESENT		0x01
 #define SOCKET_BUSY		0x02
 #define SOCKET_REMOVAL_PENDING	0x10
+#define SOCKET_DEAD		0x80
 
 /*====================================================================*/
 
@@ -137,6 +142,24 @@
 static struct pcmcia_driver * get_pcmcia_driver (dev_info_t *dev_info);
 static struct pcmcia_bus_socket * get_socket_info_by_nr(unsigned int nr);
 
+static void pcmcia_put_bus_socket(struct pcmcia_bus_socket *s)
+{
+	if (atomic_dec_and_test(&s->refcount))
+		kfree(s);
+}
+
+static struct pcmcia_bus_socket *pcmcia_get_bus_socket(int nr)
+{
+	struct pcmcia_bus_socket *s;
+
+	s = get_socket_info_by_nr(nr);
+	if (s) {
+		WARN_ON(atomic_read(&s->refcount) == 0);
+		atomic_inc(&s->refcount);
+	}
+	return s;
+}
+
 /**
  * pcmcia_register_driver - register a PCMCIA driver with the bus core
  *
@@ -501,7 +524,7 @@
 
     DEBUG(0, "ds_open(socket %d)\n", i);
 
-    s = get_socket_info_by_nr(i);
+    s = pcmcia_get_bus_socket(i);
     if (!s)
 	    return -ENODEV;
 
@@ -517,6 +540,7 @@
     user->event_tail = user->event_head = 0;
     user->next = s->user;
     user->user_magic = USER_MAGIC;
+    user->socket = s;
     s->user = user;
     file->private_data = user;
     
@@ -529,20 +553,17 @@
 
 static int ds_release(struct inode *inode, struct file *file)
 {
-    socket_t i = iminor(inode);
     struct pcmcia_bus_socket *s;
     user_info_t *user, **link;
 
     DEBUG(0, "ds_release(socket %d)\n", i);
 
-    s = get_socket_info_by_nr(i);
-    if (!s)
-	    return 0;
-
     user = file->private_data;
     if (CHECK_USER(user))
 	goto out;
 
+    s = user->socket;
+
     /* Unlink user data structure */
     if ((file->f_flags & O_ACCMODE) != O_RDONLY)
 	s->state &= ~SOCKET_BUSY;
@@ -554,6 +575,7 @@
     *link = user->next;
     user->user_magic = 0;
     kfree(user);
+    pcmcia_put_bus_socket(s);
 out:
     return 0;
 } /* ds_release */
@@ -563,7 +585,6 @@
 static ssize_t ds_read(struct file *file, char *buf,
 		       size_t count, loff_t *ppos)
 {
-    socket_t i = iminor(file->f_dentry->d_inode);
     struct pcmcia_bus_socket *s;
     user_info_t *user;
 
@@ -572,14 +593,14 @@
     if (count < 4)
 	return -EINVAL;
 
-    s = get_socket_info_by_nr(i);
-    if (!s)
-	    return -ENODEV;
-
     user = file->private_data;
     if (CHECK_USER(user))
 	return -EIO;
     
+    s = user->socket;
+    if (s->state & SOCKET_DEAD)
+        return -EIO;
+
     if (queue_empty(user)) {
 	interruptible_sleep_on(&s->queue);
 	if (signal_pending(current))
@@ -594,7 +615,6 @@
 static ssize_t ds_write(struct file *file, const char *buf,
 			size_t count, loff_t *ppos)
 {
-    socket_t i = iminor(file->f_dentry->d_inode);
     struct pcmcia_bus_socket *s;
     user_info_t *user;
 
@@ -605,14 +625,14 @@
     if ((file->f_flags & O_ACCMODE) == O_RDONLY)
 	return -EBADF;
 
-    s = get_socket_info_by_nr(i);
-    if (!s)
-	    return -ENODEV;
-
     user = file->private_data;
     if (CHECK_USER(user))
 	return -EIO;
 
+    s = user->socket;
+    if (s->state & SOCKET_DEAD)
+        return -EIO;
+
     if (s->req_pending) {
 	s->req_pending--;
 	get_user(s->req_result, (int *)buf);
@@ -629,19 +649,19 @@
 /* No kernel lock - fine */
 static u_int ds_poll(struct file *file, poll_table *wait)
 {
-    socket_t i = iminor(file->f_dentry->d_inode);
     struct pcmcia_bus_socket *s;
     user_info_t *user;
 
     DEBUG(2, "ds_poll(socket %d)\n", i);
     
-    s = get_socket_info_by_nr(i);
-    if (!s)
-	    return POLLERR;
-
     user = file->private_data;
     if (CHECK_USER(user))
 	return POLLERR;
+    s = user->socket;
+    /*
+     * We don't check for a dead socket here since that
+     * will send cardmgr into an endless spin.
+     */
     poll_wait(file, &s->queue, wait);
     if (!queue_empty(user))
 	return POLLIN | POLLRDNORM;
@@ -653,17 +673,21 @@
 static int ds_ioctl(struct inode * inode, struct file * file,
 		    u_int cmd, u_long arg)
 {
-    socket_t i = iminor(inode);
     struct pcmcia_bus_socket *s;
     u_int size;
     int ret, err;
     ds_ioctl_arg_t buf;
+    user_info_t *user;
 
     DEBUG(2, "ds_ioctl(socket %d, %#x, %#lx)\n", i, cmd, arg);
     
-    s = get_socket_info_by_nr(i);
-    if (!s)
-	    return -ENODEV;
+    user = file->private_data;
+    if (CHECK_USER(user))
+	return -EIO;
+
+    s = user->socket;
+    if (s->state & SOCKET_DEAD)
+        return -EIO;
     
     size = (cmd & IOCSIZE_MASK) >> IOCSIZE_SHIFT;
     if (size > sizeof(ds_ioctl_arg_t)) return -EINVAL;
@@ -833,6 +857,7 @@
 	if(!s)
 		return -ENOMEM;
 	memset(s, 0, sizeof(struct pcmcia_bus_socket));
+	atomic_set(&s->refcount, 1);
     
 	/*
 	 * Ugly. But we want to wait for the socket threads to have started up.
@@ -894,7 +919,8 @@
 
 	pcmcia_deregister_client(socket->pcmcia->handle);
 
-	kfree(socket->pcmcia);
+	socket->pcmcia->state |= SOCKET_DEAD;
+	pcmcia_put_bus_socket(socket->pcmcia);
 	socket->pcmcia = NULL;
 
 	return;

