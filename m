Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262882AbVGNDvC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262882AbVGNDvC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 23:51:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262883AbVGNDvC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 23:51:02 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:23736 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S262882AbVGNDvA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 23:51:00 -0400
Date: Thu, 14 Jul 2005 13:50:23 +1000
From: Dave Chinner <dgc@sgi.com>
To: Nathan Scott <nathans@sgi.com>
Cc: Daniel Walker <dwalker@mvista.com>, Ingo Molnar <mingo@elte.hu>,
       Steve Lord <lord@xfs.org>, linux-kernel@vger.kernel.org,
       linux-xfs@oss.sgi.com
Subject: Re: RT and XFS
Message-ID: <20050714135023.E241419@melbourne.sgi.com>
References: <1121209293.26644.8.camel@dhcp153.mvista.com> <20050713002556.GA980@frodo> <20050713064739.GD12661@elte.hu> <1121273158.13259.9.camel@c-67-188-6-232.hsd1.ca.comcast.net> <20050714002246.GA937@frodo>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050714002246.GA937@frodo>; from nathans@sgi.com on Thu, Jul 14, 2005 at 10:22:46AM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 14, 2005 at 10:22:46AM +1000, Nathan Scott wrote:
> Hi there,
> 
> On Wed, Jul 13, 2005 at 09:45:58AM -0700, Daniel Walker wrote:
> > On Wed, 2005-07-13 at 08:47 +0200, Ingo Molnar wrote:
> > > 
> > > downgrade_write() wasnt the main problem - the main problem was that for 
> > > PREEMPT_RT i implemented 'strict' semaphores, which are not identical to 
> > > vanilla kernel semaphores. The thing that seemed to impact XFS the most 
> > > is the 'acquirer thread has to release the lock' rule of strict 
> > > semaphores. Both the XFS logging code and the XFS IO completion code 
> > > seems to release locks in a different context from where the acquire 
> > > happened. It's of course valid upstream behavior, but without these 
> > > extra rules it's hard to do sane priority inheritance. (who do you boost 
> > > if you dont really know who 'owns' the lock?) It might make sense to 
> > > introduce some sort of sem_pass_to(new_owner) interface? For now i 
> > > introduced a compat type, which lets those semaphores fall back to the 
> > > vanilla implementation.
> 
> Hmm, I'm not aware of anywhere in XFS where we do that.  From talking
> to some colleagues here, they're claiming that we can't be doing that
> since it'd trip an assert in the IRIX mrlock code.

Now that I've read the thread, I see it's not mrlocks that is the
issue with unlocking in a different context - it's semaphores.

All the pagebuf synchronisation is done with a semaphore because
it's held across the I/O and it's _most definitely_ released in a
different context when doing async I/O. Just about all metadata I/O
is async because once the transaction has been logged to disk we
don't need to write these buffers out synchronously. Not to mention
the log I/O completion unlocks the buffers in a transaction in a
different context as well.

The whole point of using a semaphore in the pagebuf is because there
is no tracking of who "owns" the lock so we can actually release it
in a different context. Semaphores were invented for this purpose,
and we use them in the way they were intended. ;)

Realistically, I seriously doubt the need for any sort of rt changes
to these semaphores. They can be held for indeterminant periods of
time potentially across multiple disk I/Os (e.g. when held locked in
a transaction that requires more metadata to be read in from disk to
make progress).  Hence there is no really no point in making them RT
aware because if you end up waiting on one of them you can forget
about pretty much any RT guarantee that you've ever given....

Cheers,

Dave.
-- 
Dave Chinner
R&D Software Engineer
SGI Australian Software Group
