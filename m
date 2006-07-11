Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932169AbWGKWJD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932169AbWGKWJD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 18:09:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932187AbWGKWJB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 18:09:01 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:33236 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932169AbWGKWJA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 18:09:00 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=bQSNgtYHGUHRqHGThuO1+H8Ov2PcI402c30jvI8TKuRtHz7bWc4dWbjVKWHRvqtR1Tq37T7hAlFmYWeMxV7ADeGh+VU69cnloU2e+o3GtRrivGi47kT4hGwJsJxFVLscSRK61esbm64FTsQ2Qn7GEH+Cn+cvJeX5P8vYKFGhuiw=
Message-ID: <9e4733910607111508x526ee642p5b587698306b22d3@mail.gmail.com>
Date: Tue, 11 Jul 2006 18:08:59 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Theodore Tso" <tytso@mit.edu>, "Jon Smirl" <jonsmirl@gmail.com>,
       "Alan Cox" <alan@lxorguk.ukuu.org.uk>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: tty's use of file_list_lock and file_move
In-Reply-To: <20060711194456.GA3677@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <9e4733910607100810r6e02f69g9a3f6d3d1400b397@mail.gmail.com>
	 <1152552806.27368.187.camel@localhost.localdomain>
	 <9e4733910607101027g5f3386feq5fc54f7593214139@mail.gmail.com>
	 <1152554708.27368.202.camel@localhost.localdomain>
	 <9e4733910607101535i7f395686p7450dc524d9b82ae@mail.gmail.com>
	 <1152573312.27368.212.camel@localhost.localdomain>
	 <9e4733910607101604j16c54ef0r966f72f3501cfd2b@mail.gmail.com>
	 <9e4733910607101649m21579ae2p9372cced67283615@mail.gmail.com>
	 <20060711012904.GD30332@thunk.org>
	 <20060711194456.GA3677@flint.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/11/06, Russell King <rmk+lkml@arm.linux.org.uk> wrote:
> On Mon, Jul 10, 2006 at 09:29:04PM -0400, Theodore Tso wrote:
> > On Mon, Jul 10, 2006 at 07:49:31PM -0400, Jon Smirl wrote:
> > > How about the use of lock/unlock_kernel(). Is there some hidden global
> > > synchronization going on? Every time lock/unlock_kernel() is used
> > > there is a tty_struct available. My first thought would be to turn
> > > this into a per tty spinlock. Looking at where it is used it looks
> > > like it was added to protect all of the VFS calls. I see no obvious
> > > coordination with other ttys that isn't handled by other locks.
> >
> > No, it was just a case of not being worth it to get rid of the BKL for
> > the tty subsystem, since opening and closing tty's isn't exactly a
> > common event.  Switching it to use a per-tty spinlock makes sense if
> > we're going to rototill the code, but to be honest it's probably not
> > going to make a noticeable difference on any benchmark and most
> > workloads.
>
> It's not that simple - remember that you must be able to open a tty
> in non-blocking mode while someone else is opening the same tty in
> blocking mode, _and_ succeed.  (iow, the getty waiting for call-in
> and you want to dial out case.)
>
> If we go for merely replacing BKL with some other lock, each tty
> driver has to be able to drop that lock when it decides to sleep due
> to no carrier in its open method... which is kind'a yuck.

Directly replacing BKL was my first strategy but that looks to be
hard. Some of the sleeps are in the line discipline code which means I
have to find all of them. After replacing BKL I'd try to simplify the
locking.

What about adjusting things so the BKL isn't required? I tried
completely removing it and died in release_dev. tty_mutex is already
locks a lot of stuff, maybe it can be adjusted to allow removal of the
BKL.

I'm also trying to decide if read/write really need BKL when they are
called. Read/write already uses the atomic_read/write_lock mutexes.

read_chan has this comment:
 *	Perform reads for the line discipline. We are guaranteed that the
 *	line discipline will not be closed under us but we may get multiple
 *	parallel readers and must handle this ourselves. We may also get
 *	a hangup. Always called in user context, may sleep.

But read_chan is always called from tty_io.c with BKL held. So is
atomic_read_lock really doing anything or is it masked by BKL?

I see why no one works on this code, it is very intertwined with the
rest of the kernel and a lot of the reasons for locking are
non-obvious.

-- 
Jon Smirl
jonsmirl@gmail.com
