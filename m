Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261204AbULHNi6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261204AbULHNi6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 08:38:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261220AbULHNib
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 08:38:31 -0500
Received: from users.linvision.com ([62.58.92.114]:2791 "HELO bitwizard.nl")
	by vger.kernel.org with SMTP id S261214AbULHN3z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 08:29:55 -0500
Date: Wed, 8 Dec 2004 14:29:51 +0100
To: Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Rogier Wolff <R.E.Wolff@BitWizard.nl>, Eric Wood <eric@interplas.com>,
       bmckinlay@perle.com, tmckinlay@perle.com
Subject: [PATCH] RIO
Message-ID: <20041208132951.GC19937@bitwizard.nl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="E13BgyNx05feLLmH"
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
From: Patrick van de Lageweg <patrick@bitwizard.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--E13BgyNx05feLLmH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

This patch converts all save_flags/restore_flags to the new 
spin_lick_irqsave/spin_unlock_irqrestore calls, as well as some
other 2.6.X cleanups. This allows the "rio" driver to become
SMP safe.


Signed-off-by: Patrick vd Lageweg <patrick@bitwizard.nl>
Signed-off-by: Rogier Wolff <R.E.Wolff@BitWizard.nl>

        Patrick

--E13BgyNx05feLLmH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="patch-08122004-2.6.10-rc3-rio"

diff -u -r linux-2.6.10-rc3-clean/drivers/char/Kconfig linux-2.6.10-rc3-rio/drivers/char/Kconfig
--- linux-2.6.10-rc3-clean/drivers/char/Kconfig	Fri Dec  3 15:13:32 2004
+++ linux-2.6.10-rc3-rio/drivers/char/Kconfig	Fri Dec  3 15:28:48 2004
@@ -299,7 +299,7 @@
 
 config RIO
 	tristate "Specialix RIO system support"
-	depends on SERIAL_NONSTANDARD && BROKEN_ON_SMP
+	depends on SERIAL_NONSTANDARD
 	help
 	  This is a driver for the Specialix RIO, a smart serial card which
 	  drives an outboard box that can support up to 128 ports.  Product
diff -u -r linux-2.6.10-rc3-clean/drivers/char/rio/linux_compat.h linux-2.6.10-rc3-rio/drivers/char/rio/linux_compat.h
--- linux-2.6.10-rc3-clean/drivers/char/rio/linux_compat.h	Fri Dec  3 15:11:52 2004
+++ linux-2.6.10-rc3-rio/drivers/char/rio/linux_compat.h	Fri Dec  3 15:28:48 2004
@@ -19,8 +19,8 @@
 #include <linux/interrupt.h>
 
 
-#define disable(oldspl) save_flags (oldspl)
-#define restore(oldspl) restore_flags (oldspl)
+#define disable(oldspl) local_irq_save(oldspl);
+#define restore(oldspl) local_irq_restore(oldspl) ;
 
 #define sysbrk(x) kmalloc ((x),in_interrupt()? GFP_ATOMIC : GFP_KERNEL)
 #define sysfree(p,size) kfree ((p))
diff -u -r linux-2.6.10-rc3-clean/drivers/char/rio/rio_linux.c linux-2.6.10-rc3-rio/drivers/char/rio/rio_linux.c
--- linux-2.6.10-rc3-clean/drivers/char/rio/rio_linux.c	Fri Dec  3 15:13:33 2004
+++ linux-2.6.10-rc3-rio/drivers/char/rio/rio_linux.c	Fri Dec  3 15:28:48 2004
@@ -354,7 +354,7 @@
 
 int rio_minor(struct tty_struct *tty)
 {
-	return tty->index + (tty->driver == rio_driver) ? 0 : 256;
+	return tty->index + ((tty->driver == rio_driver) ? 0 : 256);
 }
 
 
@@ -405,6 +405,8 @@
 static irqreturn_t rio_interrupt (int irq, void *ptr, struct pt_regs *regs)
 {
   struct Host *HostP;
+  int old_debug=rio_debug;
+  rio_debug=0;
   func_enter ();
 
   HostP = (struct Host*)ptr; /* &p->RIOHosts[(long)ptr]; */
@@ -458,12 +460,14 @@
     rio_reset_interrupt (HostP);
   }
 
-  if ((HostP->Flags & RUN_STATE) != RC_RUNNING)
+  if ((HostP->Flags & RUN_STATE) != RC_RUNNING) {
+          rio_debug=old_debug;
   	return IRQ_HANDLED;
-
+  }
   if (test_and_set_bit (RIO_BOARD_INTR_LOCK, &HostP->locks)) {
     printk (KERN_ERR "Recursive interrupt! (host %d/irq%d)\n", 
             (int) ptr, HostP->Ivec);
+    rio_debug=old_debug;
     return IRQ_HANDLED;
   }
 
@@ -476,6 +480,7 @@
   rio_dprintk (RIO_DEBUG_IFLOW, "rio: exit rio_interrupt (%d/%d)\n", 
                irq, HostP->Ivec); 
   func_exit ();
+rio_debug=old_debug;
   return IRQ_HANDLED;
 }
 
@@ -726,6 +731,9 @@
       rc = gs_setserial(&PortP->gs, (struct serial_struct *) arg);
     break;
 #if 0
