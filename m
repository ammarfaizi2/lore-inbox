Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262117AbRENPDo>; Mon, 14 May 2001 11:03:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262119AbRENPDf>; Mon, 14 May 2001 11:03:35 -0400
Received: from 13dyn155.delft.casema.net ([212.64.76.155]:3855 "EHLO
	abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
	id <S262117AbRENPDW>; Mon, 14 May 2001 11:03:22 -0400
Message-Id: <200105141503.RAA17459@cave.bitwizard.nl>
Subject: Re: [PATCH] RIO, SX, driver update.
In-Reply-To: <200105141448.QAA17400@cave.bitwizard.nl> from Rogier Wolff at "May
 14, 2001 04:48:12 pm"
To: Rogier Wolff <R.E.Wolff@BitWizard.nl>
Date: Mon, 14 May 2001 17:03:11 +0200 (MEST)
CC: Linus Torvalds <Torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
        patrick@BitWizard.nl
From: R.E.Wolff@BitWizard.nl (Rogier Wolff)
X-Mailer: ELM [version 2.4ME+ PL60 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Retry. This time with patch.... 

			Roger. 



Rogier Wolff wrote:
> 
> Hi Linus, Alan, 
> 
> The patch below implements breaks (correctly) for the RIO and SX
> cards.
> 
> We started out trying to fix one thing, but found that the 2.4.4 rio
> driver was behind on several patches.
> 
> 	Roger Wolff. 
> 	Patrick van de Lageweg. 
> 
> -----------


diff -u -r linux-2.4.4.clean/drivers/char/generic_serial.c linux-2.4.4.rio_close/drivers/char/generic_serial.c
--- linux-2.4.4.clean/drivers/char/generic_serial.c	Fri Dec 29 23:35:47 2000
+++ linux-2.4.4.rio_close/drivers/char/generic_serial.c	Mon May 14 16:36:39 2001
@@ -344,7 +344,7 @@
 	struct gs_port *port = ptr;
 	long end_jiffies;
 	int jiffies_to_transmit, charsleft = 0, rv = 0;
-	int to, rcib;
+	int rcib;
 
 	func_enter();
 
@@ -368,6 +368,7 @@
 		return rv;
 	}
 	/* stop trying: now + twice the time it would normally take +  seconds */
+	if (timeout == 0) timeout = MAX_SCHEDULE_TIMEOUT;
 	end_jiffies  = jiffies; 
 	if (timeout !=  MAX_SCHEDULE_TIMEOUT)
 		end_jiffies += port->baud?(2 * rcib * 10 * HZ / port->baud):0;
@@ -376,11 +377,9 @@
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
@@ -1059,6 +1058,19 @@
 	copy_to_user(sp, &sio, sizeof(struct serial_struct));
 }
 
+
+void gs_got_break(struct gs_port *port)
+{
+	if (port->flags & ASYNC_SAK) {
+		do_SAK (port->tty);
+	}
+	*(port->tty->flip.flag_buf_ptr) = TTY_BREAK;
+	port->tty->flip.flag_buf_ptr++;
+	port->tty->flip.char_buf_ptr++;
+	port->tty->flip.count++;
+}
+
+
 EXPORT_SYMBOL(gs_put_char);
 EXPORT_SYMBOL(gs_write);
 EXPORT_SYMBOL(gs_write_room);
@@ -1075,4 +1087,4 @@
 EXPORT_SYMBOL(gs_init_port);
 EXPORT_SYMBOL(gs_setserial);
 EXPORT_SYMBOL(gs_getserial);
-
+EXPORT_SYMBOL(gs_got_break);
diff -u -r linux-2.4.4.clean/drivers/char/rio/linux_compat.h linux-2.4.4.rio_close/drivers/char/rio/linux_compat.h
--- linux-2.4.4.clean/drivers/char/rio/linux_compat.h	Fri Aug 11 23:51:33 2000
+++ linux-2.4.4.rio_close/drivers/char/rio/linux_compat.h	Mon May 14 15:11:09 2001
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
diff -u -r linux-2.4.4.clean/drivers/char/rio/rio_linux.c linux-2.4.4.rio_close/drivers/char/rio/rio_linux.c
--- linux-2.4.4.clean/drivers/char/rio/rio_linux.c	Wed May  2 18:29:56 2001
+++ linux-2.4.4.rio_close/drivers/char/rio/rio_linux.c	Mon May 14 16:03:39 2001
@@ -58,6 +58,7 @@
 #include <linux/pci.h>
 #include <linux/slab.h>
 #include <linux/miscdevice.h>
