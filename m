Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262038AbVDRLWX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262038AbVDRLWX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Apr 2005 07:22:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262039AbVDRLWX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Apr 2005 07:22:23 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:23506 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262038AbVDRLWR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Apr 2005 07:22:17 -0400
Date: Mon, 18 Apr 2005 12:22:13 +0100
From: Christoph Hellwig <hch@infradead.org>
To: akpm@osdl.org
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org, bernard@blackham.com.au,
       cmm@us.ibm.com
Subject: Re: [patch 130/198] ext2 corruption - regression between 2.6.9 and 2.6.10
Message-ID: <20050418112213.GA22356@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>, akpm@osdl.org,
	torvalds@osdl.org, linux-kernel@vger.kernel.org,
	bernard@blackham.com.au, cmm@us.ibm.com
References: <200504121032.j3CAWhE5005660@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200504121032.j3CAWhE5005660@shell0.pdx.osdl.net>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Mingming Cao <cmm@us.ibm.com> said:
> The ext2 handle discard preallocation differently at that time, it discard the
> preallocation at each iput(), not in input_final(), so we think it's
> unnecessary to thrash it so frequently, and the right thing to do, as we did
> for ext3 reservation, discard preallocation on last iput().  So we moved the
> ext2_discard_preallocation from ext2_put_inode(0 to ext2_clear_inode.
> 
> Since ext2 preallocation is doing pre-allocation on disk, so it is possible
> that at the unmount time, someone is still hold the reference of the inode, so
> the preallocation for a file is not discard yet, so we still mark those blocks
> allocated on disk, while they are not actually in the inode's block map, so
> fsck will catch/fix that error later.
> 
> This is not a issue for ext3, as ext3 reservation(pre-allocation) is done in
> memory.

Shouldn't we have a pass to discard on unmount instead?  ->put_inode is
a really bad interface and all usages including this one are racy (not that
it matters too much here, but I'd like to get rid of it eventually).

As a band-aid to avoid the corruption it's certainly okay (and needed), but
we should try to fix this for real.  Mingming, do you want to look into it
or should I put it on my TODO list?

