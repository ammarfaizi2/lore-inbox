Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263191AbUFJXA2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263191AbUFJXA2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jun 2004 19:00:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263226AbUFJXA1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jun 2004 19:00:27 -0400
Received: from mail.fh-wedel.de ([213.39.232.194]:14985 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S263191AbUFJXAV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jun 2004 19:00:21 -0400
Date: Fri, 11 Jun 2004 00:59:38 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Andrew Morton <akpm@osdl.org>
Cc: michael@metaparadigm.com, linux-kernel@vger.kernel.org, hugh@veritas.com
Subject: Re: [STACK] >3k call path in ide
Message-ID: <20040610225938.GF3340@wohnheim.fh-wedel.de>
References: <20040609122921.GG21168@wohnheim.fh-wedel.de> <40C72B68.1030404@metaparadigm.com> <20040609162949.GC29531@wohnheim.fh-wedel.de> <20040609122721.0695cf96.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040609122721.0695cf96.akpm@osdl.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 June 2004 12:27:21 -0700, Andrew Morton wrote:
> Jörn Engel <joern@wohnheim.fh-wedel.de> wrote:
> >
> >  Andrew, what do you thing about the patch below for sync_inodes_sb()?
> >  It's stack consumption is reduced from 308 to 64, at the cost of one
> >  more function call.
> 
> Like this:
> 
> --- 25/fs/fs-writeback.c~sync_inodes_sb-stack-reduction	2004-06-09 12:25:57.111389456 -0700
> +++ 25-akpm/fs/fs-writeback.c	2004-06-09 12:25:57.115388848 -0700
> @@ -433,15 +433,15 @@ restart:
>   */
>  void sync_inodes_sb(struct super_block *sb, int wait)
>  {
> -	struct page_state ps;
>  	struct writeback_control wbc = {
>  		.sync_mode	= wait ? WB_SYNC_ALL : WB_SYNC_HOLD,
>  	};
> +	unsigned long nr_dirty = read_page_state(nr_dirty);
> +	unsigned long nr_unstable = read_page_state(nr_unstable);

read_page_state doesn't exist in 2.6.7-rc3 or 2.6.6-mm5.  How is it
defined?

If it is just a simple macro to access the right fields, then the
patch looks fine to me.

> -	get_page_state(&ps);
> -	wbc.nr_to_write = ps.nr_dirty + ps.nr_unstable +
> +	wbc.nr_to_write = nr_dirty + nr_unstable +
>  			(inodes_stat.nr_inodes - inodes_stat.nr_unused) +
> -			ps.nr_dirty + ps.nr_unstable;
> +			nr_dirty + nr_unstable;
>  	wbc.nr_to_write += wbc.nr_to_write / 2;		/* Bit more for luck */
>  	spin_lock(&inode_lock);
>  	sync_sb_inodes(sb, &wbc);
> _

Jörn

-- 
Fantasy is more important than knowledge. Knowledge is limited,
while fantasy embraces the whole world.
-- Albert Einstein
