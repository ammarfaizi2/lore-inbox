Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262868AbVAKRDX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262868AbVAKRDX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 12:03:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262831AbVAKQ4j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 11:56:39 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:38826 "EHLO suse.cz")
	by vger.kernel.org with ESMTP id S262839AbVAKQhC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 11:37:02 -0500
Date: Tue, 11 Jan 2005 17:37:13 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: cijoml@volny.cz, linux-kernel@vger.kernel.org,
       linux-usb-deve@lists.sourceforge.net
Subject: Re: for USB guys - strange things in dmesg
Message-ID: <20050111163713.GA4500@ucw.cz>
References: <mailman.1104438600.3923.linux-kernel2news@redhat.com> <20050108150003.4adfdd7e@lembas.zaitcev.lan>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="gBBFr7Ir9EOA20Yy"
Content-Disposition: inline
In-Reply-To: <20050108150003.4adfdd7e@lembas.zaitcev.lan>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--gBBFr7Ir9EOA20Yy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Jan 08, 2005 at 03:00:03PM -0800, Pete Zaitcev wrote:
> On Thu, 30 Dec 2004 21:13:00 +0100, Michal Semler <cijoml@volny.cz> wrote:
> 
> > when inserting my Bluetooth dongle into USB port, I get into dmesg this:
> > Bluetooth: RFCOMM ver 1.4
> > Bluetooth: RFCOMM socket layer initialized
> > Bluetooth: RFCOMM TTY layer initialized
> > drivers/usb/input/hid-core.c: input irq status -84 received
> 
> >[.... LONG flood of the same messages ....]
> 
> > drivers/usb/input/hid-core.c: input irq status -84 received
> > usb 3-1: USB disconnect, address 3
> > drivers/usb/input/hid-core.c: input irq status -84 received
> > drivers/usb/input/hid-core.c: can't resubmit intr, 0000:00:1d.2-1/input1, status -19
> > usb 3-1: new full speed USB device using uhci_hcd and address 4
> > Bluetooth: HCI USB driver ver 2.7
> 
> What happens here is that the device disconnects itself during or after
> it's initialized.
> 
> Once the HC hardware detects the disconnect, future URBs will end with
> -84 error. However, the HID driver does not do anything about it.
> It continues to attempt to resubmit until the khubd does its processing
> and enters its disconnect method. In extreme cases, it is possible to
> have this submit-and-error-and-repeat loop to monopolize the CPU and
> prevent khubd from working ever, thus effectively locking up the box.
> Fortunately, in 2.6 kernel we standardized error codes, and thus drivers
> like hid can rely on -84 meaning a disconnect and not something else.
> In such case, hid has to stop resubmitting before its disconnect method
> is executed.
 
Can you test this patch? It seems to work for me.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR

--gBBFr7Ir9EOA20Yy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=hid-disconnect-fix

ChangeSet@1.1970, 2005-01-11 17:33:17+01:00, vojtech@silver.ucw.cz
  input: Handle -EILSEQ return code in the HID driver completion
         handlers as unplug.
         Flush request queue on unplug, too.
         
  Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>


 hid-core.c |   23 ++++++++++++++++++-----
 1 files changed, 18 insertions(+), 5 deletions(-)


diff -Nru a/drivers/usb/input/hid-core.c b/drivers/usb/input/hid-core.c
--- a/drivers/usb/input/hid-core.c	2005-01-11 17:34:52 +01:00
+++ b/drivers/usb/input/hid-core.c	2005-01-11 17:34:52 +01:00
@@ -925,8 +925,9 @@
 			break;
 		case -ECONNRESET:	/* unlink */
 		case -ENOENT:
-		case -ESHUTDOWN:
 		case -EPERM:
+		case -ESHUTDOWN:	/* unplug */
+		case -EILSEQ:		/* unplug timeout on uhci */
 			return;
 		case -ETIMEDOUT:	/* NAK */
 			break;
@@ -1136,12 +1137,15 @@
 {
 	struct hid_device *hid = urb->context;
 	unsigned long flags;
+	int unplug = 0;
 
 	switch (urb->status) {
 		case 0:			/* success */
+		case -ESHUTDOWN:	/* unplug */
+		case -EILSEQ:		/* unplug timeout on uhci */
+			unplug = 1;
 		case -ECONNRESET:	/* unlink */
 		case -ENOENT:
-		case -ESHUTDOWN:
 			break;
 		default:		/* error */
 			warn("output irq status %d received", urb->status);
@@ -1149,7 +1153,10 @@
 
 	spin_lock_irqsave(&hid->outlock, flags);
 
-	hid->outtail = (hid->outtail + 1) & (HID_OUTPUT_FIFO_SIZE - 1);
+	if (unplug)
+		hid->outtail = hid->outhead;
+	else
+		hid->outtail = (hid->outtail + 1) & (HID_OUTPUT_FIFO_SIZE - 1);
 
 	if (hid->outhead != hid->outtail) {
 		if (hid_submit_out(hid)) {
@@ -1173,6 +1180,7 @@
 {
 	struct hid_device *hid = urb->context;
 	unsigned long flags;
+	int unplug = 0;
 
 	spin_lock_irqsave(&hid->ctrllock, flags);
 
@@ -1180,16 +1188,21 @@
 		case 0:			/* success */
 			if (hid->ctrl[hid->ctrltail].dir == USB_DIR_IN) 
 				hid_input_report(hid->ctrl[hid->ctrltail].report->type, urb, regs);
+		case -ESHUTDOWN:	/* unplug */
+		case -EILSEQ:		/* unplug timectrl on uhci */
+			unplug = 1;
 		case -ECONNRESET:	/* unlink */
 		case -ENOENT:
-		case -ESHUTDOWN:
 		case -EPIPE:		/* report not available */
 			break;
 		default:		/* error */
 			warn("ctrl urb status %d received", urb->status);
 	}
 
-	hid->ctrltail = (hid->ctrltail + 1) & (HID_CONTROL_FIFO_SIZE - 1);
+	if (unplug)
+		hid->ctrltail = hid->ctrlhead;
+	else
+		hid->ctrltail = (hid->ctrltail + 1) & (HID_CONTROL_FIFO_SIZE - 1);
 
 	if (hid->ctrlhead != hid->ctrltail) {
 		if (hid_submit_ctrl(hid)) {

--gBBFr7Ir9EOA20Yy--
