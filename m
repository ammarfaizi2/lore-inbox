Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264608AbTFKXg5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 19:36:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264610AbTFKXg5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 19:36:57 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:57610 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S264608AbTFKXg4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 19:36:56 -0400
Date: Wed, 11 Jun 2003 16:50:03 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
cc: Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] First casuality of hlist poisoning in 2.5.70
In-Reply-To: <16103.48257.400430.785367@charged.uio.no>
Message-ID: <Pine.LNX.4.44.0306111640590.28014-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 11 Jun 2003, Trond Myklebust wrote:
> 
>   This patch removes the Oops that occurs when either the source or
> the target of a d_move() operation is unhashed. It is currently
> triggered by the NFS sillyrename code.

Cool. The thing found something!

However, I'm still a bit confused:

> -		hlist_del_rcu(&dentry->d_hash);
> -		hlist_add_head_rcu(&dentry->d_hash, target->d_bucket);
> +		if (!hlist_unhashed(&dentry->d_hash))
> +			hlist_del_rcu(&dentry->d_hash);
> +		if (!hlist_unhashed(&target->d_hash)) {
> +			hlist_add_head_rcu(&dentry->d_hash, target->d_bucket);
> +			dentry->d_vfs_flags &= ~DCACHE_UNHASHED;
> +		} else
> +			dentry->d_vfs_flags |= DCACHE_UNHASHED;

Can source or target really be validly unhashed? That makes no sense,
since we just looked it up, and we've held the directory semaphores over
the whole thing.

In other words, I worry that the real bug is something else, and your 
patch makes it not oops, but hides the real problem.

I'm sure you're right, but can you tell me what the sequence of events is 
that validly leads to this?

		Linus

