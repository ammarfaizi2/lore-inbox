Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262811AbTENUjq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 16:39:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262816AbTENUjq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 16:39:46 -0400
Received: from ida.rowland.org ([192.131.102.52]:1796 "HELO ida.rowland.org")
	by vger.kernel.org with SMTP id S262811AbTENUji (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 16:39:38 -0400
Date: Wed, 14 May 2003 16:52:26 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@ida.rowland.org
To: Paul Fulghum <paulkf@microgate.com>
cc: Greg KH <greg@kroah.com>, Andrew Morton <akpm@digeo.com>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       Arnd Bergmann <arnd@arndb.de>, <johannes@erdfelt.com>,
       USB development list <linux-usb-devel@lists.sourceforge.net>
Subject: Test Patch: 2.5.69 Interrupt Latency
In-Reply-To: <1052840106.2255.24.camel@diemos>
Message-ID: <Pine.LNX.4.44L0.0305141634070.626-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 13 May 2003, Paul Fulghum wrote:

> On Tue, 2003-05-13 at 10:26, Alan Stern wrote:
> 
> > Putting in a sanity check for the global suspend state will be very easy.  
> > But I would like to point out that this "global suspend" does not refer to
> > the entire system, only the USB bus.
> 
> That is a problem then, because the delay can still
> occur during normal system operation.
> 
> > I'm not sure under what
> > circumstances the bus is placed in global suspend; I think it's just when
> > there are no devices attached (or the last remaining device is detached).
> > 
> > However, there have been cases on my own system where turning off the only
> > USB peripheral caused the driver to bounce between suspend_hc() and
> > wakeup_hc() several times without any apparent explanation -- possibly as
> > a result of transient electrical signals on the bus (?).  So perhaps
> > moving that delay out of the ISR isn't such a bad idea.
> 
> Agreed. If this can happen on functional USB controllers
> when no devices are attached, then it is a serious problem.

Below is a patch that addresses both of the issues raised in this thread.  
The delay time is moved out of the interrupt handler, and the
wakeup/suspend transitions are de-bounced.  To do this, I needed to add a
mildly elaborate state mechanism.  State transitions are polled during the
stall-timer callback.

There is no protection against simultaneous access from multiple threads,
such as a PCI suspend occurring at the same time as a normal suspend or
resume.  The original driver didn't have any either; it's probably not
worth worrying too much about.  The patch works okay on my system.  Try it
and see how it works on yours.

Johannes, please look over this code and verify that I haven't screwed 
anything up.

Alan Stern


===== uhci-hcd.c 1.48 vs edited =====
--- 1.48/drivers/usb/host/uhci-hcd.c	Mon May  5 02:49:54 2003
+++ edited/drivers/usb/host/uhci-hcd.c	Wed May 14 16:45:42 2003
@@ -61,7 +61,7 @@
 /*
  * Version Information
  */
-#define DRIVER_VERSION "v2.0"
+#define DRIVER_VERSION "v2.1"
 #define DRIVER_AUTHOR "Linus 'Frodo Rabbit' Torvalds, Johannes Erdfelt, Randy Dunlap, Georg Acher, Deti Fliegl, Thomas Sailer, Roman Weissgaerber"
 #define DRIVER_DESC "USB Universal Host Controller Interface driver"
 
@@ -91,9 +91,7 @@
 static int uhci_urb_dequeue(struct usb_hcd *hcd, struct urb *urb);
 static void uhci_unlink_generic(struct uhci_hcd *uhci, struct urb *urb);
 
-static int  ports_active(struct uhci_hcd *uhci);
-static void suspend_hc(struct uhci_hcd *uhci);
-static void wakeup_hc(struct uhci_hcd *uhci);
+static void hc_state_transitions(struct uhci_hcd *uhci);
 
 /* If a transfer is still active after this much time, turn off FSBR */
 #define IDLE_TIMEOUT	(HZ / 20)	/* 50 ms */
@@ -1757,9 +1755,8 @@
 		uhci->skel_term_qh->link = UHCI_PTR_TERM;
 	}
 
-	/* enter global suspend if nothing connected */
-	if (!uhci->is_suspended && !ports_active(uhci))
-		suspend_hc(uhci);
+	/* Poll for and perform state transitions */
+	hc_state_transitions(uhci);
 
 	init_stall_timer(hcd);
 }
