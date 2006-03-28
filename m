Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751221AbWC1D2w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751221AbWC1D2w (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Mar 2006 22:28:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751222AbWC1D2w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Mar 2006 22:28:52 -0500
Received: from smtp.osdl.org ([65.172.181.4]:35811 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751221AbWC1D2v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Mar 2006 22:28:51 -0500
Date: Mon, 27 Mar 2006 19:28:30 -0800
From: Andrew Morton <akpm@osdl.org>
To: Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>
Cc: linux-kernel@vger.kernel.org, fridtjof@fbunet.de,
       Neil Brown <neilb@suse.de>
Subject: Re: kernel BUG at fs/buffer.c:2790!
Message-Id: <20060327192830.355f184f.akpm@osdl.org>
In-Reply-To: <20060327213429.GK19434@charite.de>
References: <20060327213429.GK19434@charite.de>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ralf Hildebrandt <Ralf.Hildebrandt@charite.de> wrote:
>
> This happens when umount'ing an intact softraid-5 with vanila 2.6.16.
> 
>  ------------[ cut here ]------------
>  kernel BUG at fs/buffer.c:2790!
>  invalid opcode: 0000 [#1]
>  PREEMPT
>  Modules linked in: sata_sil vmnet vmmon snd_seq_oss snd_seq_midi snd_seq_midi_event snd_seq snd_via82xx snd_ac97_codec snd_ac97_bus snd_pcm_oss snd_mixer_oss snd_pcm snd_timer snd_page_alloc snd_mpu401_uart snd_rawmidi snd_seq_device snd soundcore sk98lin
>  CPU:    0
>  EIP:    0060:[<b015fda9>]    Tainted: P      VLI

Can you confirm that an untainted kernel does the same thing?

>  EFLAGS: 00010246   (2.6.16 #1)
>  EIP is at submit_bh+0x109/0x130
>  eax: 00000005   ebx: d5e0ed54   ecx: 00000001   edx: 0000002b
>  esi: c9a0e000   edi: 00000001   ebp: 000040cd   esp: be715cb8
>  ds: 007b   es: 007b   ss: 0068
>  Process umount (pid: 7011, threadinfo=be714000 task=e0be3ab0)
>  Stack: <0>b13341c0 eeacc160 d5e0ed54 c9a0e000 ed772960 b015fe12 00000001 d5e0ed54
>         ed772960 c9a0e000 ed772960 c9a0e000 b01b3da1 d5e0ed54 be714000 ef2d8ae0
>         d5e0ed54 be714000 00000a61 b01b25f0 ed772960 00000001 b03b8bf6 0000032a
>  Call Trace:
>   [<b015fe12>] sync_dirty_buffer+0x42/0xe0
>   [<b01b3da1>] journal_update_superblock+0xc1/0xe0
>   [<b01b25f0>] cleanup_journal_tail+0xc0/0x190
>   [<b03b8bf6>] preempt_schedule_irq+0x46/0x70
>   [<b01b2914>] log_do_checkpoint+0x24/0x490
>   [<b0142ac2>] __pagevec_free+0x32/0x50
>   [<b0144963>] release_pages+0x33/0x220
>   [<b03b87c5>] schedule+0x315/0x640
>   [<b03b8c6d>] preempt_schedule+0x4d/0x60
>   [<b012e22f>] autoremove_wake_function+0x2f/0x60
>   [<b01b4e5b>] journal_destroy+0x12b/0x2c0
>   [<b0178cc2>] dispose_list+0x82/0x120
>   [<b01a767a>] ext3_put_super+0x2a/0x1f0
>   [<b01790b3>] invalidate_inodes+0xd3/0x110

We've lost BH_mapped on journal->j_sb_buffer.  it's a buffer_head against
the backing blockdev's pagecache.  JBD holds a ref on the buffer_head,
which should protect it from, say, invalidate_inode_pages().

If raid5 is doing something to kill the mapped bit in this bh, it must have
been very clever about it.
