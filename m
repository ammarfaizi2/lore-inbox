Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261421AbTJAK0R (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 06:26:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261476AbTJAK0Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 06:26:16 -0400
Received: from main.gmane.org ([80.91.224.249]:65187 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261421AbTJAK0N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 06:26:13 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Andreas Schwarz <usenet.2117@andreas-s.net>
Subject: More UHCI bugs in 2.6.0-test1
Date: Wed, 1 Oct 2003 10:26:11 +0000 (UTC)
Message-ID: <slrnbnlaug.3q0.usenet.2117@home.andreas-s.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-TCPA-ist-scheisse: yes
User-Agent: slrn/0.9.8.0 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A few days ago I reported a rmmod uhci-hcd problem in
<slrnbniinj.41m.usenet.2117@home.andreas-s.net>. Today I tried to reload
the uhci-hcd module (because my USB mouse cursor was stuck again (might
be a related problem)) and ran into the following problem:

# rmmod uhci-hcd
# modprobe uhci-hcd
Speicherzugriffsfehler [memory access error]
# rmmod uhci-hcd
device is in use [or something like that]
# rmmod uhci-hcd -f
[rmmod hangs, I have to reset]

log:
============================================================================

Oct  1 12:06:41 d700 kernel: uhci-hcd 0000:00:13.0: remove, state 1
Oct  1 12:06:41 d700 kernel: uhci-hcd 0000:00:13.0: roothub graceful disconnect
Oct  1 12:06:41 d700 kernel: usb usb4: USB disconnect, address 1
Oct  1 12:06:41 d700 kernel: usb 4-1: USB disconnect, address 5
Oct  1 12:06:41 d700 kernel: usb 4-1: usb_disable_device nuking all URBs
Oct  1 12:06:41 d700 kernel: uhci-hcd 0000:00:13.0: shutdown urb ce9d8d40 pipe 40408580 ep1in-intr
Oct  1 12:06:41 d700 kernel: usb 4-1: unregistering interface 4-1:1.0
Oct  1 12:06:41 d700 kernel: usb 4-1: hcd_unlink_urb ce9d8d40 fail -16
Oct  1 12:06:41 d700 kernel: usb 4-1: hcd_unlink_urb ce9d8b40 fail -22
Oct  1 12:06:41 d700 kernel: usb 4-1: hcd_unlink_urb ce9d8d40 fail -16
Oct  1 12:06:41 d700 kernel: usb 4-1: unregistering device
Oct  1 12:06:41 d700 kernel: usb usb4: usb_disable_device nuking all URBs
Oct  1 12:06:41 d700 kernel: uhci-hcd 0000:00:13.0: shutdown urb cea332c0 pipe 40408180 ep1in-intr
Oct  1 12:06:41 d700 kernel: usb usb4: unregistering interface 4-0:1.0
Oct  1 12:06:41 d700 kernel: usb usb4: hcd_unlink_urb cea332c0 fail -22
Oct  1 12:06:41 d700 kernel: usb usb4: unregistering device
Oct  1 12:06:41 d700 kernel: pci_pool_destroy 0000:00:13.0/uhci_td, ce9ec000 busy
Oct  1 12:06:41 d700 kernel: uhci-hcd 0000:00:13.0: USB bus 4 deregistered
Oct  1 12:06:41 d700 kernel: uhci-hcd 0000:00:13.1: remove, state 1
Oct  1 12:06:41 d700 kernel: uhci-hcd 0000:00:13.1: roothub graceful disconnect
Oct  1 12:06:41 d700 kernel: usb usb5: USB disconnect, address 1
Oct  1 12:06:41 d700 kernel: usb usb5: usb_disable_device nuking all URBs
Oct  1 12:06:41 d700 kernel: uhci-hcd 0000:00:13.1: shutdown urb ce9d8dc0 pipe 40408180 ep1in-intr
Oct  1 12:06:41 d700 kernel: usb usb5: unregistering interface 5-0:1.0
Oct  1 12:06:41 d700 kernel: usb usb5: hcd_unlink_urb ce9d8dc0 fail -22
Oct  1 12:06:41 d700 kernel: usb usb5: unregistering device
Oct  1 12:06:41 d700 kernel: uhci-hcd 0000:00:13.1: USB bus 5 deregistered
Oct  1 12:06:41 d700 kernel: slab error in kmem_cache_destroy(): cache `uhci_urb_priv': Can't free all objects
Oct  1 12:06:41 d700 kernel: Call Trace:
Oct  1 12:06:41 d700 kernel:  [<c013a4d5>] kmem_cache_destroy+0x85/0x100
Oct  1 12:06:41 d700 kernel:  [<d1a9dfac>] uhci_hcd_cleanup+0x1c/0x5e [uhci_hcd]
Oct  1 12:06:41 d700 kernel:  [<c012f402>] sys_delete_module+0x152/0x1c0
Oct  1 12:06:41 d700 kernel:  [<c0143800>] do_munmap+0xd0/0x190
Oct  1 12:06:41 d700 kernel:  [<c010930b>] syscall_call+0x7/0xb
Oct  1 12:06:41 d700 kernel: 
Oct  1 12:06:41 d700 kernel: uhci: not all urb_priv's were freed
Oct  1 12:06:41 d700 kernel: ehci_hcd 0000:00:13.2: GetStatus port 1 status 001403 POWER sig=k  CSC CONNECT
Oct  1 12:06:41 d700 kernel: hub 1-0:1.0: port 1, status 501, change 1, 480 Mb/s
Oct  1 12:06:41 d700 kernel: hub 1-0:1.0: debounce: port 1: delay 100ms stable 4 status 0x501
Oct  1 12:06:41 d700 kernel: ehci_hcd 0000:00:13.2: port 1 low speed --> companion
Oct  1 12:06:41 d700 kernel: ehci_hcd 0000:00:13.2: GetStatus port 1 status 003402 POWER OWNER sig=k  CSC
Oct  1 12:06:43 d700 kernel: drivers/usb/host/uhci-hcd.c: USB Universal Host Controller Interface driver v2.1
Oct  1 12:06:43 d700 kernel: kmem_cache_create: duplicate cache uhci_urb_priv
Oct  1 12:06:43 d700 kernel: ------------[ cut here ]------------
Oct  1 12:06:43 d700 kernel: kernel BUG at mm/slab.c:1266!
Oct  1 12:06:43 d700 kernel: invalid operand: 0000 [#1]
Oct  1 12:06:43 d700 kernel: CPU:    0
Oct  1 12:06:43 d700 kernel: EIP:    0060:[<c013a151>]    Not tainted
Oct  1 12:06:43 d700 kernel: EFLAGS: 00010202
Oct  1 12:06:43 d700 kernel: EIP is at kmem_cache_create+0x3d1/0x4c0
Oct  1 12:06:43 d700 kernel: eax: 00000031   ebx: cf0f4d70   ecx: c03cb5c8   edx: c032c8b8
Oct  1 12:06:43 d700 kernel: esi: d1a9e606   edi: d1a9e606   ebp: cf0f4ec4   esp: ce8dff48
Oct  1 12:06:43 d700 kernel: ds: 007b   es: 007b   ss: 0068
Oct  1 12:06:43 d700 kernel: Process modprobe (pid: 4018, threadinfo=ce8de000 task=c1fb60c0)
Oct  1 12:06:43 d700 kernel: Stack: c02f7220 d1a9e5f8 00000000 ce8dff6c cf0f4dac cf0f4e50 02a336c0 c0000000
Oct  1 12:06:43 d700 kernel:        fffffffc 00000038 fffffff4 d1aa0700 c032ee38 ce8de000 d1ab10c5 d1a9e5f8 
Oct  1 12:06:43 d700 kernel:        0000003c 00000040 00000000 00000000 00000000 c032ee50 c0130e8c c03cb524 
Oct  1 12:06:43 d700 kernel: Call Trace:
Oct  1 12:06:43 d700 kernel:  [<d1ab10c5>] uhci_hcd_init+0xc5/0x13c [uhci_hcd]
Oct  1 12:06:43 d700 kernel:  [<c0130e8c>] sys_init_module+0x12c/0x250
Oct  1 12:06:43 d700 kernel:  [<c010930b>] syscall_call+0x7/0xb
Oct  1 12:06:43 d700 kernel: 
Oct  1 12:06:43 d700 kernel: Code: 0f 0b f2 04 09 6a 2f c0 0f b6 05 01 ba 32 c0 8b 6d 00 89 6c
Oct  1 12:06:59 d700 kernel:  <1>Unable to handle kernel NULL pointer dereference at virtual address 00000000
Oct  1 12:06:59 d700 kernel:  printing eip:
Oct  1 12:06:59 d700 kernel: c0107fd9
Oct  1 12:06:59 d700 kernel: *pde = 00000000
Oct  1 12:06:59 d700 kernel: Oops: 0002 [#2]
Oct  1 12:06:59 d700 kernel: CPU:    0
Oct  1 12:06:59 d700 kernel: EIP:    0060:[<c0107fd9>]    Tainted: GF 
Oct  1 12:06:59 d700 kernel: EFLAGS: 00010002
Oct  1 12:06:59 d700 kernel: EIP is at __down+0x69/0x110
Oct  1 12:06:59 d700 kernel: eax: c25c0000   ebx: c25c0000   ecx: c25c1f0c   edx: 00000000
Oct  1 12:06:59 d700 kernel: esi: d1aa0690   edi: 00000292   ebp: c25c0000   esp: c25c1ef8
Oct  1 12:06:59 d700 kernel: ds: 007b   es: 007b   ss: 0068
Oct  1 12:06:59 d700 kernel: Process rmmod (pid: 4022, threadinfo=c25c0000 task=c1fb60c0)
Oct  1 12:06:59 d700 kernel: Stack: d1aa0698 c1fb60c0 00000001 c1fb60c0 c01170d0 d1aa0698 00000000 c1b406c0 
Oct  1 12:06:59 d700 kernel:        400f7410 00000000 d1aa0688 00000a80 00000200 00000000 c010823c d1aa0690 
Oct  1 12:06:59 d700 kernel:        c25c1f70 d1aa0688 c02290cd d1aa0688 d1aa0700 c01dce12 d1aa0688 d1a9df9f 
Oct  1 12:06:59 d700 kernel: Call Trace:
Oct  1 12:06:59 d700 kernel:  [<c01170d0>] default_wake_function+0x0/0x30
Oct  1 12:06:59 d700 kernel:  [<c010823c>] __down_failed+0x8/0xc
Oct  1 12:06:59 d700 kernel:  [<c02290cd>] .text.lock.driver+0x5/0x18
Oct  1 12:06:59 d700 kernel:  [<c01dce12>] pci_unregister_driver+0x12/0x20
Oct  1 12:06:59 d700 kernel:  [<d1a9df9f>] uhci_hcd_cleanup+0xf/0x5e [uhci_hcd]
Oct  1 12:06:59 d700 kernel:  [<c012f402>] sys_delete_module+0x152/0x1c0
Oct  1 12:06:59 d700 kernel:  [<c0143800>] do_munmap+0xd0/0x190
Oct  1 12:06:59 d700 kernel:  [<c010930b>] syscall_call+0x7/0xb
Oct  1 12:06:59 d700 kernel: 
Oct  1 12:06:59 d700 kernel: Code: 89 0a ff 46 04 89 f6 8b 46 04 48 01 06 0f 98 c0 84 c0 74 32 
Oct  1 12:06:59 d700 kernel:  <6>note: rmmod[4022] exited with preempt_count 1

-- 
AVR-Tutorial, über 350 Links
Forum für AVRGCC und MSPGCC
-> http://www.mikrocontroller.net

