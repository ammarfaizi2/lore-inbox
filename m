Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129756AbQKMXBj>; Mon, 13 Nov 2000 18:01:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129230AbQKMXB3>; Mon, 13 Nov 2000 18:01:29 -0500
Received: from imladris.demon.co.uk ([193.237.130.41]:20741 "EHLO
	imladris.demon.co.uk") by vger.kernel.org with ESMTP
	id <S129756AbQKMXBL>; Mon, 13 Nov 2000 18:01:11 -0500
Date: Mon, 13 Nov 2000 22:30:56 +0000 (GMT)
From: David Woodhouse <dwmw2@infradead.org>
To: David Hinds <dhinds@valinux.com>
cc: Jeff Garzik <jgarzik@mandrakesoft.com>, <torvalds@transmeta.com>,
        <tytso@valinux.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] pcmcia event thread. (fwd)
In-Reply-To: <20001113105931.C1587@valinux.com>
Message-ID: <Pine.LNX.4.30.0011132222070.28525-100000@imladris.demon.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Nov 2000, David Hinds wrote:

> The i82365 and tcic drivers in the 2.4 tree have not been converted to
> use the thread stuff; as far as I know, the yenta driver is the only
> socket driver that works at all in 2.4.
>
> On Mon, Nov 13, 2000 at 09:52:30PM +0000, David Woodhouse wrote:
> > OK. I take it you support my proposed change?
> > Can you review this patch for i82365.c?
>
> It looks reasonable and straighforward to me.

Cool. Linus, please could you apply this patch. If the fact that i82365
and tcic are broken in 2.4 isn't on Ted's critical list, then I think it
probably ought to have been - and this should fix it.

As before, this causes the PCMCIA core code to start a kernel thread
solely for the purpose of running a queue of tasks submitted by random
drivers. It also now converts the tcic and i82365 driver to use it, rather
than just causing the machine to panic by calling parse_events() from
interrupt context.

There's still a small amount of duplicated code, but far less than before,
and I think the flexibility of making a task queue available rather than
just accepting event submission asynchronously is probably going to be
worth it.


Index: include/pcmcia/cs.h
===================================================================
RCS file: /net/passion/inst/cvs/linux/include/pcmcia/Attic/cs.h,v
retrieving revision 1.1.2.8
diff -u -r1.1.2.8 cs.h
--- include/pcmcia/cs.h	2000/09/07 08:26:16	1.1.2.8
+++ include/pcmcia/cs.h	2000/11/13 22:21:39
@@ -443,6 +443,7 @@
 int pcmcia_map_mem_page(window_handle_t win, memreq_t *req);
 int pcmcia_modify_configuration(client_handle_t handle, modconf_t *mod);
 int pcmcia_modify_window(window_handle_t win, modwin_t *req);
+void pcmcia_queue_task(struct tq_struct *task);
 int pcmcia_register_client(client_handle_t *handle, client_reg_t *req);
 int pcmcia_release_configuration(client_handle_t handle);
 int pcmcia_release_io(client_handle_t handle, io_req_t *req);
Index: drivers/pcmcia/cs.c
===================================================================
RCS file: /net/passion/inst/cvs/linux/drivers/pcmcia/Attic/cs.c,v
retrieving revision 1.1.2.28
diff -u -r1.1.2.28 cs.c
--- drivers/pcmcia/cs.c	2000/11/10 14:56:32	1.1.2.28
+++ drivers/pcmcia/cs.c	2000/11/13 22:21:41
@@ -2333,6 +2333,60 @@

 /*======================================================================

+    Kernel thread for submitting events on behalf of interrupt handlers
+
+======================================================================*/
+static int event_thread_leaving = 0;
+static DECLARE_TASK_QUEUE(tq_pcmcia);
+static DECLARE_WAIT_QUEUE_HEAD(event_thread_wq);
+static DECLARE_MUTEX_LOCKED(event_thread_exit_sem);
+
+static int pcmcia_event_thread(void * dummy)
+{
+	DECLARE_WAITQUEUE(wait, current);
+
+	daemonize();
+        strcpy(current->comm, "kpcmciad");
+        spin_lock_irq(&current->sigmask_lock);
+        sigfillset(&current->blocked);
+        recalc_sigpending(current);
+        spin_unlock_irq(&current->sigmask_lock);
+
+	while(!event_thread_leaving) {
+		void *active;
+
+		set_current_state(TASK_INTERRUPTIBLE);
+		add_wait_queue(&event_thread_wq, &wait);
+
+		/* We don't really need locking because it'll be
+		   an atomic copy - but we do need the implied mb()
+		*/
+		spin_lock(&tqueue_lock);
+		active = tq_pcmcia;
+		spin_unlock(&tqueue_lock);
+
+		if (!active)
+			schedule();
+
+		set_current_state(TASK_RUNNING);
+		remove_wait_queue(&event_thread_wq, &wait);
+
+		run_task_queue(&tq_pcmcia);
+	}
+
+	/* Need up_and_exit() */
+	up(&event_thread_exit_sem);
+	return 0;
+}
+
+void pcmcia_queue_task(struct tq_struct *task)
+{
+	queue_task(task, &tq_pcmcia);
+	wake_up(&event_thread_wq);
+}
+
+/*======================================================================
+
     OS-specific module glue goes here

 ======================================================================*/
@@ -2366,6 +2420,7 @@
 EXPORT_SYMBOL(pcmcia_modify_window);
 EXPORT_SYMBOL(pcmcia_open_memory);
 EXPORT_SYMBOL(pcmcia_parse_tuple);
