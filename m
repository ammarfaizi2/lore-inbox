Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277514AbRKHGrm>; Thu, 8 Nov 2001 01:47:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278709AbRKHGrd>; Thu, 8 Nov 2001 01:47:33 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:8185
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S277514AbRKHGrW>; Thu, 8 Nov 2001 01:47:22 -0500
Date: Wed, 7 Nov 2001 22:47:16 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Andrew Morton <akpm@zip.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Memory accounting problem in 2.4.13, 2.4.14pre, and possibly 2.4.14
Message-ID: <20011107224716.D467@mikef-linux.matchmail.com>
Mail-Followup-To: Andrew Morton <akpm@zip.com.au>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20011106140335.A13678@mikef-linux.matchmail.com> <3BE9E9A7.6F90C4DB@zip.com.au>, <3BE9E9A7.6F90C4DB@zip.com.au> <20011107182442.B467@mikef-linux.matchmail.com> <3BEA116A.646B9159@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3BEA116A.646B9159@zip.com.au>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 07, 2001 at 09:00:26PM -0800, Andrew Morton wrote:
> Mike Fedyk wrote:
> > 
> > >
> > 
> > I am running unpatched 2.4.14 now.
> > 
> > Do you still want me to try this patch now that you know I have been able to
> > see the problem with 2.2.14+ext3?
> > 
> 
> It's OK - I can reproduce it easily anyway.
> 
> There are two things here.  Recent -ac kernels had a merge
> bug down in the /proc code which caused `Cached:' to go
> negative.  It was recently fixed.
> 
> And quite independently, current ext3 for Linus kernels now has a
> bug which causes the `buffermem_pages' number to get too large.
> This has the exact same effect: `Cached:' goes negative. 
> 
> The buffermem_pages counter is purely for reporting - no VM decisions
> are based on its value.  But if it worries you, just remove line 1933 of fs/jbd/transaction.c.

Applied.

Here's the patch.

--- 2.4.14-ext3_0.9.15-2414/fs/jbd/transaction.c~	Wed Nov  7 22:41:13 2001
+++ 2.4.14-ext3_0.9.15-2414/fs/jbd/transaction.c	Wed Nov  7 22:43:14 2001
@@ -1930,7 +1930,6 @@
 
 	if (!offset) {
 		if (!may_free || !try_to_free_buffers(page, 0)) {
-			atomic_inc(&buffermem_pages);
 			return 0;
 		}
 		J_ASSERT(page->buffers == NULL);

I'll run it overnight, and test it tomorrow...

Mike
