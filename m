Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290434AbSAXWvD>; Thu, 24 Jan 2002 17:51:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290444AbSAXWus>; Thu, 24 Jan 2002 17:50:48 -0500
Received: from 213.237.12.194.adsl.brh.worldonline.dk ([213.237.12.194]:50155
	"HELO firewall.jaquet.dk") by vger.kernel.org with SMTP
	id <S290445AbSAXWtx>; Thu, 24 Jan 2002 17:49:53 -0500
Date: Thu, 24 Jan 2002 23:49:44 +0100
From: Rasmus Andersen <rasmus@jaquet.dk>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: lkml <linux-kernel@vger.kernel.org>, R.E.Wolff@BitWizard.nl
Subject: Re: Linux 2.4.18-pre7
Message-ID: <20020124234943.I825@jaquet.dk>
In-Reply-To: <Pine.LNX.4.21.0201231953410.4134-100000@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.21.0201231953410.4134-100000@freak.distro.conectiva>; from marcelo@conectiva.com.br on Wed, Jan 23, 2002 at 07:55:46PM -0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 23, 2002 at 07:55:46PM -0200, Marcelo Tosatti wrote:
> 
> Hi, 
> 
> So here goes pre7.

Hi Marcelo.
 
This is a resend of a patch I sent you earlier, rediffed. Explanation
below. If you would prefer Rogier Wolff to send it, please let me
know.
 
---
The following patch makes drivers/char/generic_serial.c check the
return code of copy_{from,to}_user, coverts a cli/sti to
save_flags/cli/restore_flags and does some minor cleanup. It
also makes the rio_linux, serial_tx3912, sh-sci and sx drivers
propagate the copy_xxx_user return codes upwards.
 
The patch has been blessed by Rogier Wolff, the maintainer.
---


diff -uar linux-2418p7-clean/drivers/char/generic_serial.c linux-2418p7/drivers/char/generic_serial.c
--- linux-2418p7-clean/drivers/char/generic_serial.c	Fri Sep 14 00:21:32 2001
+++ linux-2418p7/drivers/char/generic_serial.c	Thu Jan 24 23:45:14 2002
@@ -143,7 +143,12 @@
 		/* Can't copy more? break out! */
 		if (c <= 0) break;
 		if (from_user)
-			copy_from_user (port->xmit_buf + port->xmit_head, buf, c);
+                       if (copy_from_user (port->xmit_buf + port->xmit_head, 
+                                           buf, c)) {
+                               up (& port->port_write_sem);
+                               return -EFAULT;
+                       }
+
 		else
 			memcpy         (port->xmit_buf + port->xmit_head, buf, c);
 
