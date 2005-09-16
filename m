Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750763AbVIPXjg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750763AbVIPXjg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 19:39:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750774AbVIPXjg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 19:39:36 -0400
Received: from x35.xmailserver.org ([69.30.125.51]:47278 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id S1750769AbVIPXjf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 19:39:35 -0400
X-AuthUser: davidel@xmailserver.org
Date: Fri, 16 Sep 2005 16:35:34 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@localhost.localdomain
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
cc: Andrew Morton <akpm@osdl.org>
Subject: [patch] Fix epoll delayed initialization bug ...
Message-ID: <Pine.LNX.4.63.0509161621050.6125@localhost.localdomain>
X-GPG-FINGRPRINT: CFAE 5BEE FD36 F65E E640  56FE 0974 BF23 270F 474E
X-GPG-PUBLIC_KEY: http://www.xmailserver.org/davidel.asc
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Al found a potential problem in epoll_create(), where the 
file->private_data member was set after fd_install(). This is obviously 
wrong since another thread might do a close() on that fd# before we set 
the file->private_data member. This goes over 2.6.13 and passes a few 
basic tests I've done here.


Signed-off-by: Davide Libenzi <davidel@xmailserver.org>


- Davide



diff -Nru linux-2.6.13.vanilla/fs/eventpoll.c linux-2.6.13/fs/eventpoll.c
--- linux-2.6.13.vanilla/fs/eventpoll.c	2005-09-16 15:20:46.000000000 -0700
+++ linux-2.6.13/fs/eventpoll.c	2005-09-16 15:21:08.000000000 -0700
@@ -231,8 +231,9 @@

  static void ep_poll_safewake_init(struct poll_safewake *psw);
  static void ep_poll_safewake(struct poll_safewake *psw, wait_queue_head_t *wq);
-static int ep_getfd(int *efd, struct inode **einode, struct file **efile);
-static int ep_file_init(struct file *file);
+static int ep_getfd(int *efd, struct inode **einode, struct file **efile,
+		    struct eventpoll *ep);
+static int ep_alloc(struct eventpoll **pep);
  static void ep_free(struct eventpoll *ep);
  static struct epitem *ep_find(struct eventpoll *ep, struct file *file, int fd);
  static void ep_use_epitem(struct epitem *epi);
@@ -501,38 +502,37 @@
  asmlinkage long sys_epoll_create(int size)
  {
  	int error, fd;
+	struct eventpoll *ep;
  	struct inode *inode;
  	struct file *file;

  	DNPRINTK(3, (KERN_INFO "[%p] eventpoll: sys_epoll_create(%d)\n",
  		     current, size));

-	/* Sanity check on the size parameter */
+	/*
+	 * Sanity check on the size parameter, and create the internal data
+	 * structure ( "struct eventpoll" ).
+	 */
  	error = -EINVAL;
-	if (size <= 0)
+	if (size <= 0 || (error = ep_alloc(&ep)))
  		goto eexit_1;

  	/*
  	 * Creates all the items needed to setup an eventpoll file. That is,
  	 * a file structure, and inode and a free file descriptor.
  	 */
-	error = ep_getfd(&fd, &inode, &file);
-	if (error)
-		goto eexit_1;
-
-	/* Setup the file internal data structure ( "struct eventpoll" ) */
-	error = ep_file_init(file);
+	error = ep_getfd(&fd, &inode, &file, ep);
  	if (error)
  		goto eexit_2;

-
  	DNPRINTK(3, (KERN_INFO "[%p] eventpoll: sys_epoll_create(%d) = %d\n",
  		     current, size, fd));

  	return fd;

  eexit_2:
-	sys_close(fd);
+	ep_free(ep);
+	kfree(ep);
  eexit_1:
  	DNPRINTK(3, (KERN_INFO "[%p] eventpoll: sys_epoll_create(%d) = %d\n",
  		     current, size, error));
@@ -706,7 +706,8 @@
  /*
   * Creates the file descriptor to be used by the epoll interface.
   */
-static int ep_getfd(int *efd, struct inode **einode, struct file **efile)
+static int ep_getfd(int *efd, struct inode **einode, struct file **efile,
+		    struct eventpoll *ep)
  {
  	struct qstr this;
  	char name[32];
@@ -756,7 +757,7 @@
  	file->f_op = &eventpoll_fops;
  	file->f_mode = FMODE_READ;
  	file->f_version = 0;
-	file->private_data = NULL;
+	file->private_data = ep;

  	/* Install the new setup file into the allocated fd. */
  	fd_install(fd, file);
@@ -777,7 +778,7 @@
  }


-static int ep_file_init(struct file *file)
+static int ep_alloc(struct eventpoll **pep)
  {
  	struct eventpoll *ep;

@@ -792,9 +793,9 @@
  	INIT_LIST_HEAD(&ep->rdllist);
  	ep->rbr = RB_ROOT;

-	file->private_data = ep;
+	*pep = ep;

-	DNPRINTK(3, (KERN_INFO "[%p] eventpoll: ep_file_init() ep=%p\n",
+	DNPRINTK(3, (KERN_INFO "[%p] eventpoll: ep_alloc() ep=%p\n",
  		     current, ep));
  	return 0;
  }
