Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129789AbQLFOg3>; Wed, 6 Dec 2000 09:36:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130200AbQLFOgT>; Wed, 6 Dec 2000 09:36:19 -0500
Received: from 13dyn31.delft.casema.net ([212.64.76.31]:24581 "EHLO
	abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
	id <S129789AbQLFOgF>; Wed, 6 Dec 2000 09:36:05 -0500
Date: Wed, 6 Dec 2000 15:05:16 +0100 (CET)
From: Patrick van de Lageweg <patrick@bitwizard.nl>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rogier Wolff <wolff@bitwizard.nl>
Subject: [PATCH] rio 2.2.18pre24
Message-ID: <Pine.LNX.4.21.0012061503560.11253-100000@panoramix.bitwizard.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi alan,

This patches fixes several isues with the rio driver:

 - Implemented breaks
 - Fixed a DCD up/down crash
 - Added kmalloc return value check

Sorry for the late moment we submit this: the DCD bug was very, very hard
to find.

        Patrick

diff -u -r linux-2.2.18-pre24.clean/drivers/char/generic_serial.c linux-2.2.18-pre24.rio_break/drivers/char/generic_serial.c
--- linux-2.2.18-pre24.clean/drivers/char/generic_serial.c	Wed Nov 29 11:10:01 2000
+++ linux-2.2.18-pre24.rio_break/drivers/char/generic_serial.c	Wed Dec  6 14:27:36 2000
@@ -29,7 +29,7 @@
 #include <linux/compatmac.h>
 #include <linux/generic_serial.h>
 
-#define DEBUG 
+#define DEBUG 1
 
 static char *                  tmp_buf; 
 static DECLARE_MUTEX(tmp_buf_sem);
@@ -575,7 +575,7 @@
 	port->flags &= ~(ASYNC_NORMAL_ACTIVE|ASYNC_CALLOUT_ACTIVE |GS_ACTIVE);
 	port->tty = NULL;
 	port->count = 0;
-
+	port->event = 0;
 	wake_up_interruptible(&port->open_wait);
 	func_exit ();
 }
@@ -750,9 +750,13 @@
 	if (!port) return;
 
 	if (!port->tty) {
+		port->rd->hungup (port);
+		return;
+#if 0
 		/* This seems to happen when this is called from vhangup. */
 		gs_dprintk (GS_DEBUG_CLOSE, "gs: Odd: port->tty is NULL\n");
 		port->tty = tty;
+#endif
 	}
 
 	save_flags(flags); cli();
diff -u -r linux-2.2.18-pre24.clean/drivers/char/rio/rio_linux.c linux-2.2.18-pre24.rio_break/drivers/char/rio/rio_linux.c
--- linux-2.2.18-pre24.clean/drivers/char/rio/rio_linux.c	Wed Nov 29 11:10:01 2000
+++ linux-2.2.18-pre24.rio_break/drivers/char/rio/rio_linux.c	Wed Dec  6 14:27:29 2000
@@ -165,7 +165,7 @@
   /* startuptime */     HZ*2,           /* how long to wait for card to run */
   /* slowcook */        0,              /* TRUE -> always use line disc. */
   /* intrpolltime */    1,              /* The frequency of OUR polls */
-  /* breakinterval */   25,             /* x10 mS */
+  /* breakinterval */   25,             /* x10 mS XXX: units seem to be 1ms not 10! -- REW*/
   /* timer */           10,             /* mS */
   /* RtaLoadBase */     0x7000,
   /* HostLoadBase */    0x7C00,
@@ -205,11 +205,11 @@
 static INT rio_fw_release(struct inode *inode, struct file *filp);
 static int rio_init_drivers(void);
 
+int RIOShortCommand(struct rio_info *p, struct Port *PortP, 
+			   int command, int len, int arg);
 
 void my_hd (void *addr, int len);
 
-
-
 static struct tty_driver rio_driver, rio_callout_driver;
 static struct tty_driver rio_driver2, rio_callout_driver2;
 
@@ -458,7 +458,6 @@
   func_enter ();
 
   HostP = (struct Host*)ptr; /* &p->RIOHosts[(long)ptr]; */
-  
   rio_dprintk (RIO_DEBUG_IFLOW, "rio: enter rio_interrupt (%d/%d)\n", 
                irq, HostP->Ivec); 
 
@@ -519,8 +518,8 @@
 
   RIOServiceHost(p, HostP, irq);
 
-  rio_dprintk ( RIO_DEBUG_IFLOW, "riointr() doing host %d type %d\n", 
-                (int) ptr, HostP->Type);
+  rio_dprintk ( RIO_DEBUG_IFLOW, "riointr() doing host %p type %d\n", 
+                ptr, HostP->Type);
 
   clear_bit (RIO_BOARD_INTR_LOCK, &HostP->locks);
   rio_dprintk (RIO_DEBUG_IFLOW, "rio: exit rio_interrupt (%d/%d)\n", 
@@ -627,8 +626,12 @@
 /* Nothing special here... */
 static void rio_shutdown_port (void * ptr) 
 {
+  struct Port *PortP;
+
   func_enter();
 
+  PortP = (struct Port *)ptr;
+  PortP->gs.tty = NULL;
 #if 0
   port->gs.flags &= ~ GS_ACTIVE;
   if (!port->gs.tty) {
@@ -706,9 +709,8 @@
     PortP->gs.count = 0; 
   }                
 
-
+  PortP->gs.tty = NULL;
   rio_dec_mod_count ();
-
   func_exit ();
 }
 
@@ -756,10 +758,36 @@
         (ival ? CLOCAL : 0);
     }
     break;
