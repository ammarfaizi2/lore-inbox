Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316089AbSGQRsj>; Wed, 17 Jul 2002 13:48:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316106AbSGQRsj>; Wed, 17 Jul 2002 13:48:39 -0400
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:60303 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S316089AbSGQRsh>; Wed, 17 Jul 2002 13:48:37 -0400
Date: Wed, 17 Jul 2002 11:51:31 -0600
Message-Id: <200207171751.g6HHpVc07197@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: Elladan <elladan@eskimo.com>, Stevie O <stevie@qrpff.net>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Zack Weinberg <zack@codesourcery.com>, linux-kernel@vger.kernel.org
Subject: Re: close return value (was Re: [ANNOUNCE] Ext3 vs Reiserfs benchmarks)
In-Reply-To: <20020717171722.GA1352@win.tue.nl>
References: <1026867782.1688.108.camel@irongate.swansea.linux.org.uk>
	<20020716232225.GH358@codesourcery.com>
	<5.1.0.14.2.20020717001624.00ab8c00@whisper.qrpff.net>
	<20020717043853.GA31493@eskimo.com>
	<20020717171722.GA1352@win.tue.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries Brouwer writes:
> On Tue, Jul 16, 2002 at 09:38:53PM -0700, Elladan wrote:
> 
> > The question is, does the OS standard guarantee that the fd is closed,
> > even if close() returns EINTR or EIO?  Just going by the normal usage of
> > EINTR, one might think otherwise.  It doesn't appear to be documented
> > one way or another.
> > 
> > Alan said you could just issue close again to make sure - the example
> > shows that this is not the case.  A second close is either required or
> > forbidden in that example - and the behavior has to be well defined or
> > you won't know which to do.
> 
> No, the behaviour is not well-defined at all.
> The standard explicitly leaves undefined what happens when close
> returns EINTR or EIO.

However, the only sane thing to do is to explicitly define one way or
another. The standard is broken. Consider a threaded application,
where one thread tries to call close(), gets an error and re-tries,
because it's not sure if the fd was closed or not. If the fd *is*
closed, and the thread loops calling close(), checking for EBADF,
there is a race if another thread tries calling open()/creat()/dup().

The ambiguity in the standard thus results in the impossibility of
writing a race-free application. And no, forcing the application to
protect system calls with mutexes isn't a solution.

Linux should define explicitly what happens on error return from
close(). Let that be the new standard.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
