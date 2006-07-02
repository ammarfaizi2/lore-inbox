Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750735AbWGBAC7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750735AbWGBAC7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jul 2006 20:02:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932116AbWGBAC7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jul 2006 20:02:59 -0400
Received: from smtp.osdl.org ([65.172.181.4]:14499 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751163AbWGBAC6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jul 2006 20:02:58 -0400
Date: Sat, 1 Jul 2006 17:02:29 -0700
From: Andrew Morton <akpm@osdl.org>
To: David Greaves <david@dgreaves.com>
Cc: galibert@pobox.com, linux-kernel@vger.kernel.org, marcel@holtmann.org,
       maxk@qualcomm.com, bluez-devel@lists.sourceforge.net
Subject: Re: [PATCH] Fix SCO on some bluetooth adapters (Success report for
 Belkin F8T012)
Message-Id: <20060701170229.4f0ec643.akpm@osdl.org>
In-Reply-To: <44A66911.50309@dgreaves.com>
References: <20060420140517.GA72089@dspnet.fr.eu.org>
	<44A66911.50309@dgreaves.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 01 Jul 2006 13:22:41 +0100
David Greaves <david@dgreaves.com> wrote:

> > Pavel, '4' doesn't seem to be a value that happens in any correctly
> > answering adapter, while 8 happens often.  Try "SCO MTU 64:4" and "SCO
> > MTU 64:8" for comparison.
> > 
> > 
> >  drivers/bluetooth/hci_usb.c      |   12 ++++++++++++
> >  drivers/bluetooth/hci_usb.h      |    1 +
> >  include/net/bluetooth/hci_core.h |    1 +
> >  net/bluetooth/hci_event.c        |   16 ++++++++++++++--
> >  4 files changed, 28 insertions(+), 2 deletions(-)
> > 
> > 841d7690e75189803907fbc4616b984087e7f89c
> 
> Replying to an old email about a patch that hasn't made it yet (at least
> to 2.6.17.3).
> 
> Without this patch I can't use my Belkin F8T012 with the bluetooth alsa
> sound driver (snd-bt-sco)
> 
> with it, I can :)
> 
> Thanks Olivier.
> 
> Is this likely to be merged?

It's floating around in -mm still.  I resend it to various people when I
feel like provoking a fight.

Marcel is working on a better way of fixing this problem.

But it's a teeny patch and `patch -R' is easy.  If this patch doesn't break
anything, perhaps we should temp-merge it?



From: Olivier Galibert <galibert@pobox.com>

Some bluetooth adapters return an incorrect number of sco packets in
READ_BUFFER_SIZE.  Fix it.

This is the worst possible way to fix it for several reasons:
- this is not a generic fix, it has to me activated explicitely by the
  driver

- this is not a driver-specific fix either, only one action is
  possible (change to 8), the driver can only enable it

- this is not a wildcard-able fix, because it overwrites the returned
  value no matter what, i.e. even when it is correct.  So drivers without
  device id which need it, for instance uart, can't use it.

- there is no warning anywhere when the problematic condition is
  detected, so users of non-listed buggy hardware have no clue about
  what is going on, and the list of buggy hardware will be very hard to
  complete

- the fix is inconsistant with the sco_mtu handling

But that's exactly what Marcel Holtmann wants, so that's what he gets.

Signed-off-by: Olivier Galibert <galibert@pobox.com>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Marcel Holtmann <marcel@holtmann.org>
Cc: Greg KH <greg@kroah.com>

[akpm: this is permanacked, but will keep getting sent until the problem is
fixed for real]

Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 drivers/bluetooth/hci_usb.c |    6 ++++++
 drivers/bluetooth/hci_usb.h |    1 +
 include/net/bluetooth/hci.h |    3 ++-
 net/bluetooth/hci_event.c   |   10 ++++++++--
 4 files changed, 17 insertions(+), 3 deletions(-)

