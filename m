Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266128AbUIWPP6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266128AbUIWPP6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 11:15:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266271AbUIWPP6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 11:15:58 -0400
Received: from port-212-202-157-208.static.qsc.de ([212.202.157.208]:38553
	"EHLO zoidberg.portrix.net") by vger.kernel.org with ESMTP
	id S266128AbUIWPPy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 11:15:54 -0400
Message-ID: <4152E890.5030500@ppp0.net>
Date: Thu, 23 Sep 2004 17:15:28 +0200
From: Jan Dittmer <jdittmer@ppp0.net>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040830)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: linux1394-devel@lists.sourceforge.net, bcollins@debian.org
Subject: Oops in dv1394_remove_host (inkl. fix)
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was playing around with dummyphp. When removing the pci device
of ohci1394 I got an oops due to the missing initialization
of the .name attribute of the dummy driver (I think).
The code in question is this (in dv1394.c, dv1394_remove_host):

        /* We only work with the OHCI-1394 driver */
        if (strcmp(host->driver->name, OHCI1394_DRIVER_NAME))
                return;

Additionally I think this check will never be true, because
host->driver is set to &dummy before calling the
remove_hosts functions of the sublevel drivers
(hosts.c, remove_host):

        host->driver = &dummy_driver;

        highlevel_remove_host(host);

highlevel_remove_host calls dv1394_remove_host.

The following should fix the oops:

--- 2.6/drivers/ieee1394/hosts.c.orig   2004-09-23 16:57:58.000000000 +0200
+++ 2.6/drivers/ieee1394/hosts.c        2004-09-23 16:58:00.000000000 +0200
@@ -76,7 +76,8 @@
 static struct hpsb_host_driver dummy_driver = {
         .transmit_packet = dummy_transmit_packet,
         .devctl =          dummy_devctl,
-       .isoctl =          dummy_isoctl
+       .isoctl =          dummy_isoctl,
+       .name = "dummy"
 };

 static int alloc_hostnum_cb(struct hpsb_host *host, void *__data)


Thanks,

Jan

ieee1394: Node removed: ID:BUS[0-00:1023]  GUID[0800460301101508]
Unable to handle kernel NULL pointer dereference at virtual address 00000000
 printing eip:
c02d2aa8
*pde = 097eb001
*pte = 00000000
Oops: 0000 [#1]
PREEMPT SMP
Modules linked in: dummyphp pci_hotplug orinoco_cs orinoco hermes ds ipv6 ppp_generic slhc ipt_state iptable_filter iptable_mangle ipt_MASQUERADE iptable_nat ip_conntrack iptable_raw ip_tables hci_usb yenta_socket pcmcia_core eeprom i2c_sensor i2c_isa i2c_i810 i2c_algo_bit i2c_i801 i2c_core pl2303 usbserial
CPU:    0
EIP:    0060:[<c02d2aa8>]    Not tainted VLI
EFLAGS: 00010286   (2.6.9-rc2-bk8-numa)
EIP is at dv1394_remove_host+0x18/0xc0
eax: c04895fc   ebx: 00000000   ecx: 00000000   edx: c02d2a90
esi: 00000000   edi: c03faa6e   ebp: c048a920   esp: cd842e54
ds: 007b   es: 007b   ss: 0068
Process bash (pid: 2764, threadinfo=cd842000 task=ceea7aa0)
Stack: c048a920 cf470000 cf470000 c048a920 c02b970b cd842e68 c02b9258 c048a640
       cf470000 00000000 c048a920 cf470000 c0489634 cf47209c c02ba10b cf470000
       c048a084 cae1eb40 c02b9139 cfe67000 c02c65c3 cf454140 cf433098 cf471f38
Call Trace:
 [<c02b970b>] __unregister_host+0xbb/0xc0
 [<c02b9258>] hl_get_hostinfo+0x48/0x60
 [<c02ba10b>] highlevel_remove_host+0x3b/0x70
 [<c02b9139>] hpsb_remove_host+0x39/0x60
 [<c02c65c3>] ohci1394_pci_remove+0x53/0x220
 [<c021e8f8>] pci_device_remove+0x28/0x30
 [<c02812b6>] device_release_driver+0x56/0x60
 [<c02814f5>] bus_remove_device+0x55/0xa0
 [<c028046c>] device_del+0x5c/0xa0
 [<c02804b8>] device_unregister+0x8/0x10
 [<c021ca30>] pci_destroy_dev+0x10/0x70
 [<d4f194b6>] disable_slot+0x76/0x100 [dummyphp]
 [<d4f14798>] power_write_file+0x118/0x170 [pci_hotplug]
 [<d4f14680>] power_write_file+0x0/0x170 [pci_hotplug]
 [<d4f14066>] hotplug_slot_attr_store+0x36/0x40 [pci_hotplug]
 [<c018efab>] flush_write_buffer+0x2b/0x40
 [<c018f001>] sysfs_write_file+0x41/0x50
 [<c015dda0>] vfs_write+0xb0/0x110
 [<c015dec7>] sys_write+0x47/0x80
 [<c010614b>] syscall_call+0x7/0xb
Code: 89 d8 e8 dc 42 e7 ff 8b 5c 24 38 83 c4 3c c3 8d 74 26 00 55 57 bf 6e aa 3f c0 56 53 8b 98 34 1f 00 00 8b 80 2c 1f 00 00 8b 70 04 <ac> ae 75 08 84 c0 75 f8 31 c0 eb 04 19 c0 0c 01 85 c0 74 05 5b
