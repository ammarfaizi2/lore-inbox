Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030332AbVIVN3u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030332AbVIVN3u (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 09:29:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030315AbVIVN3u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 09:29:50 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:30217 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1030299AbVIVN3t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 09:29:49 -0400
Date: Thu, 22 Sep 2005 14:29:41 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Mark Lord <liml@rtr.ca>, Richard Purdie <rpurdie@rpsys.net>,
       LKML <linux-kernel@vger.kernel.org>,
       Dominik Brodowski <linux@dominikbrodowski.net>, bzolnier@gmail.com,
       linux-ide@vger.kernel.org
Subject: Re: [RFC/BUG?] ide_cs's removable status
Message-ID: <20050922132941.GA26438@flint.arm.linux.org.uk>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Mark Lord <liml@rtr.ca>, Richard Purdie <rpurdie@rpsys.net>,
	LKML <linux-kernel@vger.kernel.org>,
	Dominik Brodowski <linux@dominikbrodowski.net>, bzolnier@gmail.com,
	linux-ide@vger.kernel.org
References: <1127319328.8542.57.camel@localhost.localdomain> <1127321829.18840.18.camel@localhost.localdomain> <433196B6.8000607@rtr.ca> <1127327243.18840.34.camel@localhost.localdomain> <20050921192932.GB13246@flint.arm.linux.org.uk> <1127347845.18840.53.camel@localhost.localdomain> <20050922102221.GD16949@flint.arm.linux.org.uk> <1127396382.18840.79.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1127396382.18840.79.camel@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 22, 2005 at 02:39:42PM +0100, Alan Cox wrote:
> On Iau, 2005-09-22 at 11:22 +0100, Russell King wrote:
> > If you have a CF adapter which behaves as you describe above, could
> > you please check what happens as far as PCMCIA goes when you unplug
> > the CF card - particularly what happens to cardctl status / cardctl
> > ident ?
> 
> If I remove the CF card I get garbage reported. I don't however get a
> card plug/unplug event.

That's interesting, because PCMCIA caches the CIS data and only
invalidates the CIS cache when an unplug event is seen.  I assume
the whole lot isn't garbage, just some parts of it?

> On the other card I have I get a card plug/unplug event.

Using the same CF card with these two adapters, do you get differing
CIS data?  Can you post the entire CIS data from both using dump_cis
please?

I'm wondering if your first adapter is somehow "inteligent" and isn't
operating the CF card in "PCMCIA" mode.  If this is the case, PCMCIA
should be more inteligent about it than it currently is - telling IDE
that the media is replaceable when the interface is registered.


There is another concern I have in all this, one which seems to have
been completely missed.  Yes we do this partition rescanning each time
a "removable" IDE device is opened, but do we re-read the identity?
I'm asking this because what happens if you replace a 64MB CF card
with a 256MB CF card in your first adapter?  Do we assume that it's
still a 64MB CF card with weird partitions?

> The pcmcia ide floppy (40MB clik! drive if anyone
> wants to play) I have always shows up as present. It triggers the same
> hotplug behaviour being complained about as far as I can see and
> correctly so.

Not having a clik drive, but "ide floppy" sounds like standard floppy
behaviour - the "other" class of hotplug where the media is replaceable
independent of the controller itself, so this is a slightly different
problem, and one which we handle correctly.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
