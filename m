Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280585AbRKSSgH>; Mon, 19 Nov 2001 13:36:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280570AbRKSSfy>; Mon, 19 Nov 2001 13:35:54 -0500
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:30731 "EHLO
	deathstar.prodigy.com") by vger.kernel.org with ESMTP
	id <S280547AbRKSSed>; Mon, 19 Nov 2001 13:34:33 -0500
Date: Mon, 19 Nov 2001 13:34:32 -0500
Message-Id: <200111191834.fAJIYWK30800@deathstar.prodigy.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [patch] scheduler cache affinity improvement for 2.4 kernels
X-Newsgroups: linux.kernel
In-Reply-To: <20011108170740.B14468@mikef-linux.matchmail.com>
In-Reply-To: <20011108153749.A14468@mikef-linux.matchmail.com> <Pine.LNX.4.40.0111081632400.1501-100000@blue1.dev.mcafeelabs.com>
Organization: TMR Associates, Schenectady NY
From: davidsen@tmr.com (bill davidsen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20011108170740.B14468@mikef-linux.matchmail.com> mfedyk@matchmail.com wrote:

| Running one niced copy of cpuhog on a 2x366 mhz celeron box did pretty well.
| Instead of switching several times in one second, it only switched a few
| times per minute.
| 
| I was also able to merge it with just about everything else I was testing
| (ext3, freeswan, elevator updates, -ac) except for the preempt patch.  Well, I
| was able to manually merge it, but the cpu afinity broke.  (it wouldn't use
| the second processor for anything except for interrupt processing...)

  The problem with processor affinity is that for some *typical* loads
the things which make things better for one load make it worse for
another. If you wait longer for the "right" processor to be available
then you increase the chances that the cache is mostly filled with what
the CPU was doing in other processes, and affinity has done nothing but
delay the scheduling of the process, since the cache is going to be of
small use anyway.

  The item of interest for making decisions about affinity would be
number of cache misses (and obviously cache changes to satisfy them).
This would allow a better estimate of how much of the cache is still
useful if affinity is preserved. Given the number of processor types on
which Linux runs this is not something likely to be included on all of
them, and is related to cache size as well. So the things being done in
the scheduler are not really measuring "how much of the cache is still
useful to process X," which would be the best predictor of the value of
affinity. I apologise to those who find this an old thought, not
everyone on this list has noted this, I believe.

  I'm not surprised that you find the preempt doesn't work, it is
somewhat counter to the process of affinity. Given the choice of better
performance for cpu hogs or more responsive preformance and in some
cases much higher network performance, I will take preempt. But it would
be nice to have a choice at runtime or in /proc/sys so that systems
could be tuned to optimize the characteristics most needed.

-- 
bill davidsen <davidsen@tmr.com>
  His first management concern is not solving the problem, but covering
his ass. If he lived in the middle ages he'd wear his codpiece backward.
