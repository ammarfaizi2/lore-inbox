Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264915AbUELBxu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264915AbUELBxu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 21:53:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264904AbUELBxt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 21:53:49 -0400
Received: from smtp3.Stanford.EDU ([171.67.16.138]:49643 "EHLO
	smtp3.Stanford.EDU") by vger.kernel.org with ESMTP id S264915AbUELBtQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 21:49:16 -0400
Date: Tue, 11 May 2004 18:49:14 -0700 (PDT)
From: Junfeng Yang <yjf@stanford.edu>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       <ext2-devel@lists.sourceforge.net>
Subject: Re: [MC] [CHECKER] e2fsck writes out blocks out of order, causing
 root dir to be corrupted (ext3, linux 2.4.19, e2fsprogs 1.34)
In-Reply-To: <Pine.GSO.4.44.0405111749290.2448-100000@elaine24.Stanford.EDU>
Message-ID: <Pine.GSO.4.44.0405111844510.4285-100000@elaine24.Stanford.EDU>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Although the kernel and e2fsck share the same copy of recovery.c, the same
problem doesn't seem to exist to the kernel, since fsync_no_super will do
the sync for the kernel.  While for e2fsck, fsync_no_super is defined as a
nop.

int journal_recover(journal_t *journal)
{
	int			err;
	journal_superblock_t *	sb;

	struct recovery_info	info;

	memset(&info, 0, sizeof(info));
	sb = journal->j_superblock;

	/*
	 * The journal superblock's s_start field (the current log head)
	 * is always zero if, and only if, the journal was cleanly
	 * unmounted.
	 */

	if (!sb->s_start) {
		jbd_debug(1, "No recovery required, last transaction
%d\n",
			  ntohl(sb->s_sequence));
		journal->j_transaction_sequence = ntohl(sb->s_sequence) +
1;
		return 0;
	}


	err = do_one_pass(journal, &info, PASS_SCAN);
	if (!err)
		err = do_one_pass(journal, &info, PASS_REVOKE);
	if (!err)
		err = do_one_pass(journal, &info, PASS_REPLAY);

	jbd_debug(0, "JBD: recovery, exit status %d, "
		  "recovered transactions %u to %u\n",
		  err, info.start_transaction, info.end_transaction);
	jbd_debug(0, "JBD: Replayed %d and revoked %d/%d blocks\n",
		  info.nr_replays, info.nr_revoke_hits, info.nr_revokes);

	/* Restart the log at the next transaction ID, thus invalidating
	 * any existing commit records in the log. */
	journal->j_transaction_sequence = ++info.end_transaction;

	journal_clear_revoke(journal);
	fsync_no_super(journal->j_fs_dev);
	return err;
}


