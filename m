Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261872AbUBHC3s (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Feb 2004 21:29:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261877AbUBHC3s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Feb 2004 21:29:48 -0500
Received: from mailgw.cvut.cz ([147.32.3.235]:39078 "EHLO mailgw.cvut.cz")
	by vger.kernel.org with ESMTP id S261872AbUBHC3p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Feb 2004 21:29:45 -0500
Date: Sun, 8 Feb 2004 03:29:21 +0100
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: linux-kernel@vger.kernel.org
Subject: Oopses on usbnet unload in 2.6.3-rc1
Message-ID: <20040208022921.GA1337@buk.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
  recent thread about buggy sysfs fbdev support reminded me that situation
with modules unloading is not quite correct... Besides floppy & nbd unload
crashes (I already reported floppy/sysfs problem during Christmas), there 
is a doublefree in usbnet's unload. I have no idea what's correct fix, but
given fbdev's problems probably just removing kfree(dev->net).

  For now I build my kernel without any modules, papering over all simillar
bugs...

Feb  8 02:00:45 ppc kernel: Linux version 2.6.3-rc1-c1560 (root@ppc) (gcc version 3.3.3 20040125 (prerelease) (Debian)) #2 Sun Feb 8 01:03:09 CET 2004

Feb  8 02:00:46 ppc kernel: usb0: register usbnet at usb-0000:00:04.2-2, Prolific PL-2301/PL-2302
Feb  8 02:00:46 ppc kernel: drivers/usb/core/usb.c: registered new driver usbnet

Feb  8 02:09:04 ppc kernel: drivers/usb/core/usb.c: deregistering driver usbnet
Feb  8 02:09:04 ppc kernel: usb0: unregister usbnet usb-0000:00:04.2-2, Prolific PL-2301/PL-2302
Feb  8 02:09:05 ppc kernel: slab error in cache_free_debugcheck(): cache `size-1024': double free, or memory outside object was overwritten
Feb  8 02:09:05 ppc kernel: Call Trace:
Feb  8 02:09:05 ppc kernel:  [<c0154e1b>] kfree+0x2db/0x3f0
Feb  8 02:09:05 ppc kernel:  [<e198cf23>] usbnet_disconnect+0x93/0xd0 [usbnet]
Feb  8 02:09:05 ppc kernel:  [<e198cf23>] usbnet_disconnect+0x93/0xd0 [usbnet]
Feb  8 02:09:05 ppc kernel:  [<c02d101b>] usb_unbind_interface+0x7b/0x80
Feb  8 02:09:05 ppc kernel:  [<c0279e94>] device_release_driver+0x64/0x70
Feb  8 02:09:05 ppc kernel:  [<c0279ec0>] driver_detach+0x20/0x30
Feb  8 02:09:05 ppc kernel:  [<c027a171>] bus_remove_driver+0x61/0xa0
Feb  8 02:09:05 ppc kernel:  [<c027a5da>] driver_unregister+0x1a/0x46
Feb  8 02:09:05 ppc kernel:  [<c02d1101>] usb_deregister+0x31/0x40
Feb  8 02:09:05 ppc kernel:  [<e198d44f>] usbnet_exit+0xf/0x13 [usbnet]
Feb  8 02:09:05 ppc kernel:  [<c01445cd>] sys_delete_module+0x14d/0x1d0
Feb  8 02:09:05 ppc kernel:  [<c0109abb>] syscall_call+0x7/0xb
Feb  8 02:09:05 ppc kernel:
Feb  8 02:09:05 ppc kernel: de162008: redzone 1: 0x0, redzone 2: 0x0.
Feb  8 02:09:05 ppc kernel: ------------[ cut here ]------------
Feb  8 02:09:05 ppc kernel: kernel BUG at mm/slab.c:1696!
Feb  8 02:09:05 ppc kernel: invalid operand: 0000 [#1]
Feb  8 02:09:05 ppc kernel: CPU:    0
Feb  8 02:09:05 ppc kernel: EIP:    0060:[<c0154dbb>]    Not tainted
Feb  8 02:09:05 ppc kernel: EFLAGS: 00010002
Feb  8 02:09:05 ppc kernel: EIP is at kfree+0x27b/0x3f0
Feb  8 02:09:05 ppc kernel: eax: de162000   ebx: 80010c00   ecx: 00001000   edx: 00000008
Feb  8 02:09:05 ppc kernel: esi: c151a800   edi: de162000   ebp: de162008   esp: dd209e84
Feb  8 02:09:05 ppc kernel: ds: 007b   es: 007b   ss: 0068
Feb  8 02:09:05 ppc kernel: Process rmmod (pid: 1659, threadinfo=dd208000 task=d8f22960)
Feb  8 02:09:05 ppc kernel: Stack: c151a800 de162008 00000000 00000000 1e162008 e198cf23 c151e3c0 00000286
Feb  8 02:09:05 ppc kernel:        ddf40df8 df4d6ef8 df52ebf8 00000000 e198cf23 de162c00 de162c00 c1743ca8
Feb  8 02:09:05 ppc kernel:        df52ebfc e198d85d df4d6ef8 e198e780 e198e7a0 c02d101b df4d6ef8 df4d6ef8
Feb  8 02:09:05 ppc kernel: Call Trace:
Feb  8 02:09:05 ppc kernel:  [<e198cf23>] usbnet_disconnect+0x93/0xd0 [usbnet]
Feb  8 02:09:05 ppc kernel:  [<e198cf23>] usbnet_disconnect+0x93/0xd0 [usbnet]
Feb  8 02:09:05 ppc kernel:  [<c02d101b>] usb_unbind_interface+0x7b/0x80
Feb  8 02:09:05 ppc kernel:  [<c0279e94>] device_release_driver+0x64/0x70
Feb  8 02:09:05 ppc kernel:  [<c0279ec0>] driver_detach+0x20/0x30
Feb  8 02:09:05 ppc kernel:  [<c027a171>] bus_remove_driver+0x61/0xa0
Feb  8 02:09:05 ppc kernel:  [<c027a5da>] driver_unregister+0x1a/0x46
Feb  8 02:09:05 ppc kernel:  [<c02d1101>] usb_deregister+0x31/0x40
Feb  8 02:09:05 ppc kernel:  [<e198d44f>] usbnet_exit+0xf/0x13 [usbnet]
Feb  8 02:09:05 ppc kernel:  [<c01445cd>] sys_delete_module+0x14d/0x1d0
Feb  8 02:09:05 ppc kernel:  [<c0109abb>] syscall_call+0x7/0xb
Feb  8 02:09:05 ppc kernel:
Feb  8 02:09:05 ppc kernel: Code: 0f 0b a0 06 da ef 39 c0 e9 e7 fe ff ff 0f 0b 9f 06 da ef 39

						Petr Vandrovec


