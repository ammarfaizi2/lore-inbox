Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754556AbWKRVpa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754556AbWKRVpa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Nov 2006 16:45:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754793AbWKRVpa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Nov 2006 16:45:30 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:36789 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S1754556AbWKRVp2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Nov 2006 16:45:28 -0500
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-ID: <455F7EDD.6060007@s5r6.in-berlin.de>
Date: Sat, 18 Nov 2006 22:45:01 +0100
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.6) Gecko/20060730 SeaMonkey/1.0.4
MIME-Version: 1.0
To: Mattia Dongili <malattia@linux.it>
CC: Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net,
       bcollins@debian.org
Subject: Re: 2.6.19-rc5-mm2 (Oops in class_device_remove_attrs during nodemgr_remove_host)
References: <20061114014125.dd315fff.akpm@osdl.org> <20061116171715.GA3645@inferi.kami.home> <455CAE0F.1080502@s5r6.in-berlin.de> <20061116203926.GA3314@inferi.kami.home> <455CEB48.5000906@s5r6.in-berlin.de> <20061117071650.GA4974@inferi.kami.home> <455DCEF7.3060906@s5r6.in-berlin.de> <455DD42B.1020004@s5r6.in-berlin.de> <20061118094706.GA17879@kroah.com> <455EEE17.4020605@s5r6.in-berlin.de> <455F3DED.3070603@s5r6.in-berlin.de>
In-Reply-To: <455F3DED.3070603@s5r6.in-berlin.de>
X-Enigmail-Version: 0.94.1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I added the following patch:

