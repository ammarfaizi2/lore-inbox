Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750823AbWERI0L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750823AbWERI0L (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 04:26:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750854AbWERI0L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 04:26:11 -0400
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:54234 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP
	id S1750823AbWERI0J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 04:26:09 -0400
Message-ID: <446C2F89.5020300@bull.net>
Date: Thu, 18 May 2006 10:25:45 +0200
From: Zoltan Menyhart <Zoltan.Menyhart@bull.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en, fr, hu
MIME-Version: 1.0
To: jack@suse.cz, sct@redhat.com, linux-kernel@vger.kernel.org
Subject: re: [PATCH] Change ll_rw_block() calls in JBD
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 18/05/2006 10:29:03,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 18/05/2006 10:29:13,
	Serialize complete at 18/05/2006 10:29:13
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> We must be sure that the current data in buffer are sent to disk.
> Hence we have to call ll_rw_block() with SWRITE.

Let's consider the following case:

	while (commit_transaction->t_sync_datalist) {
		...

		// Assume a "bh" got locked before starting this loop

		if (buffer_locked(bh)) {
			...
			__journal_temp_unlink_buffer(jh);
			__journal_file_buffer(jh, commit_transaction, BJ_Locked);
		} else ...
	}
	...
	while (commit_transaction->t_locked_list) {
		...

		// Assume our "bh" is not locked any more
		// Nothing has happened to this "bh", someone just wanted
		// to look at it in a safe way

		if (buffer_jbd(bh) && jh->b_jlist == BJ_Locked) {
			__journal_unfile_buffer(jh);
			jbd_unlock_bh_state(bh);
			journal_remove_journal_head(bh);
			put_bh(bh);
		} else ...
	}

I.e. having an already locked "bh", it is missed out from the log.

Regards,

Zoltan Menyhart

