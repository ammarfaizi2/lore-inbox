Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161465AbWHDVJQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161465AbWHDVJQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 17:09:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161466AbWHDVJQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 17:09:16 -0400
Received: from static-ip-62-75-166-246.inaddr.intergenia.de ([62.75.166.246]:28294
	"EHLO bu3sch.de") by vger.kernel.org with ESMTP id S1161465AbWHDVJQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 17:09:16 -0400
From: Michael Buesch <mb@bu3sch.de>
To: moreau francis <francis_moreau2000@yahoo.fr>
Subject: Re: [HW_RNG] How to use generic rng in kernel space
Date: Fri, 4 Aug 2006 23:08:24 +0200
User-Agent: KMail/1.9.1
References: <20060804130030.90361.qmail@web25805.mail.ukl.yahoo.com>
In-Reply-To: <20060804130030.90361.qmail@web25805.mail.ukl.yahoo.com>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200608042308.24421.mb@bu3sch.de>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 04 August 2006 15:00, moreau francis wrote:
> Michael Buesch wrote:
> > The dataflow is as follows:
> 
> > HW-RNG -> userspace RNGD (through /dev/hwrng) -> the daemon
> > checks it for sanity and puts it back into the kernel through
> > /dev/random -> Your driver gets the data from the /dev/random
> > entropy pools.
> 
> Is that also true for embedded systems ? I mean we may not found
> any rngd on these systems.

Yes, I think so.

> One other question now: suppose that others drivers need to use
> random data during their inits. At this time userspace appli still not
> have been started. How does it work ?
> 
> > This is very neccesary, because your HW-RNG may fail and
> > so you may unintentionally use non-random data, if you use
> > the random data from the RNG directly.
> > The data _must_ go through userspace rngd, which does FIPS
> > sanity checks on the data.
> 
> Well I'm working on a secure SOC which have a randown hardware
> which is supposed to return true random data. I understand that 
> some self tests on the random data are needed but doing them in 
> userspace is suprising.

The whole purpose of the hrwng subsystem is to give userspace
an interface to the RNG device. Not more and not less.

So, if you have a special hwrng on your embedded board and you
have some special driver in that board, why not interface
directly from the driver to the hwrng-driver?
This is all pretty special case.
In the hwrng-driver you could still additionally do a
hrwng_register() to export the functionality to
userspace, though.


I am not a friend of a direct in-kernel hwrng access interface,
because it may return crap data by definition. Many (all current)
RNG devices may fail and return non-random data. If that's happily
used by some in-kernel user by the interface, we are screwed.

Why can't you build your random-data consumer as module and load
it later, when random data is available (and was carefully checked
by various tests in rngd)?

-- 
Greetings Michael.
