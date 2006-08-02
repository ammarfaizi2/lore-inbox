Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932202AbWHBT6n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932202AbWHBT6n (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 15:58:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932205AbWHBT6n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 15:58:43 -0400
Received: from saraswathi.solana.com ([198.99.130.12]:3204 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S932202AbWHBT6m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 15:58:42 -0400
Message-Id: <200608021958.k72JwHkj005987@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: [PATCH 1/4] UML - SIGIO cleanups
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 02 Aug 2006 15:58:16 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Various cleanups in the sigio code.
Removed explicit zero-initializations of a few structures.
Improved some error messages.
An API change - there was an asymmetry between reactivate_fd calling
maybe_sigio_broken, which goes through all the machinery of figuring
out if a file descriptor supports SIGIO and applying the workaround to
it if not, and deactivate_fd, which just turns off the descriptor.
This is changed so that only activate_fd calls maybe_sigio_broken,
when the descriptor is first seen.  reactivate_fd now calls
add_sigio_fd, which is symmetric with ignore_sigio_fd.  This removes a
recursion which makes a critical section look more critical than it
really was, obsoleting a big comment to that effect.
This requires keeping track of all descriptors which are getting the
SIGIO treatment, not just the ones being polled at any given moment,
so that reactivate_fd, through add_sigio_fd, doesn't try to tell the
SIGIO thread about descriptors it doesn't care about.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.18-rc2-mm1/arch/um/include/os.h
===================================================================
--- linux-2.6.18-rc2-mm1.orig/arch/um/include/os.h	2006-08-01 13:10:20.000000000 -0400
+++ linux-2.6.18-rc2-mm1/arch/um/include/os.h	2006-08-01 13:12:44.000000000 -0400
@@ -329,6 +329,7 @@ extern void os_set_ioignore(void);
 extern void init_irq_signals(int on_sigstack);
 
 /* sigio.c */
+extern int add_sigio_fd(int fd);
 extern int ignore_sigio_fd(int fd);
 extern void maybe_sigio_broken(int fd, int read);
 
Index: linux-2.6.18-rc2-mm1/arch/um/kernel/irq.c
===================================================================
--- linux-2.6.18-rc2-mm1.orig/arch/um/kernel/irq.c	2006-08-01 13:10:20.000000000 -0400
+++ linux-2.6.18-rc2-mm1/arch/um/kernel/irq.c	2006-08-01 13:12:44.000000000 -0400
@@ -142,19 +142,6 @@ int activate_fd(int irq, int fd, int typ
 				     .events 		= events,
 				     .current_events 	= 0 } );
 
-	/* Critical section - locked by a spinlock because this stuff can
-	 * be changed from interrupt handlers.  The stuff above is done
-	 * outside the lock because it allocates memory.
-	 */
-
-	/* Actually, it only looks like it can be called from interrupt
-	 * context.  The culprit is reactivate_fd, which calls
-	 * maybe_sigio_broken, which calls write_sigio_workaround,
-	 * which calls activate_fd.  However, write_sigio_workaround should
-	 * only be called once, at boot time.  That would make it clear that
-	 * this is called only from process context, and can be locked with
-	 * a semaphore.
-	 */
 	spin_lock_irqsave(&irq_lock, flags);
 	for (irq_fd = active_fds; irq_fd != NULL; irq_fd = irq_fd->next) {
 		if ((irq_fd->fd == fd) && (irq_fd->type == type)) {
@@ -165,7 +152,6 @@ int activate_fd(int irq, int fd, int typ
 		}
 	}
 
-	/*-------------*/
 	if (type == IRQ_WRITE)
 		fd = -1;
 
@@ -198,7 +184,6 @@ int activate_fd(int irq, int fd, int typ
 
 		spin_lock_irqsave(&irq_lock, flags);
 	}
-	/*-------------*/
 
 	*last_irq_ptr = new_fd;
 	last_irq_ptr = &new_fd->next;
@@ -210,14 +195,14 @@ int activate_fd(int irq, int fd, int typ
 	 */
 	maybe_sigio_broken(fd, (type == IRQ_READ));
 
-	return(0);
+	return 0;
 
  out_unlock:
 	spin_unlock_irqrestore(&irq_lock, flags);
  out_kfree:
 	kfree(new_fd);
  out:
-	return(err);
+	return err;
 }
 
 static void free_irq_by_cb(int (*test)(struct irq_fd *, void *), void *arg)
@@ -302,10 +287,7 @@ void reactivate_fd(int fd, int irqnum)
 	os_set_pollfd(i, irq->fd);
 	spin_unlock_irqrestore(&irq_lock, flags);
 
-	/* This calls activate_fd, so it has to be outside the critical
-	 * section.
-	 */
-	maybe_sigio_broken(fd, (irq->type == IRQ_READ));
+	add_sigio_fd(fd);
 }
 
 void deactivate_fd(int fd, int irqnum)
@@ -316,11 +298,15 @@ void deactivate_fd(int fd, int irqnum)
 
 	spin_lock_irqsave(&irq_lock, flags);
 	irq = find_irq_by_fd(fd, irqnum, &i);
-	if (irq == NULL)
-		goto out;
+	if(irq == NULL){
+		spin_unlock_irqrestore(&irq_lock, flags);
+		return;
+	}
+
 	os_set_pollfd(i, -1);
- out:
 	spin_unlock_irqrestore(&irq_lock, flags);
+
+	ignore_sigio_fd(fd);
 }
 
 int deactivate_all_fds(void)
