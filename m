Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266092AbSKFUBB>; Wed, 6 Nov 2002 15:01:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266093AbSKFUBB>; Wed, 6 Nov 2002 15:01:01 -0500
Received: from probity.mcc.ac.uk ([130.88.200.94]:25352 "EHLO
	probity.mcc.ac.uk") by vger.kernel.org with ESMTP
	id <S266092AbSKFUA7>; Wed, 6 Nov 2002 15:00:59 -0500
Date: Wed, 6 Nov 2002 20:07:26 +0000
From: John Levon <levon@movementarian.org>
To: george anzinger <george@mvista.com>
Cc: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
       Mikael Pettersson <mikpe@csd.uu.se>, Ingo Molnar <mingo@elte.hu>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: NMI watchdog question.
Message-ID: <20021106200726.GA2388@compsoc.man.ac.uk>
References: <Pine.GSO.3.96.1021106192840.2684L-100000@delta.ds2.pg.gda.pl> <3DC97233.2BBD511@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DC97233.2BBD511@mvista.com>
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: Mr. Scruff - Trouser Jazz
X-Scanner: exiscan *189WSV-0001Ix-00*Vu0O7owkhH6* (Manchester Computing, University of Manchester)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 06, 2002 at 11:49:07AM -0800, george anzinger wrote:

> So the performance counters are only used on UP machines?

no. nmi_watchdog=1 -> I/O APIC is used iff available and it works
nmi_watchdog=2 -> local APIC LVTPC set to interrupt in NMI mode when
perfctr overflows.

=2 can be used on both UP and SMP, =1 is only available on UP for the
rare machines that have an I/O APIC on a UP motherboard (I believe there
are some, but I don't know if the code is set up to do so properly).

> Also, what is the point of turning off the nmi in this way
> (i.e. nmi_watchdog = 0;)?  If the interrupts are not
> generated the test of the flag will not be done in traps.c. 
> Is it tested else where?

NMIs can have other sources. In particular if we get an NMI from an
unknown source, we want to tell the user we're dazed and confused.

Currently, if we boot with nmi_watchdog=2 on SMP /and/ that io_apic.c
code sets nmi_watchdog to 0, it seems we will get an incorrect "dazed
and confused" every time the perfctr overflows (which will take a while
to overflow the full 40 bits, but ...)

[hmm, actually this would depend on exactly what order the setup is
done, I'm too lazy to check]

So I think that test definitely needs to be there, but it needs to be

	if (nmi_watchdog == NMI_IO_APIC)

as Maciej ACKed.

regards
john

-- 
"When a man has nothing to say, the worst thing he can do is to say it
memorably."
	- Calvin Trillin
