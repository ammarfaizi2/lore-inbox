Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129961AbQKPOp3>; Thu, 16 Nov 2000 09:45:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130270AbQKPOpJ>; Thu, 16 Nov 2000 09:45:09 -0500
Received: from cerebus-ext.cygnus.co.uk ([194.130.39.252]:53491 "EHLO
	passion.cygnus") by vger.kernel.org with ESMTP id <S129961AbQKPOpD>;
	Thu, 16 Nov 2000 09:45:03 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <E13wPFs-0007og-00@the-village.bc.nu> 
In-Reply-To: <E13wPFs-0007og-00@the-village.bc.nu> 
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: jgarzik@mandrakesoft.com (Jeff Garzik), torvalds@transmeta.com,
        dhinds@valinux.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pcmcia event thread. (fwd) 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 16 Nov 2000 14:14:31 +0000
Message-ID: <12129.974384071@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


alan@lxorguk.ukuu.org.uk said:
>  Umm..  Linus drivers dont appear to be SMP safe on unload 

AFAIK, no kernel threads are currently SMP safe on unload. However, 
the PCMCIA thread would be safe with the patch below, and we could fairly 
easily convert the others to use up_and_exit() once it's available.

Anyone using PCMCIA or CardBus with 2.4, even if you have a non-CardBus
i82365 or TCIC controller for which the driver was disabled in test11-pre5,
please could you test this? Especially if you have TCIC, in fact, because
it's already been tested successfully on yenta and i82365. 

(pcmcia-dif-7). Linus, this is the full patch against pre5, including the 
incremental part I sent this morning.

Index: drivers/pcmcia/Config.in
===================================================================
RCS file: /inst/cvs/linux/drivers/pcmcia/Attic/Config.in,v
retrieving revision 1.1.2.7
diff -u -r1.1.2.7 Config.in
--- drivers/pcmcia/Config.in	2000/08/01 14:18:00	1.1.2.7
+++ drivers/pcmcia/Config.in	2000/11/16 11:52:11
@@ -7,18 +7,18 @@
 mainmenu_option next_comment
 comment 'PCMCIA/CardBus support'
 
-dep_tristate 'CardBus support' CONFIG_PCMCIA $CONFIG_PCI
-if [ "$CONFIG_PCMCIA" != "n" ]; then
-  define_bool CONFIG_CARDBUS y
-fi
-
-#tristate 'PCMCIA/CardBus support' CONFIG_PCMCIA
+#dep_tristate 'CardBus support' CONFIG_PCMCIA $CONFIG_PCI
 #if [ "$CONFIG_PCMCIA" != "n" ]; then
-#   if [ "$CONFIG_PCI" != "n" ]; then
-#      bool '  CardBus support' CONFIG_CARDBUS
-#   fi
-#   bool '  i82365 compatible bridge support' CONFIG_I82365
-#   bool '  Databook TCIC host bridge support' CONFIG_TCIC
+#  define_bool CONFIG_CARDBUS y
 #fi
+
+tristate 'PCMCIA/CardBus support' CONFIG_PCMCIA
+if [ "$CONFIG_PCMCIA" != "n" ]; then
+   if [ "$CONFIG_PCI" != "n" ]; then
+      bool '  CardBus support' CONFIG_CARDBUS
+   fi
+   bool '  i82365 compatible bridge support' CONFIG_I82365
+   bool '  Databook TCIC host bridge support' CONFIG_TCIC
+fi
 
 endmenu
Index: drivers/pcmcia/cs.c
===================================================================
RCS file: /inst/cvs/linux/drivers/pcmcia/Attic/cs.c,v
retrieving revision 1.1.2.28
diff -u -r1.1.2.28 cs.c
--- drivers/pcmcia/cs.c	2000/11/10 14:56:32	1.1.2.28
+++ drivers/pcmcia/cs.c	2000/11/16 11:52:11
@@ -2333,6 +2333,58 @@
 
 /*======================================================================
 
+    Kernel thread for doing stuff(tm) on behalf of interrupt handlers
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
+	up_and_exit(&event_thread_exit_sem,0);
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
@@ -2366,6 +2418,7 @@
 EXPORT_SYMBOL(pcmcia_modify_window);
 EXPORT_SYMBOL(pcmcia_open_memory);
 EXPORT_SYMBOL(pcmcia_parse_tuple);
+EXPORT_SYMBOL(pcmcia_queue_task);
 EXPORT_SYMBOL(pcmcia_read_memory);
 EXPORT_SYMBOL(pcmcia_register_client);
 EXPORT_SYMBOL(pcmcia_register_erase_queue);
@@ -2403,9 +2456,19 @@
 
 static int __init init_pcmcia_cs(void)
 {
+    pid_t pid;
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
@@ -2417,6 +2480,14 @@
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
RCS file: /inst/cvs/linux/drivers/pcmcia/Attic/i82365.c,v
retrieving revision 1.1.2.14
diff -u -r1.1.2.14 i82365.c
--- drivers/pcmcia/i82365.c	2000/06/07 14:48:18	1.1.2.14
+++ drivers/pcmcia/i82365.c	2000/11/16 11:52:11
@@ -859,6 +859,28 @@
 
 /*====================================================================*/
 
+static u_int pending_events[8];
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
+static struct tq_struct pcic_task = {
+	routine:	pcic_bh
+};
+
 static void pcic_interrupt(int irq, void *dev,
 				    struct pt_regs *regs)
 {
@@ -893,8 +915,13 @@
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
Index: drivers/pcmcia/pci_socket.c
===================================================================
RCS file: /inst/cvs/linux/drivers/pcmcia/Attic/pci_socket.c,v
retrieving revision 1.1.2.7
diff -u -r1.1.2.7 pci_socket.c
--- drivers/pcmcia/pci_socket.c	2000/08/01 14:18:00	1.1.2.7
+++ drivers/pcmcia/pci_socket.c	2000/11/16 11:52:11
@@ -177,7 +177,7 @@
 	socket->dev = dev;
 	socket->op = ops;
 	dev->driver_data = socket;
-	init_waitqueue_head(&socket->wait);
+	spin_lock_init(&socket->event_lock);
 	return socket->op->open(socket);
 }
 
Index: drivers/pcmcia/pci_socket.h
===================================================================
RCS file: /inst/cvs/linux/drivers/pcmcia/Attic/pci_socket.h,v
retrieving revision 1.1.2.5
diff -u -r1.1.2.5 pci_socket.h
--- drivers/pcmcia/pci_socket.h	2000/07/06 15:28:43	1.1.2.5
+++ drivers/pcmcia/pci_socket.h	2000/11/16 11:52:11
@@ -18,9 +18,11 @@
 	void *info;
 	struct pci_socket_ops *op;
 	socket_cap_t cap;
-	wait_queue_head_t wait;
+	spinlock_t event_lock;
 	unsigned int events;
 	struct socket_info_t *pcmcia_socket;
+	struct tq_struct tq_task;
+	struct timer_list poll_timer;
 
 	/* A few words of private data for the low-level driver.. */
 	unsigned int private[8];
Index: drivers/pcmcia/tcic.c
===================================================================
RCS file: /inst/cvs/linux/drivers/pcmcia/Attic/tcic.c,v
retrieving revision 1.1.2.9
diff -u -r1.1.2.9 tcic.c
--- drivers/pcmcia/tcic.c	2000/06/07 14:48:18	1.1.2.9
+++ drivers/pcmcia/tcic.c	2000/11/16 11:52:11
@@ -530,6 +530,28 @@
 
 /*====================================================================*/
 
+static u_int pending_events[2];
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
+static struct tq_struct tcic_task = {
+	routine:	tcic_bh
+};
+
 static void tcic_interrupt(int irq, void *dev, struct pt_regs *regs)
 {
     int i, quick = 0;
@@ -567,9 +589,13 @@
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
Index: drivers/pcmcia/yenta.c
===================================================================
RCS file: /inst/cvs/linux/drivers/pcmcia/Attic/yenta.c,v
retrieving revision 1.1.2.25
diff -u -r1.1.2.25 yenta.c
--- drivers/pcmcia/yenta.c	2000/11/10 14:56:32	1.1.2.25
+++ drivers/pcmcia/yenta.c	2000/11/16 11:52:11
@@ -10,7 +10,10 @@
 #include <linux/delay.h>
 #include <linux/module.h>
 
+#include <pcmcia/version.h>
+#include <pcmcia/cs_types.h>
 #include <pcmcia/ss.h>
+#include <pcmcia/cs.h>
 
 #include <asm/io.h>
 
@@ -464,6 +467,20 @@
 	return events;
 }
 
+
+static void yenta_bh(void *data)
+{
+	pci_socket_t *socket = data;
+	unsigned int events;
+	
+	spin_lock_irq(&socket->event_lock);
+	events = socket->events;
+	socket->events = 0;
+	spin_unlock_irq(&socket->event_lock);
+	if (socket->handler)
+		socket->handler(socket->info, events);
+}
+
 static void yenta_interrupt(int irq, void *dev_id, struct pt_regs *regs)
 {
 	unsigned int events;
@@ -471,11 +488,22 @@
 
 	events = yenta_events(socket);
 	if (events) {
+		spin_lock(&socket->event_lock);
 		socket->events |= events;
-		wake_up_interruptible(&socket->wait);
+		spin_unlock(&socket->event_lock);
+		pcmcia_queue_task(&socket->tq_task);
 	}
 }
 
+static void yenta_interrupt_wrapper(unsigned long data)
+{
+	pci_socket_t *socket = (pci_socket_t *) data;
+
+	yenta_interrupt(0, (void *)socket, NULL);
+	socket->poll_timer.expires = jiffies + HZ;
+	add_timer(&socket->poll_timer);
+}
+
 /*
  * Only probe "regular" interrupts, don't
  * touch dangerous spots like the mouse irq,
@@ -545,24 +573,24 @@
 
 extern void cardbus_register(pci_socket_t *socket);
 
-/*
- * Watch a socket every second (and possibly in a
- * more timely manner if the state change interrupt
- * works..)
+/* 
+ * 'Bottom half' for the yenta_open routine. Allocate the interrupt line
+ *  and register the socket with the upper layers.
  */
-static int yenta_socket_thread(void * data)
+static void yenta_open_bh(void * data)
 {
 	pci_socket_t * socket = (pci_socket_t *) data;
-	DECLARE_WAITQUEUE(wait, current);
 
-	MOD_INC_USE_COUNT;
-	daemonize();
-	strcpy(current->comm, "CardBus Watcher");
+	/* It's OK to overwrite this now */
+	socket->tq_task.routine = yenta_bh;
 
-	if (socket->cb_irq && request_irq(socket->cb_irq, yenta_interrupt, SA_SHIRQ, socket->dev->name, socket)) {
-		printk ("Yenta: unable to register irq %d\n", socket->cb_irq);
-		MOD_DEC_USE_COUNT;
-		return (1);
+	if (!socket->cb_irq || request_irq(socket->cb_irq, yenta_interrupt, SA_SHIRQ, socket->dev->name, socket)) {
+		/* No IRQ or request_irq failed. Poll */
+		socket->cb_irq = 0; /* But zero is a valid IRQ number. */
+		socket->poll_timer.function = yenta_interrupt_wrapper;
+		socket->poll_timer.data = (unsigned long)socket;
+		socket->poll_timer.expires = jiffies + HZ;
+		add_timer(&socket->poll_timer);
 	}
 
 	/* Figure out what the dang thing can do for the PCMCIA layer... */
@@ -572,23 +600,7 @@
 	/* Register it with the pcmcia layer.. */
 	cardbus_register(socket);
 
-	do {
-		unsigned int events = socket->events | yenta_events(socket);
-
-		if (events) {
-			socket->events = 0;
-			if (socket->handler)
-				socket->handler(socket->info, events);
-		}
-
-		current->state = TASK_INTERRUPTIBLE;
-		add_wait_queue(&socket->wait, &wait);
-		if (!socket->events)
-			schedule_timeout(HZ);
-		remove_wait_queue(&socket->wait, &wait);
-	} while (!signal_pending(current));
 	MOD_DEC_USE_COUNT;
-	return 0;
 }
 
 static void yenta_clear_maps(pci_socket_t *socket)
@@ -745,6 +757,9 @@
 {
 	if (sock->cb_irq)
 		free_irq(sock->cb_irq, sock);
+	else
+		del_timer_sync(&sock->poll_timer);
+
 	if (sock->base)
 		iounmap(sock->base);
 }
@@ -835,8 +850,17 @@
 			}
 		}
 	}
