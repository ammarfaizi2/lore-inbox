Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266465AbUG0RJd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266465AbUG0RJd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 13:09:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266466AbUG0RJd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 13:09:33 -0400
Received: from madrid10.amenworld.com ([62.193.203.32]:7954 "EHLO
	madrid10.amenworld.com") by vger.kernel.org with ESMTP
	id S266465AbUG0RJY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 13:09:24 -0400
Date: Tue, 27 Jul 2004 19:09:07 +0200
From: DervishD <raul@pleyades.net>
To: Mike Waychison <Michael.Waychison@sun.com>
Cc: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: The dreadful CLOSE_WAIT
Message-ID: <20040727170907.GA26136@DervishD>
Mail-Followup-To: Mike Waychison <Michael.Waychison@Sun.COM>,
	Linux-kernel <linux-kernel@vger.kernel.org>
References: <20040727083947.GB31766@DervishD> <4106869A.5030905@sun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4106869A.5030905@sun.com>
User-Agent: Mutt/1.4.2.1i
Organization: Pleyades
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi Mike :)

 * Mike Waychison <Michael.Waychison@Sun.COM> dixit:
> >     Seems under Linux that, when a connection is in the CLOSE_WAIT
> > state, the only wait to go to LAST_ACK is the application doing the
> > 'shutdown()' or 'close()'. Doesn't seem to be a timeout for that.
> This is by design.  It is possible to close a single direction of data
> transmission in TCP, hence the shutdown system call.

    I know, that's the only 'harm' a CLOSE_WAIT timeout will have,
but anyway I don't see any point in having a permanent CLOSE_WAIT
state. The other end is not there, it has sent us a FIN.

> > the tx queue, it seems that the kernel tries to retransmit all that
> > data, which makes no sense: in CLOSE_WAIT state the other end is not
> > there... Surely I'm missing a lot :((
> It may be half there.  It should be in FIN_WAIT1 state.

    OK, that's what I was missing. But anyway FIN_WAIT1 has a
timeout, so if our 'bad' application doesn't do the close and the
connection goes from CLOSE_WAIT to LAST_ACK due to a (new) timeout,
the other end will have its FIN anyway and our 'bad' app won't hold a
resource.

> >     Since I don't know if a timeout (or another solution) exists to
> > avoid this I won't give names, but it's pretty easy to do a DoS
> > attack over a very known FTP server just using 'wget' and your
> > favourite C-c keys.
> This is broken application behaviour.  Forgetting about sockets (or any
> other resource for that matter) is bad news.

    Of course!, that's why I called it 'bad app'. Obviously is a bug
in the server, but I don't think it's a good idea to let a bug in an
application (well, we are all *VERY* good programmers, but bugs are,
you know, die hard...) eat resources without control.
 
> >     IMHO, Linux (Unix) is about not allowing a bad app to screw the
> > system, and the CLOSE_WAIT state allows that. I know: you can screw
> > the system using as root an application that allocates and locks
> > large chunks of memory, or other 'legal' bad things, the sysadmin
> > should not allow the use of crappy software, but will do any harm a
> > CLOSE_WAIT timeout?
> This is the same idea of having a server run that loses a bit of memory
> on each bad request.  It would be an application bug, and similarly, the
> kernel would have no way to know whether the application was doing
> something wrong or not.

    I think that being in CLOSE_WAIT more than a given amount of time
(this is system policy, I suppose, and kernel should not dictate
here) is wrong. I did a simple test and my 'bad server' (written that
way on purpose) held a connection in CLOSE_WAIT for a day! And it's
still there. Obviously the application is not doing anything correct.
I can't think of an scenario where holding a connection in CLOSE_WAIT
for ever is correct. I mean, not doing the 'close()'.
 
> If you are _really_ concerned, you'd cap out at NR_OPEN per process
> anyway :)

    Well, it may be an idea ;) Anyway if you have, let's say, a
maximum of 10 connections in your server, and I do 10 wget+C-c, you
no longer have a running server. The kernel should not allow that. A
timeout of 3600 seconds seems very reasonable, or somethink like
that, am I wrong?

    Thanks for your help :)

    Raúl Núñez de Arenas Coronado

-- 
Linux Registered User 88736
http://www.pleyades.net & http://raul.pleyades.net/
