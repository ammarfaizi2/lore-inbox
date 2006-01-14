Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751433AbWANX5Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751433AbWANX5Y (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 18:57:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751330AbWANX5Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 18:57:24 -0500
Received: from h144-158.u.wavenet.pl ([217.79.144.158]:37514 "EHLO
	ogre.sisk.pl") by vger.kernel.org with ESMTP id S1751433AbWANX5X
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 18:57:23 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: 2.6.15-mm4: sem2mutex problem in USB OHCI
Date: Sun, 15 Jan 2006 00:58:58 +0100
User-Agent: KMail/1.9
Cc: LKML <linux-kernel@vger.kernel.org>, Greg KH <greg@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601150058.58518.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I get this on the system startup (Asus L5D, x86-64, 1 CPU):

ACPI: PCI Interrupt Link [LUS1] enabled at IRQ 11
ACPI: PCI Interrupt 0000:00:02.1[B] -> Link [LUS1] -> GSI 11 (level, low) -> IRQ 11
ohci_hcd 0000:00:02.1: OHCI Host Controller
ohci_hcd 0000:00:02.1: new USB bus registered, assigned bus number 2
ohci_hcd 0000:00:02.1: irq 11, io mem 0xfebfc000
usb usb2: Product: OHCI Host Controller
usb usb2: Manufacturer: Linux 2.6.15-mm4 ohci_hcd
Badness in __mutex_trylock_slowpath at kernel/mutex.c:281

Call Trace: <IRQ> <ffffffff80148d8d>{mutex_trylock+141}
       <ffffffff880abaf0>{:ohci_hcd:ohci_hub_status_data+480}
       <ffffffff802d25d0>{rh_timer_func+0} <ffffffff802d24c3>{usb_hcd_poll_rh_status+67}
       <ffffffff802d25d0>{rh_timer_func+0} <ffffffff802d25d9>{rh_timer_func+9}
       <ffffffff8013a3cc>{run_timer_softirq+396} <ffffffff801361c0>{__do_softirq+80}
       <ffffffff8010fd12>{call_softirq+30} <ffffffff80111715>{do_softirq+53}
       <ffffffff8013625f>{irq_exit+63} <ffffffff80111761>{do_IRQ+65}
       <ffffffff8010f266>{ret_from_intr+0} <EOI> <ffffffff80130c1d>{release_console_sem+333}
       <ffffffff801313f7>{vprintk+775} <ffffffff801314f2>{printk+162}
       <ffffffff801314f2>{printk+162} <ffffffff802d5b0b>{usb_cache_string+139}
       <ffffffff802cd170>{show_string+64} <ffffffff802ceec5>{usb_new_device+261}
       <ffffffff802d3769>{usb_add_hcd+1433} <ffffffff802dce83>{usb_hcd_pci_probe+691}
       <ffffffff8025a26a>{pci_device_probe+106} <ffffffff802b556c>{driver_probe_device+108}
       <ffffffff802b5636>{__driver_attach+86} <ffffffff802b55e0>{__driver_attach+0}
       <ffffffff802b4eef>{bus_for_each_dev+79} <ffffffff802b53fc>{driver_attach+28}
       <ffffffff802b48e8>{bus_add_driver+136} <ffffffff802b57af>{driver_register+207}
       <ffffffff8025a521>{__pci_register_driver+177} <ffffffff88012059>{:ohci_hcd:ohci_hcd_pci_init+89}
       <ffffffff8014f7af>{sys_init_module+239} <ffffffff8010ec9e>{system_call+126}
ohci_hcd 0000:00:02.0: suspend root hub
usb usb2: SerialNumber: 0000:00:02.1
usb usb2: uevent
usb usb2: device is self-powered
usb usb2: configuration #1 chosen from 1 choice
usb usb2: adding 2-0:1.0 (config #1, interface 0)

This happens every time the system starts and it sometimes leaves a dead khubd.

Greetings,
Rafael
