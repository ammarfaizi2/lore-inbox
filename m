Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267403AbUG2BSt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267403AbUG2BSt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 21:18:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267398AbUG2BSt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 21:18:49 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:44182 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S267403AbUG2BSb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 21:18:31 -0400
Date: Thu, 29 Jul 2004 12:14:53 +1000
From: Nathan Scott <nathans@sgi.com>
To: lord@xfs.org, Amon Ott <ao@rsbac.org>
Cc: "Jeffrey E. Hundstad" <jeffrey.hundstad@mnsu.edu>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 4K stack kernel get Oops in Filesystem stress test
Message-ID: <20040729021453.GG800@frodo>
References: <20040720114418.GH21918@email.archlab.tuwien.ac.at> <40FD0A61.1040503@xfs.org> <40FD2E99.20707@mnsu.edu> <200407220927.45201.ao@rsbac.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200407220927.45201.ao@rsbac.org>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 22, 2004 at 09:27:44AM +0200, Amon Ott wrote:
> On Dienstag, 20. Juli 2004 16:39, Jeffrey E. Hundstad wrote:
> > Steve Lord wrote:
> > > Don't use 4K stacks and XFS. What you hit here is a path where the
> > > filesystem is getting full and it needs to free some reserved space
> > > by flushing cached data which is using reserved extents. Reserved
> > > extents do not yet have an on disk address and they include a
> > > reservation for the worst case metadata usage. Flushing them will
> > > get you room back.
> > >
> > > As you can see, it is a pretty deep call stack, most of XFS is going
> > > to work just fine with a 4K stack, but there are end cases like
> > > this one which will just not fit.

Actually, this area of the code has been a source of several
deadlocks, so we need to consider reworking how we do this
anyay (helper thread or something along those lines) - that
would also help to address the stack depth problem here, and
this spot is probably the worst-case situation for stack use
in XFS.

> > If this is a known truth with XFS maybe it would be a good idea to have 
> > 4K stacks and XFS be an impossible combination using the config tool.

I would prefer not to do that, we want to know where the problems
are - if we hide them like this it will just make them harder to
find and resolve.  Certainly XFS is not the only subsystem with
problems here (even saw an _ext2_ stack overflow go past recently,
and I believe other filesystems can be much worse) - & when stacked
volume managers and other drivers enter the picture...

> It would be good if there was some warning in the 4K stack option help, 
> there have been quite many cases already where the kernel broke with odd 
> symptoms because of this switch.
> 
> E.g.
> Warning: Use this option with care, as it might break your system under 
> load. If you experience weird crashes or oopses, please retry with this 
> option turned off.

If its not done already, perhaps 4KSTACKS could be reported in
the oops message (like PREEMPT and one or two other things are,
IIRC)?

cheers.

-- 
Nathan
