Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266096AbUFWQS6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266096AbUFWQS6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 12:18:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265786AbUFWQS6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 12:18:58 -0400
Received: from mail.kroah.org ([65.200.24.183]:8401 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266576AbUFWQMF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 12:12:05 -0400
Date: Wed, 23 Jun 2004 09:10:44 -0700
From: Greg KH <greg@kroah.com>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Oops w/ USB serial + modular ipaq
Message-ID: <20040623161044.GA25681@kroah.com>
References: <Pine.LNX.4.58.0406230222090.3273@montezuma.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0406230222090.3273@montezuma.fsmlabs.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 23, 2004 at 02:33:25AM -0400, Zwane Mwaikambo wrote:
> Loading the ipaq module, connecting a device and then unloading ipaq.ko
> oopses.
> 
> PocketPC PDA ttyUSB0: PocketPC PDA converter now disconnected from ttyUSB0
> usbserial 1-2:1.0: device disconnected
> Unable to handle kernel NULL pointer dereference at virtual address 00000085
>  printing eip:
> f8990a6f
> *pde = 00000000
> Oops: 0000 [#1]
> SMP
> Modules linked in: ppp_async ppp_generic slhc ipaq usbserial vmnet vmmon
> dm_mod e100 e1000 3c59x
> CPU:    0
> EIP:    0060:[<f8990a6f>]    Tainted: P   VLI
> EFLAGS: 00210246   (2.6.7-rc3-mm2-slock)
> EIP is at usb_serial_disconnect+0x1b/0x86 [usbserial]
> eax: 00000000   ebx: 00000011   ecx: 00000002   edx: 00000000
> esi: 00000000   edi: 00000001   ebp: d9d0c000   esp: d9d0cf38
> ds: 007b   es: 007b   ss: 0068
> Process rmmod (pid: 19148, threadinfo=d9d0c000 task=e62ced10)
> Stack: f8993f40 c02ef8f6 c1d61b48 c1ec46d8 00000000 f8998220 f8990e04 f89924c0
>        f8991e8c f8996cc8 f8998480 c04631a4 00000000 c0128b94 00000000 71617069
>        00000000 d5d33a80 d5d33a80 c013cac9 40001000 40000000 c013ce17 40000000
> Call Trace:
>  [<c02ef8f6>] device_release_driver+0x56/0x58
>  [<f8990e04>] usb_serial_deregister+0x9b/0x9f [usbserial]
>  [<c0128b94>] sys_delete_module+0x132/0x180
>  [<c013cac9>] unmap_vma_list+0xe/0x17
>  [<c013ce17>] do_munmap+0x10a/0x144
>  [<c0110df4>] do_page_fault+0x0/0x501
>  [<c0103a71>] sysenter_past_esp+0x52/0x71
> 
> Code: 04 24 b3 1d 99 f8 e8 89 65 78 c7 e9 8a f5 ff ff 83 ec 18 89 5c 24 0c
> 89 7c 24 14 89 74 24 10 8d 58 10 89 c7 a1 04 46 99 f8 85 c0 <8b> 73 74 75
> 48 85 f6 c7 43 74 00 00 00 00 74 08 8d 46 38 e8 47
> 
> (gdb) list * usb_serial_disconnect+0x1b
> 0x1a6f is in usb_serial_disconnect (device.h:298).
> 293     }
> 294
> 295     static inline void *
> 296     dev_get_drvdata (struct device *dev)
> 297     {
> 298             return dev->driver_data;
> 299     }
> 
> 
> The problem is due to the following;
> 
> void usb_serial_deregister(struct usb_serial_device_type *device)
> {
> 	struct usb_serial *serial;
> 	int i;
> 
> 	for(i = 0; i < SERIAL_TTY_MINORS; ++i) {
> 		serial = serial_table[i];
> 		if ((serial != NULL) && (serial->type == device)) {
> 			printk("usb_serial_deregister: %p %p\n", serial, serial->interface);
> 			usb_driver_release_interface (&usb_serial_driver, serial->interface);
> 			usb_serial_disconnect (serial->interface); <===
> 		}
> 	}
> ...
> }
> 
> It's not safe to use serial->interface after that
> usb_driver_release_interface().

Why not?  The ->interface pointer is still valid, only thing is that
device does not have a driver bound to it anymore, so the later call to
dev_info() in the usb_serial_disconnect() call might cause the oops.

How about just switching those two calls around (usb_serial_disconnect()
before calling usb_driver_release_interface())?  Will that solve the
problem for you?  If you just comment out usb_serial_disconnect() you
will leak memory :(

thanks,

greg k-h
