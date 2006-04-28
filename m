Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751727AbWD1RCE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751727AbWD1RCE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Apr 2006 13:02:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751671AbWD1RAx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Apr 2006 13:00:53 -0400
Received: from [198.99.130.12] ([198.99.130.12]:34264 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S1751703AbWD1RAe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Apr 2006 13:00:34 -0400
Message-Id: <200604281601.k3SG17rV007527@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net,
       Jesper Juhl <jesper.juhl@gmail.com>
Subject: [PATCH 3/6] UML - remove NULL checks and add some CodingStyle
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 28 Apr 2006 12:01:07 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jesper Juhl <jesper.juhl@gmail.com>

Remove redundant NULL checks before [kv]free + small CodingStyle cleanup
for arch/

Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.16/arch/um/kernel/irq.c
===================================================================
--- linux-2.6.16.orig/arch/um/kernel/irq.c	2006-04-27 18:40:27.000000000 -0400
+++ linux-2.6.16/arch/um/kernel/irq.c	2006-04-27 19:00:34.000000000 -0400
@@ -89,16 +89,18 @@ void sigio_handler(int sig, union uml_pt
 	struct irq_fd *irq_fd;
 	int n;
 
-	if(smp_sigio_handler()) return;
-	while(1){
+	if (smp_sigio_handler())
+		return;
+
+	while (1) {
 		n = os_waiting_for_events(active_fds);
 		if (n <= 0) {
 			if(n == -EINTR) continue;
 			else break;
 		}
 
-		for(irq_fd = active_fds; irq_fd != NULL; irq_fd = irq_fd->next){
-			if(irq_fd->current_events != 0){
+		for (irq_fd = active_fds; irq_fd != NULL; irq_fd = irq_fd->next) {
+			if (irq_fd->current_events != 0) {
 				irq_fd->current_events = 0;
 				do_IRQ(irq_fd->irq, regs);
 			}
@@ -110,19 +112,17 @@ void sigio_handler(int sig, union uml_pt
 
 static void maybe_sigio_broken(int fd, int type)
 {
-	if(os_isatty(fd)){
-		if((type == IRQ_WRITE) && !pty_output_sigio){
+	if (os_isatty(fd)) {
+		if ((type == IRQ_WRITE) && !pty_output_sigio) {
 			write_sigio_workaround();
 			add_sigio_fd(fd, 0);
-		}
-		else if((type == IRQ_READ) && !pty_close_sigio){
+		} else if ((type == IRQ_READ) && !pty_close_sigio) {
 			write_sigio_workaround();
 			add_sigio_fd(fd, 1);
 		}
 	}
 }
 
-
 int activate_fd(int irq, int fd, int type, void *dev_id)
 {
 	struct pollfd *tmp_pfd;
@@ -132,16 +132,18 @@ int activate_fd(int irq, int fd, int typ
 
 	pid = os_getpid();
 	err = os_set_fd_async(fd, pid);
-	if(err < 0)
+	if (err < 0)
 		goto out;
 
 	new_fd = um_kmalloc(sizeof(*new_fd));
 	err = -ENOMEM;
-	if(new_fd == NULL)
+	if (new_fd == NULL)
 		goto out;
 
-	if(type == IRQ_READ) events = UM_POLLIN | UM_POLLPRI;
-	else events = UM_POLLOUT;
+	if (type == IRQ_READ)
+		events = UM_POLLIN | UM_POLLPRI;
+	else
+		events = UM_POLLOUT;
 	*new_fd = ((struct irq_fd) { .next  		= NULL,
 				     .id 		= dev_id,
 				     .fd 		= fd,
@@ -165,8 +167,8 @@ int activate_fd(int irq, int fd, int typ
 	 * a semaphore.
 	 */
 	flags = irq_lock();
-	for(irq_fd = active_fds; irq_fd != NULL; irq_fd = irq_fd->next){
-		if((irq_fd->fd == fd) && (irq_fd->type == type)){
+	for (irq_fd = active_fds; irq_fd != NULL; irq_fd = irq_fd->next) {
+		if ((irq_fd->fd == fd) && (irq_fd->type == type)) {
 			printk("Registering fd %d twice\n", fd);
 			printk("Irqs : %d, %d\n", irq_fd->irq, irq);
 			printk("Ids : 0x%p, 0x%p\n", irq_fd->id, dev_id);
@@ -175,13 +177,13 @@ int activate_fd(int irq, int fd, int typ
 	}
 
 	/*-------------*/
-	if(type == IRQ_WRITE)
+	if (type == IRQ_WRITE)
 		fd = -1;
 
 	tmp_pfd = NULL;
 	n = 0;
 
-	while(1){
+	while (1) {
 		n = os_create_pollfd(fd, events, tmp_pfd, n);
 		if (n == 0)
 			break;
@@ -198,10 +200,8 @@ int activate_fd(int irq, int fd, int typ
 		 * then we free the buffer tmp_fds and try again.
 		 */
 		irq_unlock(flags);
-		if (tmp_pfd != NULL) {
-			kfree(tmp_pfd);
-			tmp_pfd = NULL;
-		}
+		kfree(tmp_pfd);
+		tmp_pfd = NULL;
 
 		tmp_pfd = um_kmalloc(n);
 		if (tmp_pfd == NULL)
@@ -249,7 +249,7 @@ static int same_irq_and_dev(struct irq_f
 {
 	struct irq_and_dev *data = d;
 
-	return((irq->irq == data->irq) && (irq->id == data->dev));
+	return ((irq->irq == data->irq) && (irq->id == data->dev));
 }
 
 void free_irq_by_irq_and_dev(unsigned int irq, void *dev)
@@ -262,7 +262,7 @@ void free_irq_by_irq_and_dev(unsigned in
 
 static int same_fd(struct irq_fd *irq, void *fd)
 {
-	return(irq->fd == *((int *) fd));
+	return (irq->fd == *((int *)fd));
 }
 
 void free_irq_by_fd(int fd)
@@ -276,16 +276,17 @@ static struct irq_fd *find_irq_by_fd(int
 	int i = 0;
 	int fdi;
 
-	for(irq=active_fds; irq != NULL; irq = irq->next){
-		if((irq->fd == fd) && (irq->irq == irqnum)) break;
+	for (irq = active_fds; irq != NULL; irq = irq->next) {
+		if ((irq->fd == fd) && (irq->irq == irqnum))
+			break;
 		i++;
 	}
-	if(irq == NULL){
+	if (irq == NULL) {
 		printk("find_irq_by_fd doesn't have descriptor %d\n", fd);
 		goto out;
 	}
 	fdi = os_get_pollfd(i);
-	if((fdi != -1) && (fdi != fd)){
+	if ((fdi != -1) && (fdi != fd)) {
 		printk("find_irq_by_fd - mismatch between active_fds and "
 		       "pollfds, fd %d vs %d, need %d\n", irq->fd,
 		       fdi, fd);
@@ -294,7 +295,7 @@ static struct irq_fd *find_irq_by_fd(int
 	}
 	*index_out = i;
  out:
-	return(irq);
+	return irq;
 }
 
 void reactivate_fd(int fd, int irqnum)
@@ -305,7 +306,7 @@ void reactivate_fd(int fd, int irqnum)
 
 	flags = irq_lock();
 	irq = find_irq_by_fd(fd, irqnum, &i);
-	if(irq == NULL){
+	if (irq == NULL) {
 		irq_unlock(flags);
 		return;
 	}
@@ -326,7 +327,7 @@ void deactivate_fd(int fd, int irqnum)
 
 	flags = irq_lock();
 	irq = find_irq_by_fd(fd, irqnum, &i);
-	if(irq == NULL)
+	if (irq == NULL)
 		goto out;
 	os_set_pollfd(i, -1);
  out:
@@ -338,15 +339,15 @@ int deactivate_all_fds(void)
 	struct irq_fd *irq;
 	int err;
 
-	for(irq=active_fds;irq != NULL;irq = irq->next){
+	for (irq = active_fds; irq != NULL; irq = irq->next) {
 		err = os_clear_fd_async(irq->fd);
-		if(err)
-			return(err);
+		if (err)
+			return err;
 	}
 	/* If there is a signal already queued, after unblocking ignore it */
 	os_set_ioignore();
 
-	return(0);
+	return 0;
 }
 
 void forward_interrupts(int pid)
@@ -356,9 +357,9 @@ void forward_interrupts(int pid)
 	int err;
 
 	flags = irq_lock();
-	for(irq=active_fds;irq != NULL;irq = irq->next){
+	for (irq = active_fds; irq != NULL; irq = irq->next) {
 		err = os_set_owner(irq->fd, pid);
-		if(err < 0){
+		if (err < 0) {
 			/* XXX Just remove the irq rather than
 			 * print out an infinite stream of these
 			 */
@@ -379,7 +380,7 @@ void forward_interrupts(int pid)
 unsigned int do_IRQ(int irq, union uml_pt_regs *regs)
 {
        irq_enter();
-       __do_IRQ(irq, (struct pt_regs *) regs);
+       __do_IRQ(irq, (struct pt_regs *)regs);
        irq_exit();
        return 1;
 }
@@ -392,12 +393,12 @@ int um_request_irq(unsigned int irq, int
 	int err;
 
 	err = request_irq(irq, handler, irqflags, devname, dev_id);
-	if(err)
-		return(err);
+	if (err)
+		return err;
 
-	if(fd != -1)
+	if (fd != -1)
 		err = activate_fd(irq, fd, type, dev_id);
-	return(err);
+	return err;
 }
 EXPORT_SYMBOL(um_request_irq);
 EXPORT_SYMBOL(reactivate_fd);
@@ -409,7 +410,7 @@ unsigned long irq_lock(void)
 	unsigned long flags;
 
 	spin_lock_irqsave(&irq_spinlock, flags);
-	return(flags);
+	return flags;
 }
 
 void irq_unlock(unsigned long flags)
@@ -452,7 +453,7 @@ void __init init_IRQ(void)
 	irq_desc[TIMER_IRQ].depth = 1;
 	irq_desc[TIMER_IRQ].handler = &SIGVTALRM_irq_type;
 	enable_irq(TIMER_IRQ);
-	for(i=1;i<NR_IRQS;i++){
+	for (i = 1; i < NR_IRQS; i++) {
 		irq_desc[i].status = IRQ_DISABLED;
 		irq_desc[i].action = NULL;
 		irq_desc[i].depth = 1;
@@ -467,7 +468,7 @@ int init_aio_irq(int irq, char *name, ir
 	int fds[2], err;
 
 	err = os_pipe(fds, 1, 1);
-	if(err){
+	if (err) {
 		printk("init_aio_irq - os_pipe failed, err = %d\n", -err);
 		goto out;
 	}
@@ -475,7 +476,7 @@ int init_aio_irq(int irq, char *name, ir
 	err = um_request_irq(irq, fds[0], IRQ_READ, handler,
 			     SA_INTERRUPT | SA_SAMPLE_RANDOM, name,
 			     (void *) (long) fds[0]);
-	if(err){
+	if (err) {
 		printk("init_aio_irq - : um_request_irq failed, err = %d\n",
 		       err);
 		goto out_close;
@@ -488,5 +489,5 @@ int init_aio_irq(int irq, char *name, ir
 	os_close_file(fds[0]);
 	os_close_file(fds[1]);
  out:
-	return(err);
+	return err;
 }
Index: linux-2.6.16/arch/um/os-Linux/irq.c
===================================================================
--- linux-2.6.16.orig/arch/um/os-Linux/irq.c	2006-04-27 18:57:09.000000000 -0400
+++ linux-2.6.16/arch/um/os-Linux/irq.c	2006-04-27 19:00:34.000000000 -0400
@@ -29,21 +29,21 @@ int os_waiting_for_events(struct irq_fd 
 	int i, n, err;
 
 	n = poll(pollfds, pollfds_num, 0);
-	if(n < 0){
+	if (n < 0) {
 		err = -errno;
-		if(errno != EINTR)
+		if (errno != EINTR)
 			printk("sigio_handler: os_waiting_for_events:"
 			       " poll returned %d, errno = %d\n", n, errno);
 		return err;
 	}
 
-	if(n == 0)
+	if (n == 0)
 		return 0;
 
 	irq_fd = active_fds;
 
-	for(i = 0; i < pollfds_num; i++){
-		if(pollfds[i].revents != 0){
+	for (i = 0; i < pollfds_num; i++) {
+		if (pollfds[i].revents != 0) {
 			irq_fd->current_events = pollfds[i].revents;
 			pollfds[i].fd = -1;
 		}
@@ -54,7 +54,7 @@ int os_waiting_for_events(struct irq_fd 
 
 int os_isatty(int fd)
 {
-	return(isatty(fd));
+	return isatty(fd);
 }
 
 int os_create_pollfd(int fd, int events, void *tmp_pfd, int size_tmpfds)
@@ -65,7 +65,7 @@ int os_create_pollfd(int fd, int events,
 			return((pollfds_size + 1) * sizeof(pollfds[0]));
 		}
 
-		if(pollfds != NULL){
+		if (pollfds != NULL) {
 			memcpy(tmp_pfd, pollfds,
 			       sizeof(pollfds[0]) * pollfds_size);
 			/* remove old pollfds */
@@ -73,18 +73,15 @@ int os_create_pollfd(int fd, int events,
 		}
 		pollfds = tmp_pfd;
 		pollfds_size++;
-	} else {
-		/* remove not used tmp_pfd */
-		if (tmp_pfd != NULL)
-			kfree(tmp_pfd);
-	}
+	} else
+		kfree(tmp_pfd);	/* remove not used tmp_pfd */
 
-	pollfds[pollfds_num] = ((struct pollfd) { .fd 	= fd,
-						  .events 	= events,
-						  .revents 	= 0 });
+	pollfds[pollfds_num] = ((struct pollfd) { .fd		= fd,
+						  .events	= events,
+						  .revents	= 0 });
 	pollfds_num++;
 
-	return(0);
+	return 0;
 }
 
 void os_free_irq_by_cb(int (*test)(struct irq_fd *, void *), void *arg,
@@ -94,11 +91,11 @@ void os_free_irq_by_cb(int (*test)(struc
 	int i = 0;
 
 	prev = &active_fds;
-	while(*prev != NULL){
-		if((*test)(*prev, arg)){
+	while (*prev != NULL) {
+		if ((*test)(*prev, arg)) {
 			struct irq_fd *old_fd = *prev;
-			if((pollfds[i].fd != -1) &&
-			   (pollfds[i].fd != (*prev)->fd)){
+			if ((pollfds[i].fd != -1) &&
+			    (pollfds[i].fd != (*prev)->fd)) {
 				printk("os_free_irq_by_cb - mismatch between "
 				       "active_fds and pollfds, fd %d vs %d\n",
 				       (*prev)->fd, pollfds[i].fd);
@@ -110,7 +107,6 @@ void os_free_irq_by_cb(int (*test)(struc
 			/* This moves the *whole* array after pollfds[i]
 			 * (though it doesn't spot as such)!
 			 */
-
 			memmove(&pollfds[i], &pollfds[i + 1],
 			       (pollfds_num - i) * sizeof(pollfds[0]));
 			if(*last_irq_ptr2 == &old_fd->next)
@@ -129,10 +125,9 @@ void os_free_irq_by_cb(int (*test)(struc
 	return;
 }
 
-
 int os_get_pollfd(int i)
 {
-	return(pollfds[i].fd);
+	return pollfds[i].fd;
 }
 
 void os_set_pollfd(int i, int fd)
@@ -151,8 +146,10 @@ void init_irq_signals(int on_sigstack)
 	int flags;
 
 	flags = on_sigstack ? SA_ONSTACK : 0;
-	if(timer_irq_inited) h = (__sighandler_t) alarm_handler;
-	else h = boot_timer_handler;
+	if (timer_irq_inited)
+		h = (__sighandler_t)alarm_handler;
+	else
+		h = boot_timer_handler;
 
 	set_handler(SIGVTALRM, h, flags | SA_RESTART,
 		    SIGUSR1, SIGIO, SIGWINCH, SIGALRM, -1);

