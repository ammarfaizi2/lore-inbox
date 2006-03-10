Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750850AbWCJMb4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750850AbWCJMb4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 07:31:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750843AbWCJMb4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 07:31:56 -0500
Received: from ns2.suse.de ([195.135.220.15]:1767 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750837AbWCJMbz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 07:31:55 -0500
Date: Fri, 10 Mar 2006 13:31:53 +0100
From: Jan Blunck <jblunck@suse.de>
To: Neil Brown <neilb@suse.de>
Cc: Kirill Korotaev <dev@openvz.org>, akpm@osdl.org, viro@zeniv.linux.org.uk,
       olh@suse.de, bsingharora@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix shrink_dcache_parent() against shrink_dcache_memory() race (3rd updated patch)]
Message-ID: <20060310123153.GN4243@hasse.suse.de>
References: <20060309165833.GK4243@hasse.suse.de> <441060D2.6090800@openvz.org> <17425.2594.967505.22336@cse.unsw.edu.au> <441138B7.9060809@sw.ru> <20060310105950.GL4243@hasse.suse.de> <17425.26668.678359.918399@cse.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <17425.26668.678359.918399@cse.unsw.edu.au>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 10, Neil Brown wrote:

> -static void prune_dcache(int count)
> +static void prune_dcache(int count, struct super_block *sb)
>  {
>  	spin_lock(&dcache_lock);
>  	for (; count ; count--) {
> @@ -417,8 +425,10 @@ static void prune_dcache(int count)
>   			spin_unlock(&dentry->d_lock);
>  			continue;
>  		}
> -		/* If the dentry was recently referenced, don't free it. */
> -		if (dentry->d_flags & DCACHE_REFERENCED) {
> +		/* If the dentry was recently referenced, or is for
> +		 * a unmounting filesystem, don't free it. */
> +		if ((dentry->d_flags & DCACHE_REFERENCED) ||
> +		    (dentry->d_sb != sb && dentry->d_sb->s_root == NULL)) {
>  			dentry->d_flags &= ~DCACHE_REFERENCED;
>   			list_add(&dentry->d_lru, &dentry_unused);
>   			dentry_stat.nr_unused++;

You have to down_read the rw-semaphore sb->s_umount since sb->s_root is
protected by it :(

Regards,
	Jan

-- 
Jan Blunck                                               jblunck@suse.de
SuSE LINUX AG - A Novell company
Maxfeldstr. 5                                          +49-911-74053-608
D-90409 Nürnberg                                      http://www.suse.de
