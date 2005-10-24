Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751283AbVJXUrS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751283AbVJXUrS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Oct 2005 16:47:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751285AbVJXUrS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Oct 2005 16:47:18 -0400
Received: from waste.org ([216.27.176.166]:15009 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S1751283AbVJXUrR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Oct 2005 16:47:17 -0400
Date: Mon, 24 Oct 2005 13:45:18 -0700
From: Matt Mackall <mpm@selenic.com>
To: Hareesh Nagarajan <hnagar2@gmail.com>
Cc: linux-kernel@vger.kernel.org, ak@suse.de
Subject: Re: [TRIVIAL] Error checks omitted in init_tmpfs() in mm/tiny-shmem.c
Message-ID: <20051024204518.GI26160@waste.org>
References: <435C7149.3010004@gmail.com> <20051024070921.GW26160@waste.org> <435CA1CF.3070204@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <435CA1CF.3070204@gmail.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 24, 2005 at 03:56:47AM -0500, Hareesh Nagarajan wrote:
> Matt Mackall wrote:
> >On Mon, Oct 24, 2005 at 12:29:45AM -0500, Hareesh Nagarajan wrote:
> >>The existing code in init_tmpfs() in mm/tiny-shmem.c does not handle the 
> >>cases when the calls to register_filesystem() and kern_mount() fail. 
> >>This patch adds those checks.
> >
> >Hmm. Did you actually encounter this?
> 
> No, I haven't. I was just reading the source code when I chanced upon 
> these trivial error checking omissions.
> 
> >I'd rather use BUG_ON. Passing up errors is only useful when the code
> >above can and will do something useful with the information. 
> 
> [ Snip ]
> 
> >And what could the higher level, which is simply looping through init
> >functions, do to handle the error? Retry? Print a warning? Better to
> >stop everything outright when we encounter a problem we expect should
> >never happen so it doesn't go by undiagnosed.
> 
> Makes sense. New patch attached.

A couple more comments..

> Signed-off-by: Hareesh Nagarajan <hnagar2@gmail.com>

> --- linux-2.6.13.4/mm/tiny-shmem.c	2005-10-10 13:54:29.000000000 -0500
> +++ linux-2.6.13.4-edit/mm/tiny-shmem.c	2005-10-24 03:43:38.614071000 -0500
> @@ -31,12 +31,18 @@
>  
>  static int __init init_tmpfs(void)
>  {
> -	register_filesystem(&tmpfs_fs_type);
> +	int error;
> +
> +	error = register_filesystem(&tmpfs_fs_type);
> +	BUG_ON(error);

Can we just do BUG_ON(register_filesystem() != 0)?

Strictly speaking, the != 0 is redundant, but as this goes slightly
against the grain of normal usage, it's a good indicator of intent.

> +
>  #ifdef CONFIG_TMPFS
>  	devfs_mk_dir("shm");
>  #endif
>  	shm_mnt = kern_mount(&tmpfs_fs_type);
> -	return 0;
> +	BUG_ON(IS_ERR(shm_mnt));
> +
> +	return error;

We can never return non-zero here. Returning error implies we can, so
it's confusing.

-- 
Mathematics is the supreme nostalgia of our time.
