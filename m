Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266221AbUJEWhu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266221AbUJEWhu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 18:37:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266243AbUJEWht
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 18:37:49 -0400
Received: from sa10.bezeqint.net ([192.115.104.24]:5090 "EHLO
	sa10.bezeqint.net") by vger.kernel.org with ESMTP id S266221AbUJEWgy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 18:36:54 -0400
Date: Wed, 6 Oct 2004 01:37:49 +0200
From: Micha Feigin <michf@post.tau.ac.il>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.9-rc3 lost cdrom
Message-ID: <20041005233748.GA3055@luna.mooo.com>
Mail-Followup-To: Linux Kernel <linux-kernel@vger.kernel.org>
References: <20041003021055.GA3227@luna.mooo.com> <20041004061902.GC2287@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041004061902.GC2287@suse.de>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 04, 2004 at 08:19:06AM +0200, Jens Axboe wrote:
> On Sun, Oct 03 2004, Micha Feigin wrote:
> > I seem to have lost cdrom support through scsi emulation, any ideas?
> > (its a burner, and drive detection with xcdroast in ide mode is
> > terrible, takes minutes).
> 
> So did it work in 2.6.9-rc2?
> 

Just tested (sorry, took me some time to free the time to check). Also
doesn't work, same error message:

Oct  6 01:26:11 litshi kernel: attempt to access beyond end of device
Oct  6 01:26:11 litshi kernel: sr0: rw=0, want=68, limit=4
Oct  6 01:26:11 litshi kernel: isofs_fill_super: bread failed, dev=sr0, iso_blknum=16, block=16

(repeated several times).

I rebooted into 2.6.9-rc3 again and tried to remove the scsi modules to
try ide-cd instead and got a segmentation fault to

rmmod ide_scsi cdrom sr_mod scsi_mod nls_base isofs

second attempt blocked with error that ide_scsi is busy. In
/var/log/messages I found the following error message:

Oct  6 01:29:32 litshi kernel: attempt to access beyond end of device
Oct  6 01:29:32 litshi kernel: sr0: rw=0, want=68, limit=4
Oct  6 01:29:32 litshi kernel: isofs_fill_super: bread failed, dev=sr0, iso_blknum=16, block=16
Oct  6 01:30:34 litshi kernel: d082b43c
Oct  6 01:30:34 litshi kernel: PREEMPT 
Oct  6 01:30:34 litshi kernel: Modules linked in: isofs nls_base zlib_inflate mach64 ipt_TOS ipt_REJECT ipt_pkttype ipt_LOG ipt_state ipt_multiport ipt_conntrack iptable_mangle ip_conntrack_ftp ip_conntrack iptable_filter ip_tables eth1394 8139too crc32 ohci1394 ieee1394 snd_via82xx snd_ac97_codec snd_pcm_oss snd_mixer_oss snd_pcm snd_timer snd_page_alloc snd_mpu401_uart snd_rawmidi snd_seq_device snd soundcore uhci_hcd usbcore via_agp agpgart sr_mod cdrom autofs4 ide_scsi scsi_mod
Oct  6 01:30:34 litshi kernel: CPU:    0
Oct  6 01:30:34 litshi kernel: EIP:    0060:[pg0+273220668/1069954048]    Not tainted VLI
Oct  6 01:30:34 litshi kernel: EFLAGS: 00010092   (2.6.9-rc3) 
Oct  6 01:30:34 litshi kernel: EIP is at idescsi_queue+0x11c/0x640 [ide_scsi]
Oct  6 01:30:34 litshi kernel: eax: 00000000   ebx: cef92260   ecx: cef95ca0   edx: c03932b0
Oct  6 01:30:34 litshi kernel: esi: cef95cfe   edi: cef95ca0   ebp: cef95cf4   esp: c76cfc78
Oct  6 01:30:34 litshi kernel: ds: 007b   es: 007b   ss: 0068
Oct  6 01:30:34 litshi kernel: Process rmmod (pid: 3082, threadinfo=c76ce000 task=cecdc020)
Oct  6 01:30:34 litshi kernel: Stack: cfeef360 00000020 d083c76e cef92260 cffe3c89 00000010 00000000 cef95d08 
Oct  6 01:30:34 litshi kernel:        00000246 ce1a5a40 000001e0 c03932b0 cef95ca0 00000293 cef95ca0 cfec2200 
Oct  6 01:30:34 litshi kernel:        d083c5e8 cef95ca0 d083c7f0 d083ea70 00000000 cef95d28 cef95ca0 ceeec800 
Oct  6 01:30:34 litshi kernel: Call Trace:
Oct  6 01:30:34 litshi kernel:  [pg0+273291118/1069954048] scsi_init_cmd_from_req+0xde/0x160 [scsi_mod]
Oct  6 01:30:34 litshi kernel:  [pg0+273290728/1069954048] scsi_dispatch_cmd+0x148/0x1f0 [scsi_mod]
Oct  6 01:30:34 litshi kernel:  [pg0+273291248/1069954048] scsi_done+0x0/0x30 [scsi_mod]
Oct  6 01:30:34 litshi kernel:  [pg0+273300080/1069954048] scsi_times_out+0x0/0xb0 [scsi_mod]
Oct  6 01:30:34 litshi kernel:  [pg0+273310861/1069954048] scsi_request_fn+0x1cd/0x3b0 [scsi_mod]
Oct  6 01:30:34 litshi kernel:  [__elv_add_request+69/160] __elv_add_request+0x45/0xa0
Oct  6 01:30:34 litshi kernel:  [blk_insert_request+189/224] blk_insert_request+0xbd/0xe0
Oct  6 01:30:34 litshi kernel:  [pg0+273305850/1069954048] scsi_insert_special_req+0x3a/0x40 [scsi_mod]
Oct  6 01:30:34 litshi kernel:  [pg0+273306457/1069954048] scsi_wait_req+0x69/0xa0 [scsi_mod]
Oct  6 01:30:34 litshi kernel:  [pg0+273306208/1069954048] scsi_wait_done+0x0/0x90 [scsi_mod]
Oct  6 01:30:34 litshi kernel:  [pg0+273261521/1069954048] sr_do_ioctl+0x91/0x2b0 [sr_mod]
Oct  6 01:30:34 litshi kernel:  [pg0+273260725/1069954048] sr_packet+0x25/0x40 [sr_mod]
Oct  6 01:30:34 litshi kernel:  [pg0+273438417/1069954048] cdrom_get_disc_info+0x61/0xb0 [cdrom]
Oct  6 01:30:34 litshi kernel:  [pg0+273422075/1069954048] cdrom_mrw_exit+0x1b/0x70 [cdrom]
Oct  6 01:30:34 litshi kernel:  [pg0+273421028/1069954048] unregister_cdrom+0x94/0xe0 [cdrom]
Oct  6 01:30:34 litshi kernel:  [pg0+273260818/1069954048] sr_kref_release+0x42/0x70 [sr_mod]
Oct  6 01:30:34 litshi kernel:  [pg0+273260752/1069954048] sr_kref_release+0x0/0x70 [sr_mod]
Oct  6 01:30:34 litshi kernel:  [kref_put+57/160] kref_put+0x39/0xa0
Oct  6 01:30:34 litshi kernel:  [kobject_put+30/48] kobject_put+0x1e/0x30
Oct  6 01:30:34 litshi kernel:  [pg0+273260927/1069954048] sr_remove+0x3f/0x57 [sr_mod]
Oct  6 01:30:34 litshi kernel:  [pg0+273260752/1069954048] sr_kref_release+0x0/0x70 [sr_mod]
Oct  6 01:30:34 litshi kernel:  [device_release_driver+100/112] device_release_driver+0x64/0x70
Oct  6 01:30:34 litshi kernel:  [bus_remove_device+100/176] bus_remove_device+0x64/0xb0
Oct  6 01:30:34 litshi kernel:  [device_del+93/160] device_del+0x5d/0xa0
Oct  6 01:30:34 litshi kernel:  [pg0+273322161/1069954048] scsi_remove_device+0x61/0xe0 [scsi_mod]
Oct  6 01:30:34 litshi kernel:  [pg0+273318836/1069954048] scsi_forget_host+0x44/0x90 [scsi_mod]
Oct  6 01:30:34 litshi kernel:  [pg0+273293507/1069954048] scsi_remove_host+0x13/0x60 [scsi_mod]
Oct  6 01:30:34 litshi kernel:  [pg0+273220061/1069954048] idescsi_cleanup+0x4d/0x60 [ide_scsi]
Oct  6 01:30:34 litshi kernel:  [ide_unregister_driver+113/177] ide_unregister_driver+0x71/0xb1
Oct  6 01:30:34 litshi kernel:  [try_stop_module+40/48] try_stop_module+0x28/0x30
Oct  6 01:30:34 litshi kernel:  [pg0+273223567/1069954048] exit_idescsi_module+0xf/0x13 [ide_scsi]
Oct  6 01:30:34 litshi kernel:  [sys_delete_module+366/432] sys_delete_module+0x16e/0x1b0
Oct  6 01:30:34 litshi kernel:  [do_munmap+192/384] do_munmap+0xc0/0x180
Oct  6 01:30:34 litshi kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Oct  6 01:30:34 litshi kernel: Code: 00 00 8b 7c 24 44 8b 47 64 89 7b 2c 89 43 14 89 43 0c 8b 44 24 48 89 43 30 a1 60 0f 2e c0 03 47 3c 89 43 38 8b 54 24 2c 8b 42 20 <8b> 80 ec 01 00 00 a8 01 74 05 0f ba 6b 34 02 8b 4b 1c 89 4c 24 
Oct  6 01:30:34 litshi kernel:  <6>note: rmmod[3082] exited with preempt_count 1
Oct  6 01:30:34 litshi kernel:  [schedule+1222/1232] schedule+0x4c6/0x4d0
Oct  6 01:30:34 litshi kernel:  [unmap_page_range+75/128] unmap_page_range+0x4b/0x80
Oct  6 01:30:34 litshi kernel:  [unmap_vmas+428/448] unmap_vmas+0x1ac/0x1c0
Oct  6 01:30:34 litshi kernel:  [exit_mmap+131/352] exit_mmap+0x83/0x160
Oct  6 01:30:34 litshi kernel:  [mmput+100/160] mmput+0x64/0xa0
Oct  6 01:30:34 litshi kernel:  [do_exit+352/1072] do_exit+0x160/0x430
Oct  6 01:30:34 litshi kernel:  [do_page_fault+0/1433] do_page_fault+0x0/0x599
Oct  6 01:30:34 litshi kernel:  [die+392/400] die+0x188/0x190
Oct  6 01:30:34 litshi kernel:  [do_page_fault+0/1433] do_page_fault+0x0/0x599
Oct  6 01:30:34 litshi kernel:  [printk+23/32] printk+0x17/0x20
Oct  6 01:30:34 litshi kernel:  [do_page_fault+558/1433] do_page_fault+0x22e/0x599
Oct  6 01:30:34 litshi kernel:  [search_by_key+1851/4144] search_by_key+0x73b/0x1030
Oct  6 01:30:34 litshi kernel:  [is_tree_node+109/112] is_tree_node+0x6d/0x70
Oct  6 01:30:34 litshi kernel:  [search_by_key+1851/4144] search_by_key+0x73b/0x1030
Oct  6 01:30:34 litshi kernel:  [do_page_fault+0/1433] do_page_fault+0x0/0x599
Oct  6 01:30:34 litshi kernel:  [error_code+45/56] error_code+0x2d/0x38
Oct  6 01:30:34 litshi kernel:  [pg0+273220668/1069954048] idescsi_queue+0x11c/0x640 [ide_scsi]
Oct  6 01:30:34 litshi kernel:  [pg0+273291118/1069954048] scsi_init_cmd_from_req+0xde/0x160 [scsi_mod]
Oct  6 01:30:34 litshi kernel:  [pg0+273290728/1069954048] scsi_dispatch_cmd+0x148/0x1f0 [scsi_mod]
Oct  6 01:30:34 litshi kernel:  [pg0+273291248/1069954048] scsi_done+0x0/0x30 [scsi_mod]
Oct  6 01:30:34 litshi kernel:  [pg0+273300080/1069954048] scsi_times_out+0x0/0xb0 [scsi_mod]
Oct  6 01:30:34 litshi kernel:  [pg0+273310861/1069954048] scsi_request_fn+0x1cd/0x3b0 [scsi_mod]
Oct  6 01:30:34 litshi kernel:  [__elv_add_request+69/160] __elv_add_request+0x45/0xa0
Oct  6 01:30:34 litshi kernel:  [blk_insert_request+189/224] blk_insert_request+0xbd/0xe0
Oct  6 01:30:34 litshi kernel:  [pg0+273305850/1069954048] scsi_insert_special_req+0x3a/0x40 [scsi_mod]
Oct  6 01:30:34 litshi kernel:  [pg0+273306457/1069954048] scsi_wait_req+0x69/0xa0 [scsi_mod]
Oct  6 01:30:34 litshi kernel:  [pg0+273306208/1069954048] scsi_wait_done+0x0/0x90 [scsi_mod]
Oct  6 01:30:34 litshi kernel:  [pg0+273261521/1069954048] sr_do_ioctl+0x91/0x2b0 [sr_mod]
Oct  6 01:30:34 litshi kernel:  [pg0+273260725/1069954048] sr_packet+0x25/0x40 [sr_mod]
Oct  6 01:30:34 litshi kernel:  [pg0+273438417/1069954048] cdrom_get_disc_info+0x61/0xb0 [cdrom]
Oct  6 01:30:34 litshi kernel:  [pg0+273422075/1069954048] cdrom_mrw_exit+0x1b/0x70 [cdrom]
Oct  6 01:30:34 litshi kernel:  [pg0+273421028/1069954048] unregister_cdrom+0x94/0xe0 [cdrom]
Oct  6 01:30:34 litshi kernel:  [pg0+273260818/1069954048] sr_kref_release+0x42/0x70 [sr_mod]
Oct  6 01:30:34 litshi kernel:  [pg0+273260752/1069954048] sr_kref_release+0x0/0x70 [sr_mod]
Oct  6 01:30:34 litshi kernel:  [kref_put+57/160] kref_put+0x39/0xa0
Oct  6 01:30:34 litshi kernel:  [kobject_put+30/48] kobject_put+0x1e/0x30
Oct  6 01:30:34 litshi kernel:  [pg0+273260927/1069954048] sr_remove+0x3f/0x57 [sr_mod]
Oct  6 01:30:34 litshi kernel:  [pg0+273260752/1069954048] sr_kref_release+0x0/0x70 [sr_mod]
Oct  6 01:30:34 litshi kernel:  [device_release_driver+100/112] device_release_driver+0x64/0x70
Oct  6 01:30:34 litshi kernel:  [bus_remove_device+100/176] bus_remove_device+0x64/0xb0
Oct  6 01:30:34 litshi kernel:  [device_del+93/160] device_del+0x5d/0xa0
Oct  6 01:30:34 litshi kernel:  [pg0+273322161/1069954048] scsi_remove_device+0x61/0xe0 [scsi_mod]
Oct  6 01:30:34 litshi kernel:  [pg0+273318836/1069954048] scsi_forget_host+0x44/0x90 [scsi_mod]
Oct  6 01:30:34 litshi kernel:  [pg0+273293507/1069954048] scsi_remove_host+0x13/0x60 [scsi_mod]
Oct  6 01:30:34 litshi kernel:  [pg0+273220061/1069954048] idescsi_cleanup+0x4d/0x60 [ide_scsi]
Oct  6 01:30:34 litshi kernel:  [ide_unregister_driver+113/177] ide_unregister_driver+0x71/0xb1
Oct  6 01:30:34 litshi kernel:  [try_stop_module+40/48] try_stop_module+0x28/0x30
Oct  6 01:30:34 litshi kernel:  [pg0+273223567/1069954048] exit_idescsi_module+0xf/0x13 [ide_scsi]
Oct  6 01:30:34 litshi kernel:  [sys_delete_module+366/432] sys_delete_module+0x16e/0x1b0
Oct  6 01:30:34 litshi kernel:  [do_munmap+192/384] do_munmap+0xc0/0x180
Oct  6 01:30:34 litshi kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Oct  6 01:30:39 litshi kernel: d082b43c
Oct  6 01:30:39 litshi kernel: PREEMPT 
Oct  6 01:30:39 litshi kernel: Modules linked in: isofs nls_base zlib_inflate mach64 ipt_TOS ipt_REJECT ipt_pkttype ipt_LOG ipt_state ipt_multiport ipt_conntrack iptable_mangle ip_conntrack_ftp ip_conntrack iptable_filter ip_tables eth1394 8139too crc32 ohci1394 ieee1394 snd_via82xx snd_ac97_codec snd_pcm_oss snd_mixer_oss snd_pcm snd_timer snd_page_alloc snd_mpu401_uart snd_rawmidi snd_seq_device snd soundcore uhci_hcd usbcore via_agp agpgart sr_mod cdrom autofs4 ide_scsi scsi_mod
Oct  6 01:30:39 litshi kernel: CPU:    0
Oct  6 01:30:39 litshi kernel: EIP:    0060:[pg0+273220668/1069954048]    Not tainted VLI
Oct  6 01:30:39 litshi kernel: EFLAGS: 00010086   (2.6.9-rc3) 
Oct  6 01:30:39 litshi kernel: EIP is at idescsi_queue+0x11c/0x640 [ide_scsi]
Oct  6 01:30:39 litshi kernel: eax: 00000000   ebx: cb9afe60   ecx: cef95ca0   edx: c03932b0
Oct  6 01:30:39 litshi kernel: esi: cef95cfa   edi: cef95ca0   ebp: cef95cf4   esp: ceeafee4
Oct  6 01:30:39 litshi kernel: ds: 007b   es: 007b   ss: 0068
Oct  6 01:30:39 litshi kernel: Process scsi_eh_0 (pid: 355, threadinfo=ceeae000 task=cee86aa0)
Oct  6 01:30:39 litshi kernel: Stack: cfeef360 00000020 c0356800 cb9afe60 c02e1cb0 cfec2200 00000000 cef95d08 
Oct  6 01:30:39 litshi kernel:        00000246 ce1a5080 000001e0 c03932b0 00000296 ceeae000 cef95ca0 ceeaff38 
Oct  6 01:30:39 litshi kernel:        d083edd5 cef95ca0 d083ece0 d083ecc0 cfec2200 00000000 00000000 ceeaff40 
Oct  6 01:30:39 litshi kernel: Call Trace:
Oct  6 01:30:39 litshi kernel:  [pg0+273300949/1069954048] scsi_send_eh_cmnd+0xa5/0x160 [scsi_mod]
Oct  6 01:30:39 litshi kernel:  [pg0+273300704/1069954048] scsi_eh_done+0x0/0x50 [scsi_mod]
Oct  6 01:30:39 litshi kernel:  [pg0+273300672/1069954048] scsi_eh_times_out+0x0/0x20 [scsi_mod]
Oct  6 01:30:39 litshi kernel:  [pg0+273301942/1069954048] scsi_eh_tur+0x96/0xd0 [scsi_mod]
Oct  6 01:30:39 litshi kernel:  [pg0+273302105/1069954048] scsi_eh_abort_cmds+0x69/0x80 [scsi_mod]
Oct  6 01:30:39 litshi kernel:  [pg0+273304999/1069954048] scsi_unjam_host+0xa7/0xd0 [scsi_mod]
Oct  6 01:30:39 litshi kernel:  [pg0+273305202/1069954048] scsi_error_handler+0xa2/0xd0 [scsi_mod]
Oct  6 01:30:39 litshi kernel:  [pg0+273305040/1069954048] scsi_error_handler+0x0/0xd0 [scsi_mod]
Oct  6 01:30:39 litshi kernel:  [kernel_thread_helper+5/20] kernel_thread_helper+0x5/0x14
Oct  6 01:30:39 litshi kernel: Code: 00 00 8b 7c 24 44 8b 47 64 89 7b 2c 89 43 14 89 43 0c 8b 44 24 48 89 43 30 a1 60 0f 2e c0 03 47 3c 89 43 38 8b 54 24 2c 8b 42 20 <8b> 80 ec 01 00 00 a8 01 74 05 0f ba 6b 34 02 8b 4b 1c 89 4c 24 
Oct  6 01:30:39 litshi kernel:  <6>note: scsi_eh_0[355] exited with
preempt_count 1

> -- 
> Jens Axboe
> 
>  
>  +++++++++++++++++++++++++++++++++++++++++++
>  This Mail Was Scanned By Mail-seCure System
>  at the Tel-Aviv University CC.
> 