--- linux-2.6.19-rc5-mm2.orig/drivers/ieee1394/nodemgr.c        2006-11-18 21:18:05.000000000 +0100
+++ linux-2.6.19-rc5-mm2/drivers/ieee1394/nodemgr.c     2006-11-18 21:33:44.000000000 +0100
@@ -798,8 +798,9 @@ static void nodemgr_remove_uds(struct no

 static void nodemgr_remove_ne(struct node_entry *ne)
 {
-       struct device *dev = &ne->device;
+       struct device *dev;

+       HPSB_DEBUG("****** nodemgr_remove_ne");
        dev = get_device(&ne->device);
        if (!dev)
                return;
@@ -817,7 +818,10 @@ static void nodemgr_remove_ne(struct nod

 static int __nodemgr_remove_host_dev(struct device *dev, void *data)
 {
-       nodemgr_remove_ne(container_of(dev, struct node_entry, device));
+       struct node_entry *ne = container_of(dev, struct node_entry, device);
+
+       HPSB_DEBUG("****** ne = %p", ne);
+       nodemgr_remove_ne(ne);
        return 0;
 }

@@ -906,6 +910,7 @@ static struct node_entry *nodemgr_create
        HPSB_DEBUG("%s added: ID:BUS[" NODE_BUS_FMT "]  GUID[%016Lx]",
                   (host->node_id == nodeid) ? "Host" : "Node",
                   NODE_BUS_ARGS(host, nodeid), (unsigned long long)guid);
+       HPSB_DEBUG("****** ne = %p", ne);

        return ne;



With this I get the following kernel log on a PC with two FireWire cards:

# modprobe ohci1394

Nov 18 21:38:05 shuttle kernel: ieee1394: Initialized config rom entry `ip1394'
Nov 18 21:38:05 shuttle kernel: ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=[17]  MMIO=[e7004000-e70047ff]  Max Packet=[4096]  IR/IT contexts=[4/8]
Nov 18 21:38:05 shuttle kernel: ohci1394: fw-host1: OHCI-1394 1.0 (PCI): IRQ=[19]  MMIO=[e7006000-e70067ff]  Max Packet=[2048]  IR/IT contexts=[8/8]
Nov 18 21:38:07 shuttle kernel: ieee1394: Error parsing configrom for node 0-01:1023
Nov 18 21:38:07 shuttle kernel: ieee1394: Host added: ID:BUS[0-02:1023]  GUID[0001080000002d02]
Nov 18 21:38:07 shuttle kernel: ieee1394: ****** ne = f61f609c
Nov 18 21:38:07 shuttle kernel: eth1394: eth1: IEEE-1394 IPv4 over 1394 Ethernet (fw-host0)
Nov 18 21:38:07 shuttle kernel: eth1394: eth2: IEEE-1394 IPv4 over 1394 Ethernet (fw-host1)
Nov 18 21:38:07 shuttle kernel: ieee1394: Host added: ID:BUS[1-00:1023]  GUID[00301bac00002ba4]
Nov 18 21:38:07 shuttle kernel: ieee1394: ****** ne = f50db964

# modprobe -r ohci1394

Nov 18 21:38:18 shuttle kernel: ieee1394: ****** ne = f627952c
Nov 18 21:38:18 shuttle kernel: ieee1394: ****** nodemgr_remove_ne
Nov 18 21:38:18 shuttle kernel: BUG: unable to handle kernel NULL pointer dereference at virtual address 000000b8

We never created a "ne" at f627952c. This address is obtained by the
container_of() in __nodemgr_remove_host_dev(). Ergo the list of device
pointers which device_for_each_child() in nodemgr_remove_host_dev() is
iterating over, i.e. the host->device.klist_children, was corrupted
somewhere.

Nov 18 21:38:18 shuttle kernel:  printing eip:
Nov 18 21:38:18 shuttle kernel: f9057b4c
Nov 18 21:38:18 shuttle kernel: *pde = 00000000
Nov 18 21:38:18 shuttle kernel: Oops: 0000 [#1]
Nov 18 21:38:18 shuttle kernel: PREEMPT SMP
Nov 18 21:38:18 shuttle kernel: last sysfs file: /class/printer/lp0/dev
Nov 18 21:38:18 shuttle kernel: Modules linked in: eth1394 ohci1394 ieee1394 nvidia(P) nfsd exportfs lockd sunrpc snd_via82xx snd_ac97_codec snd_ac97_bus snd_pcm snd_timer snd_page_alloc snd_mpu401_uart snd_rawmidi snd lp af_packet 8139too mii loop via_agp agpgart uhci_hcd
Nov 18 21:38:18 shuttle kernel: CPU:    0
Nov 18 21:38:18 shuttle kernel: EIP:    0060:[pg0+950528844/1067602944]    Tainted: P      VLI
Nov 18 21:38:18 shuttle kernel: EIP:    0060:[<f9057b4c>]    Tainted: P      VLI
Nov 18 21:38:18 shuttle kernel: EFLAGS: 00210213   (2.6.19-rc5-mm2 #15)
Nov 18 21:38:18 shuttle kernel: EIP is at nodemgr_remove_ne+0x4c/0x90 [ieee1394]
Nov 18 21:38:18 shuttle kernel: eax: 00000000   ebx: f6279568   ecx: 00003a2d   edx: 0000037a
Nov 18 21:38:18 shuttle kernel: esi: f627952c   edi: f9057b90   ebp: f57a3dd8   esp: f57a3db8
Nov 18 21:38:18 shuttle kernel: ds: 007b   es: 007b   ss: 0068
Nov 18 21:38:18 shuttle kernel: Process modprobe (pid: 5967, ti=f57a2000 task=f576e0f0 task.ti=f57a2000)
Nov 18 21:38:18 shuttle kernel: Stack: f6279568 f627952c 00000020 0000037a f8c7de00 00000000 f627952c f57a3dfc
Nov 18 21:38:18 shuttle kernel:        f57a3dec f9057bb5 f627952c f627952c 00000000 f57a3e18 c02313b2 f6279568
Nov 18 21:38:18 shuttle kernel:        00000000 f73ea0c4 f73ea0e4 f6279598 c02d8b18 f73ea0c4 f73ea000 f73ea000
Nov 18 21:38:18 shuttle kernel: Call Trace:
Nov 18 21:38:19 shuttle kernel:  [show_trace_log_lvl+47/80] show_trace_log_lvl+0x2f/0x50
Nov 18 21:38:19 shuttle kernel:  [<c010400f>] show_trace_log_lvl+0x2f/0x50
Nov 18 21:38:19 shuttle kernel:  [show_stack_log_lvl+151/192] show_stack_log_lvl+0x97/0xc0
Nov 18 21:38:19 shuttle kernel:  [<c01040f7>] show_stack_log_lvl+0x97/0xc0
Nov 18 21:38:19 shuttle kernel:  [show_registers+453/832] show_registers+0x1c5/0x340
Nov 18 21:38:19 shuttle kernel:  [<c0104355>] show_registers+0x1c5/0x340
Nov 18 21:38:19 shuttle kernel:  [die+298/544] die+0x12a/0x220
Nov 18 21:38:19 shuttle kernel:  [<c010469a>] die+0x12a/0x220
Nov 18 21:38:19 shuttle kernel:  [do_page_fault+873/1632] do_page_fault+0x369/0x660
Nov 18 21:38:19 shuttle kernel:  [<c0114649>] do_page_fault+0x369/0x660
Nov 18 21:38:19 shuttle kernel:  [error_code+124/132] error_code+0x7c/0x84
Nov 18 21:38:19 shuttle kernel:  [<c02dadfc>] error_code+0x7c/0x84
Nov 18 21:38:19 shuttle kernel:  [pg0+950528949/1067602944] __nodemgr_remove_host_dev+0x25/0x30 [ieee1394]
Nov 18 21:38:19 shuttle kernel:  [<f9057bb5>] __nodemgr_remove_host_dev+0x25/0x30 [ieee1394]
Nov 18 21:38:19 shuttle kernel:  [device_for_each_child+50/96] device_for_each_child+0x32/0x60
Nov 18 21:38:19 shuttle kernel:  [<c02313b2>] device_for_each_child+0x32/0x60
Nov 18 21:38:19 shuttle kernel:  [pg0+950528994/1067602944] nodemgr_remove_host_dev+0x22/0x90 [ieee1394]
Nov 18 21:38:19 shuttle kernel:  [<f9057be2>] nodemgr_remove_host_dev+0x22/0x90 [ieee1394]
Nov 18 21:38:19 shuttle kernel:  [pg0+950536711/1067602944] nodemgr_remove_host+0x37/0x40 [ieee1394]
Nov 18 21:38:19 shuttle kernel:  [<f9059a07>] nodemgr_remove_host+0x37/0x40 [ieee1394]
Nov 18 21:38:19 shuttle kernel:  [pg0+950514108/1067602944] __unregister_host+0x8c/0xd0 [ieee1394]
Nov 18 21:38:19 shuttle kernel:  [<f90541bc>] __unregister_host+0x8c/0xd0 [ieee1394]
Nov 18 21:38:19 shuttle kernel:  [pg0+950516502/1067602944] highlevel_remove_host+0x36/0x60 [ieee1394]
Nov 18 21:38:19 shuttle kernel:  [<f9054b16>] highlevel_remove_host+0x36/0x60 [ieee1394]
Nov 18 21:38:19 shuttle kernel:  [pg0+950512675/1067602944] hpsb_remove_host+0x43/0x70 [ieee1394]
Nov 18 21:38:19 shuttle kernel:  [<f9053c23>] hpsb_remove_host+0x43/0x70 [ieee1394]
Nov 18 21:38:19 shuttle kernel:  [pg0+946040328/1067602944] ohci1394_pci_remove+0x68/0x240 [ohci1394]
Nov 18 21:38:19 shuttle kernel:  [<f8c0fe08>] ohci1394_pci_remove+0x68/0x240 [ohci1394]
Nov 18 21:38:19 shuttle kernel:  [pci_device_remove+70/80] pci_device_remove+0x46/0x50
Nov 18 21:38:19 shuttle kernel:  [<c01fe976>] pci_device_remove+0x46/0x50
Nov 18 21:38:19 shuttle kernel:  [__device_release_driver+174/192] __device_release_driver+0xae/0xc0
Nov 18 21:38:19 shuttle kernel:  [<c023377e>] __device_release_driver+0xae/0xc0
Nov 18 21:38:19 shuttle kernel:  [driver_detach+280/288] driver_detach+0x118/0x120
Nov 18 21:38:19 shuttle kernel:  [<c0233908>] driver_detach+0x118/0x120
Nov 18 21:38:19 shuttle kernel:  [bus_remove_driver+68/112] bus_remove_driver+0x44/0x70
Nov 18 21:38:19 shuttle kernel:  [<c0232c44>] bus_remove_driver+0x44/0x70
Nov 18 21:38:19 shuttle kernel:  [driver_unregister+18/32] driver_unregister+0x12/0x20
Nov 18 21:38:19 shuttle kernel:  [<c0233bd2>] driver_unregister+0x12/0x20
Nov 18 21:38:19 shuttle kernel:  [pci_unregister_driver+21/48] pci_unregister_driver+0x15/0x30
Nov 18 21:38:19 shuttle kernel:  [<c01fecf5>] pci_unregister_driver+0x15/0x30
Nov 18 21:38:19 shuttle kernel:  [pg0+946042066/1067602944] ohci1394_cleanup+0x12/0x14 [ohci1394]
Nov 18 21:38:19 shuttle kernel:  [<f8c104d2>] ohci1394_cleanup+0x12/0x14 [ohci1394]
Nov 18 21:38:19 shuttle kernel:  [sys_delete_module+342/384] sys_delete_module+0x156/0x180
Nov 18 21:38:19 shuttle kernel:  [<c0142aa6>] sys_delete_module+0x156/0x180
Nov 18 21:38:19 shuttle kernel:  [sysenter_past_esp+95/133] sysenter_past_esp+0x5f/0x85
Nov 18 21:38:19 shuttle kernel:  [<c01031f6>] sysenter_past_esp+0x5f/0x85
Nov 18 21:38:19 shuttle kernel:  =======================
Nov 18 21:38:19 shuttle kernel: Code: c7 85 c0 89 c3 74 60 8b 06 8b 56 04 89 44 24 10 89 54 24 14 0f b7 46 14 89 c2 83 e0 3f c1 ea 06 89 44 24 08 89 54 24 0c 8b 46 10 <8b> 80 b8 00 00 00 c7 04 24 2c b5 07 f9 89 44 24 04 e8 3e 6c 0c
Nov 18 21:38:19 shuttle kernel: EIP: [pg0+950528844/1067602944] nodemgr_remove_ne+0x4c/0x90 [ieee1394] SS:ESP 0068:f57a3db8
Nov 18 21:38:19 shuttle kernel: EIP: [<f9057b4c>] nodemgr_remove_ne+0x4c/0x90 [ieee1394] SS:ESP 0068:f57a3db8



The same on Linux 2.6.19-rc4 plus what constitutes git-ieee1394.patch
plus the diagnostics patch:

# modprobe ohci1394

Nov 18 22:09:25 shuttle kernel: ieee1394: Initialized config rom entry `ip1394'
Nov 18 22:09:25 shuttle kernel: ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=[17]  MMIO=[e7004000-e70047ff]  Max Packet=[4096]  IR/IT contexts=[4/8]
Nov 18 22:09:25 shuttle kernel: ohci1394: fw-host1: OHCI-1394 1.0 (PCI): IRQ=[19]  MMIO=[e7006000-e70067ff]  Max Packet=[2048]  IR/IT contexts=[8/8]
Nov 18 22:09:27 shuttle kernel: ieee1394: Error parsing configrom for node 0-01:1023
Nov 18 22:09:27 shuttle kernel: ieee1394: Host added: ID:BUS[0-02:1023]  GUID[0001080000002d02]
Nov 18 22:09:27 shuttle kernel: ieee1394: ****** ne = f505512c
Nov 18 22:09:27 shuttle kernel: eth1394: eth1: IEEE-1394 IPv4 over 1394 Ethernet (fw-host0)
Nov 18 22:09:27 shuttle kernel: eth1394: eth2: IEEE-1394 IPv4 over 1394 Ethernet (fw-host1)
Nov 18 22:09:27 shuttle kernel: ieee1394: Host added: ID:BUS[1-00:1023]  GUID[00301bac00002ba4]
Nov 18 22:09:27 shuttle kernel: ieee1394: ****** ne = f5140d80

# modprobe -r ohci1394

Nov 18 22:09:31 shuttle kernel: ieee1394: ****** ne = f5140d80
Nov 18 22:09:31 shuttle kernel: ieee1394: ****** nodemgr_remove_ne
Nov 18 22:09:31 shuttle kernel: ieee1394: Node removed: ID:BUS[1-00:1023]  GUID[00301bac00002ba4]
Nov 18 22:09:32 shuttle kernel: ieee1394: ****** ne = f505512c
Nov 18 22:09:32 shuttle kernel: ieee1394: ****** nodemgr_remove_ne
Nov 18 22:09:32 shuttle kernel: ieee1394: Node removed: ID:BUS[0-02:1023]  GUID[0001080000002d02]

It seems like one of the patches in -mm overwrites a device's list of
children with junk.

Mattia, *if* your machine is able to compile and reboot into new
kernels  really quickly, it would be nice if you could biject between
the -mm patches. I suppose the following ones are those to concentrate
on first:

broken-out/gregkh-driver-config_sysfs_deprecated-bus.patch
broken-out/gregkh-driver-config_sysfs_deprecated-class.patch
broken-out/gregkh-driver-config_sysfs_deprecated-device.patch
broken-out/gregkh-driver-config_sysfs_deprecated-PHYSDEV.patch
broken-out/gregkh-driver-driver-link-sysfs-timing.patch
broken-out/gregkh-driver-sysfs-crash-debugging.patch
broken-out/gregkh-driver-udev-compatible-hack.patch

But hold on, I will do one other thing after I sent this message; I'll
test -mm with CONFIG_SYSFS_DEPRECATED=y.
-- 
Stefan Richter
-=====-=-==- =-== =--=-
http://arcgraph.de/sr/
