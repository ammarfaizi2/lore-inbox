Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313509AbSDLKoc>; Fri, 12 Apr 2002 06:44:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313512AbSDLKob>; Fri, 12 Apr 2002 06:44:31 -0400
Received: from pc-62-31-92-140-az.blueyonder.co.uk ([62.31.92.140]:2232 "EHLO
	kushida.apsleyroad.org") by vger.kernel.org with ESMTP
	id <S313509AbSDLKoa>; Fri, 12 Apr 2002 06:44:30 -0400
Date: Fri, 12 Apr 2002 11:44:22 +0100
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Pavel Machek <pavel@suse.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: faster boots?
Message-ID: <20020412114422.A24021@kushida.apsleyroad.org>
In-Reply-To: <200204080048.g380mt514749@lmail.actcom.co.il> <200204080057.g380vbO00868@vindaloo.ras.ucalgary.ca> <3CB0EF0B.14D48619@zip.com.au> <20020408095717.GB27999@atrey.karlin.mff.cuni.cz> <20020408174333.A28116@kushida.apsleyroad.org> <20020408124803.A14935@redhat.com> <20020409015657.A28889@kushida.apsleyroad.org> <20020409222214.GK5148@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> > > > I've had no luck at all with noflushd on my Toshiba Satellite 4070CDT.
> > > > It would spin down every few minutes, and then spin up _immediately_,
> > > > every time.  I have no idea why.
> > > 
> > > Were you using the console?  Any activity on ttys causes device inode 
> > > atime/mtime updates which trigger disk spin ups.  The easiest way to 
> > > work around this is to run X while using devpts for the ptys.
> > 
> > I was using X, nodiratime on all /dev/hda mounts.  My friend who has the
> > small VAIO with a Crusoe chip also reports the same problem: noflushd
> > doesn't work with 2.4 kernels (versions that we tried), and the problem
> > is the same: it spins down and then spins up immediately afterward.
> 
> It works for me, 2.4.18 on HP omnibook xe3.
> 
> You may want to watch /proc/stats to see if it is read or write
> activity that wakes disk up.

It's write activity, due to atime updates.  I was using nodiratime, but
that's not good enough because every time an executable is run a load of
things are accessed.

I found it interesting that some write activity happens almost
immediately after the access -- and noflushd is connected in some way.
If I do this:

    while :; do cat /proc/stat; sleep 1; done

Then I see a few writes have occurred at nearly every iteration.  I
think that is due to the atime updates, because using "noatime" there
are no writes at most iterations.

But more interesting: I only see those few-per-second atime writes while
noflushd is running.  If I kill noflushd then they go away.

So, noflushd triggers some kind of regular write activity.  Either
killing noflushd, or mounting with "noatime", makes it go away.

I don't like "noatime" because some programs monitor
/var/spool/mail/jamie's atime to decide if there is any new mail.  But I
am using it now anyway.

With "noatime", I find the disk is able to spin down for 20 seconds.  A
record :-)  But not a very useful one.

When the disk spins up, I see both read and write activity at the same
time.  Of course I have no idea what files are triggering the spin up.
(And atime is switched off so I can't use that as a guide!)

I am a bit surprised that "noatime" makes a difference -- I thought that
if noflushd spun down a disk, then pending inode writes should be
delayed until a read or excess memory pressure forces a spin up.

So: "noatime" is definitely required, to spin the disk down for more
than an instant.  But even that is not good enough.  I have 192MB RAM,
btw.  Is that enough to expect longer spin down times than 20s?

-- Jamie
