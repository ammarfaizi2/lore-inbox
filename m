Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262373AbUCHCYw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Mar 2004 21:24:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262376AbUCHCYv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Mar 2004 21:24:51 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:59266
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S262373AbUCHCYt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Mar 2004 21:24:49 -0500
From: Rob Landley <rob@landley.net>
To: David Gibson <hermes@gibson.dropbear.id.au>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Orinoco card fails on resume with 2.6.2 (race condition?)
Date: Sun, 7 Mar 2004 18:01:15 -0600
User-Agent: KMail/1.5.4
References: <200402251436.15740.rob@landley.net> <20040304094555.C6052@flint.arm.linux.org.uk> <20040308002051.GA10554@zax>
In-Reply-To: <20040308002051.GA10554@zax>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200403071801.15688.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 07 March 2004 18:20, David Gibson wrote:
> Sorry I've been slow to reply - still catching up from three weeks
> away.

I'm traveling around the country myself.

> On Thu, Mar 04, 2004 at 09:45:55AM +0000, Russell King wrote:
> > On Wed, Feb 25, 2004 at 02:36:15PM -0600, Rob Landley wrote:
> > > Attached are a dmesg log from my laptop resuming after a software
> > > suspend with a stock 2.6.2 kernel, and the config that 2.6.2 kernel was
> > > compiled with.
> >
> > I guess we need the orinoco people to comment on this; although I seem
> > to look after the 2.6 PCMCIA _core_, I certainly do not look after
> > PCMCIA driver issues.
> >
> > David - can you provide any insight?
>
> Um... not a lot, I'm afraid.  A "Timeout waiting for command
> completion" usually indicates a low-level problem, the registers not
> responding at all, for example.  On the other hand we do seem to be
> getting some interrupts and correctly processing linkstatus frames
> before it all falls over, so it doesn't look like a complete failure
> of the low-level stuff to re-activate the card on resume.

Well, thanks for the attempt.

Hmmm...  I don't _think_ the software suspend logic is likely to snapshot any 
strange timer state, but I dunno.  On resume, the system goes into a swap 
frenzy trying to get everything back in.  (This thinkpad can only hold 192 
megabytes of ram, and as far as I can tell Konqueror never actually frees any 
memory it allocates, so I'm usually about halfway into swap.)  So if there's 
any possibility of the world's strangest race condition occurring on resume, 
this thing could probably trigger it.  My suspend script is just:

#!/bin/sh

sync
#echo -n disk > /sys/power/state
echo 4 > /proc/acpi/sleep
hwclock --hctosys
# rdate -s clock.psu.edu
dhclient eth0

> > > Usually after resume the network is back and happy, but this time it
> > > went "boing".  Specifically:
>
> A race condition in the re-initialization logic is plausible - the
> locking around there is very hairy - and would jibe with this
> observation.

The odd part is that dhclient thought it had negotiated a connection before 
the wireless card decided to curl up and die.  Too bad the card couldn't 
either start over initializing the sucker again, or at least print a stack 
trace of where it to confused...

I'll let you know if it happens again.  That's the...  second or third time 
I've seen it in the past four or five months.  (It happens.  Just not often 
enough to determine a pattern.)

Rob

