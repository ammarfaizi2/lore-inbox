Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129257AbQLANdo>; Fri, 1 Dec 2000 08:33:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129226AbQLANde>; Fri, 1 Dec 2000 08:33:34 -0500
Received: from 13dyn218.delft.casema.net ([212.64.76.218]:9482 "EHLO
	abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
	id <S129255AbQLANdV>; Fri, 1 Dec 2000 08:33:21 -0500
Date: Fri, 1 Dec 2000 14:02:51 +0100 (CET)
From: Patrick van de Lageweg <patrick@bitwizard.nl>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] rio (This time with patch) 
Message-ID: <Pine.LNX.4.21.0012011402390.14960-100000@panoramix.bitwizard.nl>
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

diff -u -r linux-2.2.18-pre24.clean/drivers/char/rio/rio_linux.c linux-2.2.18-pre24.rio_break/drivers/char/rio/rio_linux.c
--- linux-2.2.18-pre24.clean/drivers/char/rio/rio_linux.c	Wed Nov 29 11:10:01 2000
+++ linux-2.2.18-pre24.rio_break/drivers/char/rio/rio_linux.c	Fri Dec  1 09:33:23 2000
@@ -165,7 +165,7 @@
   /* startuptime */     HZ*2,           /* how long to wait for card to run */
   /* slowcook */        0,              /* TRUE -> always use line disc. */
   /* intrpolltime */    1,              /* The frequency of OUR polls */
-  /* breakinterval */   25,             /* x10 mS */
+  /* breakinterval */   25,             /* x10 mS XXX: units seem to be 1ms not 10! -- REW*/
   /* timer */           10,             /* mS */
   /* RtaLoadBase */     0x7000,
   /* HostLoadBase */    0x7C00,
@@ -205,11 +205,8 @@
 static INT rio_fw_release(struct inode *inode, struct file *filp);
 static int rio_init_drivers(void);
 
-
 void my_hd (void *addr, int len);
 
-
-
 static struct tty_driver rio_driver, rio_callout_driver;
 static struct tty_driver rio_driver2, rio_callout_driver2;
 
@@ -458,7 +455,6 @@
   func_enter ();
 
   HostP = (struct Host*)ptr; /* &p->RIOHosts[(long)ptr]; */
-  
   rio_dprintk (RIO_DEBUG_IFLOW, "rio: enter rio_interrupt (%d/%d)\n", 
                irq, HostP->Ivec); 
 
@@ -519,7 +515,7 @@
 
   RIOServiceHost(p, HostP, irq);
 
-  rio_dprintk ( RIO_DEBUG_IFLOW, "riointr() doing host %d type %d\n", 
+  rio_dprintk ( RIO_DEBUG_IFLOW, "riointr() doing host %p type %d\n", 
                 (int) ptr, HostP->Type);
 
   clear_bit (RIO_BOARD_INTR_LOCK, &HostP->locks);
@@ -627,8 +623,12 @@
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
@@ -681,8 +681,14 @@
    exit minicom.  I expect an "oops".  -- REW */
 static void rio_hungup (void *ptr)
 {
-  func_enter ();
+  struct Port *PortP;
+
+  func_enter();
+  
+  PortP = (struct Port *)ptr;
+  PortP->gs.tty = NULL;
   rio_dec_mod_count (); 
+
   func_exit ();
 }
 
@@ -706,9 +712,8 @@
     PortP->gs.count = 0; 
   }                
 
-
+  PortP->gs.tty = NULL;
   rio_dec_mod_count ();
-
   func_exit ();
 }
 
@@ -756,10 +761,36 @@
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
+++ linux-2.2.18-pre24.rio_break/drivers/char/rio/rio_linux.h	Fri Dec  1 09:59:56 2000
@@ -165,7 +165,7 @@
 #define rio_memcpy_fromio                      memcpy_fromio
 #endif
 
-#define DEBUG
+#define DEBUG 1
 
 
 /* 
diff -u -r linux-2.2.18-pre24.clean/drivers/char/rio/riointr.c linux-2.2.18-pre24.rio_break/drivers/char/rio/riointr.c
--- linux-2.2.18-pre24.clean/drivers/char/rio/riointr.c	Thu Oct 19 15:27:27 2000
+++ linux-2.2.18-pre24.rio_break/drivers/char/rio/riointr.c	Fri Dec  1 09:25:16 2000
@@ -273,7 +273,7 @@
 	for ( host=0; host<p->RIONumHosts; host++ ) {
 		struct Host *HostP = &p->RIOHosts[host];
 
-		rio_dprintk (RIO_DEBUG_INTR,  "riointr() doing host %d type %d\n", host, HostP->Type);
+		rio_dprintk (RIO_DEBUG_INTR,  "riointr() doing host %p type %d\n", host, HostP->Type);
 
 		switch( HostP->Type ) {
 			case RIO_AT:
diff -u -r linux-2.2.18-pre24.clean/drivers/char/rio/riotty.c linux-2.2.18-pre24.rio_break/drivers/char/rio/riotty.c
--- linux-2.2.18-pre24.clean/drivers/char/rio/riotty.c	Wed Nov 29 11:10:02 2000
+++ linux-2.2.18-pre24.rio_break/drivers/char/rio/riotty.c	Fri Dec  1 09:25:17 2000
@@ -95,7 +95,7 @@
 #endif
 
 static void RIOClearUp(struct Port *PortP);
-static int RIOShortCommand(struct rio_info *p, struct Port *PortP, 
+int RIOShortCommand(struct rio_info *p, struct Port *PortP, 
 			   int command, int len, int arg);
 
 
@@ -509,6 +509,7 @@
 
 	rio_spin_unlock_irqrestore(&PortP->portSem, flags);
 	rio_dprintk (RIO_DEBUG_TTY, "Returning from open\n");
+	
 	func_exit ();
 	return 0;
 }
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
