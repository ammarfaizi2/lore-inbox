Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932469AbWE3VOc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932469AbWE3VOc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 17:14:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932473AbWE3VOc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 17:14:32 -0400
Received: from sj-iport-4.cisco.com ([171.68.10.86]:65122 "EHLO
	sj-iport-4.cisco.com") by vger.kernel.org with ESMTP
	id S932469AbWE3VOb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 17:14:31 -0400
X-IronPort-AV: i="4.05,190,1146466800"; 
   d="scan'208"; a="1815669385:sNHT34650252"
To: Arjan van de Ven <arjan@infradead.org>
Cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch, -rc5-mm1] lock validator: fix RT_HASH_LOCK_SZ
X-Message-Flag: Warning: May contain useful information
References: <20060530022925.8a67b613.akpm@osdl.org>
	<adaac8z70yc.fsf@cisco.com> <20060530202654.GA25720@elte.hu>
	<ada1wub6y6b.fsf@cisco.com> <20060530204901.GA27645@elte.hu>
	<adawtc35iws.fsf@cisco.com>
	<1149022880.3636.116.camel@laptopd505.fenrus.org>
From: Roland Dreier <rdreier@cisco.com>
Date: Tue, 30 May 2006 14:14:30 -0700
In-Reply-To: <1149022880.3636.116.camel@laptopd505.fenrus.org> (Arjan van de Ven's message of "Tue, 30 May 2006 23:01:20 +0200")
Message-ID: <adaodxf5i6h.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 30 May 2006 21:14:30.0740 (UTC) FILETIME=[0A92E940:01C6842E]
Authentication-Results: sj-dkim-2.cisco.com; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here it is with KALLSYMS_ALL:

[   80.587694] ====================================
[   80.605928] [ BUG: possible deadlock detected! ]
[   80.619729] ------------------------------------
[   80.633532] mount/3534 is trying to acquire lock:
[   80.647593]  (&inode->i_mutex){--..}, at: [<ffffffff804396af>] mutex_lock+0x22/0x27
[   80.670683]
[   80.670684] but task is already holding lock:
[   80.688170]  (&inode->i_mutex){--..}, at: [<ffffffff804396af>] mutex_lock+0x22/0x27
[   80.711260]
[   80.711261] which could potentially lead to deadlocks!
[   80.731083]
[   80.731083] other info that might help us debug this:
[   80.750618] 2 locks held by mount/3534:
[   80.762085]  #0:  (&s->s_umount#16){--..}, at: [<ffffffff8028c07b>] sget+0x1a0/0x407
[   80.785513]  #1:  (&inode->i_mutex){--..}, at: [<ffffffff804396af>] mutex_lock+0x22/0x27
[   80.809952]
[   80.809952] stack backtrace:
[   80.823003]
[   80.823003] Call Trace:
[   80.834790]  [<ffffffff80247b4e>] __lockdep_acquire+0x18a/0xad2
[   80.852503]  [<ffffffff804396af>] mutex_lock+0x22/0x27
[   80.867887]  [<ffffffff8024887d>] lockdep_acquire+0x82/0xa3
[   80.884596]  [<ffffffff80439420>] __mutex_lock_slowpath+0xfd/0x36a
[   80.903095]  [<ffffffff804396af>] mutex_lock+0x22/0x27
[   80.918499]  [<ffffffff880ce635>] :sunrpc:rpc_populate+0x43/0x141
[   80.936759]  [<ffffffff880cedb8>] :sunrpc:rpc_mkdir+0xb6/0x172
[   80.954206]  [<ffffffff802a182a>] mntput_no_expire+0x1b/0xb9
[   80.971173]  [<ffffffff802a9864>] simple_pin_fs+0xc3/0xd3
[   80.987371]  [<ffffffff880bf8c1>] :sunrpc:rpc_new_client+0x226/0x348
[   81.006390]  [<ffffffff880c06e0>] :sunrpc:rpc_create_client+0xc/0x3e
[   81.025415]  [<ffffffff88105e0c>] :nfs:nfs_get_sb+0x559/0x6e8
[   81.042598]  [<ffffffff8028b7ef>] vfs_kern_mount+0x8b/0x196
[   81.059305]  [<ffffffff8028b948>] do_kern_mount+0x3c/0x57
[   81.075495]  [<ffffffff802a355e>] do_mount+0x7dd/0x851
[   81.090906]  [<ffffffff80247240>] mark_lock+0x3b/0x4fc
[   81.106289]  [<ffffffff802629f2>] get_page_from_freelist+0x34e/0x4cc
[   81.125331]  [<ffffffff802479a0>] trace_hardirqs_on+0x165/0x189
[   81.143050]  [<ffffffff80262a61>] get_page_from_freelist+0x3bd/0x4cc
[   81.162094]  [<ffffffff8043b431>] _spin_unlock_irqrestore+0x3f/0x47
[   81.180880]  [<ffffffff80262bf2>] __alloc_pages+0x82/0x33d
[   81.197332]  [<ffffffff802787b7>] alloc_pages_current+0xa0/0xa9
[   81.215074]  [<ffffffff803361cc>] _raw_spin_lock+0xc7/0x15d
[   81.231781]  [<ffffffff802a366f>] sys_mount+0x9d/0xe9
[   81.246905]  [<ffffffff8043aae1>] trace_hardirqs_on_thunk+0x35/0x37
[   81.265690]  [<ffffffff80209652>] system_call+0x7e/0x83
