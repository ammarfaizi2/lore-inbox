Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932512AbWHCO0s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932512AbWHCO0s (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 10:26:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932517AbWHCO0s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 10:26:48 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:52203 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932512AbWHCO0s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 10:26:48 -0400
Date: Thu, 3 Aug 2006 15:26:44 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: reiserfs-dev@namesys.com, linux-kernel@vger.kernel.org
Subject: Re: partial reiser4 review comments
Message-ID: <20060803142644.GC20405@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@osdl.org>, reiserfs-dev@namesys.com,
	linux-kernel@vger.kernel.org
References: <20060803001741.4ee9ff72.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060803001741.4ee9ff72.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 03, 2006 at 12:17:41AM -0700, Andrew Morton wrote:
> - running igrab() in the writepage() path is really going to hammer
>   inode_lock.  Something else will need to be done here.

> - Running iput() in entd() is a bit surprising.  iirc there are various ways
>   in which this can recur into the filesystem, perform I/O, etc.  I guess it
>   works..
> 
>   But again, it will hammer inode_lock.

XFS used to do this and it caused lots of problems.  What xfs does now
is to keep an iocount in the inode for outstanding I/Os and ->clear_inode
waits for that I/O to finish using hashed waitqueues.  It would be nice
to have a facility like that in generic code.

> - reiser4_readpages() shouldn't need to clean up the remaining pages on
>   *pages.  read_cache_pages() does that now.

Without looking at the code I remember someone from the Namesys people told
me they could use plain mpage_readpages now.  Anything still blocking using
that function?

> - General comment: the lack of support for extended attributes, access
>   control lists and direct-io is a big problem and it's getting bigger.  I
>   don't see how a vendor could support reiser4 without these features and
>   permanent lack of vendor support will hurt.
> 
>   What's the plan here?

Another issue is the lack of support for blocksize < pagesize.   This prevents
it from beeing used across architectures.  Even worse when I tried the last
time it didn't allow me to create a 64k blocksize filesystem that I could
actually test on ppc64.
