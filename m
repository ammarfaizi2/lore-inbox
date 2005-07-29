Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262667AbVG2RJk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262667AbVG2RJk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 13:09:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262662AbVG2RJg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 13:09:36 -0400
Received: from moraine.clusterfs.com ([66.96.26.190]:49285 "EHLO
	moraine.clusterfs.com") by vger.kernel.org with ESMTP
	id S262667AbVG2RGo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 13:06:44 -0400
Date: Fri, 29 Jul 2005 11:06:41 -0600
From: Andreas Dilger <adilger@clusterfs.com>
To: Takashi Sato <sho@bsd.tnes.nec.co.jp>
Cc: ext2-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [Ext2-devel] OOM problems still left in 2.6.13-rc3
Message-ID: <20050729170641.GH6126@schatzie.adilger.int>
Mail-Followup-To: Takashi Sato <sho@bsd.tnes.nec.co.jp>,
	ext2-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <018101c5943a$1a07a5d0$4168010a@bsd.tnes.nec.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <018101c5943a$1a07a5d0$4168010a@bsd.tnes.nec.co.jp>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jul 29, 2005  21:36 +0900, Takashi Sato wrote:
> The buffers connected to t_sync_datalist can't simply be removed like
> the buffers connected to t_locked_list, since we don't know if the
> I/O against the buffers are complete.
> 
> So we should wait until the committing transaction becomes complete
> if there are any buffers connected to the transaction's
> t_sync_datalist.
> 
> b) If journal_unmap_buffer() returns -1 on journal_invalidatepages(),
>   call log_wait_commit() to wait for the completion of the
>   transaction, and retry to call journal_unmap_buffer() again.
>
> @@ -1899,8 +1896,19 @@ int journal_invalidatepage(journal_t *jo
> 
>   if (offset <= curr_off) {
>     /* This block is wholly outside the truncation point */
> +retry:
>    lock_buffer(bh);
> -   may_free &= journal_unmap_buffer(journal, bh);
> +   ret = journal_unmap_buffer(journal, bh, &wait_tid);
> +   /* When this buffer is in transaction of
> +    * t_sync_datalist, truncate must wait for
> +    * that transaction.
> +    */
> +   if (ret < 0) {
> +    unlock_buffer(bh);
> +    log_wait_commit(journal, wait_tid);
> +    goto retry;
> +   }
> +   may_free &= ret;

What kind of effect does this have on filesystem performance?
This would apparently make truncate be synchronous with journal commit due to
truncate_{partial,complete}_page->do_invalidatepage->journal_invalidatepage().

Cheers, Andreas
--
Andreas Dilger
Principal Software Engineer
Cluster File Systems, Inc.

