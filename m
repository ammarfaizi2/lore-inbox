Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964949AbVHSOjJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964949AbVHSOjJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Aug 2005 10:39:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964953AbVHSOjI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Aug 2005 10:39:08 -0400
Received: from amdext4.amd.com ([163.181.251.6]:54936 "EHLO amdext4.amd.com")
	by vger.kernel.org with ESMTP id S964949AbVHSOjH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Aug 2005 10:39:07 -0400
X-Server-Uuid: 5FC0E2DF-CD44-48CD-883A-0ED95B391E89
Message-ID: <4305EF1D.6020502@amd.com>
Date: Fri, 19 Aug 2005 08:39:25 -0600
From: "William Morrow" <William.Morrow@amd.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8)
 Gecko/20050513 Fedora/1.7.8-2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: dbrownell@users.sourceforge.net
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] for acpi S1 power cycle resume problems
X-WSS-ID: 6F1B31652CC10905926-01-01
Content-Type: multipart/mixed;
 boundary=------------080309010309050701070300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080309010309050701070300
Content-Type: text/plain;
 charset=iso-8859-1;
 format=flowed
Content-Transfer-Encoding: 7bit

Hi
I was told that if I had a patch to submit for a baseline change that 
this was the place to do it.
If not, please let me know...

thanks,
morrow

Patched against 2.6.11 baseline
problems fixed:
1) OHCI_INTR_RD not being cleared in ohci interrupt handler
 results in interrupt storm and system hang on RD status.
 ohci spec indicates this should be done.
2) PORT_CSC not being cleared in ehci_hub_status_data
 code attempts to clear bit, but bit is write to clear.
 there are other errant clears, since the PORTSCn regs
 have 3 RWC bits, and the rest are RW. All stmts of the form:
   writel (v, &ehci->regs->port_status[i])
 should clear RWC bits if they do not intend to clear status,
 and should set the bits which should be cleared (this case).
3) loop control and subsequent port resume/reset not correct.
 unsigned index made detecting port1 active impossible, and
 OWNER/POWER status was being ignored on ports assigned
 to companion controller.

Signed-off-by: Jordan Crouse <jordan.crouse@amd.com>


--------------080309010309050701070300
Content-Type: text/plain;
 name=patch
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename=patch

diff -uprN linux-2.6.11.orig/drivers/usb/host/ehci.h linux-2.6.11/drivers/usb/host/ehci.h
--- linux-2.6.11.orig/drivers/usb/host/ehci.h	2005-03-02 00:38:25.000000000 -0700
+++ linux-2.6.11/drivers/usb/host/ehci.h	2005-08-17 08:15:36.000000000 -0600
@@ -262,6 +262,7 @@ struct ehci_regs {
 #define PORT_PE		(1<<2)		/* port enable */
 #define PORT_CSC	(1<<1)		/* connect status change */
 #define PORT_CONNECT	(1<<0)		/* device connected */
+#define PORT_RWC_BITS   (PORT_CSC | PORT_PEC | PORT_OCC)
 } __attribute__ ((packed));
 
 /* Appendix C, Debug port ... intended for use with special "debug devices"
diff -uprN linux-2.6.11.orig/drivers/usb/host/ehci-hcd.c linux-2.6.11/drivers/usb/host/ehci-hcd.c
--- linux-2.6.11.orig/drivers/usb/host/ehci-hcd.c	2005-03-02 00:38:38.000000000 -0700
+++ linux-2.6.11/drivers/usb/host/ehci-hcd.c	2005-08-17 08:15:36.000000000 -0600
@@ -722,7 +722,7 @@ static int ehci_suspend (struct usb_hcd 
 static int ehci_resume (struct usb_hcd *hcd)
 {
 	struct ehci_hcd		*ehci = hcd_to_ehci (hcd);
-	unsigned		port;
+	int			port;
 	struct usb_device	*root = hcd->self.root_hub;
 	int			retval = -EINVAL;
 	int			powerup = 0;
@@ -733,11 +733,11 @@ static int ehci_resume (struct usb_hcd *
 		msleep (100);
 
 	/* If any port is suspended, we know we can/must resume the HC. */
-	for (port = HCS_N_PORTS (ehci->hcs_params); port > 0; ) {
+	for (port = HCS_N_PORTS (ehci->hcs_params); --port >= 0; ) {
 		u32	status;
-		port--;
 		status = readl (&ehci->regs->port_status [port]);
-		if (status & PORT_SUSPEND) {
+		if ( (status & PORT_SUSPEND) != 0 ||
+		    ((status & PORT_OWNER) != 0 && (status & PORT_POWER) != 0) ) {
 			down (&hcd->self.root_hub->serialize);
 			retval = ehci_hub_resume (hcd);
 			up (&hcd->self.root_hub->serialize);
@@ -755,7 +755,7 @@ static int ehci_resume (struct usb_hcd *
 	/* Else reset, to cope with power loss or flush-to-storage
 	 * style "resume" having activated BIOS during reboot.
 	 */
-	if (port == 0) {
+	if (port < 0) {
 		(void) ehci_halt (ehci);
 		(void) ehci_reset (ehci);
 		(void) ehci_hc_reset (hcd);
diff -uprN linux-2.6.11.orig/drivers/usb/host/ehci-hub.c linux-2.6.11/drivers/usb/host/ehci-hub.c
--- linux-2.6.11.orig/drivers/usb/host/ehci-hub.c	2005-03-02 00:38:32.000000000 -0700
+++ linux-2.6.11/drivers/usb/host/ehci-hub.c	2005-08-17 08:15:36.000000000 -0600
@@ -232,7 +232,8 @@ ehci_hub_status_data (struct usb_hcd *hc
 		if (temp & PORT_OWNER) {
 			/* don't report this in GetPortStatus */
 			if (temp & PORT_CSC) {
-				temp &= ~PORT_CSC;
+				temp &= ~PORT_RWC_BITS;
+				temp |= PORT_CSC;
 				writel (temp, &ehci->regs->port_status [i]);
 			}
 			continue;
diff -uprN linux-2.6.11.orig/drivers/usb/host/ohci-hcd.c linux-2.6.11/drivers/usb/host/ohci-hcd.c
--- linux-2.6.11.orig/drivers/usb/host/ohci-hcd.c	2005-03-02 00:37:48.000000000 -0700
+++ linux-2.6.11/drivers/usb/host/ohci-hcd.c	2005-08-17 08:15:36.000000000 -0600
@@ -720,6 +720,7 @@ static irqreturn_t ohci_irq (struct usb_
 
 	if (ints & OHCI_INTR_RD) {
 		ohci_vdbg (ohci, "resume detect\n");
+		ohci_writel (ohci, OHCI_INTR_RD, &regs->intrstatus);
 		schedule_work(&ohci->rh_resume);
 	}
 

--------------080309010309050701070300--

