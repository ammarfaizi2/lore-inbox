Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265367AbTLHKKj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Dec 2003 05:10:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265368AbTLHKKh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Dec 2003 05:10:37 -0500
Received: from postfix4-1.free.fr ([213.228.0.62]:27602 "EHLO
	postfix4-1.free.fr") by vger.kernel.org with ESMTP id S265367AbTLHKKe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Dec 2003 05:10:34 -0500
From: Duncan Sands <baldrick@free.fr>
To: Vince <fuzzy77@free.fr>
Subject: Re: [OOPS,  usbcore, releaseintf] 2.6.0-test10-mm1
Date: Mon, 8 Dec 2003 11:10:28 +0100
User-Agent: KMail/1.5.4
Cc: "Randy.Dunlap" <rddunlap@osdl.org>, mfedyk@matchmail.com,
       zwane@holomorphy.com, linux-kernel@vger.kernel.org,
       USB development list <linux-usb-devel@lists.sourceforge.net>
References: <3FC4E8C8.4070902@free.fr> <200312072224.32417.baldrick@free.fr> <3FD3AF9F.6010406@free.fr>
In-Reply-To: <3FD3AF9F.6010406@free.fr>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312081110.28590.baldrick@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vince, I'm not sure, but it looks like a bug in the USB core.
I was kind of expecting this :)  My patch causes devio.c to hold
a reference to the usb_device maybe long after the device has
been disconnected.  This is supposed to be OK, but from your
Oops it looks like some part of the hcd was finalized too early
(before devio.c dropped its reference to the usb_device).  Maybe
one of the USB guys can comment?

All the best,

Duncan.

On Sunday 07 December 2003 23:54, Vince wrote:
> Duncan Sands wrote:
> > Hi Vincent, that's great!  I think the fix is solid, but can you please
> > beat on it a bit just to be sure...
> >
> > Thanks,
> >
> > Duncan.
>
> I'm not sure how to reproduce the previous oops (not even if it was
> really related to your patch...), but here follows a real, untainted
> oops I finally got:
>
> [9889]: shutting down for system reboot
> printing eip:
> c8ae8999
> Oops: 0000 [#1]
> PREEMPT
> CPU:    0
> EIP:    0060:[<c8ae8999>]    Not tainted VLI
> EFLAGS: 00010286
> EIP is at hcd_pci_release+0x19/0x20 [usbcore]
> eax: c8c69d80   ebx: c637f050   ecx: c8af6c20   edx: c637f000
> esi: c031e65c   edi: c031e680   ebp: c0019ec4   esp: c0019ec0
> ds: 007b   es: 007b   ss: 0068
> Process modem_run (pid: 8460, threadinfo=c0018000 task=c1508080)
> Stack: c637f000 c0019ed0 c8ae455d c637f000 c0019ee8 c0203738 c637f048
> c0019f00
> c8ae77d6 c031e450 c0019f00 c01bc88f c637f050 c6b09200 c031e428 c031e440
> c0019f10 c8ae08b6 c637f050 00000000 c0019f2c c02019e1 c6b092cc c0019f2c
> Call Trace:
> [<c8ae455d>] usb_host_release+0x1d/0x20 [usbcore]
> [<c0203738>] class_dev_release+0x58/0x60
> [<c8ae77d6>] usb_destroy_configuration+0xb6/0xf0 [usbcore]
> [<c01bc88f>] kobject_cleanup+0x6f/0x80
> [<c8ae08b6>] usb_release_dev+0x46/0x60 [usbcore]
> [<c02019e1>] device_release+0x21/0x80
> [<c01bc88f>] kobject_cleanup+0x6f/0x80
> [<c8ae9b38>] usbdev_release+0x88/0xc0 [usbcore]
> [<c0157a5c>] __fput+0x10c/0x120
> [<c0156047>] filp_close+0x57/0x80
> [<c01560d1>] sys_close+0x61/0x90
> [<c02a302e>] sysenter_past_esp+0x43/0x65
>
> Code: 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 55 89 e5 83
> ec 04 8b 45 08 8b 50 30 85 d2 74 0c 8b 82 08 01 00 00 89 14 24 <ff> 50
> 28 c9 c3 89 f6 55 89 e5 57 56 53 83 ec 34 8b 5d 0c e8 3f
> <0>Fatal exception: panic in 5 seconds
