Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292924AbSBVQN3>; Fri, 22 Feb 2002 11:13:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292925AbSBVQNV>; Fri, 22 Feb 2002 11:13:21 -0500
Received: from pc-62-31-66-117-ed.blueyonder.co.uk ([62.31.66.117]:55681 "EHLO
	sisko.scot.redhat.com") by vger.kernel.org with ESMTP
	id <S292924AbSBVQNO>; Fri, 22 Feb 2002 11:13:14 -0500
Date: Fri, 22 Feb 2002 16:13:07 +0000
From: "Stephen C. Tweedie" <sct@redhat.com>
To: James Bottomley <James.Bottomley@steeleye.com>
Cc: "Stephen C. Tweedie" <sct@redhat.com>, Chris Mason <mason@suse.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4.x write barriers (updated for ext3)
Message-ID: <20020222161307.H2424@redhat.com>
In-Reply-To: <200202221557.g1MFvp004149@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200202221557.g1MFvp004149@localhost.localdomain>; from James.Bottomley@steeleye.com on Fri, Feb 22, 2002 at 10:57:51AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Feb 22, 2002 at 10:57:51AM -0500, James Bottomley wrote:

> Finally, I think the driver ordering problem can be solved easily as long as 
> an observation I have about your barrier is true.  It seems to me that the 
> barrier is only semi permeable, namely its purpose is to complete *after* a 
> particular set of commands do.  This means that it doesnt matter if later 
> commands move through the barrier, it only matters that earlier commands 
> cannot move past it?

No.  A commit block must be fully ordered.  

If the commit block fails to be written, then we must be able to roll
the filesystem back to the consistent, pre-commit state, which implies
that any later IOs (which might be writeback IOs updating
now-committed metadata to final locations on disk) must not be allowed
to overtake the commit block.

However, in the current code, we don't assume that ordered queuing
works, so that later writeback will never be scheduled until we get a
positive completion acknowledgement for the commit block.  In other
words, right now, the scenario you describe is not a problem.

But ideally, with ordered queueing we would want to be able to relax
things by allowing writeback to be queued immediately the commit is
queued.  The ordered tag must be honoured in both directions in that
case.

There is a get-out for ext3 --- we can submit new journal IOs without
waiting for the commit IO to complete, but hold back on writeback IOs.
That still has the desired advantage of allowing us to stream to the
journal, but only requires that the commit block be ordered with
respect to older, not newer, IOs.  That gives us most of the benefits
of tagged queuing without any problems in your scenario.

--Stephen
