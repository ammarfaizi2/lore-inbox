Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751077AbWEFSY3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751077AbWEFSY3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 May 2006 14:24:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751078AbWEFSY3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 May 2006 14:24:29 -0400
Received: from mail.pioneer-pra.com ([65.205.244.70]:4261 "EHLO
	mail1.dmz.sj.pioneer-pra.com") by vger.kernel.org with ESMTP
	id S1751077AbWEFSY2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 May 2006 14:24:28 -0400
From: Jason Schoonover <jasons@pioneer-pra.com>
Organization: Pioneer PRA
To: Robert Hancock <hancockr@shaw.ca>
Subject: Re: High load average on disk I/O on 2.6.17-rc3
Date: Sat, 6 May 2006 11:23:01 -0700
User-Agent: KMail/1.8.3
Cc: linux-kernel <linux-kernel@vger.kernel.org>
References: <69c8K-3Bu-57@gated-at.bofh.it> <200605052139.49241.jasons@pioneer-pra.com> <445CDAD0.1000203@shaw.ca>
In-Reply-To: <445CDAD0.1000203@shaw.ca>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_GmOXEI7ED0kTH88"
Message-Id: <200605061123.02077.jasons@pioneer-pra.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_GmOXEI7ED0kTH88
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Robert,

I did started a ncftpget and managed to get 6 pdflush processes running in 
state D, hopefully this will give us a chance to debug it.

I've attached the entire Alt+SysReq+T output here because I have no idea how 
to read it.

Thanks,
Jason

-------Original Message-----
From: Robert Hancock
Sent: Saturday 06 May 2006 10:20
To: Jason Schoonover
Subject: Re: High load average on disk I/O on 2.6.17-rc3

Jason Schoonover wrote:
> Hi Robert,
>
> There are, this is the relevant output of the process list:
>
>  ...
>  4659 pts/6    Ss     0:00 -bash
>  4671 pts/5    R+     0:12 cp -a test-dir/ new-test
>  4676 ?        D      0:00 [pdflush]
>  4679 ?        D      0:00 [pdflush]
>  4687 pts/4    D+     0:01 hdparm -t /dev/sda
>  4688 ?        D      0:00 [pdflush]
>  4690 ?        D      0:00 [pdflush]
>  4692 ?        D      0:00 [pdflush]
>  ...
>
> This was when I was copying a directory and then doing a performance test
> with hdparm in a separate shell.  The hdparm process was in [D+] state and
> basically waited until the cp was finished.  During the whole thing there
> were up to 5 pdflush processes in [D] state.
>
> The 5 minute load average hit 8.90 during this test.
>
> Does that help?

Well, it obviously explains why the load average is high, those D state
processes all count in the load average. It may be sort of a cosmetic
issue, since they're not actually using any CPU, but it's still a bit
unusual. For one thing, not sure why there are that many of them?

You could try enabling the SysRq triggers (if they're not already in
your kernel/distro) and doing Alt-SysRq-T which will dump the kernel
stack of all processes, that should show where exactly in the kernel
those pdflush processes are blocked..

--Boundary-00=_GmOXEI7ED0kTH88
Content-Type: text/plain;
  charset="iso-8859-1";
  name="sysreq.output.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="sysreq.output.txt"

 015c0ca> sys_select+0x9a/0x166   <b0104a5b> do_IRQ+0x22/0x2b
  <b010267b> syscall_call+0x7/0xb  
 snmpd         S 3C14DC00     0  3771      1          3778  3764 (NOTLB)
        f7975b58 f78d8300 0000000f 3c14dc00 00000000 000186a0 d5831281 000f68dc 
        dfbc4688 dfbc4580 b21a0540 b2014340 7b773b00 000f9663 00000001 b01273fc 
        b21f0500 f78aef00 00200286 b011e999 f7975b68 f7975b68 00200286 00000000 
 Call Trace:
  <b01273fc> add_wait_queue+0x12/0x30   <b011e999> lock_timer_base+0x15/0x2f
  <b026fd89> schedule_timeout+0x6c/0x8b   <b011ecff> process_timeout+0x0/0x9
  <b015baca> do_select+0x3b6/0x41e   <f88df929> ext3_mark_iloc_dirty+0x2a7/0x345 [ext3]
  <b015b65c> __pollwait+0x0/0xb8   <b011357b> default_wake_function+0x0/0x15
  <b011357b> default_wake_function+0x0/0x15   <b011357b> default_wake_function+0x0/0x15
  <b011357b> default_wake_function+0x0/0x15   <b011357b> default_wake_function+0x0/0x15
  <b011357b> default_wake_function+0x0/0x15   <b0113571> try_to_wake_up+0x327/0x331
  <b01609e5> inode_init_once+0x4c/0x14c   <b0149394> cache_alloc_refill+0x39e/0x45d
  <b0149062> cache_alloc_refill+0x6c/0x45d   <b01117b5> __wake_up_common+0x2a/0x4f
  <b017605f> proc_alloc_inode+0x41/0x66   <b0160911> alloc_inode+0xf5/0x17d
  <b016e6c0> inotify_d_instantiate+0x3b/0x5e   <b015fd63> d_instantiate+0x45/0x78
  <b0160557> d_rehash+0x4f/0x5f   <b0178a39> proc_lookup+0x77/0xaf
  <b0137669> get_page_from_freelist+0x7e/0x31a   <b0137895> get_page_from_freelist+0x2aa/0x31a
  <b015bd1a> core_sys_select+0x1e8/0x2a2   <b01ad8db> vsnprintf+0x423/0x461
  <b0137c3a> free_hot_cold_page+0x91/0xcd   <b0137c90> __pagevec_free+0x1a/0x24
  <b01393de> release_pages+0x147/0x150   <b0142040> page_remove_rmap+0x27/0x2a
  <b021303e> lock_sock+0x85/0x8d   <b0213d18> sk_free+0xa8/0xe2
  <b0210e8e> sock_destroy_inode+0x13/0x16   <b015f456> dput+0x1b/0x11e
  <b015c0ca> sys_select+0x9a/0x166   <b011b272> sys_gettimeofday+0x22/0x51
  <b010267b> syscall_call+0x7/0xb  
 smbd          S 000F4240     0  3776   3764                     (NOTLB)
        df977fb0 00000000 00000000 000f4240 00000000 00028b0a 00000012 00000002 
        dff18178 dff18070 dfb78580 b200c340 1685e740 000f41ff 00000000 00000000 
        00000001 00000007 df977fbc dff18070 00000001 df977fbc b0282b65 00000007 
 Call Trace:
  <b011fa32> sys_pause+0x14/0x1a   <b010267b> syscall_call+0x7/0xb
 sshd          S 004C4B40     0  3778      1  3875    3820  3771 (NOTLB)
        f7f77b60 b23c4374 00000000 004c4b40 00000000 00000000 f8545f80 000f68dd 
        dfb81138 dfb81030 b02b0480 b200c340 ca71c780 000f95ea 00000000 00000000 
        dfa76ac8 00200246 b01273fc fffffffc df989a80 00200246 b023aee4 00000000 
 Call Trace:
  <b01273fc> add_wait_queue+0x12/0x30   <b023aee4> tcp_poll+0x24/0x134
  <b026fd30> schedule_timeout+0x13/0x8b   <b02112c0> sock_poll+0x13/0x17
  <b015baca> do_select+0x3b6/0x41e   <f88df929> ext3_mark_iloc_dirty+0x2a7/0x345 [ext3]
  <b015b65c> __pollwait+0x0/0xb8   <b011357b> default_wake_function+0x0/0x15
  <b011357b> default_wake_function+0x0/0x15   <b014f430> __getblk+0x1d/0x211
  <f8874995> do_get_write_access+0x44a/0x45c [jbd]   <b01114b5> __activate_task+0x47/0x56
  <b0113571> try_to_wake_up+0x327/0x331   <f88e698a> __ext3_journal_stop+0x19/0x37 [ext3]
  <b01271f4> autoremove_wake_function+0x18/0x3a   <b01117b5> __wake_up_common+0x2a/0x4f
  <b0149062> cache_alloc_refill+0x6c/0x45d   <b01ab175> kobject_put+0x16/0x19
  <b01ab69b> kobject_release+0x0/0xa   <b0215457> __alloc_skb+0x4a/0xee
  <b0213988> sock_alloc_send_skb+0x5a/0x188   <b0217138> memcpy_fromiovec+0x29/0x4e
  <b0214593> sock_def_readable+0x11/0x5e   <b02659e1> unix_stream_sendmsg+0x21b/0x2e6
  <b015bd1a> core_sys_select+0x1e8/0x2a2   <b0211077> do_sock_write+0xa4/0xad
  <b0137669> get_page_from_freelist+0x7e/0x31a   <b0137953> __alloc_pages+0x4e/0x261
  <b0142611> __page_set_anon_rmap+0x2b/0x2f   <b013d845> do_wp_page+0x244/0x286
  <b013d869> do_wp_page+0x268/0x286   <b0215117> skb_dequeue+0x3b/0x41
  <b0160690> destroy_inode+0x48/0x4c   <b015f456> dput+0x1b/0x11e
  <b015c0ca> sys_select+0x9a/0x166   <b014a58a> filp_close+0x4e/0x57
  <b010267b> syscall_call+0x7/0xb  
 rpc.statd     S 006ACFC0     0  3820      1          3828  3778 (NOTLB)
        df9a9b60 b01114b5 b0328460 006acfc0 00000000 00000000 00000100 00000000 
        dfb7a138 dfb7a030 b21a0540 b2014340 3b0f8a80 000f41ff 00000001 f78a4c80 
        00000246 00000246 b01273fc 00000304 df917b80 00000246 b023aee4 00000000 
 Call Trace:
  <b01114b5> __activate_task+0x47/0x56   <b01273fc> add_wait_queue+0x12/0x30
  <b023aee4> tcp_poll+0x24/0x134   <b026fd30> schedule_timeout+0x13/0x8b
  <b02112c0> sock_poll+0x13/0x17   <b015baca> do_select+0x3b6/0x41e
  <b015b65c> __pollwait+0x0/0xb8   <b011357b> default_wake_function+0x0/0x15
  <b011357b> default_wake_function+0x0/0x15   <b011357b> default_wake_function+0x0/0x15
  <b015b65c> __pollwait+0x0/0xb8   <b011357b> default_wake_function+0x0/0x15
  <b021a02c> net_rx_action+0x98/0x146   <b011bdf9> __do_softirq+0x57/0xc0
  <b011bfc0> local_bh_enable+0x5b/0x66   <b021aff9> dev_queue_xmit+0x1e5/0x1eb
  <b02377ea> ip_output+0x1c0/0x1f6   <b02369b7> ip_push_pending_frames+0x351/0x3dd
  <b02170ea> memcpy_toiovec+0x29/0x4e   <b0217824> skb_copy_datagram_iovec+0x49/0x1a6
  <b0215932> kfree_skbmem+0x65/0x69   <b024e64d> udp_recvmsg+0x18a/0x1d3
  <b021318b> sock_common_recvmsg+0x36/0x4b   <b0212a1e> sock_recvmsg+0xf1/0x10d
  <b01271dc> autoremove_wake_function+0x0/0x3a   <b015bd1a> core_sys_select+0x1e8/0x2a2
  <b0210e04> move_addr_to_user+0x3a/0x52   <b0212d12> sys_recvfrom+0xfc/0x134
  <b021303e> lock_sock+0x85/0x8d   <b0211aa5> sys_bind+0x73/0xa0
  <b0213d18> sk_free+0xa8/0xe2   <b0210e8e> sock_destroy_inode+0x13/0x16
  <b015f456> dput+0x1b/0x11e   <b015c0ca> sys_select+0x9a/0x166
  <b014a58a> filp_close+0x4e/0x57   <b010267b> syscall_call+0x7/0xb
 ntpd          S 39E048C0     0  3828      1          3836  3820 (NOTLB)
        df8d7b60 0583c2ce 00000127 39e048c0 00000000 00000000 00000000 b011bdf9 
        b21ddb98 b21dda90 b02b0480 b200c340 48b33bc0 000f966c 00000000 dff27540 
        00000246 b021773c dff27540 df98a118 df8d7bd4 df98a100 dff27540 00000000 
 Call Trace:
  <b011bdf9> __do_softirq+0x57/0xc0   <b021773c> datagram_poll+0x21/0xc0
  <b026fd30> schedule_timeout+0x13/0x8b   <b02112c0> sock_poll+0x13/0x17
  <b015baca> do_select+0x3b6/0x41e   <f88df929> ext3_mark_iloc_dirty+0x2a7/0x345 [ext3]
  <b015b65c> __pollwait+0x0/0xb8   <b011357b> default_wake_function+0x0/0x15
  <b011357b> default_wake_function+0x0/0x15   <b011357b> default_wake_function+0x0/0x15
  <b011357b> default_wake_function+0x0/0x15   <b021aff9> dev_queue_xmit+0x1e5/0x1eb
  <b02377ea> ip_output+0x1c0/0x1f6   <b0113571> try_to_wake_up+0x327/0x331
  <b0214593> sock_def_readable+0x11/0x5e   <b01117b5> __wake_up_common+0x2a/0x4f
  <b0111803> __wake_up+0x29/0x3c   <b02145b5> sock_def_readable+0x33/0x5e
  <b0243570> tcp_rcv_established+0x40e/0x69a   <f886501c> ipt_hook+0x1c/0x20 [iptable_filter]
  <b024963e> tcp_v4_do_rcv+0x23/0x2ba   <b0232a0a> ip_local_deliver_finish+0x0/0x193
  <b0232a0a> ip_local_deliver_finish+0x0/0x193   <b024a72a> tcp_v4_rcv+0x889/0x8dd
  <b0232bf8> ip_local_deliver+0x5b/0x1fd   <b0232cf6> ip_local_deliver+0x159/0x1fd
  <b0213117> sk_reset_timer+0x12/0x1e   <b02447b1> tcp_send_delayed_ack+0xb7/0xbd
  <b015bd1a> core_sys_select+0x1e8/0x2a2   <f886501c> ipt_hook+0x1c/0x20 [iptable_filter]
  <b011f676> __sigqueue_free+0x2a/0x2f   <b010710a> convert_fxsr_to_user+0xdf/0x12e
  <b0107274> save_i387+0xf0/0x105   <b0101e68> setup_sigcontext+0xde/0x11c
  <b0102490> do_notify_resume+0x4ab/0x58b   <b010729f> convert_fxsr_from_user+0x16/0xd6
  <b015c0ca> sys_select+0x9a/0x166   <b0101c66> restore_sigcontext+0x102/0x14c
  <b0101fc0> sys_sigreturn+0x98/0xbd   <b010267b> syscall_call+0x7/0xb
 atd           S 000F4240     0  3836      1          3843  3828 (NOTLB)
        df8b5f1c df8b5ee8 30b8a000 000f4240 00000000 00000000 445cddcf f7e23f5c 
        b21c8178 b21c8070 b21a0540 b2014340 a2ec1c80 000f93e0 00000001 b2014d94 
        b2014d8c b2014d8c 1268d3c8 00000282 b012996a 00000000 e1b033c8 00000000 
 Call Trace:
  <b012996a> hrtimer_start+0xc5/0xd0   <b0270109> do_nanosleep+0x3b/0x63
  <b01299b8> hrtimer_nanosleep+0x43/0xfe   <b0120244> do_sigaction+0x92/0x149
  <b0129596> hrtimer_wakeup+0x0/0x1c   <b0129ab0> sys_nanosleep+0x3d/0x51
  <b010267b> syscall_call+0x7/0xb  
 cron          S 03A2C940     0  3843      1          3859  3836 (NOTLB)
        f7e23f1c f7e23ee8 f8475800 03a2c940 00000000 00000000 445ce895 f7fb5cc4 
        dff6e648 dff6e540 b02b0480 b200c340 23033000 000f9663 00000000 b200cd94 
        b200cd8c b200cd8c 264ea2e8 00000282 b012996a 00000000 2e074ae8 00000000 
 Call Trace:
  <b012996a> hrtimer_start+0xc5/0xd0   <b0270109> do_nanosleep+0x3b/0x63
  <b01299b8> hrtimer_nanosleep+0x43/0xfe   <b0120244> do_sigaction+0x92/0x149
  <b0129596> hrtimer_wakeup+0x0/0x1c   <b0129ab0> sys_nanosleep+0x3d/0x51
  <b010267b> syscall_call+0x7/0xb  
 login         S 00895440     0  3859      1  5750    3860  3843 (NOTLB)
        df9abf68 f7f5f580 df9aa000 00895440 00000000 00000000 b18f9d4c 7ee02065 
        dfb81b58 dfb81a50 b02b0480 b200c340 40787740 000f95d1 00000000 f7880740 
        00000140 c647b080 b026f8ed df9abfb4 00000286 00000000 00895440 00000000 
 Call Trace:
  <b026f8ed> schedule+0xa0d/0xaaf   <b011a7cd> do_wait+0x8ab/0x94d
  <b011357b> default_wake_function+0x0/0x15   <b011a896> sys_wait4+0x27/0x2a
  <b010267b> syscall_call+0x7/0xb  
 getty         S 000F4240     0  3860      1          3861  3859 (NOTLB)
        df975edc 00000246 00000000 000f4240 00000000 00000000 00000020 b01fb342 
        dfb7bb98 dfb7ba90 dfb81a50 b200c340 85ce1000 000f41ff 00000000 00000000 
        000000ff b1fdc520 b02b5ba0 b02b5ba0 b01393de df975ec8 00000001 00000202 
 Call Trace:
  <b01fb342> do_con_write+0x141f/0x1450   <b01393de> release_pages+0x147/0x150
  <b01179cd> release_console_sem+0x157/0x191   <b026fd30> schedule_timeout+0x13/0x8b
  <b01fb3ba> con_write+0x1d/0x23   <b01273fc> add_wait_queue+0x12/0x30
  <b01f2383> read_chan+0x321/0x53e   <b011357b> default_wake_function+0x0/0x15
  <b01ee431> tty_read+0x5d/0x9f   <b014bc1d> vfs_read+0xa3/0x13a
  <b014c5cc> sys_read+0x3b/0x64   <b010267b> syscall_call+0x7/0xb
 getty         S 000F4240     0  3861      1          3862  3860 (NOTLB)
        df9a7edc 00000246 00000000 000f4240 00000000 00000000 00000020 b01fb342 
        dfbc7138 dfbc7030 b02b0480 b200c340 861a5b40 000f41ff 00000000 00000000 
        000000ff b1fdc520 b02b5ba0 b02b5ba0 b01393de df9a7ec8 00000001 00000000 
 Call Trace:
  <b01fb342> do_con_write+0x141f/0x1450   <b01393de> release_pages+0x147/0x150
  <b026fd30> schedule_timeout+0x13/0x8b   <b01fb3ba> con_write+0x1d/0x23
  <b01273fc> add_wait_queue+0x12/0x30   <b01f2383> read_chan+0x321/0x53e
  <b011357b> default_wake_function+0x0/0x15   <b01ee431> tty_read+0x5d/0x9f
  <b014bc1d> vfs_read+0xa3/0x13a   <b014c5cc> sys_read+0x3b/0x64
  <b010267b> syscall_call+0x7/0xb  
 getty         S 000F4240     0  3862      1          3863  3861 (NOTLB)
        df99bedc 00000246 00000000 000f4240 00000000 00000000 861a5b40 000f41ff 
        dfbba138 dfbba030 dfbc7030 b200c340 861a5b40 000f41ff 00000000 00000000 
        000000ff b1fdc520 b02b5ba0 b02b5ba0 b200c380 df99bec8 00000001 00000206 
 Call Trace:
  <b01179cd> release_console_sem+0x157/0x191   <b026fd30> schedule_timeout+0x13/0x8b
  <b01fb3ba> con_write+0x1d/0x23   <b01273fc> add_wait_queue+0x12/0x30
  <b01f2383> read_chan+0x321/0x53e   <b011357b> default_wake_function+0x0/0x15
  <b01ee431> tty_read+0x5d/0x9f   <b014bc1d> vfs_read+0xa3/0x13a
  <b014c5cc> sys_read+0x3b/0x64   <b010267b> syscall_call+0x7/0xb
 getty         S 002DC6C0     0  3863      1          3864  3862 (NOTLB)
        f7ed3edc 00000246 00000000 002dc6c0 00000000 00000000 00000020 b01fb342 
        dffafb98 dffafa90 b21a0540 b2014340 85fbd6c0 000f41ff 00000001 00000000 
        000000ff b1fb66e0 b02b5ba0 b02b5ba0 b01393de f7ed3ec8 00000001 00000000 
 Call Trace:
  <b01fb342> do_con_write+0x141f/0x1450   <b01393de> release_pages+0x147/0x150
  <b026fd30> schedule_timeout+0x13/0x8b   <b01fb3ba> con_write+0x1d/0x23
  <b01273fc> add_wait_queue+0x12/0x30   <b01f2383> read_chan+0x321/0x53e
  <b011357b> default_wake_function+0x0/0x15   <b01ee431> tty_read+0x5d/0x9f
  <b014bc1d> vfs_read+0xa3/0x13a   <b014c5cc> sys_read+0x3b/0x64
  <b010267b> syscall_call+0x7/0xb  
 getty         S 000F4240     0  3864      1          5964  3863 (NOTLB)
        df9ededc 00000246 00000000 000f4240 00000000 00000000 00000020 b01fb342 
        dfb75138 dfb75030 b21a0540 b2014340 8638dfc0 000f41ff 00000001 00000000 
        000000ff b1fb66e0 b02b5ba0 b02b5ba0 b01393de df9edec8 00000001 00000000 
 Call Trace:
  <b01fb342> do_con_write+0x141f/0x1450   <b01393de> release_pages+0x147/0x150
  <b026fd30> schedule_timeout+0x13/0x8b   <b01fb3ba> con_write+0x1d/0x23
  <b01273fc> add_wait_queue+0x12/0x30   <b01f2383> read_chan+0x321/0x53e
  <b011357b> default_wake_function+0x0/0x15   <b01ee431> tty_read+0x5d/0x9f
  <b014bc1d> vfs_read+0xa3/0x13a   <b014c5cc> sys_read+0x3b/0x64
  <b010267b> syscall_call+0x7/0xb  
 sshd          S 08B3C880     0  3875   3778  3877    3887       (NOTLB)
        df99fb60 008a184e 0000012b 08b3c880 00000000 00000000 97a171c0 000f4a7c 
        b21dfb58 b21dfa50 dffbfa50 b200c340 3f0f6200 000f4a7d 00000000 00000000 
        df99fb54 b0111803 00000000 00000000 00000003 00000046 f797100c 00000286 
 Call Trace:
  <b0111803> __wake_up+0x29/0x3c   <b026fd30> schedule_timeout+0x13/0x8b
  <b01ee160> tty_poll+0x4a/0x54   <b015baca> do_select+0x3b6/0x41e
  <b021d346> neigh_lookup+0x9c/0xa3   <b015b65c> __pollwait+0x0/0xb8
  <b011357b> default_wake_function+0x0/0x15   <b011357b> default_wake_function+0x0/0x15
  <b011357b> default_wake_function+0x0/0x15   <b011357b> default_wake_function+0x0/0x15
  <b0226a72> qdisc_restart+0x14/0x17f   <b021aff9> dev_queue_xmit+0x1e5/0x1eb
  <b02377ea> ip_output+0x1c0/0x1f6   <b023717e> ip_queue_xmit+0x34d/0x38f
  <b01114b5> __activate_task+0x47/0x56   <b011e999> lock_timer_base+0x15/0x2f
  <b011f2c3> __mod_timer+0x90/0x98   <b0213117> sk_reset_timer+0x12/0x1e
  <b0243dea> update_send_head+0x7a/0x80   <b02468c8> __tcp_push_pending_frames+0x68f/0x74b
  <b0215457> __alloc_skb+0x4a/0xee   <b02133db> release_sock+0xf/0x97
  <b023d9ae> tcp_sendmsg+0x8ab/0x985   <b015bd1a> core_sys_select+0x1e8/0x2a2
  <b0211077> do_sock_write+0xa4/0xad   <b0211625> sock_aio_write+0x56/0x63
  <b014b99a> do_sync_write+0xc0/0xf3   <b01271dc> autoremove_wake_function+0x0/0x3a
  <b015c0ca> sys_select+0x9a/0x166   <b014c630> sys_write+0x3b/0x64
  <b010267b> syscall_call+0x7/0xb  
 bash          S 02CD29C0     0  3877   3875                     (NOTLB)
        df8afedc b01ecee7 00000000 02cd29c0 00000000 00000000 df8b780c df8b7800 
        dffbfb58 dffbfa50 b02b0480 b200c340 3f0f6200 000f4a7d 00000000 00000010 
        00000000 df8aff14 dffbfa50 df8affbc b01209c2 f7814ac0 f7814c18 00000000 
 Call Trace:
  <b01ecee7> tty_ldisc_deref+0x52/0x61   <b01209c2> dequeue_signal+0x36/0xa4
  <b026fd30> schedule_timeout+0x13/0x8b   <b01273fc> add_wait_queue+0x12/0x30
  <b01f2383> read_chan+0x321/0x53e   <b011357b> default_wake_function+0x0/0x15
  <b01ee431> tty_read+0x5d/0x9f   <b014bc1d> vfs_read+0xa3/0x13a
  <b014c5cc> sys_read+0x3b/0x64   <b010267b> syscall_call+0x7/0xb
 sshd          S 1BA81400     0  3887   3778  3889    5760  3875 (NOTLB)
        df8b1b60 df8b1b58 df8b1b58 1ba81400 00000000 00000000 474e1feb 000f4a7e 
        dffbb648 dffbb540 b02b0480 b200c340 4758da80 000f4a7e 00000000 00000001 
        df8b1b54 b0111803 00000000 00000000 00000003 00000046 f780480c 00000000 
 Call Trace:
  <b0111803> __wake_up+0x29/0x3c   <b026fd30> schedule_timeout+0x13/0x8b
  <b01ee160> tty_poll+0x4a/0x54   <b015baca> do_select+0x3b6/0x41e
  <b024a28e> tcp_v4_rcv+0x3ed/0x8dd   <b015b65c> __pollwait+0x0/0xb8
  <b011357b> default_wake_function+0x0/0x15   <b011357b> default_wake_function+0x0/0x15
  <b011357b> default_wake_function+0x0/0x15   <b011357b> default_wake_function+0x0/0x15
  <b0226a72> qdisc_restart+0x14/0x17f   <b021aff9> dev_queue_xmit+0x1e5/0x1eb
  <b02377ea> ip_output+0x1c0/0x1f6   <b023717e> ip_queue_xmit+0x34d/0x38f
  <b021aff9> dev_queue_xmit+0x1e5/0x1eb   <b02377ea> ip_output+0x1c0/0x1f6
  <b023717e> ip_queue_xmit+0x34d/0x38f   <b01055a9> timer_interrupt+0x72/0x7a
  <b011e999> lock_timer_base+0x15/0x2f   <b011f2c3> __mod_timer+0x90/0x98
  <b0213117> sk_reset_timer+0x12/0x1e   <b0243dea> update_send_head+0x7a/0x80
  <b02468c8> __tcp_push_pending_frames+0x68f/0x74b   <b0104a5b> do_IRQ+0x22/0x2b
  <b0215457> __alloc_skb+0x4a/0xee   <b02133db> release_sock+0xf/0x97
  <b023d9ae> tcp_sendmsg+0x8ab/0x985   <b015bd1a> core_sys_select+0x1e8/0x2a2
  <b0211077> do_sock_write+0xa4/0xad   <b0211625> sock_aio_write+0x56/0x63
  <b014b99a> do_sync_write+0xc0/0xf3   <b01271dc> autoremove_wake_function+0x0/0x3a
  <b015c0ca> sys_select+0x9a/0x166   <b014c630> sys_write+0x3b/0x64
  <b010267b> syscall_call+0x7/0xb  
 bash          S 02CD29C0     0  3889   3887                     (NOTLB)
        df9a3edc b01ecee7 00000000 02cd29c0 00000000 00000000 4758da80 000f4a7e 
        dff18b98 dff18a90 dffbb540 b200c340 4758da80 000f4a7e 00000000 00000000 
        00000016 0202c205 00000002 1b02000a b200c380 f792d280 f7f8c634 f7f87280 
 Call Trace:
  <b01ecee7> tty_ldisc_deref+0x52/0x61   <b026fd30> schedule_timeout+0x13/0x8b
  <b01273fc> add_wait_queue+0x12/0x30   <b01f2383> read_chan+0x321/0x53e
  <b011357b> default_wake_function+0x0/0x15   <b01ee431> tty_read+0x5d/0x9f
  <b014bc1d> vfs_read+0xa3/0x13a   <b014c5cc> sys_read+0x3b/0x64
  <b010267b> syscall_call+0x7/0xb  
 bash          S 01312D00     0  5750   3859                     (NOTLB)
        b85cfedc 00000246 00000000 01312d00 00000000 000186a0 00000020 b01fb342 
        dfe73138 dfe73030 b02b0480 b200c340 05584d80 000f966b 00000000 00000000 
        000000ff 00000297 b01ba027 000003d4 00000297 b201e000 df808800 00000000 
 Call Trace:
  <b01fb342> do_con_write+0x141f/0x1450   <b01ba027> vgacon_set_cursor_size+0x34/0xd1
  <b026fd30> schedule_timeout+0x13/0x8b   <b01179cd> release_console_sem+0x157/0x191
  <b01273fc> add_wait_queue+0x12/0x30   <b01f2383> read_chan+0x321/0x53e
  <b011357b> default_wake_function+0x0/0x15   <b01ee431> tty_read+0x5d/0x9f
  <b014bc1d> vfs_read+0xa3/0x13a   <b014c5cc> sys_read+0x3b/0x64
  <b010267b> syscall_call+0x7/0xb  
 sshd          S 0F518240     0  5760   3778  5762    5787  3887 (NOTLB)
        effd1b60 058431d4 00000127 0f518240 00000000 00000000 00000000 b011bdf9 
        dfbba648 dfbba540 b02b0480 b200c340 61511d00 000f966c 00000000 00000001 
        effd1b54 b0111803 00000000 00000000 00000003 00000046 f7d6200c 00000000 
 Call Trace:
  <b011bdf9> __do_softirq+0x57/0xc0   <b0111803> __wake_up+0x29/0x3c
  <b026fd30> schedule_timeout+0x13/0x8b   <b01ee160> tty_poll+0x4a/0x54
  <b015baca> do_select+0x3b6/0x41e   <b015b65c> __pollwait+0x0/0xb8
  <b011357b> default_wake_function+0x0/0x15   <b011357b> default_wake_function+0x0/0x15
  <b011357b> default_wake_function+0x0/0x15   <b011357b> default_wake_function+0x0/0x15
  <b0226a72> qdisc_restart+0x14/0x17f   <b021aff9> dev_queue_xmit+0x1e5/0x1eb
  <b02377ea> ip_output+0x1c0/0x1f6   <b023717e> ip_queue_xmit+0x34d/0x38f
  <b021b373> netif_receive_skb+0x22c/0x24a   <f89008a0> tg3_poll+0x5e8/0x643 [tg3]
  <b011e999> lock_timer_base+0x15/0x2f   <b011f2c3> __mod_timer+0x90/0x98
  <b0213117> sk_reset_timer+0x12/0x1e   <b0243dea> update_send_head+0x7a/0x80
  <b02468c8> __tcp_push_pending_frames+0x68f/0x74b   <b0104a5b> do_IRQ+0x22/0x2b
  <b0215457> __alloc_skb+0x4a/0xee   <b02133db> release_sock+0xf/0x97
  <b023d9ae> tcp_sendmsg+0x8ab/0x985   <b015bd1a> core_sys_select+0x1e8/0x2a2
  <b0211077> do_sock_write+0xa4/0xad   <b0211625> sock_aio_write+0x56/0x63
  <b014b99a> do_sync_write+0xc0/0xf3   <b01271dc> autoremove_wake_function+0x0/0x3a
  <b015c0ca> sys_select+0x9a/0x166   <b014c630> sys_write+0x3b/0x64
  <b010267b> syscall_call+0x7/0xb  
 bash          S 068E7780     0  5762   5760  6115               (NOTLB)
        d3b45f54 b013d869 b1d3cc80 068e7780 00000000 00000000 dfeb9740 b1d3cc80 
        dffbf138 dffbf030 dfbc7a50 b200c340 68f58540 000f9654 00000000 00000000 
        bfdb9080 b134470c 69e64065 f7d6f574 0000001d 000003d8 f789ee00 aff805a4 
 Call Trace:
  <b013d869> do_wp_page+0x268/0x286   <b011a7cd> do_wait+0x8ab/0x94d
  <b011357b> default_wake_function+0x0/0x15   <b011a896> sys_wait4+0x27/0x2a
  <b011a8ac> sys_waitpid+0x13/0x17   <b010267b> syscall_call+0x7/0xb
 sshd          S 08C30AC0     0  5787   3778  5789          5760 (NOTLB)
        b5dbfb60 f792d2e0 000005ea 08c30ac0 00000000 00000000 a4ab0bc0 000f966b 
        dfbc2648 dfbc2540 b02b0480 b200c340 a5ccf680 000f966b 00000000 00000001 
        b5dbfb54 b0111803 00000000 00000000 00000003 00000046 dcd5400c 00000000 
 Call Trace:
  <b0111803> __wake_up+0x29/0x3c   <b026fd30> schedule_timeout+0x13/0x8b
  <b01ee160> tty_poll+0x4a/0x54   <b015baca> do_select+0x3b6/0x41e
  <b015b65c> __pollwait+0x0/0xb8   <b011357b> default_wake_function+0x0/0x15
  <b011357b> default_wake_function+0x0/0x15   <b011357b> default_wake_function+0x0/0x15
  <b011357b> default_wake_function+0x0/0x15   <b0226a72> qdisc_restart+0x14/0x17f
  <b021aff9> dev_queue_xmit+0x1e5/0x1eb   <b02377ea> ip_output+0x1c0/0x1f6
  <b023717e> ip_queue_xmit+0x34d/0x38f   <b011bdf9> __do_softirq+0x57/0xc0
  <b010314c> apic_timer_interrupt+0x1c/0x24   <b0244573> tcp_transmit_skb+0x5dc/0x600
  <b02468c8> __tcp_push_pending_frames+0x68f/0x74b   <b0215457> __alloc_skb+0x4a/0xee
  <b02133db> release_sock+0xf/0x97   <b023d9ae> tcp_sendmsg+0x8ab/0x985
  <b015bd1a> core_sys_select+0x1e8/0x2a2   <b0211077> do_sock_write+0xa4/0xad
  <b0211625> sock_aio_write+0x56/0x63   <b014b99a> do_sync_write+0xc0/0xf3
  <b01271dc> autoremove_wake_function+0x0/0x3a   <b015c0ca> sys_select+0x9a/0x166
  <b014c630> sys_write+0x3b/0x64   <b010267b> syscall_call+0x7/0xb
 bash          S 055D4A80     0  5789   5787                     (NOTLB)
        de097edc b01ecee7 00000000 055d4a80 00000000 0001b207 a5ccf680 000f966b 
        dfbc2b58 dfbc2a50 dfbc2540 b200c340 a5ccf680 000f966b 00000000 00000000 
        00000000 de097f14 dfbc2a50 de097fbc b200c380 f7f3f580 f7f3f6d8 f7f3f6c4 
 Call Trace:
  <b01ecee7> tty_ldisc_deref+0x52/0x61   <b01216d0> get_signal_to_deliver+0x1c0/0x372
  <b026fd30> schedule_timeout+0x13/0x8b   <b01273fc> add_wait_queue+0x12/0x30
  <b01f2383> read_chan+0x321/0x53e   <b011357b> default_wake_function+0x0/0x15
  <b01ee431> tty_read+0x5d/0x9f   <b014bc1d> vfs_read+0xa3/0x13a
  <b014c5cc> sys_read+0x3b/0x64   <b010267b> syscall_call+0x7/0xb
 pdflush       D 37E8BE80     0  5842     11          6085  3699 (L-TLB)
        c7803eec b1bfa900 b1bfa920 37e8be80 00000000 00000000 fc4c7fab 000f9668 
        dfe67688 dfe67580 b21a0540 b2014340 805ef140 000f966c 00000001 00000000 
        00000286 b011e999 00000286 b011e999 c7803efc c7803efc 00000286 00000000 
 Call Trace:
  <b011e999> lock_timer_base+0x15/0x2f   <b011e999> lock_timer_base+0x15/0x2f
  <b026fd89> schedule_timeout+0x6c/0x8b   <b011ecff> process_timeout+0x0/0x9
  <b026ebf5> io_schedule_timeout+0x29/0x33   <b01387eb> pdflush+0x0/0x1b5
  <b01a0a1d> blk_congestion_wait+0x55/0x69   <b01271dc> autoremove_wake_function+0x0/0x3a
  <b0137f01> background_writeout+0x7d/0x8b   <b01388ee> pdflush+0x103/0x1b5
  <b0137e84> background_writeout+0x0/0x8b   <b01271a1> kthread+0xa3/0xd0
  <b01270fe> kthread+0x0/0xd0   <b0100bc5> kernel_thread_helper+0x5/0xb
 syslogd       S 029F6300     0  5964      1          6051  3864 (NOTLB)
        c8d39b60 f88df961 c2e1aed8 029f6300 00000000 00000000 f7c7c260 00001000 
        dffbd178 dffbd070 b02b0480 b200c340 baf35680 000f9666 00000000 00000000 
        b013595f dffe2340 00011200 b733848c 00000246 b01273fc df9d4680 00000000 
 Call Trace:
  <f88df961> ext3_mark_iloc_dirty+0x2df/0x345 [ext3]   <b013595f> mempool_alloc+0x21/0xbf
  <b01273fc> add_wait_queue+0x12/0x30   <b026fd30> schedule_timeout+0x13/0x8b
  <b02112c0> sock_poll+0x13/0x17   <b015baca> do_select+0x3b6/0x41e
  <b015b65c> __pollwait+0x0/0xb8   <b011357b> default_wake_function+0x0/0x15
  <f887355d> __journal_file_buffer+0x111/0x1e7 [jbd]   <f8874995> do_get_write_access+0x44a/0x45c [jbd]
  <f887355d> __journal_file_buffer+0x111/0x1e7 [jbd]   <f8874df9> journal_dirty_metadata+0x173/0x19e [jbd]
  <b013595f> mempool_alloc+0x21/0xbf   <b013595f> mempool_alloc+0x21/0xbf
  <b01a543b> as_set_request+0x1c/0x6d   <b01a5a45> as_update_iohist+0x38/0x2a5
  <b01a63ee> as_add_request+0xc0/0xef   <b019ea34> elv_insert+0x9b/0x138
  <b01a27e6> __make_request+0x319/0x350   <b01342a3> generic_file_buffered_write+0x482/0x56f
  <b01a0268> generic_make_request+0x168/0x17a   <b013595f> mempool_alloc+0x21/0xbf
  <b01a0ad6> submit_bio+0xa5/0xaa   <b015bd1a> core_sys_select+0x1e8/0x2a2
  <b0133749> wait_on_page_writeback_range+0xb3/0xf7   <b011f676> __sigqueue_free+0x2a/0x2f
  <b0120981> __dequeue_signal+0x14b/0x156   <b01053b7> do_gettimeofday+0x1b/0x9d
  <b01053b7> do_gettimeofday+0x1b/0x9d   <b011b6ba> getnstimeofday+0xf/0x25
  <b01acb36> rb_insert_color+0xa6/0xc8   <b01294f4> enqueue_hrtimer+0x58/0x7f
  <b012996a> hrtimer_start+0xc5/0xd0   <b011abdd> do_setitimer+0x16c/0x47d
  <b015c0ca> sys_select+0x9a/0x166   <b0101fc0> sys_sigreturn+0x98/0xbd
  <b010267b> syscall_call+0x7/0xb  
 klogd         R running     0  6051      1                5964 (NOTLB)
 pdflush       D 0E205540     0  6085     11          6130  5842 (L-TLB)
        b4d01eec f792d280 00000204 0e205540 00000000 00000000 ad7d58c0 000f966b 
        dffbbb58 dffbba50 b21a0540 b2014340 7e1b1bc0 000f966c 00000001 00000000 
        00000286 b011e999 00000286 b011e999 b4d01efc b4d01efc 00000286 00000000 
 Call Trace:
  <b011e999> lock_timer_base+0x15/0x2f   <b011e999> lock_timer_base+0x15/0x2f
  <b026fd89> schedule_timeout+0x6c/0x8b   <b011ecff> process_timeout+0x0/0x9
  <b026ebf5> io_schedule_timeout+0x29/0x33   <b01387eb> pdflush+0x0/0x1b5
  <b01a0a1d> blk_congestion_wait+0x55/0x69   <b01271dc> autoremove_wake_function+0x0/0x3a
  <b0137f01> background_writeout+0x7d/0x8b   <b01388ee> pdflush+0x103/0x1b5
  <b0137e84> background_writeout+0x0/0x8b   <b01271a1> kthread+0xa3/0xd0
  <b01270fe> kthread+0x0/0xd0   <b0100bc5> kernel_thread_helper+0x5/0xb
 ncftpget      D 568FC100     0  6115   5762                     (NOTLB)
        cb351a88 87280008 b013595f 568fc100 00000008 00051615 f2a64c80 b21cc340 
        dfbc7b58 dfbc7a50 b02b0480 b200c340 77405900 000f966c 00000000 00000282 
        b011e999 f2a64cd8 00000000 dfec8b84 00000000 dfec8b84 b01a216b 00000000 
 Call Trace:
  <b013595f> mempool_alloc+0x21/0xbf   <b011e999> lock_timer_base+0x15/0x2f
  <b01a216b> get_request+0x55/0x283   <b026f9b5> io_schedule+0x26/0x30
  <b01a2432> get_request_wait+0x99/0xd3   <b01271dc> autoremove_wake_function+0x0/0x3a
  <b01a2786> __make_request+0x2b9/0x350   <b01a0268> generic_make_request+0x168/0x17a
  <b013595f> mempool_alloc+0x21/0xbf   <b01a0ad6> submit_bio+0xa5/0xaa
  <b015032c> bio_alloc+0x13/0x22   <b014dad0> submit_bh+0xe6/0x107
  <b014f9d9> __block_write_full_page+0x20e/0x301   <f88e17e8> ext3_get_block+0x0/0xad [ext3]
  <f88e0633> ext3_ordered_writepage+0xcb/0x137 [ext3]   <f88e17e8> ext3_get_block+0x0/0xad [ext3]
  <f88def99> bget_one+0x0/0xb [ext3]   <b016a1d3> mpage_writepages+0x193/0x2e9
  <f88e0568> ext3_ordered_writepage+0x0/0x137 [ext3]   <b013813f> do_writepages+0x30/0x39
  <b0168988> __writeback_single_inode+0x166/0x2e2   <b01aa9d3> __next_cpu+0x11/0x20
  <b0136421> read_page_state_offset+0x33/0x41   <b0168f5e> sync_sb_inodes+0x185/0x23a
  <b01691c6> writeback_inodes+0x6e/0xbb   <b0138246> balance_dirty_pages_ratelimited_nr+0xcb/0x152
  <b013429e> generic_file_buffered_write+0x47d/0x56f   <f88e698a> __ext3_journal_stop+0x19/0x37 [ext3]
  <f88dfde0> ext3_dirty_inode+0x5e/0x64 [ext3]   <b0168b4c> __mark_inode_dirty+0x28/0x14c
  <b01354da> __generic_file_aio_write_nolock+0x3c8/0x405   <b0211c91> sock_aio_read+0x56/0x63
  <b013573c> generic_file_aio_write+0x61/0xb3   <f88dde72> ext3_file_write+0x26/0x92 [ext3]
  <b014b99a> do_sync_write+0xc0/0xf3   <b016201a> notify_change+0x2d4/0x2e5
  <b01271dc> autoremove_wake_function+0x0/0x3a   <b014bdb0> vfs_write+0xa3/0x13a
  <b014c630> sys_write+0x3b/0x64   <b010267b> syscall_call+0x7/0xb
 pdflush       D 00F42400     0  6130     11          6146  6085 (L-TLB)
        f57ddeec b1964a00 b1fdf940 00f42400 00000000 00000000 b1c75ca0 b1f29320 
        dfb75648 dfb75540 b21a0540 b2014340 7b01a6c0 000f966c 00000001 00000000 
        00000286 b011e999 00000286 b011e999 f57ddefc f57ddefc 00000286 00000000 
 Call Trace:
  <b011e999> lock_timer_base+0x15/0x2f   <b011e999> lock_timer_base+0x15/0x2f
  <b026fd89> schedule_timeout+0x6c/0x8b   <b011ecff> process_timeout+0x0/0x9
  <b026ebf5> io_schedule_timeout+0x29/0x33   <b01387eb> pdflush+0x0/0x1b5
  <b01a0a1d> blk_congestion_wait+0x55/0x69   <b01271dc> autoremove_wake_function+0x0/0x3a
  <b0137f01> background_writeout+0x7d/0x8b   <b01388ee> pdflush+0x103/0x1b5
  <b0137e84> background_writeout+0x0/0x8b   <b01271a1> kthread+0xa3/0xd0
  <b01270fe> kthread+0x0/0xd0   <b0100bc5> kernel_thread_helper+0x5/0xb
 pdflush       D 004C4B40     0  6146     11          6156  6130 (L-TLB)
        dec91eec 00000001 b02f20e0 004c4b40 00000000 00000000 00000000 b02f20e0 
        dfb80178 dfb80070 b21a0540 b2014340 7b8afb00 000f966c 00000001 00000000 
        00000286 b011e999 00000286 b011e999 dec91efc dec91efc 00000286 00000000 
 Call Trace:
  <b011e999> lock_timer_base+0x15/0x2f   <b011e999> lock_timer_base+0x15/0x2f
  <b026fd89> schedule_timeout+0x6c/0x8b   <b011ecff> process_timeout+0x0/0x9
  <b026ebf5> io_schedule_timeout+0x29/0x33   <b01387eb> pdflush+0x0/0x1b5
  <b01a0a1d> blk_congestion_wait+0x55/0x69   <b01271dc> autoremove_wake_function+0x0/0x3a
  <b0137f01> background_writeout+0x7d/0x8b   <b01388ee> pdflush+0x103/0x1b5
  <b0137e84> background_writeout+0x0/0x8b   <b01271a1> kthread+0xa3/0xd0
  <b01270fe> kthread+0x0/0xd0   <b0100bc5> kernel_thread_helper+0x5/0xb
 pdflush       D 04B571C0     0  6156     11          6168  6146 (L-TLB)
        d959feec b1b7c500 b1f0e020 04b571c0 00000000 00000000 14c754c0 000f9669 
        dff15b98 dff15a90 b21a0540 b2014340 7b10e900 000f966c 00000001 00000000 
        00000286 b011e999 00000286 b011e999 d959fefc d959fefc 00000286 00000000 
 Call Trace:
  <b011e999> lock_timer_base+0x15/0x2f   <b011e999> lock_timer_base+0x15/0x2f
  <b026fd89> schedule_timeout+0x6c/0x8b   <b011ecff> process_timeout+0x0/0x9
  <b026ebf5> io_schedule_timeout+0x29/0x33   <b01387eb> pdflush+0x0/0x1b5
  <b01a0a1d> blk_congestion_wait+0x55/0x69   <b01271dc> autoremove_wake_function+0x0/0x3a
  <b0137f01> background_writeout+0x7d/0x8b   <b01388ee> pdflush+0x103/0x1b5
  <b0137e84> background_writeout+0x0/0x8b   <b01271a1> kthread+0xa3/0xd0
  <b01270fe> kthread+0x0/0xd0   <b0100bc5> kernel_thread_helper+0x5/0xb
 pdflush       D 000F4240     0  6168     11                6156 (L-TLB)
        caa13eec 0000000a b23ec9cc 000f4240 00000000 00000000 b01117b5 ebb31f74 
        b21dd178 b21dd070 b21a0540 b2014340 7ee17900 000f966c 00000001 00000000 
        00000286 b011e999 00000286 b011e999 caa13efc caa13efc 00000286 00000000 
 Call Trace:
  <b01117b5> __wake_up_common+0x2a/0x4f   <b011e999> lock_timer_base+0x15/0x2f
  <b011e999> lock_timer_base+0x15/0x2f   <b026fd89> schedule_timeout+0x6c/0x8b
  <b011ecff> process_timeout+0x0/0x9   <b026ebf5> io_schedule_timeout+0x29/0x33
  <b01387eb> pdflush+0x0/0x1b5   <b01a0a1d> blk_congestion_wait+0x55/0x69
  <b01271dc> autoremove_wake_function+0x0/0x3a   <b0137f01> background_writeout+0x7d/0x8b
  <b01388ee> pdflush+0x103/0x1b5   <b0137e84> background_writeout+0x0/0x8b
  <b01271a1> kthread+0xa3/0xd0   <b01270fe> kthread+0x0/0xd0
  <b0100bc5> kernel_thread_helper+0x5/0xb  

--Boundary-00=_GmOXEI7ED0kTH88--
