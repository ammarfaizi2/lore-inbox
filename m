Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261368AbTJ0KBq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Oct 2003 05:01:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261552AbTJ0KBq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Oct 2003 05:01:46 -0500
Received: from fw.osdl.org ([65.172.181.6]:65241 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261368AbTJ0KAn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Oct 2003 05:00:43 -0500
Date: Mon, 27 Oct 2003 02:01:51 -0800
From: Andrew Morton <akpm@osdl.org>
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: ext3-users@redhat.com, linux-kernel@vger.kernel.org,
       Jan Kara <jack@ucw.cz>
Subject: Re: EXT3 deadlock in 2.4.22 and 2.4.23-pre7 - quota related?
Message-Id: <20031027020151.333fcb9e.akpm@osdl.org>
In-Reply-To: <16284.46552.776018.358472@notabene.cse.unsw.edu.au>
References: <16284.46552.776018.358472@notabene.cse.unsw.edu.au>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Brown <neilb@cse.unsw.edu.au> wrote:
>
> 
> Hi all, and particularly Andrew and Stephen,
> 
>  I recently "upgraded' one of my NFS fileservers from (patched)2.4.18
>  to 2.4.23-pre7 (in order to resolve a HIMEM related memory pressure
>  problem).
> 
>  Unfortunately I have experienced what appears to be a deadlock.
>

I don't recall a time when quotas on ext3 were not deadlocky :(

> ...
> 
>       rquotad Call Trace:    [sleep_on+75/124]
>             [start_this_handle+205/368] [journal_start+149/196]
>             [ext3_dirty_inode+116/268] [__mark_inode_dirty+50/168]
>             [update_atime+75/80] [do_generic_file_read+1158/1172]
>             [generic_file_read+147/400] [file_read_actor+0/224]
>             [do_get_write_access+1382/1420] [v1_read_dqblk+121/196]
>             [read_dqblk+76/128] [dqget+344/484] [vfs_get_dqblk+21/64]
>             [v1_get_dqblk+39/172] [link_path_walk+2680/2956]
>             [do_compat_quotactl+417/688] [resolve_dev+89/108]
>             [sys_quotactl+166/275] [system_call+51/56] 

read_dqblk() took dqio_sem, then ext3_dirty_inode() did journal_start().

> At the same time, "sync" is running:
> 
>          sync Call Trace:    [__down+109/208] [__down_failed+8/12]
>              [.text.lock.dquot+73/286] [ext3_sync_dquot+337/462]
>              [vfs_quota_sync+102/372] [sync_dquots_dev+194/260]
>              [fsync_dev+66/128] [sys_sync+7/16] [system_call+51/56] 

ext3_sync_dquot() did journal_start(), then someone (commit_dqblk?) tried
to take dqio_sem.

Probably it is not too hard to flip the ordering in the latter case, but all
other code paths need to be checked, and perhaps even documented.

Jan, didn't we fix this very problem in 2.6 recently?


