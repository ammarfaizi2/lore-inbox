Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262234AbVAYXM4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262234AbVAYXM4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 18:12:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262241AbVAYXM0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 18:12:26 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:42932 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S262232AbVAYXJg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 18:09:36 -0500
Subject: Re: [RFC][PATCH] new timeofday arch specific hooks (v. A2)
From: john stultz <johnstul@us.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: lkml <linux-kernel@vger.kernel.org>,
       Tim Schmielau <tim@physik3.uni-rostock.de>,
       George Anzinger <george@mvista.com>, albert@users.sourceforge.net,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>,
       Christoph Lameter <clameter@sgi.com>,
       Dominik Brodowski <linux@dominikbrodowski.de>,
       David Mosberger <davidm@hpl.hp.com>, Andi Kleen <ak@suse.de>,
       Paul Mackerras <paulus@samba.org>, schwidefsky@de.ibm.com,
       keith maanthey <kmannth@us.ibm.com>, Patricia Gaughen <gone@us.ibm.com>,
       Chris McDermott <lcm@us.ibm.com>, Max Asbock <amax@us.ibm.com>,
       mahuja@us.ibm.com, Nishanth Aravamudan <nacc@us.ibm.com>,
       Darren Hart <darren@dvhart.com>, "Darrick J. Wong" <djwong@us.ibm.com>,
       Anton Blanchard <anton@samba.org>
In-Reply-To: <1106620134.15850.3.camel@gaston>
References: <1106607089.30884.10.camel@cog.beaverton.ibm.com>
	 <1106607153.30884.12.camel@cog.beaverton.ibm.com>
	 <1106620134.15850.3.camel@gaston>
Content-Type: text/plain
Date: Tue, 25 Jan 2005 15:09:21 -0800
Message-Id: <1106694561.30884.52.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-01-25 at 13:28 +1100, Benjamin Herrenschmidt wrote:
> On Mon, 2005-01-24 at 14:52 -0800, john stultz wrote:
> > All,
> > 	This patch implements the minimal architecture specific hooks to enable
> > the new time of day subsystem code for i386, x86-64, and ppc64. It
> > applies on top of my linux-2.6.11-rc1_timeofday-core_A2 patch and with
> > this patch applied, you can test the new time of day subsystem. 
> > 
> > 	Basically it adds the call to timeofday_interrupt_hook() and cuts alot
> > of code out of the build via #ifdefs. I know, I know, #ifdefs' are ugly
> > and bad, and the final patch will just remove the old code. For now this
> > allows us to be flexible and easily switch between the two
> > implementations with a single define. Also it makes the patch a bit
> > easier to read.
> 
> I haven't seen your other patch. Do you mean that with this patch, ppc64
> stops using it's own gettimeofday implementation based on the CPU
> hardware timebase ?

Not quite. It still uses the hardware timebase, but we use a common
infrastructure to calculate time. I believe you'll find the common code
similar to the current ppc64 time code, as it seemed to be one of the
better timeofday implementations (oh the joy of sane hardware time
devices).

> There are reasons why I plan to keep that. First, our implementation is
> very efficient. It allows a timeofday computation without locks or
> barriers thanks to carefully hand crafted data dependencies in the
> operation. 

The performance is a concern, and right now there are issues (ntp_scale
being the top of the list) however I hope they can be resolved. Looking
at ppc64's do_gettimeofday() vs this implementation there we do have
more overhead, but maybe you could suggest how we can avoid some of it?


> Second, we have an ABI issue here. For historical reasons, we
> have this "systemcfg" data structure that can be mmap'ed to userland,
> and which contains copy of some of the ppc64 internal time keeping
> infos. Some userland stuff use it to implement a fully userland
> gettimeofday (again, without barrier nor locks). This is done at least
> by IBM's JVM. My still-to-be-merged vDSO patch will also use this for
> the userland implementation of gettimeofday syscall itself.

I still want to support vsyscall gettimeofday, although it does have to
be done on an arch-by-arch basis. It's likely the systemcfg data
structure can still be generated and exported. I'll look into it and see
what can be done.

thanks
-john


