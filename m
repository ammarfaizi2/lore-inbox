Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267087AbUBMQRH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 11:17:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267096AbUBMQQq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 11:16:46 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:10125 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S267087AbUBMQPy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 11:15:54 -0500
Date: Fri, 13 Feb 2004 17:12:48 +0100
From: Jan Kara <jack@suse.cz>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] Journalled quota (fwd)
Message-ID: <20040213161248.GD1973@atrey.karlin.mff.cuni.cz>
References: <20040212111128.GA32552@atrey.karlin.mff.cuni.cz> <20040212180659.7d5bcb07.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040212180659.7d5bcb07.akpm@osdl.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hello,

  thank you for a reply.

> Jan Kara <jack@suse.cz> wrote:
> >
> >   Here comes journalled quota patch for 2.6.3-rc2.
> 
> Could you please document the locking rules?  For example, functions such
> as DQUOT_FREE_SPACE_NODIRTY() (and all similar) should have a little
> comment above them describing the caller's locking responsibilities.
> 
> Because it looks to me like DQUOT_FREE_SPACE_NODIRTY() is supposed to be
> called under i_lock, but will call dquot_free_space(), which does
> down_read().
  DQUOT_FREE_SPACE_NODIRTY() should not need any lock - i_lock is needed
only for inode_sub_bytes() but that function gets it itself... But I'll
add some doc about locking, that is always a good idea.

> I didn't review your changes to the ext3 transaction space reservation
> constants.  Did you get them right?  Mistakes here tend to take a long time
> to show up.
  I hope so - I'll check once more and add some comments why the values
were chosen as they were...

> In ext3_orphan_cleanup():
> 
>   - Local variable `i' is unused if !CONFIG_QUOTA and will generate a
>     compiler warning.
  Will fix.

>   - This
> 
> 	for (i=0; i < MAXQUOTAS; i++)
> 
>     introduces coding style inconsistency.  Please do
> 
> 	for (i = 0; i < MAXQUOTAS; i++)
>
>   - Please edit in an 80-column xterm.  Changes you have made to this
>     filesystem are quite infuriating to those who _do_ use 80-cols and need
>     to be cleaned up.
  OK, will fix both.
 
>   - This
> 
> 	for (i=0; i < MAXQUOTAS; i++)
> 		if (EXT3_SB(sb)->s_qf_names[i]) {
> 			int ret = ext3_quota_on_mount(sb, i);
> 
>     introduces coding style inconsistency.  Please do
> 
> 	for (i=0; i < MAXQUOTAS; i++) {
> 		if (EXT3_SB(sb)->s_qf_names[i]) {
> 			int ret = ext3_quota_on_mount(sb, i);
> 
>     (several places)
  I guess there should be 'i = 0'...

> Please document writes_to_blocks()
  OK, will do.

> The locking in v2_commit_dquot() looks fishy.
> 
> The locking in dquot_mark_dquot_dirty() and in mark_info_dirty() also look
> fishy.  For example:
> 
> 	void mark_info_dirty(struct super_block *sb, int type)
> 	{
> 		spin_lock(&dq_data_lock);
> 		set_bit(DQF_INFO_DIRTY_B, &sb_dqopt(sb)->info[type].dqi_flags);
> 		spin_unlock(&dq_data_lock);
> 	}
> 
> what is the spinlock doing there?
  I think there used to be some non-atomic stuff (like |= ) which was
later replaced by set_bit()... I'll fix that.

> I'm not really in a position to review the deadlockiness of this code
> without some sort of documentation of the lock ranking (including where
> journal_start() sits in that ranking).  Is that something you could add?
  I'll improve the docs, fix the problems you mentioned and resend.

					Thanks one more for comments
								Honza
-- 
Jan Kara <jack@suse.cz>
SuSE CR Labs