Index: linux-2.6.18-rc2-mm1/arch/um/os-Linux/sigio.c
===================================================================
--- linux-2.6.18-rc2-mm1.orig/arch/um/os-Linux/sigio.c	2006-08-01 13:10:20.000000000 -0400
+++ linux-2.6.18-rc2-mm1/arch/um/os-Linux/sigio.c	2006-08-01 13:12:44.000000000 -0400
@@ -43,17 +43,9 @@ struct pollfds {
 /* Protected by sigio_lock().  Used by the sigio thread, but the UML thread
  * synchronizes with it.
  */
-static struct pollfds current_poll = {
-	.poll  		= NULL,
-	.size 		= 0,
-	.used 		= 0
-};
-
-static struct pollfds next_poll = {
-	.poll  		= NULL,
-	.size 		= 0,
-	.used 		= 0
-};
+static struct pollfds current_poll;
+static struct pollfds next_poll;
+static struct pollfds all_sigio_fds;
 
 static int write_sigio_thread(void *unused)
 {
@@ -78,7 +70,8 @@ static int write_sigio_thread(void *unus
 				n = os_read_file(sigio_private[1], &c, sizeof(c));
 				if(n != sizeof(c))
 					printk("write_sigio_thread : "
-					       "read failed, err = %d\n", -n);
+					       "read on socket failed, "
+					       "err = %d\n", -n);
 				tmp = current_poll;
 				current_poll = next_poll;
 				next_poll = tmp;
@@ -93,35 +86,36 @@ static int write_sigio_thread(void *unus
 
 			n = os_write_file(respond_fd, &c, sizeof(c));
 			if(n != sizeof(c))
-				printk("write_sigio_thread : write failed, "
-				       "err = %d\n", -n);
+				printk("write_sigio_thread : write on socket "
+				       "failed, err = %d\n", -n);
 		}
 	}
 
 	return 0;
 }
 
-static int need_poll(int n)
+static int need_poll(struct pollfds *polls, int n)
 {
-	if(n <= next_poll.size){
-		next_poll.used = n;
-		return(0);
-	}
-	kfree(next_poll.poll);
-	next_poll.poll = um_kmalloc_atomic(n * sizeof(struct pollfd));
-	if(next_poll.poll == NULL){
+	if(n <= polls->size){
+		polls->used = n;
+		return 0;
+	}
+	kfree(polls->poll);
+	polls->poll = um_kmalloc_atomic(n * sizeof(struct pollfd));
+	if(polls->poll == NULL){
 		printk("need_poll : failed to allocate new pollfds\n");
-		next_poll.size = 0;
-		next_poll.used = 0;
-		return(-1);
-	}
-	next_poll.size = n;
-	next_poll.used = n;
-	return(0);
+		polls->size = 0;
+		polls->used = 0;
+		return -ENOMEM;
+	}
+	polls->size = n;
+	polls->used = n;
+	return 0;
 }
 
 /* Must be called with sigio_lock held, because it's needed by the marked
- * critical section. */
+ * critical section.
+ */
 static void update_thread(void)
 {
 	unsigned long flags;
@@ -156,34 +150,39 @@ static void update_thread(void)
 	set_signals(flags);
 }
 
