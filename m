Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261683AbVFFUWt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261683AbVFFUWt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Jun 2005 16:22:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261680AbVFFUUV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Jun 2005 16:20:21 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:2705 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S261658AbVFFUTQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Jun 2005 16:19:16 -0400
Date: Mon, 6 Jun 2005 15:18:57 -0500 (CDT)
From: Brent Casavant <bcasavan@sgi.com>
Reply-To: Brent Casavant <bcasavan@sgi.com>
To: Hugh Dickins <hugh@veritas.com>
cc: Andrew Morton <akpm@osdl.org>, Christoph Rohland <cr@sap.com>,
       Robin Holt <holt@sgi.com>, "Adam J. Richter" <adam@yggdrasil.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] shmem: restore superblock info
In-Reply-To: <Pine.LNX.4.61.0506062043470.5000@goblin.wat.veritas.com>
Message-ID: <20050606150742.F19925@chenjesu.americas.sgi.com>
References: <Pine.LNX.4.61.0506062043470.5000@goblin.wat.veritas.com>
Organization: "Silicon Graphics, Inc."
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Jun 2005, Hugh Dickins wrote:

> @@ -1607,15 +1582,17 @@ static int shmem_statfs(struct super_blo
>  	buf->f_type = TMPFS_MAGIC;
>  	buf->f_bsize = PAGE_CACHE_SIZE;
>  	buf->f_namelen = NAME_MAX;
> -	if (sbinfo) {
> -		spin_lock(&sbinfo->stat_lock);
> +	spin_lock(&sbinfo->stat_lock);
> +	if (sbinfo->max_blocks) {
>  		buf->f_blocks = sbinfo->max_blocks;
>  		buf->f_bavail = buf->f_bfree = sbinfo->free_blocks;
> +	}
> +	if (sbinfo->max_inodes) {
>  		buf->f_files = sbinfo->max_inodes;
>  		buf->f_ffree = sbinfo->free_inodes;
> -		spin_unlock(&sbinfo->stat_lock);
>  	}
>  	/* else leave those fields 0 like simple_statfs */
> +	spin_unlock(&sbinfo->stat_lock);
>  	return 0;
>  }

This is the only change I'm at all concerned about.

I'm not sure how frequent statfs operations occur in practice (I suspect
infrequently), however simply changing the existing code from "if (sbinfo)"
to "if (sbinfo->max_blocks || sbinfo->max_inodes)" would be an appropriate
remedy if there is a real problem.

That said, I'm not all that concerned about it, as my fuzzy memory
indicates it was the lock/unlock around the statistics updates which
caused the primary lock contention.

Brent

-- 
Brent Casavant                          If you had nothing to fear,
bcasavan@sgi.com                        how then could you be brave?
Silicon Graphics, Inc.                    -- Queen Dama, Source Wars