+#include <linux/init.h>
 
 #include <linux/compatmac.h>
 #include <linux/generic_serial.h>
@@ -165,7 +166,7 @@
   /* startuptime */     HZ*2,           /* how long to wait for card to run */
   /* slowcook */        0,              /* TRUE -> always use line disc. */
   /* intrpolltime */    1,              /* The frequency of OUR polls */
-  /* breakinterval */   25,             /* x10 mS */
+  /* breakinterval */   25,             /* x10 mS XXX: units seem to be 1ms not 10! -- REW*/
   /* timer */           10,             /* mS */
   /* RtaLoadBase */     0x7000,
   /* HostLoadBase */    0x7C00,
@@ -203,11 +204,8 @@
 		         unsigned int cmd, unsigned long arg);
 static int rio_init_drivers(void);
 
-
 void my_hd (void *addr, int len);
 
-
-
 static struct tty_driver rio_driver, rio_callout_driver;
 static struct tty_driver rio_driver2, rio_callout_driver2;
 
@@ -248,14 +246,12 @@
 long rio_irqmask = -1;
 
 #ifndef TWO_ZERO
-#ifdef MODULE
 MODULE_AUTHOR("Rogier Wolff <R.E.Wolff@bitwizard.nl>, Patrick van de Lageweg <patrick@bitwizard.nl>");
 MODULE_DESCRIPTION("RIO driver");
 MODULE_PARM(rio_poll, "i");
 MODULE_PARM(rio_debug, "i");
 MODULE_PARM(rio_irqmask, "i");
 #endif
-#endif
 
 static struct real_driver rio_real_driver = {
   rio_disable_tx_interrupts,
@@ -383,8 +379,8 @@
 
 int rio_ismodem (kdev_t device)
 {
-  return (MAJOR (device) != RIO_NORMAL_MAJOR0) &&
-         (MAJOR (device) != RIO_NORMAL_MAJOR1);
+  return (MAJOR (device) == RIO_NORMAL_MAJOR0) ||
+         (MAJOR (device) == RIO_NORMAL_MAJOR1);
 }
 
 
@@ -455,7 +451,6 @@
   func_enter ();
 
   HostP = (struct Host*)ptr; /* &p->RIOHosts[(long)ptr]; */
-  
   rio_dprintk (RIO_DEBUG_IFLOW, "rio: enter rio_interrupt (%d/%d)\n", 
                irq, HostP->Ivec); 
 
@@ -624,8 +619,12 @@
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
@@ -654,8 +653,14 @@
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
 
@@ -679,9 +684,8 @@
     PortP->gs.count = 0; 
   }                
 
-
+  PortP->gs.tty = NULL;
   rio_dec_mod_count ();
-
   func_exit ();
 }
 
@@ -700,24 +704,28 @@
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
@@ -730,13 +738,39 @@
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
@@ -768,17 +802,13 @@
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
 
 
@@ -1038,8 +1068,7 @@
   return -ENOMEM;
 }
 
-#ifdef MODULE
-static void rio_release_drivers(void)
+static void  __exit rio_release_drivers(void)
 {
   func_enter();
   tty_unregister_driver (&rio_callout_driver2);
@@ -1048,7 +1077,6 @@
   tty_unregister_driver (&rio_driver);
   func_exit();
 }
-#endif 
 
 #ifdef TWO_ZERO
 #define PDEV unsigned char pci_bus, unsigned pci_fun
@@ -1101,11 +1129,7 @@
 #endif
 
 
