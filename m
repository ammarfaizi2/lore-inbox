Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263660AbTKYXdr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Nov 2003 18:33:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263702AbTKYXdr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Nov 2003 18:33:47 -0500
Received: from mid-1.inet.it ([213.92.5.18]:44974 "EHLO mid-1.inet.it")
	by vger.kernel.org with ESMTP id S263660AbTKYXdo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Nov 2003 18:33:44 -0500
From: Fabio Coatti <cova@ferrara.linux.it>
Organization: FerraraLUG
To: Marcel Holtmann <marcel@holtmann.org>, linux-kernel@vger.kernel.org
Subject: Re: test9 and bluetooth - got it :)
Date: Wed, 26 Nov 2003 00:33:20 +0100
User-Agent: KMail/1.5.4
Cc: "Maxim Krasnyansky <maxk@qualcomm.com>"@kefk.homelinux.org,
       Mauro Tortonesi <mauro@deepspace6.net>
References: <200311021853.47300.cova@ferrara.linux.it> <200311192219.02964.cova@ferrara.linux.it> <1069280879.9473.179.camel@pegasus>
In-Reply-To: <1069280879.9473.179.camel@pegasus>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8bit
Message-Id: <200311260033.20580.cova@ferrara.linux.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alle 23:27, mercoledì 19 novembre 2003, Marcel Holtmann ha scritto:

>
> I don't wrote the SCO part of the HCI USB driver and I never worked with
> USB ISOC transfers. At the moment we don't know if the problem is part
> of the USB subsystem or if it is the driver itself, but I suspect it is
> the driver. However I am the wrong person to ask for a fix :(

Thanks anyway; I've spent some time digging in logs with BT_DEBUG defined, and 
I've seen something curious, so I'm posting here and cc'ing the hci_usb 
module maintainer as seen on .c file; if someone else is in charge to follow 
this code please let me know. I've tried the following without loading hcid 
or sdpd, if I do it the crash when usb BT dongle is removed is granted :)


The first thing that I've noticed when a usb BT dongle is plugged is this 
error: (test9-bk24)

Nov 25 21:16:02 kefk kernel: hci_usb_intr_rx_submit: hci0
Nov 25 21:16:02 kefk kernel: hci_usb_bulk_rx_submit: hci0 urb f28f1614
Nov 25 21:16:02 kefk kernel: __fill_isoc_desc: len 490 mtu 49
Nov 25 21:16:02 kefk kernel: __fill_isoc_desc: desc 0 offset 0 len 49
Nov 25 21:16:02 kefk kernel: __fill_isoc_desc: desc 1 offset 49 len 49
Nov 25 21:16:02 kefk kernel: __fill_isoc_desc: desc 2 offset 98 len 49
Nov 25 21:16:02 kefk kernel: __fill_isoc_desc: desc 3 offset 147 len 49
Nov 25 21:16:02 kefk kernel: __fill_isoc_desc: desc 4 offset 196 len 49
Nov 25 21:16:02 kefk kernel: __fill_isoc_desc: desc 5 offset 245 len 49
Nov 25 21:16:02 kefk kernel: __fill_isoc_desc: desc 6 offset 294 len 49
Nov 25 21:16:02 kefk kernel: __fill_isoc_desc: desc 7 offset 343 len 49
Nov 25 21:16:02 kefk kernel: __fill_isoc_desc: desc 8 offset 392 len 49
Nov 25 21:16:02 kefk kernel: __fill_isoc_desc: desc 9 offset 441 len 49
Nov 25 21:16:02 kefk kernel: hci_usb_isoc_rx_submit: hci0 urb f567e414
Nov 25 21:16:02 kefk kernel: hci_usb_isoc_rx_submit: hci0 isoc rx submit 
failed urb f567e414 err -22
Nov 25 21:16:02 kefk kernel: __hci_request: hci0 start

i've checked and it seems that usb_submit_urb: fails here (line 340):

        switch (temp) {
        case PIPE_ISOCHRONOUS:
        case PIPE_INTERRUPT:
                /* too small? */
                if (urb->interval <= 0)
                        return -EINVAL;

maybe urb->interval is not set from calling code:
static int hci_usb_isoc_rx_submit(struct hci_usb *husb)
(line 236 of ./drivers/bluetooth/hci_usb.c)
but i don't know if this can cause harm.

I've also noticed that when the sub dongle is unplugged, every 10 seconds I 
get this:

Nov 25 23:49:38 kefk kernel: drivers/usb/host/uhci-hcd.c: c000: suspend_hc
Nov 25 23:49:47 kefk kernel: hci_sock_create: sock d9f14980
Nov 25 23:49:47 kefk kernel: hci_sock_bind: sock d9f14980 sk dae8f500
Nov 25 23:49:47 kefk kernel: hci_dev_get: 0
Nov 25 23:49:57 kefk kernel: hci_sock_create: sock d9f14780
Nov 25 23:49:57 kefk kernel: hci_sock_bind: sock d9f14780 sk dae8f980
Nov 25 23:49:57 kefk kernel: hci_dev_get: 0
Nov 25 23:50:07 kefk kernel: hci_sock_create: sock d9f14580
Nov 25 23:50:07 kefk kernel: hci_sock_bind: sock d9f14580 sk dae8f680
Nov 25 23:50:07 kefk kernel: hci_dev_get: 0

and the use count of bluetooth module get a +2 increment each time. (hci_usb 
is not loaded)
I can see the same behaviour with 2.6.0-test10-bk1

Module                  Size  Used by
bnep                   11648  0
l2cap                  26368  1 bnep
bluetooth              47972  36 bnep,l2cap

The same holds even if I unload bnep and l2cap modules.

I'll be happy to add any needed information or make other tests, just let me 
know.

-- 
Fabio Coatti       http://www.ferrara.linux.it/members/cova     
Ferrara Linux Users Group           http://ferrara.linux.it
GnuPG fp:9765 A5B6 6843 17BC A646  BE8C FA56 373A 5374 C703
Old SysOps never die... they simply forget their password.

