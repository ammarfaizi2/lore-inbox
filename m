Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129591AbQKMOic>; Mon, 13 Nov 2000 09:38:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129610AbQKMOiW>; Mon, 13 Nov 2000 09:38:22 -0500
Received: from cerebus-ext.cygnus.co.uk ([194.130.39.252]:26094 "EHLO
	passion.cygnus") by vger.kernel.org with ESMTP id <S129591AbQKMOiM>;
	Mon, 13 Nov 2000 09:38:12 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <3A0FF138.A510B45@mandrakesoft.com> 
In-Reply-To: <3A0FF138.A510B45@mandrakesoft.com>  <7572.974120930@redhat.com> 
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: torvalds@transmeta.com, dhinds@valinux.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pcmcia event thread. (fwd) 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 13 Nov 2000 14:37:31 +0000
Message-ID: <20554.974126251@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


jgarzik@mandrakesoft.com said:
>  Replace most if not all of this crap w/ daemonize()

OK.


>  it looks like the loop can be simplified to

Nope. sleep_on is bad. We have to set_current_state(TASK_INTERRUPTIBLE) 
before checking tq_pcmcia.

> while (1) {
> 	mb();
> 	active = tq_pcmcia;

        /* EVENT ARRIVES NOW */

> 	if (!active)
> 		interruptible_sleep_on(&event_thread_wq);

	/* WE SLEEP ANYWAY */

> 	if (signal_pending(current)
> 		break;
> 	run_task_queue(&tq_pcmcia); } 



jgarzik@mandrakesoft.com said:
> Racy.  Use waitpid() in the thread killer instead.  

Doesn't waitpid() require the thread we're waiting for to be child of the 
rmmod process? I suppose we could arrange that, but it's not particularly 
clean.

I prefer the tiny race and the campaign for up_and_exit() :)

> You also need to reap the process, just like in userland... 

Gratuitous cruft. Just let init(8) do it.

jgarzik@mandrakesoft.com said:
> Why are you cloning _FS, _FILES, and _SIGHAND?  I don't see why the
> third arg should not be zero.  man clone...

If we don't specify CLONE_FS | CLONE_FILES | CLONE_SIGHAND then new ones 
get allocated just for us to free them again immediately. If we clone them, 
then we just increase and decrease the use counts of the parent's ones. The 
latter is slightly more efficient, and I don't think it really matters. If 
you really care, that can be changed. I've dropped CLONE_SIGHAND because 
daemonize() doesn't free that, but left CLONE_FS and CLONE_FILES.

Revised patch:

Index: drivers/pcmcia/cs.c
===================================================================
RCS file: /inst/cvs/linux/drivers/pcmcia/Attic/cs.c,v
retrieving revision 1.1.2.28
diff -u -r1.1.2.28 cs.c
--- drivers/pcmcia/cs.c	2000/11/10 14:56:32	1.1.2.28
+++ drivers/pcmcia/cs.c	2000/11/13 14:35:13
@@ -2333,6 +2333,58 @@
 
 /*======================================================================
 
+    Kernel thread for submitting events on behalf of interrupt handlers
+    
+======================================================================*/
+static int event_thread_leaving = 0;
+static DECLARE_TASK_QUEUE(tq_pcmcia);
+static DECLARE_WAIT_QUEUE_HEAD(event_thread_wq);
+static DECLARE_MUTEX_LOCKED(event_thread_exit_sem);
+static int event_thread_pid;
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
@@ -2366,6 +2418,7 @@
 EXPORT_SYMBOL(pcmcia_modify_window);
 EXPORT_SYMBOL(pcmcia_open_memory);
 EXPORT_SYMBOL(pcmcia_parse_tuple);
+EXPORT_SYMBOL(pcmcia_queue_task);
 EXPORT_SYMBOL(pcmcia_read_memory);
 EXPORT_SYMBOL(pcmcia_register_client);
 EXPORT_SYMBOL(pcmcia_register_erase_queue);
@@ -2406,6 +2459,15 @@
     printk(KERN_INFO "%s\n", release);
     printk(KERN_INFO "  %s\n", options);
     DEBUG(0, "%s\n", version);
+
+    /* Start the thread for handling queued events for socket drivers */
+    event_thread_pid = kernel_thread (pcmcia_event_thread, NULL, CLONE_FS | CLONE_FILES);
+
+    if (event_thread_pid < 0) {
+	    printk(KERN_ERR "init_pcmcia_cs: fork failed: errno %d\n", -event_thread_pid);
+	    return event_thread_pid;
+    }
+
     if (do_apm)
 	pm_register(PM_SYS_DEV, PM_SYS_PCMCIA, handle_pm_event);
 #ifdef CONFIG_PROC_FS
@@ -2417,6 +2479,14 @@
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
Index: include/pcmcia/cs.h
===================================================================
RCS file: /inst/cvs/linux/include/pcmcia/Attic/cs.h,v
retrieving revision 1.1.2.8
diff -u -r1.1.2.8 cs.h
--- include/pcmcia/cs.h	2000/09/07 08:26:16	1.1.2.8
+++ include/pcmcia/cs.h	2000/11/13 14:35:13
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


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
