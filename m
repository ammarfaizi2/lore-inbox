Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030346AbWAXGBR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030346AbWAXGBR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jan 2006 01:01:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030343AbWAXGBR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jan 2006 01:01:17 -0500
Received: from mx1.redhat.com ([66.187.233.31]:37324 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030346AbWAXGBR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jan 2006 01:01:17 -0500
Date: Tue, 24 Jan 2006 01:01:03 -0500
From: Dave Jones <davej@redhat.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: laredo@gnu.org
Subject: stradis oopses on modprobe.
Message-ID: <20060124060103.GA3532@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>, laredo@gnu.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We got this oops from a Fedora user..
Unable to handle kernel NULL pointer dereference at virtual address 000000fc
 printing eip: *pde = 1ef5b067
Oops: 0002 [#1]
last sysfs file: /devices/pci0000:00/0000:00:11.5/modalias
Modules linked in: parport_pc parport floppy nvram orinoco_cs orinoco hermes hos
tap_cs hostap ieee80211_crypt stradis compat_ioctl32 ehci_hcd ohci1394 ieee1394
uhci_hcd snd_via82xx gameport snd_ac97_codec snd_ac97_bus snd_seq_dummy snd_seq_
oss snd_seq_midi_event snd_seq snd_pcm_oss snd_mixer_oss dvb_ttpci l64781 saa714
6_vv snd_pcm video_buf saa7146 v4l1_compat snd_timer v4l2_common snd_page_alloc
videodev ves1820 snd_mpu401_uart snd_rawmidi i2c_viapro stv0299 snd_seq_device v
ia_ircc dvb_core tda8083 snd irda stv0297 sp8870 ves1x93 ttpci_eeprom i2c_core v
ia_rhine mii soundcore crc_ccitt ext3 jbd
CPU:0
EIP:0060:[<e09ed182>]Not tainted VLI
EFLAGS: 00010246   (2.6.15-1.1863_FC5)
EIP is at stradis_probe+0x5ba/0xa81 [stradis]
eax: 00000000   ebx: e09f20e0   ecx: 00000000   edx: df23ccf0
esi: e09f1b2c   edi: e09f2540   ebp: e09f20e0   esp: df074d70
ds: 007b   es: 007b   ss: 0068
Process modprobe (pid: 899, threadinfo=df074000 task=df23ccf0)
Stack: dfcf607c 00000000 00000000 00000001 dead4ead ffffffff ffffffff 00000001 
       dead4ead ffffffff ffffffff 00000001 dead4ead ffffffff ffffffff 00000001
       dead4ead ffffffff ffffffff 00000001 dead4ead ffffffff ffffffff e09f190c
Call Trace:
 [<c02284b0>] __driver_attach+0x0/0x8b [<c57  
 [<c02283fd>] driver_probe_device+0x42/0x8b [<c0228513>] __driver_attach+0x63/0x8b
 [<c0227ef9>] bus_for_each_dev+0x33/0x55     [<c0228361>] driver_attach+0x11/0x13 
 [<c02284b0>] __driver_attach+0x0/0x8b     [<c0227c1a>] bus_add_driver+0x64/0xfd
 [<c01cd709>] __pci_register_driver+0x82/0xa4     [<e09c201a>] stradis_init+0x1a/0x2f [stradis]
 [<c0131c95>] sys_init_module+0x137c/0x150e     [<e09e1000>] ieee80211_crypt_null_init+0x0/0x6 [ieee80211_crypt
 [<c01547df>] do_sync_read+0xb8/0xf3     [<c012a963 x0/0x2d       
 [<c02df797>] __mutex_unlock_slowpath+0x1c3/0x1c8     [<c0154727>] do_sync_read+0x0/0xf3
 [<c01550a9>] vfs_read+0x9f/0x13e     [<c0155410>] sys_read+0x3c/0x63
 [<c0102ba9>] syscall_call+0x7/0xb    <0>Code: c4 10 e9 df 04 00 00 8b 04 24 8b
98 74 01 00 00 31 c0 b9 18 01 00 00 89 df f3 ab c7 83 7c 02 00 00 00 00 00 00 8b
 83 0c 03 00 00 <c7> 80 fc 00 00 00 00 00 ff ff b8 00 f0 ff ff 21 e0 f7 40 14 00


The backtrace is a bit of a mess, but what seems to happen is that we're oopsing
on the saawrite(0xffff0000, SAA7146_MC1)  in init_saa7146
saawrite does a   writel((dat), saa->saa7146_mem+(adr)), and as we've already
dereferenced 'saa' a few lines above, the oops is due to saa7146_mem being NULL
however that should be set up by configure_saa7146, which gets called in stradis_probe()
prior to calling init_saa7146.

*puzzled*.

		Dave

