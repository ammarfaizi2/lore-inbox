Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280132AbRLGNLs>; Fri, 7 Dec 2001 08:11:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280114AbRLGNLg>; Fri, 7 Dec 2001 08:11:36 -0500
Received: from 213.237.12.194.adsl.brh.worldonline.dk ([213.237.12.194]:5093
	"HELO firewall.jaquet.dk") by vger.kernel.org with SMTP
	id <S280805AbRLGNLW>; Fri, 7 Dec 2001 08:11:22 -0500
Date: Fri, 7 Dec 2001 14:11:15 +0100
From: Rasmus Andersen <rasmus@jaquet.dk>
To: marcelo@conectiva.com.br
Cc: R.E.Wolff@BitWizard.nl, linux-kernel@vger.kernel.org
Subject: [PATCH] returning errors from copy_xxx_user in generic_serial.c (2417p4)
Message-ID: <20011207141115.D3329@jaquet.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo.

The following patch makes drivers/char/generic_serial.c check the
return code of copy_{from,to}_user, coverts a cli/sti to 
save_flags/cli/restore_flags and does some minor cleanup. It
also makes the rio_linux, serial_tx3912, sh-sci and sx drivers
propagate the copy_xxx_user return codes upwards.

The patch has been blessed by Rogier Wolff, the maintainer,
compiles and survives test loads. It applies against 2417p4
with tiny fuzz.


--- linux-2414-kbuild-clean/drivers/char/generic_serial.c	Thu Oct 11 20:52:37 2001
+++ linux-2414/drivers/char/generic_serial.c	Thu Dec  6 14:40:02 2001
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
 
 
diff -aur linux-2414-kbuild-clean/drivers/char/rio/rio_linux.c linux-2414/drivers/char/rio/rio_linux.c
--- linux-2414-kbuild-clean/drivers/char/rio/rio_linux.c	Tue Nov  6 20:16:57 2001
+++ linux-2414/drivers/char/rio/rio_linux.c	Fri Nov 16 20:52:00 2001
@@ -742,7 +742,7 @@
   case TIOCGSERIAL:
     if ((rc = verify_area(VERIFY_WRITE, (void *) arg,
                           sizeof(struct serial_struct))) == 0)
-      gs_getserial(&PortP->gs, (struct serial_struct *) arg);
+      rc = gs_getserial(&PortP->gs, (struct serial_struct *) arg);
     break;
   case TCSBRK:
     if ( PortP->State & RIO_DELETED ) {
diff -aur linux-2414-kbuild-clean/drivers/char/serial_tx3912.c linux-2414/drivers/char/serial_tx3912.c
--- linux-2414-kbuild-clean/drivers/char/serial_tx3912.c	Wed Oct 31 21:04:43 2001
+++ linux-2414/drivers/char/serial_tx3912.c	Fri Nov 16 20:52:00 2001
@@ -673,7 +673,7 @@
 	case TIOCGSERIAL:
 		if ((rc = verify_area(VERIFY_WRITE, (void *) arg,
 		                      sizeof(struct serial_struct))) == 0)
-			gs_getserial(&port->gs, (struct serial_struct *) arg);
+			rc = gs_getserial(&port->gs, (struct serial_struct *) arg);
 		break;
 	case TIOCSSERIAL:
 		if ((rc = verify_area(VERIFY_READ, (void *) arg,
diff -aur linux-2414-kbuild-clean/drivers/char/sh-sci.c linux-2414/drivers/char/sh-sci.c
--- linux-2414-kbuild-clean/drivers/char/sh-sci.c	Wed Oct 31 21:08:37 2001
+++ linux-2414/drivers/char/sh-sci.c	Fri Nov 16 20:52:00 2001
@@ -919,7 +919,7 @@
 	case TIOCGSERIAL:
 		if ((rc = verify_area(VERIFY_WRITE, (void *) arg,
 		                      sizeof(struct serial_struct))) == 0)
-			gs_getserial(&port->gs, (struct serial_struct *) arg);
+			rc = gs_getserial(&port->gs, (struct serial_struct *) arg);
 		break;
 	case TIOCSSERIAL:
 		if ((rc = verify_area(VERIFY_READ, (void *) arg,
diff -aur linux-2414-kbuild-clean/drivers/char/sx.c linux-2414/drivers/char/sx.c
--- linux-2414-kbuild-clean/drivers/char/sx.c	Thu Oct 11 20:52:39 2001
+++ linux-2414/drivers/char/sx.c	Fri Nov 16 20:52:00 2001
@@ -1810,7 +1810,7 @@
 	case TIOCGSERIAL:
 		if ((rc = verify_area(VERIFY_WRITE, (void *) arg,
 		                      sizeof(struct serial_struct))) == 0)
-			gs_getserial(&port->gs, (struct serial_struct *) arg);
+			rc = gs_getserial(&port->gs, (struct serial_struct *) arg);
 		break;
 	case TIOCSSERIAL:
 		if ((rc = verify_area(VERIFY_READ, (void *) arg,
diff -aur linux-2414-kbuild-clean/include/linux/generic_serial.h linux-2414/include/linux/generic_serial.h
--- linux-2414-kbuild-clean/include/linux/generic_serial.h	Thu Oct 11 20:53:04 2001
+++ linux-2414/include/linux/generic_serial.h	Fri Nov 16 20:54:49 2001
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
        Rasmus(rasmus@jaquet.dk)

Cutler Webster's Law: There are two sides to every argument, unless a 
person is personally involved, in which case there is only one. 

