Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263594AbUDYVsZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263594AbUDYVsZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Apr 2004 17:48:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263620AbUDYVsT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Apr 2004 17:48:19 -0400
Received: from smtp812.mail.sc5.yahoo.com ([66.163.170.82]:7312 "HELO
	smtp812.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S263594AbUDYVsJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Apr 2004 17:48:09 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: Re: [OOPS/HACK] atmel_cs and the latest changes in sysfs/symlink.c
Date: Sun, 25 Apr 2004 16:48:07 -0500
User-Agent: KMail/1.6.1
Cc: Greg KH <greg@kroah.com>, linux-usb-devel@lists.sourceforge.net,
       vojtech@suse.cz
References: <200404230142.46792.dtor_core@ameritech.net> <200404240144.05004.dtor_core@ameritech.net> <20040425024900.GA13971@kroah.com>
In-Reply-To: <20040425024900.GA13971@kroah.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200404251648.07232.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 24 April 2004 09:49 pm, Greg KH wrote:
> On Sat, Apr 24, 2004 at 01:44:04AM -0500, Dmitry Torokhov wrote:
>
> > Yes, it does fix it for me, thanks a lot!
> > Now if somebody could fix the following oops...
> 
> When does that oops happen?  With my patch applied?  Are you yanking out
> a device that currently has a userspace progam attached to it?  What
> kind of device is it?
> 
> Hm, this might solve the problem, can you try the patch below?  It's on
> top of my previous patch.
>
(removed some recipients from the CC list..)
 
No, I am still getting the oops.. hmm.. it seems a little bit different,
but still in the hiddev. I investigated further and the oops only happens
if I yank a HID device connected to an USB hub or if I yank entire hub with
a HID device connected to it. Tried with APC UPS and MS Intellimouse
Explorer. If they are connected directly to the laptop's ports everything is
fine, also other devices (USB printer for example) handle hub disconnection
just fine. It does not matter if I have device open or closed for oops to
happen. And, for the record, oops itself:

Apr 25 16:18:40 core kernel: usb 1-1: USB disconnect, address 3
Apr 25 16:18:40 core kernel: Unable to handle kernel paging request at virtual address e19a9120
Apr 25 16:18:40 core kernel:  printing eip:
Apr 25 16:18:40 core kernel: e19a4031
Apr 25 16:18:40 core kernel: *pde = 1fe1d067
Apr 25 16:18:40 core kernel: *pte = 00000000
Apr 25 16:18:40 core kernel: Oops: 0002 [#1]
Apr 25 16:18:40 core kernel: PREEMPT
Apr 25 16:18:40 core kernel: CPU:    0
Apr 25 16:18:40 core kernel: EIP:    0060:[<e19a4031>]    Not tainted
Apr 25 16:18:40 core kernel: EFLAGS: 00010246   (2.6.6-rc2)
Apr 25 16:18:40 core kernel: EIP is at hiddev_cleanup+0x11/0x40 [usbhid]
Apr 25 16:18:40 core kernel: eax: 00000060   ebx: dd0c4760   ecx: 00000000   edx: de2b7b48
Apr 25 16:18:40 core kernel: esi: e19a8b80   edi: c1565400   ebp: de025e78   esp: de025e6c
Apr 25 16:18:41 core kernel: ds: 007b   es: 007b   ss: 0068
Apr 25 16:18:41 core kernel: Process khubd (pid: 400, threadinfo=de024000 task=ddbd0d30)
Apr 25 16:18:41 core kernel: Stack: de025e78 e185e5ef ddd30000 de025e8c e19a3ac8 dd0c4760 e19a8b80 dfc1d4c0
Apr 25 16:18:41 core kernel:        de025ea8 e1859106 dfc1d4c0 dfc1d4c0 dcfe33e0 dfc1d4d0 e19a8ba0 de025ec0
Apr 25 16:18:41 core kernel:        c0210bc6 dfc1d4d0 dfc1d4f8 dfc1d4d0 c15654cc de025ed8 c0210d03 dfc1d4d0
Apr 25 16:18:41 core kernel: Call Trace:
Apr 25 16:18:41 core kernel:  [<e185e5ef>] usb_unlink_urb+0x3f/0x50 [usbcore]
Apr 25 16:18:41 core kernel:  [<e19a3ac8>] hid_disconnect+0xb8/0xe0 [usbhid]
Apr 25 16:18:41 core kernel:  [<e1859106>] usb_unbind_interface+0x76/0x80 [usbcore]
Apr 25 16:18:41 core kernel:  [<c0210bc6>] device_release_driver+0x66/0x70
Apr 25 16:18:41 core kernel:  [<c0210d03>] bus_remove_device+0x53/0xa0
Apr 25 16:18:41 core kernel:  [<c020fbdd>] device_del+0x5d/0xa0
Apr 25 16:18:41 core kernel:  [<c020fc34>] device_unregister+0x14/0x30
Apr 25 16:18:41 core kernel:  [<e185f480>] usb_disable_device+0x70/0xb0 [usbcore]
Apr 25 16:18:41 core kernel:  [<e1859d16>] usb_disconnect+0xa6/0x100 [usbcore]
Apr 25 16:18:41 core kernel:  [<e185bfef>] hub_port_connect_change+0x28f/0x2a0 [usbcore]
Apr 25 16:18:41 core kernel:  [<e185b971>] hub_port_status+0x41/0xb0 [usbcore]
Apr 25 16:18:41 core kernel:  [<e185c343>] hub_events+0x343/0x3b0 [usbcore]
Apr 25 16:18:41 core kernel:  [<e185c3e5>] hub_thread+0x35/0xf0 [usbcore]
Apr 25 16:18:41 core kernel:  [<c0115ef0>] default_wake_function+0x0/0x20
Apr 25 16:18:41 core kernel:  [<e185c3b0>] hub_thread+0x0/0xf0 [usbcore]
Apr 25 16:18:41 core kernel:  [<c01032e5>] kernel_thread_helper+0x5/0x10
Apr 25 16:18:41 core kernel:
Apr 25 16:18:41 core kernel: Code: 89 0c 85 a0 8f 9a e1 c7 44 24 04 7c 8c 9a e1 8b 43 14 8b 80
 
-- 
Dmitry
