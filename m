Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263423AbTKJNHm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Nov 2003 08:07:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263432AbTKJNHm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Nov 2003 08:07:42 -0500
Received: from [212.86.245.254] ([212.86.245.254]:50048 "EHLO umka.bear.com.ua")
	by vger.kernel.org with ESMTP id S263423AbTKJNHj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Nov 2003 08:07:39 -0500
Content-Type: text/plain; charset=US-ASCII
From: Alex Lyashkov <shadow@itt.net.ru>
Organization: Home
To: Jan Kara <jack@suse.cz>
Subject: Re: [BUG] journal handler reference count breaked and fs deadlocked
Date: Mon, 10 Nov 2003 15:07:18 +0200
User-Agent: KMail/1.4.1
References: <200311092334.01957.shadow@itt.net.ru> <200311101348.49623.shadow@itt.net.ru> <20031110115050.GA17124@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20031110115050.GA17124@atrey.karlin.mff.cuni.cz>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Herbert Poetzl <herbert@13thfloor.at>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200311101507.20959.shadow@itt.net.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >
> > It kernel from my fork vserver project who adapted to RH kernel tree.
> > i do stress testing and see this problems.
> > I see you only rename function, set NO_ATIME to diskquota..
> > and change at one point
> > -		commit_dqblk(dquot);
> > +		dquot->dq_sb->dq_op->write_dquot(dquot);
> > it`s rignt ?
> > i probe to adapted it fix to my kernel..
>
>   Yes, that should be the only changes.
>
I add it but it not fix my problem.. 
i enable debug print in diskquotas and see sync diskquots be finished before 
kernel locked.
sample output:
============================================================
 (revoke.c, 375): journal_cancel_revoke: journal_head c79d6990, cancelling 
revoke
(transaction.c, 567): do_get_write_access: buffer_head c79d6990, force_copy 0   
(revoke.c, 375): journal_cancel_revoke: journal_head c79d6990, cancelling 
revoke
(transaction.c, 1104): journal_dirty_metadata: journal_head c79d6990            
(transaction.c, 1391): journal_stop: Handle c6cd0500 going down                 
(transaction.c, 102): start_this_handle: New handle c6cd0500 going live.        
(transaction.c, 204): start_this_handle: Handle c6cd0500 given 1 credits 
(total)
(inode.c, 2587): ext3_dirty_inode: marking dirty.  outer handle=00000000        
(transaction.c, 567): do_get_write_access: buffer_head c79d6990, force_copy 0   
(revoke.c, 375): journal_cancel_revoke: journal_head c79d6990, cancelling 
revoke
(transaction.c, 567): do_get_write_access: buffer_head c79d6990, force_copy 0   
(revoke.c, 375): journal_cancel_revoke: journal_head c79d6990, cancelling 
revoke
(transaction.c, 1104): journal_dirty_metadata: journal_head c79d6990            
(transaction.c, 1391): journal_stop: Handle c6cd0500 going down                 
(transaction.c, 102): start_this_handle: New handle c6cd0500 going live.        
(transaction.c, 204): start_this_handle: Handle c6cd0500 given 1 credits 
(total)
(inode.c, 2587): ext3_dirty_inode: marking dirty.  outer handle=00000000        
(transaction.c, 102): start_this_handle: New handle c6cd0340 going live.        
(transaction.c, 204): start_this_handle: Handle c6cd0340 given 26 credits 
(tota)
(transaction.c, 955): journal_dirty_data: jh: c79d6c00, tid:507179              
(transaction.c, 1391): journal_stop: Handle c6cd0340 going down                 
dqput(): dq:c7b7e180                                                            
put_dqout_ref c7b7e180 341 USR 81                                               
ctx_sync_dquots end                                                       
(journal.c, 581): log_start_commit: JBD: requesting commit 507179/507178        
(journal.c, 608): log_wait_commit: JBD: want 507179, j_commit_sequence=507178   
(journal.c, 263): kjournald: kjournald wakes                                    
(journal.c, 238): kjournald: commit_sequence=507178, commit_request=507179      
(journal.c, 242): kjournald: OK, requests differ                                
(commit.c, 81): journal_commit_transaction: JBD: starting commit of 
transaction9
(commit.c, 87): journal_commit_transaction: wait updates.......                 
(transaction.c, 102): start_this_handle: New handle c6cd0340 going live.        
(transaction.c, 136): start_this_handle: Handle c6cd0340 stalling...            
(transaction.c, 567): do_get_write_access: buffer_head c79d6480, force_copy 0   
(revoke.c, 375): journal_cancel_revoke: journal_head c79d6480, cancelling 
revoke
(transaction.c, 567): do_get_write_access: buffer_head c79d6480, force_copy 0   
(revoke.c, 375): journal_cancel_revoke: journal_head c79d6480, cancelling 
revoke
(transaction.c, 1104): journal_dirty_metadata: journal_head c79d6480            
(transaction.c, 567): do_get_write_access: buffer_head c79d61e0, force_copy 0   
(revoke.c, 375): journal_cancel_revoke: journal_head c79d61e0, cancelling 
revoke
(transaction.c, 567): do_get_write_access: buffer_head c79d61e0, force_copy 0   
(revoke.c, 375): journal_cancel_revoke: journal_head c79d61e0, cancelling 
revoke
(transaction.c, 1104): journal_dirty_metadata: journal_head c79d61e0            
(transaction.c, 567): do_get_write_access: buffer_head c79d6990, force_copy 0   
(revoke.c, 375): journal_cancel_revoke: journal_head c79d6990, cancelling 
revoke
(transaction.c, 567): do_get_write_access: buffer_head c79d6990, force_copy 0   
(revoke.c, 375): journal_cancel_revoke: journal_head c79d6990, cancelling 
revoke
(transaction.c, 1104): journal_dirty_metadata: journal_head c79d6990            
(transaction.c, 1391): journal_stop: Handle c6cd0500 going down                 
(transaction.c, 102): start_this_handle: New handle c6cd0500 going live.        
(transaction.c, 136): start_this_handle: Handle c6cd0500 stalling...           
================
if you need full log - i can upload it to freevps.com.

i think races not in a diskquotas, but in ext3fs or jbd :-\

-- 
With best regards,
Alex
