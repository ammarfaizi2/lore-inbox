Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751049AbVJXHLD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751049AbVJXHLD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Oct 2005 03:11:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751055AbVJXHLD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Oct 2005 03:11:03 -0400
Received: from waste.org ([216.27.176.166]:54434 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S1751049AbVJXHLB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Oct 2005 03:11:01 -0400
Date: Mon, 24 Oct 2005 00:09:21 -0700
From: Matt Mackall <mpm@selenic.com>
To: Hareesh Nagarajan <hnagar2@gmail.com>
Cc: linux-kernel@vger.kernel.org, ak@suse.de
Subject: Re: [TRIVIAL] Error checks omitted in init_tmpfs() in mm/tiny-shmem.c
Message-ID: <20051024070921.GW26160@waste.org>
References: <435C7149.3010004@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <435C7149.3010004@gmail.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 24, 2005 at 12:29:45AM -0500, Hareesh Nagarajan wrote:
> The existing code in init_tmpfs() in mm/tiny-shmem.c does not handle the 
> cases when the calls to register_filesystem() and kern_mount() fail. 
> This patch adds those checks.

Hmm. Did you actually encounter this?

I'd rather use BUG_ON. Passing up errors is only useful when the code
above can and will do something useful with the information. 

Here, we're talking about a built-in getting initialized at boot that
can quietly fail and the upper layer will simply shrug and go on,
leaving the system in a possibly useless state. Which is worse than
not attempting error handling at all, because we've added complexity
for no gain.

And what could the higher level, which is simply looping through init
functions, do to handle the error? Retry? Print a warning? Better to
stop everything outright when we encounter a problem we expect should
never happen so it doesn't go by undiagnosed.

> --- linux-2.6.13.4/mm/tiny-shmem.c	2005-10-10 13:54:29.000000000 -0500
> +++ linux-2.6.13.4-edit/mm/tiny-shmem.c	2005-10-24 00:13:10.532652000 -0500
> @@ -31,12 +31,27 @@
>  
>  static int __init init_tmpfs(void)
>  {
> -	register_filesystem(&tmpfs_fs_type);
> +	int error;
> +
> +	error = register_filesystem(&tmpfs_fs_type);
> +	if (error) {
> +		goto out2;
> +	}
> +
>  #ifdef CONFIG_TMPFS
>  	devfs_mk_dir("shm");
>  #endif
>  	shm_mnt = kern_mount(&tmpfs_fs_type);
> +	if (IS_ERR(shm_mnt)) {
> +		error = PTR_ERR(shm_mnt);
> +		goto out1;
> +	}
> +
>  	return 0;
> +out1:
> +	unregister_filesystem(&tmpfs_fs_type);
> +out2:
> +	return error;
>  }
>  module_init(init_tmpfs)
>  


-- 
Mathematics is the supreme nostalgia of our time.
