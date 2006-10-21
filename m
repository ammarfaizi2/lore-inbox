Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992855AbWJUIoF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992855AbWJUIoF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Oct 2006 04:44:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992863AbWJUIoF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Oct 2006 04:44:05 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:18319 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S2992855AbWJUIoB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Oct 2006 04:44:01 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-ID: <4539DDC5.80207@s5r6.in-berlin.de>
Date: Sat, 21 Oct 2006 10:43:49 +0200
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.6) Gecko/20060730 SeaMonkey/1.0.4
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Greg KH <gregkh@suse.de>
Subject: NULL pointer dereference in sysfs_readdir
X-Enigmail-Version: 0.94.1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is a report about lockups and/or(?) oopses while HALD is obviously
traversing sysfs files of FireWire devices, seen under Fedora Core
kernels 2.6.{16,17,18} on an SMP setup:

https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=188140

> May 17 11:49:42 malbec kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000020
> May 17 11:49:42 malbec kernel:  printing eip:
> May 17 11:49:42 malbec kernel: c019797d
> May 17 11:49:42 malbec kernel: *pde = 14924001
> May 17 11:49:42 malbec kernel: Oops: 0000 [#1]
> May 17 11:49:42 malbec kernel: SMP 
> May 17 11:49:42 malbec kernel: last sysfs file: /class/net/eth0/address
> May 17 11:49:42 malbec kernel: Modules linked in: sunrpc xt_limit xt_state ip_conntrack nfnetlink xt_tcpudp iptable_filter ip_tables ip6table_filter ip6_tables x_tables ipv6 dm_multipath lp parport_pc parport floppy nvram ohci1394 ieee1394 uhci_hcd sg ohci_hcd ehci_hcd snd_emu10k1_synth snd_emux_synth snd_seq_virmidi snd_seq_midi_emul snd_emu10k1 snd_ac97_codec snd_ac97_bus snd_usb_audio snd_usb_lib snd_rawmidi snd_seq_dummy snd_seq_oss snd_seq_midi_event i2c_piix4 snd_seq i2c_core snd_pcm_oss snd_mixer_oss snd_pcm snd_seq_device snd_timer snd_page_alloc snd_util_mem emu10k1_gp snd_hwdep gameport snd soundcore e100 mii dm_snapshot dm_zero dm_mirror dm_mod ext3 jbd aic7xxx scsi_transport_spi sd_mod scsi_mod
> May 17 11:49:42 malbec kernel: CPU:    1
> May 17 11:49:42 malbec kernel: EIP:    0060:[<c019797d>]    Not tainted VLI
> May 17 11:49:42 malbec kernel: EFLAGS: 00010282   (2.6.16-1.2111_FC5smp #1) 
> May 17 11:49:42 malbec kernel: EIP is at sysfs_readdir+0x153/0x202
> May 17 11:49:42 malbec kernel: eax: 00000000   ebx: d56cd5a0   ecx: 0000000a   edx: 00000002
> May 17 11:49:42 malbec kernel: esi: e3a2e6fc   edi: e3a2e707   ebp: e2c08b14   esp: d55a7f50
> May 17 11:49:42 malbec kernel: ds: 007b   es: 007b   ss: 0068
> May 17 11:49:42 malbec kernel: Process hald (pid: 2512, threadinfo=d55a7000 task=d8bc7930)
> May 17 11:49:42 malbec kernel: Stack: <0>c0171894 d55a7f98 d4c73e60 e3b28a4c e2c08b18 0000000a c0362f80 d4c73e60 
> May 17 11:49:42 malbec kernel:        e3b2655c e3b265dc c0171a53 d55a7f98 c0171894 fffffff7 09e4f5d4 00000000 
> May 17 11:49:42 malbec kernel:        d4c73e60 c0171ae0 09e4f754 09e4f73c 00000e80 ffffffea 0000000d 09e4f5d4 
> May 17 11:49:42 malbec kernel: Call Trace:
> May 17 11:49:42 malbec kernel:  [<c0171894>] filldir64+0x0/0xc3     [<c0171a53>] vfs_readdir+0x66/0x90
> May 17 11:49:42 malbec kernel:  [<c0171894>] filldir64+0x0/0xc3     [<c0171ae0>] sys_getdents64+0x63/0xa5
> May 17 11:49:42 malbec kernel:  [<c0103db9>] syscall_call+0x7/0xb    <0>Code: 14 00 0f 84 ad 00 00 00 89 e8 e8 b3 e8 ff ff 89 c6 31 c0 83 c9 ff 89 f7 f2 ae f7 d1 49 89 4c 24 14 8b 45 20 85 c0 74 08 8b 40 18 <8b> 50 20 eb 11 ba 02 00 00 00 a1 20 24 48 c0 e8 2e 06 fe ff 89 

A quick look at linux-2.6.19-rc2/fs/sysfs/dir.c::sysfs_readdir shows a
list_move, a traversal through a list, and some accesses to data with no
apparent protection by mutexes.

Is there reason to be worried...?
-- 
Stefan Richter
-=====-=-==- =-=- =-=-=
http://arcgraph.de/sr/
