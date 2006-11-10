Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946236AbWKJMdv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946236AbWKJMdv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 07:33:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946528AbWKJMdv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 07:33:51 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:44933 "EHLO
	out1.smtp.messagingengine.com") by vger.kernel.org with ESMTP
	id S1946236AbWKJMdu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 07:33:50 -0500
X-Sasl-enc: 1gD3osQ2cExdC+yBxG6/SUW08Xa/IpsL0wbok/f4r9T1 1163162029
Subject: [2.4.19-rc4 and 2.4.19-rc4-mm2] super block list corruption
	following fill_super returns fail
From: Ian Kent <raven@themaw.net>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>
Content-Type: text/plain
Date: Fri, 10 Nov 2006 20:33:42 +0800
Message-Id: <1163162022.10725.13.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi all,

I'm seeing an oops after returning a fail status from the autofs and
autofs4 fill_super methods. The scenario is a little contrived but does
demonstrate the mount fail case.

get_super+0x78 corresponds to:

                        down_read(&sb->s_umount);
---->                   if (sb->s_root)
                                return sb;
                        up_read(&sb->s_umount);

So I believe that, following the fill_super call in get_sb_nodev the
super block is freed during the call to deactivate_super but not removed
from the supers list.

As far as I can tell I've done the appropriate housekeeping in the
autofs[4] fill_super function. In particular, sb->s_root is not set upon
mount fail.

Does anyone have any suggestions as to what I might not be doing that I
should be doing that is preventing this removal? 