-#ifdef MODULE
-#define rio_init init_module
-#endif
-
-int rio_init(void) 
+static int __init rio_init(void) 
 {
   int found = 0;
   int i;
@@ -1255,6 +1279,7 @@
       hp->Type  = RIO_PCI;
       hp->Copy  = rio_pcicopy;
       hp->Mode  = RIO_PCI_BOOT_FROM_RAM;
+      hp->HostLock = SPIN_LOCK_UNLOCKED;
 
       rio_dprintk (RIO_DEBUG_PROBE, "Ivec: %x\n", hp->Ivec);
       rio_dprintk (RIO_DEBUG_PROBE, "Mode: %x\n", hp->Mode);
@@ -1310,6 +1335,7 @@
                              * Moreover, the ISA card will work with the 
                              * special PCI copy anyway. -- REW */
     hp->Mode = 0;
+    hp->HostLock = SPIN_LOCK_UNLOCKED;
 
     vpdp = get_VPD_PROM (hp);
     rio_dprintk (RIO_DEBUG_PROBE, "Got VPD ROM\n");
@@ -1388,8 +1414,7 @@
 }
 
 
-#ifdef MODULE
-void cleanup_module(void)
+static void __exit rio_exit (void)
 {
   int i; 
   struct Host *hp;
@@ -1424,9 +1449,9 @@
 
   func_exit();
 }
-#endif
-
 
+module_init(rio_init);
+module_exit(rio_exit);
 
 /*
  * Anybody who knows why this doesn't work for me, please tell me -- REW.
diff -u -r linux-2.4.4.clean/drivers/char/rio/rio_linux.h linux-2.4.4.rio_close/drivers/char/rio/rio_linux.h
--- linux-2.4.4.clean/drivers/char/rio/rio_linux.h	Fri May 11 15:28:12 2001
+++ linux-2.4.4.rio_close/drivers/char/rio/rio_linux.h	Mon May 14 16:34:21 2001
@@ -95,28 +95,27 @@
 #if 1
 #define rio_spin_lock_irqsave(sem, flags) do { \
 	rio_dprintk (RIO_DEBUG_SPINLOCK, "spinlockirqsave: %p %s:%d\n", \
-					sem, __FILE__, __LINE__);\
-        spin_lock_irqsave(sem, flags);\
-        } while (0)
+	                                sem, __FILE__, __LINE__);\
+	spin_lock_irqsave(sem, flags);\
+	} while (0)
 
 #define rio_spin_unlock_irqrestore(sem, flags) do { \
 	rio_dprintk (RIO_DEBUG_SPINLOCK, "spinunlockirqrestore: %p %s:%d\n",\
-					sem, __FILE__, __LINE__);\
-        spin_unlock_irqrestore(sem, flags);\
-        } while (0)
-
+	                                sem, __FILE__, __LINE__);\
+	spin_unlock_irqrestore(sem, flags);\
+	} while (0)
 
 #define rio_spin_lock(sem) do { \
 	rio_dprintk (RIO_DEBUG_SPINLOCK, "spinlock: %p %s:%d\n",\
-					sem, __FILE__, __LINE__);\
-        spin_lock(sem);\
-        } while (0)
+	                                sem, __FILE__, __LINE__);\
+	spin_lock(sem);\
+	} while (0)
 
 #define rio_spin_unlock(sem) do { \
 	rio_dprintk (RIO_DEBUG_SPINLOCK, "spinunlock: %p %s:%d\n",\
-					sem, __FILE__, __LINE__);\
-        spin_unlock(sem);\
-        } while (0)
+	                                sem, __FILE__, __LINE__);\
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
diff -u -r linux-2.4.4.clean/drivers/char/rio/rioboot.c linux-2.4.4.rio_close/drivers/char/rio/rioboot.c
--- linux-2.4.4.clean/drivers/char/rio/rioboot.c	Thu Mar  8 17:34:10 2001
+++ linux-2.4.4.rio_close/drivers/char/rio/rioboot.c	Mon May 14 16:19:20 2001
@@ -38,6 +38,7 @@
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/errno.h>
+#include <linux/interrupt.h>
 #include <asm/io.h>
 #include <asm/system.h>
 #include <asm/string.h>
diff -u -r linux-2.4.4.clean/drivers/char/rio/riocmd.c linux-2.4.4.rio_close/drivers/char/rio/riocmd.c
--- linux-2.4.4.clean/drivers/char/rio/riocmd.c	Thu Mar  8 17:34:10 2001
+++ linux-2.4.4.rio_close/drivers/char/rio/riocmd.c	Mon May 14 16:18:45 2001
@@ -474,17 +474,18 @@
 	rio_spin_lock_irqsave(&PortP->portSem, flags);
 	switch( RBYTE(PktCmdP->Command) ) {
 		case BREAK_RECEIVED:
-		rio_dprintk (RIO_DEBUG_CMD, "Received a break!\n");
+			rio_dprintk (RIO_DEBUG_CMD, "Received a break!\n");
 			/* If the current line disc. is not multi-threading and
 	   			the current processor is not the default, reset rup_intr
 	   			and return FALSE to ensure that the command packet is
 	   			not freed. */
 			/* Call tmgr HANGUP HERE */
 			/* Fix this later when every thing works !!!! RAMRAJ */