-static int add_sigio_fd(int fd, int read)
+int add_sigio_fd(int fd)
 {
-	int err = 0, i, n, events;
+	struct pollfd *p;
+	int err = 0, i, n;
 
 	sigio_lock();
+	for(i = 0; i < all_sigio_fds.used; i++){
+		if(all_sigio_fds.poll[i].fd == fd)
+			break;
+	}
+	if(i == all_sigio_fds.used)
+		goto out;
+
+	p = &all_sigio_fds.poll[i];
+
 	for(i = 0; i < current_poll.used; i++){
 		if(current_poll.poll[i].fd == fd)
 			goto out;
 	}
 
 	n = current_poll.used + 1;
-	err = need_poll(n);
+	err = need_poll(&next_poll, n);
 	if(err)
 		goto out;
 
 	for(i = 0; i < current_poll.used; i++)
 		next_poll.poll[i] = current_poll.poll[i];
 
-	if(read) events = POLLIN;
-	else events = POLLOUT;
-
-	next_poll.poll[n - 1] = ((struct pollfd) { .fd  	= fd,
-						   .events 	= events,
-						   .revents 	= 0 });
+	next_poll.poll[n - 1] = *p;
 	update_thread();
  out:
 	sigio_unlock();
-	return(err);
+	return err;
 }
 
 int ignore_sigio_fd(int fd)
@@ -205,18 +204,14 @@ int ignore_sigio_fd(int fd)
 	if(i == current_poll.used)
 		goto out;
 
-	err = need_poll(current_poll.used - 1);
+	err = need_poll(&next_poll, current_poll.used - 1);
 	if(err)
 		goto out;
 
 	for(i = 0; i < current_poll.used; i++){
 		p = &current_poll.poll[i];
-		if(p->fd != fd) next_poll.poll[n++] = current_poll.poll[i];
-	}
-	if(n == i){
-		printk("ignore_sigio_fd : fd %d not found\n", fd);
-		err = -1;
-		goto out;
+		if(p->fd != fd)
+			next_poll.poll[n++] = *p;
 	}
 
 	update_thread();
@@ -234,7 +229,7 @@ static struct pollfd *setup_initial_poll
 		printk("setup_initial_poll : failed to allocate poll\n");
 		return NULL;
 	}
-	*p = ((struct pollfd) { .fd  	= fd,
+	*p = ((struct pollfd) { .fd		= fd,
 				.events 	= POLLIN,
 				.revents 	= 0 });
 	return p;
@@ -323,6 +318,8 @@ out_close1:
 
 void maybe_sigio_broken(int fd, int read)
 {
+	int err;
+
 	if(!isatty(fd))
 		return;
 
@@ -330,7 +327,19 @@ void maybe_sigio_broken(int fd, int read
 		return;
 
 	write_sigio_workaround();
-	add_sigio_fd(fd, read);
+
+	sigio_lock();
+	err = need_poll(&all_sigio_fds, all_sigio_fds.used + 1);
+	if(err){
+		printk("maybe_sigio_broken - failed to add pollfd\n");
+		goto out;
+	}
+	all_sigio_fds.poll[all_sigio_fds.used++] =
+		((struct pollfd) { .fd  	= fd,
+				   .events 	= read ? POLLIN : POLLOUT,
+				   .revents 	= 0 });
+out:
+	sigio_unlock();
 }
 
 static void sigio_cleanup(void)

