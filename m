Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266379AbUG0Qrp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266379AbUG0Qrp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 12:47:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266366AbUG0Qro
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 12:47:44 -0400
Received: from brmea-mail-4.Sun.COM ([192.18.98.36]:62683 "EHLO
	brmea-mail-4.sun.com") by vger.kernel.org with ESMTP
	id S266434AbUG0Qqw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 12:46:52 -0400
Date: Tue, 27 Jul 2004 12:45:14 -0400
From: Mike Waychison <Michael.Waychison@Sun.COM>
Subject: Re: The dreadful CLOSE_WAIT
In-reply-to: <20040727083947.GB31766@DervishD>
To: DervishD <raul@pleyades.net>
Cc: Linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <4106869A.5030905@sun.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
X-Accept-Language: en-us, en
User-Agent: Mozilla Thunderbird 0.5 (X11/20040208)
X-Enigmail-Version: 0.83.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
References: <20040727083947.GB31766@DervishD>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

DervishD wrote:
>     Hi all :))
>
>     Seems under Linux that, when a connection is in the CLOSE_WAIT
> state, the only wait to go to LAST_ACK is the application doing the
> 'shutdown()' or 'close()'. Doesn't seem to be a timeout for that.
>

This is by design.  It is possible to close a single direction of data
transmission in TCP, hence the shutdown system call.


>     Well, I think this is dangerous because a bad application (and a
> couple of widely used servers have this problem) can exhaust system
> network resources (difficult, but possible). For example, a
> concurrent FTP server with a race condition that doesn't do the
> shutdown when the remote end aborts. Writing such a 'bad app' is very
> easy, just do the socket->bind->listen->accept and after accepting
> the connection forget the connected socket and keeps on listening. If
> the remote end aborts, the server leaves the connection in
> CLOSE_WAIT. Sometimes it has a associated timer, when data remains in
> the tx queue, it seems that the kernel tries to retransmit all that
> data, which makes no sense: in CLOSE_WAIT state the other end is not
> there... Surely I'm missing a lot :((

It may be half there.  It should be in FIN_WAIT1 state.

>
>     Since I don't know if a timeout (or another solution) exists to
> avoid this I won't give names, but it's pretty easy to do a DoS
> attack over a very known FTP server just using 'wget' and your
> favourite C-c keys.

This is broken application behaviour.  Forgetting about sockets (or any
other resource for that matter) is bad news.

>
>     IMHO, Linux (Unix) is about not allowing a bad app to screw the
> system, and the CLOSE_WAIT state allows that. I know: you can screw
> the system using as root an application that allocates and locks
> large chunks of memory, or other 'legal' bad things, the sysadmin
> should not allow the use of crappy software, but will do any harm a
> CLOSE_WAIT timeout?
>

This is the same idea of having a server run that loses a bit of memory
on each bad request.  It would be an application bug, and similarly, the
kernel would have no way to know whether the application was doing
something wrong or not.

If you are _really_ concerned, you'd cap out at NR_OPEN per process
anyway :)


- --
Mike Waychison
Sun Microsystems, Inc.
1 (650) 352-5299 voice
1 (416) 202-8336 voice
http://www.sun.com

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
NOTICE:  The opinions expressed in this email are held by me,
and may not represent the views of Sun Microsystems, Inc.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBBoaZdQs4kOxk3/MRArNBAJ91A7CCycwWfwZqUJNuL/y7GrlYngCfYOkC
mM1vvp7GVHe6pBrvPXtuEIY=
=VcrF
-----END PGP SIGNATURE-----
