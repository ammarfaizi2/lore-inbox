Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262949AbUBZTJy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 14:09:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262951AbUBZTJx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 14:09:53 -0500
Received: from fw.osdl.org ([65.172.181.6]:54666 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262949AbUBZTJr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 14:09:47 -0500
Subject: Re: [PATCH] sync_sb_inodes sync hang
From: Daniel McNeil <daniel@osdl.org>
To: Hugh Dickins <hugh@veritas.com>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0402241636160.1681-100000@localhost.localdomain>
References: <Pine.LNX.4.44.0402241636160.1681-100000@localhost.localdomain>
Content-Type: text/plain
Organization: 
Message-Id: <1077822584.1956.285.camel@ibm-c.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 26 Feb 2004 11:09:44 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh,

I tried the while loop below on a UP without PREEMPT and it has
not hung running 2.6.3-mm3 without your patch.

How long does it take to hang?
Which file system?

Thanks,
Daniel

On Tue, 2004-02-24 at 08:52, Hugh Dickins wrote:
> 2.6.3-mm UP without PREEMPT easily hangs looping around pdflush's
> sync_sb_inodes, failing the down_read_trylock in do_writepages,
> but giving the concurrent sync no chance to complete: just try
> while : ; do echo $SECONDS; sync; cp /etc/termcap .; done
> 
> I think sync_sb_inodes is the only loop vulnerable to that
> change in do_writepages, so site the cond_resched() here.
> 
> Hugh
> 
> --- 2.6.3-mm3/fs/fs-writeback.c	2004-02-23 12:51:49.000000000 +0000
> +++ linux/fs/fs-writeback.c	2004-02-24 16:14:49.000000000 +0000
> @@ -326,6 +326,7 @@ sync_sb_inodes(struct super_block *sb, s
>  			writeback_release(bdi);
>  		spin_unlock(&inode_lock);
>  		iput(inode);
> +		cond_resched();
>  		spin_lock(&inode_lock);
>  		if (wbc->nr_to_write <= 0)
>  			break;
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

