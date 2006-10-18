Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751443AbWJRIF3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751443AbWJRIF3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 04:05:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751439AbWJRIF2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 04:05:28 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:49132 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S1751442AbWJRIF0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 04:05:26 -0400
Date: Wed, 18 Oct 2006 10:05:47 +0200
From: Jan Kara <jack@suse.cz>
To: Suzuki K P <suzuki@in.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, vs@namesys.com,
       lkml <linux-kernel@vger.kernel.org>, Dale Mosby <k7fw@us.ibm.com>
Subject: Re: [RFC] Patch to fix reiserfs bad path release panic on 2.6.19-rc1
Message-ID: <20061018080547.GD19879@atrey.karlin.mff.cuni.cz>
References: <45357F73.9010302@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45357F73.9010302@in.ibm.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hello,

> * fix reiserfs/inode.c : restart_transaction() to release the path in all cases.
> 
> The restart_transaction() doesn't release the path when the the
> journal handle has a refcount > 1. This would trigger a
> reiserfs_panic() if we encounter an -ENOSPC / -EDQUOT in
> reiserfs_get_block(). 
  Yes, your analysis seems to be correct. I've looked at places where
restart_transaction() is called and all expect path to be released.

> Signed-off-by: Suzuki K P <suzuki@in.ibm.com>
You can add:
  Signed-off-by: Jan Kara <jack@suse.cz>

BTW: The more appropriate audience for this patch is at
reiserfs-list@namesys.com.

								Honza

> Index: linux-2.6.19-rc1/fs/reiserfs/inode.c
> ===================================================================
> --- linux-2.6.19-rc1.orig/fs/reiserfs/inode.c	2006-10-12 02:13:12.000000000 -0700
> +++ linux-2.6.19-rc1/fs/reiserfs/inode.c	2006-10-13 16:38:32.000000000 -0700
> @@ -216,11 +216,12 @@
>  	BUG_ON(!th->t_trans_id);
>  	BUG_ON(!th->t_refcount);
>  
> +	pathrelse(path);
> +
>  	/* we cannot restart while nested */
>  	if (th->t_refcount > 1) {
>  		return 0;
>  	}
> -	pathrelse(path);
>  	reiserfs_update_sd(th, inode);
>  	err = journal_end(th, s, len);
>  	if (!err) {

-- 
Jan Kara <jack@suse.cz>
SuSE CR Labs
