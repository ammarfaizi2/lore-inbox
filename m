Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317944AbSGQH46>; Wed, 17 Jul 2002 03:56:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318239AbSGQH45>; Wed, 17 Jul 2002 03:56:57 -0400
Received: from bart.one-2-one.net ([217.115.142.76]:50436 "EHLO
	bart.webpack.hosteurope.de") by vger.kernel.org with ESMTP
	id <S317944AbSGQH4w>; Wed, 17 Jul 2002 03:56:52 -0400
Date: Wed, 17 Jul 2002 10:02:39 +0200 (CEST)
From: Martin Diehl <lists@mdiehl.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Filip Van Raemdonck <filipvr@xs4all.be>, linux-kernel@vger.kernel.org,
       fischer@norbit.de, Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: [PATCH] aha152x fix
In-Reply-To: <1026860430.1688.95.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.21.0207170156360.6083-100000@notebook.diehl.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 17 Jul 2002, Alan Cox wrote:

> On Tue, 2002-07-16 at 22:10, Filip Van Raemdonck wrote:
> > Hi,
> > 
> > I upgraded from 2.4.19-pre7 to -rc1 and this resulted in my aha152x card not
> > working anymore. (The error was "trying software interrupt, lost")
> > 
> > Below is a patch which makes it work again. Note that this is just reverting
> > a minimal part of the last applied patch to aha152x.c; so this may only be
> > fixing the symptom and not the problem.
> > 
> > Can somebody confirm if this is correct or not, and give some more insight
> > into this behaviour?
> 
> I've seen reports but not figured out what is going on yet. Are you

AFAICT, the patch which went into 2.4.19-pre10 (looks like a 2.5 backport)
removed the release/re-acquire of the io_request_lock with interrupts off
around a mdelay(1000) while the scsi_host->detect method probes for 
interrupts. The identical code (i.e. with the unlock/lock removed) works
with 2.5.

Apparently the io_request_lock policy was changed in 2.5 and
aha152x_detect() is called without io_request_lock taken - in contrast to
2.4. However, the aha152x_detect strategy depends on some status change
driven by interrupt completion which doesn't happen when the lock is still
acquired by the caller - hence the interrupt appears to be lost.

Well, I'm definetely not the one to judge what's really correct here, but
my impression is, if the detect() is called with io_request_lock held and
interrupts off it wouldn't be allowed to release it down there. OTOH it
was there before and the driver used to work this way - in contrast to the
2.4.19-pre10 and later 2.4 which isn't working at all.

> using an AHA152x or the PCMCIA version ?

I can confirm Filip's patch putting back in place the old unlock/lock
makes things working again. Tested with an AVA1505AE (ISA, configured to
non-pnp fixed irq/io) on UP box running SMP kernel.

Therefore if you ask me, my vote would be to put this back in for
2.4.19-final until we have a better solution.

Martin

