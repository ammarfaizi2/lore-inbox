Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266020AbTBTQsQ>; Thu, 20 Feb 2003 11:48:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266043AbTBTQsQ>; Thu, 20 Feb 2003 11:48:16 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:22793 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S266020AbTBTQsF>; Thu, 20 Feb 2003 11:48:05 -0500
Date: Thu, 20 Feb 2003 08:54:55 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
cc: Ingo Molnar <mingo@elte.hu>, Dave Hansen <haveblue@us.ibm.com>,
       Zwane Mwaikambo <zwane@holomorphy.com>, Chris Wedgwood <cw@f00f.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       William Lee Irwin III <wli@holomorphy.com>
Subject: Re: doublefault debugging (was Re: Linux v2.5.62 --- spontaneous
 reboots)
In-Reply-To: <39710000.1045757490@[10.10.2.4]>
Message-ID: <Pine.LNX.4.44.0302200847060.2493-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 20 Feb 2003, Martin J. Bligh wrote:
> 
> There are patches in -mjb from Dave Hansen / Ben LaHaise to detect stack
> overflow included with the stuff for the 4K stacks patch (intended for 
> scaling to large numbers of tasks). I've split them out attatched, should 
> apply to mainline reasonably easily.

Ok, the 4kB stack definitely won't work in real life, but that's because 
we have some hopelessly bad stack users in the kernel. But the debugging 
part would be good to try (in fact, it might be a good idea to keep the 
8kB stack, but with rather anal debugging. Just the "mcount" part should 
do that).

A sorted list of bad stack users (more than 256 bytes) in my default build
follows. Anybody can create their own with something like

	objdump -d linux/vmlinux |
		grep 'sub.*$0x...,.*esp' |
		awk '{ print $9,$1 }' |
		sort > bigstack

and a script to look up the addresses.

That ide_unregister() thing uses up >2kB in just one call! And there are 
several in the 1.5kB range too, with a long list of ~500 byte offenders.

Yeah, and this assumes we don't have alloca() users or other dynamic 
stack allocators (non-constant-size automatic arrays). I hope we don't 
have that kind of crap anywhere..

			Linus

