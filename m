Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286447AbSBCH6e>; Sun, 3 Feb 2002 02:58:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286462AbSBCH6Y>; Sun, 3 Feb 2002 02:58:24 -0500
Received: from relay1.pair.com ([209.68.1.20]:22035 "HELO relay.pair.com")
	by vger.kernel.org with SMTP id <S286447AbSBCH6F>;
	Sun, 3 Feb 2002 02:58:05 -0500
X-pair-Authenticated: 24.126.75.99
Message-ID: <3C5CEEED.E98D35B7@kegel.com>
Date: Sun, 03 Feb 2002 00:03:57 -0800
From: Dan Kegel <dank@kegel.com>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.7-10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Vincent Sweeney <v.sweeney@barrysworld.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "coder-com@undernet.org" <coder-com@undernet.org>
CC: "Kevin L. Mitchell" <klmitch@mit.edu>
Subject: Re: PROBLEM: high system usage / poor SMP network performance
In-Reply-To: <3C56E327.69F8B70F@kegel.com> <001901c1a900$e2bc7420$0201010a@frodo> <3C58D50B.FD44524F@kegel.com> <001d01c1aa8e$2e067e60$0201010a@frodo>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vincent Sweeney wrote:
> > > [I want to use Linux for my irc server, but performance sucks.]
> > >     1) Someone is going to have to recode the ircd source we use and
> > > possibly a modified kernel in the *hope* that performance improves.
> > >     2) Convert the box to FreeBSD which seems to have a better poll()
> > > implementation, and where I could support 8K clients easily as other
> > > admins on my chat network do already....
> >
> > No need to use a modified kernel; plain old 2.4.18 or so should do
> > fine, it supports the rtsig stuff.  But yeah, you may want to
> > see if the core of ircd can be recoded.  Can you give me the URL
> > for the source of the version you use?  I can peek at it.
> > It only took me two days to recode betaftpd to use Poller...
> 
> http://dev-com.b2irc.net/ : Undernet's IRCD + Lain 1.1.2 patch

Hmm.  Have a look at
http://www.mail-archive.com/coder-com@undernet.org/msg00060.html
It looks like the mainline Undernet ircd was rewritten around May 2001
to support high efficiency techniques like /dev/poll and kqueue.
The source you pointed to is way behind Undernet's current sources.

Undernet's ircd has engine_{select,poll,devpoll,kqueue}.c, 
but not yet an engine_rtsig.c, as far as I know.
If you want ircd to handle zillions of simultaneous connections
on a stock 2.4 Linux kernel, rtsignals are the way to go at the
moment.  What's needed is to write ircd's engine_rtsig.c, and 
modify ircd's os_linux.c to notice EWOULDBLOCK
return values and feed them to engine_rtsig.c (that's the icky
part about the way linux currently does this kind of event 
notification - signals are used for 'I'm ready now', but return
values from I/O functions are where you learn 'I'm no longer ready').

So I dunno if I'm going to go ahead and do that myself, but at least I've
scoped out the situation.  Before I did any work, I'd measure CPU
usage under a simulated load of 2000 clients, just to verify that
poll() was indeed a bottleneck (ok, can't imagine it not being a
bottleneck, but it's nice to have a baseline to compare the improved
version against).
- Dan
