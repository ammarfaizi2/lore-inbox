Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750748AbWFFVhK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750748AbWFFVhK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 17:37:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750864AbWFFVhK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 17:37:10 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:16779 "EHLO smtp1-g19.free.fr")
	by vger.kernel.org with ESMTP id S1750748AbWFFVhJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 17:37:09 -0400
Message-ID: <4485F5E2.5040708@free.fr>
Date: Tue, 06 Jun 2006 23:38:42 +0200
From: Laurent Riffard <laurent.riffard@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.8.0.1) Gecko/20060130 SeaMonkey/1.0
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: "Barry K. Nathan" <barryn@pobox.com>, Andrew Morton <akpm@osdl.org>,
       76306.1226@compuserve.com, linux-kernel@vger.kernel.org,
       jbeulich@novell.com, Arjan van de Ven <arjan@linux.intel.com>
Subject: Re: 2.6.17-rc5-mm1
References: <200606042101_MC3-1-C19B-1CF4@compuserve.com> <20060604181002.57ca89df.akpm@osdl.org> <44840838.7030802@free.fr> <4484584D.4070108@free.fr> <20060605110046.2a7db23f.akpm@osdl.org> <986ed62e0606051452x320cce2ap9598558b5343ae6b@mail.gmail.com> <20060606072628.GA28752@elte.hu> <4485E0D3.8080708@free.fr> <20060606205801.GC17787@elte.hu>
In-Reply-To: <20060606205801.GC17787@elte.hu>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Le 06.06.2006 22:58, Ingo Molnar a écrit :
> * Laurent Riffard <laurent.riffard@free.fr> wrote:
> 
>> Results:
>> - 2.6.17-rc4-mm3 with 4K stack works fine (this is the latest good 4K-kernel).
>> - 2.6.17-rc5-mm3 with 4K stack crashes, the stack seems to be corrupted.
> 
> that's vanilla mm3, or mm3 patched with extra lockdep patches? If it's 
> patched then you should try vanilla mm3 too.

It was vanilla mm3.
 
>> - 2.6.17-rc5-mm3 with 8K stack works fine.
>> - 2.6.17-rc5-mm3-lockdep with 8k stack works fine, although it exhibits high 
>> stack usage while running pktsetup.
> 
> is the log you sent the highest footprint that my DEBUG_STACKOVERFLOW 
> tracer detects?

No, I managed to trigger higher footprint while mounting a packet-formatted
DVD. I didn't sent it because:
- this operation (mounting a packet-formatted DVD) wasn't part of my crash scenario.
- It wasn't a *vanilla* 2.6.17-rc5-mm3-lockdep as I started to hack driver/block/pktcdvd.c 
to reduce stack usage (changing stack allocation to kmalloc in pkt_generic_packet() 
and in pkt_get_max_speed()). 

FYI, here is the highest footprint I got: 

