Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751393AbWIYVZH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751393AbWIYVZH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 17:25:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751401AbWIYVZH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 17:25:07 -0400
Received: from mail.fieldses.org ([66.93.2.214]:59808 "EHLO
	pickle.fieldses.org") by vger.kernel.org with ESMTP
	id S1751393AbWIYVZF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 17:25:05 -0400
Date: Mon, 25 Sep 2006 17:24:57 -0400
To: NeilBrown <neilb@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, nfs@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [NFS] [PATCH 009 of 11] knfsd: Allow max size of NFSd payload to be configured.
Message-ID: <20060925212457.GK32762@fieldses.org>
References: <20060824162917.3600.patches@notabene> <1060824063716.5020@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1060824063716.5020@suse.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
From: "J. Bruce Fields" <bfields@fieldses.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 24, 2006 at 04:37:16PM +1000, NeilBrown wrote:
> diff .prev/fs/nfsd/nfssvc.c ./fs/nfsd/nfssvc.c
> --- .prev/fs/nfsd/nfssvc.c	2006-08-24 16:26:10.000000000 +1000
> +++ ./fs/nfsd/nfssvc.c	2006-08-24 16:26:10.000000000 +1000
> @@ -198,9 +198,26 @@ int nfsd_create_serv(void)
>  		unlock_kernel();
>  		return 0;
>  	}
> +	if (nfsd_max_blksize == 0) {
> +		/* choose a suitable default */
> +		struct sysinfo i;
> +		si_meminfo(&i);
> +		/* Aim for 1/4096 of memory per thread
> +		 * This gives 1MB on 4Gig machines
> +		 * But only uses 32K on 128M machines.
> +		 * Bottom out at 8K on 32M and smaller.
> +		 * Of course, this is only a default.
> +		 */
> +		nfsd_max_blksize = NFSSVC_MAXBLKSIZE;
> +		i.totalram >>= 12;
> +		while (nfsd_max_blksize > i.totalram &&
> +		       nfsd_max_blksize >= 8*1024*2)
> +			nfsd_max_blksize /= 2;
> +	}

It looks to me like totalram is actually measured in pages.  So in
practice this gives almost everyone 8k here.  So that 12 should be
something like 12 - PAGE_CACHE_SHIFT?

--b.
