Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261161AbVDDJEU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261161AbVDDJEU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 05:04:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261163AbVDDJEU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 05:04:20 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:25801 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261161AbVDDJEP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 05:04:15 -0400
Date: Mon, 4 Apr 2005 11:04:14 +0200
From: Jan Kara <jack@suse.cz>
To: linux-kernel@vger.kernel.org
Cc: sct@redhat.com, jeffm@suse.com
Subject: Problem in log_do_checkpoint()?
Message-ID: <20050404090414.GB20219@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hello,

  I've been looking through the JBD code when trying to understand the
assertion failure in log_do_checkpoint() (it was on old SUSE 2.6.5 kernel
though the reporter claims to be able to get the failure even with the
Stephen's patch fixing a race with journal_put_journal_head()) and I've
spotted one place where I think could be a race (the code around there
seems to be the same in latest kernels):
  In log_do_checkpoint() we go through the t_checkpoint_list of a
transaction and call __flush_buffer() on each buffer. Suppose there is
just one buffer on the list and it is dirty. __flush_buffer() sees it and
puts it to an array of buffers for flushing. Then the loop finishes,
retry=0, drop_count=0, batch_count=1. So __flush_batch() is called - we
drop all locks and sleep. While we are sleeping somebody else comes and
makes the buffer dirty again (OK, that is not probable, but I think it
could be possible). Now we wake up and call __cleanup_transaction().
It's not able to do anything and returns 0. And we fail on the assertion
J_ASSERT(drop_count != 0 || cleanup_ret != 0).
  Am I missing something? In my opinion we should set retry=1 after we
call __flush_batch() even if we call it outside of the "__flush_buffer-loop"...

								Honza

-- 
Jan Kara <jack@suse.cz>
SuSE CR Labs
