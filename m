Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932416AbWE3U6r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932416AbWE3U6r (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 16:58:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932462AbWE3U6q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 16:58:46 -0400
Received: from sj-iport-6.cisco.com ([171.71.176.117]:9019 "EHLO
	sj-iport-6.cisco.com") by vger.kernel.org with ESMTP
	id S932416AbWE3U6q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 16:58:46 -0400
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Arjan van de Ven <arjan@infradead.org>
Subject: Re: [patch, -rc5-mm1] lock validator: fix RT_HASH_LOCK_SZ
X-Message-Flag: Warning: May contain useful information
References: <20060530022925.8a67b613.akpm@osdl.org>
	<adaac8z70yc.fsf@cisco.com> <20060530202654.GA25720@elte.hu>
	<ada1wub6y6b.fsf@cisco.com> <20060530204901.GA27645@elte.hu>
From: Roland Dreier <rdreier@cisco.com>
Date: Tue, 30 May 2006 13:58:43 -0700
In-Reply-To: <20060530204901.GA27645@elte.hu> (Ingo Molnar's message of "Tue, 30 May 2006 22:49:01 +0200")
Message-ID: <adawtc35iws.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 30 May 2006 20:58:45.0194 (UTC) FILETIME=[D6FC0AA0:01C6842B]
Authentication-Results: sj-dkim-3.cisco.com; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks, that boots.

During boot I see this, apparently while mounting NFS filesystems:

[   83.114812] ====================================
[   83.133079] [ BUG: possible deadlock detected! ]
[   83.146881] ------------------------------------
[   83.160683] mount/3531 is trying to acquire lock:
[   83.174745]  (&inode->i_mutex){--..}, at: [<ffffffff804396df>] mutex_lock+0x22/0x27
[   83.197835]
[   83.197836] but task is already holding lock:
[   83.215295]  (&inode->i_mutex){--..}, at: [<ffffffff804396df>] mutex_lock+0x22/0x27
[   83.238386]
[   83.238387] which could potentially lead to deadlocks!
[   83.258207]
[   83.258207] other info that might help us debug this:
[   83.277769] 2 locks held by mount/3531:
[   83.289235]  #0:  (&s->s_umount#16){--..}, at: [<ffffffff8028c0b3>] sget+0x1a0/0x407
[   83.312612]  #1:  (&inode->i_mutex){--..}, at: [<ffffffff804396df>] mutex_lock+0x22/0x27
[   83.337025]
[   83.337026] stack backtrace:
[   83.350101]
[   83.350101] Call Trace:
[   83.361890]  [<ffffffff80247b4e>] __lockdep_acquire+0x18a/0xad2
[   83.379629]  [<ffffffff804396df>] mutex_lock+0x22/0x27
[   83.395038]  [<ffffffff8024887d>] lockdep_acquire+0x82/0xa3
[   83.411748]  [<ffffffff80439450>] __mutex_lock_slowpath+0xfd/0x36a
[   83.430273]  [<ffffffff804396df>] mutex_lock+0x22/0x27
[   83.445703]  [<ffffffff880ce635>] :sunrpc:rpc_populate+0x43/0x141
[   83.463934]  [<ffffffff880cedb8>] :sunrpc:rpc_mkdir+0xb6/0x172
[   83.481383]  [<ffffffff802a1862>] mntput_no_expire+0x1b/0xb9
[   83.498348]  [<ffffffff802a989c>] simple_pin_fs+0xc3/0xd3
[   83.514548]  [<ffffffff880bf8c1>] :sunrpc:rpc_new_client+0x226/0x348
[   83.533592]  [<ffffffff880c06e0>] :sunrpc:rpc_create_client+0xc/0x3e
[   83.552644]  [<ffffffff88105e0c>] :nfs:nfs_get_sb+0x559/0x6e8
[   83.569853]  [<ffffffff8028b827>] vfs_kern_mount+0x8b/0x196
[   83.586560]  [<ffffffff8028b980>] do_kern_mount+0x3c/0x57
[   83.602724]  [<ffffffff802a3596>] do_mount+0x7dd/0x851
[   83.618108]  [<ffffffff80247240>] mark_lock+0x3b/0x4fc
[   83.633520]  [<ffffffff80262a2a>] get_page_from_freelist+0x34e/0x4cc
[   83.652560]  [<ffffffff802479a0>] trace_hardirqs_on+0x165/0x189
[   83.670281]  [<ffffffff80262a99>] get_page_from_freelist+0x3bd/0x4cc
[   83.689324]  [<ffffffff8043b461>] _spin_unlock_irqrestore+0x3f/0x47
[   83.708109]  [<ffffffff80262c2a>] __alloc_pages+0x82/0x33d
[   83.724558]  [<ffffffff802787ef>] alloc_pages_current+0xa0/0xa9
[   83.742301]  [<ffffffff803361fc>] _raw_spin_lock+0xc7/0x15d
[   83.759012]  [<ffffffff802a36a7>] sys_mount+0x9d/0xe9
[   83.774160]  [<ffffffff8043ab11>] trace_hardirqs_on_thunk+0x35/0x37
[   83.792919]  [<ffffffff80209652>] system_call+0x7e/0x83

 - R.
