Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293396AbSBYM4D>; Mon, 25 Feb 2002 07:56:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293397AbSBYMzy>; Mon, 25 Feb 2002 07:55:54 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:32266 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S293396AbSBYMzm>; Mon, 25 Feb 2002 07:55:42 -0500
Date: Mon, 25 Feb 2002 13:55:28 +0100
From: Jan Hubicka <jh@suse.cz>
To: gcc@gcc.gnu.org
Cc: Luigi Genoni <kernel@Expansa.sns.it>,
        "Paul G. Allen" <pgallen@randomlogic.com>,
        "Linux kernel developer's mailing list" 
	<linux-kernel@vger.kernel.org>
Subject: Re: gcc-2.95.3 vs gcc-3.0.4
Message-ID: <20020225125528.GE1135@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20020225024817.Q2434@devserv.devel.redhat.com> <Pine.LNX.4.44.0202251044040.18205-100000@Expansa.sns.it> <20020225045859.S2434@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020225045859.S2434@devserv.devel.redhat.com>
User-Agent: Mutt/1.3.24i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Mon, Feb 25, 2002 at 10:46:52AM +0100, Luigi Genoni wrote:
> > > > At this link:
> > > >
> > > >  http://www.cs.utk.edu/~rwhaley/ATLAS/gcc30.html
> > > >
> > > > you can find an interesting explanation why code compiled with gcc 3.0 is
> > > > mostly slower than code compiled with gcc 2.95 on x86 CPUs (but it is
> > > > really faster on other platforms like alpha and sparc64).
> > > >
> > > > basically the main reasons semm to be the scheduler algorithm and the fpu
> > > > stack handling, but I suggest to read the full study.

You should understand that this is mostly the special case.
Atlas loop is hand tuned to compile well with gcc 2.x.x and 3.x.x
prduces worse code on it.   

I've tracked down and fixed problem that made Atlas loop to run out
of registers in 3.1.x so it works well again. (It is not that dificult
to prepare corresponding patch for 3.0.x in case there is interest)

There was nothing wrong with the scheduler and the analysis on page
are somewhat missleading. Real problem was that gcc "forgotten" about
posibility of using memory operand in certain cases of commutative
i387 fp instructions requiring one additional register. (this happent as
result of two independent major change sin the compiler)
This register is not available in the loop curefully written for 8 registers
and causes the performance drop.

In specFP perofmrance, gcc 3.0.1 is about 4% better on specfp according to
the results at http://www.suse.de/~aj/SPEC
Honza
> > > >
> > > >
> > > > I would be interested to know if this apply to gcc 3.1 too.
> > >
> > > Well, concerning reg-stack, you can completely get away without it in 3.1
> > > by using -mfpmath=sse if you are targeting Pentium 3,4 or Athlon 4,xp,mp
> > > (for float math, for higher precision only for Pentium 4).
> > 
> > Yes, but the lot of users (like me) who are still using Athlon TB, 1330 or
> > 1400 Mhz, and who do not have any reason to upgrade to MP since the
> > performance gain is not really considerable, they cannot use sse instructions.
> > So, what could they do? should they stay with gcc 2.95?
> 
> Linux kernel doesn't use floating point math at all, so this is irrelevant
> on lkml, moving to an more appropriate list...
> 
> 	Jakub
