Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129977AbQK3PJc>; Thu, 30 Nov 2000 10:09:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129909AbQK3PJX>; Thu, 30 Nov 2000 10:09:23 -0500
Received: from 13dyn240.delft.casema.net ([212.64.76.240]:23556 "EHLO
        abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
        id <S129937AbQK3PJP>; Thu, 30 Nov 2000 10:09:15 -0500
Date: Thu, 30 Nov 2000 15:38:19 +0100 (CET)
From: Patrick van de Lageweg <patrick@bitwizard.nl>
To: Linus Torvalds <torvalds@transmeta.com>
cc: kickstein@melosgmbh.de, Oliver@Rauscher.com,
        Rogier Wolff <wolff@bitwizard.nl>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] rio
Message-ID: <Pine.LNX.4.21.0011301428190.12764-100000@panoramix.bitwizard.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

This patch fixes several problems with the RIO driver:

  - Implemented breaks
  - Fixed close wait implementation
  - Fixed a DCD up/down crash
  - Fixed for DCD on open
  - Initialization of the spinlocks
  - Added kmalloc return value check

Most of these fixes have already been submitted but were silently
ignored. Most of these fixes have already been merged into 2.2.18pre


	Patrick


diff -u -r linux-2.4.0-test12-pre3.clean/drivers/char/generic_serial.c linux/drivers/char/generic_serial.c
--- linux-2.4.0-test12-pre3.clean/drivers/char/generic_serial.c	Thu Nov 16 21:51:27 2000
+++ linux/drivers/char/generic_serial.c	Thu Nov 30 13:41:15 2000
@@ -345,7 +345,7 @@
 	struct gs_port *port = ptr;
 	long end_jiffies;
 	int jiffies_to_transmit, charsleft = 0, rv = 0;
-	int to, rcib;
+	int rcib;
 
 	func_enter();
 
@@ -369,6 +369,7 @@
 		return rv;
 	}
 	/* stop trying: now + twice the time it would normally take +  seconds */
+	if (timeout == 0) timeout = MAX_SCHEDULE_TIMEOUT;
 	end_jiffies  = jiffies; 
 	if (timeout !=  MAX_SCHEDULE_TIMEOUT)
 		end_jiffies += port->baud?(2 * rcib * 10 * HZ / port->baud):0;
@@ -377,11 +378,9 @@
 	gs_dprintk (GS_DEBUG_FLUSH, "now=%lx, end=%lx (%ld).\n", 
 		    jiffies, end_jiffies, end_jiffies-jiffies); 
 
-	to = 100;
 	/* the expression is actually jiffies < end_jiffies, but that won't
 	   work around the wraparound. Tricky eh? */
