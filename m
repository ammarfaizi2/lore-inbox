Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263354AbTHWVnP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Aug 2003 17:43:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263482AbTHWVnP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Aug 2003 17:43:15 -0400
Received: from smtp807.mail.sc5.yahoo.com ([66.163.168.186]:35626 "HELO
	smtp807.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S263499AbTHWVnI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Aug 2003 17:43:08 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 2.6] 2/3 Serio: possible race in handle_events
Date: Sat, 23 Aug 2003 16:42:41 -0500
User-Agent: KMail/1.5.1
Cc: linux-kernel@vger.kernel.org, vojtech@suse.cz
References: <200308230131.45474.dtor_core@ameritech.net> <200308230225.10308.dtor_core@ameritech.net> <20030823003447.24aa1efc.akpm@osdl.org>
In-Reply-To: <20030823003447.24aa1efc.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308231642.43888.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 23 August 2003 02:34 am, Andrew Morton wrote:
> Dmitry Torokhov <dtor_core@ameritech.net> wrote:
> > Do you think we should introduce allocate_serio/free_serio pair for
> > dynamically allocated serios; free_serio would scan event_list and
> > invalidate events that refer to freed serio?
>
> I don't understand the subsystem well enough to say.  But if we are
> receiving events which refer to an already-freed serio then something is
> very broken.  We should be draining all those events before allowing the
> original object to be freed up.
>
> Let's wait for Vojtech's comments.

I think the patch below should work. We invalidate serio events at the same
time serio itself is unregistered.

The patch is on top of the 3 previous ones + synaptics, but if needed I can 
rediff against vanilla kernel.


diff -urN --exclude-from=/usr/src/exclude 2.6.0-test4/drivers/input/serio/serio.c linux-2.6.0-test4/drivers/input/serio/serio.c
--- 2.6.0-test4/drivers/input/serio/serio.c	2003-08-23 00:38:10.000000000 -0500
+++ linux-2.6.0-test4/drivers/input/serio/serio.c	2003-08-23 16:28:28.000000000 -0500
@@ -89,14 +89,13 @@
 static DECLARE_WAIT_QUEUE_HEAD(serio_wait);
 static DECLARE_COMPLETION(serio_exited);
 
-static int is_known_serio(struct serio *serio)
+static void serio_invalidate_pending_events(struct serio *serio)
 {
-	struct serio *s;
+	struct serio_event *event;
 	
-	list_for_each_entry(s, &serio_list, node)
-		if (s == serio)
-			return 1;
-	return 0;
+	list_for_each_entry(event, &serio_event_list, node)
+		if (event->serio == serio)
+			event->serio = NULL;
 }
 
 void serio_handle_events(void)
@@ -108,7 +107,7 @@
 		event = container_of(node, struct serio_event, node);	
 
 		down(&serio_sem);
-		if (!is_known_serio(event->serio))
+		if (event->serio == NULL)
 			goto event_done;
 		
 		switch (event->type) {
@@ -213,6 +212,7 @@
 void serio_unregister_port(struct serio *serio)
 {
 	down(&serio_sem);
+	serio_invalidate_pending_events(serio);
 	list_del_init(&serio->node);
 	if (serio->dev && serio->dev->disconnect)
 		serio->dev->disconnect(serio);
@@ -226,6 +226,7 @@
  */
 void serio_unregister_slave_port(struct serio *serio)
 {
+	serio_invalidate_pending_events(serio);
 	list_del_init(&serio->node);
 	if (serio->dev && serio->dev->disconnect)
 		serio->dev->disconnect(serio);
