Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262438AbUKDU5C@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262438AbUKDU5C (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 15:57:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262427AbUKDUyY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 15:54:24 -0500
Received: from mail.kroah.org ([69.55.234.183]:19623 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262411AbUKDUxD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 15:53:03 -0500
Date: Thu, 4 Nov 2004 12:52:38 -0800
From: Greg KH <greg@kroah.com>
To: maneesh@in.ibm.com
Cc: linux-kernel@vger.kernel.org
Subject: kernel BUG at fs/sysfs/dir.c:20!
Message-ID: <20041104205238.GA11885@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I get the following BUG in the sysfs code when I do:
	- plug in a usb-serial device.
	- open the port with 'cat /dev/ttyUSB0'
	- unplug the device.
	- stop the 'cat' process with control-C

This used to work just fine before your big sysfs changes.

Anything I should look at testing?

thanks,

greg k-h

kernel BUG at fs/sysfs/dir.c:20!
invalid operand: 0000 [#1]
PREEMPT SMP DEBUG_PAGEALLOC
Modules linked in: pl2303 usbserial evdev usbhid uhci_hcd ehci_hcd usbcore
CPU:    0
EIP:    0060:[<c018e710>]    Not tainted VLI
EFLAGS: 00010a87   (2.6.10-rc1-bk14) 
EIP is at sysfs_d_iput+0x7c/0x86
eax: d5d50f68   ebx: d5d50f68   ecx: c018e694   edx: c0489c00
esi: d739eae8   edi: d6e76ea8   ebp: d714af5c   esp: d6ee9ce4
ds: 007b   es: 007b   ss: 0068
Process serial_loopback (pid: 9270, threadinfo=d6ee8000 task=d69b9af0)
Stack: d5d50f68 d5d50f68 d6e76ea8 d5d50f70 c0172c74 d5d50f68 d6e76ea8 dca96eb4 
       c0407b48 db23bf0c c01f7d17 d5d50f68 00000002 dca96e90 c025a952 dca96eb4 
       00000042 dca96e90 db23bf0c d739eec4 c025a9c5 dca96e90 dca96ee8 00000000 
Call Trace:
 [<c0172c74>] dput+0x14d/0x1ed
 [<c01f7d17>] kobject_del+0x20/0x2d
 [<c025a952>] device_del+0x8a/0xda
 [<c025a9c5>] device_unregister+0x23/0x30
 [<e0a1e201>] destroy_serial+0x82/0x186 [usbserial]
 [<e0a1e49d>] serial_close+0x0/0x11c [usbserial]
 [<c023f509>] release_dev+0x6c8/0x801
 [<e0a1e17f>] destroy_serial+0x0/0x186 [usbserial]
 [<c0117018>] change_page_attr+0x5b/0x71
 [<c015c35a>] filp_dtor+0x0/0x1d
 [<c0117136>] kernel_map_pages+0x2a/0x58
 [<c014547c>] cache_free_debugcheck+0x2b1/0x2b6
 [<c0143617>] dbg_redzone1+0x15/0x2b
 [<c0143c56>] poison_obj+0x2e/0x59
 [<c01452fb>] cache_free_debugcheck+0x130/0x2b6
 [<c014d7a1>] remove_vm_struct+0x8b/0xa7
 [<c023fb18>] tty_release+0x14/0x1f
 [<c015c5a3>] __fput+0x13e/0x177
 [<c015ac54>] filp_close+0x52/0x96
 [<c011f0fb>] put_files_struct+0x83/0xfc
 [<c011ff85>] do_exit+0x176/0x4a6
 [<c012036f>] do_group_exit+0x40/0xa8
 [<c01296c1>] get_signal_to_deliver+0x226/0x350
 [<c0103fbe>] do_signal+0x98/0x15e
 [<c0119442>] __wake_up+0x40/0x56
 [<c023e1db>] tty_read+0xc5/0x12f
 [<c0185dc1>] dnotify_parent+0x3a/0xa5
 [<c015b4bd>] vfs_read+0xa8/0x12f
 [<c015b7d3>] sys_read+0x51/0x80
 [<c01040bb>] do_notify_resume+0x37/0x3c
 [<c010423a>] work_notifysig+0x13/0x15
Code: 0c 83 c4 10 e9 36 73 fe ff 8b 5e 14 8b 03 89 04 24 e8 07 79 fb ff 8b 43 04 89 04 24 e8 43 97 06 00 89 1c 24 e8 f4 78 fb ff eb be <0f> 0b 14 00 72 99 37 c0 eb 9d 83 ec 1c a1 b0 27 3c c0 89 5c 24 

