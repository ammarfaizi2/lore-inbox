Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757134AbWKWHI5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757134AbWKWHI5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Nov 2006 02:08:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757093AbWKWHI5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Nov 2006 02:08:57 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:35220 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1757068AbWKWHIz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Nov 2006 02:08:55 -0500
Date: Thu, 23 Nov 2006 18:08:37 +1100
From: David Chinner <dgc@sgi.com>
To: David Miller <davem@davemloft.net>
Cc: dgc@sgi.com, jesper.juhl@gmail.com, chatz@melbourne.sgi.com,
       linux-kernel@vger.kernel.org, xfs@oss.sgi.com, xfs-masters@oss.sgi.com,
       netdev@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: 2.6.19-rc6 : Spontaneous reboots, stack overflows - seems to implicate xfs, scsi, networking, SMP
Message-ID: <20061123070837.GV11034@melbourne.sgi.com>
References: <9a8748490611211551v2ebe88fel2bcf25af004c338a@mail.gmail.com> <9a8748490611220458w4d94d953v21f7a29a9f1bdb72@mail.gmail.com> <20061123011809.GY37654165@melbourne.sgi.com> <20061122.201013.112290046.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061122.201013.112290046.davem@davemloft.net>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 22, 2006 at 08:10:13PM -0800, David Miller wrote:
> From: David Chinner <dgc@sgi.com>
> Date: Thu, 23 Nov 2006 12:18:09 +1100
> 
> > So, assuming the stacks less than 32 bytes are 32 bytes, we've got
> > 1380 bytes in the XFS stack there, 
> 
> On sparc64 just the XFS parts of the backtrace would be a minimum of
> 2816 bytes (each function has a minimum 8 * 16 byte stack frame, and
> there are about 22 calls in that trace).

Ok, I didn't think of stack frames - I thought they tiny on x86 but
I'm not intimately familiar with x86 which is why I'm asking....

> It's probably a lot more
> with local variables and such.

Not much more than above - the same call path on ia64 and x86_64
using the stack checker addition method I used showed about a 35%
increase in stack usage compared to ia32. I'd say about 4.5k stack
usage on sparc64 for that call path, then.

FWIW, I've never heard of XFS related stack overflows on the
sparc64 platform - have you heard of any reports of this
being a problem?

> It's way too much.  You guys have to fix this stuff.

Sure, we're trying to but it takes time.  However, if it's such a
problem for you now and you want this process sped up, then _please,
please, please_ submit patches to help fix the problem.....

Realistically, XFS is only part of the problem here - the other part
of the problem is the amount of stack that softirqs are using (e.g.
the entire tcp send and receive path) which means we really have
much, much less than 4k of stack space to play with.

If the softirqs were run on a different stack, then a lot of these
problems would go away (29 of the 35 reported overflows had softirqs
running) and we'd be much more likely to get XFS to run reliably on
4k stacks...

Cheers,

Dave.
-- 
Dave Chinner
Principal Engineer
SGI Australian Software Group
