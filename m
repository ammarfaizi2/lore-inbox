Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263831AbUD0Gr1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263831AbUD0Gr1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 02:47:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263835AbUD0Gr1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 02:47:27 -0400
Received: from smtp1.Stanford.EDU ([171.67.16.120]:28649 "EHLO
	smtp1.Stanford.EDU") by vger.kernel.org with ESMTP id S263831AbUD0GrT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 02:47:19 -0400
Date: Mon, 26 Apr 2004 23:47:14 -0700 (PDT)
From: Junfeng Yang <yjf@stanford.edu>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       <ext2-devel@lists.sourceforge.net>, <mc@cs.Stanford.EDU>,
       Madanlal S Musuvathi <madan@stanford.edu>,
       "David L. Dill" <dill@cs.Stanford.EDU>
Subject: [CHECKER] possible violation of journaling semantics in JBD (2.4.19)?
Message-ID: <Pine.GSO.4.44.0404262345180.7325-100000@elaine24.Stanford.EDU>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

We are checking JBD & EXT3 and came across a warning complaining that the
filesystem is in inconsistent state when the journal is aborted at line
589.  After looking at the code, it seems that whenever JBD can't get a
descriptor, it'll pass everything back to bdflush/kupdated (at line 691).
This may leave filesystem in irrecovable inconsistent state if buffers are
flushed out (by bdflush + disk scheduler) in a bad order.  My
understanding is that if the current transaction can't be commited, we
should just drop it without damaging any old metadata on disk.  Is my
understanding correct?  Or are there any tricky things I missed?


587        	descriptor = journal_get_descriptor_buffer(journal);
588        	if (!descriptor) {
589        		__journal_abort_hard(journal);
593        		goto skip_commit;
594        	}
596        	/* AKPM: buglet - add `i' to tmp! */
597        	for (i = 0; i < jh2bh(descriptor)->b_size; i += 512) {
598        		journal_header_t *tmp =
599        			(journal_header_t*)jh2bh(descriptor)->b_data;
600        		tmp->h_magic = htonl(JFS_MAGIC_NUMBER);
601        		tmp->h_blocktype = htonl(JFS_COMMIT_BLOCK);
602        		tmp->h_sequence = htonl(commit_transaction->t_tid);
603        	}

		...

631        skip_commit:
633        	jbd_debug(3, "JBD: commit phase 7\n");
635        	J_ASSERT(commit_transaction->t_sync_datalist == NULL);
636        	J_ASSERT(commit_transaction->t_async_datalist == NULL);
637        	J_ASSERT(commit_transaction->t_buffers == NULL);
638        	J_ASSERT(commit_transaction->t_checkpoint_list == NULL);
639        	J_ASSERT(commit_transaction->t_iobuf_list == NULL);
640        	J_ASSERT(commit_transaction->t_shadow_list == NULL);
641        	J_ASSERT(commit_transaction->t_log_list == NULL);
643        	while (commit_transaction->t_forget) {

		....

686        		bh = jh2bh(jh);
687        		if (buffer_jdirty(bh)) {
688        			JBUFFER_TRACE(jh, "add to new checkpointing trans");
689        			__journal_insert_checkpoint(jh, commit_transaction);
690        			JBUFFER_TRACE(jh, "refile for checkpoint writeback");
691        			__journal_refile_buffer(jh);
692        		} else {
693        			J_ASSERT_BH(bh, !buffer_dirty(bh));
694        			J_ASSERT_JH(jh, jh->b_next_transaction == NULL);
695        			__journal_unfile_buffer(jh);
696        			jh->b_transaction = 0;
697        			__journal_remove_journal_head(bh);
698        			__brelse(bh);
699        		}
700        		spin_unlock(&journal_datalist_lock);
701        	}