-	while (to-- &&
-	       (charsleft = gs_real_chars_in_buffer (port->tty)) &&
+	while ((charsleft = gs_real_chars_in_buffer (port->tty)) &&
 	        time_after (end_jiffies, jiffies)) {
 		/* Units check: 
 		   chars * (bits/char) * (jiffies /sec) / (bits/sec) = jiffies!
diff -u -r linux-2.4.0-test12-pre3.clean/drivers/char/rio/linux_compat.h linux/drivers/char/rio/linux_compat.h
--- linux-2.4.0-test12-pre3.clean/drivers/char/rio/linux_compat.h	Fri Aug 11 23:51:33 2000
+++ linux/drivers/char/rio/linux_compat.h	Thu Nov 30 14:50:29 2000
@@ -16,11 +16,13 @@
  *      Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  */
 
+#include <asm/hardirq.h>
+
 
 #define disable(oldspl) save_flags (oldspl)
 #define restore(oldspl) restore_flags (oldspl)
 
-#define sysbrk(x) kmalloc ((x), GFP_KERNEL)
+#define sysbrk(x) kmalloc ((x),in_interrupt()? GFP_ATOMIC : GFP_KERNEL)
 #define sysfree(p,size) kfree ((p))
 
 #define WBYTE(p,v) writeb(v, &p)
diff -u -r linux-2.4.0-test12-pre3.clean/drivers/char/rio/rio_linux.c linux/drivers/char/rio/rio_linux.c
--- linux-2.4.0-test12-pre3.clean/drivers/char/rio/rio_linux.c	Thu Nov 16 21:51:27 2000
+++ linux/drivers/char/rio/rio_linux.c	Thu Nov 30 13:46:22 2000
@@ -165,7 +165,7 @@
   /* startuptime */     HZ*2,           /* how long to wait for card to run */
   /* slowcook */        0,              /* TRUE -> always use line disc. */
   /* intrpolltime */    1,              /* The frequency of OUR polls */
-  /* breakinterval */   25,             /* x10 mS */
+  /* breakinterval */   25,             /* x10 mS XXX: units seem to be 1ms not 10! -- REW*/
   /* timer */           10,             /* mS */
   /* RtaLoadBase */     0x7000,
   /* HostLoadBase */    0x7C00,
@@ -203,11 +203,8 @@
 		         unsigned int cmd, unsigned long arg);
 static int rio_init_drivers(void);
 
-
 void my_hd (void *addr, int len);
 
-
-
 static struct tty_driver rio_driver, rio_callout_driver;
 static struct tty_driver rio_driver2, rio_callout_driver2;
 
@@ -383,8 +380,8 @@
 
 int rio_ismodem (kdev_t device)
 {
-  return (MAJOR (device) != RIO_NORMAL_MAJOR0) &&
-         (MAJOR (device) != RIO_NORMAL_MAJOR1);
+  return (MAJOR (device) == RIO_NORMAL_MAJOR0) ||
+         (MAJOR (device) == RIO_NORMAL_MAJOR1);
 }
 
 
@@ -455,7 +452,6 @@
   func_enter ();
 
   HostP = (struct Host*)ptr; /* &p->RIOHosts[(long)ptr]; */
-  
   rio_dprintk (RIO_DEBUG_IFLOW, "rio: enter rio_interrupt (%d/%d)\n", 
                irq, HostP->Ivec); 
 
@@ -516,7 +512,7 @@
 
   RIOServiceHost(p, HostP, irq);
 
-  rio_dprintk ( RIO_DEBUG_IFLOW, "riointr() doing host %d type %d\n", 
+  rio_dprintk ( RIO_DEBUG_IFLOW, "riointr() doing host %p type %d\n", 
                 (int) ptr, HostP->Type);
 
   clear_bit (RIO_BOARD_INTR_LOCK, &HostP->locks);
@@ -624,8 +620,12 @@
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
@@ -654,8 +654,14 @@
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
 
@@ -679,9 +685,8 @@
     PortP->gs.count = 0; 
   }                
 
-
+  PortP->gs.tty = NULL;
   rio_dec_mod_count ();
-
   func_exit ();
 }
 
@@ -700,24 +705,28 @@
   return rc;
 }
 
+extern int RIOShortCommand(struct rio_info *p, struct Port *PortP,
+               int command, int len, int arg);
 
 static int rio_ioctl (struct tty_struct * tty, struct file * filp, 
                      unsigned int cmd, unsigned long arg)
 {
-#if 0
   int rc;
-  struct rio_port *port = tty->driver_data;
+  struct Port *PortP;
   int ival;
 
-  /* func_enter2(); */
+  func_enter();
 
+  PortP = (struct Port *)tty->driver_data;
 
   rc  = 0;
   switch (cmd) {
+#if 0
   case TIOCGSOFTCAR:
     rc = Put_user(((tty->termios->c_cflag & CLOCAL) ? 1 : 0),
                   (unsigned int *) arg);
     break;
+#endif
   case TIOCSSOFTCAR:
     if ((rc = verify_area(VERIFY_READ, (void *) arg,
                           sizeof(int))) == 0) {
@@ -730,13 +739,39 @@
   case TIOCGSERIAL:
     if ((rc = verify_area(VERIFY_WRITE, (void *) arg,
                           sizeof(struct serial_struct))) == 0)
-      gs_getserial(&port->gs, (struct serial_struct *) arg);
+      gs_getserial(&PortP->gs, (struct serial_struct *) arg);
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
                           sizeof(struct serial_struct))) == 0)
-      rc = gs_setserial(&port->gs, (struct serial_struct *) arg);
+      rc = gs_setserial(&PortP->gs, (struct serial_struct *) arg);
     break;
+#if 0
   case TIOCMGET:
     if ((rc = verify_area(VERIFY_WRITE, (void *) arg,
                           sizeof(unsigned int))) == 0) {
@@ -768,17 +803,13 @@
                            ((ival & TIOCM_RTS) ? 1 : 0));
     }
     break;
-
+#endif
   default:
     rc = -ENOIOCTLCMD;
     break;
   }
-  /* func_exit(); */
+  func_exit();
   return rc;
-#else
-  return -ENOIOCTLCMD;
-#endif
-
 }
 
 
