Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261270AbVAHXBJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261270AbVAHXBJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 18:01:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261282AbVAHXBJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 18:01:09 -0500
Received: from mx1.redhat.com ([66.187.233.31]:10909 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261270AbVAHXAq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 18:00:46 -0500
Date: Sat, 8 Jan 2005 15:00:03 -0800
From: Pete Zaitcev <zaitcev@redhat.com>
To: cijoml@volny.cz, linux-kernel@vger.kernel.org, vojtech@suse.cz
Cc: linux-usb-deve@lists.sourceforge.net
Subject: Re: for USB guys - strange things in dmesg
Message-ID: <20050108150003.4adfdd7e@lembas.zaitcev.lan>
In-Reply-To: <mailman.1104438600.3923.linux-kernel2news@redhat.com>
References: <mailman.1104438600.3923.linux-kernel2news@redhat.com>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed-Claws 0.9.12cvs126.2 (GTK+ 2.4.14; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Dec 2004 21:13:00 +0100, Michal Semler <cijoml@volny.cz> wrote:

> when inserting my Bluetooth dongle into USB port, I get into dmesg this:
> Bluetooth: RFCOMM ver 1.4
> Bluetooth: RFCOMM socket layer initialized
> Bluetooth: RFCOMM TTY layer initialized
> drivers/usb/input/hid-core.c: input irq status -84 received

>[.... LONG flood of the same messages ....]

> drivers/usb/input/hid-core.c: input irq status -84 received
> usb 3-1: USB disconnect, address 3
> drivers/usb/input/hid-core.c: input irq status -84 received
> drivers/usb/input/hid-core.c: can't resubmit intr, 0000:00:1d.2-1/input1, status -19
> usb 3-1: new full speed USB device using uhci_hcd and address 4
> Bluetooth: HCI USB driver ver 2.7

What happens here is that the device disconnects itself during or after
it's initialized.

Once the HC hardware detects the disconnect, future URBs will end with
-84 error. However, the HID driver does not do anything about it.
It continues to attempt to resubmit until the khubd does its processing
and enters its disconnect method. In extreme cases, it is possible to
have this submit-and-error-and-repeat loop to monopolize the CPU and
prevent khubd from working ever, thus effectively locking up the box.
Fortunately, in 2.6 kernel we standardized error codes, and thus drivers
like hid can rely on -84 meaning a disconnect and not something else.
In such case, hid has to stop resubmitting before its disconnect method
is executed.

This is relevant to all drivers which submit interrupt URBs. One driver
which does it correctly is mct_u232 (surprisingly enough), so the code
can be taken from there.

-- Pete