+EXPORT_SYMBOL(pcmcia_queue_task);
 EXPORT_SYMBOL(pcmcia_read_memory);
 EXPORT_SYMBOL(pcmcia_register_client);
 EXPORT_SYMBOL(pcmcia_register_erase_queue);
@@ -2403,9 +2458,19 @@

 static int __init init_pcmcia_cs(void)
 {
+    int pid;
     printk(KERN_INFO "%s\n", release);
     printk(KERN_INFO "  %s\n", options);
     DEBUG(0, "%s\n", version);
+
+    /* Start the thread for handling queued events for socket drivers */
+    pid = kernel_thread (pcmcia_event_thread, NULL, CLONE_FS | CLONE_FILES);
+
+    if (pid < 0) {
+	    printk(KERN_ERR "init_pcmcia_cs: fork failed: errno %d\n", -pid);
+	    return pid;
+    }
+
     if (do_apm)
 	pm_register(PM_SYS_DEV, PM_SYS_PCMCIA, handle_pm_event);
 #ifdef CONFIG_PROC_FS
@@ -2417,6 +2482,14 @@
 static void __exit exit_pcmcia_cs(void)
 {
     printk(KERN_INFO "unloading PCMCIA Card Services\n");
+
+    /* Tell the event thread to die */
+    event_thread_leaving = 1;
+    wake_up(&event_thread_wq);
+
+    /* Wait for it... */
+    down(&event_thread_exit_sem);
+
 #ifdef CONFIG_PROC_FS
     if (proc_pccard) {
 	remove_proc_entry("pccard", proc_bus);
Index: drivers/pcmcia/i82365.c
===================================================================
RCS file: /net/passion/inst/cvs/linux/drivers/pcmcia/Attic/i82365.c,v
retrieving revision 1.1.2.14
diff -u -r1.1.2.14 i82365.c
--- drivers/pcmcia/i82365.c	2000/06/07 14:48:18	1.1.2.14
+++ drivers/pcmcia/i82365.c	2000/11/13 22:21:43
@@ -859,6 +859,26 @@

 /*====================================================================*/

+static u_int pending_events[8] = {0,0,0,0,0,0,0,0};
+static spinlock_t pending_event_lock = SPIN_LOCK_UNLOCKED;
+
+static void pcic_bh(void *dummy)
+{
+	u_int events;
+	int i;
+
+	for (i=0; i < sockets; i++) {
+		spin_lock_irq(&pending_event_lock);
+		events = pending_events[i];
+		pending_events[i] = 0;
+		spin_unlock_irq(&pending_event_lock);
+		if (socket[i].handler)
+			socket[i].handler(socket[i].info, events);
+	}
+}
+
+static struct tq_struct pcic_task = {0, 0, &pcic_bh, NULL};
+
 static void pcic_interrupt(int irq, void *dev,
 				    struct pt_regs *regs)
 {
@@ -893,8 +913,13 @@
 	    }
 	    ISA_UNLOCK(i, flags);
 	    DEBUG(2, "i82365: socket %d event 0x%02x\n", i, events);
-	    if (events)
-		socket[i].handler(socket[i].info, events);
+
+	    if (events) {
+		    spin_lock(&pending_event_lock);
+		    pending_events[i] |= events;
+		    spin_unlock(&pending_event_lock);
+		    pcmcia_queue_task(&pcic_task);
+	    }
 	    active |= events;
 	}
 	if (!active) break;
Index: drivers/pcmcia/tcic.c
===================================================================
RCS file: /net/passion/inst/cvs/linux/drivers/pcmcia/Attic/tcic.c,v
retrieving revision 1.1.2.9
diff -u -r1.1.2.9 tcic.c
--- drivers/pcmcia/tcic.c	2000/06/07 14:48:18	1.1.2.9
+++ drivers/pcmcia/tcic.c	2000/11/13 22:21:44
@@ -530,6 +530,26 @@

 /*====================================================================*/

+static u_int pending_events[2] = {0,0};
+static spinlock_t pending_event_lock = SPIN_LOCK_UNLOCKED;
+
+static void tcic_bh(void *dummy)
+{
+	u_int events;
+	int i;
+
+	for (i=0; i < sockets; i++) {
+		spin_lock_irq(&pending_event_lock);
+		events = pending_events[i];
+		pending_events[i] = 0;
+		spin_unlock_irq(&pending_event_lock);
+		if (socket_table[i].handler)
+			socket_table[i].handler(socket_table[i].info, events);
+	}
+}
+
+static struct tq_struct tcic_task = {0, 0, &tcic_bh, NULL};
+
 static void tcic_interrupt(int irq, void *dev, struct pt_regs *regs)
 {
     int i, quick = 0;
@@ -567,9 +587,13 @@
 	    events |= (latch & TCIC_SSTAT_RDY) ? SS_READY : 0;
 	    events |= (latch & TCIC_SSTAT_LBAT1) ? SS_BATDEAD : 0;
 	    events |= (latch & TCIC_SSTAT_LBAT2) ? SS_BATWARN : 0;
+	}
+	if (events) {
+		spin_lock(&pending_event_lock);
+		pending_events[i] |= events;
+		spin_unlock(&pending_event_lock);
+		pcmcia_queue_task(&tcic_task);
 	}
-	if (events)
-	    socket_table[i].handler(socket_table[i].info, events);
     }

     /* Schedule next poll, if needed */

-- 
dwmw2



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