@@ -1253,6 +1284,7 @@
       hp->Type  = RIO_PCI;
       hp->Copy  = rio_pcicopy;
       hp->Mode  = RIO_PCI_BOOT_FROM_RAM;
+      hp->HostLock = SPIN_LOCK_UNLOCKED;
 
       rio_dprintk (RIO_DEBUG_PROBE, "Ivec: %x\n", hp->Ivec);
       rio_dprintk (RIO_DEBUG_PROBE, "Mode: %x\n", hp->Mode);
@@ -1308,6 +1340,7 @@
                              * Moreover, the ISA card will work with the 
                              * special PCI copy anyway. -- REW */
     hp->Mode = 0;
+    hp->HostLock = SPIN_LOCK_UNLOCKED;
 
     vpdp = get_VPD_PROM (hp);
     rio_dprintk (RIO_DEBUG_PROBE, "Got VPD ROM\n");
diff -u -r linux-2.4.0-test12-pre3.clean/drivers/char/rio/rio_linux.h linux/drivers/char/rio/rio_linux.h
--- linux-2.4.0-test12-pre3.clean/drivers/char/rio/rio_linux.h	Fri Aug 11 23:51:33 2000
+++ linux/drivers/char/rio/rio_linux.h	Thu Nov 30 14:50:29 2000
@@ -94,29 +94,28 @@
    recompile.... */
 #if 1
 #define rio_spin_lock_irqsave(sem, flags) do { \
+	spin_lock_irqsave(sem, flags);\
 	rio_dprintk (RIO_DEBUG_SPINLOCK, "spinlockirqsave: %p %s:%d\n", \
-					sem, __FILE__, __LINE__);\
-        spin_lock_irqsave(sem, flags);\
-        } while (0)
+	                                 sem, __FILE__, __LINE__);\
+	} while (0)
 
 #define rio_spin_unlock_irqrestore(sem, flags) do { \
 	rio_dprintk (RIO_DEBUG_SPINLOCK, "spinunlockirqrestore: %p %s:%d\n",\
-					sem, __FILE__, __LINE__);\
-        spin_unlock_irqrestore(sem, flags);\
-        } while (0)
-
+	                                 sem, __FILE__, __LINE__);\
+	spin_unlock_irqrestore(sem, flags);\
+	} while (0)
 
 #define rio_spin_lock(sem) do { \
+	spin_lock(sem);\
 	rio_dprintk (RIO_DEBUG_SPINLOCK, "spinlock: %p %s:%d\n",\
-					sem, __FILE__, __LINE__);\
-        spin_lock(sem);\
-        } while (0)
+	                                 sem, __FILE__, __LINE__);\
+	} while (0)
 
 #define rio_spin_unlock(sem) do { \
 	rio_dprintk (RIO_DEBUG_SPINLOCK, "spinunlock: %p %s:%d\n",\
-					sem, __FILE__, __LINE__);\
-        spin_unlock(sem);\
-        } while (0)
+	                                 sem, __FILE__, __LINE__);\
+	spin_unlock(sem);\
+	} while (0)
 #else
 #define rio_spin_lock_irqsave(sem, flags) \
             spin_lock_irqsave(sem, flags)
@@ -165,7 +164,7 @@
 #define rio_memcpy_fromio                      memcpy_fromio
 #endif
 
-#define DEBUG
+#define DEBUG 1
 
 
 /* 
diff -u -r linux-2.4.0-test12-pre3.clean/drivers/char/rio/rioboot.c linux/drivers/char/rio/rioboot.c
--- linux-2.4.0-test12-pre3.clean/drivers/char/rio/rioboot.c	Fri Aug 11 23:51:33 2000
+++ linux/drivers/char/rio/rioboot.c	Wed Nov 29 11:35:35 2000
@@ -38,11 +38,11 @@
 #include <linux/module.h>
 #include <linux/malloc.h>
 #include <linux/errno.h>
+#include <linux/interrupt.h>
 #include <asm/io.h>
 #include <asm/system.h>
 #include <asm/string.h>
 #include <asm/semaphore.h>
-
 
 #include <linux/termios.h>
 #include <linux/serial.h>
diff -u -r linux-2.4.0-test12-pre3.clean/drivers/char/rio/riocmd.c linux/drivers/char/rio/riocmd.c
--- linux-2.4.0-test12-pre3.clean/drivers/char/rio/riocmd.c	Fri Aug 11 23:51:33 2000
+++ linux/drivers/char/rio/riocmd.c	Thu Nov 30 13:48:19 2000
@@ -38,6 +38,9 @@
 #include <linux/module.h>
 #include <linux/malloc.h>
 #include <linux/errno.h>
+#include <linux/smp.h>
+#include <linux/interrupt.h>
+#include <asm/ptrace.h>
 #include <asm/io.h>
 #include <asm/system.h>
 #include <asm/string.h>
@@ -80,7 +83,6 @@
 #include "control.h"
 #include "cirrus.h"
 
-
 static struct IdentifyRta IdRta;
 static struct KillNeighbour KillUnit;
 
@@ -548,6 +550,8 @@
 				*/
 				if (PortP->gs.tty == NULL)
 					break;