+
   case TIOCGSERIAL:
     if ((rc = verify_area(VERIFY_WRITE, (void *) arg,
                           sizeof(struct serial_struct))) == 0)
       gs_getserial(&PortP->gs, (struct serial_struct *) arg);
+    break;
+  case TCSBRK:
+    if ( PortP->State & RIO_DELETED ) {
+      rio_dprintk (RIO_DEBUG_TTY, "BREAK on deleted RTA\n");
+      rc = -EIO;      
+    } else {
+      if (RIOShortCommand(p, PortP, SBREAK, 2, 250) == RIO_FAIL) {
+         rio_dprintk (RIO_DEBUG_INTR, "SBREAK RIOShortCommand failed\n");
+         rc = -EIO;
+      }          
+    }
+    break;
+  case TCSBRKP:
+    if ( PortP->State & RIO_DELETED ) {
+      rio_dprintk (RIO_DEBUG_TTY, "BREAK on deleted RTA\n");
+      rc = -EIO;      
+    } else {
+      int l;
+      l = arg?arg*100:250;
+      if (l > 255) l = 255;
+      if (RIOShortCommand(p, PortP, SBREAK, 2, arg?arg*100:250) == RIO_FAIL) {
+         rio_dprintk (RIO_DEBUG_INTR, "SBREAK RIOShortCommand failed\n");
+         rc = -EIO;
+      }          
+    }
     break;
   case TIOCSSERIAL:
     if ((rc = verify_area(VERIFY_READ, (void *) arg,
diff -u -r linux-2.2.18-pre24.clean/drivers/char/rio/rio_linux.h linux-2.2.18-pre24.rio_break/drivers/char/rio/rio_linux.h
--- linux-2.2.18-pre24.clean/drivers/char/rio/rio_linux.h	Wed Nov 29 11:10:01 2000
+++ linux-2.2.18-pre24.rio_break/drivers/char/rio/rio_linux.h	Wed Dec  6 11:52:54 2000
@@ -165,7 +165,7 @@
 #define rio_memcpy_fromio                      memcpy_fromio
 #endif
 
-#define DEBUG
+#define DEBUG 1
 
 
 /* 
diff -u -r linux-2.2.18-pre24.clean/drivers/char/rio/riocmd.c linux-2.2.18-pre24.rio_break/drivers/char/rio/riocmd.c
--- linux-2.2.18-pre24.clean/drivers/char/rio/riocmd.c	Fri Dec  1 16:16:59 2000
+++ linux-2.2.18-pre24.rio_break/drivers/char/rio/riocmd.c	Wed Dec  6 10:25:40 2000
@@ -536,7 +536,7 @@
 				     PortP->ModemState, ReportedModemStatus);
 				PortP->ModemState = ReportedModemStatus;
 #ifdef MODEM_SUPPORT
-				if ( PortP->Mapped ) {
+				if ( PortP->Mapped && (PortP->PortState & PORT_ISOPEN) && !(PortP->PortState & RIO_CLOSING))  {
 				/***********************************************************\
 				*************************************************************
 				***													   ***
@@ -548,14 +548,14 @@
 				** If the device is a modem, then check the modem
 				** carrier.
 				*/
+
 				if (PortP->gs.tty == NULL)
 					break;
 				if (PortP->gs.tty->termios == NULL)
 					break;
-			  
-				if (!(PortP->gs.tty->termios->c_cflag & CLOCAL) &&
-				((PortP->State & (RIO_MOPEN|RIO_WOPEN)))) {
 
+				if (!(PortP->gs.tty->termios->c_cflag & CLOCAL) &&
+				    ((PortP->State & (RIO_MOPEN|RIO_WOPEN)))) {
 					rio_dprintk (RIO_DEBUG_CMD, "Is there a Carrier?\n");
 			/*
 			** Is there a carrier?
@@ -581,8 +581,9 @@
 			** Has carrier just dropped?
 			*/
 						if (PortP->State & RIO_CARR_ON) {
-							if (PortP->State & (PORT_ISOPEN|RIO_WOPEN|RIO_MOPEN))
-								tty_hangup (PortP->gs.tty);
+						  if (PortP->State & (PORT_ISOPEN|RIO_WOPEN|RIO_MOPEN)) 
+							  tty_hangup (PortP->gs.tty);
+
 							PortP->State &= ~RIO_CARR_ON;
 							rio_dprintk (RIO_DEBUG_CMD, "Carrirer just went down\n");
 #ifdef STATS
diff -u -r linux-2.2.18-pre24.clean/drivers/char/rio/riotty.c linux-2.2.18-pre24.rio_break/drivers/char/rio/riotty.c
--- linux-2.2.18-pre24.clean/drivers/char/rio/riotty.c	Wed Nov 29 11:10:02 2000
+++ linux-2.2.18-pre24.rio_break/drivers/char/rio/riotty.c	Wed Dec  6 10:02:15 2000
@@ -95,7 +95,7 @@
 #endif
 
 static void RIOClearUp(struct Port *PortP);
-static int RIOShortCommand(struct rio_info *p, struct Port *PortP, 
+int RIOShortCommand(struct rio_info *p, struct Port *PortP, 
 			   int command, int len, int arg);
 
 
@@ -793,7 +794,7 @@
 ** Other values of len aren't allowed, and will cause
 ** a panic.
 */
-static int RIOShortCommand(struct rio_info *p, struct Port *PortP,
+int RIOShortCommand(struct rio_info *p, struct Port *PortP,
 		int command, int len, int arg)
 {
 	PKT *PacketP;


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