diff -puN drivers/bluetooth/hci_usb.c~fix-sco-on-some-bluetooth-adapters-2 drivers/bluetooth/hci_usb.c
--- a/drivers/bluetooth/hci_usb.c~fix-sco-on-some-bluetooth-adapters-2
+++ a/drivers/bluetooth/hci_usb.c
@@ -129,6 +129,9 @@ static struct usb_device_id blacklist_id
 	/* CSR BlueCore Bluetooth Sniffer */
 	{ USB_DEVICE(0x0a12, 0x0002), .driver_info = HCI_SNIFFER },
 
+	/* Belkin F8T012 */
+	{ USB_DEVICE(0x050d, 0x0012), .driver_info = HCI_READ_BUFFER_SIZE },
+
 	{ }	/* Terminating entry */
 };
 
@@ -984,6 +987,9 @@ static int hci_usb_probe(struct usb_inte
 	if (reset || id->driver_info & HCI_RESET)
 		set_bit(HCI_QUIRK_RESET_ON_INIT, &hdev->quirks);
 
+	if (id->driver_info & HCI_READ_BUFFER_SIZE)
+		set_bit(HCI_QUIRK_FIX_SCO_PKTS, &hdev->quirks);
+
 	if (id->driver_info & HCI_SNIFFER) {
 		if (le16_to_cpu(udev->descriptor.bcdDevice) > 0x997)
 			set_bit(HCI_QUIRK_RAW_DEVICE, &hdev->quirks);
diff -puN drivers/bluetooth/hci_usb.h~fix-sco-on-some-bluetooth-adapters-2 drivers/bluetooth/hci_usb.h
--- a/drivers/bluetooth/hci_usb.h~fix-sco-on-some-bluetooth-adapters-2
+++ a/drivers/bluetooth/hci_usb.h
@@ -35,6 +35,7 @@
 #define HCI_SNIFFER		0x10
 #define HCI_BCM92035		0x20
 #define HCI_BROKEN_ISOC		0x40
+#define HCI_READ_BUFFER_SIZE    0x80
 
 #define HCI_MAX_IFACE_NUM	3
 
diff -puN include/net/bluetooth/hci.h~fix-sco-on-some-bluetooth-adapters-2 include/net/bluetooth/hci.h
--- a/include/net/bluetooth/hci.h~fix-sco-on-some-bluetooth-adapters-2
+++ a/include/net/bluetooth/hci.h
@@ -54,7 +54,8 @@
 /* HCI device quirks */
 enum {
 	HCI_QUIRK_RESET_ON_INIT,
-	HCI_QUIRK_RAW_DEVICE
+	HCI_QUIRK_RAW_DEVICE,
+	HCI_QUIRK_FIX_SCO_PKTS
 };
 
 /* HCI device flags */
diff -puN net/bluetooth/hci_event.c~fix-sco-on-some-bluetooth-adapters-2 net/bluetooth/hci_event.c
--- a/net/bluetooth/hci_event.c~fix-sco-on-some-bluetooth-adapters-2
+++ a/net/bluetooth/hci_event.c
@@ -320,8 +320,14 @@ static void hci_cc_info_param(struct hci
 
 		hdev->acl_mtu  = __le16_to_cpu(bs->acl_mtu);
 		hdev->sco_mtu  = bs->sco_mtu ? bs->sco_mtu : 64;
-		hdev->acl_pkts = hdev->acl_cnt = __le16_to_cpu(bs->acl_max_pkt);
-		hdev->sco_pkts = hdev->sco_cnt = __le16_to_cpu(bs->sco_max_pkt);
+		hdev->acl_pkts = __le16_to_cpu(bs->acl_max_pkt);
+		hdev->sco_pkts = __le16_to_cpu(bs->sco_max_pkt);
+
+		if (test_bit(HCI_QUIRK_FIX_SCO_PKTS, &hdev->quirks))
+			hdev->sco_pkts = 8;
+
+		hdev->acl_cnt = hdev->acl_pkts;
+		hdev->sco_cnt = hdev->sco_pkts;
 
 		BT_DBG("%s mtu: acl %d, sco %d max_pkt: acl %d, sco %d", hdev->name,
 			hdev->acl_mtu, hdev->sco_mtu, hdev->acl_pkts, hdev->sco_pkts);
_