Jun  5 21:27:12 antares kernel: ----------------------------->
Jun  5 21:27:12 antares kernel: | new stack fill maximum: mount/26318, 5484 bytes (out of 8136 bytes).
Jun  5 21:27:12 antares kernel: | Stack fill ratio: 67%% - that's still OK, no need to report this.
Jun  5 21:27:12 antares kernel: ------------|
Jun  5 21:27:12 antares kernel: {   20} [debug_stackoverflow+128/174] debug_stackoverflow+0x80/0xae
Jun  5 21:27:12 antares kernel: {   20} [<c013ba14>] debug_stackoverflow+0x80/0xae
Jun  5 21:27:12 antares kernel: {   28} [__mcount+42/151] __mcount+0x2a/0x97
Jun  5 21:27:12 antares kernel: {   28} [<c013cbb6>] __mcount+0x2a/0x97
Jun  5 21:27:12 antares kernel: {   20} [mcount+20/24] mcount+0x14/0x18
Jun  5 21:27:12 antares kernel: {   20} [<c010e434>] mcount+0x14/0x18
Jun  5 21:27:12 antares kernel: {   36} [__lockdep_acquire+14/2358] __lockdep_acquire+0xe/0x936
Jun  5 21:27:12 antares kernel: {   36} [<c012f299>] __lockdep_acquire+0xe/0x936
Jun  5 21:27:12 antares kernel: {   40} [lockdep_acquire+80/104] lockdep_acquire+0x50/0x68
Jun  5 21:27:12 antares kernel: {   40} [<c012fc11>] lockdep_acquire+0x50/0x68
Jun  5 21:27:12 antares kernel: {   36} [_spin_lock_irqsave+38/53] _spin_lock_irqsave+0x26/0x35
Jun  5 21:27:12 antares kernel: {   36} [<c02a8572>] _spin_lock_irqsave+0x26/0x35
Jun  5 21:27:12 antares kernel: {   20} [lock_timer_base+31/58] lock_timer_base+0x1f/0x3a
Jun  5 21:27:12 antares kernel: {   20} [<c0120a70>] lock_timer_base+0x1f/0x3a
Jun  5 21:27:12 antares kernel: {   36} [__mod_timer+41/156] __mod_timer+0x29/0x9c
Jun  5 21:27:12 antares kernel: {   36} [<c0120b0c>] __mod_timer+0x29/0x9c
Jun  5 21:27:12 antares kernel: {   24} [__ide_set_handler+92/101] __ide_set_handler+0x5c/0x65
Jun  5 21:27:12 antares kernel: {   24} [<c0239a24>] __ide_set_handler+0x5c/0x65
Jun  5 21:27:12 antares kernel: {   28} [ide_set_handler+38/58] ide_set_handler+0x26/0x3a
Jun  5 21:27:12 antares kernel: {   28} [<c0239c09>] ide_set_handler+0x26/0x3a
Jun  5 21:27:12 antares kernel: {   44} [<e0e579da>] cdrom_transfer_packet_command+0x75/0xcd
Jun  5 21:27:12 antares kernel: {   20} [<e0e57ac6>] cdrom_do_pc_continuation+0x33/0x35
Jun  5 21:27:12 antares kernel: {   44} [<e0e548bb>] cdrom_start_packet_command+0x132/0x13d
Jun  5 21:27:12 antares kernel: {   60} [<e0e55294>] ide_do_rw_cdrom+0x404/0x449
Jun  5 21:27:12 antares kernel: {   96} [ide_do_request+1335/1774] ide_do_request+0x537/0x6ee
Jun  5 21:27:12 antares kernel: {   96} [<c0238a60>] ide_do_request+0x537/0x6ee
Jun  5 21:27:12 antares kernel: {   16} [do_ide_request+30/35] do_ide_request+0x1e/0x23
Jun  5 21:27:12 antares kernel: {   16} [<c02391cb>] do_ide_request+0x1e/0x23
Jun  5 21:27:12 antares kernel: {   36} [elv_insert+102/322] elv_insert+0x66/0x142
Jun  5 21:27:12 antares kernel: {   36} [<c01b64d5>] elv_insert+0x66/0x142
Jun  5 21:27:12 antares kernel: {   32} [__elv_add_request+136/147] __elv_add_request+0x88/0x93
Jun  5 21:27:12 antares kernel: {   32} [<c01b6639>] __elv_add_request+0x88/0x93
Jun  5 21:27:12 antares kernel: {  320} [ide_do_drive_cmd+284/364] ide_do_drive_cmd+0x11c/0x16c
Jun  5 21:27:12 antares kernel: {  320} [<c0238d33>] ide_do_drive_cmd+0x11c/0x16c
Jun  5 21:27:12 antares kernel: {  100} [<e0e553aa>] cdrom_queue_packet_command+0x45/0xd8
Jun  5 21:27:12 antares kernel: {  200} [<e0e554dc>] ide_cdrom_packet+0x9f/0xb9
Jun  5 21:27:12 antares kernel: {   92} [<e0c87fca>] cdrom_get_track_info+0x56/0x9d
Jun  5 21:27:12 antares kernel: {  116} [<e0c88069>] cdrom_get_last_written+0x58/0x110
Jun  5 21:27:12 antares kernel: {   60} [<e0e55e08>] cdrom_read_toc+0x342/0x3a4
Jun  5 21:27:12 antares kernel: {  292} [<e0e56b75>] ide_cdrom_audio_ioctl+0x14c/0x210
Jun  5 21:27:12 antares kernel: {   56} [<e0c8743d>] cdrom_count_tracks+0x6b/0x142
Jun  5 21:27:12 antares kernel: {  376} [<e0c8a96b>] cdrom_open+0x19b/0x7ef
Jun  5 21:27:12 antares kernel: {   32} [<e0e54756>] idecd_open+0x8a/0xbd
Jun  5 21:27:12 antares kernel: {  564} [do_open+731/980] do_open+0x2db/0x3d4
Jun  5 21:27:12 antares kernel: {  564} [<c016297c>] do_open+0x2db/0x3d4
Jun  5 21:27:12 antares kernel: {  568} [blkdev_get+98/106] blkdev_get+0x62/0x6a
Jun  5 21:27:12 antares kernel: {  568} [<c0162ad7>] blkdev_get+0x62/0x6a
Jun  5 21:27:12 antares kernel: {  356} [<e0e9f389>] pkt_open+0x92/0xc21
Jun  5 21:27:12 antares kernel: {  564} [do_open+166/980] do_open+0xa6/0x3d4
Jun  5 21:27:12 antares kernel: {  564} [<c0162747>] do_open+0xa6/0x3d4
Jun  5 21:27:12 antares kernel: {  568} [blkdev_get+98/106] blkdev_get+0x62/0x6a
Jun  5 21:27:12 antares kernel: {  568} [<c0162ad7>] blkdev_get+0x62/0x6a
Jun  5 21:27:12 antares kernel: {   28} [open_bdev_excl+55/121] open_bdev_excl+0x37/0x79
Jun  5 21:27:12 antares kernel: {   28} [<c0162f0f>] open_bdev_excl+0x37/0x79
Jun  5 21:27:12 antares kernel: {   68} [get_sb_bdev+29/342] get_sb_bdev+0x1d/0x156
Jun  5 21:27:12 antares kernel: {   68} [<c0161445>] get_sb_bdev+0x1d/0x156
Jun  5 21:27:12 antares kernel: {   28} [<e0f33c1b>] udf_get_sb+0x1e/0x20
Jun  5 21:27:12 antares kernel: {   36} [vfs_kern_mount+48/160] vfs_kern_mount+0x30/0xa0
Jun  5 21:27:12 antares kernel: {   36} [<c01612be>] vfs_kern_mount+0x30/0xa0
Jun  5 21:27:12 antares kernel: {   32} [do_kern_mount+45/65] do_kern_mount+0x2d/0x41
Jun  5 21:27:12 antares kernel: {   32} [<c0161374>] do_kern_mount+0x2d/0x41
Jun  5 21:27:12 antares kernel: {  336} [do_mount+1789/1887] do_mount+0x6fd/0x75f
Jun  5 21:27:12 antares kernel: {  336} [<c0175978>] do_mount+0x6fd/0x75f
Jun  5 21:27:12 antares kernel: {   48} [sys_mount+114/172] sys_mount+0x72/0xac
Jun  5 21:27:12 antares kernel: {   48} [<c0175a4c>] sys_mount+0x72/0xac
Jun  5 21:27:12 antares kernel: {=5476} [sysenter_past_esp+99/161] sysenter_past_esp+0x63/0xa1
Jun  5 21:27:12 antares kernel: {=5476} [<c02a87ba>] sysenter_past_esp+0x63/0xa1
Jun  5 21:27:12 antares kernel: <---------------------------
Jun  5 21:27:12 antares kernel: 
Jun  5 21:27:12 antares kernel: pktcdvd: Fixed packets, 32 blocks, Mode-2 disc
Jun  5 21:27:12 antares kernel: pktcdvd: Max. media speed: 4
Jun  5 21:27:12 antares kernel: pktcdvd: write speed 4x
Jun  5 21:27:12 antares kernel: pktcdvd: 590528kB available on disc
Jun  5 21:27:14 antares kernel: UDF-fs INFO UDF 0.9.8.1 (2004/29/09) Mounting volume 'flexbackup', timestamp 2006/03/17 15:29 (1078)
Jun  5 21:40:45 antares kernel: pktcdvd: writer pktcdvd0 unmapped


-- 
laurent

