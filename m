Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262860AbTELWgJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 18:36:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262842AbTELWgJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 18:36:09 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:63828 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S262869AbTELWfu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 18:35:50 -0400
Date: Mon, 12 May 2003 15:44:16 -0700
From: Andrew Morton <akpm@digeo.com>
To: Paul Fulghum <paulkf@microgate.com>
Cc: dahinds@users.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: PCMCIA 2.5.X sleeping from illegal context
Message-Id: <20030512154416.3f502c36.akpm@digeo.com>
In-Reply-To: <1052775331.1995.49.camel@diemos>
References: <1052775331.1995.49.camel@diemos>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 12 May 2003 22:48:30.0151 (UTC) FILETIME=[9BBF3D70:01C318D8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Fulghum <paulkf@microgate.com> wrote:
>
> The 2.5.X PCMCIA kernel support seems to have a problem
> with drivers/pcmcia/rsrc_mgr.c in function undo_irq().

The timer handlers need to be converted to use schedule_delayed_work(),
or (more probably) schedule_work().

Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
>
> Does this still happen with all the patches Russell King posted
> that everyone else is ignoring ?

I've had the below in -mm for a couple of weeks.  I don't know if
it fixes the down()-in-timer-handler bug?




From: Russell King <rmk@arm.linux.org.uk>

Ok, I think everyone ignored my last email about the updated pcmcia
deadlock patch.  I've done a little more work on it since then, so
here it is again.  Feedback welcome.

It should apply to bk-curr or 2.5.68 (probably with some offsets
though.)

I've tried all manner of cardctl operations vs plugging and unplugging
cards, as well as module insertion and removal - it seems pretty rock
solid for me.



 25-akpm/drivers/pcmcia/cs.c          |  721 +++++++++++++++++++----------------
 25-akpm/drivers/pcmcia/cs_internal.h |    9 
 2 files changed, 418 insertions(+), 312 deletions(-)

diff -puN drivers/pcmcia/cs.c~pcmcia-deadlock-fix-2 drivers/pcmcia/cs.c
--- 25/drivers/pcmcia/cs.c~pcmcia-deadlock-fix-2	Tue Apr 29 13:29:35 2003
+++ 25-akpm/drivers/pcmcia/cs.c	Tue Apr 29 13:29:35 2003
@@ -302,11 +302,8 @@ static int proc_read_clients(char *buf, 
     
 ======================================================================*/
 
-static int setup_socket(socket_info_t *);
-static void shutdown_socket(socket_info_t *);
-static void reset_socket(socket_info_t *);
-static void unreset_socket(socket_info_t *);
-static void parse_events(void *info, u_int events);
+static int pccardd(void *__skt);
+void pcmcia_unregister_socket(struct device *dev);
 
 #define to_class_data(dev) dev->class_data
 
@@ -317,7 +314,7 @@ int pcmcia_register_socket(struct class_
 {
 	struct pcmcia_socket_class_data *cls_d = class_get_devdata(class_dev);
 	socket_info_t *s_info;
-	unsigned int i, j;
+	unsigned int i, j, ret;
 
 	if (!cls_d)
 		return -EINVAL;
@@ -330,6 +327,7 @@ int pcmcia_register_socket(struct class_
 	memset(s_info, 0, cls_d->nsock * sizeof(socket_info_t));
 
 	cls_d->s_info = s_info;
+	ret = 0;
 
 	/* socket initialization */
 	for (i = 0; i < cls_d->nsock; i++) {
@@ -344,7 +342,7 @@ int pcmcia_register_socket(struct class_
 		s->erase_busy.next = s->erase_busy.prev = &s->erase_busy;
 		INIT_LIST_HEAD(&s->cis_cache);
 		spin_lock_init(&s->lock);
-    
+
 		/* TBD: remove usage of socket_table, use class_for_each_dev instead */
 		for (j = 0; j < sockets; j++)
 			if (socket_table[j] == NULL) break;
@@ -353,6 +351,20 @@ int pcmcia_register_socket(struct class_
 
 		init_socket(s);
 		s->ss_entry->inquire_socket(s->sock, &s->cap);
+
+		init_completion(&s->thread_done);
+		init_waitqueue_head(&s->thread_wait);
+		init_MUTEX(&s->skt_sem);
+		spin_lock_init(&s->thread_lock);
+		ret = kernel_thread(pccardd, s, CLONE_KERNEL);
+		if (ret < 0) {
+			pcmcia_unregister_socket(dev);
+			break;
+		}
+
+		wait_for_completion(&s->thread_done);
+		BUG_ON(!s->thread);
+
 #ifdef CONFIG_PROC_FS
 		if (proc_pccard) {
 			char name[3];
@@ -368,7 +380,7 @@ int pcmcia_register_socket(struct class_
 		}
 #endif
 	}
-	return 0;
+	return ret;
 } /* pcmcia_register_socket */
 
 
@@ -407,8 +419,12 @@ void pcmcia_unregister_socket(struct cla
 			remove_proc_entry(name, proc_pccard);
 		}
 #endif
-		
-		shutdown_socket(s);
+		if (s->thread) {
+			init_completion(&s->thread_done);
+			s->thread = NULL;
+			wake_up(&s->thread_wait);
+			wait_for_completion(&s->thread_done);
+		}
 		release_cis_mem(s);
 		while (s->clients) {
 			client = s->clients;
@@ -450,15 +466,6 @@ static void free_regions(memory_handle_t
 
 static int send_event(socket_info_t *s, event_t event, int priority);
 
-/*
- * Sleep for n_cs centiseconds (1 cs = 1/100th of a second)
- */
-static void cs_sleep(unsigned int n_cs)
-{
-	current->state = TASK_INTERRUPTIBLE;
-	schedule_timeout( (n_cs * HZ + 99) / 100);
-}
-
 static void shutdown_socket(socket_info_t *s)
 {
     client_t **c;
@@ -505,132 +512,6 @@ static void shutdown_socket(socket_info_
     free_regions(&s->c_region);
 } /* shutdown_socket */
 
-/*
- * Return zero if we think the card isn't actually present
- */
-static int setup_socket(socket_info_t *s)
-{
-	int val, ret;
-	int setup_timeout = 100;
-
-	/* Wait for "not pending" */
-	for (;;) {
-		get_socket_status(s, &val);
-		if (!(val & SS_PENDING))
-			break;
-		if (--setup_timeout) {
-			cs_sleep(10);
-			continue;
-		}
-		printk(KERN_NOTICE "cs: socket %p voltage interrogation"
-			" timed out\n", s);
-		ret = 0;
-		goto out;
-	}
-
-	if (val & SS_DETECT) {
-		DEBUG(1, "cs: setup_socket(%p): applying power\n", s);
-		s->state |= SOCKET_PRESENT;
-		s->socket.flags &= SS_DEBOUNCED;
-		if (val & SS_3VCARD)
-		    s->socket.Vcc = s->socket.Vpp = 33;
-		else if (!(val & SS_XVCARD))
-		    s->socket.Vcc = s->socket.Vpp = 50;
-		else {
-		    printk(KERN_NOTICE "cs: socket %p: unsupported "
-			   "voltage key\n", s);
-		    s->socket.Vcc = 0;
-		}
-		if (val & SS_CARDBUS) {
-		    s->state |= SOCKET_CARDBUS;
-#ifndef CONFIG_CARDBUS
-		    printk(KERN_NOTICE "cs: unsupported card type detected!\n");
-#endif
-		}
-		set_socket(s, &s->socket);
-		cs_sleep(vcc_settle);
-		reset_socket(s);
-		ret = 1;
-	} else {
-		DEBUG(0, "cs: setup_socket(%p): no card!\n", s);
-		ret = 0;
-	}
-out:
-	return ret;
-} /* setup_socket */
-
-/*======================================================================
-
-    Reset_socket() and unreset_socket() handle hard resets.  Resets
-    have several causes: card insertion, a call to reset_socket, or
-    recovery from a suspend/resume cycle.  Unreset_socket() sends
-    a CS event that matches the cause of the reset.
-    
-======================================================================*/
-
-static void reset_socket(socket_info_t *s)
-{
-    DEBUG(1, "cs: resetting socket %p\n", s);
-    s->socket.flags |= SS_OUTPUT_ENA | SS_RESET;
-    set_socket(s, &s->socket);
-    udelay((long)reset_time);
-    s->socket.flags &= ~SS_RESET;
-    set_socket(s, &s->socket);
-    cs_sleep(unreset_delay);
-    unreset_socket(s);
-} /* reset_socket */
-
-#define EVENT_MASK \
-(SOCKET_SETUP_PENDING|SOCKET_SUSPEND|SOCKET_RESET_PENDING)
-
-static void unreset_socket(socket_info_t *s)
-{
-	int setup_timeout = unreset_limit;
-	int val;
-
-	/* Wait for "ready" */
-	for (;;) {
-		get_socket_status(s, &val);
-		if (val & SS_READY)
-			break;
-		DEBUG(2, "cs: socket %d not ready yet\n", s->sock);
-		if (--setup_timeout) {
-			cs_sleep(unreset_check);
-			continue;
-		}
-		printk(KERN_NOTICE "cs: socket %p timed out during"
-			" reset.  Try increasing setup_delay.\n", s);
-		s->state &= ~EVENT_MASK;
-		return;
-	}
-
-	DEBUG(1, "cs: reset done on socket %p\n", s);
-	if (s->state & SOCKET_SUSPEND) {
-	    s->state &= ~EVENT_MASK;
-	    if (verify_cis_cache(s) != 0)
-		parse_events(s, SS_DETECT);
-	    else
-		send_event(s, CS_EVENT_PM_RESUME, CS_EVENT_PRI_LOW);
-	} else if (s->state & SOCKET_SETUP_PENDING) {
-#ifdef CONFIG_CARDBUS
-	    if (s->state & SOCKET_CARDBUS) {
-		cb_alloc(s);
-		s->state |= SOCKET_CARDBUS_CONFIG;
-	    }
-#endif
-	    send_event(s, CS_EVENT_CARD_INSERTION, CS_EVENT_PRI_LOW);
-	    s->state &= ~SOCKET_SETUP_PENDING;
-	} else {
-	    send_event(s, CS_EVENT_CARD_RESET, CS_EVENT_PRI_LOW);
-	    if (s->reset_handle) { 
-		    s->reset_handle->event_callback_args.info = NULL;
-		    EVENT(s->reset_handle, CS_EVENT_RESET_COMPLETE,
-			  CS_EVENT_PRI_LOW);
-	    }
-	    s->state &= ~EVENT_MASK;
-	}
-} /* unreset_socket */
-
 /*======================================================================
 
     The central event handler.  Send_event() sends an event to all
@@ -661,61 +542,266 @@ static int send_event(socket_info_t *s, 
     return ret;
 } /* send_event */
 
-static void do_shutdown(socket_info_t *s)
+static void pcmcia_error(socket_info_t *skt, const char *fmt, ...)
 {
-    client_t *client;
-    if (s->state & SOCKET_SHUTDOWN_PENDING)
-	return;
-    s->state |= SOCKET_SHUTDOWN_PENDING;
-    send_event(s, CS_EVENT_CARD_REMOVAL, CS_EVENT_PRI_HIGH);
-    for (client = s->clients; client; client = client->next)
-	if (!(client->Attributes & INFO_MASTER_CLIENT))
-	    client->state |= CLIENT_STALE;
-    if (s->state & (SOCKET_SETUP_PENDING|SOCKET_RESET_PENDING)) {
-	DEBUG(0, "cs: flushing pending setup\n");
-	s->state &= ~EVENT_MASK;
-    }
-    cs_sleep(shutdown_delay);
-    s->state &= ~SOCKET_PRESENT;
-    shutdown_socket(s);
+	static char buf[128];
+	va_list ap;
+	int len;
+
+	va_start(ap, fmt);
+	len = vsnprintf(buf, sizeof(buf), fmt, ap);
+	va_end(ap);
+	buf[len] = '\0';
+
+	printk(KERN_ERR "PCMCIA: socket %p: %s", skt, buf);
+}
+
+#define cs_to_timeout(cs) (((cs) * HZ + 99) / 100)
+
+static void socket_remove_drivers(socket_info_t *skt)
+{
+	client_t *client;
+
+	send_event(skt, CS_EVENT_CARD_REMOVAL, CS_EVENT_PRI_HIGH);
+
+	for (client = skt->clients; client; client = client->next)
+		if (!(client->Attributes & INFO_MASTER_CLIENT))
+			client->state |= CLIENT_STALE;
+}
+
+static void socket_shutdown(socket_info_t *skt)
+{
+	socket_remove_drivers(skt);
+	set_current_state(TASK_UNINTERRUPTIBLE);
+	schedule_timeout(cs_to_timeout(shutdown_delay));
+	skt->state &= ~SOCKET_PRESENT;
+	shutdown_socket(skt);
+}
+
+static int socket_reset(socket_info_t *skt)
+{
+	int status, i;
+
+	skt->socket.flags |= SS_OUTPUT_ENA | SS_RESET;
+	set_socket(skt, &skt->socket);
+	udelay((long)reset_time);
+
+	skt->socket.flags &= ~SS_RESET;
+	set_socket(skt, &skt->socket);
+
+	set_current_state(TASK_UNINTERRUPTIBLE);
+	schedule_timeout(cs_to_timeout(unreset_delay));
+	for (i = 0; i < unreset_limit; i++) {
+		get_socket_status(skt, &status);
+
+		if (!(status & SS_DETECT))
+			return CS_NO_CARD;
+
+		if (status & SS_READY)
+			return CS_SUCCESS;
+
+		set_current_state(TASK_UNINTERRUPTIBLE);
+		schedule_timeout(cs_to_timeout(unreset_check));
+	}
+
+	pcmcia_error(skt, "time out after reset.\n");
+	return CS_GENERAL_FAILURE;
+}
+
+static int socket_setup(socket_info_t *skt, int initial_delay)
+{
+	int status, i;
+
+	get_socket_status(skt, &status);
+	if (!(status & SS_DETECT))
+		return CS_NO_CARD;
+
+	set_current_state(TASK_UNINTERRUPTIBLE);
+	schedule_timeout(cs_to_timeout(initial_delay));
+
+	for (i = 0; i < 100; i++) {
+		get_socket_status(skt, &status);
+		if (!(status & SS_DETECT))
+			return CS_NO_CARD;
+
+		if (!(status & SS_PENDING))
+			break;
+
+		set_current_state(TASK_UNINTERRUPTIBLE);
+		schedule_timeout(cs_to_timeout(10));
+	}
+
+	if (status & SS_PENDING) {
+		pcmcia_error(skt, "voltage interrogation timed out.\n");
+		return CS_GENERAL_FAILURE;
+	}
+
+	if (status & SS_CARDBUS) {
+		skt->state |= SOCKET_CARDBUS;
+#ifndef CONFIG_CARDBUS
+		pcmcia_error(skt, "cardbus cards are not supported.\n");
+		return CS_BAD_TYPE;
+#endif
+	}
+
+	/*
+	 * Decode the card voltage requirements, and apply power to the card.
+	 */
+	if (status & SS_3VCARD)
+		skt->socket.Vcc = skt->socket.Vpp = 33;
+	else if (!(status & SS_XVCARD))
+		skt->socket.Vcc = skt->socket.Vpp = 50;
+	else {
+		pcmcia_error(skt, "unsupported voltage key.\n");
+		return CS_BAD_TYPE;
+	}
+	skt->state |= SOCKET_PRESENT;
+	skt->socket.flags = SS_DEBOUNCED;
+	set_socket(skt, &skt->socket);
+
+	/*
+	 * Wait "vcc_settle" for the supply to stabilise.
+	 */
+	set_current_state(TASK_UNINTERRUPTIBLE);
+	schedule_timeout(cs_to_timeout(vcc_settle));
+
+	return socket_reset(skt);
+}
+
+/*
+ * Handle card insertion.  Setup the socket, reset the card,
+ * and then tell the rest of PCMCIA that a card is present.
+ */
+static int socket_insert(socket_info_t *skt)
+{
+	int ret;
+
+	ret = socket_setup(skt, setup_delay);
+	if (ret == CS_SUCCESS) {
+#ifdef CONFIG_CARDBUS
+		if (skt->state & SOCKET_CARDBUS) {
+			cb_alloc(skt);
+			skt->state |= SOCKET_CARDBUS_CONFIG;
+		}
+#endif
+		send_event(skt, CS_EVENT_CARD_INSERTION, CS_EVENT_PRI_LOW);
+		skt->socket.flags &= ~SS_DEBOUNCED;
+	} else
+		socket_shutdown(skt);
+
+	return ret;
+}
+
+static int socket_suspend(socket_info_t *skt)
+{
+	if (skt->state & SOCKET_SUSPEND)
+		return CS_IN_USE;
+
+	send_event(skt, CS_EVENT_PM_SUSPEND, CS_EVENT_PRI_LOW);
+	suspend_socket(skt);
+	skt->state |= SOCKET_SUSPEND;
+
+	return CS_SUCCESS;
+}
+
+/*
+ * Resume a socket.  If a card is present, verify its CIS against
+ * our cached copy.  If they are different, the card has been
+ * replaced, and we need to tell the drivers.
+ */
+static int socket_resume(socket_info_t *skt)
+{
+	int ret;
+
+	if (!(skt->state & SOCKET_SUSPEND))
+		return CS_IN_USE;
+
+	init_socket(skt);
+
+	ret = socket_setup(skt, resume_delay);
+	if (ret == CS_SUCCESS) {
+		/*
+		 * FIXME: need a better check here for cardbus cards.
+		 */
+		if (verify_cis_cache(skt) != 0) {
+			socket_remove_drivers(skt);
+			destroy_cis_cache(skt);
+			send_event(skt, CS_EVENT_CARD_INSERTION, CS_EVENT_PRI_LOW);
+		} else {
+			send_event(skt, CS_EVENT_PM_RESUME, CS_EVENT_PRI_LOW);
+		}
+		skt->socket.flags &= ~SS_DEBOUNCED;
+	} else
+		socket_shutdown(skt);
+
+	skt->state &= ~SOCKET_SUSPEND;
+
+	return CS_SUCCESS;
+}
+
+static int pccardd(void *__skt)
+{
+	socket_info_t *skt = __skt;
+	DECLARE_WAITQUEUE(wait, current);
+
+	daemonize("pccardd");
+	skt->thread = current;
+	complete(&skt->thread_done);
+
+	add_wait_queue(&skt->thread_wait, &wait);
+	for (;;) {
+		unsigned long flags;
+		unsigned int events;
+
+		set_current_state(TASK_INTERRUPTIBLE);
+
+		spin_lock_irqsave(&skt->thread_lock, flags);
+		events = skt->thread_events;
+		skt->thread_events = 0;
+		spin_unlock_irqrestore(&skt->thread_lock, flags);
+
+		if (events) {
+			down(&skt->skt_sem);
+			if (events & SS_DETECT && !(skt->state & SOCKET_SUSPEND)) {
+				int status;
+
+				get_socket_status(skt, &status);
+				if ((skt->state & SOCKET_PRESENT) &&
+				     !(status & SS_DETECT))
+					socket_shutdown(skt);
+				if (status & SS_DETECT)
+					socket_insert(skt);
+			}
+			if (events & SS_BATDEAD)
+				send_event(skt, CS_EVENT_BATTERY_DEAD, CS_EVENT_PRI_LOW);
+			if (events & SS_BATWARN)
+				send_event(skt, CS_EVENT_BATTERY_LOW, CS_EVENT_PRI_LOW);
+			if (events & SS_READY)
+				send_event(skt, CS_EVENT_READY_CHANGE, CS_EVENT_PRI_LOW);
+			up(&skt->skt_sem);
+			continue;
+		}
+
+		schedule();
+		if (!skt->thread)
+			break;
+	}
+	remove_wait_queue(&skt->thread_wait, &wait);
+
+	socket_shutdown(skt);
+
+	complete_and_exit(&skt->thread_done, 0);
 }
 
 static void parse_events(void *info, u_int events)
 {
-    socket_info_t *s = info;
-    if (events & SS_DETECT) {
-	int status;
-
-	get_socket_status(s, &status);
-	if ((s->state & SOCKET_PRESENT) &&
-	    (!(s->state & SOCKET_SUSPEND) ||
-	     !(status & SS_DETECT)))
-	    do_shutdown(s);
-	if (status & SS_DETECT) {
-	    if (s->state & SOCKET_SETUP_PENDING) {
-		DEBUG(1, "cs: delaying pending setup\n");
-		return;
-	    }
-	    s->state |= SOCKET_SETUP_PENDING;
-	    if (s->state & SOCKET_SUSPEND)
-		cs_sleep(resume_delay);
-	    else
-		cs_sleep(setup_delay);
-	    s->socket.flags |= SS_DEBOUNCED;
-	    if (setup_socket(s) == 0)
-		s->state &= ~SOCKET_SETUP_PENDING;
-	    s->socket.flags &= ~SS_DEBOUNCED;
-	}
-    }
-    if (events & SS_BATDEAD)
-	send_event(s, CS_EVENT_BATTERY_DEAD, CS_EVENT_PRI_LOW);
-    if (events & SS_BATWARN)
-	send_event(s, CS_EVENT_BATTERY_LOW, CS_EVENT_PRI_LOW);
-    if (events & SS_READY) {
-	if (!(s->state & SOCKET_RESET_PENDING))
-	    send_event(s, CS_EVENT_READY_CHANGE, CS_EVENT_PRI_LOW);
-	else DEBUG(1, "cs: ready change during reset\n");
-    }
+	socket_info_t *s = info;
+
+	spin_lock(&s->thread_lock);
+	s->thread_events |= events;
+	spin_unlock(&s->thread_lock);
+
+	wake_up(&s->thread_wait);
 } /* parse_events */
 
 /*======================================================================
@@ -727,27 +813,18 @@ static void parse_events(void *info, u_i
     
 ======================================================================*/
 
-void pcmcia_suspend_socket (socket_info_t *s)
+void pcmcia_suspend_socket (socket_info_t *skt)
 {
-    if ((s->state & SOCKET_PRESENT) && !(s->state & SOCKET_SUSPEND)) {
-	send_event(s, CS_EVENT_PM_SUSPEND, CS_EVENT_PRI_LOW);
-	suspend_socket(s);
-	s->state |= SOCKET_SUSPEND;
-    }
+	down(&skt->skt_sem);
+	socket_suspend(skt);
+	up(&skt->skt_sem);
 }
 
-void pcmcia_resume_socket (socket_info_t *s)
+void pcmcia_resume_socket (socket_info_t *skt)
 {
-    int	stat;
-
-    /* Do this just to reinitialize the socket */
-    init_socket(s);
-    get_socket_status(s, &stat);
-
-    /* If there was or is a card here, we need to do something
-    about it... but parse_events will sort it all out. */
-    if ((s->state & SOCKET_PRESENT) || (stat & SS_DETECT))
-	parse_events(s, SS_DETECT);
+	down(&skt->skt_sem);
+	socket_resume(skt);
+	up(&skt->skt_sem);
 }
 
 
@@ -1461,15 +1538,8 @@ int pcmcia_register_client(client_handle
 
     s = socket_table[ns];
     if (++s->real_clients == 1) {
-	int status;
 	register_callback(s, &parse_events, s);
-	get_socket_status(s, &status);
-	if ((status & SS_DETECT) &&
-	    !(s->state & SOCKET_SETUP_PENDING)) {
-	    s->state |= SOCKET_SETUP_PENDING;
-	    if (setup_socket(s) == 0)
-		    s->state &= ~SOCKET_SETUP_PENDING;
-	}
+	parse_events(s, SS_DETECT);
     }
 
     *handle = client;
@@ -2022,30 +2092,44 @@ int pcmcia_request_window(client_handle_
 
 int pcmcia_reset_card(client_handle_t handle, client_req_t *req)
 {
-    int i, ret;
-    socket_info_t *s;
+	socket_info_t *skt;
+	int ret;
     
-    if (CHECK_HANDLE(handle))
-	return CS_BAD_HANDLE;
-    i = handle->Socket; s = socket_table[i];
-    if (!(s->state & SOCKET_PRESENT))
-	return CS_NO_CARD;
-    if (s->state & SOCKET_RESET_PENDING)
-	return CS_IN_USE;
-    s->state |= SOCKET_RESET_PENDING;
+	if (CHECK_HANDLE(handle))
+		return CS_BAD_HANDLE;
+	DEBUG(1, "cs: resetting socket %d\n", handle->Socket);
+	skt = SOCKET(handle);
+
+	down(&skt->skt_sem);
+	do {
+		if (!(skt->state & SOCKET_PRESENT)) {
+			ret = CS_NO_CARD;
+			break;
+		}
+		if (skt->state & SOCKET_SUSPEND) {
+			ret = CS_IN_USE;
+			break;
+		}
+		if (skt->state & SOCKET_CARDBUS) {
+			ret = CS_UNSUPPORTED_FUNCTION;
+			break;
+		}
 
-    ret = send_event(s, CS_EVENT_RESET_REQUEST, CS_EVENT_PRI_LOW);
-    if (ret != 0) {
-	s->state &= ~SOCKET_RESET_PENDING;
-	handle->event_callback_args.info = (void *)(u_long)ret;
-	EVENT(handle, CS_EVENT_RESET_COMPLETE, CS_EVENT_PRI_LOW);
-    } else {
-	DEBUG(1, "cs: resetting socket %d\n", i);
-	send_event(s, CS_EVENT_RESET_PHYSICAL, CS_EVENT_PRI_LOW);
-	s->reset_handle = handle;
-	reset_socket(s);
-    }
-    return CS_SUCCESS;
+		ret = send_event(skt, CS_EVENT_RESET_REQUEST, CS_EVENT_PRI_LOW);
+		if (ret == 0) {
+			send_event(skt, CS_EVENT_RESET_PHYSICAL, CS_EVENT_PRI_LOW);
+			if (socket_reset(skt) == CS_SUCCESS)
+				send_event(skt, CS_EVENT_CARD_RESET, CS_EVENT_PRI_LOW);
+		}
+
+		handle->event_callback_args.info = (void *)(u_long)ret;
+		EVENT(handle, CS_EVENT_RESET_COMPLETE, CS_EVENT_PRI_LOW);
+
+		ret = CS_SUCCESS;
+	} while (0);
+	up(&skt->skt_sem);
+
+	return ret;
 } /* reset_card */
 
 /*======================================================================
@@ -2057,42 +2141,56 @@ int pcmcia_reset_card(client_handle_t ha
 
 int pcmcia_suspend_card(client_handle_t handle, client_req_t *req)
 {
-    int i;
-    socket_info_t *s;
+	socket_info_t *skt;
+	int ret;
     
-    if (CHECK_HANDLE(handle))
-	return CS_BAD_HANDLE;
-    i = handle->Socket; s = socket_table[i];
-    if (!(s->state & SOCKET_PRESENT))
-	return CS_NO_CARD;
-    if (s->state & SOCKET_SUSPEND)
-	return CS_IN_USE;
-
-    DEBUG(1, "cs: suspending socket %d\n", i);
-    send_event(s, CS_EVENT_PM_SUSPEND, CS_EVENT_PRI_LOW);
-    suspend_socket(s);
-    s->state |= SOCKET_SUSPEND;
+	if (CHECK_HANDLE(handle))
+		return CS_BAD_HANDLE;
+	DEBUG(1, "cs: suspending socket %d\n", handle->Socket);
+	skt = SOCKET(handle);
+
+	down(&skt->skt_sem);
+	do {
+		if (!(skt->state & SOCKET_PRESENT)) {
+			ret = CS_NO_CARD;
+			break;
+		}
+		if (skt->state & SOCKET_CARDBUS) {
+			ret = CS_UNSUPPORTED_FUNCTION;
+			break;
+		}
+		ret = socket_suspend(skt);
+	} while (0);
+	up(&skt->skt_sem);
 
-    return CS_SUCCESS;
+	return ret;
 } /* suspend_card */
 
 int pcmcia_resume_card(client_handle_t handle, client_req_t *req)
 {
-    int i;
-    socket_info_t *s;
+	socket_info_t *skt;
+	int ret;
     
-    if (CHECK_HANDLE(handle))
-	return CS_BAD_HANDLE;
-    i = handle->Socket; s = socket_table[i];
-    if (!(s->state & SOCKET_PRESENT))
-	return CS_NO_CARD;
-    if (!(s->state & SOCKET_SUSPEND))
-	return CS_IN_USE;
-
-    DEBUG(1, "cs: waking up socket %d\n", i);
-    setup_socket(s);
+	if (CHECK_HANDLE(handle))
+		return CS_BAD_HANDLE;
+	DEBUG(1, "cs: waking up socket %d\n", handle->Socket);
+	skt = SOCKET(handle);
+
+	down(&skt->skt_sem);
+	do {
+		if (!(skt->state & SOCKET_PRESENT)) {
+			ret = CS_NO_CARD;
+			break;
+		}
+		if (skt->state & SOCKET_CARDBUS) {
+			ret = CS_UNSUPPORTED_FUNCTION;
+			break;
+		}
+		ret = socket_resume(skt);
+	} while (0);
+	up(&skt->skt_sem);
 
-    return CS_SUCCESS;
+	return ret;
 } /* resume_card */
 
 /*======================================================================
@@ -2103,57 +2201,58 @@ int pcmcia_resume_card(client_handle_t h
 
 int pcmcia_eject_card(client_handle_t handle, client_req_t *req)
 {
-    int i, ret;
-    socket_info_t *s;
-    u_long flags;
+	socket_info_t *skt;
+	int ret;
     
-    if (CHECK_HANDLE(handle))
-	return CS_BAD_HANDLE;
-    i = handle->Socket; s = socket_table[i];
-    if (!(s->state & SOCKET_PRESENT))
-	return CS_NO_CARD;
+	if (CHECK_HANDLE(handle))
+		return CS_BAD_HANDLE;
+	DEBUG(1, "cs: user eject request on socket %d\n", handle->Socket);
+	skt = SOCKET(handle);
+
+	down(&skt->skt_sem);
+	do {
+		if (!(skt->state & SOCKET_PRESENT)) {
+			ret = CS_NO_CARD;
+			break;
+		}
 
-    DEBUG(1, "cs: user eject request on socket %d\n", i);
+		ret = send_event(skt, CS_EVENT_EJECTION_REQUEST, CS_EVENT_PRI_LOW);
+		if (ret != 0)
+			break;
 
-    ret = send_event(s, CS_EVENT_EJECTION_REQUEST, CS_EVENT_PRI_LOW);
-    if (ret != 0)
-	return ret;
+		socket_shutdown(skt);
+		ret = CS_SUCCESS;
+	} while (0);
+	up(&skt->skt_sem);
 
-    spin_lock_irqsave(&s->lock, flags);
-    do_shutdown(s);
-    spin_unlock_irqrestore(&s->lock, flags);
-    
-    return CS_SUCCESS;
-    
+	return ret;
 } /* eject_card */
 
 int pcmcia_insert_card(client_handle_t handle, client_req_t *req)
 {
-    int i, status;
-    socket_info_t *s;
-    u_long flags;
-    
-    if (CHECK_HANDLE(handle))
-	return CS_BAD_HANDLE;
-    i = handle->Socket; s = socket_table[i];
-    if (s->state & SOCKET_PRESENT)
-	return CS_IN_USE;
-
-    DEBUG(1, "cs: user insert request on socket %d\n", i);
+	socket_info_t *skt;
+	int ret;
 
-    spin_lock_irqsave(&s->lock, flags);
-    if (!(s->state & SOCKET_SETUP_PENDING)) {
-	s->state |= SOCKET_SETUP_PENDING;
-	spin_unlock_irqrestore(&s->lock, flags);
-	get_socket_status(s, &status);
-	if ((status & SS_DETECT) == 0 || (setup_socket(s) == 0)) {
-	    s->state &= ~SOCKET_SETUP_PENDING;
-	    return CS_NO_CARD;
-	}
-    } else
-	spin_unlock_irqrestore(&s->lock, flags);
+	if (CHECK_HANDLE(handle))
+		return CS_BAD_HANDLE;
+	DEBUG(1, "cs: user insert request on socket %d\n", handle->Socket);
+	skt = SOCKET(handle);
+
+	down(&skt->skt_sem);
+	do {
+		if (skt->state & SOCKET_PRESENT) {
+			ret = CS_IN_USE;
+			break;
+		}
+		if (socket_insert(skt) == CS_NO_CARD) {
+			ret = CS_NO_CARD;
+			break;
+		}
+		ret = CS_SUCCESS;
+	} while (0);
+	up(&skt->skt_sem);
 
-    return CS_SUCCESS;
+	return ret;
 } /* insert_card */
 
 /*======================================================================
diff -puN drivers/pcmcia/cs_internal.h~pcmcia-deadlock-fix-2 drivers/pcmcia/cs_internal.h
--- 25/drivers/pcmcia/cs_internal.h~pcmcia-deadlock-fix-2	Tue Apr 29 13:29:35 2003
+++ 25-akpm/drivers/pcmcia/cs_internal.h	Tue Apr 29 13:29:35 2003
@@ -133,7 +133,6 @@ typedef struct socket_info_t {
     u_short			lock_count;
     client_handle_t		clients;
     u_int			real_clients;
-    client_handle_t		reset_handle;
     pccard_mem_map		cis_mem;
     u_char			*cis_virt;
     config_t			*config;
@@ -155,6 +154,14 @@ typedef struct socket_info_t {
 #ifdef CONFIG_PROC_FS
     struct proc_dir_entry	*proc;
 #endif
+
+    struct semaphore		skt_sem;	/* protects socket h/w state */
+
+    struct task_struct		*thread;
+    struct completion		thread_done;
+    wait_queue_head_t		thread_wait;
+    spinlock_t			thread_lock;	/* protects thread_events */
+    unsigned int		thread_events;
 } socket_info_t;
 
 /* Flags in config state */

_

