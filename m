Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751599AbWHNBK3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751599AbWHNBK3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Aug 2006 21:10:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751757AbWHNBK2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Aug 2006 21:10:28 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:61388 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751599AbWHNBK0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Aug 2006 21:10:26 -0400
Date: Mon, 14 Aug 2006 11:09:42 +1000
From: Nathan Scott <nathans@sgi.com>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: linux-kernel@vger.kernel.org, xfs-masters@oss.sgi.com, xfs@oss.sgi.com
Subject: Re: [PATCH] XFS: remove pointless conditional testing 'nmp' vs NULL in fs/xfs/xfs_rtalloc.c::xfs_growfs_rt()
Message-ID: <20060814110942.C2698880@wobbly.melbourne.sgi.com>
References: <200608130016.51136.jesper.juhl@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200608130016.51136.jesper.juhl@gmail.com>; from jesper.juhl@gmail.com on Sun, Aug 13, 2006 at 12:16:50AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 13, 2006 at 12:16:50AM +0200, Jesper Juhl wrote:
> In fs/xfs/xfs_rtalloc.c::xfs_growfs_rt() there's a completely useless
> conditional at the error_exit label.
> The 'if (nmp)' check is pointless and might as well be removed for two 
> reasons.
> 
> 1) if 'nmp' is NULL then kmem_free() will end up calling kfree() with a NULL
>    argument - which in turn will just cause a return from kfree(). No harm 
>    done.

Thats valid.

> 2) At the beginning of the function there's an assignment; '*nmp = *mp;' so

Thats not.  Theres no assignment at the start of the function;
theres one inside the main body of the loop 20+ lines into it,
and right after a mem alloc with flags requiring no failure.
Later that local variable is freed then set to NULL inside the
loop, before continuing the next iteration...

Really this code would be better if reworked slightly to just
allocate nmp once before entering the loop, and then free it
once at the end... we wouldn't need a goto, just a few breaks
in the loop and a conditional transaction cancel.

> This patch gets rid of the pointless check.

Hmm, seems like code churn that makes the code slightly less
obvious, but thats just me... I'd prefer a tested patch that
implements the above suggestion, to be honest. :)

cheers.

-- 
Nathan
