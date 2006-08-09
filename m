Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751433AbWHIXGG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751433AbWHIXGG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 19:06:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751435AbWHIXGF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 19:06:05 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:47774 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751433AbWHIXGE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 19:06:04 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=eB5K3pPBk135rmktc6UrEQwhx2GoHIVmx0dTb0KDmUiUOAcQBWZ0eBj/y9sZwPm8HwK75u9Ej+ThL57e0jQhPS1gB4IIuwfL3kS1Qw7EUto8VVQqKiOC5zxJOBw7TLdYLiH1zHgXFiy+R36WBvRQO34SVuaNHZmVXNzwrN+8No0=
Date: Thu, 10 Aug 2006 03:06:00 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Meelis Roos <mroos@linux.ee>
Cc: nathans@sgi.com, linux-kernel@vger.kernel.org
Subject: Re: XFS warning in 2.6.18-rc4
Message-ID: <20060809230559.GA7679@martell.zuzino.mipt.ru>
References: <Pine.SOC.4.61.0608092303570.27011@math.ut.ee>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.SOC.4.61.0608092303570.27011@math.ut.ee>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 09, 2006 at 11:04:53PM +0300, Meelis Roos wrote:
> fs/xfs/xfs_bmap.c: In function 'xfs_bmapi':
> fs/xfs/xfs_bmap.c:2662: warning: 'rtx' is used uninitialized in this function

gcc bug again? Corresponding preprocessed source when XFS realtime allocator
is off:

static int xfs_bmap_rtalloc(xfs_bmalloca_t *ap)
{
		...
	xfs_rtblock_t rtx;

		...
	if (ap->eof && ap->off == 0) {
===>		error = (251);		<===
		if (error)
			return error;
		ap->rval = rtx * mp->m_sb.sb_rextsize;
	} else {
		ap->rval = 0;
	}

This is the only place where rtx is "used".

When realtime allocator is on, xfs_rtpick_extent() is real function
either a) returning error and leaving garbage in "rtx", or b)
initializing "rtx" and returning 0.

