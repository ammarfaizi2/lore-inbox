Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261706AbTESQ24 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 12:28:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261754AbTESQ2z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 12:28:55 -0400
Received: from ida.rowland.org ([192.131.102.52]:8708 "HELO ida.rowland.org")
	by vger.kernel.org with SMTP id S261706AbTESQ2r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 12:28:47 -0400
Date: Mon, 19 May 2003 12:41:44 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@ida.rowland.org
To: Paul Fulghum <paulkf@microgate.com>
cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       <johannes@erdfelt.com>,
       USB development list <linux-usb-devel@lists.sourceforge.net>
Subject: Re: Test Patch: 2.5.69 Interrupt Latency
In-Reply-To: <1053100440.1948.17.camel@toshiba>
Message-ID: <Pine.LNX.4.44L0.0305191235470.655-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul:

The patch below incorporates your suggested subroutine.  That alone wasn't
enough to prevent the state from bouncing a few times when I powered my
USB device on or off, so the debounce code is in there too.  This patch
behaves fine on my workstation, which has both ports connected.  I'll try
it later on my laptop, which only has one port.

In the end, I decided it was easiest and safest to follow your "don't 
suspend if any ports are OC" scheme.  We can try it the other way too if 
you want.  What do you think would happen if you were to try to put your 
machine in an APM/ACPI "suspend" state?

This is a cumulative patch, i.e., it applies to a virgin 2.5.69 source.  
Let me know how it works for you.

Alan Stern


===== uhci-hcd.c 1.48 vs edited =====
--- 1.48/drivers/usb/host/uhci-hcd.c	Mon May  5 02:49:54 2003
+++ edited/drivers/usb/host/uhci-hcd.c	Mon May 19 11:30:22 2003
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
 
@@ -1922,10 +1919,12 @@
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
@@ -1933,34 +1932,48 @@
 	unsigned int io_addr = uhci->io_addr;
 
 	dbg("%x: suspend_hc", io_addr);
-
-	uhci->is_suspended = 1;
-	smp_wmb();
-
+	uhci->state = UHCI_SUSPENDED;
+	uhci->resume_detect = 0;
 	outw(USBCMD_EGSM, io_addr + USBCMD);
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
+		case UHCI_RESUMING_1:		/* End global resume */
+			uhci->state = UHCI_RESUMING_2;
+			outw(0, io_addr + USBCMD);
+			/* Falls through */
 
-	uhci->is_suspended = 0;
+		case UHCI_RESUMING_2:		/* Wait for EOP to be sent */
+			if (inw(io_addr + USBCMD) & USBCMD_FGR)
+				break;
 
-	/* Run and mark it configured with a 64-byte max packet */
-	outw(USBCMD_RS | USBCMD_CF | USBCMD_MAXP, io_addr + USBCMD);
+			/* Run for at least 1 second, and
+			 * mark it configured with a 64-byte max packet */
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
@@ -1975,6 +1988,73 @@
 	return connection;
 }
 
+static int suspend_allowed(struct uhci_hcd *uhci)
+{
+	unsigned int io_addr = uhci->io_addr;
+	int i;
+
+	if (!uhci->hcd.pdev ||
+	     uhci->hcd.pdev->vendor != PCI_VENDOR_ID_INTEL ||
+	     uhci->hcd.pdev->device != PCI_DEVICE_ID_INTEL_82371AB_2)
+		return 1;
+
+	/* This is a 82371AB/EB/MB USB controller which has a bug that
+	 * causes false resume indications if any port has an
+	 * over current condition.  To prevent problems, we will not
+	 * allow a global suspend if any ports are OC.
+	 *
+	 * Some motherboards using the 82371AB/EB/MB (but not the USB portion)
+	 * appear to hardwire the over current inputs active to disable
+	 * the USB ports.
+	 */
+
+	/* check for over current condition on any port */
+	for (i = 0; i < uhci->rh_numports; i++) {
+		if (inw(io_addr + USBPORTSC1 + i * 2) & USBPORTSC_OC)
+			return 0;
+	}
+
+	return 1;
+}
+
+static void hc_state_transitions(struct uhci_hcd *uhci)
+{
+	switch (uhci->state) {
+		case UHCI_RUNNING:
+
+			/* global suspend if nothing connected for 1 second */
+			if (!ports_active(uhci) && suspend_allowed(uhci)) {
+				uhci->state = UHCI_SUSPENDING_GRACE;
+				uhci->state_end = jiffies + HZ;
+			}
+			break;
+
+		case UHCI_SUSPENDING_GRACE:
+			if (ports_active(uhci))
+				uhci->state = UHCI_RUNNING;
+			else if (time_after_eq(jiffies, uhci->state_end))
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
@@ -2003,6 +2083,8 @@
 	outl(uhci->fl->dma_handle, io_addr + USBFLBASEADD);
 
 	/* Run and mark it configured with a 64-byte max packet */
+	uhci->state = UHCI_RUNNING_GRACE;
+	uhci->state_end = jiffies + HZ;
 	outw(USBCMD_RS | USBCMD_CF | USBCMD_MAXP, io_addr + USBCMD);
 
         uhci->hcd.state = USB_STATE_READY;
@@ -2100,8 +2182,6 @@
 
 	uhci->fsbr = 0;
 	uhci->fsbrtimeout = 0;
-
-	uhci->is_suspended = 0;
 
 	spin_lock_init(&uhci->qh_remove_list_lock);
 	INIT_LIST_HEAD(&uhci->qh_remove_list);
===== uhci-hcd.h 1.11 vs edited =====
--- 1.11/drivers/usb/host/uhci-hcd.h	Tue Dec 10 14:03:10 2002
+++ edited/drivers/usb/host/uhci-hcd.h	Mon May 19 10:36:36 2003
@@ -53,6 +53,7 @@
 #define   USBPORTSC_RD		0x0040	/* Resume Detect */
 #define   USBPORTSC_LSDA	0x0100	/* Low Speed Device Attached */
 #define   USBPORTSC_PR		0x0200	/* Port Reset */
+#define   USBPORTSC_OC		0x0400	/* Over Current condition */
 #define   USBPORTSC_SUSP	0x1000	/* Suspend */
 
 /* Legacy support register */
@@ -282,6 +283,29 @@
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
@@ -313,7 +337,10 @@
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

