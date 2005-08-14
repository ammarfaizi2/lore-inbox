Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932510AbVHNMnE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932510AbVHNMnE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Aug 2005 08:43:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932513AbVHNMnE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Aug 2005 08:43:04 -0400
Received: from grendel.sisk.pl ([217.67.200.140]:54706 "HELO mail.sisk.pl")
	by vger.kernel.org with SMTP id S932510AbVHNMnB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Aug 2005 08:43:01 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: 2.6.13-rc5-mm1: BUG: rwlock recursion on CPU#0
Date: Sun, 14 Aug 2005 14:48:36 +0200
User-Agent: KMail/1.8.2
Cc: LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508141448.36562.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've got the following BUG on Asus L5D (x86-64) with the 2.6.13-rc5-mm1 kernel:

BUG: rwlock recursion on CPU#0, nscd/3668, ffffffff8817d4a0

Call Trace:<ffffffff80241ca9>{add_preempt_count+105} <ffffffff80241682>{rwlock_bug+114}
       <ffffffff8024179e>{_raw_write_lock+62} <ffffffff80350f48>{_write_lock_bh+40}
       <ffffffff88171824>{:ip_conntrack:destroy_conntrack+196}
       <ffffffff88170435>{:ip_conntrack:__ip_ct_event_cache_init+165}
       <ffffffff88170549>{:ip_conntrack:ip_ct_refresh_acct+249}
       <ffffffff88173c4f>{:ip_conntrack:udp_packet+47} <ffffffff88172143>{:ip_conntrack:ip_conntrack_in+1059}
       <ffffffff8816fb4c>{:ip_conntrack:ip_conntrack_local+76}
       <ffffffff802fe7ec>{nf_iterate+92} <ffffffff80311d90>{dst_output+0}
       <ffffffff802ff3de>{nf_hook_slow+142} <ffffffff80311d90>{dst_output+0}
       <ffffffff803123bf>{ip_push_pending_frames+895} <ffffffff802eade9>{lock_sock+201}
       <ffffffff8032e72e>{udp_push_pending_frames+574} <ffffffff8032ffc7>{udp_sendmsg+1703}
       <ffffffff8013874e>{current_fs_time+78} <ffffffff8015c03c>{file_read_actor+60}
       <ffffffff80199b6c>{update_atime+76} <ffffffff8015e8fa>{do_generic_mapping_read+1194}
       <ffffffff80335946>{inet_sendmsg+86} <ffffffff802e7dff>{sock_sendmsg+271}
       <ffffffff80241ca9>{add_preempt_count+105} <ffffffff8016153e>{free_hot_cold_page+270}
       <ffffffff801615bb>{free_hot_page+11} <ffffffff80241ca9>{add_preempt_count+105}
       <ffffffff8014a670>{autoremove_wake_function+0} <ffffffff802e846c>{sockfd_lookup+28}
       <ffffffff802e9c64>{sys_sendto+260} <ffffffff80193003>{do_sys_poll+851}
       <ffffffff80193de0>{__pollwait+0} <ffffffff8010eb3e>{system_call+126}
       
---------------------------
| preempt count: 00000303 ]
| 3 level deep critical section nesting:
----------------------------------------
.. [<ffffffff802ff385>] .... nf_hook_slow+0x35/0x160
.....[<ffffffff803123bf>] ..   ( <= ip_push_pending_frames+0x37f/0x490)
.. [<ffffffff80350f40>] .... _write_lock_bh+0x20/0x30
.....[<ffffffff88170500>] ..   ( <= ip_ct_refresh_acct+0xb0/0x160 [ip_conntrack])
.. [<ffffffff80350f40>] .... _write_lock_bh+0x20/0x30
.....[<ffffffff88171824>] ..   ( <= destroy_conntrack+0xc4/0x180 [ip_conntrack])

It does not seem to be easily reproducible.

Greets,
Rafael


-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
