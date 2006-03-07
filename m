Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752485AbWCGMEC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752485AbWCGMEC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 07:04:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752488AbWCGMEB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 07:04:01 -0500
Received: from smtp101.mail.mud.yahoo.com ([209.191.85.211]:21624 "HELO
	smtp101.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1752486AbWCGMEB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 07:04:01 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=ZB5agXykZYSdp8l0vMXfTssSHGF8JAUJYc60vaEZdl+AkLfPLIYHwM8uE45l+t6lZQPW8q/ywTxBkWRUIcCYaFizUZeL6QszOWkMba2sqWu/1xVDULNdDIk4k3cCXhHxyA4Ha5Xljb+6s6Rgv3vhPILU/wS92jaU4dTMs7OY5v8=  ;
Message-ID: <440D76A4.8050703@yahoo.com.au>
Date: Tue, 07 Mar 2006 23:03:48 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: David Howells <dhowells@redhat.com>
CC: torvalds@osdl.org, akpm@osdl.org, steved@redhat.com,
       trond.myklebust@fys.uio.no, aviro@redhat.com,
       linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
       nfsv4@linux-nfs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/6] Optimise d_find_alias() [try #6]
References: <20060307113352.23330.80913.stgit@warthog.cambridge.redhat.com> <20060307113404.23330.71158.stgit@warthog.cambridge.redhat.com>
In-Reply-To: <20060307113404.23330.71158.stgit@warthog.cambridge.redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Howells wrote:
> The attached patch optimises d_find_alias() to only take the spinlock if
> there's anything in the the inode's alias list. If there isn't, it returns NULL
> immediately.
> 
> With respect to the superblock sharing patch, this should reduce by one the
> number of times the dcache_lock is taken by nfs_lookup() for ordinary
> directory lookups.
> 
> Only in the case where there's already a dentry for particular directory inode
> (such as might happen when another mountpoint is rooted at that dentry) will
> the lock then be taken the extra time.
> 
> Signed-Off-By: David Howells <dhowells@redhat.com>
> ---
> 
>  fs/dcache.c |   11 +++++++----
>  1 files changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/dcache.c b/fs/dcache.c
> index 97e1e44..32051ba 100644
> --- a/fs/dcache.c
> +++ b/fs/dcache.c
> @@ -325,10 +325,13 @@ static struct dentry * __d_find_alias(st
>  
>  struct dentry * d_find_alias(struct inode *inode)
>  {
> -	struct dentry *de;
> -	spin_lock(&dcache_lock);
> -	de = __d_find_alias(inode, 0);
> -	spin_unlock(&dcache_lock);
> +	struct dentry *de = NULL;
> +	smp_rmb();

Having the smp_rmb() here implies there is some sort of memory barrier
based synchronisation protocol at a higher level (than this function),
because you don't actually do anything before them smp_rmb() here.

So can you comment what that is?

> +	if (!list_empty(&inode->i_dentry)) {
> +		spin_lock(&dcache_lock);
> +		de = __d_find_alias(inode, 0);
> +		spin_unlock(&dcache_lock);
> +	}
>  	return de;
>  }
>  

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
