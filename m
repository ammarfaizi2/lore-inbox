Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263776AbTKXRBT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Nov 2003 12:01:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263794AbTKXRBT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Nov 2003 12:01:19 -0500
Received: from gprs145-34.eurotel.cz ([160.218.145.34]:27520 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S263776AbTKXRBM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Nov 2003 12:01:12 -0500
Date: Mon, 24 Nov 2003 12:05:04 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Petr Vandrovec <vandrove@vc.cvut.cz>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Fix locking in input
Message-ID: <20031124110504.GA9843@elf.ucw.cz>
References: <20031122155224.GA249@elf.ucw.cz> <20031123134140.GE22591@vana.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031123134140.GE22591@vana.vc.cvut.cz>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > input uses "volatile signed char" as a shared variable between normal
> > and interrupt threads (look at _sendbyte()). Thats bad idea, this
> > switches it to atomic_t.
> > 
> > I did not dare to store -1 o atomic ariable, that's why I switched -1
> > to +2.
> > 
> > I hope I do not break compilation somewhere, otherwise its trivial...
> 
> It is not.
> 
> > @@ -220,14 +220,14 @@
> >  static int kbd98_sendbyte(struct kbd98 *kbd98, unsigned char byte)
> >  {
> >  	int timeout = 10000; /* 100 msec */
> > -	kbd98->ack = 0;
> > +	atomic_set(&kbd98->ack, 0);
> >  
> >  	if (serio_write(kbd98->serio, byte))
> >  		return -1;
> >  
> > -	while (!kbd98->ack && timeout--) udelay(10);
> > +	while (!atomic_read(&kbd98->ack) && timeout--) udelay(10);
> >  
> > -	return -(kbd98->ack <= 0);
> > +	return -(atomic_read(&kbd98->ack) == 2);
> >  }
> 
> <= 0 is not same as == 2. You need atomic_read(&kbd98->ack) == 0 || ... == 2 to
> get same behavior. No ack means error.

Yep, right. This should fix it.
								Pavel

--- linux.orig/drivers/input/keyboard/atkbd.c	2003-11-24 11:30:30.000000000 +0100
+++ linux/drivers/input/keyboard/atkbd.c	2003-11-24 10:31:28.000000000 +0100
@@ -145,7 +145,7 @@
 	unsigned char set;
 	unsigned char release;
 	int lastkey;
-	volatile signed char ack;
+	atomic_t ack;
 	unsigned char emul;
 	unsigned short id;
 	unsigned char write;
@@ -214,10 +214,10 @@
 
 	switch (code) {
 		case ATKBD_RET_ACK:
-			atkbd->ack = 1;
+			atomic_set(&atkbd->ack, 1);
 			goto out;
 		case ATKBD_RET_NAK:
-			atkbd->ack = -1;
+			atomic_set(&atkbd->ack, 2);
 			goto out;
 	}
 
@@ -294,7 +294,7 @@
 static int atkbd_sendbyte(struct atkbd *atkbd, unsigned char byte)
 {
 	int timeout = 20000; /* 200 msec */
-	atkbd->ack = 0;
+	atomic_set(&atkbd->ack, 0);
 
 #ifdef ATKBD_DEBUG
 	printk(KERN_DEBUG "atkbd.c: Sent: %02x\n", byte);
@@ -302,9 +302,9 @@
 	if (serio_write(atkbd->serio, byte))
 		return -1;
 
-	while (!atkbd->ack && timeout--) udelay(10);
+	while (!atomic_read(&atkbd->ack) && timeout--) udelay(10);
 
-	return -(atkbd->ack <= 0);
+	return -(atomic_read(&atkbd->ack) != 1);
 }
 
 /*
--- linux.orig/drivers/input/keyboard/98kbd.c	2003-11-24 11:30:30.000000000 +0100
+++ linux/drivers/input/keyboard/98kbd.c	2003-11-24 11:29:07.000000000 +0100
@@ -100,7 +100,7 @@
 	char phys[32];
 	unsigned char cmdbuf[4];
 	unsigned char cmdcnt;
-	signed char ack;
+	atomic_t ack;
 	unsigned char shift;
 	struct {
 		unsigned char scancode;
@@ -118,10 +118,10 @@
 
 	switch (data) {
 		case KBD98_RET_ACK:
-			kbd98->ack = 1;
+			atomic_set(&kbd98->ack, 1);
 			return;
 		case KBD98_RET_NAK:
-			kbd98->ack = -1;
+			atomic_set(&kbd98->ack, 2);
 			return;
 	}
 
@@ -220,14 +220,14 @@
 static int kbd98_sendbyte(struct kbd98 *kbd98, unsigned char byte)
 {
 	int timeout = 10000; /* 100 msec */
-	kbd98->ack = 0;
+	atomic_set(&kbd98->ack, 0);
 
 	if (serio_write(kbd98->serio, byte))
 		return -1;
 
-	while (!kbd98->ack && timeout--) udelay(10);
+	while (!atomic_read(&kbd98->ack) && timeout--) udelay(10);
 
-	return -(kbd98->ack <= 0);
+	return -(atomic_read(&kbd98->ack) != 1);
 }
 
 /*
--- linux.orig/drivers/input/mouse/psmouse-base.c	2003-11-24 11:30:30.000000000 +0100
+++ linux/drivers/input/mouse/psmouse-base.c	2003-11-24 11:29:30.000000000 +0100
@@ -121,13 +121,14 @@
 	if (psmouse->acking) {
 		switch (data) {
 			case PSMOUSE_RET_ACK:
-				psmouse->ack = 1;
+				atomic_set(&psmouse->ack, 1);
 				break;
 			case PSMOUSE_RET_NAK:
-				psmouse->ack = -1;
+				atomic_set(&psmouse->ack, 2);
 				break;
 			default:
-				psmouse->ack = 1;	/* Workaround for mice which don't ACK the Get ID command */
+				/* Workaround for mice which don't ACK the Get ID command */
+				atomic_set(&psmouse->ack, 1);
 				if (psmouse->cmdcnt)
 					psmouse->cmdbuf[--psmouse->cmdcnt] = data;
 				break;
@@ -197,7 +198,7 @@
 static int psmouse_sendbyte(struct psmouse *psmouse, unsigned char byte)
 {
 	int timeout = 10000; /* 100 msec */
-	psmouse->ack = 0;
+	atomic_set(&psmouse->ack, 0);
 	psmouse->acking = 1;
 
 	if (serio_write(psmouse->serio, byte)) {
@@ -205,9 +206,9 @@
 		return -1;
 	}
 
-	while (!psmouse->ack && timeout--) udelay(10);
+	while (!atomic_read(&psmouse->ack) && timeout--) udelay(10);
 
-	return -(psmouse->ack <= 0);
+	return -(atomic_read(&psmouse->ack) != 1);
 }
 
 /*
Index: linux/drivers/input/mouse/psmouse.h
===================================================================
--- linux.orig/drivers/input/mouse/psmouse.h	2003-11-24 11:30:30.000000000 +0100
+++ linux/drivers/input/mouse/psmouse.h	2003-11-24 11:29:43.000000000 +0100
@@ -37,7 +37,7 @@
 	unsigned long last;
 	unsigned char state;
 	char acking;
-	volatile char ack;
+	atomic_t ack;	/* This is being accessed without locking, at least make sure we do not run into alignment problems */
 	char error;
 	char devname[64];
 	char phys[32];


-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
