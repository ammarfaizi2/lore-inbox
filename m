Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318355AbSHUQH7>; Wed, 21 Aug 2002 12:07:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318356AbSHUQH7>; Wed, 21 Aug 2002 12:07:59 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:38480 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S318355AbSHUQH6>; Wed, 21 Aug 2002 12:07:58 -0400
Date: Wed, 21 Aug 2002 18:13:17 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Mikael Pettersson <mikpe@csd.uu.se>, john stultz <johnstul@us.ibm.com>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>, Leah Cunningham <leahc@us.ibm.com>,
       wilhelm.nuesser@sap.com, paramjit@us.ibm.com, msw@redhat.com
Subject: Re: [PATCH] tsc-disable_B9
Message-ID: <20020821161317.GI1117@dualathlon.random>
References: <1028771615.22918.188.camel@cog> <1028812663.28883.32.camel@irongate.swansea.linux.org.uk> <1028860246.1117.34.camel@cog> <20020815165617.GE14394@dualathlon.random> <1029496559.31487.48.camel@irongate.swansea.linux.org.uk> <15708.64483.439939.850493@kim.it.uu.se> <20020821131223.GB1117@dualathlon.random> <1029939024.26425.49.camel@irongate.swansea.linux.org.uk> <20020821143323.GF1117@dualathlon.random> <1029942115.26411.81.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1029942115.26411.81.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.3.27i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 21, 2002 at 04:01:55PM +0100, Alan Cox wrote:
> On Wed, 2002-08-21 at 15:33, Andrea Arcangeli wrote:
> > But silenty breaking apps and not allowing in any way to apps to learn
> > if the tsc is returning random or if it's returning something
> > significant (I understand that's the way you did it in -ac) is a no-way
> > by default IMHO.
> 
> All such apps and libraries are already broken have been silently broken
> since about 1999 and will continue to be broken. Thats been true since
> speedstep cpus appeared if not before.

certainly fair enough argument in theory, but in practice you're not
going to risk running those apps in a laptop or in general with any
power management that will decrease the frequency of the cpu anytime.
Also the change in frequency wouldn't generate non monothone results,
still the app may malfunction but going backwards or with an huge error
is more likely to be erronic for the tsc users than just the decrease of
frequency.

Furthmore the speedstep right now today can crash any laptop that boots
at reduced mhz and that switches to higher mhz at runtime, that change
of the tsc frequency simply make udelay run faster, and it'll break
drivers easily. I suspect there's even an unfixable race condition in
the speedstep hardware since it's not the kernel asking for the change
of frequency (at least when not using ACPI), so the change of frequency
when you plugin power may happen right before the start of udelay, we
may have irq disabled and the udelay will take less without a chance to
recalbirate delays.

Returning to our tsc issue, these "broken apps since 1999" may now
run run silenty on these numa machines that obviously cannot provide any
significant info via the tsc to userspace, and there's no way to know
that your app isn't breaking because of numa, unless you disable the tsc
to userspace.

Feel free to argue further but that won't change the fact you will never
know if your apps is getting confused or not if you don't disable the
tsc and you don't let it get the instruction fault. it is just
impossible with -ac (hmm, ok you could objdump all the binaries and libs
and hope there's no self modyfing code :)

And following your argument that these apps have been silenty broken
since 1999, if there's no broken app out there, nobody will ever get the
instruction fault. If there's any app broken out there we probably like
to know.

Infact following your argument of "broken apps since 1999" we should
disable the tsc on every machine out there, not only on the numa,
lefting a backdoor via prctl or sysctl to allow the profiling. And we
should bug at boot if we notice the cpu isn't at max frequency to avoid
the speedstep instability (but that's another issue).

Andrea
