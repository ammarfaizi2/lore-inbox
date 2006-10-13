Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751293AbWJMPnV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751293AbWJMPnV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 11:43:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751315AbWJMPnV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 11:43:21 -0400
Received: from sbexim0.cs.sunysb.edu ([130.245.1.149]:46990 "EHLO
	sbexim0.cs.sunysb.edu") by vger.kernel.org with ESMTP
	id S1751293AbWJMPnU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 11:43:20 -0400
Date: Fri, 13 Oct 2006 11:43:00 -0400
Message-Id: <200610131543.k9DFh05m016578@agora.fsl.cs.sunysb.edu>
From: Erez Zadok <ezk@cs.sunysb.edu>
To: Pekka J Enberg <penberg@cs.helsinki.fi>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       jsipek@cs.sunysb.edu, ezk@cs.sunysb.edu, mhalcrow@us.ibm.com,
       phillip@hellewell.homeip.net
Subject: Re: [RFC/PATCH 1/2] stackfs: generic functions for obtaining hidden object 
In-reply-to: Your message of "Fri, 13 Oct 2006 16:22:09 +0300."
             <Pine.LNX.4.64.0610131615370.563@sbz-30.cs.Helsinki.FI> 
X-MailKey: Erez_Zadok
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.64.0610131615370.563@sbz-30.cs.Helsinki.FI>, Pekka J Enberg writes:
> From: Pekka Enberg <penberg@cs.helsinki.fi>
> 
> Add generic functions for obtaining the hidden object (superblock, inode,
> dentry, and dentry mount-point) in a stacked filesystem.  As fan-out 
> stacked filesystems have multiple hidden objects, we store them in a 
> statically allocated array of pointers.  The current hard-coded limit 
> STACKFS_MAX_BRANCHES is not enough for unionfs (for which users have more 
> than 100 branches).  That, however, can be fixed later for unionfs.

I think we should do it right the first time (i.e., now :-)

> +#define STACKFS_MAX_BRANCHES (8)

> +struct stackfs_sb_info {
> +	struct super_block *hidden_sbs[STACKFS_MAX_BRANCHES];
> +};

Why not make it something more dynamic, such as a mount-time option per sb?
Even at 8, you waste most of that space for non-fan-out stackable file
systems such as ecryptfs; and those unionfs users who want more, will have
to _recompile_ the code.

And given that this code is shared, if just one f/s needs 100 branches, why
should ecryptfs waste 99*sizeof(pointer) bytes for every *_info structure?

> +static inline struct super_block *
> +__stackfs_hidden_sb(struct super_block *sb, unsigned long branch_idx)
> +{
> +	struct stackfs_sb_info *info = sb->s_fs_info;
> +	return info->hidden_sbs[branch_idx];
> +}

Also, the functions don't check array bounds.  Where, if at all, this gets
checked against the STACKFS_MAX_BRANCHES value?  Shouldn't we at least put
some ASSERT's in there to catch bugs?

Of course, I realize that the above code is rather simple now and changing
it as I propose will require kmalloc/kfree (or containers) carefully used
throughout.

Thanks,
Erez.
