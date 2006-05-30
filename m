Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932326AbWE3Q5J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932326AbWE3Q5J (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 12:57:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932330AbWE3Q5I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 12:57:08 -0400
Received: from mx1.redhat.com ([66.187.233.31]:53481 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932326AbWE3Q5H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 12:57:07 -0400
Date: Tue, 30 May 2006 12:56:49 -0400
From: Dave Jones <davej@redhat.com>
To: Jens Axboe <axboe@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: .17rc5 cfq slab corruption.
Message-ID: <20060530165649.GB17218@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>, Jens Axboe <axboe@suse.de>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20060526213915.GB7585@redhat.com> <20060526170013.67391a2b.akpm@osdl.org> <20060527070724.GB24988@suse.de> <20060527133122.GB3086@redhat.com> <20060530131728.GX4199@suse.de> <20060530161232.GA17218@redhat.com> <20060530164917.GB4199@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060530164917.GB4199@suse.de>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 30, 2006 at 06:49:18PM +0200, Jens Axboe wrote:

 > > List corruption. next->prev should be f74a5e2c, but was ea7ed31c
 > > Pointing at cfq_set_request.
 > 
 > I think I'm missing a piece of this - what list was corrupted, in what
 > function did it trigger?

If you look at the attachment in the bugzilla url in my previous msg,
you'll see this:

ay 30 05:31:33 mandril kernel: List corruption. next->prev should be f74a5e2c, but was ea7ed31c
May 30 05:31:33 mandril kernel: ------------[ cut here ]------------
May 30 05:31:33 mandril kernel: kernel BUG at include/linux/list.h:58!
May 30 05:31:33 mandril kernel: invalid opcode: 0000 [#1]
May 30 05:31:33 mandril kernel: SMP
May 30 05:31:33 mandril kernel: last sysfs file: /devices/pci0000:00/0000:00:1f.3/i2c-0/0-002e/pwm3
May 30 05:31:33 mandril kernel: Modules linked in: iptable_filter ipt_DSCP iptable_mangle ip_tables x_tables eeprom lm85 hwmon_vid hwmon i2c_isa ipv6 nls_utf8 loop dm_mirror dm_mod video button battery ac lp parport_pc parport ehci_hcd uhci_hcd floppy snd_intel8x0 snd_ac97_codec snd_ac97_bus sg snd_seq_dummy matroxfb_base snd_seq_oss snd_seq_midi_event matroxfb_DAC1064 snd_seq matroxfb_accel matroxfb_Ti3026 3w_9xxx matroxfb_g450 snd_seq_device g450_pll matroxfb_misc snd_pcm_oss snd_mixer_oss snd_pcm snd_timer snd e1000 soundcore snd_page_alloc i2c_i801 i2c_core ext3 jbd 3w_xxxx ata_piix libata sd_mod scsi_mod
May 30 05:31:33 mandril kernel: CPU:    0
May 30 05:31:33 mandril kernel: EIP:    0060:[<c04e3310>]    Not tainted VLI
May 30 05:31:33 mandril kernel: EFLAGS: 00210292   (2.6.16-1.2227_FC6 #1)
May 30 05:31:33 mandril kernel: EIP is at cfq_set_request+0x202/0x3ff
May 30 05:31:33 mandril kernel: eax: 00000044   ebx: f605af58   ecx: c06c77d0   edx: 00200282
May 30 05:31:33 mandril kernel: esi: f4c31d58   edi: f74a5e2c   ebp: f4c31da8   esp: c57c1abc
May 30 05:31:33 mandril kernel: ds: 007b   es: 007b   ss: 0068
May 30 05:31:33 mandril kernel: Process httpd (pid: 30323, threadinfo=c57c1000 task=f1bf4550)
May 30 05:31:33 mandril kernel: Stack: c0624ac7 f74a5e2c ea7ed31c d0c71c34 f74cb25c f74a5d04 f1bf4550 00000000
May 30 05:31:33 mandril kernel:        00007673 f3822398 00000000 c04e310e f74cb25c d0c71c34 f74cb26c c04d7342
May 30 05:31:33 mandril kernel:        00000010 f74cb25c 00000000 c04d9da8 00000010 d954b84c c046ca2b 0142781d
May 30 05:31:33 mandril kernel: Call Trace:
May 30 05:31:33 mandril kernel:  <c04e310e> cfq_set_request+0x0/0x3ff  <c04d7342> elv_set_request+0x1e/0x2d
May 30 05:31:33 mandril kernel:  <c04d9da8> get_request+0x164/0x31d  <c046ca2b> __find_get_block+0x161/0x16b
May 30 05:31:33 mandril kernel:  <c04da58e> get_request_wait+0x1b/0x15e  <c046ca6e> __getblk+0x39/0x257
May 30 05:31:33 mandril kernel:  <c04dbeeb> __make_request+0x322/0x3cb  <c0465b7a> cache_alloc_debugcheck_after+0x134/0x13e
May 30 05:31:33 mandril kernel:  <f8951626> ext3_get_blocks_handle+0x921/0x954 [ext3]  <c04d96f6> generic_make_request+0x2b7/0x2c7
May 30 05:31:33 mandril kernel:  <c046c6f9> __find_get_block_slow+0x11c/0x128  <c0465b7a> cache_alloc_debugcheck_after+0x134/0x13e
May 30 05:31:33 mandril kernel:  <c046ca2b> __find_get_block+0x161/0x16b  <c0465b13> cache_alloc_debugcheck_after+0xcd/0x13e
May 30 05:31:33 mandril kernel:  <c044ec05> mempool_alloc+0x37/0xd3  <c04db30c> submit_bio+0xb7/0xbe
May 30 05:31:33 mandril kernel:  <c044ec05> mempool_alloc+0x37/0xd3  <f8951774> ext3_getblk+0x11b/0x2a6 [ext3]
May 30 05:31:33 mandril kernel:  <c046f5f2> bio_alloc_bioset+0x9b/0xf3  <c046c3da> submit_bh+0xe4/0x102
May 30 05:31:33 mandril kernel:  <c046d3d5> ll_rw_block+0x8d/0xa9  <f89527a3> ext3_bread+0x39/0x83 [ext3]
May 30 05:31:33 mandril kernel:  <f895571c> ext3_find_entry+0x174/0x58d [ext3]  <c0406470> do_IRQ+0x79/0x84
May 30 05:31:33 mandril kernel:  <c040485e> common_interrupt+0x1a/0x20  <c04390ef> debug_mutex_add_waiter+0x97/0xa9
May 30 05:31:33 mandril kernel:  <c047fd1e> d_alloc+0x4b/0x206  <f8956f38> ext3_lookup+0x21/0x77 [ext3]
May 30 05:31:33 mandril kernel:  <c0476e95> do_lookup+0xb2/0x14d  <c0478c03> __link_path_walk+0x894/0xd31
May 30 05:31:33 mandril kernel:  <c04790e9> link_path_walk+0x49/0xbd  <c0435994> autoremove_wake_function+0x0/0x35
May 30 05:31:33 mandril kernel:  <c0479484> do_path_lookup+0x1e3/0x251  <c047823b> getname+0x91/0x98
May 30 05:31:33 mandril kernel:  <c0479c7d> __user_walk_fd+0x2f/0x40  <c04736ab> vfs_stat_fd+0x19/0x40
May 30 05:31:33 mandril kernel:  <c0435994> autoremove_wake_function+0x0/0x35  <c047375f> sys_stat64+0xf/0x23
May 30 05:31:33 mandril kernel:  <c0406470> do_IRQ+0x79/0x84  <c0403e1f> syscall_call+0x7/0xb
May 30 05:31:33 mandril kernel: Code: 8b 7c 24 14 8b 98 28 01 00 00 81 c7 28 01 00 00 8b 43 04 39 f8 74 46 89 7c 24 04 89 44 24 08 c7 04 24 c7 4a 62 c0 e8 44 1e f4 ff <0f>
0b 3a 00 b2 4a 62 c0 8b 54 24 14 8b 82 28 01 00 00 39 d8 74

Not sure which list is being pointed at. I'll see if I can decipher
more after lunch.

		Dave

-- 
http://www.codemonkey.org.uk
