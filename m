Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266658AbUBMCFa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Feb 2004 21:05:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266679AbUBMCFa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Feb 2004 21:05:30 -0500
Received: from fw.osdl.org ([65.172.181.6]:61077 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266658AbUBMCFM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Feb 2004 21:05:12 -0500
Date: Thu, 12 Feb 2004 18:06:59 -0800
From: Andrew Morton <akpm@osdl.org>
To: Jan Kara <jack@suse.cz>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] Journalled quota (fwd)
Message-Id: <20040212180659.7d5bcb07.akpm@osdl.org>
In-Reply-To: <20040212111128.GA32552@atrey.karlin.mff.cuni.cz>
References: <20040212111128.GA32552@atrey.karlin.mff.cuni.cz>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Kara <jack@suse.cz> wrote:
>
>   Here comes journalled quota patch for 2.6.3-rc2.

Could you please document the locking rules?  For example, functions such
as DQUOT_FREE_SPACE_NODIRTY() (and all similar) should have a little
comment above them describing the caller's locking responsibilities.

Because it looks to me like DQUOT_FREE_SPACE_NODIRTY() is supposed to be
called under i_lock, but will call dquot_free_space(), which does
down_read().


I didn't review your changes to the ext3 transaction space reservation
constants.  Did you get them right?  Mistakes here tend to take a long time
to show up.

In ext3_orphan_cleanup():

  - Local variable `i' is unused if !CONFIG_QUOTA and will generate a
    compiler warning.

  - This

	for (i=0; i < MAXQUOTAS; i++)

    introduces coding style inconsistency.  Please do

	for (i = 0; i < MAXQUOTAS; i++)

  - Please edit in an 80-column xterm.  Changes you have made to this
    filesystem are quite infuriating to those who _do_ use 80-cols and need
    to be cleaned up.

  - This

	for (i=0; i < MAXQUOTAS; i++)
		if (EXT3_SB(sb)->s_qf_names[i]) {
			int ret = ext3_quota_on_mount(sb, i);

    introduces coding style inconsistency.  Please do

	for (i=0; i < MAXQUOTAS; i++) {
		if (EXT3_SB(sb)->s_qf_names[i]) {
			int ret = ext3_quota_on_mount(sb, i);

    (several places)


Please document writes_to_blocks()


The locking in v2_commit_dquot() looks fishy.

The locking in dquot_mark_dquot_dirty() and in mark_info_dirty() also look
fishy.  For example:

	void mark_info_dirty(struct super_block *sb, int type)
	{
		spin_lock(&dq_data_lock);
		set_bit(DQF_INFO_DIRTY_B, &sb_dqopt(sb)->info[type].dqi_flags);
		spin_unlock(&dq_data_lock);
	}

what is the spinlock doing there?


I'm not really in a position to review the deadlockiness of this code
without some sort of documentation of the lock ranking (including where
journal_start() sits in that ranking).  Is that something you could add?

Thanks.
