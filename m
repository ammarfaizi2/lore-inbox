Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131382AbRDMO5C>; Fri, 13 Apr 2001 10:57:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131386AbRDMO4n>; Fri, 13 Apr 2001 10:56:43 -0400
Received: from hq.fsmlabs.com ([209.155.42.197]:31250 "EHLO hq.fsmlabs.com")
	by vger.kernel.org with ESMTP id <S131382AbRDMO4b>;
	Fri, 13 Apr 2001 10:56:31 -0400
Date: Fri, 13 Apr 2001 08:59:27 -0600
From: yodaiken@fsmlabs.com
To: Mark Salisbury <mbs@mc.com>
Cc: yodaiken@fsmlabs.com, george anzinger <george@mvista.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: POSIX 52 53? 54
Message-ID: <20010413085927.B24060@hq.fsmlabs.com>
In-Reply-To: <3AD66F56.A827E22@mvista.com> <20010412215323.A17007@hq.fsmlabs.com> <0104130853521R.01893@pc-eng24.mc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <0104130853521R.01893@pc-eng24.mc.com>; from mbs@mc.com on Fri, Apr 13, 2001 at 08:46:14AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 13, 2001 at 08:46:14AM -0400, Mark Salisbury wrote:
> these are covered in IEEE P100.13, D9 September 1997 AD212.  it is available
> from IEEE for a "nominal" fee.
> 
> they are 4 defined subsets of POSIX that are deemed appropriate for real-time
> systems.
> 
> unfortunately, the sub in subset is a small delta from the full set.
> 
> the subsets are:
> 	PSE51: Minimal Realtime System Profile
> 	PSE52: Realtime Controller System Profile
> 	PSE53: Dedicated Realtime System Profile
> 	PSE54: Multi-purpose Realtime System Profile.
> 
> now, PSE51 is already about 90% of POSIX, so I don't really see what is so
> minimal about it.  the others require even more.

Actually PSE51 seems to me to be pretty smart which is why, even though I
swore we would never adopt the bloated, slow, POSIX standard for RTLinux,
the discovery of 1003.13 changed my mind. PSE51 says a minimal RT system
can look like a single process with "main" as the OS and with signal 
handlers and threads for applications. They note that POSIX does require
"open/close/read/write", but in PSE51, we don't need to offer POSIX file
semantics: this is actually pretty nice for us. We install interrupt
handlers with sigaction, use the thread/creation deletion and the standard
synchronization API which I have grown to semi-like. 1003.13 gets around
"fork" and such by simply adopting a "single process" semantics. According
to the standard, we gotta have "fork", but it can fail due to too many
processes (Linus hates this, but he thinks CC-NUMA scales, so ...)
Basically, PSE51 allows for a real standard API without requiring the system
to stop being hard realtime.
 And then  we have one thread as  PS54 system so we can do
	pthread_kill(linux_thread(), LINUX_IRQ +n)
to  send interrupt "n" to Linux
And Alan Cox invented a brilliant method for fault tolerance where the PSE51
system runs a watchdog thread for the OS and has a recovery thread that
does
   vulture:
        /* wait for death*/
	pthread_join(linux_thread())
	/* note that critical RT processing continues */
	generate_blue_screen("NT EMULATION MODE ON: PLEASE BE PATIENT WHILE 
                              WE RECOVER. .\n");
        pthread_create(linux_thread(),&linux_attr,restart_linux,0);
        goto vulture;

This could be implemented quite easily.

> 
> On Thu, 12 Apr 2001, yodaiken@fsmlabs.com wrote:
> > POSIX 1003.13 defines profiles 51-4 where 51 is a single POSIX
> > process with multiple threads (RTLinux) and 54 is a full POSIX OS
> > with the RT extensions (Linux).
> > 
> > On Thu, Apr 12, 2001 at 08:15:34PM -0700, george anzinger wrote:
> > > Any one know any thing about a POSIX draft 52 or 53 or 54.  I think they
> > > are suppose to have something to do with real time.
> > > 
> > > Where can they be found?  What do they imply for the kernel?
> > > 
> > > George
> > > -
> > > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > > the body of a message to majordomo@vger.kernel.org
> > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > > Please read the FAQ at  http://www.tux.org/lkml/
> > 
> > -- 
> > ---------------------------------------------------------
> > Victor Yodaiken 
> > Finite State Machine Labs: The RTLinux Company.
> >  www.fsmlabs.com  www.rtlinux.com
> > 
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> -- 
> /*------------------------------------------------**
> **   Mark Salisbury | Mercury Computer Systems    **
> **   mbs@mc.com     | System OS - Kernel Team     **
> **------------------------------------------------**
> **  I will be riding in the Multiple Sclerosis    **
> **  Great Mass Getaway, a 150 mile bike ride from **
> **  Boston to Provincetown.  Last year I raised   **
> **  over $1200.  This year I would like to beat   **
> **  that.  If you would like to contribute,       **
> **  please contact me.                            **
> **------------------------------------------------*/

-- 
---------------------------------------------------------
Victor Yodaiken 
Finite State Machine Labs: The RTLinux Company.
 www.fsmlabs.com  www.rtlinux.com

