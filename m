Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261152AbTJ0GGb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Oct 2003 01:06:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261159AbTJ0GGb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Oct 2003 01:06:31 -0500
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:41645 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id S261152AbTJ0GG1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Oct 2003 01:06:27 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: ext3-users@redhat.com, linux-kernel@vger.kernel.org
Date: Mon, 27 Oct 2003 17:06:16 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16284.46552.776018.358472@notabene.cse.unsw.edu.au>
Subject: EXT3 deadlock in 2.4.22 and 2.4.23-pre7 - quota related?
X-Mailer: VM 7.17 under Emacs 21.3.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi all, and particularly Andrew and Stephen,

 I recently "upgraded' one of my NFS fileservers from (patched)2.4.18
 to 2.4.23-pre7 (in order to resolve a HIMEM related memory pressure
 problem).

 Unfortunately I have experienced what appears to be a deadlock.
 The one I will describe was experienced while running 2.4.23-pre7,
 though I had a very similar problem in 2.4.22 (but didn't collect
 enough data to be able to give a useful report at the time).

 An ext3 filesystem is mounted with data=journal, with an external
 journal, and accessed mostly via NFS.  v1 quotas are enabled.

 The stacktrace lines below are from a lightly editted 
   "echo t > /proc/sysrq-trigger"
 output.


 A substantial number of nfsd threads a waiting to "start a handle":
    nfsd Call Trace:    [sleep_on+75/124]
         [start_this_handle+205/368] [journal_start+149/196]
         [ext3_dirty_inode+116/268] [__mark_inode_dirty+50/168]
         [update_atime+75/80] [do_generic_file_read+1158/1172]
         [generic_file_read+147/400] [file_read_actor+0/224]
         [nfsd_read+477/636] [nfsd3_proc_read+295/388]
         [nfsd_dispatch+207/406] [svc_process+655/1264] [nfsd+566/944]
         [arch_kernel_thread+40/56] 

This sleep_on is the one at line 136 of
transcation.c(start_this_handle), where it is waiting for t_state to
stop being T_LOCKED. 

The related kjournald is at:
    kjournald Call Trace:    [sleep_on+75/124]
         [journal_commit_transaction+357/4044] [do_IRQ+221/236]
         [.text.lock.sched+131/471] [kjournald+326/540]
         [commit_timeout+0/12] [arch_kernel_thread+40/56] 

This sleep_on is at line 87 in commit.c (journal_commit_transaction)
where it is waiting for t_updates to be 0.  At this point, 
t_state is T_LOCKED, so presumably those nfsd threads above are
waiting on kjournald.  But what is kjournald really waiting for?
My first though was the two nfsd threads  in:
     nfsd Call Trace:    [sleep_on+75/124]
	  [log_wait_commit+74/136] [journal_stop+408/432]
	  [journal_force_commit+78/128] [ext3_force_commit+66/112]
	  [ext3_sync_file+128/144] [nfsd_sync_dir+49/72]
	  [nfsd_unlink+455/480] [nfsd_proc_remove+122/140]
	  [nfsd_dispatch+207/406] [svc_process+655/1264]
	  [nfsd+566/944] [arch_kernel_thread+40/56] 

that are waiting on j_wait_done_commit.  However they are doing that
from journal_stop *after* journal_stop has decremented t_updates, so
it doesn't seem likely that kjournald is waiting on that.

Outside of nfsd, there is an rquotad program (locally written, not the
standard one) that is :

      rquotad Call Trace:    [sleep_on+75/124]
            [start_this_handle+205/368] [journal_start+149/196]
            [ext3_dirty_inode+116/268] [__mark_inode_dirty+50/168]
            [update_atime+75/80] [do_generic_file_read+1158/1172]
            [generic_file_read+147/400] [file_read_actor+0/224]
            [do_get_write_access+1382/1420] [v1_read_dqblk+121/196]
            [read_dqblk+76/128] [dqget+344/484] [vfs_get_dqblk+21/64]
            [v1_get_dqblk+39/172] [link_path_walk+2680/2956]
            [do_compat_quotactl+417/688] [resolve_dev+89/108]
            [sys_quotactl+166/275] [system_call+51/56] 

So it is trying to start a transaction to update the atime on the
quota file, and has a lock on some quota structures thanks to
"read_dqblk".

At the same time, "sync" is running:

         sync Call Trace:    [__down+109/208] [__down_failed+8/12]
             [.text.lock.dquot+73/286] [ext3_sync_dquot+337/462]
             [vfs_quota_sync+102/372] [sync_dquots_dev+194/260]
             [fsync_dev+66/128] [sys_sync+7/16] [system_call+51/56] 

and has started an ext3 transaction (in ext3_sync_dquot) and is trying
to get the lock that rquotad has.

Presumably the transaction that sync has started is keeping t_updates
greater than 0, thus preventing kjournald from progressing, and this
preventing anyone else, including rquotad, from starting a new
transaction.  Hence a deadlock.

The incomplete trace that I have from the first time this problem
happened also has sync blocks in the same place, and an nfsd thread,
rather than rquotad, holding a lock in read_dqblk.

I note that ext3_sync_dquot didn't exist in 2.4.18 and does now, so
that correlated well with the observation that this problem has been
introduced since 2.4.18.

If my analysis is correct, I can largely avoid the problem by not
running "sync" as much (I currently run it every 5 minutes which isn't
needed any longer (it's a long story:-)) but that doesn't fix the bug.

My guess is that ext3_sync_dquot doesn't need  ext3_journal_start at
all but that isn't a well-informed guess.

Help appreciated.

NeilBrown
