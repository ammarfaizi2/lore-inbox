Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265732AbUGNVmo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265732AbUGNVmo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 17:42:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265875AbUGNVmo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 17:42:44 -0400
Received: from adonis.kotinet.com ([212.50.211.55]:41933 "EHLO
	adonis.kotinet.com") by vger.kernel.org with ESMTP id S265732AbUGNVlz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 17:41:55 -0400
Date: Thu, 15 Jul 2004 00:41:46 +0300
From: Sami Farin <7atbggg02@sneakemail.com>
To: linux-kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.7-bk20 / slab: Internal list corruption detected in cache 'proc_inode_cache' + Oops in link_path_walk radix_tree_delete reiserfs_update_inode_transaction
Message-ID: <20040714214146.GA23531@m.safari.iki.fi>
Mail-Followup-To: linux-kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20040713110437.GA4571@m.safari.iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040713110437.GA4571@m.safari.iki.fi>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 13, 2004 at 02:04:37PM +0300, Sami Farin wrote:
...
> funny thing about that 335546376 is that when I used 2.6.7-bk18,
> I was copying /proc/slabinfo every 15 seconds to a safe place...
> when I got a crash, latest slabinfo (just prior to the crash) contained these:
> radix_tree_node   335549427   5614    276   14    1 : tunables   54   27    0 : slabdata    401    401      0
> proc_inode_cache    2195   2208    320   12    1 : tunables   54   27    0 : slabdata    184    184      0
> kernel message little time before crash was
> Jul  7 12:07:25 safari kernel: slab: cache radix_tree_node error: free_objects accounting error
> 
> 335549427 is 0x140013f3 , hmm, where did the "extra" 0x14000000 come from in
> these two cases...

more Oopsing after 30 hours of uptime with 2.6.8-rc1, no SMP/preempt this time.

and the mysterious value seems to be 0x14000030 (!??!!).

this time, every time when qmail-smtpd was invoked, it segfaulted.
further inspection showed that it died when it tried to open
/var/qmail/control/pcre/debug ... that's on reiserfs partition.
it has been read only, not written to during this month.

ls -l gave this:
23:21:41.564072 lstat64("debug",  <unfinished ...>
23:21:41.594473 +++ killed by SIGSEGV +++

however,
23:28:22.325777 rename("debug", "debugx") = -1 ENOENT (No such file or directory) <0.000390>

here Oopses I got.
[after these final Oops, resulting from "rm -f debug"]

Jul 14 22:56:41 safari kernel: Unable to handle kernel paging request at virtual address 14000030
Jul 14 22:56:41 safari kernel:  printing eip:
Jul 14 22:56:41 safari kernel: c015bad9
Jul 14 22:56:41 safari kernel: *pde = 00000000
Jul 14 22:56:41 safari kernel: Oops: 0000 [#1]
Jul 14 22:56:41 safari kernel: Modules linked in: speedstep_lib ip6t_LOG
	ip6table_filter ip6_tables iptable_raw iptable_mangle iptable_filter sch_hfsc
	sch_htb sch_sfq cls_fw cls_u32 cls_route sch_ingress sch_red sch_tbf sch_teql
	sch_prio sch_gred cls_rsvp cls_rsvp6 cls_tcindex sch_cbq sch_dsmark ipt_ttl
	ipt_tos ipt_tcpmss ipt_state ipt_recent ipt_pkttype ipt_physdev ipt_owner
	ipt_multiport ipt_mark ipt_mac ipt_limit ipt_length ipt_iprange ipt_helper
	ipt_esp ipt_ecn ipt_dscp ipt_conntrack ipt_connlimit ipt_ah ipt_addrtype
	ipt_ULOG ipt_TOS ipt_TCPMSS ipt_TARPIT ipt_SAME ipt_REJECT ipt_REDIRECT
	ipt_NOTRACK ipt_NETMAP ipt_MASQUERADE iptable_nat ip_conntrack ipt_MARK ipt_LOG
	ipt_ECN ipt_DSCP ipt_CLASSIFY ip_tables xfs appletalk ax25 ipx p8022 psnap llc
	md5 ipv6 bsd_comp ppp_async ppp_deflate zlib_deflate ppp_generic slhc
	snd_seq_midi snd_seq_oss snd_seq_midi_event snd_seq lp parport_pc parport mga
	w83781d i2c_sensor i2c_piix4 tuner tvaudio msp3400 bttv video_buf i2c_algo_bit
	v4l2_common btcx_risc i2c_core videodev s
Jul 14 22:56:41 safari kernel: d_pcm_oss snd_mixer_oss snd_ens1371 snd_rawmidi
	snd_seq_device snd_pcm snd_page_alloc snd_timer snd_ac97_codec snd gameport
	soundcore uhci_hcd ohci_hcd irlan irda crc_ccitt 8139too mii loop dm_mod
Jul 14 22:56:41 safari kernel: CPU:    0
Jul 14 22:56:41 safari kernel: EIP:    0060:[<c015bad9>]    Not tainted
Jul 14 22:56:41 safari kernel: EFLAGS: 00010202   (2.6.8-rc1) 
Jul 14 22:56:41 safari kernel: EIP is at link_path_walk+0x5f9/0x960
Jul 14 22:56:41 safari kernel: eax: 14000008   ebx: ce85111c   ecx: 00000000   edx: c52aaee8
Jul 14 22:56:41 safari kernel: esi: ce6c7238   edi: cffbb012   ebp: c52aaf08   esp: c52aaecc
Jul 14 22:56:41 safari kernel: ds: 007b   es: 007b   ss: 0068
Jul 14 22:56:41 safari kernel: Process qmail-smtpd (pid: 30389, threadinfo=c52aa000 task=cf2c0760)
Jul 14 22:56:41 safari kernel: Stack: cffbb00d c901e0ec 00000001 00000101 ce85111c c52aaf60 cffceb20 ce6c7238 
Jul 14 22:56:41 safari kernel:        10f8ba9b cffbb00d 00000005 c52aaf2c c52aa000 c52aaf60 00000000 c52aaf20 
Jul 14 22:56:41 safari kernel:        c015c068 cffbb000 cffbb000 00000800 c52aaf60 c52aaf54 c015c909 00000fff 
Jul 14 22:56:41 safari kernel: Call Trace:
Jul 14 22:56:41 safari kernel:  [<c01068ca>] show_stack+0x7a/0x90
Jul 14 22:56:41 safari kernel:  [<c0106a49>] show_registers+0x149/0x1b0
Jul 14 22:56:41 safari kernel:  [<c0106bc7>] die+0x67/0xd0
Jul 14 22:56:41 safari kernel:  [<c0116ad7>] do_page_fault+0x3c7/0x580
Jul 14 22:56:41 safari kernel:  [<c010656d>] error_code+0x2d/0x38
Jul 14 22:56:41 safari kernel:  [<c015c068>] path_lookup+0x78/0x160
Jul 14 22:56:41 safari kernel:  [<c015c909>] open_namei+0x89/0x490
Jul 14 22:56:41 safari kernel:  [<c014e969>] filp_open+0x29/0x50
Jul 14 22:56:41 safari kernel:  [<c014eccd>] sys_open+0x4d/0xb0
Jul 14 22:56:41 safari kernel:  [<c010636f>] sysenter_past_esp+0x54/0x75
Jul 14 22:56:41 safari kernel: Code: 8b 48 28 85 c9 0f 84 98 02 00 00 8b 45 dc 85 c0 74 06 ff 40 

...snip similar oopses...

Jul 14 23:19:14 safari kernel:  <1>Unable to handle kernel paging request at virtual address 20493080
Jul 14 23:19:14 safari kernel:  printing eip:
Jul 14 23:19:14 safari kernel: c01f754a
Jul 14 23:19:14 safari kernel: *pde = 00000000
Jul 14 23:19:14 safari kernel: Oops: 0000 [#20]
Jul 14 23:19:14 safari kernel: Modules linked in: [snip] 
Jul 14 23:19:14 safari kernel: CPU:    0
Jul 14 23:19:14 safari kernel: EIP:    0060:[<c01f754a>]    Not tainted
Jul 14 23:19:14 safari kernel: EFLAGS: 00010092   (2.6.8-rc1) 
Jul 14 23:19:14 safari kernel: EIP is at radix_tree_delete+0x1a/0x180
Jul 14 23:19:14 safari kernel: eax: 18000bf8   ebx: c1106c20   ecx: 00000000   edx: 00000000
Jul 14 23:19:14 safari kernel: esi: 00000000   edi: cfec8da4   ebp: cfec8e10   esp: cfec8d8c
Jul 14 23:19:14 safari kernel: ds: 007b   es: 007b   ss: 0068
Jul 14 23:19:14 safari kernel: Process kswapd0 (pid: 16915, threadinfo=cfec8000 task=cfec4050)
Jul 14 23:19:14 safari kernel: Stack: 00000000 00000002 00000000 cfec8dd4 ce8511b8 00000000 00000000 cffc8798 
Jul 14 23:19:14 safari kernel:        6bf4fc94 cf6ec5d8 cf6ec5ec 00000004 cef7da58 cef7dab0 00000015 c309fed8 
Jul 14 23:19:14 safari kernel:        c309ff7c 00000028 c0a985d8 c0a986bc 00000038 cffd703c cfffd7e0 ca131258 
Jul 14 23:19:14 safari kernel: Call Trace:
Jul 14 23:19:14 safari kernel:  [<c01068ca>] show_stack+0x7a/0x90
Jul 14 23:19:14 safari kernel:  [<c0106a49>] show_registers+0x149/0x1b0
Jul 14 23:19:14 safari kernel:  [<c0106bc7>] die+0x67/0xd0
Jul 14 23:19:14 safari kernel:  [<c0116ad7>] do_page_fault+0x3c7/0x580
Jul 14 23:19:14 safari kernel:  [<c010656d>] error_code+0x2d/0x38
Jul 14 23:19:14 safari kernel:  [<c0133dcd>] __remove_from_page_cache+0x1d/0x40
Jul 14 23:19:14 safari kernel:  [<c013f3b1>] shrink_list+0x341/0x420
Jul 14 23:19:14 safari kernel:  [<c013f5c6>] shrink_cache+0x136/0x2d0
Jul 14 23:19:14 safari kernel:  [<c013fc28>] shrink_zone+0x98/0xd0
Jul 14 23:19:14 safari kernel:  [<c013ff97>] balance_pgdat+0x177/0x210
Jul 14 23:19:14 safari kernel:  [<c01400e6>] kswapd+0xb6/0xd0
Jul 14 23:19:14 safari kernel:  [<c01042a5>] kernel_thread_helper+0x5/0x10
Jul 14 23:19:14 safari kernel: Code: 39 14 85 a0 00 49 c0 89 85 7c ff ff ff 0f 82 1c 01 00 00 c7 

Jul 14 23:19:34 safari kernel:  <1>Unable to handle kernel paging request at virtual address 14000030
Jul 14 23:19:34 safari kernel:  printing eip:
Jul 14 23:19:34 safari kernel: c015bad9
Jul 14 23:19:34 safari kernel: *pde = 00000000
Jul 14 23:19:34 safari kernel: Oops: 0000 [#21]
Jul 14 23:19:34 safari kernel: Modules linked in: [snip] 
Jul 14 23:19:34 safari kernel: CPU:    0
Jul 14 23:19:34 safari kernel: EIP:    0060:[<c015bad9>]    Not tainted
Jul 14 23:19:34 safari kernel: EFLAGS: 00210202   (2.6.8-rc1) 
Jul 14 23:19:34 safari kernel: EIP is at link_path_walk+0x5f9/0x960
Jul 14 23:19:34 safari kernel: eax: 14000008   ebx: ce85111c   ecx: 00000000   edx: c9845ee8
Jul 14 23:19:34 safari kernel: esi: ce6c7238   edi: c8db7012   ebp: c9845f08   esp: c9845ecc
Jul 14 23:19:34 safari kernel: ds: 007b   es: 007b   ss: 0068
Jul 14 23:19:34 safari kernel: Process qmail-smtpd (pid: 17093, threadinfo=c9845000 task=cc7ce7a0)
Jul 14 23:19:34 safari kernel: Stack: c8db700d c0123218 cc7cecc4 00000101 ce85111c c9845f60 cffceb20 ce6c7238 
Jul 14 23:19:34 safari kernel:        10f8ba9b c8db700d 00000005 c9845000 c9845000 c9845f60 00000000 c9845f20 
Jul 14 23:19:34 safari kernel:        c015c068 c8db7000 c8db7000 00000800 c9845f60 c9845f54 c015c909 00000fff 
Jul 14 23:19:34 safari kernel: Call Trace:
Jul 14 23:19:34 safari kernel:  [<c01068ca>] show_stack+0x7a/0x90
Jul 14 23:19:34 safari kernel:  [<c0106a49>] show_registers+0x149/0x1b0
Jul 14 23:19:34 safari kernel:  [<c0106bc7>] die+0x67/0xd0
Jul 14 23:19:34 safari kernel:  [<c0116ad7>] do_page_fault+0x3c7/0x580
Jul 14 23:19:34 safari kernel:  [<c010656d>] error_code+0x2d/0x38
Jul 14 23:19:34 safari kernel:  [<c015c068>] path_lookup+0x78/0x160
Jul 14 23:19:34 safari kernel:  [<c015c909>] open_namei+0x89/0x490
Jul 14 23:19:34 safari kernel:  [<c014e969>] filp_open+0x29/0x50
Jul 14 23:19:34 safari kernel:  [<c014eccd>] sys_open+0x4d/0xb0
Jul 14 23:19:34 safari kernel:  [<c010636f>] sysenter_past_esp+0x54/0x75
Jul 14 23:19:34 safari kernel: Code: 8b 48 28 85 c9 0f 84 98 02 00 00 8b 45 dc 85 c0 74 06 ff 40 
Jul 14 23:19:40 safari kernel:  <6>SysRq : HELP : loglevel0-8 reBoot tErm kIll saK showMem powerOff showPc unRaw Sync showTasks Unmount 
...
Jul 14 23:20:41 safari kernel: Unable to handle kernel paging request at virtual address 14000044
Jul 14 23:20:41 safari kernel:  printing eip:
Jul 14 23:20:41 safari kernel: c01578c0
Jul 14 23:20:41 safari kernel: *pde = 00000000
Jul 14 23:20:41 safari kernel: Oops: 0000 [#25]
Jul 14 23:20:41 safari kernel: Modules linked in: [snip] 
Jul 14 23:20:41 safari kernel: CPU:    0
Jul 14 23:20:41 safari kernel: EIP:    0060:[<c01578c0>]    Not tainted
Jul 14 23:20:41 safari kernel: EFLAGS: 00210246   (2.6.8-rc1) 
Jul 14 23:20:41 safari kernel: EIP is at vfs_getattr+0x30/0xc0
Jul 14 23:20:41 safari kernel: eax: 14000008   ebx: ce6c7238   ecx: 00000006   edx: 00000010
Jul 14 23:20:41 safari kernel: esi: ce85111c   edi: cbdd6f14   ebp: cbdd6f0c   esp: cbdd6ef8
Jul 14 23:20:41 safari kernel: ds: 007b   es: 007b   ss: 0068
Jul 14 23:20:41 safari kernel: Process ls (pid: 7486, threadinfo=cbdd6000 task=c97f63b0)
Jul 14 23:20:41 safari kernel: Stack: cbdd6f68 cffceb20 00000000 cbdd6f68 cbdd6f14 cbdd6f60 c01579ef ce6c7238 
Jul 14 23:20:41 safari kernel:        cffceb20 00000000 00000131 00000000 00000000 00000001 00000000 40ea26c3 
Jul 14 23:20:41 safari kernel:        00000000 40ea26c3 00000000 40ea26c3 00000000 00080a28 00000000 cbdd6f68 
Jul 14 23:20:41 safari kernel: Call Trace:
Jul 14 23:20:41 safari kernel:  [<c01068ca>] show_stack+0x7a/0x90
Jul 14 23:20:41 safari kernel:  [<c0106a49>] show_registers+0x149/0x1b0
Jul 14 23:20:41 safari kernel:  [<c0106bc7>] die+0x67/0xd0
Jul 14 23:20:41 safari kernel:  [<c0116ad7>] do_page_fault+0x3c7/0x580
Jul 14 23:20:41 safari kernel:  [<c010656d>] error_code+0x2d/0x38
Jul 14 23:20:41 safari kernel:  [<c01579ef>] vfs_lstat+0x3f/0x60
Jul 14 23:20:41 safari kernel:  [<c0157ff4>] sys_lstat64+0x14/0x30
Jul 14 23:20:41 safari kernel:  [<c010636f>] sysenter_past_esp+0x54/0x75
Jul 14 23:20:41 safari kernel: Code: 8b 78 3c 85 ff 74 19 8b 4d ec 89 da 8b 45 f0 ff d7 8b 5d f4 

Jul 14 23:20:55 safari kernel: Unable to handle kernel paging request at virtual address 14000044
Jul 14 23:20:55 safari kernel:  printing eip:
Jul 14 23:20:55 safari kernel: c01578c0
Jul 14 23:20:55 safari kernel: *pde = 00000000
Jul 14 23:20:55 safari kernel: Oops: 0000 [#26]
Jul 14 23:20:55 safari kernel: Modules linked in: [snap] 
Jul 14 23:20:55 safari kernel: CPU:    0
Jul 14 23:20:55 safari kernel: EIP:    0060:[<c01578c0>]    Not tainted
Jul 14 23:20:55 safari kernel: EFLAGS: 00210246   (2.6.8-rc1) 
Jul 14 23:20:55 safari kernel: EIP is at vfs_getattr+0x30/0xc0
Jul 14 23:20:55 safari kernel: eax: 14000008   ebx: ce6c7238   ecx: 00000006   edx: 00000010
Jul 14 23:20:55 safari kernel: esi: ce85111c   edi: cbdd6f14   ebp: cbdd6f0c   esp: cbdd6ef8
Jul 14 23:20:55 safari kernel: ds: 007b   es: 007b   ss: 0068
Jul 14 23:20:55 safari kernel: Process ls (pid: 6912, threadinfo=cbdd6000 task=c97f6ed0)
Jul 14 23:20:55 safari kernel: Stack: cbdd6f68 cffceb20 00000000 cbdd6f68 cbdd6f14 cbdd6f60 c01579ef ce6c7238 
Jul 14 23:20:55 safari kernel:        cffceb20 00000000 00000131 00000000 00000000 00000001 00000000 40ea26c3 
Jul 14 23:20:55 safari kernel:        00000000 40ea26c3 00000000 40ea26c3 00000000 00080a28 00000000 cbdd6f68 
Jul 14 23:20:55 safari kernel: Call Trace:
Jul 14 23:20:55 safari kernel:  [<c01068ca>] show_stack+0x7a/0x90
Jul 14 23:20:55 safari kernel:  [<c0106a49>] show_registers+0x149/0x1b0
Jul 14 23:20:55 safari kernel:  [<c0106bc7>] die+0x67/0xd0
Jul 14 23:20:55 safari kernel:  [<c0116ad7>] do_page_fault+0x3c7/0x580
Jul 14 23:20:55 safari kernel:  [<c010656d>] error_code+0x2d/0x38
Jul 14 23:20:55 safari kernel:  [<c01579ef>] vfs_lstat+0x3f/0x60
Jul 14 23:20:55 safari kernel:  [<c0157ff4>] sys_lstat64+0x14/0x30
Jul 14 23:20:55 safari kernel:  [<c010636f>] sysenter_past_esp+0x54/0x75
Jul 14 23:20:55 safari kernel: Code: 8b 78 3c 85 ff 74 19 8b 4d ec 89 da 8b 45 f0 ff d7 8b 5d f4 

Jul 14 23:21:20 safari kernel:  <1>Unable to handle kernel paging request at virtual address 14000030
Jul 14 23:21:20 safari kernel:  printing eip:
Jul 14 23:21:20 safari kernel: c015bad9
Jul 14 23:21:20 safari kernel: *pde = 00000000
Jul 14 23:21:20 safari kernel: Oops: 0000 [#27]
Jul 14 23:21:20 safari kernel: Modules linked in: [snip] 
Jul 14 23:21:20 safari kernel: CPU:    0
Jul 14 23:21:20 safari kernel: EIP:    0060:[<c015bad9>]    Not tainted
Jul 14 23:21:20 safari kernel: EFLAGS: 00010202   (2.6.8-rc1) 
Jul 14 23:21:20 safari kernel: EIP is at link_path_walk+0x5f9/0x960
Jul 14 23:21:20 safari kernel: eax: 14000008   ebx: ce85111c   ecx: 00000000   edx: cbdd6ee8
Jul 14 23:21:20 safari kernel: esi: ce6c7238   edi: c7a88012   ebp: cbdd6f08   esp: cbdd6ecc
Jul 14 23:21:20 safari kernel: ds: 007b   es: 007b   ss: 0068
Jul 14 23:21:20 safari kernel: Process qmail-smtpd (pid: 16222, threadinfo=cbdd6000 task=c97f63b0)
Jul 14 23:21:20 safari kernel: Stack: c7a8800d c0432a00 cfffd660 00000101 ce85111c cbdd6f60 cffceb20 ce6c7238 
Jul 14 23:21:20 safari kernel:        10f8ba9b c7a8800d 00000005 c7a88000 cbdd6000 cbdd6f60 00000000 cbdd6f20 
Jul 14 23:21:20 safari kernel:        c015c068 c7a88000 c7a88000 00000800 cbdd6f60 cbdd6f54 c015c909 00000fff 
Jul 14 23:21:20 safari kernel: Call Trace:
Jul 14 23:21:20 safari kernel:  [<c01068ca>] show_stack+0x7a/0x90
Jul 14 23:21:20 safari kernel:  [<c0106a49>] show_registers+0x149/0x1b0
Jul 14 23:21:20 safari kernel:  [<c0106bc7>] die+0x67/0xd0
Jul 14 23:21:20 safari kernel:  [<c0116ad7>] do_page_fault+0x3c7/0x580
Jul 14 23:21:20 safari kernel:  [<c010656d>] error_code+0x2d/0x38
Jul 14 23:21:20 safari kernel:  [<c015c068>] path_lookup+0x78/0x160
Jul 14 23:21:20 safari kernel:  [<c015c909>] open_namei+0x89/0x490
Jul 14 23:21:20 safari kernel:  [<c014e969>] filp_open+0x29/0x50
Jul 14 23:21:20 safari kernel:  [<c014eccd>] sys_open+0x4d/0xb0
Jul 14 23:21:20 safari kernel:  [<c010636f>] sysenter_past_esp+0x54/0x75
Jul 14 23:21:20 safari kernel: Code: 8b 48 28 85 c9 0f 84 98 02 00 00 8b 45 dc 85 c0 74 06 ff 40 

Jul 14 23:24:32 safari kernel:  <1>Unable to handle kernel paging request at virtual address 14000030
Jul 14 23:24:32 safari kernel:  printing eip:
Jul 14 23:24:32 safari kernel: c015cafe
Jul 14 23:24:32 safari kernel: *pde = 00000000
Jul 14 23:24:32 safari kernel: Oops: 0000 [#39]
Jul 14 23:24:32 safari kernel: Modules linked in: [snop] 
Jul 14 23:24:32 safari kernel: CPU:    0
Jul 14 23:24:32 safari kernel: EIP:    0060:[<c015cafe>]    Not tainted
Jul 14 23:24:32 safari kernel: EFLAGS: 00210202   (2.6.8-rc1) 
Jul 14 23:24:32 safari kernel: EIP is at open_namei+0x27e/0x490
Jul 14 23:24:32 safari kernel: eax: 14000008   ebx: ce6c7238   ecx: c4de9604   edx: ce6c724c
Jul 14 23:24:32 safari kernel: esi: fffffffe   edi: cbdd6f60   ebp: cbdd6f54   esp: cbdd6f28
Jul 14 23:24:32 safari kernel: ds: 007b   es: 007b   ss: 0068
Jul 14 23:24:32 safari kernel: Process bash (pid: 30180, threadinfo=cbdd6000 task=c9841360)
Jul 14 23:24:32 safari kernel: Stack: 00000fff cbdd6f68 00000000 c4883cc8 00000002 000001b6 00008242 ce6c7238 
Jul 14 23:24:32 safari kernel:        cbdd6f60 00008241 c4cfa000 cbdd6fa8 c014e969 cbdd6f60 c4883cc8 cffceb20 
Jul 14 23:24:32 safari kernel:        10f8ba9b c4cfa000 00000005 00000300 00000000 00000000 c4cfa000 ced6ac48 
Jul 14 23:24:32 safari kernel: Call Trace:
Jul 14 23:24:32 safari kernel:  [<c01068ca>] show_stack+0x7a/0x90
Jul 14 23:24:32 safari kernel:  [<c0106a49>] show_registers+0x149/0x1b0
Jul 14 23:24:32 safari kernel:  [<c0106bc7>] die+0x67/0xd0
Jul 14 23:24:32 safari kernel:  [<c0116ad7>] do_page_fault+0x3c7/0x580
Jul 14 23:24:32 safari kernel:  [<c010656d>] error_code+0x2d/0x38
Jul 14 23:24:32 safari kernel:  [<c014e969>] filp_open+0x29/0x50
Jul 14 23:24:32 safari kernel:  [<c014eccd>] sys_open+0x4d/0xb0
Jul 14 23:24:32 safari kernel:  [<c010636f>] sysenter_past_esp+0x54/0x75
Jul 14 23:24:32 safari kernel: Code: 8b 48 28 85 c9 0f 84 7b 01 00 00 f7 45 ec 00 00 02 00 be d8 



next I tried rm -f debug
23:28:52.599142 unlink("debug"

this resulted into more Oopses.

Jul 14 23:28:50 safari kernel:  <1>Unable to handle kernel paging request at virtual address 18000544
Jul 14 23:28:50 safari kernel:  printing eip:
Jul 14 23:28:50 safari kernel: c01acd1c
Jul 14 23:28:50 safari kernel: *pde = 00000000
Jul 14 23:28:50 safari kernel: Oops: 0000 [#47]
Jul 14 23:28:50 safari kernel: Modules linked in: [same as earlier] 
Jul 14 23:28:50 safari kernel: CPU:    0
Jul 14 23:28:50 safari kernel: EIP:    0060:[<c01acd1c>]    Not tainted
Jul 14 23:28:50 safari kernel: EFLAGS: 00210217   (2.6.8-rc1) 
Jul 14 23:28:50 safari kernel: EIP is at reiserfs_update_inode_transaction+0xc/0x40
Jul 14 23:28:50 safari kernel: eax: ce85111c   ebx: fffffffb   ecx: ce8510d0   edx: 180003f8
Jul 14 23:28:50 safari kernel: esi: c4de959c   edi: ce85111c   ebp: c99abe5c   esp: c99abe5c
Jul 14 23:28:50 safari kernel: ds: 007b   es: 007b   ss: 0068
Jul 14 23:28:50 safari kernel: Process rm (pid: 22085, threadinfo=c99ab000 task=cfec4050)
Jul 14 23:28:50 safari kernel: Stack: c99abf4c c018c33f c99abea0 c99abef0 cfec4050 00000006 00000003 00000001 

Jul 14 23:28:50 safari kernel:        c99abecc cdc68690 00000001 00000000 00000026 00622bdd 00000000 c99abee0 
Jul 14 23:28:50 safari kernel:        c01e2b6b 00000004 00000000 00000000 00000000 00000000 00000000 c4df3ed8 
Jul 14 23:28:50 safari kernel: Call Trace:
Jul 14 23:28:50 safari kernel:  [<c01068ca>] show_stack+0x7a/0x90
Jul 14 23:28:50 safari kernel:  [<c0106a49>] show_registers+0x149/0x1b0
Jul 14 23:28:50 safari kernel:  [<c0106bc7>] die+0x67/0xd0
Jul 14 23:28:50 safari kernel:  [<c0116ad7>] do_page_fault+0x3c7/0x580
Jul 14 23:28:50 safari kernel:  [<c010656d>] error_code+0x2d/0x38
Jul 14 23:28:50 safari kernel:  [<c018c33f>] reiserfs_unlink+0x7f/0x240
Jul 14 23:28:50 safari kernel:  [<c015d7a5>] vfs_unlink+0x115/0x220
Jul 14 23:28:50 safari kernel:  [<c015d9af>] sys_unlink+0xff/0x150
Jul 14 23:28:50 safari kernel:  [<c010636f>] sysenter_past_esp+0x54/0x75
Jul 14 23:28:50 safari kernel: Code: 8b 92 4c 01 00 00 8b 52 0c 8b 92 a8 00 00 00 89 51 34 8b 80 

after reboot with init=/bin/sh and reiserfsck /dev/hda1, 
it gave no errors.
after "real" reboot, /var/qmail/control/pcre/debug was just fine.

what next?

BTW, I have four reiserfs partitions, one 100 MB tmpfs, one 128 MB
ext3[+loop-AES], 128 MB swap partition[loop-AES, too, but I have
crashed also without encrypted swap].

-- 
