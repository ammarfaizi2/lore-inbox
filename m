Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263828AbUD0GpY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263828AbUD0GpY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 02:45:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263823AbUD0GpY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 02:45:24 -0400
Received: from smtp1.Stanford.EDU ([171.67.16.120]:30951 "EHLO
	smtp1.Stanford.EDU") by vger.kernel.org with ESMTP id S263828AbUD0GpR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 02:45:17 -0400
Date: Mon, 26 Apr 2004 23:45:14 -0700 (PDT)
From: Junfeng Yang <yjf@stanford.edu>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       <ext2-devel@lists.sourceforge.net>, <mc@cs.Stanford.EDU>,
       Madanlal S Musuvathi <madan@stanford.edu>,
       "David L. Dill" <dill@cs.Stanford.EDU>
Subject: [CHECKER] A potential memory leak in fs/jbd/commit.c (2.4.19)
Message-ID: <Pine.GSO.4.44.0404262344340.7325-100000@elaine24.Stanford.EDU>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Below is a potential leak in file fs/jbd/commit.c
------------------------------------------------------------------------------
[BUG] jb->b_commited_data && jh->b_frozen_data may be leaked when journal
is aborted.  journal will be set to abort when we can't locate the next
log block or we can't get a new descriptor.  if current journal head jh
happens to have b_commited_data or b_frozen_data associated with it,
they'll be leaked.

void journal_commit_transaction(journal_t *journal)
{

....

	while (commit_transaction->t_buffers) {

		/* Find the next buffer to be journaled... */

		jh = commit_transaction->t_buffers;

		/* If we're in abort mode, we just un-journal the buffer and
		   release it for background writing. */

		if (is_journal_aborted(journal)) {
			JBUFFER_TRACE(jh, "journal is aborting: refile");
ERROR-->		journal_refile_buffer(jh);
			/* If that was the last one, we need to clean up
			 * any descriptor buffers which may have been
			 * already allocated, even if we are now
			 * aborting. */
			if (!commit_transaction->t_buffers)
				goto start_journal_io;
			continue;
		}

....
		/* Where is the buffer to be written? */

		err = journal_next_log_block(journal, &blocknr);
		/* If the block mapping failed, just abandon the buffer
		   and repeat this loop: we'll fall into the
		   refile-on-abort condition above. */
		if (err) {
ABORT-->		__journal_abort_hard(journal);
			continue;
		}
...
}