@@ -1884,14 +1881,14 @@
 			err("%x: host system error, PCI problems?", io_addr);
 		if (status & USBSTS_HCPE)
 			err("%x: host controller process error. something bad happened", io_addr);
-		if ((status & USBSTS_HCH) && !uhci->is_suspended) {
+		if ((status & USBSTS_HCH) && uhci->state > 0) {
 			err("%x: host controller halted. very bad", io_addr);
 			/* FIXME: Reset the controller, fix the offending TD */
 		}
 	}
 
 	if (status & USBSTS_RD)
-		wakeup_hc(uhci);
+		uhci->resume_detect = 1;
 
 	uhci_free_pending_qhs(uhci);
 
@@ -1922,45 +1919,75 @@
 	unsigned int io_addr = uhci->io_addr;
 
 	/* Global reset for 50ms */
+	uhci->state = UHCI_RESET;
 	outw(USBCMD_GRESET, io_addr + USBCMD);
 	wait_ms(50);
 	outw(0, io_addr + USBCMD);
 	wait_ms(10);
+	uhci->resume_detect = 0;
 }
 
 static void suspend_hc(struct uhci_hcd *uhci)
 {
 	unsigned int io_addr = uhci->io_addr;
 
-	dbg("%x: suspend_hc", io_addr);
+	switch (uhci->state) {
+		case UHCI_RUNNING:		/* Suspend after 1 second */
+			uhci->state = UHCI_SUSPENDING_GRACE;
+			uhci->state_end = jiffies + HZ;
+			break;
 
-	uhci->is_suspended = 1;
-	smp_wmb();
+		case UHCI_SUSPENDING_GRACE:	/* Actually suspend */
+			dbg("%x: suspend_hc", io_addr);
+			uhci->state = UHCI_SUSPENDED;
+			uhci->resume_detect = 0;
+			outw(USBCMD_EGSM, io_addr + USBCMD);
+			break;
 
-	outw(USBCMD_EGSM, io_addr + USBCMD);
+		default:
+			break;
+	}
 }
 
 static void wakeup_hc(struct uhci_hcd *uhci)
 {
 	unsigned int io_addr = uhci->io_addr;
-	unsigned int status;
 
-	dbg("%x: wakeup_hc", io_addr);
+	switch (uhci->state) {
+		case UHCI_SUSPENDED:		/* Start the resume */
+			dbg("%x: wakeup_hc", io_addr);
+
+			/* Global resume for >= 20ms */
+			uhci->state = UHCI_RESUMING_1;
+			uhci->state_end = jiffies + (20*HZ+999) / 1000;
+			outw(USBCMD_FGR | USBCMD_EGSM, io_addr + USBCMD);
+			break;
 
-	/* Global resume for 20ms */
-	outw(USBCMD_FGR | USBCMD_EGSM, io_addr + USBCMD);
-	wait_ms(20);
-	outw(0, io_addr + USBCMD);
-	
-	/* wait for EOP to be sent */
-	status = inw(io_addr + USBCMD);
-	while (status & USBCMD_FGR)
-		status = inw(io_addr + USBCMD);
+		case UHCI_RESUMING_1:		/* Continue the resume */
+			uhci->state = UHCI_RESUMING_2;
+			outw(0, io_addr + USBCMD);
+			/* Falls through */
 
-	uhci->is_suspended = 0;
+		case UHCI_RESUMING_2:		/* Run for at least 1 second */
 
-	/* Run and mark it configured with a 64-byte max packet */
-	outw(USBCMD_RS | USBCMD_CF | USBCMD_MAXP, io_addr + USBCMD);
+			/* wait for EOP to be sent */
+			if (inw(io_addr + USBCMD) & USBCMD_FGR)
+				break;
+
+			/* Run and mark it configured with a 64-byte max packet */
+			uhci->state = UHCI_RUNNING_GRACE;
+			uhci->state_end = jiffies + HZ;
+			outw(USBCMD_RS | USBCMD_CF | USBCMD_MAXP,
+					io_addr + USBCMD);
+			break;
+
+		case UHCI_RUNNING_GRACE:	/* Now allowed to suspend */
+			uhci->state = UHCI_RUNNING;
+			break;
+
+		default:
+			break;
+	}
 }
 
 static int ports_active(struct uhci_hcd *uhci)
