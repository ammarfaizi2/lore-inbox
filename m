Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272331AbTGYVkq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jul 2003 17:40:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272334AbTGYVkp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jul 2003 17:40:45 -0400
Received: from vladimir.pegasys.ws ([64.220.160.58]:43789 "EHLO
	vladimir.pegasys.ws") by vger.kernel.org with ESMTP id S272331AbTGYVkl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jul 2003 17:40:41 -0400
Date: Fri, 25 Jul 2003 14:55:48 -0700
From: jw schultz <jw@pegasys.ws>
To: linux-kernel@vger.kernel.org
Subject: Re: Net device byte statistics
Message-ID: <20030725215548.GB25838@pegasys.ws>
Mail-Followup-To: jw schultz <jw@pegasys.ws>,
	linux-kernel@vger.kernel.org
References: <E19fqMF-0007me-00@calista.inka.de> <200307251223.51849.jeffpc@optonline.net> <20030725102043.724f4a3b.rddunlap@osdl.org> <200307251355.22161.jeffpc@optonline.net> <20030725105818.6bc97653.rddunlap@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030725105818.6bc97653.rddunlap@osdl.org>
User-Agent: Mutt/1.3.27i
X-Message-Flag: This message may contain content offensive to Atheists and servants of false gods.  Read at your own risk.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 25, 2003 at 10:58:18AM -0700, Randy.Dunlap wrote:
> On Fri, 25 Jul 2003 13:55:14 -0400 Jeff Sipek <jeffpc@optonline.net> wrote:
> 
> | -----BEGIN PGP SIGNED MESSAGE-----
> | Hash: SHA1
> | 
> | On Friday 25 July 2003 13:20, Randy.Dunlap wrote:
> | > Yes, a common solution for this is to use some SNMP agent that does
> | > 64-bit counter accumulation.
> | 
> | Interesting...I haven't thought of SNMP.
> | 
> | > IETF expects that some high-speed interfaces will have 64-bit
> | > counters.  From RFC 2233 (Interfaces Group MIB using SMIv2):
> | >
> | > <quote>
> | > For interfaces that operate at 20,000,000 (20 million) bits per
> | > second or less, 32-bit byte and packet counters MUST be used.
> | > For interfaces that operate faster than 20,000,000 bits/second,
> | > and slower than 650,000,000 bits/second, 32-bit packet counters
> | > MUST be used and 64-bit octet counters MUST be used. For
> | > interfaces that operate at 650,000,000 bits/second or faster,
> | > 64-bit packet counters AND 64-bit octet counters MUST be used.
> | > </quote>
> | 
> | It is just easier to have everything 64-bits.
> 
> I think the counterpoint is that if it were easy & safe, it would
> already be in the kernel.
> 
> | > However, this is a MIB spec.  It does not require a Linux
> | > (/proc) interface to support 64-bit counters.
> | 
> | Agreed, however if we are going to change some counters, we should do it for 
> | all of them. (Btw, /proc is not the only point where users can get stats.... 
> | there is also /sys and something else...I can't remember now...)
> 
> Right, I was just saying that the kernel interface doesn't have
> to support 64-bit counters in lots of cases.  That can often be
> done in userspace.

I've been watching this discussion for several months.  If i
may, let me summarise what i see as the salient points.

	1. Uptime is such that many 32bit counters wrap.

	2. Userspace can easily detect wrapping when
	measuring deltas.  Provided it only wraps once.

	3. Some counters can wrap at intervals so small that
	userspace cannot accurately detect the wrap without
	the monitoring tool becoming a significant system
	load.

	4. 64bit counters would be sufficient.  At least for
	most of these counters.

	6. Without atomicity the counters will have windows
	where they report garbage.  And if the code paths
	writing the counter aren't otherwise protected they
	can likewise corrupt the counter.

	5. The locking overhead needed for atomicity of
	64bit counters on 32bit architectures is excessive
	for fast-paths.

It seems to me that what is needed is a in-kernel component
that can intermediate between internal 32bit counters and
userspace-visible 64bit (or larger) counters.  This
component would need to be active often enough that the
counters don't wrap without detection and so that userspace
will see sufficiently accurate numbers.

My thought would be to use 96bits for each counter.  In-kernel
code would run periodically doing something like this:

	curval = counter.in_kernel;
			/* get it in a register for atomicity */
	if (counter.user_low < curval)
		++counter.user_high;
	counter.user_low = curval;

This code would run every N jiffies or be in a high priority
kernel thread.  As an in-kernel service it could loop over a
set of counters that have been registered with it.  If
needed you could even have user_high be larger than 32 bits.

It could even be possible to make the code accessing the
userspace counter fall-back to the kernel one if the 64bit
counter is zero.  That way registration could potentially be
userspace triggered.

This is just the acorn of an idea.  It does mean that
userspace visible counters will not have instantaneous
resolution but it seems to me that HZ should be more than
tight enough.  There are certainly other ways to achieve
this and implementation should take into account cache
effects.


-- 
________________________________________________________________
	J.W. Schultz            Pegasystems Technologies
	email address:		jw@pegasys.ws

		Remember Cernan and Schmitt
