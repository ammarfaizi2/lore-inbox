Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262275AbVBXMJ0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262275AbVBXMJ0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 07:09:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262271AbVBXMJ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 07:09:26 -0500
Received: from fire.yars.free.net ([193.233.48.99]:64458 "EHLO fire.netis.ru")
	by vger.kernel.org with ESMTP id S262275AbVBXMIM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 07:08:12 -0500
Date: Thu, 24 Feb 2005 15:07:41 +0300
From: "Alexander V. Lukyanov" <lav@netis.ru>
To: linux-kernel@vger.kernel.org
Subject: [2.6.10] cdc-acm.c patches
Message-ID: <20050224120741.GA4639@night.netis.priv>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="qDbXVdCdHGoSgWSk"
Content-Disposition: inline
User-Agent: Mutt/1.4.2i
X-NETIS-MailScanner-Information: Please contact NETIS Telecom for more information <info@netis.ru> (+7 0852 797709)
X-NETIS-MailScanner: Found to be clean
X-NETIS-MailScanner-SpamCheck: not spam, SpamAssassin (score=-3.059,
	required 6, autolearn=not spam, ALL_TRUSTED -1.00, AWL 0.54,
	BAYES_00 -2.60)
X-MailScanner-From: lav@night.yars.free.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--qDbXVdCdHGoSgWSk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello!

I have ZyXEL UNO modem which has usb acm interface. Starting with kernel
version 2.6.8 the driver cdc-acm began to hand when the modem connection
was dropped due to being idle. After the hang, no data could be read from
the device /dev/usb/ttyACM0, but writting was ok. The led "data" was lit
on the modem all the time after the disconnect (which indicates that modem
has data to be read).

I tracked down the problem to this: acm_read_bulk was called from
usb_submit_urb(acm->readurb), _inside_ acm_tty_open, and that time acm->used
was 0 which led to acm_rx_tasklet being not called, and acm_read_bulk was
never called again.

The problem was caused by patch in 2.6.8, which moved incrementing of
acm->used to bottom of acm_tty_open. My patch to fix it is attached.

When debugging the problem I noticed that debug messages sometimes have
double \n and the second one is not KERN_DEBUG level, which causes it to
be emitted to display. A second patch to normalize newlines in debug
output is attached.

-- 
   Alexander.
--qDbXVdCdHGoSgWSk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="cdc-acm-hang-fix.diff"

--- linux-2.6.10/drivers/usb/class/cdc-acm.c.orig	Thu Feb 24 15:02:29 2005
+++ linux-2.6.10/drivers/usb/class/cdc-acm.c	Thu Feb 24 15:02:36 2005
@@ -272,7 +272,7 @@ static int acm_tty_open(struct tty_struc
 
         down(&open_sem);
 
-	if (acm->used) {
+	if (acm->used++) {
 		goto done;
         }
 
@@ -296,7 +296,6 @@ static int acm_tty_open(struct tty_struc
 	tty->low_latency = 1;
 
 done:
-	acm->used++;
 	up(&open_sem);
 	return 0;
 
@@ -305,6 +304,7 @@ full_bailout:
 bail_out_and_unlink:
 	usb_kill_urb(acm->ctrlurb);
 bail_out:
+	acm->used--;
 	up(&open_sem);
 	return -EIO;
 }

--qDbXVdCdHGoSgWSk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="cdc-acm-dbg-fix.diff"

--- linux-2.6.10/drivers/usb/class/cdc-acm.c.orig1	Thu Feb 24 15:02:41 2005
+++ linux-2.6.10/drivers/usb/class/cdc-acm.c	Thu Feb 24 15:03:41 2005
@@ -175,7 +175,7 @@ exit:
 static void acm_read_bulk(struct urb *urb, struct pt_regs *regs)
 {
 	struct acm *acm = urb->context;
-	dbg("Entering acm_read_bulk with status %d\n", urb->status);
+	dbg("Entering acm_read_bulk with status %d", urb->status);
 
 	if (!ACM_READY(acm))
 		return;
@@ -232,7 +232,7 @@ static void acm_rx_tasklet(unsigned long
 static void acm_write_bulk(struct urb *urb, struct pt_regs *regs)
 {
 	struct acm *acm = (struct acm *)urb->context;
-	dbg("Entering acm_write_bulk with status %d\n", urb->status);
+	dbg("Entering acm_write_bulk with status %d", urb->status);
 
 	if (!ACM_READY(acm))
 		goto out;
@@ -248,7 +248,7 @@ out:
 static void acm_softint(void *private)
 {
 	struct acm *acm = private;
-	dbg("Entering acm_softint.\n");
+	dbg("Entering acm_softint.");
 	
 	if (!ACM_READY(acm))
 		return;
@@ -262,7 +262,7 @@ static void acm_softint(void *private)
 static int acm_tty_open(struct tty_struct *tty, struct file *filp)
 {
 	struct acm *acm = acm_table[tty->index];
-	dbg("Entering acm_tty_open.\n");
+	dbg("Entering acm_tty_open.");
 
 	if (!acm || !acm->dev)
 		return -EINVAL;
@@ -339,7 +339,7 @@ static int acm_tty_write(struct tty_stru
 {
 	struct acm *acm = tty->driver_data;
 	int stat;
-	dbg("Entering acm_tty_write to write %d bytes,\n", count);
+	dbg("Entering acm_tty_write to write %d bytes,", count);
 
 	if (!ACM_READY(acm))
 		return -EINVAL;
@@ -352,7 +352,7 @@ static int acm_tty_write(struct tty_stru
 
 	dbg("Get %d bytes...", count);
 	memcpy(acm->write_buffer, buf, count);
-	dbg("  Successfully copied.\n");
+	dbg("  Successfully copied.");
 
 	acm->writeurb->transfer_buffer_length = count;
 	acm->writeurb->dev = acm->dev;
@@ -540,7 +540,7 @@ static int acm_probe (struct usb_interfa
 
 	if (!buflen) {
 		if (intf->cur_altsetting->endpoint->extralen && intf->cur_altsetting->endpoint->extra) {
-			dev_dbg(&intf->dev,"Seeking extra descriptors on endpoint");
+			dev_dbg(&intf->dev,"Seeking extra descriptors on endpoint\n");
 			buflen = intf->cur_altsetting->endpoint->extralen;
 			buffer = intf->cur_altsetting->endpoint->extra;
 		} else {

--qDbXVdCdHGoSgWSk--
