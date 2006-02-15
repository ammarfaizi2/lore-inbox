Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751218AbWBOSUm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751218AbWBOSUm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 13:20:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751221AbWBOSUm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 13:20:42 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:45211
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S1751218AbWBOSUl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 13:20:41 -0500
From: Rob Landley <rob@landley.net>
To: Olivier Galibert <galibert@pobox.com>
Subject: Re: Device enumeration (was Re: CD writing in future Linux (stirring up a hornets' nest))
Date: Wed, 15 Feb 2006 13:19:27 -0500
User-Agent: KMail/1.8.3
Cc: linux-kernel@vger.kernel.org
References: <43D7C1DF.1070606@gmx.de> <200602141924.22965.rob@landley.net> <20060215165549.GC516@dspnet.fr.eu.org>
In-Reply-To: <20060215165549.GC516@dspnet.fr.eu.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602151319.28024.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 15 February 2006 11:55 am, Olivier Galibert wrote:
> On Tue, Feb 14, 2006 at 07:24:22PM -0500, Rob Landley wrote:
> > I'm torn between "nuts to alsa", pointing out that "ln -s /dev /dev/snd"
> > should shut it up nicely, and thinking up a way to actually do what it
> > wants.
> >
> > If there's a real need for subdirectories, I'm sure we can come up with a
> > way to shunt stuff into them.  (Of course a shellout could do it, but if
> > it's common enough we could build something into mdev...)
> >
> > The easy one's the symlink, assuming there are no name collisions
> > flinging everything into one directory...
>
> Let's see, on a recent kernel and recent udev I have as directories
> under /dev:
>
> - disk, a pure udev creation, so no conflict there
> - loop, devices names under that are numeric.  mount has /dev/loop%d
>   and /dev/loop/%d hardcoded

I just downloaded 2.6.13-rc3 and built it.  That has:

/sys/block/{loop0,loop1,loop2,loop3,loop4,loop5,loop6,loop7}

And those are the names mdev would use.  Turning /dev/loop# into /dev/loop/# 
has to be some kind of udev filter in the config file.

There are no duplicate dev nodes in /sys right now.  Check for yourself.  Grab 
all the names mdev would use:

find /sys -name dev | sed -e 's@^/sys/.*/\(.*\)/dev@\1@'

And then pipe that to sort | uniq -d

No hits on my ubuntu "flatulent badger" system.  I'm not saying there won't be 
any, I haven't tried plugging in a few usb memory keys and such.  (But it 
shouldn't be an overwhelming problem.  We could keep just the first one, 
stick a #2 on the second one...  I'll worry about it when it crops up.)

> - bus/usb, this one collides with itself if flattened
> - snd/sound, names except for seq and timer are pretty much line
>   noise.  "timer" is scary though.
> - net with tun and (I think) tap.
> - pktcdvd with "control", not sure what tool uses it
> - misc is ok (they're all ex-/dev/xx devices)
> - video1394, dv1394, i2c with '0' as device name
> - dri with card%d
> - cpu which self-collides too
> - input with a potentially dangerous event%d

Don't look at the output of udev.  Look at the contents of /sys.

> So, well, I think you're going to need directories for usb and cpu
> without doubt, and some of the rest is potentially risky, long-term
> wise.

The current way sys handles things like "loop0" is to call it "loop0" rather 
than having a "loop" subdirectory with "0" under it.  If they changed that:

A) I'd whimper on the list and make puppy eyes.
B) I could turn loop/0 back into "loop0" if I had to.  Not too hard to do 
mechanically...

>   OG.

Rob
-- 
Never bet against the cheap plastic solution.
