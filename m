Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129593AbQKMW1F>; Mon, 13 Nov 2000 17:27:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129604AbQKMW0z>; Mon, 13 Nov 2000 17:26:55 -0500
Received: from zeus.kernel.org ([209.10.41.242]:13832 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S129593AbQKMW0m>;
	Mon, 13 Nov 2000 17:26:42 -0500
Date: Mon, 13 Nov 2000 21:52:30 +0000 (GMT)
From: David Woodhouse <dwmw2@infradead.org>
To: David Hinds <dhinds@valinux.com>
cc: Jeff Garzik <jgarzik@mandrakesoft.com>, <torvalds@transmeta.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] pcmcia event thread. (fwd)
In-Reply-To: <20001113105931.C1587@valinux.com>
Message-ID: <Pine.LNX.4.30.0011132131350.28525-100000@imladris.demon.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Nov 2000, David Hinds wrote:

> The i82365 and tcic drivers in the 2.4 tree have not been converted to
> use the thread stuff; as far as I know, the yenta driver is the only
> socket driver that works at all in 2.4.

OK. I take it you support my proposed change?

Can you review this patch for i82365.c?

Index: i82365.c
===================================================================
RCS file: /net/passion/inst/cvs/linux/drivers/pcmcia/Attic/i82365.c,v
retrieving revision 1.1.2.14
diff -u -r1.1.2.14 i82365.c
--- i82365.c	2000/06/07 14:48:18	1.1.2.14
+++ i82365.c	2000/11/13 21:49:29
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

-- 
dwmw2


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