+    /* As far as we know this is impossible -- PVDL */
+
+
   /*
    * note: these IOCTLs no longer reach here.  Use
    * tiocmset/tiocmget driver methods instead.  The
@@ -980,6 +988,7 @@
     port->gs.closing_wait = 30 * HZ;
     port->gs.rd = &rio_real_driver;
     port->portSem = SPIN_LOCK_UNLOCKED;
+    port->gs.driver_lock = SPIN_LOCK_UNLOCKED;
     /*
      * Initializing wait queue
      */
@@ -1048,7 +1057,7 @@
 void fix_rio_pci (struct pci_dev *pdev)
 {
   unsigned int hwbase;
-  unsigned long rebase;
+  char *rebase;
   unsigned int t;
 
 #define CNTRL_REG_OFFSET        0x50
@@ -1056,7 +1065,7 @@
 
   pci_read_config_dword(pdev, PCI_BASE_ADDRESS_0, &hwbase);
   hwbase &= PCI_BASE_ADDRESS_MEM_MASK;
-  rebase =  (ulong) ioremap(hwbase, 0x80);
+  rebase =  ioremap(hwbase, 0x80);
   t = readl (rebase + CNTRL_REG_OFFSET);
   if (t != CNTRL_REG_GOODVALUE) {
     printk (KERN_DEBUG "rio: performing cntrl reg fix: %08x -> %08x\n", 
@@ -1137,7 +1146,7 @@
       if (((1 << hp->Ivec) & rio_irqmask) == 0)
               hp->Ivec = 0;
       hp->Caddr = ioremap(p->RIOHosts[p->RIONumHosts].PaddrP, RIO_WINDOW_LEN);
-      hp->CardP	= (struct DpRam *) hp->Caddr;
+      hp->CardP = (struct DpRam *) hp->Caddr;
       hp->Type  = RIO_PCI;
       hp->Copy  = rio_pcicopy; 
       hp->Mode  = RIO_PCI_BOOT_FROM_RAM;
@@ -1195,7 +1204,7 @@
       	hp->Ivec = 0;
       hp->Ivec |= 0x8000; /* Mark as non-sharable */
       hp->Caddr = ioremap(p->RIOHosts[p->RIONumHosts].PaddrP, RIO_WINDOW_LEN);
-      hp->CardP	= (struct DpRam *) hp->Caddr;
+      hp->CardP = (struct DpRam *) hp->Caddr;
       hp->Type  = RIO_PCI;
       hp->Copy  = rio_pcicopy;
       hp->Mode  = RIO_PCI_BOOT_FROM_RAM;
diff -u -r linux-2.6.10-rc3-clean/drivers/char/rio/riotty.c linux-2.6.10-rc3-rio/drivers/char/rio/riotty.c
--- linux-2.6.10-rc3-clean/drivers/char/rio/riotty.c	Sat Aug 14 07:36:56 2004
+++ linux-2.6.10-rc3-rio/drivers/char/rio/riotty.c	Fri Dec  3 15:28:48 2004
@@ -202,7 +202,10 @@
 	}
 
 	tty->driver_data = PortP;
-
+	
+	if (PortP->gs.flags & ASYNC_CLOSING){
+		interruptible_sleep_on(&PortP->gs.close_wait);
+	}
 	PortP->gs.tty = tty;
 	PortP->gs.count++;
 
@@ -408,6 +411,7 @@
 bombout:
 		  /* 			RIOClearUp( PortP ); */
 			rio_spin_unlock_irqrestore(&PortP->portSem, flags);
+			func_exit ();
 			return retval;
 		}
 		rio_dprintk (RIO_DEBUG_TTY, "PORT_ISOPEN found\n");
@@ -458,15 +462,19 @@
 					*/
 					rio_dprintk (RIO_DEBUG_TTY, "open(%d) sleeping for carr broken by signal\n",
 					       SysPort);
-					RIOPreemptiveCmd( p, PortP, FCLOSE );
+
+					// Do not close port on RTA if the port	has multiple opens.
+					if( PortP->gs.count <= 1 )
+						RIOPreemptiveCmd( p, PortP, FCLOSE );
+
 					/*
 					tp->tm.c_state &= ~WOPEN;
 					*/
 					PortP->State &= ~RIO_WOPEN;
-					rio_spin_unlock_irqrestore(&PortP->portSem, flags);
 					func_exit ();
 					return -EINTR;
 				}
+				rio_spin_lock_irqsave(&PortP->portSem, flags);
 			}
 			PortP->State &= ~RIO_WOPEN;
 		}
@@ -525,7 +533,7 @@
 	int	try = -1; /* Disable the timeouts by setting them to -1 */
 	int	repeat_this = -1; /* Congrats to those having 15 years of 
 				     uptime! (You get to break the driver.) */
-	long end_time;
+	unsigned long end_time;
 	struct tty_struct * tty;
 	unsigned long flags;
 	int Modem;
@@ -659,6 +667,7 @@
 
 	if (RIOShortCommand(p, PortP, CLOSE, 1, 0) == RIO_FAIL) {
 	  RIOPreemptiveCmd(p, PortP,FCLOSE);
+	  rio_spin_lock_irqsave(&PortP->portSem, flags);
 	  goto close_end;
 	}
 
@@ -675,6 +684,7 @@
 
 		if ( p->RIOHalted ) {
 			RIOClearUp( PortP );
+			rio_spin_lock_irqsave(&PortP->portSem, flags);
 			goto close_end;
 		}
 		if (RIODelay(PortP, HUNDRED_MS) == RIO_FAIL) {

--E13BgyNx05feLLmH--