@@ -1975,6 +2002,40 @@
 	return connection;
 }
 
+static void hc_state_transitions(struct uhci_hcd *uhci)
+{
+	switch (uhci->state) {
+		case UHCI_RUNNING:
+
+			/* enter global suspend if nothing connected */
+			if (!ports_active(uhci))
+				suspend_hc(uhci);
+			break;
+
+		case UHCI_SUSPENDING_GRACE:
+			if (time_after_eq(jiffies, uhci->state_end))
+				suspend_hc(uhci);
+			break;
+
+		case UHCI_SUSPENDED:
+
+			/* wakeup if requested by a device */
+			if (uhci->resume_detect)
+				wakeup_hc(uhci);
+			break;
+
+		case UHCI_RESUMING_1:
+		case UHCI_RESUMING_2:
+		case UHCI_RUNNING_GRACE:
+			if (time_after_eq(jiffies, uhci->state_end))
+				wakeup_hc(uhci);
+			break;
+
+		default:
+			break;
+	}
+}
+
 static void start_hc(struct uhci_hcd *uhci)
 {
 	unsigned int io_addr = uhci->io_addr;
@@ -2003,6 +2064,8 @@
 	outl(uhci->fl->dma_handle, io_addr + USBFLBASEADD);
 
 	/* Run and mark it configured with a 64-byte max packet */
+	uhci->state = UHCI_RUNNING_GRACE;
+	uhci->state_end = jiffies + HZ;
 	outw(USBCMD_RS | USBCMD_CF | USBCMD_MAXP, io_addr + USBCMD);
 
         uhci->hcd.state = USB_STATE_READY;
@@ -2101,8 +2164,6 @@
 	uhci->fsbr = 0;
 	uhci->fsbrtimeout = 0;
 
-	uhci->is_suspended = 0;
-
 	spin_lock_init(&uhci->qh_remove_list_lock);
 	INIT_LIST_HEAD(&uhci->qh_remove_list);
 
@@ -2335,6 +2396,8 @@
 {
 	struct uhci_hcd *uhci = hcd_to_uhci(hcd);
 
+	/* Force an immediate suspend */
+	uhci->state = UHCI_SUSPENDING_GRACE;
 	suspend_hc(uhci);
 	return 0;
 }
===== uhci-hcd.h 1.11 vs edited =====
--- 1.11/drivers/usb/host/uhci-hcd.h	Tue Dec 10 14:03:10 2002
+++ edited/drivers/usb/host/uhci-hcd.h	Wed May 14 15:48:18 2003
@@ -282,6 +282,29 @@
 	return 0;				/* int128 for 128-255 ms (Max.) */
 }
 
+/*
+ * Device states for the host controller.
+ *
+ * To prevent "bouncing" in the presence of electrical noise,
+ * we insist on a 1-second "grace" period, before switching to
+ * the RUNNING or SUSPENDED states, during which the state is
+ * not allowed to change.
+ *
+ * The resume process is divided into substates in order to avoid
+ * potentially length delays during the timer handler.
+ *
+ * States in which the host controller is halted must have values <= 0.
+ */
+enum uhci_state {
+	UHCI_RESET,
+	UHCI_RUNNING_GRACE,		/* Before RUNNING */
+	UHCI_RUNNING,			/* The normal state */
+	UHCI_SUSPENDING_GRACE,		/* Before SUSPENDED */
+	UHCI_SUSPENDED = -10,		/* When no devices are attached */
+	UHCI_RESUMING_1,
+	UHCI_RESUMING_2
+};
+
 #define hcd_to_uhci(hcd_ptr) container_of(hcd_ptr, struct uhci_hcd, hcd)
 
 /*
@@ -313,7 +336,10 @@
 	struct uhci_frame_list *fl;		/* P: uhci->frame_list_lock */
 	int fsbr;				/* Full speed bandwidth reclamation */
 	unsigned long fsbrtimeout;		/* FSBR delay */
-	int is_suspended;
+
+	enum uhci_state state;			/* FIXME: needs a spinlock */
+	unsigned long state_end;		/* Time of next transition */
+	int resume_detect;			/* Need a Global Resume */
 
 	/* Main list of URB's currently controlled by this HC */
 	spinlock_t urb_list_lock;

