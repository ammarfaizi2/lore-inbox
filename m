Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265521AbUFUAwn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265521AbUFUAwn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jun 2004 20:52:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265545AbUFUAwn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jun 2004 20:52:43 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:169 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265521AbUFUAwh convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jun 2004 20:52:37 -0400
Date: Sun, 20 Jun 2004 21:45:35 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Chris Caputo <ccaputo@alt.net>, linux-kernel@vger.kernel.org,
       David Woodhouse <dwmw2@infradead.org>, riel@redhat.com
Subject: Re: inode_unused list corruption in 2.4.26 - spin_lock problem?
Message-ID: <20040621004535.GA8071@logos.cnet>
References: <Pine.LNX.4.44.0406181730370.1847-100000@nacho.alt.net> <20040620001529.GA4326@logos.cnet> <1087702435.5361.64.camel@lade.trondhjem.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <1087702435.5361.64.camel@lade.trondhjem.org>
User-Agent: Mutt/1.5.5.1i
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 19, 2004 at 11:33:55PM -0400, Trond Myklebust wrote:
> På lau , 19/06/2004 klokka 20:15, skreiv Marcelo Tosatti:
> 
> > The changes between 2.4.25->2.4.26 (which introduce __refile_inode() and 
> > the unused_pagecache list) must have something to do with this. 
> 
> Here's one question:
> 
> Given the fact that in iput(), the inode remains hashed and the
> inode->i_state does not change until after we've dropped the inode_lock,
> called write_inode_now(), and then retaken the inode_lock, exactly what
> is preventing a third party task from grabbing that inode?
> 
> (Better still: write_inode_now() itself actually calls __iget(), which
> could cause that inode to be plonked right back onto the "inode_in_use"
> list if ever refile_inode() gets called.)

Lets see if I get this right, while we drop the lock in iput to call 
write_inode_now() an iget happens, possibly from write_inode_now itself 
(sync_one->__iget) causing the inode->i_list to be added to to inode_in_use. 

But then the call returns, locks inode_lock, decreases inodes_stat.nr_unused--
and deletes the inode from the inode_in_use and adds to inode_unused. 

AFAICS its an inode with i_count==1 in the unused list, which does not
mean "list corruption", right? Am I missing something here?

If you are indeed right all 2.4.x versions contain this bug.

Thanks for helping!

> 
> So does the following patch help?
>
> +++ linux-2.4.27-pre3/fs/inode.c	2004-06-19 23:22:29.000000000 -0400
> @@ -1200,6 +1200,7 @@ void iput(struct inode *inode)
>  		struct super_block *sb = inode->i_sb;
>  		struct super_operations *op = NULL;
>  
> +again:
>  		if (inode->i_state == I_CLEAR)
>  			BUG();
>  
> @@ -1241,11 +1242,16 @@ void iput(struct inode *inode)
>  				if (!(inode->i_state & (I_DIRTY|I_LOCK))) 
>  					__refile_inode(inode);
>  				inodes_stat.nr_unused++;
> -				spin_unlock(&inode_lock);
> -				if (!sb || (sb->s_flags & MS_ACTIVE))
> +				if (!sb || (sb->s_flags & MS_ACTIVE)) {
> +					spin_unlock(&inode_lock);
>  					return;
> -				write_inode_now(inode, 1);
> -				spin_lock(&inode_lock);
> +				}
> +				if (inode->i_state & I_DIRTY) {
> +					__iget(inode);
> +					spin_unlock(&inode_lock);
> +					write_inode_now(inode, 1);
> +					goto again;
> +				}
>  				inodes_stat.nr_unused--;
>  				list_del_init(&inode->i_hash);
>  			}
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
