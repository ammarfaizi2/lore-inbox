Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262900AbVDHT5K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262900AbVDHT5K (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 15:57:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262898AbVDHT5J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 15:57:09 -0400
Received: from khan.acc.umu.se ([130.239.18.139]:9940 "EHLO khan.acc.umu.se")
	by vger.kernel.org with ESMTP id S262900AbVDHT4j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 15:56:39 -0400
Date: Fri, 8 Apr 2005 21:56:33 +0200
From: Tomas =?iso-8859-1?Q?=D6gren?= <stric@acc.umu.se>
To: linux-kernel@vger.kernel.org
Subject: [2.4] "Fix" introduced in 2.4.27pre2 for bluetooth hci_usb race causes kernel hang
Message-ID: <20050408195632.GA17621@shaka.acc.umu.se>
Mail-Followup-To: Tomas =?iso-8859-1?Q?=D6gren?= <stric@acc.umu.se>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

I have noticed a problem with a race condition fix introduced in
2.4.27-pre2 that causes the kernel to hang when disconnecting a
Bluetooth USB dongle or doing 'hciconfig hci0 down'. No message is
printed, the kernel just doesn't respond anymore.

Seen in Changelog:
Marcel Holtmann:
  o [Bluetooth] Fix race in RX complete routine of the USB drivers

Reversing the following patch to hci_usb_rx_complete() makes 2.4.27-pre2
up until 2.4.30 happy and does not hang when removing the dongle
anymore. (bfusb.c has the same patch applied)

2.6.11.7 does not show the same problem, but has similar code to the
"fixed" (that hangs) code in 2.4, so the real problem is probably
somewhere else.

I have tested this on Dell Optiplex GX150, 260 and 280's which has Intel
P3 and P4 with Intel UHCI USB chipset. I have tested both usb-uhci.o and
uhci.o with the same results. Tested with USB Bluetooth dongles with
both Broadcom and Cambridge Silicon Radio chipsets, same results.

modules loaded: l2cap, hci_usb, bluez, (usb-)uhci, usbcore

diff -ruN linux-2.4.27-pre1/drivers/bluetooth/hci_usb.c linux-2.4.27-pre2/drivers/bluetooth/hci_usb.c
--- linux-2.4.27-pre1/drivers/bluetooth/hci_usb.c       2004-04-14 15:05:29.000000000 +0200
+++ linux-2.4.27-pre2/drivers/bluetooth/hci_usb.c       2005-04-08 20:16:51.000000000 +0200
@@ -699,11 +699,11 @@
        BT_DBG("%s urb %p type %d status %d count %d flags %x", hdev->name, urb,
                        _urb->type, urb->status, count, urb->transfer_flags);

-       if (!test_bit(HCI_RUNNING, &hdev->flags))
-               return;
-
        read_lock(&husb->completion_lock);

+       if (!test_bit(HCI_RUNNING, &hdev->flags))
+               goto unlock;
+
        if (urb->status || !count)
                goto resubmit;

@@ -740,6 +740,8 @@
                BT_DBG("%s urb %p type %d resubmit status %d", hdev->name, urb,
                                _urb->type, err);
        }
+
+unlock:
        read_unlock(&husb->completion_lock);
 }


Please CC me for any responses, not on the list.

/Tomas
-- 
Tomas Ögren, stric@acc.umu.se, http://www.acc.umu.se/~stric/
|- Student at Computing Science, University of Umeå
`- Sysadmin at {cs,acc}.umu.se
