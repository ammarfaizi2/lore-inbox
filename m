Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <157500-17480>; Wed, 12 May 1999 13:56:03 -0400
Received: by vger.rutgers.edu id <159987-17480>; Wed, 12 May 1999 09:49:15 -0400
Received: from nicheisdn.inet.it ([194.185.219.229]:1041 "EHLO nicheisdn.inet.it" ident: "root") by vger.rutgers.edu with ESMTP id <154778-17483>; Wed, 12 May 1999 04:42:22 -0400
Date: Wed, 12 May 1999 11:02:20 +0200
From: Luca Lizzeri <ll@niche.it>
To: linux-kernel@vger.rutgers.edu
Subject: ppp and parport waitqueue changes for pre-2.3.1
Message-ID: <19990512110220.A3085@niche.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3us
Sender: owner-linux-kernel@vger.rutgers.edu


Plenty of places (especially sound) are still missing the waitqueue changes.

The ones I made for ppp and parport follow.

Bye,
	Luca


diff -ur linux-vanilla/drivers/misc/parport_share.c linux/drivers/misc/parport_share.c
--- linux-vanilla/drivers/misc/parport_share.c	Wed May 12 10:49:49 1999
+++ linux/drivers/misc/parport_share.c	Wed May 12 10:05:22 1999
@@ -277,7 +277,7 @@
 	inc_parport_count();
 	port->ops->inc_use_count();
 
-	init_waitqueue(&tmp->wait_q);
+	init_waitqueue_head(&tmp->wait_q);
 	tmp->timeslice = PARPORT_DEFAULT_TIMESLICE;
 	tmp->waitnext = tmp->waitprev = NULL;
 
diff -ur linux-vanilla/drivers/net/ppp.c linux/drivers/net/ppp.c
--- linux-vanilla/drivers/net/ppp.c	Wed May 12 10:49:36 1999
+++ linux/drivers/net/ppp.c	Wed May 12 10:43:59 1999
@@ -2834,7 +2834,7 @@
 	ppp->magic = PPP_MAGIC;
 	ppp->next = NULL;
 	ppp->inuse = 1;
-	ppp->read_wait = NULL;
+	init_waitqueue_head(&ppp->read_wait);
 
 	/*
 	 * Make up a suitable name for this device
diff -ur linux-vanilla/include/linux/if_pppvar.h linux/include/linux/if_pppvar.h
--- linux-vanilla/include/linux/if_pppvar.h	Wed May 12 10:49:27 1999
+++ linux/include/linux/if_pppvar.h	Wed May 12 10:40:16 1999
@@ -109,7 +109,7 @@
 	__u16		rfcs;		/* FCS so far of rpkt		*/
 
 	/* Queues for select() functionality */
-	struct wait_queue *read_wait;	/* queue for reading processes	*/
+	wait_queue_head_t	read_wait;	/* queue for reading processes	*/
 
 	/* info for detecting idle channels */
 	unsigned long	last_xmit;	/* time of last transmission	*/
diff -ur linux-vanilla/include/linux/parport.h linux/include/linux/parport.h
--- linux-vanilla/include/linux/parport.h	Wed May 12 10:49:27 1999
+++ linux/include/linux/parport.h	Wed May 12 10:33:48 1999
@@ -163,7 +163,7 @@
 	struct pardevice *next;
 	struct pardevice *prev;
 	struct parport_state *state;     /* saved status over preemption */
-	struct wait_queue *wait_q;
+	wait_queue_head_t wait_q;
 	unsigned long int time;
 	unsigned long int timeslice;
 	unsigned int waiting;


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
