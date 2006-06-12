Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932075AbWFLTLJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932075AbWFLTLJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 15:11:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752195AbWFLTLI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 15:11:08 -0400
Received: from gold.veritas.com ([143.127.12.110]:3901 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S1752191AbWFLTLG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 15:11:06 -0400
X-IronPort-AV: i="4.05,229,1146466800"; 
   d="scan'208"; a="60524479:sNHT30518720"
Date: Mon, 12 Jun 2006 20:10:47 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@blonde.wat.veritas.com
To: Sergey Vlasov <vsu@altlinux.ru>
cc: Al Viro <viro@zeniv.linux.org.uk>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] tmpfs: Decrement i_nlink correctly in shmem_rmdir()
In-Reply-To: <11501251772137-git-send-email-vsu@altlinux.ru>
Message-ID: <Pine.LNX.4.64.0606121957580.18760@blonde.wat.veritas.com>
References: <11501251772137-git-send-email-vsu@altlinux.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 12 Jun 2006 19:11:05.0877 (UTC) FILETIME=[F44D3C50:01C68E53]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12 June 2006, Sergey Vlasov wrote:

> shmem_rmdir() must undo the increment of i_nlink done in
> shmem_get_inode() for directories, otherwise at least
> IN_DELETE_SELF inotify event generation is broken.
> 
> Signed-off-by: Sergey Vlasov <vsu@altlinux.ru>

Thanks: that is consistent with ramfs, seems correct and does no harm.
Though I don't think it affects anything than the fsnotify_inoderemove
i_nlink test in dentry_iput.  I'm a little surprised by that test,
unqualified to say whether that's the right place and way to make an
inoderemove test; but even if it were not, I'd be silly to reject
your fix.  Thanks, I'll sign it off and send it onwards.

Hugh

> ---
>  mm/shmem.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 4c5e68e..bd7bf49 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -1780,6 +1780,7 @@ static int shmem_rmdir(struct inode *dir
>  	if (!simple_empty(dentry))
>  		return -ENOTEMPTY;
>  
> +	dentry->d_inode->i_nlink--;
>  	dir->i_nlink--;
>  	return shmem_unlink(dir, dentry);
>  }
> -- 
> 1.4.0.g1658
> 
