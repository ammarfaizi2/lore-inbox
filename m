Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267918AbUIVGDc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267918AbUIVGDc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Sep 2004 02:03:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267921AbUIVGDc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Sep 2004 02:03:32 -0400
Received: from fw.osdl.org ([65.172.181.6]:42671 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267918AbUIVGDa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Sep 2004 02:03:30 -0400
Date: Tue, 21 Sep 2004 23:01:24 -0700
From: Andrew Morton <akpm@osdl.org>
To: Mingming Cao <cmm@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Patch] ext3_new_inode() failure case fix
Message-Id: <20040921230124.368e469c.akpm@osdl.org>
In-Reply-To: <1095815041.1637.32926.camel@w-ming2.beaverton.ibm.com>
References: <200409071302.i87D2Dus030892@sisko.scot.redhat.com>
	<1095815041.1637.32926.camel@w-ming2.beaverton.ibm.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mingming Cao <cmm@us.ibm.com> wrote:
>
> While I am studying ext3_new_inode() failure code paths, I found the
> inode->i_nlink is not cleared to 0 in the first failure path. But it is
> cleared to 0 in the second failure path(fail to allocate disk quota). I
> think it should be cleared in both cases, because later when
> generic_drop_inode() is called by iput(), i_nlink is checked to decide
> whether to call generic_delete_inode(). Currently it is calling
> generic_forget_inode().
> 
> Also the reference to the inode bitmap buffer head should be dropped on
> the failure path too.

That reference already is dropped:

> --- linux-2.6.9-rc1-mm5/fs/ext3/ialloc.c~ext3_new_inode_failure_case_fix	2004-09-22 00:18:18.196012520 -0700
> +++ linux-2.6.9-rc1-mm5-ming/fs/ext3/ialloc.c	2004-09-22 00:19:20.063607216 -0700
> @@ -622,7 +622,9 @@ got:
>  fail:
>  	ext3_std_error(sb, err);
>  out:
> +	inode->i_nlink = 0;
>  	iput(inode);
> +	brelse(bitmap_bh);
>  	ret = ERR_PTR(err);
>  really_out:
>  	brelse(bitmap_bh);

        ^ here

So I'll drop that part of the patch.