+
+	/* Get the PCMCIA kernel thread to complete the 
+	   initialisation later. We can't do this here, 
+	   because, er, because Linus says so :)
+	*/
+	socket->tq_task.routine = yenta_open_bh;
+	socket->tq_task.data = socket;
+
+	MOD_INC_USE_COUNT;
+	pcmcia_queue_task(&socket->tq_task);
 
-	kernel_thread(yenta_socket_thread, socket, CLONE_FS | CLONE_FILES | CLONE_SIGHAND);
 	return 0;
 }
 
Index: include/linux/kernel.h
===================================================================
RCS file: /inst/cvs/linux/include/linux/kernel.h,v
retrieving revision 1.1.1.1.2.11
diff -u -r1.1.1.1.2.11 kernel.h
--- include/linux/kernel.h	2000/09/26 18:57:59	1.1.1.1.2.11
+++ include/linux/kernel.h	2000/11/16 11:52:11
@@ -45,10 +45,14 @@
 #define FASTCALL(x)	x
 #endif
 
+struct semaphore;
+
 extern struct notifier_block *panic_notifier_list;
 NORET_TYPE void panic(const char * fmt, ...)
 	__attribute__ ((NORET_AND format (printf, 1, 2)));
 NORET_TYPE void do_exit(long error_code)
