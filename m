Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751057AbWDDADE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751057AbWDDADE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 20:03:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964898AbWDDACu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 20:02:50 -0400
Received: from wp060.webpack.hosteurope.de ([80.237.132.67]:10423 "EHLO
	wp060.webpack.hosteurope.de") by vger.kernel.org with ESMTP
	id S964891AbWDCX7b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 19:59:31 -0400
Date: Tue, 4 Apr 2006 02:00:24 +0200
From: Hansjoerg Lipp <hjlipp@web.de>
To: Karsten Keil <kkeil@suse.de>
Cc: i4ldeveloper@listserv.isdn4linux.de, linux-usb-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@suse.de>,
       Tilman Schmidt <tilman@imap.cc>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH 13/13] isdn4linux: Siemens Gigaset drivers - make some variables non-atomic
Message-ID: <gigaset307x.2006.04.04.001.13@hjlipp.my-fqdn.de>
References: <gigaset307x.2006.04.04.001.3@hjlipp.my-fqdn.de> <gigaset307x.2006.04.04.001.4@hjlipp.my-fqdn.de> <gigaset307x.2006.04.04.001.5@hjlipp.my-fqdn.de> <gigaset307x.2006.04.04.001.6@hjlipp.my-fqdn.de> <gigaset307x.2006.04.04.001.7@hjlipp.my-fqdn.de> <gigaset307x.2006.04.04.001.8@hjlipp.my-fqdn.de> <gigaset307x.2006.04.04.001.9@hjlipp.my-fqdn.de> <gigaset307x.2006.04.04.001.10@hjlipp.my-fqdn.de> <gigaset307x.2006.04.04.001.11@hjlipp.my-fqdn.de> <gigaset307x.2006.04.04.001.12@hjlipp.my-fqdn.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <gigaset307x.2006.04.04.001.12@hjlipp.my-fqdn.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tilman Schmidt <tilman@imap.cc>, Hansjoerg Lipp <hjlipp@web.de>

This patch replaces some atomic_t variables in the Gigaset drivers
by non-atomic ones, using spinlocks instead to assure atomicity, as
proposed in discussions on the linux-kernel mailing list.

Signed-off-by: Hansjoerg Lipp <hjlipp@web.de>
Signed-off-by: Tilman Schmidt <tilman@imap.cc>
---

 drivers/isdn/gigaset/asyncdata.c   |    9 ++-
 drivers/isdn/gigaset/bas-gigaset.c |   48 +++++++++-----------
 drivers/isdn/gigaset/common.c      |   64 +++++++++++++--------------
 drivers/isdn/gigaset/ev-layer.c    |   87 ++++++++++++++++++++++++-------------
 drivers/isdn/gigaset/gigaset.h     |   18 +++----
 drivers/isdn/gigaset/i4l.c         |   19 +++-----
 drivers/isdn/gigaset/interface.c   |   19 +++++---
 drivers/isdn/gigaset/isocdata.c    |    6 ++
 drivers/isdn/gigaset/proc.c        |    9 +++
 drivers/isdn/gigaset/usb-gigaset.c |   86 ++++++++++++++++++++++--------------
 10 files changed, 211 insertions(+), 154 deletions(-)

--- linux-2.6.16-gig-doc/drivers/isdn/gigaset/gigaset.h	2006-04-02 18:44:29.000000000 +0200
+++ linux-2.6.16-gig-atomic/drivers/isdn/gigaset/gigaset.h	2006-04-02 18:46:19.000000000 +0200
@@ -55,9 +55,6 @@
 #define GIG_RETRYCID
 #define GIG_X75
 
-#define MAX_TIMER_INDEX 1000
-#define MAX_SEQ_INDEX   1000
-
 #define GIG_TICK 100		/* in milliseconds */
 
 /* timeout values (unit: 1 sec) */
