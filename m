Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262555AbVGFVnG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262555AbVGFVnG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 17:43:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262546AbVGFVnC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 17:43:02 -0400
Received: from smtp.osdl.org ([65.172.181.4]:15059 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261272AbVGFVkX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 17:40:23 -0400
Date: Wed, 6 Jul 2005 14:41:14 -0700
From: Andrew Morton <akpm@osdl.org>
To: Nick Wilson <njw@osdl.org>
Cc: trond.myklebust@fys.uio.no, linux-kernel@vger.kernel.org,
       nfs@lists.sourceforge.net
Subject: Re: [PATCH] NFS: fix client hang due to race condition
Message-Id: <20050706144114.37bd05be.akpm@osdl.org>
In-Reply-To: <20050706212744.GC20698@njw.pdx.osdl.net>
References: <20050706212744.GC20698@njw.pdx.osdl.net>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Wilson <njw@osdl.org> wrote:
>
> The flags field in struct nfs_inode is protected by the BKL. This patch
> fixes a couple places where the lock is not obtained before changing the
> flags.
> 

Yeah, nasty.  Well caught.

>  		}
>  		invalidate_inode_pages2(mapping);
> +		lock_kernel();
>  		nfsi->flags &= ~NFS_INO_INVALID_DATA;
> +		unlock_kernel();

Adding new lock_kernel()s is a bit retro.  We might want to use a per-inode
lock for this, or set_bit/clear_bit and friends.

If we choose to use a per-inode lock then it is legal to use inode.i_lock
(coz I said) as long as no locks are nested inside it.  i_lock's mandate is
"a general-purpose innermost per-inode lock".
