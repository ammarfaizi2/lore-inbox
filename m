Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266576AbUFWQ7r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266576AbUFWQ7r (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 12:59:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266577AbUFWQ7r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 12:59:47 -0400
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:15491 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S266576AbUFWQ7n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 12:59:43 -0400
Date: Wed, 23 Jun 2004 13:01:54 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Greg KH <greg@kroah.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Oops w/ USB serial + modular ipaq
In-Reply-To: <20040623161044.GA25681@kroah.com>
Message-ID: <Pine.LNX.4.58.0406231216270.3273@montezuma.fsmlabs.com>
References: <Pine.LNX.4.58.0406230222090.3273@montezuma.fsmlabs.com>
 <20040623161044.GA25681@kroah.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Jun 2004, Greg KH wrote:

> > It's not safe to use serial->interface after that
> > usb_driver_release_interface().
>
> Why not?  The ->interface pointer is still valid, only thing is that
> device does not have a driver bound to it anymore, so the later call to
> dev_info() in the usb_serial_disconnect() call might cause the oops.

void usb_driver_release_interface(struct usb_driver *driver,
					struct usb_interface *iface)
{
	struct device *dev = &iface->dev;

...
	dev->driver = NULL;
	usb_set_intfdata(iface, NULL);
}

usb_set_intfdata() sets usb_interface->dev.driver_data to NULL, whilst in
usbserial_disconnect() we try and retrieve and use it;

void usb_serial_disconnect(struct usb_interface *interface)
{
	struct usb_serial *serial = usb_get_intfdata (interface);
	struct device *dev = &interface->dev;
...
}

> How about just switching those two calls around (usb_serial_disconnect()
> before calling usb_driver_release_interface())?  Will that solve the
> problem for you?

I tried it last night, switching around will cause an oops in
usb_driver_release_interface()

Unable to handle kernel paging request at virtual address 6b6b6beb
 printing eip:
c042da9a
*pde = 00000000
Oops: 0000 [#1]
PREEMPT SMP DEBUG_PAGEALLOC
Modules linked in: ipaq usbserial
CPU:    1
EIP:    0060:[<c042da9a>]    Not tainted
EFLAGS: 00010246   (2.6.7)
EIP is at usb_driver_release_interface+0xa/0x50
eax: 6b6b6b6b   ebx: 6b6b6b7b   ecx: 6b6b6b6b   edx: de0a5000
esi: 00000000   edi: e0ddda60   ebp: de0a5f34   esp: de0a5f30
ds: 007b   es: 007b   ss: 0068
Process rmmod (pid: 1414, threadinfo=de0a5000 task=d5c85a60)
Stack: dee0bec0 de0a5f54 e0e1b11c e0e1f1c0 6b6b6b6b d72baef8 e0dddcc0 c05dd3a8
       00000000 de0a5f64 e0ddbea7 e0ddda60 e0ddd9c0 de0a5fbc c0139c9e 00000000
       71617069 40000000 de0a5fa0 c0156f3d d647cdc8 de801a30 d647cdfc 40001000
Call Trace:
 [<c0107675>] show_stack+0x75/0x90
 [<c01077d5>] show_registers+0x125/0x180
 [<c010796b>] die+0xab/0x170
 [<c01185d8>] do_page_fault+0x1e8/0x535
 [<c01072cd>] error_code+0x2d/0x40
 [<e0e1b11c>] usb_serial_deregister+0x7c/0x90 [usbserial]
 [<e0ddbea7>] ipaq_exit+0x17/0x1b [ipaq]
 [<c0139c9e>] sys_delete_module+0x12e/0x190
 [<c0106139>] sysenter_past_esp+0x52/0x79

(gdb) list *usb_driver_release_interface+0xa
0x31a is in usb_driver_release_interface (drivers/usb/core/usb.c:347).
342                                             struct usb_interface *iface)
343     {
344             struct device *dev = &iface->dev;
345
346             /* this should never happen, don't release something that's not ours */
347             if (!dev->driver || dev->driver != &driver->driver)
348                     return;
349
350             /* don't disconnect from disconnect(), or before dev_add() */
351             if (!list_empty (&dev->driver_list) && !list_empty (&dev->bus_list))

0x00000310 <usb_driver_release_interface+0>:    push   %ebp
0x00000311 <usb_driver_release_interface+1>:    mov    %esp,%ebp
0x00000313 <usb_driver_release_interface+3>:    push   %ebx
0x00000314 <usb_driver_release_interface+4>:    mov    0xc(%ebp),%ecx
0x00000317 <usb_driver_release_interface+7>:    lea    0x10(%ecx),%ebx
0x0000031a <usb_driver_release_interface+10>:   mov    0x70(%ebx),%edx
0x0000031d <usb_driver_release_interface+13>:   test   %edx,%edx

hmm, iface = %ebp, dev = %ecx = 0x6b6b6b6b, how did that get
freed/poisoned since it's encapsulated by iface?

Ta,
	Zwane
