Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161341AbWGJGZj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161341AbWGJGZj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 02:25:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161342AbWGJGZj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 02:25:39 -0400
Received: from mail.gmx.net ([213.165.64.21]:25245 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1161341AbWGJGZj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 02:25:39 -0400
X-Authenticated: #14349625
Subject: 2.6.18-rc1: slab BUG_ON(!PageSlab(page)) upon umount after failed
	suspend
From: Mike Galbraith <efault@gmx.de>
To: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20060709161712.c6d2aecb.akpm@osdl.org>
References: <6wDCq-5xj-25@gated-at.bofh.it> <6wM2X-1lt-7@gated-at.bofh.it>
	 <6wOxP-4QN-5@gated-at.bofh.it> <44B189D3.4090303@imap.cc>
	 <20060709161712.c6d2aecb.akpm@osdl.org>
Content-Type: text/plain
Date: Mon, 10 Jul 2006 08:31:08 +0200
Message-Id: <1152513068.7748.13.camel@Homer.TheSimpsons.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

While trying to figure out what happened to break suspend to disk on my
box, and booting between various other kernels to compare messages, I
accidentally captured the following during shutdown.  I have no idea if
failed suspends have anything to do with it, but it may, because I
haven't had this happen in any other circumstance.  I'm making a rash
presumption that the two or three other times the box has died on
shutdown (without serial console being connected) were the same.

kernel BUG at <bad filename>:45803! <-- what goeth on here.  it's slab.c:1542
invalid opcode: 0000 [#1]
PREEMPT SMP 
Modules linked in: ohci1394 prism54 xt_pkttype ipt_LOG xt_limit snd_pcm_oss snd_mixer_oss snd_seq snd_seq_device snd_intel8x0 snd_ac97_codec edd snd_ac97_bus snd_pcm snd_timer ieee1394 saa7134 snd soundcore ir_kbd_i2c bt878 snd_page_alloc i2c_i801 ip6t_REJECT xt_tcpudp ipt_REJECT xt_state iptable_mangle iptable_nat ip_nat iptable_filter ip6table_mangle ip_conntrack nfnetlink ip_tables ip6table_filter ip6_tables x_tables tuner bttv video_buf firmware_class ir_common btcx_risc tveeprom sd_mod nls_iso8859_1 nls_cp437 nls_utf8
CPU:    1
EIP:    0060:[<b1068d9f>]    Not tainted VLI
EFLAGS: 00010046   (2.6.18-rc1-smp #163) 
EIP is at kmem_freepages+0xa1/0xa5
eax: 80040000   ebx: b18327e0   ecx: fffffff8   edx: 00000000
esi: 00000001   edi: dfeacbc0   ebp: b23cddbc   esp: b23cddac
ds: 007b   es: 007b   ss: 0068
Process umount (pid: 11083, ti=b23cd000 task=dffa4aa0 task.ti=b23cd000)
Stack: bfebfbfd dfeacbc0 b1594000 b1594000 b23cddd4 b1069002 bfebfbfd dfec36a4 
       b1594000 dfeacbc0 b23cddf8 b106914d 00000000 0000001b dfea22d8 00000019 
       ef2de7bc dfeacbc0 dfec36a4 b23cde34 b1068e29 00000000 dfea22c0 dfea22d8 
Call Trace:
 [<b1069002>] slab_destroy+0x53/0x95
 [<b106914d>] free_block+0x109/0x128
 [<b1068e29>] __cache_free+0x86/0x10d
 [<b1068f6f>] kmem_cache_free+0x37/0x4a
 [<b1068655>] shmem_destroy_inode+0x10/0x12
 [<b108579c>] destroy_inode+0x31/0x47
 [<b1085b17>] generic_delete_inode+0xcb/0x11c
 [<b108552f>] iput+0x5f/0x66
 [<b108389e>] dentry_iput+0x6b/0xb1
 [<b1084490>] prune_one_dentry+0x57/0x7a
 [<b10846f6>] prune_dcache+0x144/0x157
 [<b10847fc>] shrink_dcache_parent+0xb4/0xe8
 [<b107399b>] generic_shutdown_super+0x27/0x131
 [<b1073ae9>] kill_anon_super+0x12/0x35
 [<b1073b25>] kill_litter_super+0x19/0x1c
 [<b1073b85>] deactivate_super+0x5d/0x6f
 [<b10883d6>] mntput_no_expire+0x44/0x74
 [<b1079f9f>] path_release_on_umount+0x15/0x18
 [<b108948c>] sys_umount+0x3b/0x265
 [<b10896cf>] sys_oldumount+0x19/0x1b
 [<b10030b7>] syscall_call+0x7/0xb
 [<a7e8d73d>] 0xa7e8d73d
Code: 30 8b 57 3c 8b 45 f0 e8 d5 ac fe ff f6 47 36 02 74 11 8b 4f 3c b8 01 00 00 00 d3 e0 f0 29 05 14 ad 5f b1 83 c4 04 5b 5e 5f 5d c3 <0f> 0b eb b2 55 89 e5 57 56 53 83 ec 28 89 c6 89 d3 89 e0 25 00 
EIP: [<b1068d9f>] kmem_freepages+0xa1/0xa5 SS:ESP 0068:b23cddac


