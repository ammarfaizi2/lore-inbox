Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932194AbVKJWDr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932194AbVKJWDr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 17:03:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932195AbVKJWDr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 17:03:47 -0500
Received: from dunaweb1.euroweb.hu ([195.184.0.6]:40889 "EHLO
	szolnok.dunaweb.hu") by vger.kernel.org with ESMTP id S932194AbVKJWDp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 17:03:45 -0500
Message-ID: <4373CAA2.40702@dunaweb.hu>
Date: Thu, 10 Nov 2005 23:33:06 +0100
From: Zoltan Boszormenyi <zboszor@dunaweb.hu>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc3 (X11/20050929)
X-Accept-Language: hu-hu, hu, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Bad page state at prep_new_page in 2.6.14/x86-64
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Occasionally, when I stress the machine, it locks up.
I thought it might be the CPU is overheating, but no.

At the moment, according to "sensors", the CPU temperature
is stable at 44 Celsius despite I am running "make -j6" on
the 2.6.14 kernel tree.

CPU cooler is a Thermaltake Sonictower with two fans attached.
Not a PSU problem either, I just replaced my dying PSU with an
Enermax Noisetaker 420W two days ago. Machine is: Athlon64 3200+,
1GB memory (checked with memtest86+)

I just got a series of oops. Fortunately, it didn't lock up now,
so I could catch these in dmesg:

************************************************************
Bad page state at prep_new_page (in process 'cc1', page ffff8100011e1278)
flags:0x4000000000000004 mapping:0000000000000000 mapcount:0 count:-2228224
Backtrace:

Call Trace:<ffffffff8015def1>{bad_page+113} 
<ffffffff8015ea01>{buffered_rmqueue+609}
        <ffffffff8015ec93>{__alloc_pages+243} 
<ffffffff8016add7>{do_no_page+279}
        <ffffffff8016b339>{__handle_mm_fault+425} 
<ffffffff8017c913>{do_sync_read+211}
        <ffffffff80352646>{do_page_fault+998} 
<ffffffff8822505e>{:xfs:xfs_inactive_free_eofblocks+174}
        <ffffffff88225240>{:xfs:xfs_release+160} <ffffffff80195f13>{dput+35}
        <ffffffff8017dce7>{__fput+375} <ffffffff8010f369>{error_exit+0}

Trying to fix it up, but a reboot is needed
Unable to handle kernel paging request at 000000000a9b7f80 RIP:
<ffffffff881e9b2d>{:xfs:xfs_bmapi+1037}
PGD de24067 PUD faf1067 PMD 0
Oops: 0000 [1] PREEMPT
CPU 0
Modules linked in: radeon ipv6 parport_pc lp parport autofs4 w83627hf 
hwmon_vid hwmon eeprom i2c_isa i2c_viapro i2c_dev i2c_core sunrpc pcmcia 
yenta_socket rsrc_nonstatic pcmcia_core ipt_REJECT ipt_state 
iptable_filter ipt_MASQUERADE iptable_nat ip_nat ip_conntrack nfnetlink 
ip_tables udf loop xfs exportfs dm_mod video button battery ac ohci1394 
ieee1394 uhci_hcd ehci_hcd snd_via82xx gameport snd_ac97_codec 
snd_ac97_bus snd_pcm_oss snd_mixer_oss snd_pcm snd_timer snd_page_alloc 
snd_mpu401_uart snd_rawmidi snd_seq_device snd soundcore r8169 
orinoco_pci orinoco hermes floppy ext3 jbd sata_promise sata_via libata 
sd_mod scsi_mod
Pid: 25164, comm: cc1 Tainted: G    B 2.6.14-ruby #1
RIP: 0010:[<ffffffff881e9b2d>] <ffffffff881e9b2d>{:xfs:xfs_bmapi+1037}
RSP: 0018:ffff81000e503498  EFLAGS: 00010282
RAX: 000000000a9b7f80 RBX: ffff81000a8926b0 RCX: 0000000000000000
RDX: ffff81000e503698 RSI: 0000000000000000 RDI: ffff81000a892690
RBP: 0000000000000001 R08: 0000000000000001 R09: ffff81000e5035f0
R10: 0000000000000000 R11: 0000000000000000 R12: ffff81000a892750
R13: ffff81000e5037b8 R14: 0000000000001000 R15: 0000000000000000
FS:  00002aaaaaae2b00(0000) GS:ffffffff80494800(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000000a9b7f80 CR3: 000000001a04a000 CR4: 00000000000006e0
Process cc1 (pid: 25164, threadinfo ffff81000e502000, task ffff81002959cf80)
Stack: ffff81000e503678 0000000000000000 0000000000000000 0000000000000000
        0000000000000000 0000000000000000 0000000000000000 ffffffffffffffff
        0000000000000000 0000000000000000
Call Trace:<ffffffff8820fce6>{:xfs:xfs_iomap+470} 
<ffffffff8822b808>{:xfs:__linvfs_get_block+136}
        <ffffffff8015a73e>{find_or_create_page+30} 
<ffffffff8822b97b>{:xfs:linvfs_get_block+27}
        <ffffffff801a44b3>{do_mpage_readpage+211} 
<ffffffff8822b960>{:xfs:linvfs_get_block+0}
        <ffffffff8822ce6f>{:xfs:xfs_buf_get_flags+799} 
<ffffffff801fc4d3>{radix_tree_node_alloc+19}
        <ffffffff801fc723>{radix_tree_insert+307} 
<ffffffff801a4842>{mpage_readpages+162}
        <ffffffff8822b960>{:xfs:linvfs_get_block+0} 
<ffffffff881f39f7>{:xfs:xfs_da_do_buf+1207}
        <ffffffff8015ec93>{__alloc_pages+243} 
<ffffffff80161412>{__do_page_cache_readahead+402}
        <ffffffff881f936c>{:xfs:xfs_dir2_block_lookup_int+364}
        <ffffffff801616cd>{blockable_page_cache_readahead+109}
        <ffffffff80161915>{page_cache_readahead+293} 
<ffffffff8015ab1d>{do_generic_mapping_read+381}
        <ffffffff8015af20>{file_read_actor+0} 
<ffffffff8015ce88>{__generic_file_aio_read+424}
        <ffffffff88231b1c>{:xfs:xfs_read+540} 
<ffffffff8822e294>{:xfs:linvfs_aio_read+100}
        <ffffffff8017c913>{do_sync_read+211} 
<ffffffff8014a5f0>{autoremove_wake_function+0}
        <ffffffff8017ca36>{vfs_read+230} <ffffffff8017cdf3>{sys_read+83}
        <ffffffff8010ea76>{system_call+126}

Code: 02 00 00 45 8b 02 45 85 c0 0f 8e 45 1a 00 00 48 8b 84 24 38
RIP <ffffffff881e9b2d>{:xfs:xfs_bmapi+1037} RSP <ffff81000e503498>
CR2: 000000000a9b7f80
  <0>Bad page state at prep_new_page (in process 'cc1', page 
ffff8100012e3b78)
flags:0x4000000000000004 mapping:0000000000000000 mapcount:0 count:-65536
Backtrace:

Call Trace:<ffffffff8015def1>{bad_page+113} 
<ffffffff8015ea01>{buffered_rmqueue+609}
        <ffffffff8015ec93>{__alloc_pages+243} 
<ffffffff8016add7>{do_no_page+279}
        <ffffffff8016b339>{__handle_mm_fault+425} 
<ffffffff80352646>{do_page_fault+998}
        <ffffffff8010f369>{error_exit+0}
Trying to fix it up, but a reboot is needed
Bad page state at free_hot_cold_page (in process 'cc1', page 
ffff8100015a80e8)
flags:0x4000000000000814 mapping:0000000000000000 mapcount:0 count:0
Backtrace:

Call Trace:<ffffffff8015def1>{bad_page+113} 
<ffffffff8015e6a6>{free_hot_cold_page+118}
        <ffffffff8016982c>{unmap_vmas+1372} 
<ffffffff8016f000>{exit_mmap+128}
        <ffffffff80130c2f>{mmput+31} <ffffffff80135d1a>{do_exit+474}
        <ffffffff80136968>{do_group_exit+280} 
<ffffffff8010ea76>{system_call+126}

Trying to fix it up, but a reboot is needed
Bad page state at free_hot_cold_page (in process 'cc1', page 
ffff81000138e5e8)
flags:0x4000000000000814 mapping:0000000000000000 mapcount:0 count:0
Backtrace:

Call Trace:<ffffffff8015def1>{bad_page+113} 
<ffffffff8015e6a6>{free_hot_cold_page+118}
        <ffffffff801645ff>{__page_cache_release+191} 
<ffffffff8016982c>{unmap_vmas+1372}
        <ffffffff8016f000>{exit_mmap+128} <ffffffff80130c2f>{mmput+31}
        <ffffffff80135d1a>{do_exit+474} 
<ffffffff80136968>{do_group_exit+280}
        <ffffffff8010ea76>{system_call+126}
Trying to fix it up, but a reboot is needed
Bad page state at free_hot_cold_page (in process 'cc1', page 
ffff8100012415d0)
flags:0x4000000000000814 mapping:0000000000000000 mapcount:0 count:0
Backtrace:

Call Trace:<ffffffff8015def1>{bad_page+113} 
<ffffffff8015e6a6>{free_hot_cold_page+118}
        <ffffffff801645ff>{__page_cache_release+191} 
<ffffffff8016982c>{unmap_vmas+1372}
        <ffffffff8016f000>{exit_mmap+128} <ffffffff80130c2f>{mmput+31}
        <ffffffff80135d1a>{do_exit+474} 
<ffffffff80136968>{do_group_exit+280}
        <ffffffff8010ea76>{system_call+126}
Trying to fix it up, but a reboot is needed
Bad page state at free_hot_cold_page (in process 'cc1', page 
ffff810001295d40)
flags:0x4000000000000814 mapping:0000000000000000 mapcount:0 count:0
Backtrace:

Call Trace:<ffffffff8015def1>{bad_page+113} 
<ffffffff8015e6a6>{free_hot_cold_page+118}
        <ffffffff801645ff>{__page_cache_release+191} 
<ffffffff8016982c>{unmap_vmas+1372}
        <ffffffff8016f000>{exit_mmap+128} <ffffffff80130c2f>{mmput+31}
        <ffffffff80135d1a>{do_exit+474} 
<ffffffff80136968>{do_group_exit+280}
        <ffffffff8010ea76>{system_call+126}
Trying to fix it up, but a reboot is needed
Bad page state at free_hot_cold_page (in process 'cc1', page 
ffff8100016d9f70)
flags:0x4000000000000814 mapping:0000000000000000 mapcount:0 count:0
Backtrace:

Call Trace:<ffffffff8015def1>{bad_page+113} 
<ffffffff8015e6a6>{free_hot_cold_page+118}
        <ffffffff8016982c>{unmap_vmas+1372} 
<ffffffff8016f000>{exit_mmap+128}
        <ffffffff80130c2f>{mmput+31} <ffffffff80135d1a>{do_exit+474}
        <ffffffff80136968>{do_group_exit+280} 
<ffffffff8010ea76>{system_call+126}

Trying to fix it up, but a reboot is needed
Bad page state at free_hot_cold_page (in process 'cc1', page 
ffff810001332cf0)
flags:0x4000000000000814 mapping:0000000000000000 mapcount:0 count:0
Backtrace:

Call Trace:<ffffffff8015def1>{bad_page+113} 
<ffffffff8015e6a6>{free_hot_cold_page+118}
        <ffffffff8016982c>{unmap_vmas+1372} 
<ffffffff8016f000>{exit_mmap+128}
        <ffffffff80130c2f>{mmput+31} <ffffffff80135d1a>{do_exit+474}
        <ffffffff80136968>{do_group_exit+280} 
<ffffffff8010ea76>{system_call+126}

Trying to fix it up, but a reboot is needed
Bad page state at free_hot_cold_page (in process 'cc1', page 
ffff810001162868)
flags:0x4000000000000814 mapping:0000000000000000 mapcount:0 count:0
Backtrace:

Call Trace:<ffffffff8015def1>{bad_page+113} 
<ffffffff8015e6a6>{free_hot_cold_page+118}
        <ffffffff8016982c>{unmap_vmas+1372} 
<ffffffff8016f000>{exit_mmap+128}
        <ffffffff80130c2f>{mmput+31} <ffffffff80135d1a>{do_exit+474}
        <ffffffff80136968>{do_group_exit+280} 
<ffffffff8010ea76>{system_call+126}

Trying to fix it up, but a reboot is needed
Bad page state at free_hot_cold_page (in process 'cc1', page 
ffff8100011cbd38)
flags:0x4000000000000814 mapping:0000000000000000 mapcount:0 count:0
Backtrace:

Call Trace:<ffffffff8015def1>{bad_page+113} 
<ffffffff8015e6a6>{free_hot_cold_page+118}
        <ffffffff8016982c>{unmap_vmas+1372} 
<ffffffff8016f000>{exit_mmap+128}
        <ffffffff80130c2f>{mmput+31} <ffffffff80135d1a>{do_exit+474}
        <ffffffff80136968>{do_group_exit+280} 
<ffffffff8010ea76>{system_call+126}

Trying to fix it up, but a reboot is needed
Bad page state at free_hot_cold_page (in process 'cc1', page 
ffff81000137dc58)
flags:0x4000000000000814 mapping:0000000000000000 mapcount:0 count:0
Backtrace:

Call Trace:<ffffffff8015def1>{bad_page+113} 
<ffffffff8015e6a6>{free_hot_cold_page+118}
        <ffffffff801645ff>{__page_cache_release+191} 
<ffffffff8016982c>{unmap_vmas+1372}
        <ffffffff8016f000>{exit_mmap+128} <ffffffff80130c2f>{mmput+31}
        <ffffffff80135d1a>{do_exit+474} 
<ffffffff80136968>{do_group_exit+280}
        <ffffffff8010ea76>{system_call+126}
Trying to fix it up, but a reboot is needed
Bad page state at free_hot_cold_page (in process 'cc1', page 
ffff8100012b9f30)
flags:0x4000000000000814 mapping:0000000000000000 mapcount:0 count:0
Backtrace:

Call Trace:<ffffffff8015def1>{bad_page+113} 
<ffffffff8015e6a6>{free_hot_cold_page+118}
        <ffffffff801645ff>{__page_cache_release+191} 
<ffffffff8016982c>{unmap_vmas+1372}
        <ffffffff8016f000>{exit_mmap+128} <ffffffff80130c2f>{mmput+31}
        <ffffffff80135d1a>{do_exit+474} 
<ffffffff80136968>{do_group_exit+280}
        <ffffffff8010ea76>{system_call+126}
Trying to fix it up, but a reboot is needed
Bad page state at free_hot_cold_page (in process 'cc1', page 
ffff8100012f57a0)
flags:0x4000000000000814 mapping:0000000000000000 mapcount:0 count:0
Backtrace:

Call Trace:<ffffffff8015def1>{bad_page+113} 
<ffffffff8015e6a6>{free_hot_cold_page+118}
        <ffffffff801645ff>{__page_cache_release+191} 
<ffffffff8016982c>{unmap_vmas+1372}
        <ffffffff8016f000>{exit_mmap+128} <ffffffff80130c2f>{mmput+31}
        <ffffffff80135d1a>{do_exit+474} 
<ffffffff80136968>{do_group_exit+280}
        <ffffffff8010ea76>{system_call+126}
Trying to fix it up, but a reboot is needed
Bad page state at free_hot_cold_page (in process 'cc1', page 
ffff810001633b70)
flags:0x4000000000000814 mapping:0000000000000000 mapcount:0 count:0
Backtrace:

Call Trace:<ffffffff8015def1>{bad_page+113} 
<ffffffff8015e6a6>{free_hot_cold_page+118}
        <ffffffff801645ff>{__page_cache_release+191} 
<ffffffff8016982c>{unmap_vmas+1372}
        <ffffffff8016f000>{exit_mmap+128} <ffffffff80130c2f>{mmput+31}
        <ffffffff80135d1a>{do_exit+474} 
<ffffffff80136968>{do_group_exit+280}
        <ffffffff8010ea76>{system_call+126}
Trying to fix it up, but a reboot is needed
Bad page state at free_hot_cold_page (in process 'cc1', page 
ffff810001150b60)
flags:0x4000000000000814 mapping:0000000000000000 mapcount:0 count:0
Backtrace:

Call Trace:<ffffffff8015def1>{bad_page+113} 
<ffffffff8015e6a6>{free_hot_cold_page+118}
        <ffffffff8016982c>{unmap_vmas+1372} 
<ffffffff8016f000>{exit_mmap+128}
        <ffffffff80130c2f>{mmput+31} <ffffffff80135d1a>{do_exit+474}
        <ffffffff80136968>{do_group_exit+280} 
<ffffffff8010ea76>{system_call+126}

Trying to fix it up, but a reboot is needed
Bad page state at free_hot_cold_page (in process 'cc1', page 
ffff8100010fb778)
flags:0x4000000000000814 mapping:0000000000000000 mapcount:0 count:0
Backtrace:

Call Trace:<ffffffff8015def1>{bad_page+113} 
<ffffffff8015e6a6>{free_hot_cold_page+118}
        <ffffffff801645ff>{__page_cache_release+191} 
<ffffffff8016982c>{unmap_vmas+1372}
        <ffffffff8016f000>{exit_mmap+128} <ffffffff80130c2f>{mmput+31}
        <ffffffff80135d1a>{do_exit+474} 
<ffffffff80136968>{do_group_exit+280}
        <ffffffff8010ea76>{system_call+126}
Trying to fix it up, but a reboot is needed
Bad page state at free_hot_cold_page (in process 'cc1', page 
ffff8100010e7c40)
flags:0x4000000000000814 mapping:0000000000000000 mapcount:0 count:0
Backtrace:

Call Trace:<ffffffff8015def1>{bad_page+113} 
<ffffffff8015e6a6>{free_hot_cold_page+118}
        <ffffffff801645ff>{__page_cache_release+191} 
<ffffffff8016982c>{unmap_vmas+1372}
        <ffffffff8016f000>{exit_mmap+128} <ffffffff80130c2f>{mmput+31}
        <ffffffff80135d1a>{do_exit+474} 
<ffffffff80136968>{do_group_exit+280}
        <ffffffff8010ea76>{system_call+126}
Trying to fix it up, but a reboot is needed
Bad page state at free_hot_cold_page (in process 'cc1', page 
ffff810001254998)
flags:0x4000000000000814 mapping:0000000000000000 mapcount:0 count:0
Backtrace:

Call Trace:<ffffffff8015def1>{bad_page+113} 
<ffffffff8015e6a6>{free_hot_cold_page+118}
        <ffffffff801645ff>{__page_cache_release+191} 
<ffffffff8016982c>{unmap_vmas+1372}
        <ffffffff8016f000>{exit_mmap+128} <ffffffff80130c2f>{mmput+31}
        <ffffffff80135d1a>{do_exit+474} 
<ffffffff80136968>{do_group_exit+280}
        <ffffffff8010ea76>{system_call+126}
Trying to fix it up, but a reboot is needed
Bad page state at free_hot_cold_page (in process 'cc1', page 
ffff81000139faa0)
flags:0x4000000000000814 mapping:0000000000000000 mapcount:0 count:0
Backtrace:

Call Trace:<ffffffff8015def1>{bad_page+113} 
<ffffffff8015e6a6>{free_hot_cold_page+118}
        <ffffffff801645ff>{__page_cache_release+191} 
<ffffffff8016982c>{unmap_vmas+1372}
        <ffffffff8016f000>{exit_mmap+128} <ffffffff80130c2f>{mmput+31}
        <ffffffff80135d1a>{do_exit+474} 
<ffffffff80136968>{do_group_exit+280}
        <ffffffff8010ea76>{system_call+126}
Trying to fix it up, but a reboot is needed
Bad page state at free_hot_cold_page (in process 'cc1', page 
ffff8100011b9b98)
flags:0x4000000000000814 mapping:0000000000000000 mapcount:0 count:0
Backtrace:

Call Trace:<ffffffff8015def1>{bad_page+113} 
<ffffffff8015e6a6>{free_hot_cold_page+118}
        <ffffffff801645ff>{__page_cache_release+191} 
<ffffffff8016982c>{unmap_vmas+1372}
        <ffffffff8016f000>{exit_mmap+128} <ffffffff80130c2f>{mmput+31}
        <ffffffff80135d1a>{do_exit+474} 
<ffffffff80136968>{do_group_exit+280}
        <ffffffff8010ea76>{system_call+126}
Trying to fix it up, but a reboot is needed
Bad page state at free_hot_cold_page (in process 'cc1', page 
ffff8100010ee5b0)
flags:0x4000000000000814 mapping:0000000000000000 mapcount:0 count:0
Backtrace:

Call Trace:<ffffffff8015def1>{bad_page+113} 
<ffffffff8015e6a6>{free_hot_cold_page+118}
        <ffffffff801645ff>{__page_cache_release+191} 
<ffffffff8016982c>{unmap_vmas+1372}
        <ffffffff8016f000>{exit_mmap+128} <ffffffff80130c2f>{mmput+31}
        <ffffffff80135d1a>{do_exit+474} 
<ffffffff80136968>{do_group_exit+280}
        <ffffffff8010ea76>{system_call+126}
Trying to fix it up, but a reboot is needed
Bad page state at free_hot_cold_page (in process 'cc1', page 
ffff8100014740b0)
flags:0x4000000000000814 mapping:0000000000000000 mapcount:0 count:0
Backtrace:

Call Trace:<ffffffff8015def1>{bad_page+113} 
<ffffffff8015e6a6>{free_hot_cold_page+118}
        <ffffffff801645ff>{__page_cache_release+191} 
<ffffffff8016982c>{unmap_vmas+1372}
        <ffffffff8016f000>{exit_mmap+128} <ffffffff80130c2f>{mmput+31}
        <ffffffff80135d1a>{do_exit+474} 
<ffffffff80136968>{do_group_exit+280}
        <ffffffff8010ea76>{system_call+126}
Trying to fix it up, but a reboot is needed
Bad page state at free_hot_cold_page (in process 'cc1', page 
ffff8100012883d0)
flags:0x4000000000000814 mapping:0000000000000000 mapcount:0 count:0
Backtrace:

Call Trace:<ffffffff8015def1>{bad_page+113} 
<ffffffff8015e6a6>{free_hot_cold_page+118}
        <ffffffff8016982c>{unmap_vmas+1372} 
<ffffffff8016f000>{exit_mmap+128}
        <ffffffff80130c2f>{mmput+31} <ffffffff80135d1a>{do_exit+474}
        <ffffffff80136968>{do_group_exit+280} 
<ffffffff8010ea76>{system_call+126}

Trying to fix it up, but a reboot is needed
Bad page state at free_hot_cold_page (in process 'cc1', page 
ffff810001188000)
flags:0x4000000000000814 mapping:0000000000000000 mapcount:0 count:0
Backtrace:

Call Trace:<ffffffff8015def1>{bad_page+113} 
<ffffffff8015e6a6>{free_hot_cold_page+118}
        <ffffffff8016982c>{unmap_vmas+1372} 
<ffffffff8016f000>{exit_mmap+128}
        <ffffffff80130c2f>{mmput+31} <ffffffff80135d1a>{do_exit+474}
        <ffffffff80136968>{do_group_exit+280} 
<ffffffff8010ea76>{system_call+126}

Trying to fix it up, but a reboot is needed
Bad page state at free_hot_cold_page (in process 'cc1', page 
ffff8100011cff48)
flags:0x4000000000000814 mapping:0000000000000000 mapcount:0 count:0
Backtrace:

Call Trace:<ffffffff8015def1>{bad_page+113} 
<ffffffff8015e6a6>{free_hot_cold_page+118}
        <ffffffff8016982c>{unmap_vmas+1372} 
<ffffffff8016f000>{exit_mmap+128}
        <ffffffff80130c2f>{mmput+31} <ffffffff80135d1a>{do_exit+474}
        <ffffffff80136968>{do_group_exit+280} 
<ffffffff8010ea76>{system_call+126}

Trying to fix it up, but a reboot is needed
Bad page state at free_hot_cold_page (in process 'cc1', page 
ffff810001361210)
flags:0x4000000000000814 mapping:0000000000000000 mapcount:0 count:0
Backtrace:

Call Trace:<ffffffff8015def1>{bad_page+113} 
<ffffffff8015e6a6>{free_hot_cold_page+118}
        <ffffffff8016982c>{unmap_vmas+1372} 
<ffffffff8016f000>{exit_mmap+128}
        <ffffffff80130c2f>{mmput+31} <ffffffff80135d1a>{do_exit+474}
        <ffffffff80136968>{do_group_exit+280} 
<ffffffff8010ea76>{system_call+126}

Trying to fix it up, but a reboot is needed
Bad page state at free_hot_cold_page (in process 'cc1', page 
ffff8100011a1638)
flags:0x4000000000000814 mapping:0000000000000000 mapcount:0 count:0
Backtrace:

Call Trace:<ffffffff8015def1>{bad_page+113} 
<ffffffff8015e6a6>{free_hot_cold_page+118}
        <ffffffff8016982c>{unmap_vmas+1372} 
<ffffffff8016f000>{exit_mmap+128}
        <ffffffff80130c2f>{mmput+31} <ffffffff80135d1a>{do_exit+474}
        <ffffffff80136968>{do_group_exit+280} 
<ffffffff8010ea76>{system_call+126}

Trying to fix it up, but a reboot is needed
Bad page state at free_hot_cold_page (in process 'cc1', page 
ffff810001296558)
flags:0x4000000000000814 mapping:0000000000000000 mapcount:0 count:0
Backtrace:

Call Trace:<ffffffff8015def1>{bad_page+113} 
<ffffffff8015e6a6>{free_hot_cold_page+118}
        <ffffffff801645ff>{__page_cache_release+191} 
<ffffffff8016982c>{unmap_vmas+1372}
        <ffffffff8016f000>{exit_mmap+128} <ffffffff80130c2f>{mmput+31}
        <ffffffff80135d1a>{do_exit+474} 
<ffffffff80136968>{do_group_exit+280}
        <ffffffff8010ea76>{system_call+126}
Trying to fix it up, but a reboot is needed
Bad page state at free_hot_cold_page (in process 'cc1', page 
ffff8100014198c8)
flags:0x4000000000000814 mapping:0000000000000000 mapcount:0 count:0
Backtrace:

Call Trace:<ffffffff8015def1>{bad_page+113} 
<ffffffff8015e6a6>{free_hot_cold_page+118}
        <ffffffff801645ff>{__page_cache_release+191} 
<ffffffff8016982c>{unmap_vmas+1372}
        <ffffffff8016f000>{exit_mmap+128} <ffffffff80130c2f>{mmput+31}
        <ffffffff80135d1a>{do_exit+474} 
<ffffffff80136968>{do_group_exit+280}
        <ffffffff8010ea76>{system_call+126}
Trying to fix it up, but a reboot is needed
Bad page state at free_hot_cold_page (in process 'cc1', page 
ffff810001341770)
flags:0x4000000000000814 mapping:0000000000000000 mapcount:0 count:0
Backtrace:

Call Trace:<ffffffff8015def1>{bad_page+113} 
<ffffffff8015e6a6>{free_hot_cold_page+118}
        <ffffffff8016982c>{unmap_vmas+1372} 
<ffffffff8016f000>{exit_mmap+128}
        <ffffffff80130c2f>{mmput+31} <ffffffff80135d1a>{do_exit+474}
        <ffffffff80136968>{do_group_exit+280} 
<ffffffff8010ea76>{system_call+126}

Trying to fix it up, but a reboot is needed
Bad page state at free_hot_cold_page (in process 'cc1', page 
ffff810001191e60)
flags:0x4000000000000814 mapping:0000000000000000 mapcount:0 count:0
Backtrace:

Call Trace:<ffffffff8015def1>{bad_page+113} 
<ffffffff8015e6a6>{free_hot_cold_page+118}
        <ffffffff8016982c>{unmap_vmas+1372} 
<ffffffff8016f000>{exit_mmap+128}
        <ffffffff80130c2f>{mmput+31} <ffffffff80135d1a>{do_exit+474}
        <ffffffff80136968>{do_group_exit+280} 
<ffffffff8010ea76>{system_call+126}

Trying to fix it up, but a reboot is needed
Bad page state at free_hot_cold_page (in process 'cc1', page 
ffff810001351c30)
flags:0x4000000000000814 mapping:0000000000000000 mapcount:0 count:0
Backtrace:

Call Trace:<ffffffff8015def1>{bad_page+113} 
<ffffffff8015e6a6>{free_hot_cold_page+118}
        <ffffffff801645ff>{__page_cache_release+191} 
<ffffffff8016982c>{unmap_vmas+1372}
        <ffffffff8016f000>{exit_mmap+128} <ffffffff80130c2f>{mmput+31}
        <ffffffff80135d1a>{do_exit+474} 
<ffffffff80136968>{do_group_exit+280}
        <ffffffff8010ea76>{system_call+126}
Trying to fix it up, but a reboot is needed
Bad page state at free_hot_cold_page (in process 'cc1', page 
ffff81000160dd10)
flags:0x4000000000000814 mapping:0000000000000000 mapcount:0 count:0
Backtrace:

Call Trace:<ffffffff8015def1>{bad_page+113} 
<ffffffff8015e6a6>{free_hot_cold_page+118}
        <ffffffff801645ff>{__page_cache_release+191} 
<ffffffff8016982c>{unmap_vmas+1372}
        <ffffffff8016f000>{exit_mmap+128} <ffffffff80130c2f>{mmput+31}
        <ffffffff80135d1a>{do_exit+474} 
<ffffffff80136968>{do_group_exit+280}
        <ffffffff8010ea76>{system_call+126}
Trying to fix it up, but a reboot is needed
Unable to handle kernel paging request at 0000000000100108 RIP:
<ffffffff80164582>{__page_cache_release+66}
PGD 3e3b6067 PUD 0
Oops: 0002 [2] PREEMPT
CPU 0
Modules linked in: radeon ipv6 parport_pc lp parport autofs4 w83627hf 
hwmon_vid hwmon eeprom i2c_isa i2c_viapro i2c_dev i2c_core sunrpc pcmcia 
yenta_socket rsrc_nonstatic pcmcia_core ipt_REJECT ipt_state 
iptable_filter ipt_MASQUERADE iptable_nat ip_nat ip_conntrack nfnetlink 
ip_tables udf loop xfs exportfs dm_mod video button battery ac ohci1394 
ieee1394 uhci_hcd ehci_hcd snd_via82xx gameport snd_ac97_codec 
snd_ac97_bus snd_pcm_oss snd_mixer_oss snd_pcm snd_timer snd_page_alloc 
snd_mpu401_uart snd_rawmidi snd_seq_device snd soundcore r8169 
orinoco_pci orinoco hermes floppy ext3 jbd sata_promise sata_via libata 
sd_mod scsi_mod
Pid: 26721, comm: cc1 Tainted: G    B 2.6.14-ruby #1
RIP: 0010:[<ffffffff80164582>] <ffffffff80164582>{__page_cache_release+66}
RSP: 0018:ffff810007443db8  EFLAGS: 00010086
RAX: 0000000000100100 RBX: ffff8100011ccf98 RCX: ffff8100011ccfc0
RDX: 0000000000200200 RSI: ffffffff803c8c28 RDI: ffff8100011ccf98
RBP: 00002aaaae8d0000 R08: ffff810001e26200 R09: 0000000000000002
R10: 00000000ffffffff R11: 0000000000000001 R12: 80000000083b5067
R13: ffff8100011ccf98 R14: 00002aaaae8d2000 R15: ffffffff804418c0
FS:  00002aaaaaae2b00(0000) GS:ffffffff80494800(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 0000000000100108 CR3: 000000003dbc1000 CR4: 00000000000006e0
Process cc1 (pid: 26721, threadinfo ffff810007442000, task ffff81001cd304c0)
Stack: ffff81001447a678 0000000000000212 ffff81001447a680 ffffffff8016982c
        00002aaaad9e1fff 00002aaaae8d1fff 00002aaaae8d1fff 00002aaaae8d1fff
        ffff810016100ba0 00002aaaae8d2000
Call Trace:<ffffffff8016982c>{unmap_vmas+1372} 
<ffffffff8016f000>{exit_mmap+128}
        <ffffffff80130c2f>{mmput+31} <ffffffff80135d1a>{do_exit+474}
        <ffffffff80136968>{do_group_exit+280} 
<ffffffff8010ea76>{system_call+126}


Code: 48 89 50 08 48 89 02 48 c7 41 08 00 02 20 00 8b 07 48 c7 47
RIP <ffffffff80164582>{__page_cache_release+66} RSP <ffff810007443db8>
CR2: 0000000000100108
  <1>Fixing recursive fault but reboot is needed!
scheduling while atomic: cc1/0x00000002/26721

Call Trace:<ffffffff8034fd9a>{__sched_text_start+122} 
<ffffffff80351663>{__down_read+51}
        <ffffffff80351685>{__down_read+85} <ffffffff80135c3d>{do_exit+253}
        <ffffffff80246fb9>{do_unblank_screen+25} 
<ffffffff80352972>{do_page_fault+1810}
        <ffffffff8821f00b>{:xfs:xfs_trans_tail_ail+27} 
<ffffffff8013403d>{printk+141}
        <ffffffff8010f369>{error_exit+0} 
<ffffffff80164582>{__page_cache_release+66}
        <ffffffff8016982c>{unmap_vmas+1372} 
<ffffffff8016f000>{exit_mmap+128}
        <ffffffff80130c2f>{mmput+31} <ffffffff80135d1a>{do_exit+474}
        <ffffffff80136968>{do_group_exit+280} 
<ffffffff8010ea76>{system_call+126}

Bad page state at __free_pages_ok (in process 'syslogd', page 
ffff8100011ccf98)
flags:0x4000000000000054 mapping:ffff81001cd3a8f9 mapcount:0 count:0
Backtrace:

Call Trace:<ffffffff8015def1>{bad_page+113} 
<ffffffff8015e2bf>{__free_pages_ok+127}
        <ffffffff80130822>{free_task+18} 
<ffffffff80134e09>{release_task+361}
        <ffffffff80137501>{do_wait+2433} 
<ffffffff8012f430>{default_wake_function+0}
        <ffffffff8012f430>{default_wake_function+0} 
<ffffffff8010eaff>{sysret_signal+28}
        <ffffffff8010ea76>{system_call+126}
Trying to fix it up, but a reboot is needed
Bad page state at prep_new_page (in process 'sh', page ffff8100013412a0)
flags:0x4000000000000064 mapping:ffff81001cd3a8f9 mapcount:1 count:1
Backtrace:

Call Trace:<ffffffff8015def1>{bad_page+113} 
<ffffffff8015ea01>{buffered_rmqueue+609}
        <ffffffff8015ec93>{__alloc_pages+243} 
<ffffffff8015efff>{__get_free_pages+31}
        <ffffffff8013097a>{dup_task_struct+58} 
<ffffffff80131825>{copy_process+181}
        <ffffffff8013295f>{do_fork+239} <ffffffff801979e2>{d_rehash+98}
        <ffffffff80141c74>{sys_rt_sigaction+148} 
<ffffffff8010ea76>{system_call+126}
        <ffffffff8010ede7>{ptregscall_common+103}
Trying to fix it up, but a reboot is needed
************************************************************

All my filesystems (except /boot and /) are XFS,
maybe it was a bad idea to install FC3 this way. :-(
Next time I reinstall, I will stick to ext3.

Best regards,
Zoltán Böszörményi

