Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263858AbUD0Gtf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263858AbUD0Gtf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 02:49:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263845AbUD0Gtf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 02:49:35 -0400
Received: from smtp1.Stanford.EDU ([171.67.16.120]:26091 "EHLO
	smtp1.Stanford.EDU") by vger.kernel.org with ESMTP id S263858AbUD0GtH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 02:49:07 -0400
Date: Mon, 26 Apr 2004 23:49:05 -0700 (PDT)
From: Junfeng Yang <yjf@stanford.edu>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       <ext2-devel@lists.sourceforge.net>, <mc@cs.Stanford.EDU>,
       Madanlal S Musuvathi <madan@stanford.edu>,
       "David L. Dill" <dill@cs.Stanford.EDU>
Subject: [CHECKER] no mark_buffer_dirty in journal_set_features in JBD
Message-ID: <Pine.GSO.4.44.0404262347420.7345-100000@elaine24.Stanford.EDU>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The function journal_set_features in fs/jbd/journal.c modifies the journal
super block, but doesn't not mark it dirty.  Seems an error, but could be
that these features don't need to be updated on disk.

file fs/jbd/journal.c
-------------------------------------------------------------------
[BUG] sb is modified but not marked dirty

/* Published API: Mark a given journal feature as present on the
 * superblock.  Returns true if the requested features could be set. */

int journal_set_features (journal_t *journal, unsigned long compat,
			  unsigned long ro, unsigned long incompat)
{
	journal_superblock_t *sb;

	if (journal_check_used_features(journal, compat, ro, incompat))
		return 1;

	if (!journal_check_available_features(journal, compat, ro, incompat))
		return 0;

	jbd_debug(1, "Setting new features 0x%lx/0x%lx/0x%lx\n",
		  compat, ro, incompat);

	sb = journal->j_superblock;

	sb->s_feature_compat    |= cpu_to_be32(compat);
	sb->s_feature_ro_compat |= cpu_to_be32(ro);
	sb->s_feature_incompat  |= cpu_to_be32(incompat);
	return 1;
}

