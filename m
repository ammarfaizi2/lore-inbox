Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262228AbVAZDgB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262228AbVAZDgB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 22:36:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262237AbVAZDgA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 22:36:00 -0500
Received: from gate.crashing.org ([63.228.1.57]:3020 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262228AbVAZDfu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 22:35:50 -0500
Subject: Re: [RFC][PATCH] new timeofday arch specific hooks (v. A2)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Christoph Lameter <clameter@sgi.com>
Cc: john stultz <johnstul@us.ibm.com>, lkml <linux-kernel@vger.kernel.org>,
       Tim Schmielau <tim@physik3.uni-rostock.de>,
       George Anzinger <george@mvista.com>, albert@users.sourceforge.net,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>,
       Dominik Brodowski <linux@dominikbrodowski.de>,
       David Mosberger <davidm@hpl.hp.com>, Andi Kleen <ak@suse.de>,
       Paul Mackerras <paulus@samba.org>, schwidefsky@de.ibm.com,
       keith maanthey <kmannth@us.ibm.com>, Patricia Gaughen <gone@us.ibm.com>,
       Chris McDermott <lcm@us.ibm.com>, Max Asbock <amax@us.ibm.com>,
       mahuja@us.ibm.com, Nishanth Aravamudan <nacc@us.ibm.com>,
       Darren Hart <darren@dvhart.com>, "Darrick J. Wong" <djwong@us.ibm.com>,
       Anton Blanchard <anton@samba.org>
In-Reply-To: <Pine.LNX.4.58.0501251620100.27922@schroedinger.engr.sgi.com>
References: <1106607089.30884.10.camel@cog.beaverton.ibm.com>
	 <1106607153.30884.12.camel@cog.beaverton.ibm.com>
	 <1106620134.15850.3.camel@gaston>
	 <1106694561.30884.52.camel@cog.beaverton.ibm.com>
	 <1106697227.5235.28.camel@gaston>
	 <1106698655.1589.8.camel@cog.beaverton.ibm.com>
	 <Pine.LNX.4.58.0501251620100.27922@schroedinger.engr.sgi.com>
Content-Type: text/plain
Date: Wed, 26 Jan 2005 14:29:05 +1100
Message-Id: <1106710145.5235.47.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-01-25 at 16:34 -0800, Christoph Lameter wrote:

> I just hope that the implementation of one arch does not become a standard
> without sufficient reflection. Could we first get an explanation of
> the rationale of the offsets? From my viewpoint of the ia64 implementation
> I have some difficulty understanding why such complicated things as
> prescale and postscale are necessary in gettimeday and why the simple
> formula that we use in gettimeofday is not sufficient?

What is complicated here ? The formula, at least as we do on ppc64, is
simply:

 time = (hw_value - prescale offset) / scale + post scale offset

Please, don't tell me that a substraction bothers you for performances,
and this first offset, while it could maybe be "folded" into the second
one, is actually handy, especially since it allows you to keep the
(hw_value - prescale offset) in a 32 bits number if your HW timebase
isn't too fast.

Now, for the details, on ppc, we calculate time in what we call "xsecs"
which is 2^20 xsec/sec, so not exactly micro or nanoseconds, but that's
also for simplifying calculations, we may want the generic code to just
fallback on to ns.
  
> Frankly, the direction that the design of the new time subsystem is
> taking is bothering me. Work on this on our part would just improve the
> situation from drastically worse performance to somewhat worse. So far I
> have not seen a benefit of moving away from the existing code base. For
> the project to make sense it needs at least to be evident that the design
> of the solution would lead to better timer performance in the long run.
> Conceptually that seems so far not to be possible.

The main problem with performances in the new code is the fact that it
does the ntp correction on every call. John is aware that it is a
problem and will fix that.

> I'd love simplication of the timer subsystem through the use of
> nanosecond offsets. However, the POSIX api always has extra fields
> for seconds and nanoseconds and converting back and forth between the
> internal representation in 64bit nanoseconds and the POSIX structures may
> be another performance penalty since it involves divisions and remainder
> processing.
> 
> What I think is a priority need is some subsystem that manages
> time sources effectively (including the ability of the ntp code to
> scale the appropriately) and does that in an arch independent
> way so that all the code can be consolidated. Extract the best existing
> solutions and work from there.

Which is what John is trying to do, so help instead of criticizing :)

Ben.


