Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750999AbWCKR4P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750999AbWCKR4P (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Mar 2006 12:56:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751320AbWCKR4P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Mar 2006 12:56:15 -0500
Received: from adsl-70-250-156-241.dsl.austtx.swbell.net ([70.250.156.241]:45222
	"EHLO gw.microgate.com") by vger.kernel.org with ESMTP
	id S1750999AbWCKR4O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Mar 2006 12:56:14 -0500
Subject: Re: 2.6.16-rc5 pppd oops on disconnects
From: Paul Fulghum <paulkf@microgate.com>
To: Bob Copeland <me@bobcopeland.com>
Cc: paulus@samba.org, Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20060311150908.GA4872@hash.localnet>
References: <b6c5339f0603100625k3410897fy3515d93fa1918c9@mail.gmail.com>
	 <1142011340.3220.4.camel@amdx2.microgate.com>
	 <b6c5339f0603101048l1c362582xc4d2570bc9d569b@mail.gmail.com>
	 <1142018709.26063.5.camel@amdx2.microgate.com>
	 <20060311150908.GA4872@hash.localnet>
Content-Type: text/plain
Date: Sat, 11 Mar 2006 11:56:05 -0600
Message-Id: <1142099765.3241.3.camel@x2.pipehead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-03-11 at 10:09 -0500, Bob Copeland wrote:
> Well, back to at least 2.6.15-rc7 I get a similar oops so this looks old 
> and unrelated to the mutex changes.  I don't believe it triggers without 
> CONFIG_DEBUG_SLAB.  Also won't oops without something (ppp) using the 
> device at the time of disconnect.

OK, try this patch with CONFIG_DEBUG_SLAB on and post the
debug output with the oops.

I do see one problem with the cdc-acm driver (not setting
acm->tty to NULL on the last close, where tty is released).

Thanks,
Paul

-- 
Paul Fulghum
Microgate Systems, Ltd

--- linux-2.6.16-rc5/drivers/usb/class/cdc-acm.c	2006-02-27 09:24:29.000000000 -0600
+++ b/drivers/usb/class/cdc-acm.c	2006-03-11 11:50:40.000000000 -0600
@@ -258,6 +258,7 @@ static void acm_ctrl_irq(struct urb *urb
 
 			if (acm->tty && !acm->clocal && (acm->ctrlin & ~newctrl & ACM_CTRL_DCD)) {
 				dbg("calling hangup");
+				printk("acm_ctrl_irq tty_hangup(%p)\n", acm->tty);
 				tty_hangup(acm->tty);
 			}
 
@@ -443,6 +444,8 @@ static int acm_tty_open(struct tty_struc
 	tty->driver_data = acm;
 	acm->tty = tty;
 
+	printk("acm_tty_open tty=%p acm=%p acm->used=%p\n", tty, acm, acm->used);
+
 	/* force low_latency on so that our tty_push actually forces the data through,
 	   otherwise it is scheduled, and with high data rates data can get lost. */
 	tty->low_latency = 1;
@@ -504,6 +507,10 @@ static void acm_tty_close(struct tty_str
 	struct acm *acm = tty->driver_data;
 	int i;
 
+	printk("acm_tty_close tty=%p filp=%p acm=%p\n", tty, filp, acm);
+	if (acm)
+		printk("acm_tty_close acm->used=%d acm->dev=%p\n", acm->used, acm->dev);
+
 	if (!acm || !acm->used)
 		return;
 
@@ -517,6 +524,7 @@ static void acm_tty_close(struct tty_str
 				usb_kill_urb(acm->ru[i].urb);
 		} else
 			acm_tty_unregister(acm);
+		/* need to set acm->tty = NULL here */
 	}
 	up(&open_sem);
 }
@@ -1008,6 +1016,10 @@ static void acm_disconnect(struct usb_in
 	struct usb_device *usb_dev = interface_to_usbdev(intf);
 	int i;
 
+	printk("acm_disconnect intf=%p acm=%p usb_dev=%p\n", intf, acm, usb_dev);
+	if (acm)
+		printk("acm_disconnect acm->used=%d acm->dev=%p acm->tty=%p\n", acm->used, acm->dev, acm->tty);
+
 	if (!acm || !acm->dev) {
 		dbg("disconnect on nonexisting interface");
 		return;


