Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136194AbRAJS3J>; Wed, 10 Jan 2001 13:29:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136196AbRAJS27>; Wed, 10 Jan 2001 13:28:59 -0500
Received: from hermes.mixx.net ([212.84.196.2]:31245 "HELO hermes.mixx.net")
	by vger.kernel.org with SMTP id <S136194AbRAJS2o>;
	Wed, 10 Jan 2001 13:28:44 -0500
Message-ID: <3A5CA923.4731F29@innominate.de>
Date: Wed, 10 Jan 2001 19:25:39 +0100
From: Daniel Phillips <phillips@innominate.de>
Organization: innominate
X-Mailer: Mozilla 4.72 [de] (X11; U; Linux 2.4.0-test10 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Jamie Lokier <lk@tantalophile.demon.co.uk>, linux-kernel@vger.kernel.org
Subject: Re: FS callback routines
In-Reply-To: <3A5A4958.CE11C79B@goingware.com> <3A5B0D0C.719E69F@innominate.de> <20010110115632.E30055@pcep-jamie.cern.ch>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jamie Lokier wrote:
> 
> Daniel Phillips wrote:
> > It was done last year, quietly and without fanfare, by Stephen Rothwell:
> >
> >   http://www.linuxcare.com/about-us/os-dev/rothwell.epl
> >
> > This may be the most significant new feature in 2.4.0, as it allows us
> > to take a fundamentally different approach to many different problems.
> > Three that come to mind:
> [...]
> >    mail (get your mail instantly without polling);
> 
> You'll be notified if _any_ mailbox is changed in your mail directory.
> On a multiuser system that's going to be more often than a typical
> polling interval, so you'll have to revert to polling.

?? I don't get it.  I'd expect a daemon to be notified and the daemon in
turn to notify me.

> > make (don't rely on timestamps to know when rebuilding is needed, don't
> > scan huge directory trees on each build)
> 
> You will need to rescan the timestamps of files, but yes you can skip
> subdirectories in which no file has changed.  But only if you're running
> a "make daemon" on the same box as make, and if there aren't too many
> directories.

A 'make daemon' is exactly what I was thinking of.  The 'too many
directories' think is a problem, see below.

> > locate (reindex only those directories that have changed, keep index
> > database current).
> 
> Not a chance.  dnotify doesn't work recursively, so you can't monitor
> just a few top level directories like "/usr/lib".  And have you ever
> tried to keep all 3000 directories on your filesystem directories open
> at the same time?  Would you want to consume that much non-swappable
> memory, and also prevent the directories from being removed from the
> filesystem?

Yes, basic problem.  The notification has to be persistent across
directory open/close.  There had to be a reason why dnotify.c is just
140 lines long, right?  OK, that doesn't mean 'not a chance', it just
means the current implementation is inadequate.  Now at least I can
start writing programs that work this way, try them out, and think about
what has to be done to go the rest of the distance.

Another problem is not handling hard links properly.  That's not ok.

> Long ago I proposed something similar that works at the disk level, is
> recursive, and the checks can be done without keeping directories open.
> But I never wrote the code :(  That's interesting because it speeds up
> make without needing a daemon, and really can speed up
> locate/updatedb/find.

Yes, there are obvious flaws but it's now in and it's obvious where it's
going.  A simple-minded inadequate piece of code that's working beats a
perfect one that exists purely in the imagination, any day. :-)

Do you still have your original proposal around?

--
Daniel
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
