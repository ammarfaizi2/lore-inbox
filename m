Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261433AbTJ0JWh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Oct 2003 04:22:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261464AbTJ0JWh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Oct 2003 04:22:37 -0500
Received: from 12-235-58-121.client.attbi.com ([12.235.58.121]:34058 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261433AbTJ0JWe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Oct 2003 04:22:34 -0500
Date: Mon, 27 Oct 2003 01:20:02 -0500
From: Christopher Li <ext3-user@chrisli.org>
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: ext3-users@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: EXT3 deadlock in 2.4.22 and 2.4.23-pre7 - quota related?
Message-ID: <20031027062002.GA3544@64m.dyndns.org>
References: <16284.46552.776018.358472@notabene.cse.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16284.46552.776018.358472@notabene.cse.unsw.edu.au>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 27, 2003 at 05:06:16PM +1100, Neil Brown wrote:
> 
> The related kjournald is at:
>     kjournald Call Trace:    [sleep_on+75/124]
>          [journal_commit_transaction+357/4044] [do_IRQ+221/236]
>          [.text.lock.sched+131/471] [kjournald+326/540]
>          [commit_timeout+0/12] [arch_kernel_thread+40/56] 
> 
> This sleep_on is at line 87 in commit.c (journal_commit_transaction)
> where it is waiting for t_updates to be 0.  At this point, 
> t_state is T_LOCKED, so presumably those nfsd threads above are
> waiting on kjournald.  But what is kjournald really waiting for?

kjournald is wait for the current pending transaction to stop.

> My first though was the two nfsd threads  in:
>      nfsd Call Trace:    [sleep_on+75/124]
> 	  [log_wait_commit+74/136] [journal_stop+408/432]
> 	  [journal_force_commit+78/128] [ext3_force_commit+66/112]
> 	  [ext3_sync_file+128/144] [nfsd_sync_dir+49/72]
> 	  [nfsd_unlink+455/480] [nfsd_proc_remove+122/140]
> 	  [nfsd_dispatch+207/406] [svc_process+655/1264]
> 	  [nfsd+566/944] [arch_kernel_thread+40/56] 
> 
> that are waiting on j_wait_done_commit.  However they are doing that
> from journal_stop *after* journal_stop has decremented t_updates, so
> it doesn't seem likely that kjournald is waiting on that.

That is right.

> 
> Outside of nfsd, there is an rquotad program (locally written, not the
> standard one) that is :
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
> 
> So it is trying to start a transaction to update the atime on the
> quota file, and has a lock on some quota structures thanks to
> "read_dqblk".

This guy is waiting the journal commit to be finished, seems harmless
to me.

> 
> At the same time, "sync" is running:
> 
>          sync Call Trace:    [__down+109/208] [__down_failed+8/12]
>              [.text.lock.dquot+73/286] [ext3_sync_dquot+337/462]
>              [vfs_quota_sync+102/372] [sync_dquots_dev+194/260]
>              [fsync_dev+66/128] [sys_sync+7/16] [system_call+51/56] 
> 
> and has started an ext3 transaction (in ext3_sync_dquot) and is trying
> to get the lock that rquotad has.

That seems wrong to me. It should get the lock before it start the
transasction. For the same reason that you can't lock_page inside
journal transasction, it is a ranking error. BTW, it seems that
current bk tree, truncate still do lock_page inside journal
transasction.

> 
> Presumably the transaction that sync has started is keeping t_updates
> greater than 0, thus preventing kjournald from progressing, and this
> preventing anyone else, including rquotad, from starting a new
> transaction.  Hence a deadlock.

That is right.

> 
> My guess is that ext3_sync_dquot doesn't need  ext3_journal_start at
> all but that isn't a well-informed guess.

I think you want to put ext3_sync_dquot to be atomic on power failure.  
The journal handle can get from ext3_current_journal_handle, which
used by writepage etc.

Chris
