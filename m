Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131368AbRCNONP>; Wed, 14 Mar 2001 09:13:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131369AbRCNONG>; Wed, 14 Mar 2001 09:13:06 -0500
Received: from 13dyn135.delft.casema.net ([212.64.76.135]:29201 "EHLO
	abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
	id <S131368AbRCNOMx>; Wed, 14 Mar 2001 09:12:53 -0500
Message-Id: <200103141411.PAA30346@cave.bitwizard.nl>
Subject: [PATCH] RIO modemsignals. 
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Date: Wed, 14 Mar 2001 15:11:50 +0100 (MET)
CC: fgroenewald@mweb.co.za
From: R.E.Wolff@BitWizard.nl (Rogier Wolff)
X-Mailer: ELM [version 2.4ME+ PL60 (25)]
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary=ELM984579110-29755-0_
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ELM984579110-29755-0_
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


Hi,

Francois Groenewald noted that the RIO driver under Linux didn't
implement the TIOMGET and related IOCTLs. Attached is a patch
that fixes this. 

Alan, sorry for being so late with this: I was waiting for an "yep it
works" from Francois... 

			Roger. 

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2137555 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
* There are old pilots, and there are bold pilots. 
* There are also old, bald pilots. 

--ELM984579110-29755-0_
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: attachment; filename=rio_modemsignals.diff
Content-Description: /usr/src/rio_modemsignals.diff
Content-Transfer-Encoding: 7bit

diff -ur linux-2.2.18.clean/drivers/char/rio/linux_compat.h linux-2.2.18.rio/drivers/char/rio/linux_compat.h
--- linux-2.2.18.clean/drivers/char/rio/linux_compat.h	Thu Jan  4 16:48:51 2001
+++ linux-2.2.18.rio/drivers/char/rio/linux_compat.h	Tue Jan  9 13:21:07 2001
@@ -93,6 +93,7 @@
 #define RIO_DEBUG_SPINLOCK     0x010000
 #define RIO_DEBUG_DELAY        0x020000
 #define RIO_DEBUG_MOD_COUNT    0x040000
+#define RIO_DEBUG_IOCTL        0x080000
 
 /* Copied over from riowinif.h . This is ugly. The winif file declares
 also much other stuff which is incompatible with the headers from
diff -ur linux-2.2.18.clean/drivers/char/rio/rio_linux.c linux-2.2.18.rio/drivers/char/rio/rio_linux.c
--- linux-2.2.18.clean/drivers/char/rio/rio_linux.c	Thu Jan  4 16:27:06 2001
+++ linux-2.2.18.rio/drivers/char/rio/rio_linux.c	Thu Jan 11 14:45:47 2001
@@ -730,12 +730,31 @@
 }
 
 
+int rio2l (int rio_bits)
+{
+  return ((rio_bits & MODEM_CD) ?TIOCM_CD :0) |
+         ((rio_bits & MODEM_DSR)?TIOCM_DSR:0) |
+         ((rio_bits & MODEM_RTS)?TIOCM_RTS:0) |
+         ((rio_bits & MODEM_RI) ?TIOCM_RI :0) |
+         ((rio_bits & MODEM_DTR)?TIOCM_DTR:0) |
+         ((rio_bits & MODEM_CTS)?TIOCM_CTS:0);
+}
+
+int l2rio (int l_bits)
+{
+  return ((l_bits & TIOCM_RTS)?MSET_RTS:0) |
+         ((l_bits & TIOCM_DTR)?MSET_DTR:0);
+}
+
+
 static int rio_ioctl (struct tty_struct * tty, struct file * filp, 
                      unsigned int cmd, unsigned long arg)
 {
   int rc;
   struct Port *PortP;
   int ival;
+  int state;
+  long flags;
 
   func_enter();
 
@@ -766,7 +785,7 @@
     break;
   case TCSBRK:
     if ( PortP->State & RIO_DELETED ) {
-      rio_dprintk (RIO_DEBUG_TTY, "BREAK on deleted RTA\n");
+      rio_dprintk (RIO_DEBUG_IOCTL, "BREAK on deleted RTA\n");
       rc = -EIO;      
     } else {
       if (RIOShortCommand(p, PortP, SBREAK, 2, 250) == RIO_FAIL) {
@@ -777,7 +796,7 @@
     break;
   case TCSBRKP:
     if ( PortP->State & RIO_DELETED ) {
-      rio_dprintk (RIO_DEBUG_TTY, "BREAK on deleted RTA\n");
+      rio_dprintk (RIO_DEBUG_IOCTL, "BREAK on deleted RTA\n");
       rc = -EIO;      
     } else {
       int l;
@@ -794,39 +813,48 @@
                           sizeof(struct serial_struct))) == 0)
       rc = gs_setserial(&PortP->gs, (struct serial_struct *) arg);
     break;
-#if 0
   case TIOCMGET:
-    if ((rc = verify_area(VERIFY_WRITE, (void *) arg,
-                          sizeof(unsigned int))) == 0) {
-      ival = rio_getsignals(port);
-      put_user(ival, (unsigned int *) arg);
-    }
+    rio_dprintk (RIO_DEBUG_IOCTL, "TIOCMGET: %x -> %x \n",
+                 PortP->ModemState, rio2l (PortP->ModemState));
+    return put_user (rio2l (PortP->ModemState), (unsigned int *) arg);
     break;
-  case TIOCMBIS:
-    if ((rc = verify_area(VERIFY_READ, (void *) arg,
-                          sizeof(unsigned int))) == 0) {
-      Get_user(ival, (unsigned int *) arg);
-      rio_setsignals(port, ((ival & TIOCM_DTR) ? 1 : -1),
-                           ((ival & TIOCM_RTS) ? 1 : -1));
-    }
+  case TIOCMSET:
+    Get_user(state, (unsigned int *) arg);
+    rio_dprintk (RIO_DEBUG_IOCTL, "TIOCMSET: %x -> %x\n",
+                 PortP->ModemState, l2rio (state));
+
+    rio_spin_lock_irqsave(&PortP->portSem, flags);
+    PortP->ModemState = l2rio (state);
+    PortP->ModemLines = l2rio (state);
+    if (RIOPreemptiveCmd(p, PortP, MSET) == RIO_FAIL)
+            rio_dprintk (RIO_DEBUG_TTY, "MSET command failed\n");
+    PortP->State |= RIO_BUSY;
+    rio_spin_unlock_irqrestore(&PortP->portSem, flags);
     break;
   case TIOCMBIC:
-    if ((rc = verify_area(VERIFY_READ, (void *) arg,
-                          sizeof(unsigned int))) == 0) {
-      Get_user(ival, (unsigned int *) arg);
-      rio_setsignals(port, ((ival & TIOCM_DTR) ? 0 : -1),
-                           ((ival & TIOCM_RTS) ? 0 : -1));
-    }
+    rio_dprintk (RIO_DEBUG_IOCTL, "TIOCMBIC\n");
+    Get_user(state, (unsigned int *) arg);
+
+    rio_spin_lock_irqsave(&PortP->portSem, flags);
+    PortP->ModemState &= ~l2rio (state);
+    PortP->ModemLines  =  l2rio (state);
+    if (RIOPreemptiveCmd(p, PortP, MBIC) == RIO_FAIL)
+            rio_dprintk (RIO_DEBUG_TTY, "TCRIOMBIC command failed\n");
+    PortP->State |= RIO_BUSY;
+    rio_spin_unlock_irqrestore(&PortP->portSem, flags);
     break;
-  case TIOCMSET:
-    if ((rc = verify_area(VERIFY_READ, (void *) arg,
-                          sizeof(unsigned int))) == 0) {
-      Get_user(ival, (unsigned int *) arg);
-      rio_setsignals(port, ((ival & TIOCM_DTR) ? 1 : 0),
-                           ((ival & TIOCM_RTS) ? 1 : 0));
-    }
+  case TIOCMBIS:
+    rio_dprintk (RIO_DEBUG_IOCTL, "TIOCMBIS\n");
+    Get_user(state, (unsigned int *) arg);
+
+    rio_spin_lock_irqsave(&PortP->portSem, flags);
+    PortP->ModemState |= state;
+    PortP->ModemLines  = state;
+    if (RIOPreemptiveCmd(p, PortP, MBIS) == RIO_FAIL)
+            rio_dprintk (RIO_DEBUG_TTY, "TCRIOMBIS command failed\n");
+    PortP->State |= RIO_BUSY;
+    rio_spin_unlock_irqrestore(&PortP->portSem, flags);
     break;
-#endif
   default:
     rc = -ENOIOCTLCMD;
     break;
diff -ur linux-2.2.18.clean/drivers/char/rio/rio_linux.h linux-2.2.18.rio/drivers/char/rio/rio_linux.h
--- linux-2.2.18.clean/drivers/char/rio/rio_linux.h	Thu Jan  4 16:48:51 2001
+++ linux-2.2.18.rio/drivers/char/rio/rio_linux.h	Thu Jan 11 14:44:37 2001
@@ -190,3 +190,20 @@
 #define func_enter2()
 #endif
 
+/* Documentation says to use these defines. Why aren't they in a
+ * header then?  Hmm. They are in the header "riowinif.h", however
+ * that file doesn't compile. I give up. Copied here. -- REW
+ */
+
+#define MSET_RTS        0x01            /* RTS modem signal */
+#define MSET_DTR        0x02            /* DTR modem signal */
+
+#define MODEM_DSR               0x80    /* Data Set Ready modem state */
+#define MODEM_CTS               0x40    /* Clear To Send modem state */
+#define MODEM_RI                0x20    /* Ring Indicate modem state */
+#define MODEM_CD                0x10    /* Carrier Detect modem state */
+#define MODEM_TSTOP             0x08    /* Transmit Stopped state */
+#define MODEM_TEMPTY    0x04    /* Transmit Empty state */
+#define MODEM_DTR               0x02    /* DTR modem output state */
+#define MODEM_RTS               0x01    /* RTS modem output state */
+

--ELM984579110-29755-0_--
