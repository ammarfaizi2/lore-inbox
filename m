Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262633AbTELTaV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 15:30:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262636AbTELTaV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 15:30:21 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:56230 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262633AbTELTaQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 15:30:16 -0400
Date: Mon, 12 May 2003 21:42:45 +0200
From: Jens Axboe <axboe@suse.de>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: "Mudama, Eric" <eric_mudama@maxtor.com>, Oleg Drokin <green@namesys.com>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Oliver Neukum <oliver@neukum.org>,
       lkhelp@rekl.yi.org, linux-kernel@vger.kernel.org
Subject: Re: 2.5.69, IDE TCQ can't be enabled
Message-ID: <20030512194245.GG17033@suse.de>
References: <785F348679A4D5119A0C009027DE33C102E0D31D@mcoexc04.mlm.maxtor.com> <20030512193509.GB10089@gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030512193509.GB10089@gtf.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 12 2003, Jeff Garzik wrote:
> On Mon, May 12, 2003 at 01:19:36PM -0600, Mudama, Eric wrote:
> > >You are ignoring the host side of things. PATA TCQ is basically
> > >unsupportable without some hardware support (auto-poll). It's my
> > >understanding that all SATA controllers do that.
> > 
> > The drive is always supposed to generate an interrupt when it sets the
> > service bit indicating it is ready to receive a service command.
> > 
> > The release interrupt tells the host the drive is doing a bus release
> > following a queued data command.
> > 
> > The service interrupt tells you you're going DRQ after receiving the service
> > command.
> 
> Most Linux people with TCQ drives seem to have Hitachi (nee IBM)
> ones AFAICS.  These do not have a service interrupt (or at least,
> do not report such)

Nonsense, it supports the service interrupt just fine. It will just
complain if you try to turn it off, iirc.

> They do have the release interrupt.

Which we don't use. To be interesting, you need to speculatively turn on
the dma engine for each command you want to start. If you don't do that,
then it's faster just to poll for release/no-release at command start
time.

You should probably read ide-tcq to see what we do :-)

> > >Then there's the debate of whether TCQ is worth it at all, in general. I
> > >feel that a few tags just to minimize the time spent when ending a
> > >request to starting a new one is nice.
> > 
> > TCQ shouldn't benefit writes significantly from a performance perspective if
> > the drive is reasonably smart.  TCQ *will* have a huge performance
> > improvement for random reads since the drive can order responses based on
> > minimal rotational latency.
> 
> You hit the nail on the head.
> 
> With the host interface limitation of a single scatterlist
> particularly, writes do not benefit very much at all.  However,
> since reads can be queued and buffered internally in the drive,
> TCQ will definitely show benefits.

I don't think the multiple pending _and_ active is that big a deal, and
besides _everybody_ uses write back caching on IDE which makes TCQ for
writes very uninteresting.

> Coming from an OS perspective, I think we really want to be able to
> queue up a bunch of scatterlists, like the new AHCI spec does.

I have to agree with Eric that the largest win is potentially not
getting hit by the rotational latency all the time. I don't think you'll
get much extra from actually having more than one active from the dma
POV.

-- 
Jens Axboe

