Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262887AbTJUPhH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Oct 2003 11:37:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263120AbTJUPhH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Oct 2003 11:37:07 -0400
Received: from CAT.NYU.EDU ([128.122.47.28]:55282 "EHLO cat.nyu.edu")
	by vger.kernel.org with ESMTP id S262887AbTJUPhC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Oct 2003 11:37:02 -0400
Date: Tue, 21 Oct 2003 11:36:56 -0400 (EDT)
From: Daniel Thor Kristjansson <danielk@cat.nyu.edu>
Reply-To: danielk@mrl.nyu.edu
To: Mattia Dongili <dongili@supereva.it>
Cc: linux-kernel@vger.kernel.org, cpufreq@www.linux.org.uk
Subject: Re: [PATCH] 3/3 Dynamic cpufreq governor and updates to ACPI P-state
 driver
In-Reply-To: <20031021105234.GF893@inferi.kami.home>
Message-ID: <Pine.SOL.4.53.0310211057060.6187@graphics.cat.nyu.edu>
References: <88056F38E9E48644A0F562A38C64FB60077914@scsmsx403.sc.intel.com>
 <1066725533.5237.3.camel@laptop.fenrus.com> <20031021095925.GB893@inferi.kami.home>
 <20031021101737.GA31352@wiggy.net> <20031021105234.GF893@inferi.kami.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The _user_ shouldn't set the cpu frequency hundred of times a second,
but a userland program should set the priorities. If you are just
looking at CPU Temperature and the idle loop for setting your cpu
frequency then it's fine to do it in the kernel. But if you are looking
at dozens of factors and balancing them it is much safer to do so in
userland. CPUFreq has been rearchitectured to allow this type of thing,
you can have a governor in the kernel that sets CPU Frequency based on
load within limits specified by a userland program. ACPI can meantime
throttle the CPU if it gets too hot based on what the BIOS tells you or
based on what the user tells you if you have a broken BIOS that lets the
CPU die before it thinks it's too hot.

The user may know things the kernel doesn't such as "this laptop is
burning a hole in my pants." She might want to construct a policy that
doesn't minimize power consumption since she's plugged in, but gives the
CPU lots of juice at first when the idle goes down, but then backs off
if it detects a long running 100% utilization such as during a long
compile. This would maximize responsiveness in interactive settings but
still keep her lap comfortably cool when compiling mozilla. Putting the
complexity of policies specified by something like an XML file in the
kernel scares me, putting it in a userspace program that communicates
with a low level governor is a more comforting thought.

-- Daniel

On Tue, 21 Oct 2003, Mattia Dongili wrote:

]On Tue, Oct 21, 2003 at 12:17:37PM +0200, Wichert Akkerman wrote:
]> Previously Mattia Dongili wrote:
]> > I remember Linus forcing a kernel only policy management:
]> > http://www.linux.org.uk/mailman/private/cpufreq/2002-August/000865.html
]>
]> That archive is password-protected..
]
]<QUOTE>
]
]On Wed, 28 Aug 2002, Dominik Brodowski wrote:
]>
]> The following patches add CPU frequency and volatage scaling
]> support (Intel SpeedStep, AMD PowerNow, etc.) to kernel 2.5.32
]
]The thing is, this interface appears fundamentally broken with respect to
]CPU's that change their frequency on the fly. I happen to know one such
]CPU rather well myself.
]
]What is this interface supposed to do about a CPU that can change its
]frequency dynamically several hundred times a second? Having the OS
]control it simply isn't an option - the overhead of the control is _way_
]more than is acceptable at that level.
]
]In short, this interface is too broken to be called generic.
]
]A quote from Peter Anvin:
]
]  "What is worse is that the interface is, in my opinion, fundamentally
]   broken for *ALL* CPUs.  It doesn't present a policy interface to the
]   kernel, instead it presents a frequency-setting interface and expect
]   the policy to be done in userspace.  The kernel is the only part of the
]   system which has sufficient information (idle times of all CPUs, for
]   example) to do a decent job managing the CPU frequency efficiently.
]   On Transmeta CPUs this policy should simply be passed down to CMS, of
]   course; on other CPUs the kernel needs to manage it."
]
]In other words: there is no valid way that a _user_ can set the policy
]right now: the user can set the frequency, but since any sane policy
]depends on how busy the CPU is, the user isn't even, the right person to
]_do_ that, since the user doesn't _know_.
]
]Also note that policy is not just about how busy the CPU is, but also
]about how _hot_ the CPU is. Again, a user-mode application (that maybe
]polls the situation every minute or so), simply _cannot_ handle this
]situation. You need to have the ability to poll the CPU tens of times a
]second to react to heat events, and clearly user mode cannot do that
]without impacting performance in a big way.
]
]The interface needs to be improved upon. It is simply _not_ valid to say
]"run at this speed" as the primary policy.
]
]		Linus
]
]</QUOTE>
]
]anyway there has been a full discussion regarding this issue.
]
]The result has been a major redesing of the cpufreq interface in
]accordance to Linus' statements
]
]Note: if you're subscribed to the cpufreq list you have a password to
]enter at the propmt :)
]
]ciao
]
