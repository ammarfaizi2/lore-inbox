Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317025AbSFQVXK>; Mon, 17 Jun 2002 17:23:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317026AbSFQVXK>; Mon, 17 Jun 2002 17:23:10 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:27917 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S317025AbSFQVXI>;
	Mon, 17 Jun 2002 17:23:08 -0400
Message-ID: <3D0E52DD.4CE57058@zip.com.au>
Date: Mon, 17 Jun 2002 14:21:33 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Russell King <rmk@arm.linux.org.uk>
CC: Martin Dalecki <dalecki@evision-ventures.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch 1/19] writeback tunables
References: <3D0D86D7.644F0C13@zip.com.au> <3D0DBAEE.2030409@evision-ventures.com> <20020617114957.A4130@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> 
> On Mon, Jun 17, 2002 at 12:33:18PM +0200, Martin Dalecki wrote:
> ...
> > > +int dirty_expire_centisecs = 30 * 100;
> > > +
> >
> > Blind guess - didn't the 100 wan't to be HZ?!
> 
> The units are centiseconds (as the name suggests). 5 * 100 centiseconds = 5
> seconds, so the dirty writeback timeout is 5 seconds.  Check the code a
> little further and you'll see HZ gets factored into them on use.
> 

Yup.  Sorry about the "_centisecs" thing.  That's a bit anal, but
I tend to think that it's best to be really explicit about the
units, make it a bit easier to use.  I don't know how many times
I've had to peer in fs/buffer.c to remember what those dang numbers do.

Possibly, "seconds" may be sufficiently high resolution for
these things.  But I wasn't sure - maybe someone wants to
run the kupdate function five times per second?  Dunno.

There are some departures from 2.4 tradition which are worth
mentioning here:

- There is no range checking on the settings.  (But a divide-by
  zero isn't possible, so I think that's OK)

- Unlike the 2.4 bdflush settings, these parameters are not
  updated in a single hit.  So if you modify them by a large
  amount while the system is under heavy writeback load, perhaps
  some whacky things will happen if you create an irrational
  intermediate state.  But that's quite unlikely.

- Unlike 2.4, the settings are scaled by HZ.  So that bdflush
  tuning tool whose name I forget will no longer make kupdate
  run ten times too fast on Alphas.

-
