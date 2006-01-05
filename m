Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751096AbWAEB04@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751096AbWAEB04 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 20:26:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751124AbWAEB04
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 20:26:56 -0500
Received: from pat.uio.no ([129.240.130.16]:51132 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1751096AbWAEB0z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 20:26:55 -0500
Subject: Re: d_instantiate_unique / NFS inode leakage?
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Oleg Drokin <green@linuxhacker.ru>
Cc: linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk
In-Reply-To: <20060105010047.GJ5743@linuxhacker.ru>
References: <20060105010047.GJ5743@linuxhacker.ru>
Content-Type: text/plain
Date: Thu, 05 Jan 2006 02:26:47 +0100
Message-Id: <1136424407.7847.37.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.757, required 12,
	autolearn=disabled, AWL 1.19, FORGED_RCVD_HELO 0.05,
	UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-01-05 at 03:00 +0200, Oleg Drokin wrote:
> Hello!
> 
>    Searching for inode leakage in NFS code (seen in 2.6.14 and 2.6.15 at least,
>    have not tried earlier versions), I see suspicious place in
>    d_instantiate_unique (the only user happens to be NFS).
>    There if we have found aliased dentry that we return, inode reference is
>    not dropped and inode is not attached anywhere, so it seems the reference
>    to inode is leaked in that case.
>    This simple patch below fixes the problem. Unfortunatelly the leakage seems
>    to be non-100% in my testing, so I will continue the testing to see
>    if I still see inodes to leak or not (no leak seen so far with the patch).
> 
> --- fs/dcache.c.orig	2006-01-05 02:28:57.000000000 +0200
> +++ fs/dcache.c	2006-01-05 02:32:08.000000000 +0200
> @@ -838,6 +838,7 @@ struct dentry *d_instantiate_unique(stru
>  		dget_locked(alias);
>  		spin_unlock(&dcache_lock);
>  		BUG_ON(!d_unhashed(alias));
> +		iput(inode);
>  		return alias;
>  	}
>  	list_add(&entry->d_alias, &inode->i_dentry);

Yep, that looks like it ought to be the correct behaviour. Could you
please also add a note to this effect in the DocBook header for
d_instantiate_unique?

Cheers,
  Trond

