Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131529AbRC0T7A>; Tue, 27 Mar 2001 14:59:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131531AbRC0T6w>; Tue, 27 Mar 2001 14:58:52 -0500
Received: from h24-65-193-28.cg.shawcable.net ([24.65.193.28]:59131 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S131529AbRC0T6h>; Tue, 27 Mar 2001 14:58:37 -0500
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200103271955.f2RJtoH05928@webber.adilger.int>
Subject: Re: OOM killer???
In-Reply-To: <3AC0E4D9.E157D407@evision-ventures.com> from Martin Dalecki at
 "Mar 27, 2001 09:07:05 pm"
To: Martin Dalecki <dalecki@evision-ventures.com>
Date: Tue, 27 Mar 2001 12:55:50 -0700 (MST)
CC: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>,
        Jonathan Morton <chromi@cyberspace.org>,
        Rogier Wolff <R.E.Wolff@bitwizard.nl>, linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Dalecki writes:
> Ingo Oeser wrote:
> > So as Rik stated: The OOM killer cannot suit all people, so it
> > has to be configurable, to be OOM kill, not overkill ;-)
> 
> Irony: Why then not store this information permanently - inside
> the UID of the application?

Because in some cases (large companies and such) the UID is centrally
controlled across all machines in the company, so there are > 100 (or
500 or 1000) "system" UIDs.  At one company I did work for, there were
dozens (maybe > 100) oracle instances alone (each with different UID
and passwords for security), and lots more "system" application UIDs,
each unique.

Encoding more information into the UID is getting back to the bad old
days of "uid 0" is can do anything, rather than the capability model we
are working towards.  Even so, encoding process killability info in the
UID is _still_ not putting policy in user space, because if you don't
like how the OOM killer works you still need to recompile and reboot.

Having a configurable OOM killer is not overkill, IMHO, because it is
only called in very rare cases (i.e. OOM is hopefully a rare event),
so it is definitely not on the fast path.  I'm sure people will agree
that spending a few extra cycles to kill the correct process is far
better than killing a lot of incorrect processes quickly.

Every time this subject comes up, I point to AIX and SIGDANGER - a signal
sent to processes when the system gets OOM.  If the process has registered
a SIGDANGER handler, it has a chance to free cache and such (or do a clean
shutdown), otherwise the default signal handler will kill the process.

SIGDANGER would fix the original problem (killing numerical methods
application running for weeks) perfectly - the application can freely
allocate cache memory to speed up the calculations.  When system gets
OOM (for whatever reason), it sends SIGDANGER to applications first and
they can free buffers or do safe shutdown, and this may get system out
of OOM case without having to kill anything.

Granted, I'm not against fixing the VM to reducing OOM conditions in the
first place.  Having SIGDANGER still gives the application a chance to
save itself before it is killed, which none of the OOM changes have
addressed at all.  It is _still_ possible to get a system into OOM from
network buffers and such, regardless of whether an application is
calling malloc() returns NULL or not.

Also, having a SIGDANGER handler _could_ reduce a process "badness"
value when looking for processes to SIGKILL, when calling all of the
SIGDANGER handlers has not freed enough memory to get out of OOM.  This
assumes that programs which register SIGDANGER handlers are important,
rather than malicious (in which case your system has other problems).

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
