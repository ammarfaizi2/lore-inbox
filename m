Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261379AbTIFQlt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Sep 2003 12:41:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261434AbTIFQlt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Sep 2003 12:41:49 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:58128 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261379AbTIFQlo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Sep 2003 12:41:44 -0400
Date: Sat, 6 Sep 2003 17:41:40 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Daniel Ritz <daniel.ritz@gmx.ch>, Sven Dowideit <svenud@ozemail.com.au>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Tom Marshall <tommy@home.tig-grr.com>
Subject: [PATCH] Re: Problems with PCMCIA (Texas Instruments PCI1450)
Message-ID: <20030906174140.C29417@flint.arm.linux.org.uk>
Mail-Followup-To: Daniel Ritz <daniel.ritz@gmx.ch>,
	Sven Dowideit <svenud@ozemail.com.au>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Tom Marshall <tommy@home.tig-grr.com>
References: <200308270056.33190.daniel.ritz@gmx.ch> <200309052019.30051.daniel.ritz@gmx.ch> <20030905193811.C14076@flint.arm.linux.org.uk> <200309052140.27906.daniel.ritz@gmx.ch> <20030905205429.D14076@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030905205429.D14076@flint.arm.linux.org.uk>; from rmk@arm.linux.org.uk on Fri, Sep 05, 2003 at 08:54:29PM +0100
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 05, 2003 at 08:54:29PM +0100, Russell King wrote:
> On Fri, Sep 05, 2003 at 09:40:27PM +0200, Daniel Ritz wrote:
> > On Fri September 5 2003 20:38, Russell King wrote:
> > > On Fri, Sep 05, 2003 at 08:19:28PM +0200, Daniel Ritz wrote:
> > > > ok, now i can reproduce the problem on my ti1410 too. on boot detection
> > > > works fine with an UP kernel and fails with an SMP kernel. thanx for the
> > > > hint.
> > > > 
> > > > i go to look at the csets a bit and try to find out more....
> > > > (i think i know which change...)
> > > 
> > > Care to provide a hint?
> > 
> > yes. just tested. patch below makes on boot detection with a SMP kernel
> > working again (for me). which is nice, but i don't see why it is better
> > that way...
> 
> Ok, now I need to hear from Sven (and others) to see if this patch fixes
> their problems.  Also, are these other people running a SMP kernel as
> well?

Ok, I've updated pcmcia.arm.linux.org.uk with a couple of patches which
should solve the real cause of problem - a nice race condition.  I'm
including the patch here - can people which this problem check whether
it solves the problem on their hardware?

I'd like to hear back from people who have been affected by this bug
before I push this patch to Linus.

Thanks.

diff -ur ref/drivers/pcmcia/cs.c linux/drivers/pcmcia/cs.c
--- ref/drivers/pcmcia/cs.c	Tue Aug  5 11:19:39 2003
+++ linux/drivers/pcmcia/cs.c	Sat Sep  6 15:07:25 2003
@@ -474,7 +474,7 @@
     DEBUG(1, "cs: shutdown_socket(%p)\n", s);
 
     /* Blank out the socket state */
-    s->state &= SOCKET_PRESENT|SOCKET_SETUP_PENDING;
+    s->state &= SOCKET_PRESENT|SOCKET_INUSE;
     s->socket = dead_socket;
     s->ops->init(s);
     s->irq.AssignedIRQ = s->irq.Config = 0;
@@ -657,7 +657,6 @@
 		pcmcia_error(skt, "unsupported voltage key.\n");
 		return CS_BAD_TYPE;
 	}
-	skt->state |= SOCKET_PRESENT;
 	skt->socket.flags = SS_DEBOUNCED;
 	skt->ops->set_socket(skt, &skt->socket);
 
@@ -678,22 +677,23 @@
 {
 	int ret;
 
-	if (!try_module_get(skt->owner))
+	if (!cs_socket_get(skt))
 		return CS_NO_CARD;
 
 	ret = socket_setup(skt, setup_delay);
 	if (ret == CS_SUCCESS) {
+		skt->state |= SOCKET_PRESENT;
 #ifdef CONFIG_CARDBUS
 		if (skt->state & SOCKET_CARDBUS) {
 			cb_alloc(skt);
 			skt->state |= SOCKET_CARDBUS_CONFIG;
 		}
 #endif
 		send_event(skt, CS_EVENT_CARD_INSERTION, CS_EVENT_PRI_LOW);
 		skt->socket.flags &= ~SS_DEBOUNCED;
 	} else {
 		socket_shutdown(skt);
-		module_put(skt->owner);
+		cs_socket_put(skt);
 	}
 
 	return ret;
@@ -741,10 +741,8 @@
 		}
 		skt->socket.flags &= ~SS_DEBOUNCED;
 	} else {
-		unsigned int old_state = skt->state;
 		socket_shutdown(skt);
-		if (old_state & SOCKET_PRESENT)
-			module_put(skt->owner);
+		cs_socket_put(skt);
 	}
 
 	skt->state &= ~SOCKET_SUSPEND;
