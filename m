Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267781AbUBRSdu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 13:33:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267783AbUBRSdu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 13:33:50 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:65483
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S267781AbUBRSdr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 13:33:47 -0500
Date: Wed, 18 Feb 2004 19:33:38 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Stefan Seyfried <seife@suse.de>
Cc: linux-kernel@vger.kernel.org, Rusty Russell <rusty@rustcorp.com.au>,
       viro@parcelfarce.linux.theplanet.co.uk, Andrew Morton <akpm@osdl.org>
Subject: Re: [Bug 34473] hwinfo hangs on rmmod
Message-ID: <20040218183338.GL4478@dualathlon.random>
References: <20040211184532.34473.seife@suse.de> <20040218170830.F24A61D38B@bugzilla.suse.de> <20040218174258.GG4938@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040218174258.GG4938@suse.de>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[ CC-ed back to l-k with Stefan's permission ]

On Wed, Feb 18, 2004 at 06:42:58PM +0100, Stefan Seyfried wrote:
> direct because of the cc list of bugzilla ;-)
> 
> On Wed, Feb 18, 2004 at 06:08:30PM +0100, bugzilla-daemon@suse.de wrote:
> 
> > btw, Al Viro, prefers parport to be fixed instead, however without this fix to
> > the core module locking other kernel modules can show the same problem. Not sure
> > if we should take the risk of having other modules hanging in rmmod and fix only
> > parport, or if we should apply this fix which fixes all the modules at the same
> > time.
> 
> i _believe_ i have seen rmmod hangs before on my first 2.6 tests and not only
> with parport but also with sound (iirc), but this is a long time ago and 
> i can't remember recent failures.
> 
> I just had this deja-vu with "every process that accesses /proc/modules hangs
> in state D" :-)

yes, the symptom is the same one, if you see rmmod in D state and
everything hangs reading /proc/modules you run into this exact deadlock,
I exclude it's another bug leading to the same symptom.  You'll also
find a modprobe in D state (that's because it's trying to read from
/proc/modules)

> 
> So i have no opinion on this, i just reported the bug.

the critical info that you provided here (and the reason I wanted to
CC it back to l-k and Rusty and Al) is that it happend with other
modules too. I think very few people are running rmmod (not to tell now
there's an option to even forbid rmmod as a whole). hwinfo is one of the
few things doing rmmod and that's how it triggered the parport deadlock,
or we would not notice it. So it's hard to tell from my part how many of
the thousands kernel modules have this problem. Ideally a checker could
find any potential offender (it doesn't need to be an extremely smart
checker, false positives would be ok, but it needs at least some basic C
knowledge on calls to avoid any false negative). without a checker
giving some estimate I'm not very willing to drop my fix.

BTW, the new options in the module code sounds a bit overkill, I don't
see why there should be a kernel limitation for rmmod, I'd rather add an
userspace flag somewhere in modutils.conf to disable rmmod from
userspace so you don't have to recompile the kernel, at most it could be
a sysctl, nobody can ever ship kernels with rmmod disabled at compile
time anyways so it's pretty worthless.

Disabling modules at all at compile time, is an enterely different
matter, that's needed for super-security, not even a
write-once-then-readonly sysctl would be as safe as disabling modules
completely at compile time, since it would be too easy to sneak into
/dev/kmem and reset the sysctl, while if the code is not there, nobody
can use it.
