Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289307AbSBNBal>; Wed, 13 Feb 2002 20:30:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289313AbSBNBaW>; Wed, 13 Feb 2002 20:30:22 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:17156 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S289307AbSBNBaI>;
	Wed, 13 Feb 2002 20:30:08 -0500
Message-ID: <3C6B12E4.E3BC9881@zip.com.au>
Date: Wed, 13 Feb 2002 17:29:08 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18-pre9-ac2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Daniel Phillips <phillips@bonn-fries.net>
CC: Bill Davidsen <davidsen@tmr.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] sys_sync livelock fix
In-Reply-To: <Pine.LNX.3.96.1020213170030.12448F-100000@gatekeeper.tmr.com> <E16bA59-0002Qa-00@starship.berlin> <3C6B0A70.D11DFC2A@zip.com.au>,
		<3C6B0A70.D11DFC2A@zip.com.au> <E16bAgV-0002R2-00@starship.berlin>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips wrote:
> 
> On February 14, 2002 01:53 am, Andrew Morton wrote:
> > Daniel Phillips wrote:
> > >
> > > What's the theory behind writing the data both before and after the commit?
> >
> > see fsync_dev().  It starts I/O against existing dirty data, then
> > does various fs-level syncy things which can produce more dirty
> > data - this is where ext3 runs its commit, via brilliant reverse
> > engineering of its calling context :-(.
> 
> OK, so it sounds like cleaning that up with an ext3-specific super->sync would
> be cleaner for what it's worth, and save a little cpu.

Oh, having a filesystem sync entry point is much more than
a little cleanup.  It's quite important.  In current kernels
the same code path is used for both sync() and for periodic
kupdate writeback.  It's not possible for the filesystem
to know which context it's being called in, and we do want
different behaviour.

We want the sys_sync() path to wait on writeout, but it's
silly to make the kupdate path do that.


> > It then again starts I/O against new dirty data then waits on it again.  And
> > then again.  There's quite a lot of overkill there.  But that's OK, as long
> > as it terminates sometime.
> 
> /me doesn't comment

That's odd.

-

:)
