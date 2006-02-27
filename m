Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751649AbWB0Hmj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751649AbWB0Hmj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 02:42:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751612AbWB0Hmj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 02:42:39 -0500
Received: from mx1.redhat.com ([66.187.233.31]:48048 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751649AbWB0Hmi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 02:42:38 -0500
Date: Mon, 27 Feb 2006 02:42:11 -0500
From: Dave Jones <davej@redhat.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.6.16-rc5
Message-ID: <20060227074211.GB15638@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linus Torvalds <torvalds@osdl.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.64.0602262122000.22647@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0602262122000.22647@g5.osdl.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 26, 2006 at 09:27:28PM -0800, Linus Torvalds wrote:
 > 
 > The tar-ball is being uploaded right now, and everything else should 
 > already be pushed out. Mirroring might take a while, of course.
 > 
 > There's not much to say about this: people have been pretty good, and it's 
 > just a random collection of fixes in various random areas. The shortlog is 
 > actually pretty short, and it really describes the updates better than 
 > anything else.
 > 
 > Have I missed anything? Holler. And please keep reminding about any 
 > regressions since 2.6.15.

Those brave Fedora-rawhide testers have also hit an assortment of slab
related errors recently, manifesting in various ways including our old
friend the negative page_mapcount.

(From a 2.6.16rc4-git6 based kernel ...)
https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=182593

Unable to handle kernel paging request at virtual address 6363665f
 printing eip:
00800000
*pde = 6b6b6b6b
Oops: 0000 [#1]
SMP
last sysfs file: /block/hda/hda1/size
Modules linked in: ppdev autofs4 sunrpc ip_conntrack_netbios_ns ipt_REJECT
xt_state ip_conntrack nfnetlink xt_tcpudp iptable_filter ip_tables x_tables
video button battery ac ipv6 lp parport_pc parport floppy nvram sg sd_mod
usb_storage scsi_mod ehci_hcd uhci_hcd natsemi snd_intel8x0 snd_ac97_codec
snd_ac97_bus snd_seq_dummy snd_seq_oss snd_seq_midi_event snd_seq snd_seq_device
snd_pcm_oss snd_mixer_oss snd_pcm snd_timer snd hw_random i2c_i801 soundcore
i2c_core snd_page_alloc dm_snapshot dm_zero dm_mirror dm_mod ext3 jbd
CPU:    1
EIP:    0060:[<00800000>]    Not tainted VLI
EFLAGS: 00210292   (2.6.15-1.1975_FC5smp #1)
EIP is at 0x800000
eax: 00000000   ebx: f7db2200   ecx: f0a6df5c   edx: 00000010
esi: f7db2030   edi: f14e5004   ebp: 00000000   esp: f0a6dfa8
ds: 007b   es: 007b   ss: 0068
Process gnome-settings- (pid: 2565, threadinfo=f0a6d000 task=f1e23290)
Stack: <0>00000001 00000003 bff1f7f4 08966978 c0103d39 00000003 0000541b bff1f7f4
       bff1f7f4 08966978 bff1f7a8 ffffffda c010007b 0000007b 00000036 001a5402
       00000073 00200216 bff1f784 0000007b 00000000 00000000
Call Trace:
 [<c0103d39>] syscall_call+0x7/0xb    <0>Code:  Bad EIP value.


kernel: slab error in cache_free_debugcheck(): cache `size-32': double free, or memory outside object was overwritten
kernel:  [<c015fbc4>] cache_free_debugcheck+0xce/0x1b9    [<c0160b79>] free_block+0x141/0x17d
kernel:  [<c0161619>] kmem_cache_free+0x2a/0x5c    [<c0160b79>] free_block+0x141/0x17d
kernel:  [<c0160c24>] drain_array_locked+0x6f/0x90    [<c0160cb9>] cache_reap+0x74/0x29c
kernel:  [<c0131108>] run_workqueue+0x7f/0xba    [<c0160c45>] cache_reap+0x0/0x29c
kernel:  [<c01318f5>] worker_thread+0x0/0x117    [<c01319db>] worker_thread+0xe6/0x117
kernel:  [<c011d6ab>] default_wake_function+0x0/0xc    [<c0134149>] kthread+0x9d/0xc9
kernel:  [<c01340ac>] kthread+0x0/0xc9     [<c0102005>]kernel_thread_helper+0x5/0xb
kernel: ee9979ac: redzone 1: 0x160fc2a5, redzone 2: 0x170fc2a5.
kernel: Eeek! page_mapcount(page) went negative! (-1)
kernel:   page->flags = c001006c
kernel:   page->count = 1
kernel:   page->mapping = f68f1c00
kernel: ------------[ cut here ]------------
kernel: kernel BUG at mm/rmap.c:555!



There's a bunch more reports of slab related problems, but they're mostly against
kernels from a few weeks back, I'm trying to weed through them and get them
retested on current builds.

		Dave


