Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132752AbRC2Pnw>; Thu, 29 Mar 2001 10:43:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132753AbRC2Pne>; Thu, 29 Mar 2001 10:43:34 -0500
Received: from adsl-64-163-64-75.dsl.snfc21.pacbell.net ([64.163.64.75]:54788
	"EHLO konerding.com") by vger.kernel.org with ESMTP
	id <S132752AbRC2Pn1>; Thu, 29 Mar 2001 10:43:27 -0500
Message-ID: <3AC357B8.72860494@konerding.com>
Date: Thu, 29 Mar 2001 07:41:44 -0800
From: David Konerding <dek_ml@konerding.com>
X-Mailer: Mozilla 4.73 [en] (Win98; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Guest section DW <dwguest@win.tue.nl>
CC: "Dr. Michael Weller" <eowmob@exp-math.uni-essen.de>,
   Andreas Dilger <adilger@turbolinux.com>,
   Szabolcs Szakacsits <szaka@f-secure.com>,
   Martin Dalecki <dalecki@evision-ventures.com>,
   Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>,
   Jonathan Morton <chromi@cyberspace.org>,
   Rogier Wolff <R.E.Wolff@bitwizard.nl>, linux-kernel@vger.kernel.org
Subject: Re: OOM killer???
In-Reply-To: <200103282138.f2SLcT824292@webber.adilger.int> <Pine.A32.3.95.1010329111147.63156A-100000@werner.exp-math.uni-essen.de> <20010329130154.A8701@win.tue.nl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I would tend to agree, I'm not a fan of the OOM killer's behavior.  The OOM is forced
because of the policy of overcommitting of memory.  The reason for that policy is
based on an observation:
many programs allocate far more memory than they ever use, and most people don't want
their program to crash just because it malloc()s memory it isn't going to use.
Having to activate the pages for memory that never gets used feels wasteful to some
people.  On the other hand, having my two-week-running scientific app killed because
it did a whole bunch of disk reads that fill up 600MB of my 768MB RAM, then tried to
allocate a whole bunch more memory (that it *will* use) is obviously a fault of the
OOM killer policy. At the very least the entire disk cache, or a goodly portion of
it, should be drained before ever invoking the OOM.  I'm more than glad to pay the
performance hit of no disk buffers for the privilege of having my job finish.

Now, if you're going to implement OOM, when it is absolutely necessary, at the very
least, move the policy implementation out of the kernel.  One of the general
philosophies of Linux has been to move policy out of the kernel.  In this case, you'd
just have a root owned process with locked pages that can't be pre-empted, which
implemented the policy.  You'll never come up with an OOM policy that will fit
everybody's needs unless it can be tuned for  particular system's usage, and it's
going to be far easier to come up with that policy if it's not in the kernel.



Guest section DW wrote:


> Two things are wrong.

> 1. Linux has an OOM killer.
> 2. The OOM killer has a bad behaviour.
>
> Presently, with the proper kind of load, one can see a process killed
> by OOM almost daily. That is totally unacceptable.
> People are working on refining the algorithm so that blatant idiocies
> where processes are killed while there is plenty of resources
> are avoided. Good. Suppose it done. Then one thing is wrong.
>
> 1. Linux has an OOM killer.
>
> A system with an OOM killer is unreliable. Linux must have a reliable
> mode of operation, and that must be the default mode.
>
> Now you assume that adding SIGDANGER would make people happy.
> But it would be a rather unimportant addition.
> It might help in some cases, but it falls in the category
> of improving the OOM killer a little.
>
> People will be happy when Linux is reliable by default.
>
> Andries
>
> [Never use planes where the company's engineers spend their
> time designing algorithms for selecting which passenger
> must be thrown out when the plane is overloaded.]
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