Nov 10 19:56:15 raven kernel: autofs: kernel does not match daemon version daemon (6, 6) kernel (3, 5)
Nov 10 19:56:16 raven kernel: general protection fault: 0000 [1] SMP 
Nov 10 19:56:16 raven kernel: CPU 0 
Nov 10 19:56:16 raven kernel: Modules linked in: autofs4 ppdev ipv6 hidp rfcomm l2cap bluetooth sunrpc pwc compat_ioctl32 videodev v4l1_compat v4l2_common snd_usb_audio snd_usb_lib visor usblp usbserial dm_mirror dm_mod video button battery asus_acpi ac lp parport_pc parport ehci_hcd uhci_hcd floppy snd_emu10k1_synth snd_emux_synth snd_seq_virmidi snd_seq_midi_emul snd_emu10k1 snd_rawmidi snd_ac97_codec snd_ac97_bus snd_seq_dummy snd_seq_oss snd_seq_midi_event snd_seq snd_pcm_oss snd_mixer_oss snd_pcm snd_seq_device snd_timer snd_page_alloc snd_util_mem nvidia(P) snd_hwdep snd emu10k1_gp gameport soundcore via_rhine mii pcspkr i2c_viapro i2c_core ext3 jbd
Nov 10 19:56:16 raven kernel: Pid: 2513, comm: hald-addon-stor Tainted: P      2.6.19-rc4 #1
Nov 10 19:56:16 raven kernel: RIP: 0010:[<ffffffff802ce181>]  [<ffffffff802ce181>] get_super+0x78/0x9d
Nov 10 19:56:16 raven kernel: RSP: 0018:ffff81002ac219c8  EFLAGS: 00010203
Nov 10 19:56:16 raven kernel: RAX: 6b6b6b6b6b6b6b6b RBX: 6b6b6b6b6b6b6b6b RCX: 00000000c82093fe
Nov 10 19:56:16 raven kernel: RDX: 0000000000000080 RSI: 0000000000000286 RDI: ffffffff804f8fd0
Nov 10 19:56:16 raven kernel: RBP: ffff81003bf14248 R08: ffff810037dc8ed8 R09: 0000000000000000
Nov 10 19:56:16 raven kernel: R10: ffffffff80824048 R11: ffffffff80212bce R12: ffff81003bf14248
Nov 10 19:56:16 raven kernel: R13: ffff81001ed31070 R14: ffff81003bf14368 R15: ffff81003ab1b268
Nov 10 19:56:16 raven kernel: FS:  00002add6e7c7780(0000) GS:ffffffff8058c000(0000) knlGS:00000000f7dfcab0
Nov 10 19:56:16 raven kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
Nov 10 19:56:16 raven kernel: CR2: 0000000000972000 CR3: 000000002b371000 CR4: 00000000000006e0
Nov 10 19:56:16 raven kernel: Process hald-addon-stor (pid: 2513, threadinfo ffff81002ac20000, task ffff81002b9c77e0)
Nov 10 19:56:16 raven kernel: Stack:  ffff81003bf14248 ffff81003bf14248 0000000000000000 ffffffff80257522
Nov 10 19:56:16 raven kernel:  ffff81003bf14248 ffffffff805247a0 ffff810037d576d0 ffffffff802dfac1
Nov 10 19:56:16 raven kernel:  0000000000000000 0000000000000000 ffff810037d57890 ffffffff803c4d0a
Nov 10 19:56:16 raven kernel: Call Trace:
Nov 10 19:56:16 raven kernel:  [<ffffffff80257522>] __invalidate_device+0xf/0x44
Nov 10 19:56:16 raven kernel:  [<ffffffff802dfac1>] check_disk_change+0x2b/0x76
Nov 10 19:56:16 raven kernel:  [<ffffffff803c4d0a>] cdrom_open+0x92c/0x979
Nov 10 19:56:16 raven kernel:  [<ffffffff802640da>] __reacquire_kernel_lock+0x3d/0x5b
Nov 10 19:56:16 raven kernel:  [<ffffffff80261f43>] thread_return+0xc6/0x100
Nov 10 19:56:16 raven kernel:  [<ffffffff803bf949>] cdrom_do_pc_continuation+0x0/0x2b
Nov 10 19:56:16 raven kernel:  [<ffffffff8022d13b>] cdrom_start_packet_command+0x14f/0x15a
Nov 10 19:56:16 raven kernel:  [<ffffffff8026300d>] __mutex_lock_slowpath+0x1dc/0x1e7
Nov 10 19:56:16 raven kernel:  [<ffffffff8026300d>] __mutex_lock_slowpath+0x1dc/0x1e7
Nov 10 19:56:16 raven kernel:  [<ffffffff803bd7b2>] idecd_open+0x9f/0xd1
Nov 10 19:56:16 raven kernel:  [<ffffffff802e0702>] blkdev_open+0x0/0x5d
Nov 10 19:56:16 raven kernel:  [<ffffffff802e0702>] blkdev_open+0x0/0x5d
Nov 10 19:56:16 raven kernel:  [<ffffffff802e0196>] do_open+0xb2/0x3b6
Nov 10 19:56:16 raven kernel:  [<ffffffff8020ca9b>] dput+0x3d/0x172
Nov 10 19:56:16 raven kernel:  [<ffffffff80209e61>] __link_path_walk+0xca9/0xe04
Nov 10 19:56:16 raven kernel:  [<ffffffff8022beb3>] mntput_no_expire+0x19/0x92
Nov 10 19:56:16 raven kernel:  [<ffffffff8020e289>] link_path_walk+0xd3/0xe5
Nov 10 19:56:16 raven kernel:  [<ffffffff8020beae>] cache_alloc_debugcheck_after+0x123/0x1a0
Nov 10 19:56:16 raven kernel:  [<ffffffff80215522>] get_unused_fd+0xf9/0x107
Nov 10 19:56:16 raven kernel:  [<ffffffff8029135a>] __capable+0xe/0x22
Nov 10 19:56:16 raven kernel:  [<ffffffff8020f03c>] generic_permission+0x97/0xd3
Nov 10 19:56:16 raven kernel:  [<ffffffff8020d07d>] permission+0x93/0xce
Nov 10 19:56:16 raven kernel:  [<ffffffff802119b4>] may_open+0x58/0x22f
Nov 10 19:56:16 raven kernel:  [<ffffffff802e0702>] blkdev_open+0x0/0x5d
Nov 10 19:56:16 raven kernel:  [<ffffffff802e0730>] blkdev_open+0x2e/0x5d
Nov 10 19:56:16 raven kernel:  [<ffffffff8021dc5b>] __dentry_open+0xd9/0x1df
Nov 10 19:56:16 raven kernel:  [<ffffffff80226cee>] do_filp_open+0x2d/0x3d
Nov 10 19:56:16 raven kernel:  [<ffffffff8020beae>] cache_alloc_debugcheck_after+0x123/0x1a0
Nov 10 19:56:16 raven kernel:  [<ffffffff80215522>] get_unused_fd+0xf9/0x107
Nov 10 19:56:16 raven kernel:  [<ffffffff80219418>] do_sys_open+0x44/0xbe
Nov 10 19:56:16 raven kernel:  [<ffffffff8025d11e>] system_call+0x7e/0x83
Nov 10 19:56:16 raven kernel: 
Nov 10 19:56:16 raven kernel: 
Nov 10 19:56:16 raven kernel: Code: 48 8b 03 0f 18 08 48 81 fb c0 8f 4f 80 75 a0 48 c7 c7 d0 8f 
Nov 10 19:56:16 raven kernel: RIP  [<ffffffff802ce181>] get_super+0x78/0x9d
Nov 10 19:56:16 raven kernel:  RSP <ffff81002ac219c8>