@@ -755,7 +753,7 @@
 static void socket_remove(struct pcmcia_socket *skt)
 {
 	socket_shutdown(skt);
-	module_put(skt->owner);
+	cs_socket_put(skt);
 }
 
 /*
@@ -1346,8 +1344,6 @@
 	status->CardState |= CS_EVENT_PM_SUSPEND;
     if (!(s->state & SOCKET_PRESENT))
 	return CS_NO_CARD;
-    if (s->state & SOCKET_SETUP_PENDING)
-	status->CardState |= CS_EVENT_CARD_INSERTION;
     
     /* Get info from the PRR, if necessary */
     if (handle->Function == BIND_FN_ALL) {
@@ -1524,6 +1520,10 @@
     if (client == NULL)
 	return CS_OUT_OF_RESOURCE;
 
+    /*
+     * Prevent this racing with a card insertion.
+     */
+    down(&s->skt_sem);
     *handle = client;
     client->state &= ~CLIENT_UNBOUND;
     client->Socket = s;
@@ -1555,13 +1555,15 @@
 	  client, client->Socket, client->dev_info);
     if (client->EventMask & CS_EVENT_REGISTRATION_COMPLETE)
 	EVENT(client, CS_EVENT_REGISTRATION_COMPLETE, CS_EVENT_PRI_LOW);
-    if ((s->state & SOCKET_PRESENT) &&
-	!(s->state & SOCKET_SETUP_PENDING)) {
+
+    if ((s->state & (SOCKET_PRESENT|SOCKET_CARDBUS)) == SOCKET_PRESENT) {
 	if (client->EventMask & CS_EVENT_CARD_INSERTION)
 	    EVENT(client, CS_EVENT_CARD_INSERTION, CS_EVENT_PRI_LOW);
 	else
 	    client->PendingEvents |= CS_EVENT_CARD_INSERTION;
     }
+
+    up(&s->skt_sem);
     return CS_SUCCESS;
 } /* register_client */
 
diff -ur ref/drivers/pcmcia/cs_internal.h linux/drivers/pcmcia/cs_internal.h
--- ref/drivers/pcmcia/cs_internal.h	Tue Aug  5 11:19:39 2003
+++ linux/drivers/pcmcia/cs_internal.h	Sat Sep  6 14:41:19 2003
@@ -99,7 +99,7 @@
 
 /* Flags in socket state */
 #define SOCKET_PRESENT		0x0008
-#define SOCKET_SETUP_PENDING	0x0010
+#define SOCKET_INUSE		0x0010
 #define SOCKET_SHUTDOWN_PENDING	0x0020
 #define SOCKET_RESET_PENDING	0x0040
 #define SOCKET_SUSPEND		0x0080
@@ -109,6 +109,26 @@
 #define SOCKET_CARDBUS		0x8000
 #define SOCKET_CARDBUS_CONFIG	0x10000
 
+static inline int cs_socket_get(struct pcmcia_socket *skt)
+{
+	int ret;
+
+	WARN_ON(skt->state & SOCKET_INUSE);
+
+	ret = try_module_get(skt->owner);
+	if (ret)
+		skt->state |= SOCKET_INUSE;
+	return ret;
+}
+
+static inline void cs_socket_put(struct pcmcia_socket *skt)
+{
+	if (skt->state & SOCKET_INUSE) {
+		skt->state &= ~SOCKET_INUSE;
+		module_put(skt->owner);
+	}
+}
+
 #define CHECK_HANDLE(h) \
     (((h) == NULL) || ((h)->client_magic != CLIENT_MAGIC))
 


-- 
Russell King (rmk@arm.linux.org.uk)	http://www.arm.linux.org.uk/personal/
Linux kernel maintainer of:
  2.6 ARM Linux   - http://www.arm.linux.org.uk/
  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
  2.6 Serial core
