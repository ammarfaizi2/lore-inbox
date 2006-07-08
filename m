Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964891AbWGHQZJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964891AbWGHQZJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jul 2006 12:25:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964888AbWGHQZJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jul 2006 12:25:09 -0400
Received: from fmmailgate04.web.de ([217.72.192.242]:21425 "EHLO
	fmmailgate04.web.de") by vger.kernel.org with ESMTP id S964891AbWGHQZF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jul 2006 12:25:05 -0400
Reveived: from web.de 
	by fmmailgate04.web.de (Postfix) with SMTP id A1BE953439
	for <linux-kernel@vger.kernel.org>; Sat,  8 Jul 2006 18:25:03 +0200 (CEST)
Date: Sat, 08 Jul 2006 18:25:02 +0200
Message-Id: <791933691@web.de>
MIME-Version: 1.0
From: Arne Ahrend <aahrend@web.de>
To: linux-kernel@vger.kernel.org
Subject: INFO: possible irq lock inversion dependency detected
Organization: http://freemail.web.de/
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


2.6.17-mm6 produces the following warning, but appears to be working perfectly fine.


Cheers,
Arne

=========================================================
[ INFO: possible irq lock inversion dependency detected ]
---------------------------------------------------------
swapper/0 just changed the state of lock:
 (&bfusb->lock){..?+}, at: [<e28e59e2>] bfusb_rx_complete+0x34/0x468 [bfusb]
but this lock took another, hard-irq-unsafe lock in the past:
 (&skb_queue_lock_key){-+..}

and interrupts could create inverse lock ordering between them.


other info that might help us debug this:
no locks held by swapper/0.

the first lock's dependencies:
-> (&bfusb->lock){..?+} ops: 0 {
   initial-use  at:
                        [<c012a05e>] lock_acquire+0x4f/0x6d
                        [<c0265f0f>] _write_lock_irqsave+0x2d/0x3c
                        [<e28e528d>] bfusb_open+0x27/0x5c [bfusb]
                        [<e291f8b5>] hci_dev_open+0x55/0x1e0 [bluetooth]
                        [<e2922ab2>] hci_sock_ioctl+0xd1/0x229 [bluetooth]
                        [<c02118b8>] sock_ioctl+0x193/0x1b9
                        [<c015d868>] do_ioctl+0x24/0x66
                        [<c015daf4>] vfs_ioctl+0x24a/0x25d
                        [<c015db35>] sys_ioctl+0x2e/0x4d
                        [<c010246b>] syscall_call+0x7/0xb
   in-hardirq-R at:
                        [<c012a05e>] lock_acquire+0x4f/0x6d
                        [<c0265d7e>] _read_lock+0x24/0x32
                        [<e28e59e2>] bfusb_rx_complete+0x34/0x468 [bfusb]
                        [<e2884c0d>] usb_hcd_giveback_urb+0x18/0x46 [usbcore]
                        [<e086c74c>] uhci_giveback_urb+0x120/0x14a [uhci_hcd]
                        [<e086cda9>] uhci_scan_schedule+0x536/0x7a8 [uhci_hcd]
                        [<e086e907>] uhci_irq+0x121/0x137 [uhci_hcd]
                        [<e28857a7>] usb_hcd_irq+0x27/0x58 [usbcore]
                        [<c0132452>] handle_IRQ_event+0x18/0x4a
                        [<c0133349>] handle_fasteoi_irq+0x6d/0xae
                        [<c010490c>] do_IRQ+0xa0/0xc4
   in-softirq-R at:
                        [<c012a05e>] lock_acquire+0x4f/0x6d
                        [<c0265d7e>] _read_lock+0x24/0x32
                        [<e28e6096>] bfusb_send_frame+0x280/0x2b6 [bfusb]
                        [<e291ee60>] hci_send_frame+0x55/0x5d [bluetooth]
                        [<e291f14a>] hci_cmd_task+0x94/0xcd [bluetooth]
                        [<c011786f>] tasklet_action+0x45/0x75
                        [<c0117a76>] __do_softirq+0x45/0x9f
                        [<c010480e>] do_softirq+0x4d/0xab
   hardirq-on-R at:
                        [<c012a05e>] lock_acquire+0x4f/0x6d
                        [<c0265d7e>] _read_lock+0x24/0x32
                        [<e28e6096>] bfusb_send_frame+0x280/0x2b6 [bfusb]
                        [<e291ee60>] hci_send_frame+0x55/0x5d [bluetooth]
                        [<e291f14a>] hci_cmd_task+0x94/0xcd [bluetooth]
                        [<c011786f>] tasklet_action+0x45/0x75
                        [<c0117a76>] __do_softirq+0x45/0x9f
                        [<c010480e>] do_softirq+0x4d/0xab
 }
 ... key      at: [<e28e8284>] __key.23218+0x0/0xffffde58 [bfusb]
  -> (modlist_lock){.+..} ops: 0 {
     initial-use  at:
                      [<c012a05e>] lock_acquire+0x4f/0x6d
                      [<c0265db9>] _spin_lock_irqsave+0x2d/0x3c
                      [<c012ed3b>] is_module_address+0x12/0x6e
                      [<c0127b3d>] static_obj+0x25/0x2f
                      [<c012861e>] lockdep_init_map+0x6c/0xab
                      [<c01a60c7>] __spin_lock_init+0x25/0x6e
                      [<e0842c6f>] rtl8139_init_one+0x57e/0x81b [8139too]
                      [<c01aa8b0>] pci_device_probe+0x3a/0x61
                      [<c01f0165>] driver_probe_device+0x46/0x9a
                      [<c01f025b>] __driver_attach+0x3b/0x66
                      [<c01efbee>] bus_for_each_dev+0x46/0x6d
                      [<c01f00b4>] driver_attach+0x16/0x1b
                      [<c01ef876>] bus_add_driver+0x6e/0x113
                      [<c01f04fa>] driver_register+0xa3/0xa8
                      [<c01aaa33>] __pci_register_driver+0x55/0x7a
                      [<e080f01c>] ____versions+0x12fc/0xfffffcb8 [firmware_class]
                      [<c01304c8>] sys_init_module+0x13c5/0x1570
                      [<c010246b>] syscall_call+0x7/0xb
     in-softirq-W at:
                      [<c012a05e>] lock_acquire+0x4f/0x6d
                      [<c0265db9>] _spin_lock_irqsave+0x2d/0x3c
                      [<c012ed3b>] is_module_address+0x12/0x6e
                      [<c0127b3d>] static_obj+0x25/0x2f
                      [<c012861e>] lockdep_init_map+0x6c/0xab
                      [<c01a60c7>] __spin_lock_init+0x25/0x6e
                      [<e28865a0>] usb_init_urb+0x30/0x3a [usbcore]
                      [<e28865e5>] usb_alloc_urb+0x3b/0x46 [usbcore]
                      [<e28e5302>] bfusb_tx_wakeup+0x40/0x160 [bfusb]
                      [<e28e60ad>] bfusb_send_frame+0x297/0x2b6 [bfusb]
                      [<e291ee60>] hci_send_frame+0x55/0x5d [bluetooth]
                      [<e291f14a>] hci_cmd_task+0x94/0xcd [bluetooth]
                      [<c011786f>] tasklet_action+0x45/0x75
                      [<c0117a76>] __do_softirq+0x45/0x9f
                      [<c010480e>] do_softirq+0x4d/0xab
   }
   ... key      at: [<c02b2338>] modlist_lock+0x38/0x60
 ... acquired at:
   [<c012a05e>] lock_acquire+0x4f/0x6d
   [<c0265db9>] _spin_lock_irqsave+0x2d/0x3c
   [<c012ed3b>] is_module_address+0x12/0x6e
   [<c0127b3d>] static_obj+0x25/0x2f
   [<c012861e>] lockdep_init_map+0x6c/0xab
   [<c01a60c7>] __spin_lock_init+0x25/0x6e
   [<e28865a0>] usb_init_urb+0x30/0x3a [usbcore]
   [<e28865e5>] usb_alloc_urb+0x3b/0x46 [usbcore]
   [<e28e514e>] bfusb_rx_submit+0x20/0x138 [bfusb]
   [<e28e5299>] bfusb_open+0x33/0x5c [bfusb]
   [<e291f8b5>] hci_dev_open+0x55/0x1e0 [bluetooth]
   [<e2922ab2>] hci_sock_ioctl+0xd1/0x229 [bluetooth]
   [<c02118b8>] sock_ioctl+0x193/0x1b9
   [<c015d868>] do_ioctl+0x24/0x66
   [<c015daf4>] vfs_ioctl+0x24a/0x25d
   [<c015db35>] sys_ioctl+0x2e/0x4d
   [<c010246b>] syscall_call+0x7/0xb

  -> (&parent->list_lock){.+..} ops: 0 {
     initial-use  at:
                      [<c012a05e>] lock_acquire+0x4f/0x6d
                      [<c0265fb1>] _spin_lock+0x24/0x32
                      [<c014b01d>] cache_alloc_refill+0x61/0x48d
                      [<c014b4f8>] kmem_cache_zalloc+0x34/0x78
                      [<c014bb4b>] kmem_cache_create+0x153/0x414
                      [<c033569f>] kmem_cache_init+0x144/0x318
                      [<c0328514>] start_kernel+0x137/0x2be
                      [<c0100199>] 0xc0100199
     in-softirq-W at:
                      [<c012a05e>] lock_acquire+0x4f/0x6d
                      [<c0265fb1>] _spin_lock+0x24/0x32
                      [<c014ac65>] free_block+0xd5/0x10e
                      [<c014aa0e>] __cache_free+0xb1/0xf5
                      [<c014aaa8>] kmem_cache_free+0x56/0x70
                      [<c0111218>] free_task+0x21/0x29
                      [<c0112b4e>] __put_task_struct+0xc3/0xcd
                      [<c01143ec>] delayed_put_task_struct+0x3b/0x43
                      [<c012238e>] __rcu_process_callbacks+0xfc/0x155
                      [<c01223f9>] rcu_process_callbacks+0x12/0x23
                      [<c011786f>] tasklet_action+0x45/0x75
                      [<c0117a76>] __do_softirq+0x45/0x9f
                      [<c010480e>] do_softirq+0x4d/0xab
   }
   ... key      at: [<c04abe0c>] __key.15401+0x0/0x8
 ... acquired at:
   [<c012a05e>] lock_acquire+0x4f/0x6d
   [<c0265fb1>] _spin_lock+0x24/0x32
   [<c014b01d>] cache_alloc_refill+0x61/0x48d
   [<c014b49f>] __kmalloc+0x56/0x7b
   [<c0216ade>] __alloc_skb+0x53/0x101
   [<e28e5168>] bfusb_rx_submit+0x3a/0x138 [bfusb]
   [<e28e5299>] bfusb_open+0x33/0x5c [bfusb]
   [<e291f8b5>] hci_dev_open+0x55/0x1e0 [bluetooth]
   [<e2922ab2>] hci_sock_ioctl+0xd1/0x229 [bluetooth]
   [<c02118b8>] sock_ioctl+0x193/0x1b9
   [<c015d868>] do_ioctl+0x24/0x66
   [<c015daf4>] vfs_ioctl+0x24a/0x25d
   [<c015db35>] sys_ioctl+0x2e/0x4d
   [<c010246b>] syscall_call+0x7/0xb

  -> (&skb_queue_lock_key){-+..} ops: 0 {
     initial-use  at:
                      [<c012a05e>] lock_acquire+0x4f/0x6d
                      [<c0265db9>] _spin_lock_irqsave+0x2d/0x3c
                      [<c02158f8>] skb_queue_tail+0x16/0x34
                      [<c0225ebe>] netlink_broadcast+0x1ba/0x2ba
                      [<c0197f2d>] kobject_uevent+0x347/0x3be
                      [<c01f09a2>] store_uevent+0x11/0x16
                      [<c01f14cf>] class_device_attr_store+0x1e/0x23
                      [<c017e33c>] sysfs_write_file+0x96/0xbd
                      [<c014e2c7>] vfs_write+0x8e/0x135
                      [<c014e81c>] sys_write+0x3a/0x61
                      [<c010246b>] syscall_call+0x7/0xb
     in-softirq-W at:
                      [<c012a05e>] lock_acquire+0x4f/0x6d
                      [<c0265db9>] _spin_lock_irqsave+0x2d/0x3c
                      [<c02158f8>] skb_queue_tail+0x16/0x34
                      [<c0215232>] sock_queue_rcv_skb+0xca/0x104
                      [<c02479eb>] udp_queue_rcv_skb+0x1fd/0x222
                      [<c0248f6d>] udp_rcv+0x38c/0x4ae
                      [<c022d568>] ip_local_deliver+0x157/0x1e7
                      [<c022d3e4>] ip_rcv+0x3a6/0x3d3
                      [<c021a5d9>] netif_receive_skb+0x13d/0x1a4
                      [<c021bfb4>] process_backlog+0x7c/0x112
                      [<c021bdbe>] net_rx_action+0x5b/0xed
                      [<c0117a76>] __do_softirq+0x45/0x9f
                      [<c010480e>] do_softirq+0x4d/0xab
     hardirq-on-W at:
                      [<c012a05e>] lock_acquire+0x4f/0x6d
                      [<c0265e29>] _spin_lock_bh+0x29/0x37
                      [<c02480a7>] udp_poll+0x4f/0xc6
                      [<c0211105>] sock_poll+0x17/0x19
                      [<c015e205>] do_sys_poll+0x207/0x3c0
                      [<c015e3ff>] sys_poll+0x41/0x43
                      [<c010246b>] syscall_call+0x7/0xb
   }
   ... key      at: [<c04b41a8>] skb_queue_lock_key+0x0/0x18
 ... acquired at:
   [<c012a05e>] lock_acquire+0x4f/0x6d
   [<c0265db9>] _spin_lock_irqsave+0x2d/0x3c
   [<c02158f8>] skb_queue_tail+0x16/0x34
   [<e28e5209>] bfusb_rx_submit+0xdb/0x138 [bfusb]
   [<e28e5299>] bfusb_open+0x33/0x5c [bfusb]
   [<e291f8b5>] hci_dev_open+0x55/0x1e0 [bluetooth]
   [<e2922ab2>] hci_sock_ioctl+0xd1/0x229 [bluetooth]
   [<c02118b8>] sock_ioctl+0x193/0x1b9
   [<c015d868>] do_ioctl+0x24/0x66
   [<c015daf4>] vfs_ioctl+0x24a/0x25d
   [<c015db35>] sys_ioctl+0x2e/0x4d
   [<c010246b>] syscall_call+0x7/0xb

  -> (hcd_data_lock){++..} ops: 0 {
     initial-use  at:
                      [<c012a05e>] lock_acquire+0x4f/0x6d
                      [<c0265db9>] _spin_lock_irqsave+0x2d/0x3c
                      [<e28859f1>] hcd_submit_urb+0x35/0x823 [usbcore]
                      [<e288650a>] usb_submit_urb+0x1f7/0x21d [usbcore]
                      [<e2886ca4>] usb_start_wait_urb+0x70/0x125 [usbcore]
                      [<e2886f9b>] usb_control_msg+0xd2/0xee [usbcore]
                      [<e2887773>] usb_get_descriptor+0x6d/0xa3 [usbcore]
                      [<e2887a84>] usb_get_device_descriptor+0x43/0x79 [usbcore]
                      [<e288550d>] usb_add_hcd+0x3b6/0x4cd [usbcore]
                      [<e288d245>] usb_hcd_pci_probe+0x1db/0x26a [usbcore]
                      [<c01aa8b0>] pci_device_probe+0x3a/0x61
                      [<c01f0165>] driver_probe_device+0x46/0x9a
                      [<c01f025b>] __driver_attach+0x3b/0x66
                      [<c01efbee>] bus_for_each_dev+0x46/0x6d
                      [<c01f00b4>] driver_attach+0x16/0x1b
                      [<c01ef876>] bus_add_driver+0x6e/0x113
                      [<c01f04fa>] driver_register+0xa3/0xa8
                      [<c01aaa33>] __pci_register_driver+0x55/0x7a
                      [<e080f04e>] ____versions+0x132e/0xfffffcb8 [firmware_class]
                      [<c01304c8>] sys_init_module+0x13c5/0x1570
                      [<c010246b>] syscall_call+0x7/0xb
     in-hardirq-W at:
                      [<c012a05e>] lock_acquire+0x4f/0x6d
                      [<c0265db9>] _spin_lock_irqsave+0x2d/0x3c
                      [<e2884bce>] urb_unlink+0x35/0x5c [usbcore]
                      [<e2884c03>] usb_hcd_giveback_urb+0xe/0x46 [usbcore]
                      [<e086c74c>] uhci_giveback_urb+0x120/0x14a [uhci_hcd]
                      [<e086cda9>] uhci_scan_schedule+0x536/0x7a8 [uhci_hcd]
                      [<e086e907>] uhci_irq+0x121/0x137 [uhci_hcd]
                      [<e28857a7>] usb_hcd_irq+0x27/0x58 [usbcore]
                      [<c0132452>] handle_IRQ_event+0x18/0x4a
                      [<c0133349>] handle_fasteoi_irq+0x6d/0xae
                      [<c010490c>] do_IRQ+0xa0/0xc4
     in-softirq-W at:
                      [<c012a05e>] lock_acquire+0x4f/0x6d
                      [<c0265db9>] _spin_lock_irqsave+0x2d/0x3c
                      [<e2884bce>] urb_unlink+0x35/0x5c [usbcore]
                      [<e2884c03>] usb_hcd_giveback_urb+0xe/0x46 [usbcore]
                      [<e288500d>] usb_hcd_poll_rh_status+0x18c/0x19c [usbcore]
                      [<e2885028>] rh_timer_func+0xb/0xe [usbcore]
                      [<c011ac7c>] run_timer_softirq+0xf1/0x14a
                      [<c0117a76>] __do_softirq+0x45/0x9f
                      [<c010480e>] do_softirq+0x4d/0xab
   }
   ... key      at: [<e289d498>] hcd_data_lock+0x38/0xffff1403 [usbcore]
 ... acquired at:
   [<c012a05e>] lock_acquire+0x4f/0x6d
   [<c0265db9>] _spin_lock_irqsave+0x2d/0x3c
   [<e28859f1>] hcd_submit_urb+0x35/0x823 [usbcore]
   [<e288650a>] usb_submit_urb+0x1f7/0x21d [usbcore]
   [<e28e5211>] bfusb_rx_submit+0xe3/0x138 [bfusb]
   [<e28e5299>] bfusb_open+0x33/0x5c [bfusb]
   [<e291f8b5>] hci_dev_open+0x55/0x1e0 [bluetooth]
   [<e2922ab2>] hci_sock_ioctl+0xd1/0x229 [bluetooth]
   [<c02118b8>] sock_ioctl+0x193/0x1b9
   [<c015d868>] do_ioctl+0x24/0x66
   [<c015daf4>] vfs_ioctl+0x24a/0x25d
   [<c015db35>] sys_ioctl+0x2e/0x4d
   [<c010246b>] syscall_call+0x7/0xb

  -> (&uhci->lock){++..} ops: 0 {
     initial-use  at:
                      [<c012a05e>] lock_acquire+0x4f/0x6d
                      [<c0265db9>] _spin_lock_irqsave+0x2d/0x3c
                      [<e086e4fe>] uhci_hub_control+0x64/0x34c [uhci_hcd]
                      [<e2885fe4>] hcd_submit_urb+0x628/0x823 [usbcore]
                      [<e288650a>] usb_submit_urb+0x1f7/0x21d [usbcore]
                      [<e2886ca4>] usb_start_wait_urb+0x70/0x125 [usbcore]
                      [<e2886f9b>] usb_control_msg+0xd2/0xee [usbcore]
                      [<e2883635>] hub_probe+0x1c4/0x5f8 [usbcore]
                      [<e28882db>] usb_probe_interface+0x60/0x95 [usbcore]
                      [<c01f0165>] driver_probe_device+0x46/0x9a
                      [<c01f01c7>] __device_attach+0xe/0x10
                      [<c01efae8>] bus_for_each_drv+0x46/0x77
                      [<c01f020c>] device_attach+0x43/0x57
                      [<c01ef7eb>] bus_attach_device+0x18/0x35
                      [<c01eec1b>] device_add+0x2ef/0x3dc
                      [<e2887694>] usb_set_configuration+0x335/0x3a7 [usbcore]
                      [<e2883224>] usb_new_device+0x2a9/0x301 [usbcore]
                      [<e2885534>] usb_add_hcd+0x3dd/0x4cd [usbcore]
                      [<e288d245>] usb_hcd_pci_probe+0x1db/0x26a [usbcore]
                      [<c01aa8b0>] pci_device_probe+0x3a/0x61
                      [<c01f0165>] driver_probe_device+0x46/0x9a
                      [<c01f025b>] __driver_attach+0x3b/0x66
                      [<c01efbee>] bus_for_each_dev+0x46/0x6d
                      [<c01f00b4>] driver_attach+0x16/0x1b
                      [<c01ef876>] bus_add_driver+0x6e/0x113
                      [<c01f04fa>] driver_register+0xa3/0xa8
                      [<c01aaa33>] __pci_register_driver+0x55/0x7a
                      [<e080f04e>] ____versions+0x132e/0xfffffcb8 [firmware_class]
                      [<c01304c8>] sys_init_module+0x13c5/0x1570
                      [<c010246b>] syscall_call+0x7/0xb
     in-hardirq-W at:
                      [<c012a05e>] lock_acquire+0x4f/0x6d
                      [<c0265db9>] _spin_lock_irqsave+0x2d/0x3c
                      [<e086e8fb>] uhci_irq+0x115/0x137 [uhci_hcd]
                      [<e28857a7>] usb_hcd_irq+0x27/0x58 [usbcore]
                      [<c0132452>] handle_IRQ_event+0x18/0x4a
                      [<c0133349>] handle_fasteoi_irq+0x6d/0xae
                      [<c010490c>] do_IRQ+0xa0/0xc4
     in-softirq-W at:
                      [<c012a05e>] lock_acquire+0x4f/0x6d
                      [<c0265db9>] _spin_lock_irqsave+0x2d/0x3c
                      [<e086e0a2>] uhci_hub_status_data+0x22/0x136 [uhci_hcd]
                      [<e2884eb4>] usb_hcd_poll_rh_status+0x33/0x19c [usbcore]
                      [<e2885028>] rh_timer_func+0xb/0xe [usbcore]
                      [<c011ac7c>] run_timer_softirq+0xf1/0x14a
                      [<c0117a76>] __do_softirq+0x45/0x9f
                      [<c010480e>] do_softirq+0x4d/0xab
   }
   ... key      at: [<e0871940>] __key.18912+0x0/0xffffd523 [uhci_hcd]
    -> (&parent->list_lock){.+..} ops: 0 {
       initial-use  at:
                       [<c012a05e>] lock_acquire+0x4f/0x6d
                       [<c0265fb1>] _spin_lock+0x24/0x32
                       [<c014b01d>] cache_alloc_refill+0x61/0x48d
                       [<c014b4f8>] kmem_cache_zalloc+0x34/0x78
                       [<c014bb4b>] kmem_cache_create+0x153/0x414
                       [<c033569f>] kmem_cache_init+0x144/0x318
                       [<c0328514>] start_kernel+0x137/0x2be
                       [<c0100199>] 0xc0100199
       in-softirq-W at:
                       [<c012a05e>] lock_acquire+0x4f/0x6d
                       [<c0265fb1>] _spin_lock+0x24/0x32
                       [<c014ac65>] free_block+0xd5/0x10e
                       [<c014aa0e>] __cache_free+0xb1/0xf5
                       [<c014aaa8>] kmem_cache_free+0x56/0x70
                       [<c0111218>] free_task+0x21/0x29
                       [<c0112b4e>] __put_task_struct+0xc3/0xcd
                       [<c01143ec>] delayed_put_task_struct+0x3b/0x43
                       [<c012238e>] __rcu_process_callbacks+0xfc/0x155
                       [<c01223f9>] rcu_process_callbacks+0x12/0x23
                       [<c011786f>] tasklet_action+0x45/0x75
                       [<c0117a76>] __do_softirq+0x45/0x9f
                       [<c010480e>] do_softirq+0x4d/0xab
     }
     ... key      at: [<c04abe0c>] __key.15401+0x0/0x8
   ... acquired at:
   [<c012a05e>] lock_acquire+0x4f/0x6d
   [<c0265fb1>] _spin_lock+0x24/0x32
   [<c014b01d>] cache_alloc_refill+0x61/0x48d
   [<c014af98>] kmem_cache_alloc+0x33/0x57
   [<e086d862>] uhci_urb_enqueue+0x46/0x70e [uhci_hcd]
   [<e288615a>] hcd_submit_urb+0x79e/0x823 [usbcore]
   [<e288650a>] usb_submit_urb+0x1f7/0x21d [usbcore]
   [<e2886ca4>] usb_start_wait_urb+0x70/0x125 [usbcore]
   [<e2886f9b>] usb_control_msg+0xd2/0xee [usbcore]
   [<e28822cc>] hub_port_init+0x1d6/0x45a [usbcore]
   [<e2884035>] hub_thread+0x4bd/0x932 [usbcore]
   [<c01242f2>] kthread+0xb0/0xde
   [<c01006e9>] kernel_thread_helper+0x5/0xb

    -> (&retval->lock){++..} ops: 0 {
       initial-use  at:
                       [<c012a05e>] lock_acquire+0x4f/0x6d
                       [<c0265db9>] _spin_lock_irqsave+0x2d/0x3c
                       [<c01f22f2>] dma_pool_alloc+0x14/0x189
                       [<e086d373>] uhci_alloc_td+0x14/0x42 [uhci_hcd]
                       [<e086eb62>] uhci_start+0x1b3/0x3a7 [uhci_hcd]
                       [<e288546d>] usb_add_hcd+0x316/0x4cd [usbcore]
                       [<e288d245>] usb_hcd_pci_probe+0x1db/0x26a [usbcore]
                       [<c01aa8b0>] pci_device_probe+0x3a/0x61
                       [<c01f0165>] driver_probe_device+0x46/0x9a
                       [<c01f025b>] __driver_attach+0x3b/0x66
                       [<c01efbee>] bus_for_each_dev+0x46/0x6d
                       [<c01f00b4>] driver_attach+0x16/0x1b
                       [<c01ef876>] bus_add_driver+0x6e/0x113
                       [<c01f04fa>] driver_register+0xa3/0xa8
                       [<c01aaa33>] __pci_register_driver+0x55/0x7a
                       [<e080f04e>] ____versions+0x132e/0xfffffcb8 [firmware_class]
                       [<c01304c8>] sys_init_module+0x13c5/0x1570
                       [<c010246b>] syscall_call+0x7/0xb
       in-hardirq-W at:
                       [<c012a05e>] lock_acquire+0x4f/0x6d
                       [<c0265db9>] _spin_lock_irqsave+0x2d/0x3c
                       [<c01f21c4>] dma_pool_free+0x14/0x12e
                       [<e086c4cb>] uhci_free_td+0x6a/0x75 [uhci_hcd]
                       [<e086cbc9>] uhci_scan_schedule+0x356/0x7a8 [uhci_hcd]
                       [<e086e907>] uhci_irq+0x121/0x137 [uhci_hcd]
                       [<e28857a7>] usb_hcd_irq+0x27/0x58 [usbcore]
                       [<c0132452>] handle_IRQ_event+0x18/0x4a
                       [<c0133349>] handle_fasteoi_irq+0x6d/0xae
                       [<c010490c>] do_IRQ+0xa0/0xc4
       in-softirq-W at:
                       [<c012a05e>] lock_acquire+0x4f/0x6d
                       [<c0265db9>] _spin_lock_irqsave+0x2d/0x3c
                       [<c01f21c4>] dma_pool_free+0x14/0x12e
                       [<e086c4cb>] uhci_free_td+0x6a/0x75 [uhci_hcd]
                       [<e086cbc9>] uhci_scan_schedule+0x356/0x7a8 [uhci_hcd]
                       [<e086e0ae>] uhci_hub_status_data+0x2e/0x136 [uhci_hcd]
                       [<e2884eb4>] usb_hcd_poll_rh_status+0x33/0x19c [usbcore]
                       [<e2885028>] rh_timer_func+0xb/0xe [usbcore]
                       [<c011ac7c>] run_timer_softirq+0xf1/0x14a
                       [<c0117a76>] __do_softirq+0x45/0x9f
                       [<c010480e>] do_softirq+0x4d/0xab
     }
     ... key      at: [<c04b3444>] __key.14448+0x0/0x8
   ... acquired at:
   [<c012a05e>] lock_acquire+0x4f/0x6d
   [<c0265db9>] _spin_lock_irqsave+0x2d/0x3c
   [<c01f22f2>] dma_pool_alloc+0x14/0x189
   [<e086d6a9>] uhci_alloc_qh+0x21/0xc2 [uhci_hcd]
   [<e086d8b7>] uhci_urb_enqueue+0x9b/0x70e [uhci_hcd]
   [<e288615a>] hcd_submit_urb+0x79e/0x823 [usbcore]
   [<e288650a>] usb_submit_urb+0x1f7/0x21d [usbcore]
   [<e2886ca4>] usb_start_wait_urb+0x70/0x125 [usbcore]
   [<e2886f9b>] usb_control_msg+0xd2/0xee [usbcore]
   [<e28822cc>] hub_port_init+0x1d6/0x45a [usbcore]
   [<e2884035>] hub_thread+0x4bd/0x932 [usbcore]
   [<c01242f2>] kthread+0xb0/0xde
   [<c01006e9>] kernel_thread_helper+0x5/0xb

    -> (&urb->lock){+...} ops: 0 {
       initial-use  at:
                       [<c012a05e>] lock_acquire+0x4f/0x6d
                       [<c0265fb1>] _spin_lock+0x24/0x32
                       [<e288607f>] hcd_submit_urb+0x6c3/0x823 [usbcore]
                       [<e288650a>] usb_submit_urb+0x1f7/0x21d [usbcore]
                       [<e2886ca4>] usb_start_wait_urb+0x70/0x125 [usbcore]
                       [<e2886f9b>] usb_control_msg+0xd2/0xee [usbcore]
                       [<e2887773>] usb_get_descriptor+0x6d/0xa3 [usbcore]
                       [<e2887a84>] usb_get_device_descriptor+0x43/0x79 [usbcore]
                       [<e288550d>] usb_add_hcd+0x3b6/0x4cd [usbcore]
                       [<e288d245>] usb_hcd_pci_probe+0x1db/0x26a [usbcore]
                       [<c01aa8b0>] pci_device_probe+0x3a/0x61
                       [<c01f0165>] driver_probe_device+0x46/0x9a
                       [<c01f025b>] __driver_attach+0x3b/0x66
                       [<c01efbee>] bus_for_each_dev+0x46/0x6d
                       [<c01f00b4>] driver_attach+0x16/0x1b
                       [<c01ef876>] bus_add_driver+0x6e/0x113
                       [<c01f04fa>] driver_register+0xa3/0xa8
                       [<c01aaa33>] __pci_register_driver+0x55/0x7a
                       [<e080f04e>] ____versions+0x132e/0xfffffcb8 [firmware_class]
                       [<c01304c8>] sys_init_module+0x13c5/0x1570
                       [<c010246b>] syscall_call+0x7/0xb
       in-hardirq-W at:
                       [<c012a05e>] lock_acquire+0x4f/0x6d
                       [<c0265fb1>] _spin_lock+0x24/0x32
                       [<e086cd45>] uhci_scan_schedule+0x4d2/0x7a8 [uhci_hcd]
                       [<e086e907>] uhci_irq+0x121/0x137 [uhci_hcd]
                       [<e28857a7>] usb_hcd_irq+0x27/0x58 [usbcore]
                       [<c0132452>] handle_IRQ_event+0x18/0x4a
                       [<c0133349>] handle_fasteoi_irq+0x6d/0xae
                       [<c010490c>] do_IRQ+0xa0/0xc4
     }
     ... key      at: [<e289e558>] __key.16238+0x0/0xffff030b [usbcore]
   ... acquired at:
   [<c012a05e>] lock_acquire+0x4f/0x6d
   [<c0265fb1>] _spin_lock+0x24/0x32
   [<e086cd45>] uhci_scan_schedule+0x4d2/0x7a8 [uhci_hcd]
   [<e086e907>] uhci_irq+0x121/0x137 [uhci_hcd]
   [<e28857a7>] usb_hcd_irq+0x27/0x58 [usbcore]
   [<c0132452>] handle_IRQ_event+0x18/0x4a
   [<c0133349>] handle_fasteoi_irq+0x6d/0xae
   [<c010490c>] do_IRQ+0xa0/0xc4

    -> (&waitqueue_lock_key){++..} ops: 0 {
       initial-use  at:
                       [<c012a05e>] lock_acquire+0x4f/0x6d
                       [<c0265df2>] _spin_lock_irq+0x2a/0x38
                       [<c0263e7f>] wait_for_completion+0x15/0xc1
                       [<c01240e1>] keventd_create_kthread+0x2e/0x5e
                       [<c01241f6>] kthread_create+0xe5/0x131
                       [<c0117675>] cpu_callback+0x4d/0x97
                       [<c033373d>] spawn_ksoftirqd+0x11/0x23
                       [<c0100246>] _stext+0x26/0x1e6
                       [<c01006e9>] kernel_thread_helper+0x5/0xb
       in-hardirq-W at:
                       [<c012a05e>] lock_acquire+0x4f/0x6d
                       [<c0265db9>] _spin_lock_irqsave+0x2d/0x3c
                       [<c010f489>] complete+0x12/0x3e
                       [<c0200185>] ata_qc_complete_internal+0x11/0x13
                       [<c01fddf7>] __ata_qc_complete+0x1cd/0x1d6
                       [<c01fdf18>] ata_qc_complete+0xa6/0xae
                       [<c01fe57c>] ata_hsm_qc_complete+0x1be/0x1ce
                       [<c01febba>] ata_hsm_move+0x62e/0x644
                       [<c01fec7d>] ata_host_intr+0xad/0xc7
                       [<c0205d07>] pata_via_interrupt+0xd7/0x10a
                       [<c0132452>] handle_IRQ_event+0x18/0x4a
                       [<c0133290>] handle_edge_irq+0xc1/0x10d
                       [<c010490c>] do_IRQ+0xa0/0xc4
       in-softirq-W at:
                       [<c012a05e>] lock_acquire+0x4f/0x6d
                       [<c0265db9>] _spin_lock_irqsave+0x2d/0x3c
                       [<c010f489>] complete+0x12/0x3e
                       [<c0122155>] wakeme_after_rcu+0xe/0x10
                       [<c012238e>] __rcu_process_callbacks+0xfc/0x155
                       [<c01223f9>] rcu_process_callbacks+0x12/0x23
                       [<c011786f>] tasklet_action+0x45/0x75
                       [<c0117a76>] __do_softirq+0x45/0x9f
                       [<c010480e>] do_softirq+0x4d/0xab
     }
     ... key      at: [<c0375cd4>] waitqueue_lock_key+0x0/0x8
      -> (&rq->rq_lock_key){++..} ops: 0 {
         initial-use  at:
                        [<c012a05e>] lock_acquire+0x4f/0x6d
                        [<c0265db9>] _spin_lock_irqsave+0x2d/0x3c
                        [<c010f651>] init_idle+0x4b/0x70
                        [<c03331d5>] sched_init+0xb6/0xbf
                        [<c0328437>] start_kernel+0x5a/0x2be
                        [<c0100199>] 0xc0100199
         in-hardirq-W at:
                        [<c012a05e>] lock_acquire+0x4f/0x6d
                        [<c0265fb1>] _spin_lock+0x24/0x32
                        [<c010f71a>] scheduler_tick+0xa4/0x2a1
                        [<c011b7e7>] update_process_times+0x51/0x5f
                        [<c0105810>] timer_interrupt+0x5f/0x9b
                        [<c0132452>] handle_IRQ_event+0x18/0x4a
                        [<c0133655>] handle_level_irq+0x76/0xc5
                        [<c010490c>] do_IRQ+0xa0/0xc4
         in-softirq-W at:
                        [<c012a05e>] lock_acquire+0x4f/0x6d
                        [<c0265fb1>] _spin_lock+0x24/0x32
                        [<c010fb9c>] task_rq_lock+0x17/0x1e
                        [<c010fcc6>] try_to_wake_up+0x18/0xed
                        [<c010fdaf>] default_wake_function+0x14/0x16
                        [<c010f118>] __wake_up_common+0x2b/0x50
                        [<c010f4a2>] complete+0x2b/0x3e
                        [<c0122155>] wakeme_after_rcu+0xe/0x10
                        [<c012238e>] __rcu_process_callbacks+0xfc/0x155
                        [<c01223f9>] rcu_process_callbacks+0x12/0x23
                        [<c011786f>] tasklet_action+0x45/0x75
                        [<c0117a76>] __do_softirq+0x45/0x9f
                        [<c010480e>] do_softirq+0x4d/0xab
       }
       ... key      at: [<c036326c>] per_cpu__runqueues+0x98c/0x994
     ... acquired at:
   [<c012a05e>] lock_acquire+0x4f/0x6d
   [<c0265fb1>] _spin_lock+0x24/0x32
   [<c010fb9c>] task_rq_lock+0x17/0x1e
   [<c010fcc6>] try_to_wake_up+0x18/0xed
   [<c010fdaf>] default_wake_function+0x14/0x16
   [<c010f118>] __wake_up_common+0x2b/0x50
   [<c010f4a2>] complete+0x2b/0x3e
   [<c01242d1>] kthread+0x8f/0xde
   [<c01006e9>] kernel_thread_helper+0x5/0xb

   ... acquired at:
   [<c012a05e>] lock_acquire+0x4f/0x6d
   [<c0265db9>] _spin_lock_irqsave+0x2d/0x3c
   [<c010f50e>] __wake_up+0x15/0x3b
   [<e086c816>] uhci_make_qh_idle+0xa0/0xa8 [uhci_hcd]
   [<e086cf54>] uhci_scan_schedule+0x6e1/0x7a8 [uhci_hcd]
   [<e086e907>] uhci_irq+0x121/0x137 [uhci_hcd]
   [<e28857a7>] usb_hcd_irq+0x27/0x58 [usbcore]
   [<c0132452>] handle_IRQ_event+0x18/0x4a
   [<c0133349>] handle_fasteoi_irq+0x6d/0xae
   [<c010490c>] do_IRQ+0xa0/0xc4

    -> (base_lock_keys + cpu){++..} ops: 0 {
       initial-use  at:
                       [<c012a05e>] lock_acquire+0x4f/0x6d
                       [<c0265db9>] _spin_lock_irqsave+0x2d/0x3c
                       [<c011b5ce>] lock_timer_base+0x18/0x33
                       [<c011b65c>] __mod_timer+0x24/0x96
                       [<c011b738>] mod_timer+0x2d/0x31
                       [<c03398a6>] con_init+0xb5/0x1e5
                       [<c0339369>] console_init+0x20/0x30
                       [<c03284e6>] start_kernel+0x109/0x2be
                       [<c0100199>] 0xc0100199
       in-hardirq-W at:
                       [<c012a05e>] lock_acquire+0x4f/0x6d
                       [<c0265db9>] _spin_lock_irqsave+0x2d/0x3c
                       [<c011b5ce>] lock_timer_base+0x18/0x33
                       [<c011b605>] del_timer+0x1c/0x4f
                       [<c01f66de>] scsi_delete_timer+0x10/0x23
                       [<c01f41a7>] scsi_done+0xd/0x1e
                       [<c0201f88>] atapi_qc_complete+0x202/0x212
                       [<c01fddf7>] __ata_qc_complete+0x1cd/0x1d6
                       [<c01fdf18>] ata_qc_complete+0xa6/0xae
                       [<c01fe57c>] ata_hsm_qc_complete+0x1be/0x1ce
                       [<c01febba>] ata_hsm_move+0x62e/0x644
                       [<c01fec7d>] ata_host_intr+0xad/0xc7
                       [<c0205d07>] pata_via_interrupt+0xd7/0x10a
                       [<c0132452>] handle_IRQ_event+0x18/0x4a
                       [<c0133290>] handle_edge_irq+0xc1/0x10d
                       [<c010490c>] do_IRQ+0xa0/0xc4
       in-softirq-W at:
                       [<c012a05e>] lock_acquire+0x4f/0x6d
                       [<c0265df2>] _spin_lock_irq+0x2a/0x38
                       [<c011abb4>] run_timer_softirq+0x29/0x14a
                       [<c0117a76>] __do_softirq+0x45/0x9f
                       [<c010480e>] do_softirq+0x4d/0xab
     }
     ... key      at: [<c0374fa8>] base_lock_keys+0x0/0x18
   ... acquired at:
   [<c012a05e>] lock_acquire+0x4f/0x6d
   [<c0265db9>] _spin_lock_irqsave+0x2d/0x3c
   [<c011b5ce>] lock_timer_base+0x18/0x33
   [<c011b65c>] __mod_timer+0x24/0x96
   [<c011b738>] mod_timer+0x2d/0x31
   [<e086cfd5>] uhci_scan_schedule+0x762/0x7a8 [uhci_hcd]
   [<e086e907>] uhci_irq+0x121/0x137 [uhci_hcd]
   [<e28857a7>] usb_hcd_irq+0x27/0x58 [usbcore]
   [<c0132452>] handle_IRQ_event+0x18/0x4a
   [<c0133349>] handle_fasteoi_irq+0x6d/0xae
   [<c010490c>] do_IRQ+0xa0/0xc4

    -> (&urb->lock#3){++..} ops: 0 {
       initial-use  at:
                       [<c012a05e>] lock_acquire+0x4f/0x6d
                       [<c0265fb1>] _spin_lock+0x24/0x32
                       [<e086cd45>] uhci_scan_schedule+0x4d2/0x7a8 [uhci_hcd]
                       [<e086e907>] uhci_irq+0x121/0x137 [uhci_hcd]
                       [<e28857a7>] usb_hcd_irq+0x27/0x58 [usbcore]
                       [<c0132452>] handle_IRQ_event+0x18/0x4a
                       [<c0133349>] handle_fasteoi_irq+0x6d/0xae
                       [<c010490c>] do_IRQ+0xa0/0xc4
       in-hardirq-W at:
                       [<c012a05e>] lock_acquire+0x4f/0x6d
                       [<c0265fb1>] _spin_lock+0x24/0x32
                       [<e086cd45>] uhci_scan_schedule+0x4d2/0x7a8 [uhci_hcd]
                       [<e086e907>] uhci_irq+0x121/0x137 [uhci_hcd]
                       [<e28857a7>] usb_hcd_irq+0x27/0x58 [usbcore]
                       [<c0132452>] handle_IRQ_event+0x18/0x4a
                       [<c0133349>] handle_fasteoi_irq+0x6d/0xae
                       [<c010490c>] do_IRQ+0xa0/0xc4
       in-softirq-W at:
                       [<c012a05e>] lock_acquire+0x4f/0x6d
                       [<c0265fb1>] _spin_lock+0x24/0x32
                       [<e086cd45>] uhci_scan_schedule+0x4d2/0x7a8 [uhci_hcd]
                       [<e086e0ae>] uhci_hub_status_data+0x2e/0x136 [uhci_hcd]
                       [<e2884eb4>] usb_hcd_poll_rh_status+0x33/0x19c [usbcore]
                       [<e2885028>] rh_timer_func+0xb/0xe [usbcore]
                       [<c011ac7c>] run_timer_softirq+0xf1/0x14a
                       [<c0117a76>] __do_softirq+0x45/0x9f
                       [<c010480e>] do_softirq+0x4d/0xab
     }
     ... key      at: [<e289e550>] __key.16249+0x0/0xffff0313 [usbcore]
   ... acquired at:
   [<c012a05e>] lock_acquire+0x4f/0x6d
   [<c0265fb1>] _spin_lock+0x24/0x32
   [<e086cd45>] uhci_scan_schedule+0x4d2/0x7a8 [uhci_hcd]
   [<e086e907>] uhci_irq+0x121/0x137 [uhci_hcd]
   [<e28857a7>] usb_hcd_irq+0x27/0x58 [usbcore]
   [<c0132452>] handle_IRQ_event+0x18/0x4a
   [<c0133349>] handle_fasteoi_irq+0x6d/0xae
   [<c010490c>] do_IRQ+0xa0/0xc4

    -> (&urb->lock#4){+...} ops: 0 {
       initial-use  at:
                       [<c012a05e>] lock_acquire+0x4f/0x6d
                       [<c0265fb1>] _spin_lock+0x24/0x32
                       [<e086cd45>] uhci_scan_schedule+0x4d2/0x7a8 [uhci_hcd]
                       [<e086e907>] uhci_irq+0x121/0x137 [uhci_hcd]
                       [<e28857a7>] usb_hcd_irq+0x27/0x58 [usbcore]
                       [<c0132452>] handle_IRQ_event+0x18/0x4a
                       [<c0133349>] handle_fasteoi_irq+0x6d/0xae
                       [<c010490c>] do_IRQ+0xa0/0xc4
       in-hardirq-W at:
                       [<c012a05e>] lock_acquire+0x4f/0x6d
                       [<c0265fb1>] _spin_lock+0x24/0x32
                       [<e086cd45>] uhci_scan_schedule+0x4d2/0x7a8 [uhci_hcd]
                       [<e086e907>] uhci_irq+0x121/0x137 [uhci_hcd]
                       [<e28857a7>] usb_hcd_irq+0x27/0x58 [usbcore]
                       [<c0132452>] handle_IRQ_event+0x18/0x4a
                       [<c0133349>] handle_fasteoi_irq+0x6d/0xae
                       [<c010490c>] do_IRQ+0xa0/0xc4
     }
     ... key      at: [<e28e8294>] __key.17448+0x0/0xffffde48 [bfusb]
   ... acquired at:
   [<c012a05e>] lock_acquire+0x4f/0x6d
   [<c0265fb1>] _spin_lock+0x24/0x32
   [<e086cd45>] uhci_scan_schedule+0x4d2/0x7a8 [uhci_hcd]
   [<e086e907>] uhci_irq+0x121/0x137 [uhci_hcd]
   [<e28857a7>] usb_hcd_irq+0x27/0x58 [usbcore]
   [<c0132452>] handle_IRQ_event+0x18/0x4a
   [<c0133349>] handle_fasteoi_irq+0x6d/0xae
   [<c010490c>] do_IRQ+0xa0/0xc4

 ... acquired at:
   [<c012a05e>] lock_acquire+0x4f/0x6d
   [<c0265db9>] _spin_lock_irqsave+0x2d/0x3c
   [<e086d83e>] uhci_urb_enqueue+0x22/0x70e [uhci_hcd]
   [<e288615a>] hcd_submit_urb+0x79e/0x823 [usbcore]
   [<e288650a>] usb_submit_urb+0x1f7/0x21d [usbcore]
   [<e28e5211>] bfusb_rx_submit+0xe3/0x138 [bfusb]
   [<e28e5299>] bfusb_open+0x33/0x5c [bfusb]
   [<e291f8b5>] hci_dev_open+0x55/0x1e0 [bluetooth]
   [<e2922ab2>] hci_sock_ioctl+0xd1/0x229 [bluetooth]
   [<c02118b8>] sock_ioctl+0x193/0x1b9
   [<c015d868>] do_ioctl+0x24/0x66
   [<c015daf4>] vfs_ioctl+0x24a/0x25d
   [<c015db35>] sys_ioctl+0x2e/0x4d
   [<c010246b>] syscall_call+0x7/0xb


the second lock's dependencies:
-> (&skb_queue_lock_key){-+..} ops: 0 {
   initial-use  at:
                        [<c012a05e>] lock_acquire+0x4f/0x6d
                        [<c0265db9>] _spin_lock_irqsave+0x2d/0x3c
                        [<c02158f8>] skb_queue_tail+0x16/0x34
                        [<c0225ebe>] netlink_broadcast+0x1ba/0x2ba
                        [<c0197f2d>] kobject_uevent+0x347/0x3be
                        [<c01f09a2>] store_uevent+0x11/0x16
                        [<c01f14cf>] class_device_attr_store+0x1e/0x23
                        [<c017e33c>] sysfs_write_file+0x96/0xbd
                        [<c014e2c7>] vfs_write+0x8e/0x135
                        [<c014e81c>] sys_write+0x3a/0x61
                        [<c010246b>] syscall_call+0x7/0xb
   in-softirq-W at:
                        [<c012a05e>] lock_acquire+0x4f/0x6d
                        [<c0265db9>] _spin_lock_irqsave+0x2d/0x3c
                        [<c02158f8>] skb_queue_tail+0x16/0x34
                        [<c0215232>] sock_queue_rcv_skb+0xca/0x104
                        [<c02479eb>] udp_queue_rcv_skb+0x1fd/0x222
                        [<c0248f6d>] udp_rcv+0x38c/0x4ae
                        [<c022d568>] ip_local_deliver+0x157/0x1e7
                        [<c022d3e4>] ip_rcv+0x3a6/0x3d3
                        [<c021a5d9>] netif_receive_skb+0x13d/0x1a4
                        [<c021bfb4>] process_backlog+0x7c/0x112
                        [<c021bdbe>] net_rx_action+0x5b/0xed
                        [<c0117a76>] __do_softirq+0x45/0x9f
                        [<c010480e>] do_softirq+0x4d/0xab
   hardirq-on-W at:
                        [<c012a05e>] lock_acquire+0x4f/0x6d
                        [<c0265e29>] _spin_lock_bh+0x29/0x37
                        [<c02480a7>] udp_poll+0x4f/0xc6
                        [<c0211105>] sock_poll+0x17/0x19
                        [<c015e205>] do_sys_poll+0x207/0x3c0
                        [<c015e3ff>] sys_poll+0x41/0x43
                        [<c010246b>] syscall_call+0x7/0xb
 }
 ... key      at: [<c04b41a8>] skb_queue_lock_key+0x0/0x18

stack backtrace:
 [<c0103433>] show_trace+0x16/0x19
 [<c0103913>] dump_stack+0x1a/0x1f
 [<c01285a5>] print_irq_inversion_bug+0xe3/0xf0
 [<c012881d>] check_usage_forwards+0x32/0x3b
 [<c01289d5>] mark_lock+0x1af/0x35a
 [<c0129504>] __lock_acquire+0x328/0x929
 [<c012a05e>] lock_acquire+0x4f/0x6d
 [<c0265d7e>] _read_lock+0x24/0x32
 [<e28e59e2>] bfusb_rx_complete+0x34/0x468 [bfusb]
 [<e2884c0d>] usb_hcd_giveback_urb+0x18/0x46 [usbcore]
 [<e086c74c>] uhci_giveback_urb+0x120/0x14a [uhci_hcd]
 [<e086cda9>] uhci_scan_schedule+0x536/0x7a8 [uhci_hcd]
 [<e086e907>] uhci_irq+0x121/0x137 [uhci_hcd]
 [<e28857a7>] usb_hcd_irq+0x27/0x58 [usbcore]
 [<c0132452>] handle_IRQ_event+0x18/0x4a
 [<c0133349>] handle_fasteoi_irq+0x6d/0xae
 [<c010490c>] do_IRQ+0xa0/0xc4
 =======================
 [<c0102e59>] common_interrupt+0x25/0x2c
 [<c01013de>] cpu_idle+0x3c/0x65
 [<c010043d>] rest_init+0x37/0x3e
 [<c0328699>] start_kernel+0x2bc/0x2be
 [<c0100199>] 0xc0100199


_____________________________________________________________________
Der WEB.DE SmartSurfer hilft bis zu 70% Ihrer Onlinekosten zu sparen!
http://smartsurfer.web.de/?mc=100071&distributionid=000000000071

