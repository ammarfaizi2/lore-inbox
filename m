Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263356AbTLAG6S (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Dec 2003 01:58:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263369AbTLAG6S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Dec 2003 01:58:18 -0500
Received: from smtp800.mail.ukl.yahoo.com ([217.12.12.142]:63387 "HELO
	smtp800.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S263356AbTLAG6N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Dec 2003 01:58:13 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: [2.6 RFC/PATCH] Input: possible deadlock in i8042
Date: Mon, 1 Dec 2003 01:58:01 -0500
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org, Vojtech Pavlik <vojtech@suse.cz>,
       Andrew Morton <akpm@osdl.org>
References: <200311300303.57654.dtor_core@ameritech.net> <20031130090009.GA17038@ucw.cz>
In-Reply-To: <20031130090009.GA17038@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312010158.02698.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 30 November 2003 04:00 am, Vojtech Pavlik wrote:
> On Sun, Nov 30, 2003 at 03:03:57AM -0500, Dmitry Torokhov wrote:
> > If request_irq fails in i8042_open it will call
> > serio_unregister_port, which takes serio_sem. i8042_open may be
> > called:
> >
> > serio_register_port - serio_find_dev - dev->connect
> > serio_register_device - dev->connect
> >
> > Both serio_register_port and serio_register_device take serio_sem as
> > well.
> >
> > I think that serio_{register|unregister}_port can be converted into
> > submitting requests to kseriod thus removing deadlock on the
> > serio_sem.
> >
> > The patch below is on top of serio* patches in Andrew Morton's -mm
> > tree.
>
> It's nice to avoid the deadlock this way, but I think it's not a good
> idea to make the register/unregister asynchronous - it could be a nasty
> surprise for an unsuspecting driver writer.
>

OK, you were right, it's not a good idea to convert _all_ calls to
asynchronous versions as my patch throughly screwed up module unloading.
Still, I think it is OK to export separate asynchronous versions of the
functions to be used as needed. 

The patch below implements 2 new functions, serio_register_port_delayed 
and serio_unregister_port_delayed that submit appropriate to kseriod.

The patch to convert i8042 to use it will follow shortly.

Dmitry


===================================================================


ChangeSet@1.1512, 2003-11-30 23:29:06-05:00, dtor_core@ameritech.net
  Input: Add serio_[un]register_port_delayed to allow delayed
         execution of register/unregister code (via kseriod)
         when it is not clear whether serio_sem has been taken
         or not.


 drivers/input/serio/serio.c |   38 +++++++++++++++++++++++++++++++++++---
 include/linux/serio.h       |    2 ++
 2 files changed, 37 insertions(+), 3 deletions(-)


===================================================================



diff -Nru a/drivers/input/serio/serio.c b/drivers/input/serio/serio.c
--- a/drivers/input/serio/serio.c	Mon Dec  1 01:15:33 2003
+++ b/drivers/input/serio/serio.c	Mon Dec  1 01:15:33 2003
@@ -49,8 +49,10 @@
 
 EXPORT_SYMBOL(serio_interrupt);
 EXPORT_SYMBOL(serio_register_port);
+EXPORT_SYMBOL(serio_register_port_delayed);
 EXPORT_SYMBOL(__serio_register_port);
 EXPORT_SYMBOL(serio_unregister_port);
+EXPORT_SYMBOL(serio_unregister_port_delayed);
 EXPORT_SYMBOL(__serio_unregister_port);
 EXPORT_SYMBOL(serio_register_device);
 EXPORT_SYMBOL(serio_unregister_device);
@@ -83,8 +85,10 @@
 	}
 }
 
-#define SERIO_RESCAN	1
-#define SERIO_RECONNECT	2
+#define SERIO_RESCAN		1
+#define SERIO_RECONNECT		2
+#define SERIO_REGISTER_PORT	3
+#define SERIO_UNREGISTER_PORT	4
 
 static DECLARE_WAIT_QUEUE_HEAD(serio_wait);
 static DECLARE_COMPLETION(serio_exited);
@@ -111,6 +115,14 @@
 			goto event_done;
 		
 		switch (event->type) {
+			case SERIO_REGISTER_PORT :
+				__serio_register_port(event->serio);
+				break;
+
+			case SERIO_UNREGISTER_PORT :
+				__serio_unregister_port(event->serio);
+				break;
+
 			case SERIO_RECONNECT :
 				if (event->serio->dev && event->serio->dev->reconnect)
 					if (event->serio->dev->reconnect(event->serio) == 0)
@@ -198,8 +210,18 @@
 }
 
 /*
+ * Submits register request to kseriod for subsequent execution.
+ * Can be used when it is not obvious whether the serio_sem is
+ * taken or not and when delayed execution is feasible.
+ */
+void serio_register_port_delayed(struct serio *serio)
+{
+	serio_queue_event(serio, SERIO_REGISTER_PORT);
+}
+
+/*
  * Should only be called directly if serio_sem has already been taken,
- * for example when unregistering a serio from other input device's 
+ * for example when registering a serio from other input device's 
  * connect() function.
  */
 void __serio_register_port(struct serio *serio)
@@ -213,6 +235,16 @@
 	down(&serio_sem);
 	__serio_unregister_port(serio);
 	up(&serio_sem);
+}
+
+/*
+ * Submits unregister request to kseriod for subsequent execution.
+ * Can be used when it is not obvious whether the serio_sem is
+ * taken or not and when delayed execution is feasible.
+ */
+void serio_unregister_port_delayed(struct serio *serio)
+{
+	serio_queue_event(serio, SERIO_UNREGISTER_PORT);
 }
 
 /*
diff -Nru a/include/linux/serio.h b/include/linux/serio.h
--- a/include/linux/serio.h	Mon Dec  1 01:15:33 2003
+++ b/include/linux/serio.h	Mon Dec  1 01:15:33 2003
@@ -63,8 +63,10 @@
 irqreturn_t serio_interrupt(struct serio *serio, unsigned char data, unsigned int flags, struct pt_regs *regs);
 
 void serio_register_port(struct serio *serio);
+void serio_register_port_delayed(struct serio *serio);
 void __serio_register_port(struct serio *serio);
 void serio_unregister_port(struct serio *serio);
+void serio_unregister_port_delayed(struct serio *serio);
 void __serio_unregister_port(struct serio *serio);
 void serio_register_device(struct serio_dev *dev);
 void serio_unregister_device(struct serio_dev *dev);
