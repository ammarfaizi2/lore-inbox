Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129481AbQKMNJj>; Mon, 13 Nov 2000 08:09:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129488AbQKMNJa>; Mon, 13 Nov 2000 08:09:30 -0500
Received: from cerebus-ext.cygnus.co.uk ([194.130.39.252]:35574 "EHLO
	passion.cygnus") by vger.kernel.org with ESMTP id <S129481AbQKMNI6>;
	Mon, 13 Nov 2000 08:08:58 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
To: linux-kernel@vger.kernel.org
Subject: [PATCH] pcmcia event thread. (fwd)
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 13 Nov 2000 13:08:50 +0000
Message-ID: <7572.974120930@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Argh. I give up - I've added a rewrite rule to my MTA because I'm too 
stupid to remember that the list moved.

--
dwmw2

------- Forwarded Message

From: David Woodhouse <dwmw2@infradead.org>
To: torvalds@transmeta.com, dhinds@valinux.com
Cc: linux-kernel@vger.rutgers.edu
Subject: [PATCH] pcmcia event thread.
Date: Mon, 13 Nov 2000 12:27:13 +0000

I'm not sure why we changed from the existing state machine / timer setup to
sleeping in the PCMCIA parse_events() routine, but as parse_events() was
often called from interrupt handlers, this has had the effect that a number
of socket drivers now start their own kernel thread to submit events instead
of doing from the interrupt handler.

Driver authors being, well, driver authors, this is generally going to be
done badly, aside from the fact that it's needless duplication of code.

Therefore, I propose the that the core PCMCIA code should start its own 
kernel thread, so socket drivers can use the pcmcia_queue_task() function 
to queue a task to be executed in process context.

Much like this...

Index: drivers/pcmcia/cs.c
===================================================================
RCS file: /inst/cvs/linux/drivers/pcmcia/Attic/cs.c,v
retrieving revision 1.1.2.28
diff -u -r1.1.2.28 cs.c
--- drivers/pcmcia/cs.c	2000/11/10 14:56:32	1.1.2.28
+++ drivers/pcmcia/cs.c	2000/11/13 11:34:05
@@ -2333,6 +2333,62 @@
 
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
+	current->session = 1;
+        current->pgrp = 1;
+        strcpy(current->comm, "kpcmciad");
+        current->tty = NULL;
+        spin_lock_irq(&current->sigmask_lock);
+        sigfillset(&current->blocked);
+        recalc_sigpending(current);
+        spin_unlock_irq(&current->sigmask_lock);
+        exit_mm(current);
+        exit_files(current);
+        exit_sighand(current);
+        exit_fs(current);
+
+	while(!event_thread_leaving) {
+		void *active;
+
+		set_current_state(TASK_INTERRUPTIBLE);
+		add_wait_queue(&event_thread_wq, &wait);
+
+		/* Don't really need locking. But the implied mb() */
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
@@ -2366,6 +2422,7 @@
 EXPORT_SYMBOL(pcmcia_modify_window);
 EXPORT_SYMBOL(pcmcia_open_memory);
 EXPORT_SYMBOL(pcmcia_parse_tuple);
+EXPORT_SYMBOL(pcmcia_queue_task);
 EXPORT_SYMBOL(pcmcia_read_memory);
 EXPORT_SYMBOL(pcmcia_register_client);
 EXPORT_SYMBOL(pcmcia_register_erase_queue);
@@ -2411,6 +2468,9 @@
 #ifdef CONFIG_PROC_FS
     proc_pccard = proc_mkdir("pccard", proc_bus);
 #endif
+    /* Start the thread for handling queued events for socket drivers */
+    kernel_thread (pcmcia_event_thread, NULL,
+		   CLONE_FS | CLONE_FILES | CLONE_SIGHAND);
     return 0;
 }
 
@@ -2424,6 +2484,14 @@
 #endif
     if (do_apm)
 	pm_unregister_all(handle_pm_event);
+
+    /* Tell the event thread to die */
+    event_thread_leaving = 1;
+    wake_up(&event_thread_wq);
+
+    /* Wait for it... */
+    down(&event_thread_exit_sem);
+
     release_resource_db();
 }
 
Index: include/pcmcia/cs.h
===================================================================
RCS file: /inst/cvs/linux/include/pcmcia/Attic/cs.h,v
retrieving revision 1.1.2.8
diff -u -r1.1.2.8 cs.h
--- include/pcmcia/cs.h	2000/09/07 08:26:16	1.1.2.8
+++ include/pcmcia/cs.h	2000/11/13 11:34:05
@@ -443,6 +443,7 @@
 int pcmcia_map_mem_page(window_handle_t win, memreq_t *req);
 int pcmcia_modify_configuration(client_handle_t handle, modconf_t *mod);
 int pcmcia_modify_window(window_handle_t win, modwin_t *req);
+void pcmcia_queue_task(struct tq_struct *task);
 int pcmcia_register_client(client_handle_t *handle, client_reg_t *req);
 int pcmcia_release_configuration(client_handle_t handle);
 int pcmcia_release_io(client_handle_t handle, io_req_t *req);


--
dwmw2



------- End of Forwarded Message



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
