Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932427AbVJYWFd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932427AbVJYWFd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Oct 2005 18:05:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932436AbVJYWFd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Oct 2005 18:05:33 -0400
Received: from [151.97.230.9] ([151.97.230.9]:53221 "EHLO ssc.unict.it")
	by vger.kernel.org with ESMTP id S932427AbVJYWFc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Oct 2005 18:05:32 -0400
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Subject: [PATCH 01/11] uml: sigio code - reduce spinlock hold time
Date: Wed, 26 Oct 2005 00:00:55 +0200
To: Jeff Dike <jdike@addtoit.com>
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Message-Id: <20051025220053.20010.56979.stgit@zion.home.lan>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

In a previous patch I shifted an allocation to being atomic.

In this patch, a better but more intrusive solution is implemented, i.e. hold
the lock only when really needing it, especially not over pipe operations, nor
over the culprit allocation.

Additionally, while at it, add a missing kfree in the failure path, and make
sure that if we fail in forking, write_sigio_pid is -1 and not, say, -ENOMEM.

And fix whitespace, at least for things I was touching anyway.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/um/kernel/sigio_user.c |   84 ++++++++++++++++++++++++++++++-------------
 1 files changed, 59 insertions(+), 25 deletions(-)

diff --git a/arch/um/kernel/sigio_user.c b/arch/um/kernel/sigio_user.c
--- a/arch/um/kernel/sigio_user.c
+++ b/arch/um/kernel/sigio_user.c
@@ -336,70 +336,104 @@ int ignore_sigio_fd(int fd)
 	return(err);
 }
 
-static int setup_initial_poll(int fd)
+static struct pollfd* setup_initial_poll(int fd)
 {
 	struct pollfd *p;
 
-	p = um_kmalloc_atomic(sizeof(struct pollfd));
-	if(p == NULL){
+	p = um_kmalloc(sizeof(struct pollfd));
+	if (p == NULL) {
 		printk("setup_initial_poll : failed to allocate poll\n");
-		return(-1);
+		return NULL;
 	}
 	*p = ((struct pollfd) { .fd  	= fd,
 				.events 	= POLLIN,
 				.revents 	= 0 });
-	current_poll = ((struct pollfds) { .poll 	= p,
-					   .used 	= 1,
-					   .size 	= 1 });
-	return(0);
+	return p;
 }
 
 void write_sigio_workaround(void)
 {
 	unsigned long stack;
+	struct pollfd *p;
 	int err;
+	int l_write_sigio_fds[2];
+	int l_sigio_private[2];
+	int l_write_sigio_pid;
 
+	/* We call this *tons* of times - and most ones we must just fail. */
 	sigio_lock();
-	if(write_sigio_pid != -1)
-		goto out;
+	l_write_sigio_pid = write_sigio_pid;
+	sigio_unlock();
+
+	if (l_write_sigio_pid != -1)
+		return;
 
-	err = os_pipe(write_sigio_fds, 1, 1);
+	err = os_pipe(l_write_sigio_fds, 1, 1);
 	if(err < 0){
 		printk("write_sigio_workaround - os_pipe 1 failed, "
 		       "err = %d\n", -err);
-		goto out;
+		return;
 	}
-	err = os_pipe(sigio_private, 1, 1);
+	err = os_pipe(l_sigio_private, 1, 1);
 	if(err < 0){
-		printk("write_sigio_workaround - os_pipe 2 failed, "
+		printk("write_sigio_workaround - os_pipe 1 failed, "
 		       "err = %d\n", -err);
 		goto out_close1;
 	}
-	if(setup_initial_poll(sigio_private[1]))
+
+	p = setup_initial_poll(l_sigio_private[1]);
+	if(!p)
 		goto out_close2;
 
-	write_sigio_pid = run_helper_thread(write_sigio_thread, NULL, 
+	sigio_lock();
+
+	/* Did we race? Don't try to optimize this, please, it's not so likely
+	 * to happen, and no more than once at the boot. */
+	if(write_sigio_pid != -1)
+		goto out_unlock;
+
+	write_sigio_pid = run_helper_thread(write_sigio_thread, NULL,
 					    CLONE_FILES | CLONE_VM, &stack, 0);
 
-	if(write_sigio_pid < 0) goto out_close2;
+	if (write_sigio_pid < 0)
+		goto out_clear;
 
-	if(write_sigio_irq(write_sigio_fds[0])) 
+	if (write_sigio_irq(l_write_sigio_fds[0])) 
 		goto out_kill;
 
- out:
+	/* Success, finally. */
+	memcpy(write_sigio_fds, l_write_sigio_fds, sizeof(l_write_sigio_fds));
+	memcpy(sigio_private, l_sigio_private, sizeof(l_sigio_private));
+
+	current_poll = ((struct pollfds) { .poll 	= p,
+					   .used 	= 1,
+					   .size 	= 1 });
+
 	sigio_unlock();
 	return;
 
  out_kill:
-	os_kill_process(write_sigio_pid, 1);
+	l_write_sigio_pid = write_sigio_pid;
+	write_sigio_pid = -1;
+	sigio_unlock();
+	/* Going to call waitpid, avoid holding the lock. */
+	os_kill_process(l_write_sigio_pid, 1);
+	goto out_free;
+
+ out_clear:
 	write_sigio_pid = -1;
+ out_unlock:
+	sigio_unlock();
+ out_free:
+	kfree(p);
  out_close2:
-	os_close_file(sigio_private[0]);
-	os_close_file(sigio_private[1]);
+	os_close_file(l_sigio_private[0]);
+	os_close_file(l_sigio_private[1]);
  out_close1:
-	os_close_file(write_sigio_fds[0]);
-	os_close_file(write_sigio_fds[1]);
-	sigio_unlock();
+	os_close_file(l_write_sigio_fds[0]);
+	os_close_file(l_write_sigio_fds[1]);
+	return;
+
 }
 
 int read_sigio_fd(int fd)

