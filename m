Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132716AbRC2NpF>; Thu, 29 Mar 2001 08:45:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132727AbRC2No4>; Thu, 29 Mar 2001 08:44:56 -0500
Received: from dfmail.f-secure.com ([194.252.6.39]:3593 "HELO
	dfmail.f-secure.com") by vger.kernel.org with SMTP
	id <S132716AbRC2Nor>; Thu, 29 Mar 2001 08:44:47 -0500
Date: Thu, 29 Mar 2001 15:53:51 +0200 (MET DST)
From: Szabolcs Szakacsits <szaka@f-secure.com>
To: "Dr. Michael Weller" <eowmob@exp-math.uni-essen.de>
cc: Andreas Dilger <adilger@turbolinux.com>,
   Martin Dalecki <dalecki@evision-ventures.com>,
   Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>,
   Jonathan Morton <chromi@cyberspace.org>,
   Rogier Wolff <R.E.Wolff@bitwizard.nl>, <linux-kernel@vger.kernel.org>
Subject: Re: OOM killer???
In-Reply-To: <Pine.A32.3.95.1010329111147.63156A-100000@werner.exp-math.uni-essen.de>
Message-ID: <Pine.LNX.4.30.0103291410070.13864-100000@fs131-224.f-secure.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 29 Mar 2001, Dr. Michael Weller wrote:
> On Wed, 28 Mar 2001, Andreas Dilger wrote:
> > Szaka writes:
> > > And every time the SIGDANGER comes up, the issue that AIX provides
> > > *both* early and late allocation mechanism even on per-process basis
> > > that can be controlled by *both* the programmer and the admin is
> > > completely ignored. Linux supports none of these...
> Maybe some details here were helpful.

http://www.unet.univie.ac.at/aix/aixbman/baseadmn/pag_space_under.htm

> > > ...with the current model it's quite possible the handler code is still
> > > sitting on the disk and no memory will be available to page it in.
> > Actually, I see SIGDANGER being useful at the time we hit freepages.min

The point is AIX *can* guarantee [even for an ordinary process] that
your signal handler will be executed, Linux can *not*. It doesn't matter
where the different oom watermarks are, there would be always such
situations when your handler would get the control it's already far too
late [because between sending SIGDANGER and app getting the control (you
can't schedule e.g. 1000 apps at the same time) the system run into oom
and killed just your app (and e.g. the other 999 buggy mem leaking app
registered a no-op SIGDANGER handler), hope you get the picture even
the example is highly unrealistic].

> > (or maybe even freepages.low), rather than actual OOM so that the apps
> > have a chance to DO something about the memory shortage,

Primarily *users* should have a chance to control this thing, not
developers and kernel. The laters should provide a way to control things
and have a reasonable default [Linux already has the latest but not the
former]. Guess what one wants to be killed if he runs Oracle in
production and DB2, Informix, Sybase, etc in trial. Now only kernel
decides. With SIGDANDER also only developers/kernel would decide [now
forget about resource management that would prevent running all of them
on the same box, Linux users want to fully utilize the box ;)].

So again, IMHO to address this long standing problem, Linux needs
- optional non-overcommit, with per-process granularity would be nice
  [and leave the default just as-is now], oom killer could weight also
  based on this info additionally
- reserved/quaranteed superuser memory [otherwise in non-overcommit mode
  in user space oom(=system oom), oom killer would just take action]
- and as a last chance not to deadlock, advisory oom killer with
  reasonable default [the current default is pretty fine - apart from
  its current bugs]
- a HOWTO about preventing OOM, killing your important processes, etc

Later on virtual swap space [the degree of memory overcommitment] and
SIGDANGER maybe would be useful but I don't think so at present.

BTW, the issue is far more difficult as some people, let's "fix malloc
and its friends" think.

> If freepages.min is reached, AIX starts to kill processes (just like OOM
> killer). It uses some heuristics which might be better than our, but I
> doubt it.

If every process runs in non-overcommit mode AIX kills init first :)

	Szaka