+	ATTRIB_NORET;
+NORET_TYPE void up_and_exit(struct semaphore *, long)
 	ATTRIB_NORET;
 extern unsigned long simple_strtoul(const char *,char **,unsigned int);
 extern long simple_strtol(const char *,char **,unsigned int);
Index: include/pcmcia/cs.h
===================================================================
RCS file: /inst/cvs/linux/include/pcmcia/Attic/cs.h,v
retrieving revision 1.1.2.8
diff -u -r1.1.2.8 cs.h
--- include/pcmcia/cs.h	2000/09/07 08:26:16	1.1.2.8
+++ include/pcmcia/cs.h	2000/11/16 11:52:11
@@ -443,6 +443,7 @@
 int pcmcia_map_mem_page(window_handle_t win, memreq_t *req);
 int pcmcia_modify_configuration(client_handle_t handle, modconf_t *mod);
 int pcmcia_modify_window(window_handle_t win, modwin_t *req);
+void pcmcia_queue_task(struct tq_struct *task);
 int pcmcia_register_client(client_handle_t *handle, client_reg_t *req);
 int pcmcia_release_configuration(client_handle_t handle);
 int pcmcia_release_io(client_handle_t handle, io_req_t *req);
Index: kernel/exit.c
===================================================================
RCS file: /inst/cvs/linux/kernel/exit.c,v
retrieving revision 1.3.2.29
diff -u -r1.3.2.29 exit.c
--- kernel/exit.c	2000/09/18 13:54:01	1.3.2.29
+++ kernel/exit.c	2000/11/16 11:52:11
@@ -467,6 +467,14 @@
 	goto fake_volatile;
 }
 
+NORET_TYPE void up_and_exit(struct semaphore *sem, long code)
+{
+	if (sem)
+		up(sem);
+	
+	do_exit(code);
+}
+
 asmlinkage long sys_exit(int error_code)
 {
 	do_exit((error_code&0xff)<<8);
Index: kernel/ksyms.c
===================================================================
RCS file: /inst/cvs/linux/kernel/ksyms.c,v
retrieving revision 1.3.2.65
diff -u -r1.3.2.65 ksyms.c
--- kernel/ksyms.c	2000/11/13 11:00:18	1.3.2.65
+++ kernel/ksyms.c	2000/11/16 11:52:11
@@ -417,6 +417,7 @@
 EXPORT_SYMBOL(iomem_resource);
 
 /* process management */
+EXPORT_SYMBOL(up_and_exit);
 EXPORT_SYMBOL(__wake_up);
 EXPORT_SYMBOL(wake_up_process);
 EXPORT_SYMBOL(sleep_on);




--
dwmw2


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