@@ -214,8 +219,13 @@
 		while (1) {
 			c = count;
 
-			/* This is safe because we "OWN" the "head". Noone else can 
-			   change the "head": we own the port_write_sem. */
+			/* Note: This part can be done without
+			 * interrupt routine protection since
+			 * the interrupt routines may only modify
+			 * shared variables in safe ways, in the worst
+			 * case causing us to loop twice in the code
+			 * below. See comments below. */ 
+
 			/* Don't overrun the end of the buffer */
 			t = SERIAL_XMIT_SIZE - port->xmit_head;
 			if (t < c) c = t;
@@ -506,7 +516,7 @@
 
 void gs_shutdown_port (struct gs_port *port)
 {
-	long flags;
+	unsigned long flags;
 
 	func_enter();
 	
@@ -589,6 +599,7 @@
 	int    do_clocal = 0;
 	int    CD;
 	struct tty_struct *tty;
+	unsigned long flags;
 
 	func_enter ();
 
@@ -604,7 +615,7 @@
 	 * until it's done, and then try again.
 	 */
 	if (tty_hung_up_p(filp) || port->flags & ASYNC_CLOSING) {
-	  interruptible_sleep_on(&port->close_wait);
+		interruptible_sleep_on(&port->close_wait);
 		if (port->flags & ASYNC_HUP_NOTIFY)
 			return -EAGAIN;
 		else
@@ -668,10 +679,11 @@
 	add_wait_queue(&port->open_wait, &wait);
 
 	gs_dprintk (GS_DEBUG_BTR, "after add waitq.\n"); 
+	save_flags(flags);
 	cli();
 	if (!tty_hung_up_p(filp))
 		port->count--;
-	sti();
+	restore_flags(flags);
 	port->blocked_open++;
 	while (1) {
 		CD = port->rd->get_CD (port);
@@ -1003,7 +1015,8 @@
 {
 	struct serial_struct sio;
 
-	copy_from_user(&sio, sp, sizeof(struct serial_struct));
+	if (copy_from_user(&sio, sp, sizeof(struct serial_struct)))
+		return(-EFAULT);
 
 	if (!capable(CAP_SYS_ADMIN)) {
 		if ((sio.baud_base != port->baud_base) ||
@@ -1033,7 +1046,7 @@
  *      Generate the serial struct info.
  */
 
-void gs_getserial(struct gs_port *port, struct serial_struct *sp)
+int gs_getserial(struct gs_port *port, struct serial_struct *sp)
 {
 	struct serial_struct    sio;
 
@@ -1055,7 +1068,10 @@
 	if (port->rd->getserial)
 		port->rd->getserial (port, &sio);
 
-	copy_to_user(sp, &sio, sizeof(struct serial_struct));
+	if (copy_to_user(sp, &sio, sizeof(struct serial_struct)))
+		return -EFAULT;
+	return 0;
+
 }
 
 
diff -uar linux-2418p7-clean/drivers/char/rio/rio_linux.c linux-2418p7/drivers/char/rio/rio_linux.c
--- linux-2418p7-clean/drivers/char/rio/rio_linux.c	Thu Oct 25 22:53:47 2001
+++ linux-2418p7/drivers/char/rio/rio_linux.c	Thu Jan 24 23:45:14 2002
@@ -742,7 +742,7 @@
   case TIOCGSERIAL:
     if ((rc = verify_area(VERIFY_WRITE, (void *) arg,
                           sizeof(struct serial_struct))) == 0)
-      gs_getserial(&PortP->gs, (struct serial_struct *) arg);
+      rc = gs_getserial(&PortP->gs, (struct serial_struct *) arg);
     break;
   case TCSBRK:
     if ( PortP->State & RIO_DELETED ) {
diff -uar linux-2418p7-clean/drivers/char/serial_tx3912.c linux-2418p7/drivers/char/serial_tx3912.c
--- linux-2418p7-clean/drivers/char/serial_tx3912.c	Fri Nov  9 23:01:21 2001
+++ linux-2418p7/drivers/char/serial_tx3912.c	Thu Jan 24 23:45:14 2002
@@ -673,7 +673,7 @@
 	case TIOCGSERIAL:
 		if ((rc = verify_area(VERIFY_WRITE, (void *) arg,
 		                      sizeof(struct serial_struct))) == 0)
-			gs_getserial(&port->gs, (struct serial_struct *) arg);
+			rc = gs_getserial(&port->gs, (struct serial_struct *) arg);
 		break;
 	case TIOCSSERIAL:
 		if ((rc = verify_area(VERIFY_READ, (void *) arg,
diff -uar linux-2418p7-clean/drivers/char/sh-sci.c linux-2418p7/drivers/char/sh-sci.c
--- linux-2418p7-clean/drivers/char/sh-sci.c	Mon Oct 15 22:36:48 2001
+++ linux-2418p7/drivers/char/sh-sci.c	Thu Jan 24 23:45:14 2002
@@ -919,7 +919,7 @@
 	case TIOCGSERIAL:
 		if ((rc = verify_area(VERIFY_WRITE, (void *) arg,
 		                      sizeof(struct serial_struct))) == 0)
-			gs_getserial(&port->gs, (struct serial_struct *) arg);
+			rc = gs_getserial(&port->gs, (struct serial_struct *) arg);
 		break;
 	case TIOCSSERIAL:
 		if ((rc = verify_area(VERIFY_READ, (void *) arg,
diff -uar linux-2418p7-clean/drivers/char/sx.c linux-2418p7/drivers/char/sx.c
--- linux-2418p7-clean/drivers/char/sx.c	Thu Jan 24 23:37:09 2002
+++ linux-2418p7/drivers/char/sx.c	Thu Jan 24 23:45:14 2002
@@ -1817,7 +1817,7 @@
 	case TIOCGSERIAL:
 		if ((rc = verify_area(VERIFY_WRITE, (void *) arg,
 		                      sizeof(struct serial_struct))) == 0)
-			gs_getserial(&port->gs, (struct serial_struct *) arg);
+			rc = gs_getserial(&port->gs, (struct serial_struct *) arg);
 		break;
 	case TIOCSSERIAL:
 		if ((rc = verify_area(VERIFY_READ, (void *) arg,
diff -uar linux-2418p7-clean/include/linux/generic_serial.h linux-2418p7/include/linux/generic_serial.h
--- linux-2418p7-clean/include/linux/generic_serial.h	Fri Sep  7 18:28:38 2001
+++ linux-2418p7/include/linux/generic_serial.h	Thu Jan 24 23:45:14 2002
@@ -12,9 +12,6 @@
 #ifndef GENERIC_SERIAL_H
 #define GENERIC_SERIAL_H
 
-
-
-
 struct real_driver {
   void                    (*disable_tx_interrupts) (void *);
   void                    (*enable_tx_interrupts) (void *);
@@ -98,7 +95,7 @@
                      struct termios * old_termios);
 int  gs_init_port(struct gs_port *port);
 int  gs_setserial(struct gs_port *port, struct serial_struct *sp);
-void gs_getserial(struct gs_port *port, struct serial_struct *sp);
+int  gs_getserial(struct gs_port *port, struct serial_struct *sp);
 void gs_got_break(struct gs_port *port);
 
 extern int gs_debug;

-- 
Regards,
        Rasmus(rasmus@jaquet.dk)
