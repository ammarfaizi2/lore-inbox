Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292872AbSBVOTy>; Fri, 22 Feb 2002 09:19:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292873AbSBVOTp>; Fri, 22 Feb 2002 09:19:45 -0500
Received: from pc-62-31-66-117-ed.blueyonder.co.uk ([62.31.66.117]:9601 "EHLO
	sisko.scot.redhat.com") by vger.kernel.org with ESMTP
	id <S292872AbSBVOTd>; Fri, 22 Feb 2002 09:19:33 -0500
Date: Fri, 22 Feb 2002 14:19:15 +0000
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Chris Mason <mason@suse.com>
Cc: Andrew Morton <akpm@zip.com.au>, "Stephen C. Tweedie" <sct@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4.x write barriers (updated for ext3)
Message-ID: <20020222141915.F2424@redhat.com>
In-Reply-To: <799880000.1014334220@tiny>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <799880000.1014334220@tiny>; from mason@suse.com on Thu, Feb 21, 2002 at 06:30:20PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Feb 21, 2002 at 06:30:20PM -0500, Chris Mason wrote:
 
> This makes it much easier to add support for ide writeback
> flushing to things like ext3 and lvm, where I want to make
> the minimal possible changes to make things safe.

Nice.

> There might be additional spots in ext3 where ordering needs to be 
> enforced, I've included the ext3 code below in hopes of getting 
> some comments.

No.  However, there is another optimisation which we can make.

Most ext3 commits, in practice, are lazy, asynchronous commits, and we
only nedd BH_Ordered_Tag for that, not *_Flush.  It would be easy
enough to track whether a given transaction has any synchronous
waiters, and if not, to use the async *_Tag request for the commit
block instead of forcing a flush.

We'd also have to track the sync status of the most recent
transaction, too, so that on fsync of a non-dirty file/inode, we make
sure that its data had been forced to disk by at least one synchronous
flush.  

But that's really only a win for SCSI, where proper async ordered tags
are supported.  For IDE, the single BH_Ordered_Flush is quite
sufficient.

Cheers,
 Stephen
