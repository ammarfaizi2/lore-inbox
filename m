Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751823AbWHATSP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751823AbWHATSP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 15:18:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751829AbWHATSP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 15:18:15 -0400
Received: from relay1.beelinegprs.ru ([217.118.71.5]:45088 "EHLO
	relay2.beelinegprs.ru") by vger.kernel.org with ESMTP
	id S1751823AbWHATSO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 15:18:14 -0400
From: Alexander Zarochentsev <zam@namesys.com>
Organization: namesys
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: reiser4-2.6.18-rc2-mm1: possible circular locking dependency detected in txn_end
Date: Tue, 1 Aug 2006 23:18:36 +0400
User-Agent: KMail/1.8.2
Cc: reiserfs-list@namesys.com, Laurent Riffard <laurent.riffard@free.fr>,
       Kernel development list <linux-kernel@vger.kernel.org>
References: <44CD0115.4010608@free.fr>
In-Reply-To: <44CD0115.4010608@free.fr>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608012318.36995.zam@namesys.com>
X-SpamTest-Info: Profile: Formal (478/060801)
X-SpamTest-Info: Profile: Detect Hard No RBL (4/030526)
X-SpamTest-Info: Profile: SysLog
X-SpamTest-Info: Profile: Marking Spam - Subject (2/030321)
X-SpamTest-Status: Not detected
X-SpamTest-Version: SMTP-Filter Version 2.0.0 [0125], KAS/Release
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Ingo,

there is a new reiser4 / lock validator problem:

On Sunday 30 July 2006 22:57, Laurent Riffard wrote:
> =======================================================
> [ INFO: possible circular locking dependency detected ]
> -------------------------------------------------------
> mv/29012 is trying to acquire lock:
>  (&txnh->hlock){--..}, at: [<e0c8e09b>] txn_end+0x191/0x368 [reiser4]
>
> but task is already holding lock:
>  (&atom->alock){--..}, at: [<e0c8a640>] txnh_get_atom+0xf6/0x39e
> [reiser4]
>
> which lock already depends on the new lock.

it is absolutely legal in reiser4 to lock atom first, then lock 
transaction handle.

i guess the lock validator recorded wrong dependency rule from one place 
where the spinlocks are taken in reverse order.  that place is in 
fs/reiser4/txnmgr.c:atom_begin_and_assign_to_txnh, that atom is new, 
just kmalloc'ed object which is inaccessible for others, so it can't a 
source for deadlock.

but how to explain that to the lock validator?

>
> the existing dependency chain (in reverse order) is:
>
> -> #1 (&atom->alock){--..}:
>        [<c012ce2f>] lock_acquire+0x60/0x80
>        [<c0292968>] _spin_lock+0x19/0x28
>        [<e0c8bbd7>] try_capture+0x7cf/0x1cd7 [reiser4]
>        [<e0c786e1>] longterm_lock_znode+0x427/0x84f [reiser4]
>        [<e0ca55dc>] coord_by_handle+0x2be/0x7f7 [reiser4]
>        [<e0ca5f89>] coord_by_key+0x1e3/0x22d [reiser4]
>        [<e0c7dbd2>] insert_by_key+0x8f/0xe0 [reiser4]
>        [<e0cbf7f1>] write_sd_by_inode_common+0x361/0x61a [reiser4]
>        [<e0cbfce4>] create_object_common+0xf1/0xf6 [reiser4]
>        [<e0cbaebf>] create_vfs_object+0x51d/0x732 [reiser4]
>        [<e0cbb1fd>] mkdir_common+0x43/0x4b [reiser4]
>        [<c015ed33>] vfs_mkdir+0x5a/0x9d
>        [<c0160f5e>] sys_mkdirat+0x88/0xc0
>        [<c0160fa6>] sys_mkdir+0x10/0x12
>        [<c0102c2d>] sysenter_past_esp+0x56/0x8d
>
> -> #0 (&txnh->hlock){--..}:
>        [<c012ce2f>] lock_acquire+0x60/0x80
>        [<c0292968>] _spin_lock+0x19/0x28
>        [<e0c8e09b>] txn_end+0x191/0x368 [reiser4]
>        [<e0c7f97d>] reiser4_exit_context+0x1c2/0x571 [reiser4]
>        [<e0cbb091>] create_vfs_object+0x6ef/0x732 [reiser4]
>        [<e0cbb1fd>] mkdir_common+0x43/0x4b [reiser4]
>        [<c015ed33>] vfs_mkdir+0x5a/0x9d
>        [<c0160f5e>] sys_mkdirat+0x88/0xc0
>        [<c0160fa6>] sys_mkdir+0x10/0x12
>        [<c0102c2d>] sysenter_past_esp+0x56/0x8d
>
> other info that might help us debug this:
>
> 2 locks held by mv/29012:
>  #0:  (&inode->i_mutex/1){--..}, at: [<c015f50b>]
> lookup_create+0x1d/0x73
>  #1:  (&atom->alock){--..}, at: [<e0c8a640>]
> txnh_get_atom+0xf6/0x39e [reiser4]
>
> stack backtrace:
>  [<c0104df0>] show_trace+0xd/0x10
>  [<c0104e0c>] dump_stack+0x19/0x1d
>  [<c012bc62>] print_circular_bug_tail+0x59/0x64
>  [<c012cc3e>] __lock_acquire+0x814/0x9a5
>  [<c012ce2f>] lock_acquire+0x60/0x80
>  [<c0292968>] _spin_lock+0x19/0x28
>  [<e0c8e09b>] txn_end+0x191/0x368 [reiser4]
>  [<e0c7f97d>] reiser4_exit_context+0x1c2/0x571 [reiser4]
>  [<e0cbb091>] create_vfs_object+0x6ef/0x732 [reiser4]
>  [<e0cbb1fd>] mkdir_common+0x43/0x4b [reiser4]
>  [<c015ed33>] vfs_mkdir+0x5a/0x9d
>  [<c0160f5e>] sys_mkdirat+0x88/0xc0
>  [<c0160fa6>] sys_mkdir+0x10/0x12
>  [<c0102c2d>] sysenter_past_esp+0x56/0x8d
>
> (Linux antares.localdomain 2.6.18-rc2-mm1 #77 Sun Jul 30 15:09:34
> CEST 2006 i686 AMD Athlon(TM) XP 1600+ unknown GNU/Linux)

-- 
Alex.

