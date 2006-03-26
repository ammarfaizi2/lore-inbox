Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932162AbWCZXEP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932162AbWCZXEP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Mar 2006 18:04:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932170AbWCZXEP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Mar 2006 18:04:15 -0500
Received: from mail.charite.de ([160.45.207.131]:8125 "EHLO mail.charite.de")
	by vger.kernel.org with ESMTP id S932162AbWCZXED (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Mar 2006 18:04:03 -0500
Date: Mon, 27 Mar 2006 01:03:59 +0200
From: Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>
To: linux-kernel@vger.kernel.org
Subject: Re: kernel BUG at fs/direct-io.c:916!
Message-ID: <20060326230358.GG4776@charite.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20060326230206.06C1EE083AAB@knarzkiste.dyndns.org> <20060326180440.GA4776@charite.de> <20060326184644.GC4776@charite.de> <20060327080811.D753448@wobbly.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060326230206.06C1EE083AAB@knarzkiste.dyndns.org> <20060327080811.D753448@wobbly.melbourne.sgi.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Nathan Scott <nathans@sgi.com>:

> Hmm, there were XFS patches in -mm last week, but they also got
> merged to mainline last week, not clear whether your git kernel
> had those changes or not.  I think there's probably some direct
> I/O (generic) changes in -mm too based on list traffic from the
> last couple of weeks (I'm an -mm lamer, sorry, couldn't easily
> tell you exactly what patches those might be) - could you retry
> with todays git snapshot and see if mainline is affected?  Else
> we'll need to find and analyse any -mm fs/direct-io.c patches.

2.6.16-git12 also fails utterly:

> Mar 27 00:51:55 knarzkiste kernel: ------------[ cut here ]------------
> Mar 27 00:51:55 knarzkiste kernel: kernel BUG at fs/direct-io.c:916!
> Mar 27 00:51:55 knarzkiste kernel: invalid opcode: 0000 [#1]
> Mar 27 00:51:55 knarzkiste kernel: PREEMPT
> Mar 27 00:51:56 knarzkiste kernel: Modules linked in: thermal fan button ac battery af_packet ide_scsi sata_sil libata scsi_mod eeprom powernow_k8 freq_table processor saa7134_dvb mt352 video_buf_dvb dvb_core nxt200x dvb_pll tda1004x usbhid usbmouse tda9887 tuner saa7134 video_buf compat_ioctl32 v4l2_common v4l1_compat ir_kbd_i2c ir_common videodev tsdev pcmcia firmware_class 8250_pci ehci_hcd ohci_hcd evdev 8139too 8250 serial_core psmouse yenta_socket rsrc_nonstatic pcmcia_core ide_cd usbcore ati_agp agpgart snd_atiixp_modem snd_atiixp snd_ac97_codec snd_ac97_bus snd_pcm snd_timer snd soundcore snd_page_alloc cdrom unix
> Mar 27 00:51:56 knarzkiste kernel: CPU:    0
> Mar 27 00:51:56 knarzkiste kernel: EIP:    0060:[__blockdev_direct_IO+3701/3797]    Not tainted VLI
> Mar 27 00:51:56 knarzkiste kernel: EFLAGS: 00210246   (2.6.16-git12 #1)
> Mar 27 00:51:56 knarzkiste kernel: EIP is at __blockdev_direct_IO+0xe75/0xed5
> Mar 27 00:51:56 knarzkiste kernel: eax: 00000008   ebx: dcc7d454   ecx: 00000009   edx: 00000000
> Mar 27 00:51:56 knarzkiste kernel: esi: 00000000   edi: 00000000   ebp: dcc7d400   esp: dd5fec98
> Mar 27 00:51:56 knarzkiste kernel: ds: 007b   es: 007b   ss: 0068
> Mar 27 00:51:56 knarzkiste kernel: Process xfs_fsr (pid: 4828, threadinfo=dd5fe000 task=dd11f560)
> Mar 27 00:51:56 knarzkiste kernel: Stack: <0>00000001 022faf40 0f978067 c0148ebd 007d9200 dcc7d454 d1d00bd0 c01422d6
> Mar 27 00:51:56 knarzkiste kernel:        d1d0099c dd5feef8 00000001 016bf3c0 00000009 00000009 dd61d900 007da000
> Mar 27 00:51:56 knarzkiste kernel:        00000000 00000000 00000000 00000000 00000009 00200286 00000008 00000000
> Mar 27 00:51:56 knarzkiste kernel: Call Trace:
> Mar 27 00:51:56 knarzkiste kernel:  <c0148ebd> __handle_mm_fault+0x77d/0x850   <c01422d6> __do_page_cache_readahead+0xc6/0x290
> Mar 27 00:51:56 knarzkiste kernel:  <c01f3baa> xfs_vm_direct_IO+0xda/0x100   <c01f3fe0> xfs_get_blocks_direct+0x0/0x50
> Mar 27 00:51:56 knarzkiste kernel:  <c01f3710> xfs_end_io_direct+0x0/0x90   <c0173019> touch_atime+0x59/0xc0
> Mar 27 00:51:56 knarzkiste kernel:  <c013bc87> generic_file_direct_IO+0x87/0x130   <c013bda0> generic_file_direct_write+0x70/0x1b0
> Mar 27 00:51:56 knarzkiste kernel:  <c0172f49> file_update_time+0x39/0xb0   <c01fbda6> xfs_write+0x4a6/0xd40
> Mar 27 00:51:56 knarzkiste kernel:  <c013b3b0> file_read_actor+0x0/0xe0   <c01f7d27> xfs_file_aio_write+0x87/0xb0
> Mar 27 00:51:56 knarzkiste kernel:  <c01596f4> do_sync_write+0xc4/0x120   <c01591d4> generic_file_llseek+0x34/0xe0
> Mar 27 00:51:56 knarzkiste kernel:  <c012de90> autoremove_wake_function+0x0/0x50   <c0205826> crypt+0x136/0x210
> Mar 27 00:51:56 knarzkiste kernel:  <c01f7eb5> xfs_file_ioctl+0x35/0x70   <c0159c03> vfs_write+0xa3/0x160
> Mar 27 00:51:56 knarzkiste kernel:  <c0159630> do_sync_write+0x0/0x120   <c015a5b1> sys_write+0x41/0x70
> Mar 27 00:51:56 knarzkiste kernel:  <c0102e93> sysenter_past_esp+0x54/0x75
> Mar 27 00:51:56 knarzkiste kernel: Code: ff ff 8b 84 24 80 00 00 00 bb f1 ff ff ff e8 23 39 fc ff 8b 75 2c 8b 55 34 e9 65 f8 ff ff e8 83 32 17 00 8d 76 00 e9 e4 f9 ff ff <0f> 0b 94 03 1a a5 30 c0 8d 76 00 e9 dd fb ff ff e8 66 32 17 00

-- 
Ralf Hildebrandt (i.A. des IT-Zentrums)         Ralf.Hildebrandt@charite.de
Charite - Universitätsmedizin Berlin            Tel.  +49 (0)30-450 570-155
Gemeinsame Einrichtung von FU- und HU-Berlin    Fax.  +49 (0)30-450 570-962
IT-Zentrum Standort CBF                 send no mail to spamtrap@charite.de