-----
0xc02ae062 <ide_unregister+8>:				sub    $0x8c4,%esp
0xc010535d <huft_build+9>:				sub    $0x5b0,%esp
0xc0326a53 <snd_pcm_oss_change_params+6>:		sub    $0x590,%esp
0xc0106156 <inflate_dynamic+6>:				sub    $0x554,%esp
0xc0176150 <elf_core_dump+13>:				sub    $0x4b4,%esp
0xc0105fb8 <inflate_fixed+7>:				sub    $0x4ac,%esp
0xc035935e <pci_sanity_check+6>:			sub    $0x398,%esp
0xc035986d <pcibios_fixup_peer_bridges+5>:		sub    $0x394,%esp
0xc0334b85 <snd_pcm_hw_params_old_user+8>:		sub    $0x37c,%esp
0xc0334a97 <snd_pcm_hw_refine_old_user+8>:		sub    $0x37c,%esp
0xc02fbc74 <cb_alloc+6>:				sub    $0x32c,%esp
0xc0211b2a <pci_do_scan_bus+14>:			sub    $0x314,%esp
0xc034be58 <snd_seq_midisynth_register_port+12>:	sub    $0x2f0,%esp
0xc0264406 <extract_entropy+6>:				sub    $0x2d8,%esp
0xc02fcdde <ds_ioctl+3>:				sub    $0x2c8,%esp
0xc01dbd6b <udf_load_pvoldesc+6>:			sub    $0x2bc,%esp
0xc0329c6e <snd_pcm_oss_proc_write+6>:			sub    $0x298,%esp
0xc02a218f <pcnet_config+6>:				sub    $0x294,%esp
0xc01c8457 <nlmclnt_proc+14>:				sub    $0x294,%esp
0xc0327ecc <snd_pcm_oss_get_formats+12>:		sub    $0x290,%esp
0xc01d781f <udf_add_entry+6>:				sub    $0x290,%esp
0xc01c8e56 <nlmclnt_reclaim+18>:			sub    $0x280,%esp
0xc0330802 <snd_pcm_hw_params_user+8>:			sub    $0x27c,%esp
0xc03304af <snd_pcm_hw_refine_user+8>:			sub    $0x27c,%esp
0xc01ea4c9 <reiserfs_rename+13>:			sub    $0x27c,%esp
0xc029b57c <e100_ethtool_eeprom+10>:			sub    $0x260,%esp
0xc020a9df <semctl_main+12>:				sub    $0x25c,%esp
0xc0267205 <do_kdgkb_ioctl+24>:				sub    $0x244,%esp
0xc01d0ac8 <do_udf_readdir+6>:				sub    $0x240,%esp
0xc01e137a <udf_get_filename+3>:			sub    $0x23c,%esp
0xc01bd38c <find_exported_dentry+8>:			sub    $0x234,%esp
0xc01a5fa4 <fat_readdirx+15>:				sub    $0x230,%esp
0xc01fe813 <reiserfs_delete_solid_item+6>:		sub    $0x22c,%esp
0xc031f24d <snd_iprintf+3>:				sub    $0x21c,%esp
0xc02b4d6f <cdrom_read_intr+8>:				sub    $0x21c,%esp
0xc024adfb <pnp_printf+3>:				sub    $0x218,%esp
0xc02b4cac <cdrom_buffer_sectors+11>:			sub    $0x210,%esp
0xc01ebf96 <reiserfs_get_block+8>:			sub    $0x210,%esp
0xc020b2f0 <sys_semtimedop+3>:				sub    $0x208,%esp
0xc01fe58d <reiserfs_delete_item+12>:			sub    $0x208,%esp
0xc0529e98 <snd_seq_oss_create_client+12>:		sub    $0x204,%esp
0xc038efed <tcp_check_req+6>:				sub    $0x1f8,%esp
0xc038b462 <tcp_v4_conn_request+6>:			sub    $0x1f8,%esp
0xc01fef81 <reiserfs_cut_from_item+6>:			sub    $0x1f8,%esp
0xc038df7f <tcp_timewait_state_process+8>:		sub    $0x1e4,%esp
0xc0325539 <snd_mixer_oss_build_input+3>:		sub    $0x1e0,%esp
0xc01d9328 <udf_symlink+13>:				sub    $0x1cc,%esp
0xc01ffb15 <reiserfs_insert_item+6>:			sub    $0x1c4,%esp
0xc01ffa03 <reiserfs_paste_into_item+6>:		sub    $0x1c4,%esp
0xc01c43b6 <svc_export_parse+3>:			sub    $0x1c4,%esp
0xc02f6770 <pcmcia_validate_cis+3>:			sub    $0x1c0,%esp
0xc052a2c7 <snd_seq_system_client_init+24>:		sub    $0x1bc,%esp
0xc03511c9 <snd_intel8x0_mixer+13>:			sub    $0x1bc,%esp
0xc01a54f8 <fat_search_long+6>:				sub    $0x1b4,%esp
0xc052a0a1 <snd_seq_oss_midi_lookup_ports+9>:		sub    $0x1ac,%esp
0xc02e99f5 <sg_ioctl+6>:				sub    $0x19c,%esp
0xc0320fb0 <snd_ctl_card_info+12>:			sub    $0x198,%esp
0xc0171860 <ep_send_events+8>:				sub    $0x198,%esp
0xc0155ad4 <blkdev_get+11>:				sub    $0x194,%esp
0xc01b3bea <nfs_symlink+6>:				sub    $0x18c,%esp
0xc01b2699 <nfs_readdir+9>:				sub    $0x18c,%esp
0xc01b347d <nfs_mknod+6>:				sub    $0x17c,%esp
0xc01d71e3 <udf_find_entry+6>:				sub    $0x178,%esp
0xc01b333d <nfs_create+6>:				sub    $0x178,%esp
0xc01b35ca <nfs_mkdir+6>:				sub    $0x174,%esp
0xc02873a3 <radeon_cp_vertex2+3>:			sub    $0x16c,%esp
0xc01583a5 <do_execve+3>:				sub    $0x158,%esp
0xc033e177 <snd_seq_oss_ioctl+3>:			sub    $0x154,%esp
0xc02f13d9 <mmc_ioctl+3>:				sub    $0x154,%esp
0xc017d267 <elf_kcore_store_hdr+6>:			sub    $0x150,%esp
0xc01f048d <reiserfs_readdir+6>:			sub    $0x148,%esp
0xc01b28aa <nfs_lookup_revalidate+11>:			sub    $0x148,%esp
0xc036d0e8 <rt_cache_seq_show+6>:			sub    $0x144,%esp
0xc01d4115 <udf_fill_inode+6>:				sub    $0x144,%esp
0xc032fec8 <snd_pcm_info_user+3>:			sub    $0x140,%esp
0xc0286167 <radeon_cp_clear+3>:				sub    $0x13c,%esp
0xc019608f <journal_commit_transaction+6>:		sub    $0x13c,%esp
0xc0174db5 <load_elf_binary+20>:			sub    $0x13c,%esp
0xc03b5ba4 <ip_map_parse+3>:				sub    $0x138,%esp
0xc035c698 <sys_sendmsg+8>:				sub    $0x134,%esp
0xc02f66fe <read_tuple+3>:				sub    $0x134,%esp
0xc01b2ed9 <nfs_lookup+6>:				sub    $0x134,%esp
0xc0172105 <aout_core_dump+21>:				sub    $0x134,%esp
0xc02df535 <ahc_linux_proc_info+11>:			sub    $0x130,%esp
0xc02d8097 <ahc_linux_info+16>:				sub    $0x130,%esp
0xc034d3db <snd_rawmidi_info_select_user+3>:		sub    $0x12c,%esp
0xc032e77a <snd_pcm_proc_info_read+4>:			sub    $0x12c,%esp
0xc0308874 <proc_getdriver+3>:				sub    $0x12c,%esp
0xc01d4c5c <udf_update_inode+6>:			sub    $0x12c,%esp
0xc034d2a5 <snd_rawmidi_info_user+3>:			sub    $0x128,%esp
0xc01e148f <udf_put_filename+3>:			sub    $0x128,%esp
0xc01d9c88 <udf_rename+6>:				sub    $0x128,%esp
0xc0325433 <snd_mixer_oss_build_test+3>:		sub    $0x124,%esp
0xc0321351 <snd_ctl_elem_info+11>:			sub    $0x124,%esp
0xc02f4c26 <verify_cis_cache+6>:			sub    $0x124,%esp
0xc0242307 <acpi_pci_bind+32>:				sub    $0x124,%esp
0xc01e8aff <reiserfs_add_entry+11>:			sub    $0x124,%esp
0xc01cc029 <nlmsvc_proc_granted_msg+3>:			sub    $0x124,%esp
0xc01cbfab <nlmsvc_proc_unlock_msg+3>:			sub    $0x124,%esp
0xc01cbf2d <nlmsvc_proc_cancel_msg+3>:			sub    $0x124,%esp
0xc01cbeaf <nlmsvc_proc_lock_msg+3>:			sub    $0x124,%esp
0xc01cbe31 <nlmsvc_proc_test_msg+3>:			sub    $0x124,%esp
0xc017c649 <meminfo_read_proc+15>:			sub    $0x124,%esp
0xc016a6b5 <setxattr+8>:				sub    $0x124,%esp
0xc01e37ef <autofs4_expire_run+12>:			sub    $0x120,%esp
0xc0198244 <log_do_checkpoint+6>:			sub    $0x120,%esp
0xc016a969 <getxattr+3>:				sub    $0x120,%esp
0xc0257e97 <parport_pc_probe_port+12>:			sub    $0x11c,%esp
0xc024263a <acpi_pci_bind_root+32>:			sub    $0x11c,%esp
0xc01e3118 <autofs4_notify_daemon+12>:			sub    $0x11c,%esp
0xc035c92a <sys_recvmsg+3>:				sub    $0x118,%esp
0xc031c91e <i8042_interrupt+8>:				sub    $0x118,%esp
0xc02ee068 <sg_proc_hoststrs_info+6>:			sub    $0x118,%esp
0xc02551f0 <do_autoprobe+3>:				sub    $0x118,%esp
0xc0241aab <acpi_pci_irq_add_prt+20>:			sub    $0x118,%esp
0xc016adc3 <removexattr+3>:				sub    $0x118,%esp
0xc02deecd <copy_info+3>:				sub    $0x114,%esp
0xc02c05c8 <scsi_request_sense+6>:			sub    $0x114,%esp
0xc020c619 <sys_shmctl+3>:				sub    $0x114,%esp
0xc0203c55 <reiserfs_breada+6>:				sub    $0x114,%esp
0xc012a88b <sys_reboot+10>:				sub    $0x114,%esp
0xc052aeea <pirq_peer_trick+13>:			sub    $0x110,%esp
0xc01a059f <ext2_get_parent+3>:				sub    $0x110,%esp
0xc01719cf <ep_events_transfer+11>:			sub    $0x110,%esp
0xc02efd9b <dvd_read_bca+3>:				sub    $0x10c,%esp
0xc02550e0 <do_active_device+8>:			sub    $0x10c,%esp
0xc01d2ab5 <inode_getblk+6>:				sub    $0x10c,%esp
0xc01898b5 <ext3_get_parent+12>:			sub    $0x10c,%esp
0xc024839d <acpi_bus_match+8>:				sub    $0x108,%esp
0xc029ac87 <e100_do_ethtool_ioctl+10>:			sub    $0x100,%esp
0xc01beba6 <write_filehandle+3>:			sub    $0x100,%esp

