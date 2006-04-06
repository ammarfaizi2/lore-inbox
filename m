Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750939AbWDFK70@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750939AbWDFK70 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Apr 2006 06:59:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750914AbWDFK70
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Apr 2006 06:59:26 -0400
Received: from dtp.xs4all.nl ([80.126.206.180]:37967 "HELO abra2.bitwizard.nl")
	by vger.kernel.org with SMTP id S1750793AbWDFK7Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Apr 2006 06:59:25 -0400
Date: Thu, 6 Apr 2006 12:59:21 +0200
From: Erik Mouw <erik@harddisk-recovery.com>
To: linux-kernel@vger.kernel.org
Cc: netdev@vger.kernel.org
Subject: [BUG NET/PCMCIA 2.6.17-rc1] Oops with cardctl eject
Message-ID: <20060406105921.GE20402@harddisk-recovery.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: Harddisk-recovery.com
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I got this oops while ejecting a Lucent Orinico Silver card:

root@arthur:~ # cardctl ident 0
  product info: "Lucent Technologies", "WaveLAN/IEEE", "Version 01.01", ""
  manfid: 0x0156, 0x0002
  function: 6 (network)
root@arthur:~ # ifdown eth2
root@arthur:~ # cardctl eject 0
pccard: card ejected from slot 0
------------[ cut here ]------------
kernel BUG at net/core/dev.c:3140!
invalid opcode: 0000 [#1]
Modules linked in: lp orinoco_cs orinoco hermes af_packet arc4 ieee80211_crypt_wep bcm43xx ieee80211softmac ieee80211 ieee80211_crypt binfmt_misc autofs4 ipv6 ide_cd cdrom 8250_pnp floppy eth1394 8139too mii ohci1394 ieee1394 snd_via82xx_modem snd_via82xx gameport snd_ac97_codec snd_ac97_bus snd_pcm_oss snd_mixer_oss snd_pcm snd_timer snd_page_alloc snd_mpu401_uart snd_rawmidi snd_seq_device snd soundcore via686a i2c_isa i2c_core usbhid uhci_hcd usbcore parport_pc parport tun cpufreq_conservative cpufreq_ondemand powernow_k7 freq_table 8250 serial_core psmouse pcspkr r128 drm via_agp agpgart
CPU:    0
EIP:    0060:[<c020d1cb>]    Not tainted VLI
EFLAGS: 00210293   (2.6.17-rc1-dirty #2)
EIP is at free_netdev+0x22/0x43
eax: 00000002   ebx: d23ab600   ecx: 00000000   edx: d3dc1000
esi: d23ab684   edi: e0ba08c0   ebp: dfe5e174   esp: d7b29e60
ds: 007b   es: 007b   ss: 0068
Process cardctl (pid: 12725, threadinfo=d7b29000 task=dfe08110)
Stack: <0>c01f2246 d3dc1000 d23ab6ec d23ab684 e0ba08d8 c01ddba5 d23ab684 d23ab684
       dfebd448 dfe5e028 c01ddbe8 d23ab684 d23ab684 c01dd3fc d23ab684 d23ab684
       c01dc67a d23ab684 d23ab684 d23ab600 c01dc6b1 d23ab684 00200286 c01f21d9
Call Trace:
 <c01f2246> pcmcia_device_remove+0x52/0xbd   <c01ddba5> __device_release_driver+0x54/0x7b
 <c01ddbe8> device_release_driver+0x1c/0x2b   <c01dd3fc> bus_remove_device+0x52/0x65
 <c01dc67a> device_del+0x39/0x65   <c01dc6b1> device_unregister+0xb/0x16
 <c01f21d9> pcmcia_card_remove+0x64/0x7f   <c01f2f6f> ds_event+0x4f/0x8c
 <c01ee6f0> send_event+0x42/0x6e   <c01ee729> socket_remove_drivers+0xd/0x11
 <c01ee7e6> socket_shutdown+0xc/0xc8   <c01ef02d> pcmcia_eject_card+0x41/0x52
 <c01f4d7b> ds_ioctl+0x3f5/0x5c6   <c0152ce1> do_ioctl+0x49/0x4f
 <c0152f0e> vfs_ioctl+0x170/0x17d   <c0152f46> sys_ioctl+0x2b/0x45
 <c0102a07> syscall_call+0x7/0xb
Code: df 5e 5b 5e 89 f8 5f 5d c3 8b 54 24 04 8b 82 70 01 00 00 85 c0 75 0f 0f b7 42 64 29 c2 89 54 24 04 e9 a6 57 f3 ff 83 f8 04 74 08 <0f> 0b 44 0c 3b f1 27 c0 c7 82 70 01 00 00 05 00 00 00 8d 82 c4
 BUG: cardctl/12725, lock held at task exit time!
 [dfe5e140] {pcmcia_register_socket}
.. held by:           cardctl:12725 [dfe08110, 115]
... acquired at:               pcmcia_eject_card+0x11/0x52


Kernel version: Linux version 2.6.17-rc1-dirty (root@arthur) (gcc
version 3.3.5 (Debian 1:3.3.5-13)) #2 Mon Apr 3 16:18:21 CEST 2006

This used to work with 2.6.16. Cardctl is from the Debian pcmcia-cs
3.2.5-10 package. CPU is a Mobile Athlon 1.2 GHz on a Sony Vaio
PCG-FX505 laptop.

Output from lspci:

0000:00:00.0 Host bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133] (rev 03)
0000:00:01.0 PCI bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133 AGP]
0000:00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 40)
0000:00:07.1 IDE interface: VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06)
0000:00:07.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 1a)
0000:00:07.3 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 1a)
0000:00:07.4 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 40)
0000:00:07.5 Multimedia audio controller: VIA Technologies, Inc. VT82C686 AC97 Audio Controller (rev 50)
0000:00:07.6 Communication controller: VIA Technologies, Inc. AC'97 Modem Controller (rev 30)
0000:00:0a.0 CardBus bridge: Texas Instruments PCI1420
0000:00:0a.1 CardBus bridge: Texas Instruments PCI1420
0000:00:0e.0 FireWire (IEEE 1394): Texas Instruments TSB12LV26 IEEE-1394 Controller (Link)
0000:00:10.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+ (rev 10)
0000:01:00.0 VGA compatible controller: ATI Technologies Inc Rage Mobility P/M AGP 2x (rev 64)
0000:02:00.0 Network controller: Broadcom Corporation BCM4318 [AirForce One 54g] 802.11g Wireless LAN Controller (rev 02)

At time of Oops, the Linksys/Broadcom wireless card wasn't in the
system. I can recreate the Oops also when the Linksys card hasn't been
inserted into the system (and the bcm43xx modules haven't been loaded).

Don't know if it's a locking error or a network error, so I'm sending
this message to lkml and netdev. If you need more information, feel
free to ask.


Erik

-- 
+-- Erik Mouw -- www.harddisk-recovery.com -- +31 70 370 12 90 --
| Lab address: Delftechpark 26, 2628 XH, Delft, The Netherlands