+			gs_got_break (PortP);
 			break;
 
 		case COMPLETE:
-		rio_dprintk (RIO_DEBUG_CMD, "Command complete on phb %d host %d\n",
+			rio_dprintk (RIO_DEBUG_CMD, "Command complete on phb %d host %d\n",
 			     RBYTE(PktCmdP->PhbNum), HostP-p->RIOHosts);
 			subCommand = 1;
 			switch (RBYTE(PktCmdP->SubCommand)) {
@@ -549,6 +550,8 @@
 				*/
 				if (PortP->gs.tty == NULL)
 					break;
+				if (PortP->gs.tty->termios == NULL)
+					break;
 			  
 				if (!(PortP->gs.tty->termios->c_cflag & CLOCAL) &&
 				((PortP->State & (RIO_MOPEN|RIO_WOPEN)))) {
@@ -623,7 +626,8 @@
 	struct CmdBlk *CmdBlkP;
 
 	CmdBlkP = (struct CmdBlk *)sysbrk(sizeof(struct CmdBlk));
-	bzero(CmdBlkP, sizeof(struct CmdBlk));
+	if (CmdBlkP)
+		bzero(CmdBlkP, sizeof(struct CmdBlk));
 
 	return CmdBlkP;
 }
diff -u -r linux-2.4.4.clean/drivers/char/rio/rioinit.c linux-2.4.4.rio_close/drivers/char/rio/rioinit.c
--- linux-2.4.4.clean/drivers/char/rio/rioinit.c	Thu Mar  8 17:34:10 2001
+++ linux-2.4.4.rio_close/drivers/char/rio/rioinit.c	Fri May 11 15:48:33 2001
@@ -1446,7 +1446,7 @@
 				}
 				RIODefaultName(p, HostP, rup);
 			}
-			HostP->UnixRups[rup].RupLock = -1;
+			HostP->UnixRups[rup].RupLock = SPIN_LOCK_UNLOCKED;
 		}
 	}
 }
diff -u -r linux-2.4.4.clean/drivers/char/rio/riotable.c linux-2.4.4.rio_close/drivers/char/rio/riotable.c
--- linux-2.4.4.clean/drivers/char/rio/riotable.c	Thu Mar  8 17:34:11 2001
+++ linux-2.4.4.rio_close/drivers/char/rio/riotable.c	Fri May 11 15:48:33 2001
@@ -37,6 +37,8 @@
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/errno.h>
+#include <linux/interrupt.h>
+
 #include <asm/io.h>
 #include <asm/system.h>
 #include <asm/string.h>
diff -u -r linux-2.4.4.clean/drivers/char/rio/riotty.c linux-2.4.4.rio_close/drivers/char/rio/riotty.c
--- linux-2.4.4.clean/drivers/char/rio/riotty.c	Fri May 11 15:32:27 2001
+++ linux-2.4.4.rio_close/drivers/char/rio/riotty.c	Mon May 14 16:15:15 2001
@@ -96,7 +96,7 @@
 #endif
 
 static void RIOClearUp(struct Port *PortP);