+				if (PortP->gs.tty->termios == NULL)
+					break;
 			  
 				if (!(PortP->gs.tty->termios->c_cflag & CLOCAL) &&
 				((PortP->State & (RIO_MOPEN|RIO_WOPEN)))) {
@@ -622,7 +626,8 @@
 	struct CmdBlk *CmdBlkP;
 
 	CmdBlkP = (struct CmdBlk *)sysbrk(sizeof(struct CmdBlk));
-	bzero(CmdBlkP, sizeof(struct CmdBlk));
+	if (CmdBlkP)
+		bzero(CmdBlkP, sizeof(struct CmdBlk));
 
 	return CmdBlkP;
 }
@@ -782,6 +787,7 @@
 					** routine that uses the RUP lock.
 					*/
 					rio_spin_unlock_irqrestore(&UnixRupP->RupLock, flags);
+					
 					FreeMe= RIOCommandRup(p, Rup,HostP,PacketP);
 					if (PacketP->data[5] == MEMDUMP) {
 						rio_dprintk (RIO_DEBUG_CMD, "Memdump from 0x%x complete\n",
diff -u -r linux-2.4.0-test12-pre3.clean/drivers/char/rio/rioinit.c linux/drivers/char/rio/rioinit.c
--- linux-2.4.0-test12-pre3.clean/drivers/char/rio/rioinit.c	Fri Aug 11 23:51:33 2000
+++ linux/drivers/char/rio/rioinit.c	Wed Nov 29 11:35:35 2000
@@ -1446,7 +1446,7 @@
 				}
 				RIODefaultName(p, HostP, rup);
 			}
-			HostP->UnixRups[rup].RupLock = -1;
+			HostP->UnixRups[rup].RupLock = SPIN_LOCK_UNLOCKED;
 		}
 	}
 }
