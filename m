Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263578AbTKFScM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Nov 2003 13:32:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263715AbTKFScL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Nov 2003 13:32:11 -0500
Received: from [63.170.161.194] ([63.170.161.194]:5343 "EHLO localhost")
	by vger.kernel.org with ESMTP id S263578AbTKFScA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Nov 2003 13:32:00 -0500
Subject: kernel BUG with bluetooth (2.6.0-test9)
From: Steve Dunham <dunham@cse.msu.edu>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1068143544.2132.106.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 06 Nov 2003 10:32:25 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Actually, I'm having two bluetooth issues, first the one with full
backtrace:

I occasionally get a system lockup when initiating a bluetooth
connection from my Palm.  (I'm using ppp over rfcomm, but I think this
is occuring before the ppp stuff starts up.) 

It looks like __module_get() in sk_set_owner() in l2cap_sock_alloc() is
calling BUG_ON(module_refcount(module) == 0).

The kernel is 2.6.0-test9 with a uhci usb controller. Preempt is on, SCO
is turned on, but I'm not sure if the module was loaded.  

I'm also seeing the following in syslog/dmesg when the module loads: 

  hci_usb: Unknown symbol hci_unregister_dev
  hci_usb: Unknown symbol hci_register_dev
  hci_usb: Unknown symbol hci_unregister_dev
  hci_usb: Unknown symbol hci_register_dev
  hci_usb: probe of 1-1:1.1 failed with error -5
  hci_usb: probe of 1-1:1.2 failed with error -5
  drivers/usb/core/usb.c: registered new driver hci_usb
  hci_usb_isoc_rx_submit: hci0 isoc rx submit failed urb caa1dc14 err
-22

I looked into the probe failed thing - it appears to be some additional
stuff on the USB device.  :1.0 contains whatever the hci_usb is using.

Dunno what's up with the unknown symbol stuff, the module is loaded, and
bluetooth.ko appears to be exporting those symbols. 

The kernel dump follows:

kernel BUG at include/linux/module.h:296!
invalid operand: 0000 [#1]
CPU:    0
EIP:    0060:[<cc8a9807>]    Not tainted
EFLAGS: 00010246
EIP is at l2cap_sock_alloc+0xc7/0xe0 [l2cap]
eax: 00000000   ebx: ca2e07e0   ecx: 00000000   edx: ca2e07e0
esi: 00000000   edi: c7f00780   ebp: 00000000   esp: c0443cd0
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 0, threadinfo=c0442000 task=c03c5f40)
Stack: cc8af900 00000000 00000024 00000020 c0442000 ca293254 cc8abcff
00000000
       00000000 00000020 c0443da4 c0442000 cc8d7091 c0443d20 00000296
c0443d20
       c0443dd4 c7f006c0 00000000 00000089 ca2e0ce0 00000001 00000040
00000000
Call Trace:
 [<cc8abcff>] l2cap_recv_frame+0x52f/0xe50 [l2cap]
 [<cc8d7091>] ip_conntrack_tuple_taken+0x41/0x60 [ip_conntrack]
 [<c0348fa5>] fib_validate_source+0x245/0x260
 [<c02642a8>] get_device+0x18/0x20
 [<cc874e29>] uhci_submit_common+0x229/0x2f0 [uhci_hcd]
 [<c02b55b8>] hcd_submit_urb+0x108/0x170
 [<c02b5ff1>] usb_submit_urb+0x1d1/0x250
 [<cc85d282>] hci_usb_rx_complete+0x1a2/0x6e0 [hci_usb]
 [<cc8acb9f>] l2cap_recv_acldata+0x16f/0x310 [l2cap]
 [<cc88f3f2>] hci_rx_task+0x1b2/0x350 [bluetooth]
 [<c011e536>] tasklet_action+0x46/0x70
 [<c011e345>] do_softirq+0x95/0xa0
 [<c010b0fb>] do_IRQ+0xfb/0x130
 [<c0105000>] _stext+0x0/0x60
 [<c01094f8>] common_interrupt+0x18/0x20
 [<c0105000>] _stext+0x0/0x60
 [<c011007b>] restore_i387_fxsave+0x3b/0x90
 [<c0106fb3>] default_idle+0x23/0x40
 [<c0107044>] cpu_idle+0x34/0x40
 [<c044470d>] start_kernel+0x14d/0x160
 [<c0444470>] unknown_bootoption+0x0/0x120
                                                                                
Code: 0f 0b 28 01 27 d0 8a cc eb 93 0f 0b cb 01 3e d0 8a cc e9 66
 <0>Kernel panic: Fatal exception in interrupt
In interrupt handler - not syncing


Second Problem (-test8 crash on remove)
==============
The second problem I'm having is with a crash on removal of the
bluetooth device.  I haven't yet reproduced it on the above machine
(with serial console and -test9), but it happens with two of my desktops
running -test8.   I managed to copy the stacktrace off of the screen
once on my work desktop (-test8, no preempt, SCO turned on):

On removal, it locks up at:

  EIP: uhci_remove_pending_qhs+0x4e
    uhci_irq+0x90
    do_setitimer+0x1b1
    usb_hcd_irq+0x36
   ...

The instruction is:  mov    %edi,0x34(%ecx)   --  %ecx is 0x80000300
right after a pushf/pop/cli.

It appears to be happening in list_add_tail() in the uhci_add_complete()
call in uhci_remove_pending_qhs(). 

I'll try to reproduce it with a serial console in the next week or so.


Please CC me on any responses.
Thanks,
Steve Dunham
dunham@cse.msu.edu
http://www.cse.msu.edu/~dunham


