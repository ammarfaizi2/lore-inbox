Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272371AbTGYWhF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jul 2003 18:37:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272372AbTGYWhF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jul 2003 18:37:05 -0400
Received: from mta4.srv.hcvlny.cv.net ([167.206.5.10]:51094 "EHLO
	mta4.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id S272371AbTGYWhA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jul 2003 18:37:00 -0400
Date: Fri, 25 Jul 2003 18:51:55 -0400
From: Jeff Sipek <jeffpc@optonline.net>
Subject: Re: Net device byte statistics
In-reply-to: <20030725215548.GB25838@pegasys.ws>
To: jw schultz <jw@pegasys.ws>, linux-kernel@vger.kernel.org
Message-id: <200307251852.03441.jeffpc@optonline.net>
MIME-version: 1.0
Content-type: Text/Plain; charset=iso-8859-1
Content-transfer-encoding: 7BIT
Content-disposition: inline
Content-description: clearsigned data
User-Agent: KMail/1.5.2
References: <E19fqMF-0007me-00@calista.inka.de>
 <20030725105818.6bc97653.rddunlap@osdl.org> <20030725215548.GB25838@pegasys.ws>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Friday 25 July 2003 17:55, jw schultz wrote:
> I've been watching this discussion for several months.  If i
> may, let me summarise what i see as the salient points.
>
> 	1. Uptime is such that many 32bit counters wrap.
>
> 	2. Userspace can easily detect wrapping when
> 	measuring deltas.  Provided it only wraps once.
>
> 	3. Some counters can wrap at intervals so small that
> 	userspace cannot accurately detect the wrap without
> 	the monitoring tool becoming a significant system
> 	load.

Exactly, this is why I think that we should make the counters 64-bits right 
now, so that we don't have to worry about them later - when it will be 
required to have them 64-bits long.

> 	4. 64bit counters would be sufficient.  At least for
> 	most of these counters.
>
> 	6. Without atomicity the counters will have windows
> 	where they report garbage.  And if the code paths
> 	writing the counter aren't otherwise protected they
> 	can likewise corrupt the counter.
>
> 	5. The locking overhead needed for atomicity of
> 	64bit counters on 32bit architectures is excessive
> 	for fast-paths.

Per cpu variables with global overflow seem to be the way to go (at least for 
the network statistics.)

> It seems to me that what is needed is a in-kernel component
> that can intermediate between internal 32bit counters and
> userspace-visible 64bit (or larger) counters.  This
> component would need to be active often enough that the
> counters don't wrap without detection and so that userspace
> will see sufficiently accurate numbers.

Very interesting, the same thing that "was supposed to be done" in user space, 
but modular and in the kernel itself...I am impressed.

> My thought would be to use 96bits for each counter.  In-kernel
> code would run periodically doing something like this:
>
> 	curval = counter.in_kernel;
> 			/* get it in a register for atomicity */
> 	if (counter.user_low < curval)
> 		++counter.user_high;
> 	counter.user_low = curval;
>
> This code would run every N jiffies or be in a high priority
> kernel thread.  As an in-kernel service it could loop over a
> set of counters that have been registered with it.  If
> needed you could even have user_high be larger than 32 bits.
>
> It could even be possible to make the code accessing the
> userspace counter fall-back to the kernel one if the 64bit
> counter is zero.  That way registration could potentially be
> userspace triggered.
>
> This is just the acorn of an idea.  It does mean that
> userspace visible counters will not have instantaneous
> resolution but it seems to me that HZ should be more than
> tight enough.  There are certainly other ways to achieve
> this and implementation should take into account cache
> effects.

Overall, great idea! 

We basically have a choice:

- - 32-bit counters with overflows every 4GB and instantenious (sp?) stats
- - 64-bit counters with overflows every 16PB and possibility of stats being off 
a bit

Jeff.

- -- 
*NOTE: This message is ROT-13 encrypted twice for extra protection*
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/IbSPwFP0+seVj/4RAgpoAKCZm4eswdJ+iPJZdsvlhUGXyfJZYACfVwyl
4dIfHzaufhuGSMFt2ZDd5Vg=
=iVm4
-----END PGP SIGNATURE-----