-static int RIOShortCommand(struct rio_info *p, struct Port *PortP, 
+int RIOShortCommand(struct rio_info *p, struct Port *PortP, 
 			   int command, int len, int arg);
 
 
@@ -452,8 +452,11 @@
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
@@ -471,7 +474,6 @@
 					func_exit ();
 					return -EINTR;
 				}
-#endif
 			}
 			PortP->State &= ~RIO_WOPEN;
 		}
@@ -527,8 +529,10 @@
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
@@ -541,6 +545,12 @@
 	/* tp = PortP->TtyP;*/			/* Get tty */
 	tty = PortP->gs.tty;
 	rio_dprintk (RIO_DEBUG_TTY, "TTY is at address 0x%x\n",(int)tty);
+
+	if (PortP->gs.closing_wait) 
+		end_time = jiffies + PortP->gs.closing_wait;
+	else 
+		end_time = jiffies + MAX_SCHEDULE_TIMEOUT;
+
 	Modem = rio_ismodem(tty->device);
 #if 0
 	/* What F.CKING cache? Even then, a higly idle multiprocessor,
@@ -573,7 +583,8 @@
 	** clear the open bits for this device
 	*/
 	PortP->State &= (Modem ? ~RIO_MOPEN : ~RIO_LOPEN);
-
+	PortP->State &= ~RIO_CARR_ON;
+	PortP->ModemState &= ~MSVR1_CD;
 	/*
 	** If the device was open as both a Modem and a tty line
 	** then we need to wimp out here, as the port has not really
@@ -605,7 +616,6 @@
 	*/
 	rio_dprintk (RIO_DEBUG_TTY, "Timeout 1 starts\n");
 
-#if 0
 	if (!deleted)
 	while ( (PortP->InUse != NOT_INUSE) && !p->RIOHalted && 
 		(PortP->TxBufferIn != PortP->TxBufferOut) ) {
@@ -626,7 +636,7 @@
 		}
 		rio_spin_lock_irqsave(&PortP->portSem, flags);
 	}
-#endif
+
 	PortP->TxBufferIn = PortP->TxBufferOut = 0;
 	repeat_this = 0xff;
 
@@ -662,7 +672,7 @@
 	if (!deleted)
 	  while (try && (PortP->PortState & PORT_ISOPEN)) {
 	        try--;
-		if (try == 0) {
+		if (time_after (jiffies, end_time)) {
 		  rio_dprintk (RIO_DEBUG_TTY, "Run out of tries - force the bugger shut!\n" );
 		  RIOPreemptiveCmd(p, PortP,FCLOSE);
 		  break;
@@ -674,7 +684,11 @@
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
@@ -779,7 +793,7 @@
 ** Other values of len aren't allowed, and will cause
 ** a panic.
 */
-static int RIOShortCommand(struct rio_info *p, struct Port *PortP,
+int RIOShortCommand(struct rio_info *p, struct Port *PortP,
 		int command, int len, int arg)
 {
 	PKT *PacketP;
diff -u -r linux-2.4.4.clean/drivers/char/sx.c linux-2.4.4.rio_close/drivers/char/sx.c
--- linux-2.4.4.clean/drivers/char/sx.c	Wed May  2 18:29:57 2001
+++ linux-2.4.4.rio_close/drivers/char/sx.c	Mon May 14 15:49:13 2001
@@ -918,7 +918,6 @@
 	                       SP_DCEN);
 
 	sx_write_channel_byte (port, hi_break, 
-	                       I_OTHER(port->gs.tty) ? 0:
 	                       (I_IGNBRK(port->gs.tty)?BR_IGN:0 |
 	                        I_BRKINT(port->gs.tty)?BR_INT:0));
 
@@ -1140,9 +1139,7 @@
 		sx_dprintk (SX_DEBUG_MODEMSIGNALS, "got a break.\n");
 
 		sx_write_channel_byte (port, hi_state, hi_state);
-		if (port->gs.flags & ASYNC_SAK) {
-			do_SAK (port->gs.tty);
-		}
+		gs_got_break (port);
 	}
 	if (hi_state & ST_DCD) {
 		hi_state &= ~ST_DCD;


-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2137555 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
* There are old pilots, and there are bold pilots. 
* There are also old, bald pilots. 
