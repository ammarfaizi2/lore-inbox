Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261609AbVCCNKj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261609AbVCCNKj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 08:10:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261606AbVCCNKh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 08:10:37 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:21408 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261601AbVCCNKD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 08:10:03 -0500
Date: Thu, 3 Mar 2005 14:10:04 +0100
From: Jan Kara <jack@suse.cz>
To: Petr Vandrovec <vandrove@vc.cvut.cz>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: Crash in ext3 while extracting 2.6.11 (on 2.6.11-rc5-something)
Message-ID: <20050303131004.GA16512@atrey.karlin.mff.cuni.cz>
References: <20050302180633.GA25304@ppc.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050302180633.GA25304@ppc.vc.cvut.cz>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hello,

>    I've noticed that 2.6.11 is released, so I run (flawlessly) 'bk pull',
> and now I'm trying to export tree from 'bk' by doing 'bk export -tplain
> /tmp/linux-2.6.11'.  Unfortunately I tried it twice, and twice it died
> with same crash in log_do_checkpoint (see below).  Anybody has a clue
> what it could be?  When I hit alt-sysrq-s, sync takes about 10 seconds,
> so box had to have lots of disk caches dirtied when crash occured.
> 
>   Box is dual opteron rev cg, kernel has enabled all possible debug
> options.  Problem seems to occur on 2.6.11-rc4-something too, it just
> begins with crash in ext3_inode_dirty because I have rc4-something built
> without memory poisoning (probably).
> 
>   I've not noticed any other problems, and it was possible to extract
> 2.6.11-rc5-something on Monday with 2.6.11-rc4-something, which crashes
> now too.  I'll run 'fsck -f', maybe it will help things a bit...
> 
> Bootdata ok (command line is BOOT_IMAGE=Linux ro root=801 ramdisk=0 console=tty0 console=ttyS0,115200 nmi_watchdog=2 psmouse_noext=1 verbose)
> Linux version 2.6.11-rc5-2065-64 (root@vana) (gcc version 3.3.3 (Debian 20040401)) #1 SMP Mon Feb 28 22:15:10 CET 2005
> 
> stack segment: 0000 [1] PREEMPT SMP 
> CPU 0 
  I don't see here a reason why the machine crashed (some NULL pointer
deref or what...). It would be useful to know it. Also could you run
gdb on vmlinux a find out where exactly in the function the oops
occured?
  Anyway I was briefly reading the code in log_do_checkpoint() and two
things are not clear to me - are we guaranteed that
transaction->t_checkpoint_list is non-empty (the code relies on that)?
Another thing is - __flush_buffer() can sleep. Cannot someone change
the t_checkpoint_list while we are sleeping? We are protected only by
the j_checkpoint_sem and that only protects us against other
log_do_checkpoint() calls.

								Honza

