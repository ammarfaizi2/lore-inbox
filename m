Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266802AbUIMOOq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266802AbUIMOOq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 10:14:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266825AbUIMOOq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 10:14:46 -0400
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:25832 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S266802AbUIMOOi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 10:14:38 -0400
Subject: Re: /proc/sys/kernel/pid_max issues
From: Albert Cahalan <albert@users.sf.net>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>, cw@f00f.org,
       mingo@elte.hu, anton@samba.org
In-Reply-To: <20040913074230.GW2660@holomorphy.com>
References: <1095045628.1173.637.camel@cube>
	 <20040913074230.GW2660@holomorphy.com>
Content-Type: text/plain
Organization: 
Message-Id: <1095084688.1173.1329.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 13 Sep 2004 10:11:29 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-09-13 at 03:42, William Lee Irwin III wrote:
> On Sun, Sep 12, 2004 at 11:20:29PM -0400, Albert Cahalan wrote:
> > I'd much prefer LRU allocation. There are
> > lots of system calls that take PID values.
> > All such calls are hazardous. They're pretty
> > much broken by design.
> > Better yet, make a random choice from
> > the 50% of PID space that has been least
> > recently used.
> 
> I'd favor fully pseudorandom allocation over LRU or approximate LRU
> allocation, as at least pseudorandom is feasible without large impacts
> on resource scalability. OTOH the cache characteristics of pseudorandom
> allocation are usually poor; perhaps hierarchically pseudorandom
> allocation where one probes a sequence of cachelines of the bitmap
> according to one PRNG, and within each cacheline probes a random
> sequence of bits according to some other PRNG, would resolve that.
> 
> 
> On Sun, Sep 12, 2004 at 11:20:29PM -0400, Albert Cahalan wrote:
> > Another idea is to associate PIDs with users
> > to some extent. You keep getting back the same
> > set of PIDs unless the system runs low in some
> > global pool and has to steal from one user to
> > satisfy another.
> 
> The resource tracking and locking implications of this are disturbing.
> Would fully pseudorandom allocation be acceptable?

There's no point.

LRU reduces accidents that don't involve an attacker.

Strong crypto random can make some attacks a bit harder.
OpenBSD does this. It doesn't work well enough to bother
with if the implementation is problematic; there's not
much you can do while avoiding 64-bit or 128-bit PIDs.
Pseudorandom is 100% useless.

Per-user PID recycling would make it much harder for
an attacker to grab a specific PID. Perhaps the attacker
knows that a sched_setscheduler call is coming, and he
has a way to make the right process restart or crash.
Normally, this lets him get SCHED_FIFO or somesuch.
With per-user PID recycling, it would be difficult for
him to grab the desired PID.

> On Sun, Sep 12, 2004 at 11:20:29PM -0400, Albert Cahalan wrote:
> > BTW, since pid_max is now adjustable, reducing
> > the default to 4 digits would make sense. Try a
> > "ps j" to see the use. (column width changes if
> > you change max_pid)
> 
> Is the maximum possible pid exported by the kernel somehow? Perhaps
> it should be; the maximum number of decimal digits required to
> represent PID_MAX_LIMIT (4*1024*1024) should suffice in all cases.
> Perhaps you need to detect PID_MAX_LIMIT somehow?

I do indeed detect pid_max via /proc/sys/kernel/pid_max
and adjust column widths as needed. (ps only, for now)

Since we're not getting the benefits of strong crypto
PIDs anyway, we might as well have 4-digit PIDs be default.
Very few people would need to increase this.