@@ -375,7 +372,7 @@ struct at_state_t {
 	struct list_head	list;
 	int			waiting;
 	int			getstring;
-	atomic_t		timer_index;
+	unsigned		timer_index;
 	unsigned long		timer_expires;
 	int			timer_active;
 	unsigned int		ConState;	/* State of connection */
@@ -384,7 +381,7 @@ struct at_state_t {
 	int			int_var[VAR_NUM];	/* see VAR_XXXX */
 	char			*str_var[STR_NUM];	/* see STR_XXXX */
 	unsigned		pending_commands;	/* see PC_XXXX */
-	atomic_t		seq_index;
+	unsigned		seq_index;
 
 	struct cardstate	*cs;
 	struct bc_state		*bcs;
@@ -484,10 +481,11 @@ struct cardstate {
 	unsigned fwver[4];
 	int gotfwver;
 
-	atomic_t running;		/* !=0 if events are handled */
-	atomic_t connected;		/* !=0 if hardware is connected */
+	unsigned running;		/* !=0 if events are handled */
+	unsigned connected;		/* !=0 if hardware is connected */
+	unsigned isdn_up;		/* !=0 after ISDN_STAT_RUN */
 
-	atomic_t cidmode;
+	unsigned cidmode;
 
 	int myid;			/* id for communication with LL */
 	isdn_if iif;
@@ -528,7 +526,7 @@ struct cardstate {
 
 	/* event queue */
 	struct event_t events[MAX_EVENTS];
-	atomic_t ev_tail, ev_head;
+	unsigned ev_tail, ev_head;
 	spinlock_t ev_lock;
 
 	/* current modem response */
@@ -824,7 +822,7 @@ static inline void gigaset_schedule_even
 {
 	unsigned long flags;
 	spin_lock_irqsave(&cs->lock, flags);
-	if (atomic_read(&cs->running))
+	if (cs->running)
 		tasklet_schedule(&cs->event_tasklet);
 	spin_unlock_irqrestore(&cs->lock, flags);
 }
--- linux-2.6.16-gig-doc/drivers/isdn/gigaset/common.c	2006-04-02 18:44:29.000000000 +0200
+++ linux-2.6.16-gig-atomic/drivers/isdn/gigaset/common.c	2006-04-02 18:46:19.000000000 +0200
@@ -129,11 +129,6 @@ int gigaset_enterconfigmode(struct cards
 {
 	int i, r;
 
-	if (!atomic_read(&cs->connected)) {
-		err("not connected!");
-		return -1;
-	}
-
 	cs->control_state = TIOCM_RTS; //FIXME
 
 	r = setflags(cs, TIOCM_DTR, 200);
@@ -176,7 +171,7 @@ static int test_timeout(struct at_state_
 	}
 
 	if (!gigaset_add_event(at_state->cs, at_state, EV_TIMEOUT, NULL,
-			       atomic_read(&at_state->timer_index), NULL)) {
+			       at_state->timer_index, NULL)) {
 		//FIXME what should we do?
 	}
 
@@ -204,7 +199,7 @@ static void timer_tick(unsigned long dat
 		if (test_timeout(at_state))
 			timeout = 1;
 
-	if (atomic_read(&cs->running)) {
+	if (cs->running) {
 		mod_timer(&cs->timer, jiffies + msecs_to_jiffies(GIG_TICK));
 		if (timeout) {
 			gig_dbg(DEBUG_CMD, "scheduling timeout");
@@ -298,20 +293,22 @@ static void clear_events(struct cardstat
 {
 	struct event_t *ev;
 	unsigned head, tail;
+	unsigned long flags;
 
-	/* no locking needed (no reader/writer allowed) */
+	spin_lock_irqsave(&cs->ev_lock, flags);
 
-	head = atomic_read(&cs->ev_head);
-	tail = atomic_read(&cs->ev_tail);
+	head = cs->ev_head;
+	tail = cs->ev_tail;
 
 	while (tail != head) {
 		ev = cs->events + head;
 		kfree(ev->ptr);
-
 		head = (head + 1) % MAX_EVENTS;
 	}
 
-	atomic_set(&cs->ev_head, tail);
+	cs->ev_head = tail;
+
+	spin_unlock_irqrestore(&cs->ev_lock, flags);
 }
 
 struct event_t *gigaset_add_event(struct cardstate *cs,
@@ -324,9 +321,9 @@ struct event_t *gigaset_add_event(struct
 
 	spin_lock_irqsave(&cs->ev_lock, flags);
 
-	tail = atomic_read(&cs->ev_tail);
+	tail = cs->ev_tail;
 	next = (tail + 1) % MAX_EVENTS;
-	if (unlikely(next == atomic_read(&cs->ev_head)))
+	if (unlikely(next == cs->ev_head))
 		err("event queue full");
 	else {
 		event = cs->events + tail;
@@ -336,7 +333,7 @@ struct event_t *gigaset_add_event(struct
 		event->ptr = ptr;
 		event->arg = arg;
 		event->parameter = parameter;
-		atomic_set(&cs->ev_tail, next);
+		cs->ev_tail = next;
 	}
 
 	spin_unlock_irqrestore(&cs->ev_lock, flags);
@@ -454,7 +451,7 @@ void gigaset_freecs(struct cardstate *cs
 		goto f_bcs;
 
 	spin_lock_irqsave(&cs->lock, flags);
-	atomic_set(&cs->running, 0);
+	cs->running = 0;
 	spin_unlock_irqrestore(&cs->lock, flags); /* event handler and timer are
 						     not rescheduled below */
 
@@ -513,8 +510,8 @@ void gigaset_at_init(struct at_state_t *
 	at_state->pending_commands = 0;
 	at_state->timer_expires = 0;
 	at_state->timer_active = 0;
-	atomic_set(&at_state->timer_index, 0);
-	atomic_set(&at_state->seq_index, 0);
+	at_state->timer_index = 0;
+	at_state->seq_index = 0;
 	at_state->ConState = 0;
 	for (i = 0; i < STR_NUM; ++i)
 		at_state->str_var[i] = NULL;
@@ -665,6 +662,7 @@ struct cardstate *gigaset_initcs(struct 
 				 int cidmode, const char *modulename)
 {
 	struct cardstate *cs = NULL;
+	unsigned long flags;
 	int i;
 
 	gig_dbg(DEBUG_INIT, "allocating cs");
@@ -685,11 +683,11 @@ struct cardstate *gigaset_initcs(struct 
 	cs->onechannel = onechannel;
 	cs->ignoreframes = ignoreframes;
 	INIT_LIST_HEAD(&cs->temp_at_states);
-	atomic_set(&cs->running, 0);
+	cs->running = 0;
 	init_timer(&cs->timer); /* clear next & prev */
 	spin_lock_init(&cs->ev_lock);
-	atomic_set(&cs->ev_tail, 0);
-	atomic_set(&cs->ev_head, 0);
+	cs->ev_tail = 0;
+	cs->ev_head = 0;
 	mutex_init(&cs->mutex);
 	mutex_lock(&cs->mutex);
 	
@@ -701,7 +699,7 @@ struct cardstate *gigaset_initcs(struct 
 	cs->open_count = 0;
 	cs->dev = NULL;
 	cs->tty = NULL;
-	atomic_set(&cs->cidmode, cidmode != 0);
+	cs->cidmode = cidmode != 0;
 
 	//if(onechannel) { //FIXME
 		cs->tabnocid = gigaset_tab_nocid_m10x;
@@ -737,7 +735,8 @@ struct cardstate *gigaset_initcs(struct 
 	} else
 		gigaset_inbuf_init(cs->inbuf, NULL,    cs, INS_command);
 
-	atomic_set(&cs->connected, 0);
+	cs->connected = 0;
+	cs->isdn_up = 0;
 
 	gig_dbg(DEBUG_INIT, "setting up cmdbuf");
 	cs->cmdbuf = cs->lastcmdbuf = NULL;
@@ -761,7 +760,9 @@ struct cardstate *gigaset_initcs(struct 
 
 	gigaset_if_init(cs);
 
-	atomic_set(&cs->running, 1);
+	spin_lock_irqsave(&cs->lock, flags);
+	cs->running = 1;
+	spin_unlock_irqrestore(&cs->lock, flags);
 	setup_timer(&cs->timer, timer_tick, (unsigned long) cs);
 	cs->timer.expires = jiffies + msecs_to_jiffies(GIG_TICK);
 	/* FIXME: can jiffies increase too much until the timer is added?
@@ -871,10 +872,14 @@ static void cleanup_cs(struct cardstate 
 
 int gigaset_start(struct cardstate *cs)
 {
+	unsigned long flags;
+
 	if (mutex_lock_interruptible(&cs->mutex))
 		return 0;
 
-	atomic_set(&cs->connected, 1);
+	spin_lock_irqsave(&cs->lock, flags);
+	cs->connected = 1;
+	spin_unlock_irqrestore(&cs->lock, flags);
 
 	if (atomic_read(&cs->mstate) != MS_LOCKED) {
 		cs->ops->set_modem_ctrl(cs, 0, TIOCM_DTR|TIOCM_RTS);
@@ -950,11 +955,6 @@ void gigaset_stop(struct cardstate *cs)
 {
 	mutex_lock(&cs->mutex);
 
-	/* clear device sysfs */
-	gigaset_free_dev_sysfs(cs);
-
-	atomic_set(&cs->connected, 0);
-
 	cs->waiting = 1;
 
 	if (!gigaset_add_event(cs, &cs->at_state, EV_STOP, NULL, 0, NULL)) {
@@ -970,8 +970,8 @@ void gigaset_stop(struct cardstate *cs)
 		//FIXME
 	}
 
-	/* Tell the LL that the device is not available .. */
-	gigaset_i4l_cmd(cs, ISDN_STAT_STOP); // FIXME move to event layer?
+	/* clear device sysfs */
+	gigaset_free_dev_sysfs(cs);
 
 	cleanup_cs(cs);
 
--- linux-2.6.16-gig-doc/drivers/isdn/gigaset/ev-layer.c	2006-04-02 18:44:29.000000000 +0200
+++ linux-2.6.16-gig-atomic/drivers/isdn/gigaset/ev-layer.c	2006-04-02 18:46:19.000000000 +0200
@@ -482,14 +482,6 @@ static int isdn_gethex(char *p)
 	return v;
 }
 
-static inline void new_index(atomic_t *index, int max)
-{
-	if (atomic_read(index) == max)	//FIXME race?
-		atomic_set(index, 0);
-	else
-		atomic_inc(index);
-}
-
 /* retrieve CID from parsed response
  * returns 0 if no CID, -1 if invalid CID, or CID value 1..65535
  */
@@ -581,8 +573,8 @@ void gigaset_handle_modem_response(struc
 	}
 
 	spin_lock_irqsave(&cs->ev_lock, flags);
-	head = atomic_read(&cs->ev_head);
-	tail = atomic_read(&cs->ev_tail);
+	head = cs->ev_head;
+	tail = cs->ev_tail;
 
 	abort = 1;
 	curarg = 0;
@@ -715,7 +707,7 @@ void gigaset_handle_modem_response(struc
 			break;
 	}
 
-	atomic_set(&cs->ev_tail, tail);
+	cs->ev_tail = tail;
 	spin_unlock_irqrestore(&cs->ev_lock, flags);
 
 	if (curarg != params)
@@ -734,14 +726,16 @@ static void disconnect(struct at_state_t
 	struct bc_state *bcs = (*at_state_p)->bcs;
 	struct cardstate *cs = (*at_state_p)->cs;
 
-	new_index(&(*at_state_p)->seq_index, MAX_SEQ_INDEX);
+	spin_lock_irqsave(&cs->lock, flags);
+	++(*at_state_p)->seq_index;
 
 	/* revert to selected idle mode */
-	if (!atomic_read(&cs->cidmode)) {
+	if (!cs->cidmode) {
 		cs->at_state.pending_commands |= PC_UMMODE;
 		atomic_set(&cs->commands_pending, 1); //FIXME
 		gig_dbg(DEBUG_CMD, "Scheduling PC_UMMODE");
 	}
+	spin_unlock_irqrestore(&cs->lock, flags);
 
 	if (bcs) {
 		/* B channel assigned: invoke hardware specific handler */
@@ -933,17 +927,21 @@ static void bchannel_up(struct bc_state 
 	gigaset_i4l_channel_cmd(bcs, ISDN_STAT_BCONN);
 }
 
-static void start_dial(struct at_state_t *at_state, void *data, int seq_index)
+static void start_dial(struct at_state_t *at_state, void *data, unsigned seq_index)
 {
 	struct bc_state *bcs = at_state->bcs;
 	struct cardstate *cs = at_state->cs;
 	int retval;
+	unsigned long flags;
 
 	bcs->chstate |= CHS_NOTIFY_LL;
-	//atomic_set(&bcs->status, BCS_INIT);
 
-	if (atomic_read(&at_state->seq_index) != seq_index)
+	spin_lock_irqsave(&cs->lock, flags);
+	if (at_state->seq_index != seq_index) {
+		spin_unlock_irqrestore(&cs->lock, flags);
 		goto error;
+	}
+	spin_unlock_irqrestore(&cs->lock, flags);
 
 	retval = gigaset_isdn_setup_dial(at_state, data);
 	if (retval != 0)
@@ -988,6 +986,7 @@ static void do_start(struct cardstate *c
 	if (atomic_read(&cs->mstate) != MS_LOCKED)
 		schedule_init(cs, MS_INIT);
 
+	cs->isdn_up = 1;
 	gigaset_i4l_cmd(cs, ISDN_STAT_RUN);
 					// FIXME: not in locked mode
 					// FIXME 2: only after init sequence
@@ -1003,6 +1002,12 @@ static void finish_shutdown(struct cards
 		atomic_set(&cs->mode, M_UNKNOWN);
 	}
 
+	/* Tell the LL that the device is not available .. */
+	if (cs->isdn_up) {
+		cs->isdn_up = 0;
+		gigaset_i4l_cmd(cs, ISDN_STAT_STOP);
+	}
+
 	/* The rest is done by cleanup_cs () in user mode. */
 
 	cs->cmd_result = -ENODEV;
@@ -1025,6 +1030,12 @@ static void do_shutdown(struct cardstate
 
 static void do_stop(struct cardstate *cs)
 {
+	unsigned long flags;
+
+	spin_lock_irqsave(&cs->lock, flags);
+	cs->connected = 0;
+	spin_unlock_irqrestore(&cs->lock, flags);
+
 	do_shutdown(cs);
 }
 
@@ -1153,7 +1164,7 @@ static int do_unlock(struct cardstate *c
 	atomic_set(&cs->mstate, MS_UNINITIALIZED);
 	atomic_set(&cs->mode, M_UNKNOWN);
 	gigaset_free_channels(cs);
-	if (atomic_read(&cs->connected))
+	if (cs->connected)
 		schedule_init(cs, MS_INIT);
 
 	return 0;
@@ -1185,11 +1196,14 @@ static void do_action(int action, struct
 		cs->at_state.pending_commands &= ~PC_INIT;
 		cs->cur_at_seq = SEQ_NONE;
 		atomic_set(&cs->mode, M_UNIMODEM);
-		if (!atomic_read(&cs->cidmode)) {
+		spin_lock_irqsave(&cs->lock, flags);
+		if (!cs->cidmode) {
+			spin_unlock_irqrestore(&cs->lock, flags);
 			gigaset_free_channels(cs);
 			atomic_set(&cs->mstate, MS_READY);
 			break;
 		}
+		spin_unlock_irqrestore(&cs->lock, flags);
 		cs->at_state.pending_commands |= PC_CIDMODE;
 		atomic_set(&cs->commands_pending, 1);
 		gig_dbg(DEBUG_CMD, "Scheduling PC_CIDMODE");
@@ -1536,8 +1550,9 @@ static void do_action(int action, struct
 
 	/* events from the proc file system */ // FIXME without ACT_xxxx?
 	case ACT_PROC_CIDMODE:
-		if (ev->parameter != atomic_read(&cs->cidmode)) {
-			atomic_set(&cs->cidmode, ev->parameter);
+		spin_lock_irqsave(&cs->lock, flags);
+		if (ev->parameter != cs->cidmode) {
+			cs->cidmode = ev->parameter;
 			if (ev->parameter) {
 				cs->at_state.pending_commands |= PC_CIDMODE;
 				gig_dbg(DEBUG_CMD, "Scheduling PC_CIDMODE");
@@ -1547,6 +1562,7 @@ static void do_action(int action, struct
 			}
 			atomic_set(&cs->commands_pending, 1);
 		}
+		spin_unlock_irqrestore(&cs->lock, flags);
 		cs->waiting = 0;
 		wake_up(&cs->waitqueue);
 		break;
@@ -1615,8 +1631,9 @@ static void process_event(struct cardsta
 	/* Setting the pointer to the dial array */
 	rep = at_state->replystruct;
 
+	spin_lock_irqsave(&cs->lock, flags);
 	if (ev->type == EV_TIMEOUT) {
-		if (ev->parameter != atomic_read(&at_state->timer_index)
+		if (ev->parameter != at_state->timer_index
 		    || !at_state->timer_active) {
 			ev->type = RSP_NONE; /* old timeout */
 			gig_dbg(DEBUG_ANY, "old timeout");
@@ -1625,6 +1642,7 @@ static void process_event(struct cardsta
 		else
 			gig_dbg(DEBUG_ANY, "stopped waiting");
 	}
+	spin_unlock_irqrestore(&cs->lock, flags);
 
 	/* if the response belongs to a variable in at_state->int_var[VAR_XXXX]
 	   or at_state->str_var[STR_XXXX], set it */
@@ -1686,7 +1704,7 @@ static void process_event(struct cardsta
 		} else {
 			/* Send command to modem if not NULL... */
 			if (p_command/*rep->command*/) {
-				if (atomic_read(&cs->connected))
+				if (cs->connected)
 					send_command(cs, p_command,
 						     sendcid, cs->dle,
 						     GFP_ATOMIC);
@@ -1703,8 +1721,7 @@ static void process_event(struct cardsta
 			} else if (rep->timeout > 0) { /* new timeout */
 				at_state->timer_expires = rep->timeout * 10;
 				at_state->timer_active = 1;
-				new_index(&at_state->timer_index,
-					  MAX_TIMER_INDEX);
+				++at_state->timer_index;
 			}
 			spin_unlock_irqrestore(&cs->lock, flags);
 		}
@@ -1724,6 +1741,7 @@ static void process_command_flags(struct
 	struct bc_state *bcs;
 	int i;
 	int sequence;
+	unsigned long flags;
 
 	atomic_set(&cs->commands_pending, 0);
 
@@ -1773,8 +1791,9 @@ static void process_command_flags(struct
 	}
 
 	/* only switch back to unimodem mode, if no commands are pending and no channels are up */
+	spin_lock_irqsave(&cs->lock, flags);
 	if (cs->at_state.pending_commands == PC_UMMODE
-	    && !atomic_read(&cs->cidmode)
+	    && !cs->cidmode
 	    && list_empty(&cs->temp_at_states)
 	    && atomic_read(&cs->mode) == M_CID) {
 		sequence = SEQ_UMMODE;
@@ -1788,6 +1807,7 @@ static void process_command_flags(struct
 			}
 		}
 	}
+	spin_unlock_irqrestore(&cs->lock, flags);
 	cs->at_state.pending_commands &= ~PC_UMMODE;
 	if (sequence != SEQ_NONE) {
 		schedule_sequence(cs, at_state, sequence);
@@ -1900,18 +1920,21 @@ static void process_events(struct cardst
 	int i;
 	int check_flags = 0;
 	int was_busy;
+	unsigned long flags;
 
-	/* no locking needed (only one reader) */
-	head = atomic_read(&cs->ev_head);
+	spin_lock_irqsave(&cs->ev_lock, flags);
+	head = cs->ev_head;
 
 	for (i = 0; i < 2 * MAX_EVENTS; ++i) {
-		tail = atomic_read(&cs->ev_tail);
+		tail = cs->ev_tail;
 		if (tail == head) {
 			if (!check_flags && !atomic_read(&cs->commands_pending))
 				break;
 			check_flags = 0;
+			spin_unlock_irqrestore(&cs->ev_lock, flags);
 			process_command_flags(cs);
-			tail = atomic_read(&cs->ev_tail);
+			spin_lock_irqsave(&cs->ev_lock, flags);
+			tail = cs->ev_tail;
 			if (tail == head) {
 				if (!atomic_read(&cs->commands_pending))
 					break;
@@ -1921,16 +1944,20 @@ static void process_events(struct cardst
 
 		ev = cs->events + head;
 		was_busy = cs->cur_at_seq != SEQ_NONE;
+		spin_unlock_irqrestore(&cs->ev_lock, flags);
 		process_event(cs, ev);
+		spin_lock_irqsave(&cs->ev_lock, flags);
 		kfree(ev->ptr);
 		ev->ptr = NULL;
 		if (was_busy && cs->cur_at_seq == SEQ_NONE)
 			check_flags = 1;
 
 		head = (head + 1) % MAX_EVENTS;
-		atomic_set(&cs->ev_head, head);
+		cs->ev_head = head;
 	}
 
+	spin_unlock_irqrestore(&cs->ev_lock, flags);
+
 	if (i == 2 * MAX_EVENTS) {
 		dev_err(cs->dev,
 			"infinite loop in process_events; aborting.\n");
--- linux-2.6.16-gig-doc/drivers/isdn/gigaset/i4l.c	2006-04-02 18:44:29.000000000 +0200
+++ linux-2.6.16-gig-atomic/drivers/isdn/gigaset/i4l.c	2006-04-02 18:46:28.000000000 +0200
@@ -56,11 +56,6 @@ static int writebuf_from_LL(int driverID
 		"Receiving data from LL (id: %d, ch: %d, ack: %d, sz: %d)",
 		driverID, channel, ack, len);
 
-	if (!atomic_read(&cs->connected)) {
-		err("%s: disconnected", __func__);
-		return -ENODEV;
-	}
-
 	if (!len) {
 		if (ack)
 			notice("%s: not ACKing empty packet", __func__);
@@ -78,7 +73,7 @@ static int writebuf_from_LL(int driverID
 		len, skblen, (unsigned) skb->head[0], (unsigned) skb->head[1]);
 
 	/* pass to device-specific module */
-	return cs->ops->send_skb(bcs, skb);
+	return cs->ops->send_skb(bcs, skb); //FIXME cs->ops->send_skb() must handle !cs->connected correctly
 }
 
 void gigaset_skb_sent(struct bc_state *bcs, struct sk_buff *skb)
@@ -119,11 +114,12 @@ static int command_from_LL(isdn_ctrl *cn
 	struct bc_state *bcs;
 	int retval = 0;
 	struct setup_parm *sp;
+	unsigned param;
+	unsigned long flags;
 
 	gigaset_debugdrivers();
 
-	//FIXME "remove test for &connected"
-	if ((!cs || !atomic_read(&cs->connected))) {
+	if (!cs) {
 		warn("LL tried to access unknown device with nr. %d",
 		     cntrl->driver);
 		return -ENODEV;
@@ -166,8 +162,11 @@ static int command_from_LL(isdn_ctrl *cn
 		}
 		*sp = cntrl->parm.setup;
 
-		if (!gigaset_add_event(cs, &bcs->at_state, EV_DIAL, sp,
-				       atomic_read(&bcs->at_state.seq_index),
+		spin_lock_irqsave(&cs->lock, flags);
+		param = bcs->at_state.seq_index;
+		spin_unlock_irqrestore(&cs->lock, flags);
+
+		if (!gigaset_add_event(cs, &bcs->at_state, EV_DIAL, sp, param,
 				       NULL)) {
 			//FIXME what should we do?
 			kfree(sp);
--- linux-2.6.16-gig-doc/drivers/isdn/gigaset/interface.c	2006-04-02 18:43:41.000000000 +0200
+++ linux-2.6.16-gig-atomic/drivers/isdn/gigaset/interface.c	2006-04-02 18:46:28.000000000 +0200
@@ -33,7 +33,7 @@ static int if_lock(struct cardstate *cs,
 	}
 
 	if (!cmd && atomic_read(&cs->mstate) == MS_LOCKED
-	    && atomic_read(&cs->connected)) {
+	    && cs->connected) {
 		cs->ops->set_modem_ctrl(cs, 0, TIOCM_DTR|TIOCM_RTS);
 		cs->ops->baud_rate(cs, B115200);
 		cs->ops->set_line_ctrl(cs, CS8);
@@ -107,6 +107,11 @@ static int if_config(struct cardstate *c
 	if (atomic_read(&cs->mstate) != MS_LOCKED)
 		return -EBUSY;
 
+	if (!cs->connected) {
+		err("not connected!");
+		return -ENODEV;
+	}
+
 	*arg = 0;
 	return gigaset_enterconfigmode(cs);
 }
@@ -246,7 +251,7 @@ static int if_ioctl(struct tty_struct *t
 			break;
 		case GIGASET_BRKCHARS:
 			//FIXME test if MS_LOCKED
-			if (!atomic_read(&cs->connected)) {
+			if (!cs->connected) {
 				gig_dbg(DEBUG_ANY,
 				    "can't communicate with unplugged device");
 				retval = -ENODEV;
@@ -327,7 +332,7 @@ static int if_tiocmset(struct tty_struct
 	if (mutex_lock_interruptible(&cs->mutex))
 		return -ERESTARTSYS; // FIXME -EINTR?
 
-	if (!atomic_read(&cs->connected)) {
+	if (!cs->connected) {
 		gig_dbg(DEBUG_ANY, "can't communicate with unplugged device");
 		retval = -ENODEV;
 	} else {
@@ -362,7 +367,7 @@ static int if_write(struct tty_struct *t
 	else if (atomic_read(&cs->mstate) != MS_LOCKED) {
 		warn("can't write to unlocked device");
 		retval = -EBUSY;
-	} else if (!atomic_read(&cs->connected)) {
+	} else if (!cs->connected) {
 		gig_dbg(DEBUG_ANY, "can't write to unplugged device");
 		retval = -EBUSY; //FIXME
 	} else {
@@ -396,7 +401,7 @@ static int if_write_room(struct tty_stru
 	else if (atomic_read(&cs->mstate) != MS_LOCKED) {
 		warn("can't write to unlocked device");
 		retval = -EBUSY; //FIXME
-	} else if (!atomic_read(&cs->connected)) {
+	} else if (!cs->connected) {
 		gig_dbg(DEBUG_ANY, "can't write to unplugged device");
 		retval = -EBUSY; //FIXME
 	} else
@@ -428,7 +433,7 @@ static int if_chars_in_buffer(struct tty
 	else if (atomic_read(&cs->mstate) != MS_LOCKED) {
 		warn("can't write to unlocked device");
 		retval = -EBUSY;
-	} else if (!atomic_read(&cs->connected)) {
+	} else if (!cs->connected) {
 		gig_dbg(DEBUG_ANY, "can't write to unplugged device");
 		retval = -EBUSY; //FIXME
 	} else
@@ -508,7 +513,7 @@ static void if_set_termios(struct tty_st
 		goto out;
 	}
 
-	if (!atomic_read(&cs->connected)) {
+	if (!cs->connected) {
 		gig_dbg(DEBUG_ANY, "can't communicate with unplugged device");
 		goto out;
 	}
--- linux-2.6.16-gig-doc/drivers/isdn/gigaset/proc.c	2006-04-02 18:44:29.000000000 +0200
+++ linux-2.6.16-gig-atomic/drivers/isdn/gigaset/proc.c	2006-04-02 18:46:28.000000000 +0200
@@ -19,8 +19,15 @@
 static ssize_t show_cidmode(struct device *dev, struct device_attribute *attr,
 			    char *buf)
 {
+	int ret;
+	unsigned long flags;
 	struct cardstate *cs = dev_get_drvdata(dev);
-	return sprintf(buf, "%d\n", atomic_read(&cs->cidmode));
+
+	spin_lock_irqsave(&cs->lock, flags);
+	ret = sprintf(buf, "%u\n", cs->cidmode);
+	spin_unlock_irqrestore(&cs->lock, flags);
+
+	return ret;
 }
 
 static ssize_t set_cidmode(struct device *dev, struct device_attribute *attr,
--- linux-2.6.16-gig-doc/drivers/isdn/gigaset/bas-gigaset.c	2006-04-02 18:44:29.000000000 +0200
+++ linux-2.6.16-gig-atomic/drivers/isdn/gigaset/bas-gigaset.c	2006-04-02 18:46:19.000000000 +0200
@@ -367,7 +367,7 @@ static void cmd_in_timeout(unsigned long
 	unsigned long flags;
 
 	spin_lock_irqsave(&cs->lock, flags);
-	if (unlikely(!atomic_read(&cs->connected))) {
+	if (unlikely(!cs->connected)) {
 		gig_dbg(DEBUG_USBREQ, "%s: disconnected", __func__);
 		spin_unlock_irqrestore(&cs->lock, flags);
 		return;
@@ -475,11 +475,6 @@ static void read_int_callback(struct urb
 	unsigned l;
 	int channel;
 
-	if (unlikely(!atomic_read(&cs->connected))) {
-		warn("%s: disconnected", __func__);
-		return;
-	}
-
 	switch (urb->status) {
 	case 0:			/* success */
 		break;
@@ -603,7 +598,9 @@ static void read_int_callback(struct urb
 	check_pending(ucs);
 
 resubmit:
-	status = usb_submit_urb(urb, SLAB_ATOMIC);
+	spin_lock_irqsave(&cs->lock, flags);
+	status = cs->connected ? usb_submit_urb(urb, SLAB_ATOMIC) : -ENODEV;
+	spin_unlock_irqrestore(&cs->lock, flags);
 	if (unlikely(status)) {
 		dev_err(cs->dev, "could not resubmit interrupt URB: %s\n",
 			get_usb_statmsg(status));
@@ -628,7 +625,7 @@ static void read_ctrl_callback(struct ur
 	unsigned long flags;
 
 	spin_lock_irqsave(&cs->lock, flags);
-	if (unlikely(!atomic_read(&cs->connected))) {
+	if (unlikely(!cs->connected)) {
 		warn("%s: disconnected", __func__);
 		spin_unlock_irqrestore(&cs->lock, flags);
 		return;
@@ -949,6 +946,7 @@ static int submit_iso_write_urb(struct i
 	struct bas_bc_state *ubc = ucx->bcs->hw.bas;
 	struct usb_iso_packet_descriptor *ifd;
 	int corrbytes, nframe, rc;
+	unsigned long flags;
 
 	/* urb->dev is clobbered by USB subsystem */
 	urb->dev = ucx->bcs->cs->hw.bas->udev;
@@ -995,7 +993,11 @@ static int submit_iso_write_urb(struct i
 		ifd->actual_length = 0;
 	}
 	if ((urb->number_of_packets = nframe) > 0) {
-		if ((rc = usb_submit_urb(urb, SLAB_ATOMIC)) != 0) {
+		spin_lock_irqsave(&ucx->bcs->cs->lock, flags);
+		rc = ucx->bcs->cs->connected ? usb_submit_urb(urb, SLAB_ATOMIC) : -ENODEV;
+		spin_unlock_irqrestore(&ucx->bcs->cs->lock, flags);
+
+		if (rc) {
 			dev_err(ucx->bcs->cs->dev,
 				"could not submit isochronous write URB: %s\n",
 				get_usb_statmsg(rc));
@@ -1029,11 +1031,6 @@ static void write_iso_tasklet(unsigned l
 
 	/* loop while completed URBs arrive in time */
 	for (;;) {
-		if (unlikely(!atomic_read(&cs->connected))) {
-			warn("%s: disconnected", __func__);
-			return;
-		}
-
 		if (unlikely(!(atomic_read(&ubc->running)))) {
 			gig_dbg(DEBUG_ISO, "%s: not running", __func__);
 			return;
@@ -1190,11 +1187,6 @@ static void read_iso_tasklet(unsigned lo
 
 	/* loop while more completed URBs arrive in the meantime */
 	for (;;) {
-		if (unlikely(!atomic_read(&cs->connected))) {
-			warn("%s: disconnected", __func__);
-			return;
-		}
-
 		/* retrieve URB */
 		spin_lock_irqsave(&ubc->isoinlock, flags);
 		if (!(urb = ubc->isoindone)) {
@@ -1298,7 +1290,10 @@ static void read_iso_tasklet(unsigned lo
 		urb->dev = bcs->cs->hw.bas->udev;
 		urb->transfer_flags = URB_ISO_ASAP;
 		urb->number_of_packets = BAS_NUMFRAMES;
-		if ((rc = usb_submit_urb(urb, SLAB_ATOMIC)) != 0) {
+		spin_lock_irqsave(&cs->lock, flags);
+		rc = cs->connected ? usb_submit_urb(urb, SLAB_ATOMIC) : -ENODEV;
+		spin_unlock_irqrestore(&cs->lock, flags);
+		if (rc) {
 			dev_err(cs->dev,
 				"could not resubmit isochronous read URB: %s\n",
 				get_usb_statmsg(rc));
@@ -1639,6 +1634,7 @@ static void atrdy_timeout(unsigned long 
 static int atwrite_submit(struct cardstate *cs, unsigned char *buf, int len)
 {
 	struct bas_cardstate *ucs = cs->hw.bas;
+	unsigned long flags;
 	int ret;
 
 	gig_dbg(DEBUG_USBREQ, "-------> HD_WRITE_ATMESSAGE (%d)", len);
@@ -1659,7 +1655,11 @@ static int atwrite_submit(struct cardsta
 			     (unsigned char*) &ucs->dr_cmd_out, buf, len,
 			     write_command_callback, cs);
 
-	if ((ret = usb_submit_urb(ucs->urb_cmd_out, SLAB_ATOMIC)) != 0) {
+	spin_lock_irqsave(&cs->lock, flags);
+	ret = cs->connected ? usb_submit_urb(ucs->urb_cmd_out, SLAB_ATOMIC) : -ENODEV;
+	spin_unlock_irqrestore(&cs->lock, flags);
+
+	if (ret) {
 		dev_err(cs->dev, "could not submit HD_WRITE_ATMESSAGE: %s\n",
 			get_usb_statmsg(ret));
 		return ret;
@@ -1758,11 +1758,6 @@ static int gigaset_write_cmd(struct card
 			     DEBUG_TRANSCMD : DEBUG_LOCKCMD,
 			   "CMD Transmit", len, buf);
 
-	if (unlikely(!atomic_read(&cs->connected))) {
-		err("%s: disconnected", __func__);
-		return -ENODEV;
-	}
-
 	if (len <= 0)
 		return 0;			/* nothing to do */
 
@@ -2186,6 +2181,7 @@ static int gigaset_probe(struct usb_inte
 
 error:
 	freeurbs(cs);
+	usb_set_intfdata(interface, NULL);
 	gigaset_unassign(cs);
 	return -ENODEV;
 }
--- linux-2.6.16-gig-doc/drivers/isdn/gigaset/isocdata.c	2006-04-02 18:44:06.000000000 +0200
+++ linux-2.6.16-gig-atomic/drivers/isdn/gigaset/isocdata.c	2006-04-02 18:46:28.000000000 +0200
@@ -990,13 +990,17 @@ void gigaset_isoc_input(struct inbuf_t *
 int gigaset_isoc_send_skb(struct bc_state *bcs, struct sk_buff *skb)
 {
 	int len = skb->len;
+	unsigned long flags;
 
 	skb_queue_tail(&bcs->squeue, skb);
 	gig_dbg(DEBUG_ISO, "%s: skb queued, qlen=%d",
 		__func__, skb_queue_len(&bcs->squeue));
 
 	/* tasklet submits URB if necessary */
-	tasklet_schedule(&bcs->hw.bas->sent_tasklet);
+	spin_lock_irqsave(&bcs->cs->lock, flags);
+	if (bcs->cs->connected)
+		tasklet_schedule(&bcs->hw.bas->sent_tasklet);
+	spin_unlock_irqrestore(&bcs->cs->lock, flags);
 
 	return len;	/* ok so far */
 }
--- linux-2.6.16-gig-doc/drivers/isdn/gigaset/usb-gigaset.c	2006-04-02 18:44:31.000000000 +0200
+++ linux-2.6.16-gig-atomic/drivers/isdn/gigaset/usb-gigaset.c	2006-04-02 18:46:35.000000000 +0200
@@ -371,13 +371,14 @@ static void gigaset_read_int_callback(st
 	int r;
 	unsigned numbytes;
 	unsigned char *src;
-
-	if (!atomic_read(&cs->connected)) {
-		err("%s: disconnected", __func__);
-		return;
-	}
+	unsigned long flags;
 
 	if (!urb->status) {
+		if (!cs->connected) {
+			err("%s: disconnected", __func__); /* should never happen */
+			return;
+		}
+
 		numbytes = urb->actual_length;
 
 		if (numbytes) {
@@ -399,12 +400,19 @@ static void gigaset_read_int_callback(st
 		/* The urb might have been killed. */
 		gig_dbg(DEBUG_ANY, "%s - nonzero read bulk status received: %d",
 			__func__, urb->status);
-		if (urb->status != -ENOENT) /* not killed */
+		if (urb->status != -ENOENT) { /* not killed */
+			if (!cs->connected) {
+				err("%s: disconnected", __func__); /* should never happen */
+				return;
+			}
 			resubmit = 1;
+		}
 	}
 
 	if (resubmit) {
-		r = usb_submit_urb(urb, SLAB_ATOMIC);
+		spin_lock_irqsave(&cs->lock, flags);
+		r = cs->connected ? usb_submit_urb(urb, SLAB_ATOMIC) : -ENODEV;
+		spin_unlock_irqrestore(&cs->lock, flags);
 		if (r)
 			dev_err(cs->dev, "error %d when resubmitting urb.\n",
 				-r);
@@ -416,21 +424,22 @@ static void gigaset_read_int_callback(st
 static void gigaset_write_bulk_callback(struct urb *urb, struct pt_regs *regs)
 {
 	struct cardstate *cs = urb->context;
+	unsigned long flags;
 
-#ifdef CONFIG_GIGASET_DEBUG
-	if (!atomic_read(&cs->connected)) {
-		err("%s: not connected", __func__);
-		return;
-	}
-#endif
 	if (urb->status)
 		dev_err(cs->dev, "bulk transfer failed (status %d)\n",
 			-urb->status);
 		/* That's all we can do. Communication problems
 		   are handled by timeouts or network protocols. */
 
-	atomic_set(&cs->hw.usb->busy, 0);
-	tasklet_schedule(&cs->write_tasklet);
+	spin_lock_irqsave(&cs->lock, flags);
+	if (!cs->connected) {
+		err("%s: not connected", __func__);
+	} else {
+		atomic_set(&cs->hw.usb->busy, 0);
+		tasklet_schedule(&cs->write_tasklet);
+	}
+	spin_unlock_irqrestore(&cs->lock, flags);
 }
 
 static int send_cb(struct cardstate *cs, struct cmdbuf_t *cb)
@@ -465,6 +474,8 @@ static int send_cb(struct cardstate *cs,
 		}
 		if (cb) {
 			count = min(cb->len, ucs->bulk_out_size);
+			gig_dbg(DEBUG_OUTPUT, "send_cb: send %d bytes", count);
+
 			usb_fill_bulk_urb(ucs->bulk_out_urb, ucs->udev,
 					  usb_sndbulkpipe(ucs->udev,
 					     ucs->bulk_out_endpointAddr & 0x0f),
@@ -474,14 +485,15 @@ static int send_cb(struct cardstate *cs,
 			cb->offset += count;
 			cb->len -= count;
 			atomic_set(&ucs->busy, 1);
-			gig_dbg(DEBUG_OUTPUT, "send_cb: send %d bytes", count);
 
-			status = usb_submit_urb(ucs->bulk_out_urb, SLAB_ATOMIC);
+			spin_lock_irqsave(&cs->lock, flags);
+			status = cs->connected ? usb_submit_urb(ucs->bulk_out_urb, SLAB_ATOMIC) : -ENODEV;
+			spin_unlock_irqrestore(&cs->lock, flags);
+
 			if (status) {
 				atomic_set(&ucs->busy, 0);
-				dev_err(cs->dev,
-					"could not submit urb (error %d)\n",
-					-status);
+				err("could not submit urb (error %d)\n",
+				    -status);
 				cb->len = 0; /* skip urb => remove cb+wakeup
 						in next loop cycle */
 			}
@@ -502,11 +514,6 @@ static int gigaset_write_cmd(struct card
 			     DEBUG_TRANSCMD : DEBUG_LOCKCMD,
 			   "CMD Transmit", len, buf);
 
-	if (!atomic_read(&cs->connected)) {
-		err("%s: not connected", __func__);
-		return -ENODEV;
-	}
-
 	if (len <= 0)
 		return 0;
 
@@ -533,7 +540,10 @@ static int gigaset_write_cmd(struct card
 	cs->lastcmdbuf = cb;
 	spin_unlock_irqrestore(&cs->cmdlock, flags);
 
-	tasklet_schedule(&cs->write_tasklet);
+	spin_lock_irqsave(&cs->lock, flags);
+	if (cs->connected)
+		tasklet_schedule(&cs->write_tasklet);
+	spin_unlock_irqrestore(&cs->lock, flags);
 	return len;
 }
 
@@ -629,6 +639,7 @@ static int write_modem(struct cardstate 
 	int count;
 	struct bc_state *bcs = &cs->bcs[0]; /* only one channel */
 	struct usb_cardstate *ucs = cs->hw.usb;
+	unsigned long flags;
 
 	gig_dbg(DEBUG_WRITE, "len: %d...", bcs->tx_skb->len);
 
@@ -644,20 +655,27 @@ static int write_modem(struct cardstate 
 	count = min(bcs->tx_skb->len, (unsigned) ucs->bulk_out_size);
 	memcpy(ucs->bulk_out_buffer, bcs->tx_skb->data, count);
 	skb_pull(bcs->tx_skb, count);
-
-	usb_fill_bulk_urb(ucs->bulk_out_urb, ucs->udev,
-			  usb_sndbulkpipe(ucs->udev,
-					  ucs->bulk_out_endpointAddr & 0x0f),
-			  ucs->bulk_out_buffer, count,
-			  gigaset_write_bulk_callback, cs);
 	atomic_set(&ucs->busy, 1);
 	gig_dbg(DEBUG_OUTPUT, "write_modem: send %d bytes", count);
 
-	ret = usb_submit_urb(ucs->bulk_out_urb, SLAB_ATOMIC);
+	spin_lock_irqsave(&cs->lock, flags);
+	if (cs->connected) {
+		usb_fill_bulk_urb(ucs->bulk_out_urb, ucs->udev,
+				  usb_sndbulkpipe(ucs->udev,
+						  ucs->bulk_out_endpointAddr & 0x0f),
+				  ucs->bulk_out_buffer, count,
+				  gigaset_write_bulk_callback, cs);
+		ret = usb_submit_urb(ucs->bulk_out_urb, SLAB_ATOMIC);
+	} else {
+		ret = -ENODEV;
+	}
+	spin_unlock_irqrestore(&cs->lock, flags);
+
 	if (ret) {
-		dev_err(cs->dev, "could not submit urb (error %d)\n", -ret);
+		err("could not submit urb (error %d)\n", -ret);
 		atomic_set(&ucs->busy, 0);
 	}
+
 	if (!bcs->tx_skb->len) {
 		/* skb sent completely */
 		gigaset_skb_sent(bcs, bcs->tx_skb); //FIXME also, when ret<0?
--- linux-2.6.16-gig-doc/drivers/isdn/gigaset/asyncdata.c	2006-04-02 18:44:29.000000000 +0200
+++ linux-2.6.16-gig-atomic/drivers/isdn/gigaset/asyncdata.c	2006-04-02 18:46:19.000000000 +0200
@@ -566,19 +566,22 @@ static struct sk_buff *iraw_encode(struc
 int gigaset_m10x_send_skb(struct bc_state *bcs, struct sk_buff *skb)
 {
 	unsigned len = skb->len;
+	unsigned long flags;
 
 	if (bcs->proto2 == ISDN_PROTO_L2_HDLC)
 		skb = HDLC_Encode(skb, HW_HDR_LEN, 0);
 	else
 		skb = iraw_encode(skb, HW_HDR_LEN, 0);
 	if (!skb) {
-		dev_err(bcs->cs->dev,
-			"unable to allocate memory for encoding!\n");
+		err("unable to allocate memory for encoding!\n");
 		return -ENOMEM;
 	}
 
 	skb_queue_tail(&bcs->squeue, skb);
-	tasklet_schedule(&bcs->cs->write_tasklet);
+	spin_lock_irqsave(&bcs->cs->lock, flags);
+	if (bcs->cs->connected)
+		tasklet_schedule(&bcs->cs->write_tasklet);
+	spin_unlock_irqrestore(&bcs->cs->lock, flags);
 
 	return len;	/* ok so far */
 }