diff -u -r linux-2.4.0-test12-pre3.clean/drivers/char/rio/riointr.c linux/drivers/char/rio/riointr.c
--- linux-2.4.0-test12-pre3.clean/drivers/char/rio/riointr.c	Fri Aug 11 23:51:33 2000
+++ linux/drivers/char/rio/riointr.c	Thu Nov 30 15:22:08 2000
@@ -273,7 +273,7 @@
 	for ( host=0; host<p->RIONumHosts; host++ ) {
 		struct Host *HostP = &p->RIOHosts[host];
 
-		rio_dprintk (RIO_DEBUG_INTR,  "riointr() doing host %d type %d\n", host, HostP->Type);
+		rio_dprintk (RIO_DEBUG_INTR,  "riointr() doing host %p type %d\n", host, HostP->Type);
 
 		switch( HostP->Type ) {
 			case RIO_AT:
diff -u -r linux-2.4.0-test12-pre3.clean/drivers/char/rio/riotable.c linux/drivers/char/rio/riotable.c
--- linux-2.4.0-test12-pre3.clean/drivers/char/rio/riotable.c	Fri Aug 11 23:51:33 2000
+++ linux/drivers/char/rio/riotable.c	Wed Nov 29 11:35:35 2000
@@ -37,6 +37,8 @@
 #include <linux/module.h>
 #include <linux/malloc.h>
 #include <linux/errno.h>
+#include <linux/interrupt.h>
+
 #include <asm/io.h>
 #include <asm/system.h>
 #include <asm/string.h>
diff -u -r linux-2.4.0-test12-pre3.clean/drivers/char/rio/riotty.c linux/drivers/char/rio/riotty.c
--- linux-2.4.0-test12-pre3.clean/drivers/char/rio/riotty.c	Fri Aug 11 23:51:33 2000
+++ linux/drivers/char/rio/riotty.c	Thu Nov 30 13:49:21 2000
@@ -95,7 +95,7 @@
 #endif
 
 static void RIOClearUp(struct Port *PortP);
-static int RIOShortCommand(struct rio_info *p, struct Port *PortP, 
+int RIOShortCommand(struct rio_info *p, struct Port *PortP, 
 			   int command, int len, int arg);
 
 
@@ -451,8 +451,11 @@
 				PortP->gs.tty->termios->c_state |= WOPEN;
 				*/
 				PortP->State |= RIO_WOPEN;
+				rio_spin_unlock_irqrestore(&PortP->portSem, flags);
+				if (RIODelay (PortP, HUNDRED_MS) == RIO_FAIL)
 #if 0
 				if ( sleep((caddr_t)&tp->tm.c_canqo, TTIPRI|PCATCH))
+#endif
 				{
 					/*
 					** ACTION: verify that this is a good thing
@@ -470,7 +473,6 @@
 					func_exit ();
 					return -EINTR;
 				}
-#endif
 			}
 			PortP->State &= ~RIO_WOPEN;
 		}
@@ -507,6 +509,7 @@
 
 	rio_spin_unlock_irqrestore(&PortP->portSem, flags);
 	rio_dprintk (RIO_DEBUG_TTY, "Returning from open\n");
+	
 	func_exit ();
 	return 0;
 }
@@ -526,8 +529,10 @@
 #endif
 	struct Port *PortP =ptr;	/* pointer to the port structure */
 	int deleted = 0;
-	int	try = 25;
-	int	repeat_this = 0xff;
+	int	try = -1; /* Disable the timeouts by setting them to -1 */
+	int	repeat_this = -1; /* Congrats to those having 15 years of 
+				     uptime! (You get to break the driver.) */
+	long end_time;
 	struct tty_struct * tty;
 	unsigned long flags;
 	int Modem;
@@ -540,6 +545,12 @@
 	/* tp = PortP->TtyP;*/			/* Get tty */
 	tty = PortP->gs.tty;
 	rio_dprintk (RIO_DEBUG_TTY, "TTY is at address 0x%x\n",(int)tty);
+
+	if (PortP->gs.closing_wait) 
+	  end_time = jiffies + PortP->gs.closing_wait;
+	else 
+	  end_time = jiffies + MAX_SCHEDULE_TIMEOUT;
+
 	Modem = rio_ismodem(tty->device);
 #if 0
 	/* What F.CKING cache? Even then, a higly idle multiprocessor,
@@ -572,7 +583,8 @@
 	** clear the open bits for this device
 	*/
 	PortP->State &= (Modem ? ~RIO_MOPEN : ~RIO_LOPEN);
-
+	PortP->State &= ~RIO_CARR_ON;
+	PortP->ModemState &= ~MSVR1_CD;
 	/*
 	** If the device was open as both a Modem and a tty line
 	** then we need to wimp out here, as the port has not really
@@ -604,7 +616,7 @@
 	*/
 	rio_dprintk (RIO_DEBUG_TTY, "Timeout 1 starts\n");
 
-#if 0
+
 	if (!deleted)
 	while ( (PortP->InUse != NOT_INUSE) && !p->RIOHalted && 
 		(PortP->TxBufferIn != PortP->TxBufferOut) ) {
@@ -625,7 +637,7 @@
 		}
 		rio_spin_lock_irqsave(&PortP->portSem, flags);
 	}
-#endif
+
 	PortP->TxBufferIn = PortP->TxBufferOut = 0;
 	repeat_this = 0xff;
 
@@ -661,7 +673,7 @@
 	if (!deleted)
 	  while (try && (PortP->PortState & PORT_ISOPEN)) {
 	        try--;
-		if (try == 0) {
+		if (time_after (jiffies, end_time)) {
 		  rio_dprintk (RIO_DEBUG_TTY, "Run out of tries - force the bugger shut!\n" );
 		  RIOPreemptiveCmd(p, PortP,FCLOSE);
 		  break;
@@ -673,7 +685,11 @@
 			RIOClearUp( PortP );
 			goto close_end;
 		}
-		RIODelay_ni(PortP, HUNDRED_MS);
+		if (RIODelay(PortP, HUNDRED_MS) == RIO_FAIL) {
+			rio_dprintk (RIO_DEBUG_TTY, "RTA EINTR in delay \n");
+			RIOPreemptiveCmd(p, PortP,FCLOSE);
+			break;
+		}
 	}
 	rio_spin_lock_irqsave(&PortP->portSem, flags);
 	rio_dprintk (RIO_DEBUG_TTY, "Close: try was %d on completion\n", try );
@@ -778,7 +794,7 @@
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
