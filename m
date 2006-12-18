Return-Path: <linux-kernel-owner+w=401wt.eu-S1754570AbWLRUqm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754570AbWLRUqm (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 15:46:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754497AbWLRUqm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 15:46:42 -0500
Received: from e33.co.us.ibm.com ([32.97.110.151]:40615 "EHLO
	e33.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754570AbWLRUql (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 15:46:41 -0500
Subject: Re: [Patch] BUG in fs/jfs/jfs_xtree.c
From: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
To: Eric Sesterhenn <snakebyte@gmx.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1166467889.32321.4.camel@alice>
References: <1166467889.32321.4.camel@alice>
Content-Type: text/plain
Date: Mon, 18 Dec 2006 14:46:36 -0600
Message-Id: <1166474796.28381.3.camel@kleikamp.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-12-18 at 19:51 +0100, Eric Sesterhenn wrote:
> hi,
> 
> while playing around with fsfuzzer, i got the following oops with jfs:
> 
> [  851.804875] BUG at fs/jfs/jfs_xtree.c:760 assert(!BT_STACK_FULL(btstack))

... 

> On a damaged filesystem we might have a full stack and should
> not progress further, and return instead of calling BUG()
> 
> Signed-off-by: Eric Sesterhenn
> 
> --- linux-2.6.19/fs/jfs/jfs_xtree.c.orig	2006-12-18 14:37:07.000000000 +0100
> +++ linux-2.6.19/fs/jfs/jfs_xtree.c	2006-12-18 14:37:55.000000000 +0100
> @@ -757,6 +757,8 @@ static int xtSearch(struct inode *ip, s6
>  			nsplit = 0;
>  
>  		/* push (bn, index) of the parent page/entry */
> +		if (BT_STACK_FULL(btstack))
> +			return -EINVAL;
>  		BT_PUSH(btstack, bn, index);
>  
>  		/* get the child page block number */
> 

I typically return -EIO for metadata-corruption problems.  I also want
to look at the other places in jfs_xtree.c that call BT_PUSH.  I'm on
vacation today, so I'll take a closer look at this tomorrow and push it
upstream.

Thanks!
Shaggy
-- 
David Kleikamp
IBM Linux Technology Center

