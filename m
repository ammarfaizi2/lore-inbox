Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751107AbWE2CY1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751107AbWE2CY1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 May 2006 22:24:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751106AbWE2CY1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 May 2006 22:24:27 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:60306 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751102AbWE2CY0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 May 2006 22:24:26 -0400
Date: Mon, 29 May 2006 12:24:01 +1000
From: David Chinner <dgc@sgi.com>
To: Jan Blunck <jblunck@suse.de>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       viro@zeniv.linux.org.uk, dgc@sgi.com
Subject: Re: [patch 4/5] vfs: per superblock dentry stats
Message-ID: <20060529022401.GT8069029@melbourne.sgi.com>
References: <20060526110655.197949000@suse.de>> <20060526110802.852609000@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060526110802.852609000@suse.de>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 26, 2006 at 01:06:59PM +0200, Jan Blunck wrote:
> Index: work-2.6/fs/super.c
> ===================================================================
> --- work-2.6.orig/fs/super.c
> +++ work-2.6/fs/super.c
> @@ -71,6 +71,9 @@ static struct super_block *alloc_super(v
>  		INIT_LIST_HEAD(&s->s_instances);
>  		INIT_HLIST_HEAD(&s->s_anon);
>  		INIT_LIST_HEAD(&s->s_inodes);
> +		s->s_dentry_stat.nr_dentry = 0;
> +		s->s_dentry_stat.nr_unused = 0;

No need for these as the superblock is memset to zero....

> -struct dentry_stat_t {
> +struct dentry_stat {
>  	int nr_dentry;
>  	int nr_unused;
> -	int age_limit;          /* age in seconds */
> -	int want_pages;         /* pages requested by system */
> -	int dummy[2];
> +	int age_limit;		/* age in seconds */
>  };

that changes the size of the structure from 6*sizeof(int) to
3*sizeof(int)....

> -extern struct dentry_stat_t dentry_stat;
> +extern struct dentry_stat global_dentry_stat;
> +
> +#define dentry_stat_inc(sb, x)		\
> +do {					\
> +	global_dentry_stat.x++;		\
> +	if (sb)				\
> +		(sb)->s_dentry_stat.x++;\
> +} while(0)
> +
> +#define dentry_stat_dec(sb, x)		\
> +do {					\
> +	global_dentry_stat.x--;		\
> +	if (sb)				\
> +		(sb)->s_dentry_stat.x--;\
> +} while(0)

	if (likely(sb))  ???

> Index: work-2.6/kernel/sysctl.c
> ===================================================================
> --- work-2.6.orig/kernel/sysctl.c
> +++ work-2.6/kernel/sysctl.c
> @@ -958,7 +958,7 @@ static ctl_table fs_table[] = {
>  	{
>  		.ctl_name	= FS_DENTRY,
>  		.procname	= "dentry-state",
> -		.data		= &dentry_stat,
> +		.data		= &global_dentry_stat,
>  		.maxlen		= 6*sizeof(int),

With the above change, maxlen = 3*sizeof(int).

Given that's a userspace visible change, should the above structure
change use a "int dummy[3];" to keep the global structure and userspace
export the same?

Cheers,

Dave.
-- 
Dave Chinner
R&D Software Enginner
SGI Australian Software Group
