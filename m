Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262768AbVAKOVc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262768AbVAKOVc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 09:21:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262769AbVAKOVc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 09:21:32 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:58769 "EHLO suse.cz")
	by vger.kernel.org with ESMTP id S262768AbVAKOVX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 09:21:23 -0500
Date: Tue, 11 Jan 2005 15:21:35 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: cijoml@volny.cz, linux-kernel@vger.kernel.org,
       linux-usb-deve@lists.sourceforge.net
Subject: Re: for USB guys - strange things in dmesg
Message-ID: <20050111142135.GA3729@ucw.cz>
References: <mailman.1104438600.3923.linux-kernel2news@redhat.com> <20050108150003.4adfdd7e@lembas.zaitcev.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050108150003.4adfdd7e@lembas.zaitcev.lan>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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

-84 is, according to documentation, -EILSEQ, and means "a CRC error",
that shouldn't normally happen and "indicates hardware problems such as
bad devices (including firmware) or cables".

I'm getting -84 on disconnect now, too, which suggests that uhci-hcd
might be using incorrect error code here.

Looking at uhci-hcd, it reports -EILSEQ in case there is a timeout on
the bus talking to the device. This can happen due to a disconnect, but
the HC should notice the disconnect I believe and return the right error
code.

Disconnects (-ESHUTDOWN) are already handled by hid-core.c

> This is relevant to all drivers which submit interrupt URBs. One driver
> which does it correctly is mct_u232 (surprisingly enough), so the code
> can be taken from there.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
