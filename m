Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264600AbUEJKn4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264600AbUEJKn4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 May 2004 06:43:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264616AbUEJKn4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 May 2004 06:43:56 -0400
Received: from coyote.holtmann.net ([217.160.111.169]:17604 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S264600AbUEJKkp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 May 2004 06:40:45 -0400
Subject: Re: [PATCH] hci-usb bugfix
From: Marcel Holtmann <marcel@holtmann.org>
To: Soeren Sonnenburg <kernel@nn7.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <pan.2004.05.09.22.37.55.951344@nn7.de>
References: <20040509194715.GA2163@eniac.lan.yath.eu.org>
	 <pan.2004.05.09.22.37.55.951344@nn7.de>
Content-Type: multipart/mixed; boundary="=-6qC/oQJNGq1Za1wNLr+v"
Message-Id: <1084185635.4017.5.camel@pegasus>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 10 May 2004 12:40:36 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-6qC/oQJNGq1Za1wNLr+v
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Soeren,

> indeed it fixes this oops ... however I still get 

please try the attached patch. It should fix it, too.

> usb 2-1: USB disconnect, address 4
> usb 2-1: new full speed USB device using address 5
> devfs_mk_dev: could not append to parent for bluetooth/rfcomm/0
> devfs_remove: bluetooth/rfcomm/0 not found, cannot remove
> Call trace:
>  [c00099c4] dump_stack+0x18/0x28
>  [c010af1c] devfs_remove+0xcc/0xd0
>  [c01e4a5c] tty_unregister_device+0x30/0x5c
>  [f2080b64] rfcomm_dev_destruct+0x50/0xd4 [rfcomm]
>  [f2081310] rfcomm_release_dev+0xf8/0x148 [rfcomm]
>  [f20807a8] rfcomm_sock_ioctl+0x34/0x58 [rfcomm]
>  [c02a8668] sock_ioctl+0xc0/0x2c0
>  [c00726e0] sys_ioctl+0x100/0x318
>  [c0005d60] ret_from_syscall+0x0/0x44
> usb 2-1: USB disconnect, address 5

Do you use DevFS? Does the same problem exists if you disable it and use
udev instead?

Regards

Marcel


--=-6qC/oQJNGq1Za1wNLr+v
Content-Disposition: attachment; filename=patch
Content-Type: text/plain; name=patch; charset=iso-8859-1
Content-Transfer-Encoding: 7bit

===== drivers/bluetooth/hci_usb.c 1.49 vs edited =====
--- 1.49/drivers/bluetooth/hci_usb.c	Sat Apr 17 00:23:48 2004
+++ edited/drivers/bluetooth/hci_usb.c	Mon May 10 12:03:05 2004
@@ -976,11 +971,13 @@
 static void hci_usb_disconnect(struct usb_interface *intf)
 {
 	struct hci_usb *husb = usb_get_intfdata(intf);
-	struct hci_dev *hdev = husb->hdev;
+	struct hci_dev *hdev;
 
-	if (!husb)
+	if (!husb || intf == husb->isoc_iface)
 		return;
+
 	usb_set_intfdata(intf, NULL);
+	hdev = husb->hdev;
 
 	BT_DBG("%s", hdev->name);
 

--=-6qC/oQJNGq1Za1wNLr+v--

