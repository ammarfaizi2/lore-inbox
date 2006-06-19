Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751145AbWFSCEc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751145AbWFSCEc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jun 2006 22:04:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750959AbWFSCEc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jun 2006 22:04:32 -0400
Received: from smtp.osdl.org ([65.172.181.4]:2953 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750839AbWFSCEb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jun 2006 22:04:31 -0400
Date: Sun, 18 Jun 2006 19:04:22 -0700
From: Andrew Morton <akpm@osdl.org>
To: Neil Brown <neilb@suse.de>
Cc: dgc@sgi.com, jblunck@suse.de, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
       balbir@in.ibm.com
Subject: Re: [patch 0/5] [PATCH,RFC] vfs: per-superblock unused dentries
 list (2nd version)
Message-Id: <20060618190422.5daf17fe.akpm@osdl.org>
In-Reply-To: <17557.64512.496195.714144@cse.unsw.edu.au>
References: <20060601095125.773684000@hasse.suse.de>
	<17539.35118.103025.716435@cse.unsw.edu.au>
	<20060616155120.GA6824@hasse.suse.de>
	<17555.12234.347353.670918@cse.unsw.edu.au>
	<20060618235654.GB2114946@melbourne.sgi.com>
	<17557.61307.364404.640539@cse.unsw.edu.au>
	<20060619010013.GC2114946@melbourne.sgi.com>
	<17557.64512.496195.714144@cse.unsw.edu.au>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Jun 2006 11:21:04 +1000
Neil Brown <neilb@suse.de> wrote:

> static void prune_dcache(int count, struct super_block *sb)
> +static void prune_dcache(int count, struct list_head *list)
>  {
> +	int have_list = list != NULL;
> +	struct list_head alt_head;
>  	spin_lock(&dcache_lock);
> +	if (list == NULL) {
> +		/* use the dentry_unused list */
> +		list_add(&alt_head, &dentry_unused);
> +		list_del_init(&dentry_unused);
> +		list = &alt_head;
> +	}

This will make dentry_unused appear to be empty.

>  	for (; count ; count--) {
>  		struct dentry *dentry;
>  		struct list_head *tmp;
> @@ -405,23 +417,11 @@ static void prune_dcache(int count, stru
>  
>  		cond_resched_lock(&dcache_lock);

And then it makes that apparent-emptiness globally visible.

Won't this cause concurrent unmounting or memory shrinking to malfunction?
