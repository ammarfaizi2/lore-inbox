Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263015AbVHENmp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263015AbVHENmp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 09:42:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263019AbVHENmp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 09:42:45 -0400
Received: from adsl-266.mirage.euroweb.hu ([193.226.239.10]:2054 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S263015AbVHENmn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 09:42:43 -0400
To: vvs@sw.ru
CC: dedekind@infradead.org, hch@lst.de, linux-kernel@vger.kernel.org
In-reply-to: <42F36AA2.7030807@sw.ru> (message from Vasily Averin on Fri, 05
	Aug 2005 17:33:22 +0400)
Subject: Re: [PATCH] bugfix: two read_inode() calls without clear_inode()
 call between
References: <42F36AA2.7030807@sw.ru>
Message-Id: <E1E12Si-0003An-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 05 Aug 2005 15:42:12 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Could you please explain me, why we need to wake up somebody right 
> before freeing an inode? It seems for me, if somebody really wait on 
> this inode, then they have a good chance to access already freed memory.

find_inode() needs to be woken up (__wait_on_freeing_inode) when an
inode being freed is actually taken off the hash list .  And it's
careful not to touch it after being woken up.

Miklos

> diff --git a/fs/inode.c b/fs/inode.c
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -282,6 +282,13 @@ static void dispose_list(struct list_hea
>   		if (inode->i_data.nrpages)
>   			truncate_inode_pages(&inode->i_data, 0);
>   		clear_inode(inode);
> +
> +		spin_lock(&inode_lock);
> +		hlist_del_init(&inode->i_hash);
> +		list_del_init(&inode->i_sb_list);
> +		spin_unlock(&inode_lock);
> +
> +		wake_up_inode(inode);
>                  ^^^^^^^^^^^^^^^^^^^^
>   		destroy_inode(inode);
>   		nr_disposed++;
>   	}