> Modules linked in: ipx p8022 psnap llc esp6 ah6 ipcomp esp4 ah4 xfrm_user wp512 tea sha512 michael_mic md4 khazad cast6 cast5 arc4 anubis nfsd exportfs lockd sunrpc i810_audio ac97_codec soundcore deflate zlib_deflate zlib_inflate twofish serpent aes blowfish des sha256 sha1 crypto_null af_key capability commoncap w83627hf_wdt md5 ipv6 ide_disk ide_cd floppy budget_ci tda1004x budget_core dvb_core saa7146 ttpci_eeprom stv0299 i2c_amd756 hw_random i2c_amd8111 amd74xx eth1394 usblp usb_storage ide_core tg3 usbhid ohci1394 ieee1394 tvaudio bttv tuner video_buf firmware_class v4l2_common btcx_risc tveeprom videodev ohci_hcd usbcore
> Pid: 7703, comm: syslogd Not tainted 2.6.11-rc5-2065-64
> RIP: 0010:[<ffffffff801d9996>] <ffffffff801d9996>{log_do_checkpoint+246}
> RSP: 0000:ffff81007ba819d8  EFLAGS: 00010213
> RAX: ffff81007ba81fd8 RBX: ffff8100710d12a8 RCX: 0000000000000000
> RDX: 0000000000000000 RSI: 000000000000006b RDI: 0000000000000001
> RBP: 6b6b6b6b6b6b6b6b R08: 0000000000000000 R09: ffff8100710b2778
> R10: 0000000000000001 R11: 0000000000000000 R12: 6b6b6b6b6b6b6b6b
> R13: ffff810070f67a88 R14: ffff81003fee9120 R15: ffff81003fee92c4
> FS:  0000000000000000(0000) GS:ffffffff805c0300(005b) knlGS:00000000556c12a0
> CS:  0010 DS: 002b ES: 002b CR0: 000000008005003b
> CR2: 00000000556f9d9c CR3: 000000007bd6e000 CR4: 00000000000006e0
> Process syslogd (pid: 7703, threadinfo ffff81007ba80000, task ffff81003dde2780)
> Stack: ffff81007ba81a38 0020211c80168187 ffff81003bb36208 0000000b00000000 
>        ffff81007e4b1698 ffff81007e4b1628 ffff81007e4b15b8 ffff81007d8c8318 
>        ffff810070f53f58 ffff81007dfb0f58 
> Call Trace:<ffffffff801d9322>{__log_wait_for_space+178} <ffffffff801d3fc3>{start_this_handle+1059} 
>        <ffffffff8020ffad>{radix_tree_gang_lookup_tag+77} <ffffffff80165ff0>{check_poison_obj+48} 
>        <ffffffff80165e36>{poison_obj+70} <ffffffff801d4074>{new_handle+20} 
>        <ffffffff801656c5>{dbg_redzone1+37} <ffffffff801d4074>{new_handle+20} 
>        <ffffffff80167d68>{cache_alloc_debugcheck_after+280} 
>        <ffffffff801d4148>{journal_start+168} <ffffffff801c7616>{ext3_dirty_inode+54} 
>        <ffffffff801a7c74>{__mark_inode_dirty+52} <ffffffff8019f2ec>{inode_update_time+188} 
>        <ffffffff8019069f>{pipe_writev+1311} <ffffffff801ae583>{compat_do_readv_writev+403} 
>        <ffffffff801906c0>{pipe_write+0} <ffffffff80357ccb>{_spin_lock+27} 
>        <ffffffff80358110>{_spin_unlock+64} <ffffffff801ae753>{compat_sys_writev+115} 
>        <ffffffff80124201>{ia32_sysret+0} 
> 
> Code: f0 0f ba 6d 00 13 19 c0 85 c0 74 3b bf 01 00 00 00 e8 64 b0 
> RIP <ffffffff801d9996>{log_do_checkpoint+246} RSP <ffff81007ba819d8>
>  <3>Debug: sleeping function called from invalid context at include/linux/rwsem.h:43
> in_atomic():1, irqs_disabled():0
> 
> Call Trace:<ffffffff80136e3e>{__might_sleep+206} <ffffffff8013ac69>{profile_task_exit+41} 
>        <ffffffff8013ceec>{do_exit+28} <ffffffff8010ff55>{die+69} 
>        <ffffffff8011015b>{do_trap+331} <ffffffff801107ff>{do_stack_segment+175} 
>        <ffffffff8010f5e5>{stack_segment+125} <ffffffff801d9996>{log_do_checkpoint+246} 
>        
> note: syslogd[7703] exited with preempt_count 2
> scheduling while atomic: syslogd/0x10000002/7703
> 
> Call Trace:<ffffffff80355abd>{schedule+125} <ffffffff801fc0aa>{avc_has_perm+90} 
>        <ffffffff80357ccb>{_spin_lock+27} <ffffffff8014355f>{__mod_timer+303} 
>        <ffffffff8035721f>{cond_resched+47} <ffffffff801ce78f>{ext3_statfs+111} 
>        <ffffffff80180e5f>{vfs_statfs+95} <ffffffff801577be>{check_free_space+110} 
>        <ffffffff80157c8a>{do_acct_process+26} <ffffffff80158148>{acct_process+104} 
>        <ffffffff8013cff5>{do_exit+293} <ffffffff8010ff55>{die+69} 
>        <ffffffff8011015b>{do_trap+331} <ffffffff801107ff>{do_stack_segment+175} 
>        <ffffffff8010f5e5>{stack_segment+125} <ffffffff801d9996>{log_do_checkpoint+246} 
>        
> Unable to handle kernel NULL pointer dereference at 0000000000000000 RIP: 
> <ffffffff801d40d9>{journal_start+57}
> PGD 7be96067 PUD 7d455067 PMD 0 
> Oops: 0000 [2] PREEMPT SMP 
> CPU 0 
> Modules linked in: ipx p8022 psnap llc esp6 ah6 ipcomp esp4 ah4 xfrm_user wp512 tea sha512 michael_mic md4 khazad cast6 cast5 arc4 anubis nfsd exportfs lockd sunrpc i810_audio ac97_codec soundcore deflate zlib_deflate zlib_inflate twofish serpent aes blowfish des sha256 sha1 crypto_null af_key capability commoncap w83627hf_wdt md5 ipv6 ide_disk ide_cd floppy budget_ci tda1004x budget_core dvb_core saa7146 ttpci_eeprom stv0299 i2c_amd756 hw_random i2c_amd8111 amd74xx eth1394 usblp usb_storage ide_core tg3 usbhid ohci1394 ieee1394 tvaudio bttv tuner video_buf firmware_class v4l2_common btcx_risc tveeprom videodev ohci_hcd usbcore
> Pid: 7703, comm: syslogd Not tainted 2.6.11-rc5-2065-64
> RIP: 0010:[<ffffffff801d40d9>] <ffffffff801d40d9>{journal_start+57}
> RSP: 0000:ffffffff805672e8  EFLAGS: 00010286
> RAX: 0000000000000000 RBX: ffff810041551378 RCX: ffff810079ecd960
> RDX: 0000000000000000 RSI: 0000000000000002 RDI: ffff81003fee9120
> RBP: ffff81003fee9120 R08: ffff81003fe9cf48 R09: 000000000000037e
> R10: 0000000000000000 R11: 0000000000000000 R12: ffff810079ecd8d8
> R13: 0000000000000040 R14: ffffffff805673b8 R15: 0000000000000000
> FS:  0000000000000000(0000) GS:ffffffff805c0300(005b) knlGS:00000000556c12a0
> CS:  0010 DS: 002b ES: 002b CR0: 000000008005003b
> CR2: 0000000000000000 CR3: 000000007bd6e000 CR4: 00000000000006e0
> Process syslogd (pid: 7703, threadinfo ffff81007ba80000, task ffff81003dde2780)
> Stack: 000000004225ff3b 0000000000000001 ffff810041551378 ffffffff801c7616 
>        0000000000000001 ffff810079ecd8d8 ffff81003fe9cf48 ffffffff801a7c74 
>        ffff810079ecd8d8 0000000000000001 
> Call Trace:<ffffffff801c7616>{ext3_dirty_inode+54} <ffffffff801a7c74>{__mark_inode_dirty+52} 
>        <ffffffff8019f2ec>{inode_update_time+188} <ffffffff801602c1>{__generic_file_aio_write_nolock+833} 
>        <ffffffff8010ccea>{__switch_to+282} <ffffffff8035680f>{thread_return+92} 
>        <ffffffff8016063f>{generic_file_aio_write+127} <ffffffff801c2523>{ext3_file_write+35} 
>        <ffffffff8018306d>{do_sync_write+173} <ffffffff80358202>{_spin_unlock_irqrestore+66} 
>        <ffffffff80358110>{_spin_unlock+64} <ffffffff80150a30>{autoremove_wake_function+0} 
>        <ffffffff80357ccb>{_spin_lock+27} <ffffffff802108fd>{__up_read+29} 
>        <ffffffff801580ac>{do_acct_process+1084} <ffffffff80158148>{acct_process+104} 
>        <ffffffff8013cff5>{do_exit+293} <ffffffff8010ff55>{die+69} 
>        <ffffffff8011015b>{do_trap+331} <ffffffff801107ff>{do_stack_segment+175} 
>        <ffffffff8010f5e5>{stack_segment+125} <ffffffff801d9996>{log_do_checkpoint+246} 
>        
> 
> Code: 48 39 38 74 34 49 c7 c0 60 85 38 80 b9 0f 01 00 00 48 c7 c2 
> RIP <ffffffff801d40d9>{journal_start+57} RSP <ffffffff805672e8>
> CR2: 0000000000000000
>  <6>note: syslogd[7703] exited with preempt_count 2
> scheduling while atomic: syslogd/0x10000002/7703
> 
> Call Trace:<ffffffff80355abd>{schedule+125} <ffffffff8016e7c7>{zap_pmd_range+183} 
>        <ffffffff8016e88e>{zap_pud_range+158} <ffffffff8035721f>{cond_resched+47} 
>        <ffffffff8016ebdd>{unmap_vmas+605} <ffffffff801747bd>{exit_mmap+157} 
>        <ffffffff80137584>{mmput+52} <ffffffff8013d004>{do_exit+308} 
>        <ffffffff801225e0>{do_page_fault+1216} <ffffffff80357ccb>{_spin_lock+27} 
>        <ffffffff8014355f>{__mod_timer+303} <ffffffff8010efd1>{error_exit+0} 
>        <ffffffff801d40d9>{journal_start+57} <ffffffff801c7616>{ext3_dirty_inode+54} 
>        <ffffffff801a7c74>{__mark_inode_dirty+52} <ffffffff8019f2ec>{inode_update_time+188} 
>        <ffffffff801602c1>{__generic_file_aio_write_nolock+833} 
>        <ffffffff8010ccea>{__switch_to+282} <ffffffff8035680f>{thread_return+92} 
>        <ffffffff8016063f>{generic_file_aio_write+127} <ffffffff801c2523>{ext3_file_write+35} 
>        <ffffffff8018306d>{do_sync_write+173} <ffffffff80358202>{_spin_unlock_irqrestore+66} 
>        <ffffffff80358110>{_spin_unlock+64} <ffffffff80150a30>{autoremove_wake_function+0} 
>        <ffffffff80357ccb>{_spin_lock+27} <ffffffff802108fd>{__up_read+29} 
>        <ffffffff801580ac>{do_acct_process+1084} <ffffffff80158148>{acct_process+104} 
>        <ffffffff8013cff5>{do_exit+293} <ffffffff8010ff55>{die+69} 
>        <ffffffff8011015b>{do_trap+331} <ffffffff801107ff>{do_stack_segment+175} 
>        <ffffffff8010f5e5>{stack_segment+125} <ffffffff801d9996>{log_do_checkpoint+246} 
>        
> scheduling while atomic: syslogd/0x00000002/7703
> 
> Call Trace:<ffffffff80355abd>{schedule+125} <ffffffff80132540>{recalc_task_prio+320} 
>        <ffffffff801325dc>{activate_task+140} <ffffffff80132bd0>{try_to_wake_up+560} 
>        <ffffffff80356a23>{wait_for_completion+179} <ffffffff80134a70>{default_wake_function+0} 
>        <ffffffff80134a70>{default_wake_function+0} <ffffffff8014b60d>{call_usermodehelper+365} 
>        <ffffffff8014b450>{__call_usermodehelper+0} <ffffffff803101c9>{netlink_broadcast+825} 
>        <ffffffff8020ea8c>{kobject_hotplug+604} <ffffffff80357ccb>{_spin_lock+27} 
>        <ffffffff8020e15e>{kobject_del+14} <ffffffff802ab93c>{class_device_del+172} 
>        <ffffffff802ab969>{class_device_unregister+9} <ffffffff8027bc6a>{vcs_remove_devfs+58} 
>        <ffffffff802833a6>{con_close+134} <ffffffff802729dd>{release_dev+573} 
>        <ffffffff80357ccb>{_spin_lock+27} <ffffffff80165e36>{poison_obj+70} 
>        <ffffffff801678c5>{cache_free_debugcheck+709} <ffffffff80165e36>{poison_obj+70} 
>        <ffffffff80183d80>{filp_dtor+0} <ffffffff80357ccb>{_spin_lock+27} 
>        <ffffffff802734d1>{tty_release+17} <ffffffff80183f82>{__fput+98} 
>        <ffffffff8018275e>{filp_close+126} <ffffffff8013c213>{put_files_struct+115} 
>        <ffffffff8013d03b>{do_exit+363} <ffffffff801225e0>{do_page_fault+1216} 
>        <ffffffff80357ccb>{_spin_lock+27} <ffffffff8014355f>{__mod_timer+303} 
>        <ffffffff8010efd1>{error_exit+0} <ffffffff801d40d9>{journal_start+57} 
>        <ffffffff801c7616>{ext3_dirty_inode+54} <ffffffff801a7c74>{__mark_inode_dirty+52} 
>        <ffffffff8019f2ec>{inode_update_time+188} <ffffffff801602c1>{__generic_file_aio_write_nolock+833} 
>        <ffffffff8010ccea>{__switch_to+282} <ffffffff8035680f>{thread_return+92} 
>        <ffffffff8016063f>{generic_file_aio_write+127} <ffffffff801c2523>{ext3_file_write+35} 
>        <ffffffff8018306d>{do_sync_write+173} <ffffffff80358202>{_spin_unlock_irqrestore+66} 
>        <ffffffff80358110>{_spin_unlock+64} <ffffffff80150a30>{autoremove_wake_function+0} 
>        <ffffffff80357ccb>{_spin_lock+27} <ffffffff802108fd>{__up_read+29} 
>        <ffffffff801580ac>{do_acct_process+1084} <ffffffff80158148>{acct_process+104} 
>        <ffffffff8013cff5>{do_exit+293} <ffffffff8010ff55>{die+69} 
>        <ffffffff8011015b>{do_trap+331} <ffffffff801107ff>{do_stack_segment+175} 
>        <ffffffff8010f5e5>{stack_segment+125} <ffffffff801d9996>{logSysRq : Emergency Sync
> Emergency Sync complete
> SysRq : Emergency Remount R/O
> SysRq : Resetting
> machine restart
> machine restart
> divide error: 0000 [3] PREEMPT SMP 
> CPU 0 
> Modules linked in: ipx p8022 psnap llc esp6 ah6 ipcomp esp4 ah4 xfrm_user wp512 tea sha512 michael_mic md4 khazad cast6 cast5 arc4 anubis nfsd exportfs lockd sunrpc i810_audio ac97_codec soundcore deflate zlib_deflate zlib_inflate twofish serpent aes blowfish des sha256 sha1 crypto_null af_key capability commoncap w83627hf_wdt md5 ipv6 ide_disk ide_cd floppy budget_ci tda1004x budget_core dvb_core saa7146 ttpci_eeprom stv0299 i2c_amd756 hw_random i2c_amd8111 amd74xx eth1394 usblp usb_storage ide_core tg3 usbhid ohci1394 ieee1394 tvaudio bttv tuner video_buf firmware_class v4l2_common btcx_risc tveeprom videodev ohci_hcd usbcore
> Pid: 7741, comm: klogd Not tainted 2.6.11-rc5-2065-64
> RIP: 0010:[<ffffffff801348fc>] <ffffffff801348fc>{scheduler_tick+684}
> RSP: 0000:ffffffff80566660  EFLAGS: 00010046
> RAX: 0000000000000059 RBX: ffff81007c0200b0 RCX: 0000000000000000
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffffff8056cf78
> RBP: ffffffff80566690 R08: 0000000000000000 R09: 0000000000000000
> R10: 00000000ffffffff R11: 0000000000000000 R12: ffff810001e0b6e0
> R13: 000000000000000b R14: 0000000000000059 R15: 0000000000000000
> FS:  0000000000000000(0000) GS:ffffffff805c0300(005b) knlGS:00000000556c12a0
> CS:  0010 DS: 002b ES: 002b CR0: 000000008005003b
> CR2: 00000000557e8670 CR3: 000000007b99f000 CR4: 00000000000006e0
> Process klogd (pid: 7741, threadinfo ffff81007bdea000, task ffff81007c0200b0)
> Stack: 0000000000000000 ffffffff805666b8 ffffffff801159a0 0000000000000000 
>        0000000000000000 0000000000000000 ffffffff805666b8 ffffffff8011c147 
>        0000000000000000 ffffffff8010ee35 
> Call Trace:<IRQ> <ffffffff801159a0>{machine_restart+0} <ffffffff8011c147>{smp_apic_timer_interrupt+55} 
>        <ffffffff8010ee35>{apic_timer_interrupt+133} <ffffffff801159a0>{machine_restart+0} 
>        <ffffffff8011b84c>{smp_stop_cpu+28} <ffffffff8011597b>{smp_halt+123} 
>        <ffffffff801159b7>{machine_restart+23} <ffffffff801159a0>{machine_restart+0} 
>        <ffffffff8011b956>{smp_call_function_interrupt+86} 
>        <ffffffff8010eda9>{call_function_interrupt+133}  <EOI> <ffffffff803581f8>{_spin_unlock_irqrestore+56} 
>        <ffffffff80139d40>{do_syslog+320} <ffffff
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
-- 
Jan Kara <jack@suse.cz>
SuSE CR Labs
