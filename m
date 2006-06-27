Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030228AbWF0GNY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030228AbWF0GNY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 02:13:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030627AbWF0GNY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 02:13:24 -0400
Received: from smtp.osdl.org ([65.172.181.4]:50911 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030228AbWF0GNX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 02:13:23 -0400
Date: Mon, 26 Jun 2006 23:13:19 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Dmitry Torokhov <dtor_core@ameritech.net>, Greg KH <greg@kroah.com>
cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [git pull] Input update for 2.6.17
In-Reply-To: <200606260235.03718.dtor_core@ameritech.net>
Message-ID: <Pine.LNX.4.64.0606262247040.3927@g5.osdl.org>
References: <200606260235.03718.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="21872808-1177063036-1151387732=:3927"
Content-ID: <Pine.LNX.4.64.0606262256050.3927@g5.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--21872808-1177063036-1151387732=:3927
Content-Type: TEXT/PLAIN; CHARSET=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-ID: <Pine.LNX.4.64.0606262256051.3927@g5.osdl.org>



On Mon, 26 Jun 2006, Dmitry Torokhov wrote:
> 
> Please pull from:
> 
>         git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git

I think this (or USB) may have problems.

I get a spinlock debugging fault with the current kernel on one of my 
machines at bootup, with the trace-back being:

  Process: khubd
	spin_bug
	_raw_spin_lock
	_spin_lock
	__mutex_lock_slowpath
	mutex_lock
	input_unregister_device
	hidinput_disconnect
	hid_disconnect
	usb_unbind_interface
	__device_release
	device_release_driver
	bus_remove_device
	device_del
	usb_disable_device
	usb_disconnect
	hub_thread
	kthread

it happens pretty early after bootup, but I don't know what triggers that 
usb disconnect (it may be the hand-over from UHCI->EHCI. Greg? Does that 
make sense?)

Does this ring a bell?

The fact that it triggers with spinlock debugging, and there's a bad magic 
number. It seems to be the "mutex_lock(&dev->mutex);" thing in 
input_unregister_device that triggers this. It seems to be a device that 
has been free'd already, because that 0x6b6b6b6b pattern in the 
POISON_FREE pattern.

Greg? Dmitry?

To trigger, you probably need both slab debugging _and_ spinlock debugging 
on. And perhaps just the right timings, although I've been able to do it 
three times in a row now, so it doesn't seem to be _that_ timing 
sensitive.

			Linus

---
BUG: spinlock bad magic on CPU#0, khubd/131
BUG: unable to handle kernel paging request at virtual address 6b6b6c0b
 printing eip:
c01dcf77
*pde = 00000000
Oops: 0000 [#1]
SMP 
Modules linked in: bluetooth ip_conntrack_netbios_ns ipt_REJECT iptable_filter ip_tables ip6table_filter ip6_tables cpufreq_ondemand asus_acpi lp intel_agp agpgart pcspkr
CPU:    0
EIP:    0060:[<c01dcf77>]    Not tainted VLI
EFLAGS: 00010002   (2.6.17-g2ac9f277 #17) 
EIP is at spin_bug+0x5c/0xc0
eax: ffffffff   ebx: 6b6b6b6b   ecx: 6b6b6b6b   edx: c03c7674
esi: dd9c18bc   edi: dd9c18bc   ebp: de04de18   esp: de04de10
ds: 007b   es: 007b   ss: 0068
Process khubd (pid: 131, ti=de04d000 task=de04e560 task.ti=de04d000)
Stack: de04d000 dd9c18b8 de04de30 c01dd1e3 00000001 de04d000 dd9c18b8 00000246 
       de04de38 c039ddeb de04de68 c039d3c1 c02c0e9a de04e560 de04de48 de04de48 
       11111111 11111111 de04de48 dd9c18b8 dd9c1998 dd9c1284 de04de74 c039d6e2 
Call Trace:
 <c0103c3b> show_stack_log_lvl+0x8a/0x95  <c0103dc6> show_registers+0x144/0x1b9
 <c0103fb0> die+0x175/0x285  <c011992e> do_page_fault+0x3f1/0x4eb
 <c0103759> error_code+0x39/0x40  <c01dd1e3> _raw_spin_lock+0x1e/0xe3
 <c039ddeb> _spin_lock+0x8/0xa  <c039d3c1> __mutex_lock_slowpath+0xaa/0x3a7
 <c039d6e2> mutex_lock+0x24/0x27  <c02c0e9a> input_unregister_device+0xc3/0x104
 <c02b957d> hidinput_disconnect+0x31/0x4b  <c02b6405> hid_disconnect+0x75/0xc3
 <c02a722b> usb_unbind_interface+0x37/0x6e  <c023fdeb> __device_release_driver+0x63/0x79
 <c024003d> device_release_driver+0x2e/0x3e  <c023f734> bus_remove_device+0x7e/0x8e
 <c023e6c6> device_del+0x115/0x149  <c02a59f7> usb_disable_device+0x71/0xcf
 <c02a25cd> usb_disconnect+0x8b/0xe7  <c02a3161> hub_thread+0x34d/0x992
 <c0132185> kthread+0xa5/0xd2  <c0101005> kernel_thread_helper+0x5/0xb
Code: 00 00 8b 10 81 c2 90 01 00 00 52 ff 70 10 51 68 a0 31 3d c0 e8 fa 49 f4 ff 83 c8 ff 8b 4e 08 ba 74 76 3c c0 83 c4 14 85 db 74 0c <8b> 83 a0 00 00 00 8d 93 90 01 00 00 51 50 52 ff 76 04 56 68 c6 
EIP: [<c01dcf77>] spin_bug+0x5c/0xc0 SS:ESP 0068:de04de10

--21872808-1177063036-1151387732=:3927--
