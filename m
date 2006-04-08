Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965002AbWDHDGM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965002AbWDHDGM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 23:06:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965003AbWDHDGM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 23:06:12 -0400
Received: from ns1.suse.de ([195.135.220.2]:38571 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S965002AbWDHDGL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 23:06:11 -0400
Date: Sat, 8 Apr 2006 05:06:10 +0200
From: Nick Piggin <npiggin@suse.de>
To: Arnd Bergmann <arnd.bergmann@de.ibm.com>
Cc: Nick Piggin <npiggin@suse.de>, cbe-oss-dev@ozlabs.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] inotify: check for NULL inode in inotify_d_instantiate
Message-ID: <20060408030610.GC20724@wotan.suse.de>
References: <200604071808.41953.arnd.bergmann@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200604071808.41953.arnd.bergmann@de.ibm.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 07, 2006 at 06:08:41PM +0200, Arnd Bergmann wrote:
> The spufs file system creates files in a directory before instantiating
> the directory itself, which causes a NULL pointer access in
> inotify_d_instantiate since c32ccd87bfd1414b0aabfcd8dbc7539ad23bcbaa.
> 
> I'd like to keep this behavior since it means that the user
> will not have access to files in the directory before I know
> that I succeed in creating everything in it. This patch adds
> a simple check for the inode to keep that working.
> 

If this were not the correct thing to do, it is not the
business of c32ccd87bfd1414b0aabfcd8dbc7539ad23bcbaa to
prevent it. Thanks.

Acked-by: Nick Piggin <npiggin@suse.de>


> Cc: Nick Piggin <npiggin@suse.de>
> Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>
> ---
> 
> diff --git a/fs/inotify.c b/fs/inotify.c
> index 367c487..1f50302 100644
> --- a/fs/inotify.c
> +++ b/fs/inotify.c
> @@ -538,7 +538,7 @@ void inotify_d_instantiate(struct dentry
>  	WARN_ON(entry->d_flags & DCACHE_INOTIFY_PARENT_WATCHED);
>  	spin_lock(&entry->d_lock);
>  	parent = entry->d_parent;
> -	if (inotify_inode_watched(parent->d_inode))
> +	if (parent->d_inode && inotify_inode_watched(parent->d_inode))
>  		entry->d_flags |= DCACHE_INOTIFY_PARENT_WATCHED;
>  	spin_unlock(&entry->d_lock);
>  }
