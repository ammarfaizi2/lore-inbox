Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313305AbSHBMgd>; Fri, 2 Aug 2002 08:36:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313416AbSHBMgd>; Fri, 2 Aug 2002 08:36:33 -0400
Received: from pcp01179415pcs.strl1201.mi.comcast.net ([68.60.208.36]:11768
	"EHLO mythical") by vger.kernel.org with ESMTP id <S313305AbSHBMgc>;
	Fri, 2 Aug 2002 08:36:32 -0400
Date: Fri, 2 Aug 2002 08:38:52 -0400 (EDT)
From: Ryan Anderson <ryan@michonline.com>
To: Roman Zippel <zippel@linux-m68k.org>
cc: Linus Torvalds <torvalds@transmeta.com>,
       David Woodhouse <dwmw2@infradead.org>,
       David Howells <dhowells@redhat.com>, alan@redhat.com,
       linux-kernel@vger.kernel.org
Subject: Re: manipulating sigmask from filesystems and drivers 
In-Reply-To: <Pine.LNX.4.44.0208021118120.28515-100000@serv>
Message-ID: <Pine.LNX.4.10.10208020827490.579-100000@mythical.michonline.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Aug 2002, Roman Zippel wrote:

> I slept over it and I thought about a bit more, but I think it just starts
> to get interresting, so I hope your co-workers had a chance to snatch that
> chainsaw away. :-)

uh-oh.  heh.

> On Thu, 1 Aug 2002, Linus Torvalds wrote:
> 
> > There are cases where you absolutely _have_ to rely on this documented
> > UNIX behaviour. One example is using a log-file (yes, a _file_, not a
> > socket or a pipe) that you explicitly opened with O_APPEND, just so that
> > you can guarantee _atomic_ writes that do not get lost or partially
> > re-ordered in your log.
> >
> > And yes, these logging programs are mission-critical, and they do have
> > signals going on, and they rely on well-defined and documented interfaces
> > that say that doing a write() to a filesystem is _not_ going to return in
> > the middle just because a signal came in.
> 
> If these programs are so mission-critical, they better do some error
> checking. Your atomic write will fail on a full disk and if the
> information is that important, the program has to handle that.

>From personal experience, I have an application that DEPENDS on the
atomicity of writes in O_APPEND mode.  In the logging function, we have
made a conscious choice that, if we get a disk-full error, there's not a
damn thing we can do about a "disk full" condition that makes sense in
the application, so we don't handle that error.  (That situation is
something the sysadmin is supposed to prevent, anyway.)  (Admittedly,
that application is running on AIX - but I still expect the behavior to
remain the same when we port that application over to Linux...
eventually.)


> > These programs know what they are doing. They are explicitly _not_ using
> > "stdio" to write the log-file, exactly because they cannot afford to have
> > the write broken up into many parts (and they do not want to have it
> > buffered either, since getting the logging out in a timely fashion can be
> > important).
> >
> > The only, and the _portable_ way to do this under UNIX is to create one
> > single buffer, and write it out with one single write() call. Anything
> > else is likely to cause the file to be interspersed by random
> > log-fragments, instead of being a nice consecutive list of full log
> > entries.
> 
> I looked around a bit and it doesn't look that portable. UNIX systems seem
> to have this behaviour, but not all POSIX systems. Letting multiple
> programs log to the same file is insane (there must be a reason why syslog
> was invented). Signals are your least worry, that's easy to deal with:
> 
> 	sigfillset(&s);
> 	sigprocmask(SIG_SETMASK, &s, &os);
> 	write(...);
> 	sigprocmask(SIG_SETMASK, &os, NULL);
> 
> But that doesn't deal with an almost full disk.
> 
> > If people cannot find this in SuS, then I simply don't _care_. I care
> > about not having a crap OS, and I also care about not having to repeat
> > myself and give a million examples of why the current behaviour is
> > _required_, and why we're not getting rid of it.

In any case, atomicity is guaranteed by SUSv3 (Read open(2) for O_APPEND,
then read write(2) and skip down to the Rationale, first paragraph.

> I'm not asking for removing for this, I simply don't agree with the
> reason. I still consider any program relying on this behaviour buggy. Your
> "atomic" write is an illusion, the os can certainly try, but in the end
> it's the applications responsibility to get this right.
> I know that we can't remove this behaviour, but the only reason is to
> keep buggy programs working and let them instead fail in other more subtle
> ways.

Yes, it's always the application's responsibility to get this right.

The application can expect that when write(2) returns from a request
that involved smaller than {PIPE_BUF} size, it either failed, or wrote
the whole request, and with that assumption, the application can handle
the other errors sanely.

Note that write(2) can never return less bytes written than requested if
the requested amount is smaller than {PIPE_BUF} size.

Linus is absolutely correct here, changing the semantics of this
scenario would be a huge mess.

--
Ryan Anderson
  sometimes Pug Majere

