Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262354AbSJODhR>; Mon, 14 Oct 2002 23:37:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262355AbSJODhQ>; Mon, 14 Oct 2002 23:37:16 -0400
Received: from CPE-144-132-192-193.nsw.bigpond.net.au ([144.132.192.193]:49543
	"EHLO anakin.wychk.org") by vger.kernel.org with ESMTP
	id <S262354AbSJODhP>; Mon, 14 Oct 2002 23:37:15 -0400
Date: Tue, 15 Oct 2002 11:36:40 +0800
From: Geoffrey Lee <glee@gnupilgrims.org>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: Jogchem de Groot <bighawk@kryptology.org>, linux-kernel@vger.kernel.org
Subject: Re: poll() incompatability with POSIX.1-2001
Message-ID: <20021015033640.GA15553@anakin.wychk.org>
References: <20021014145726.DFKF19708.mail8-sh.home.nl@there> <Pine.LNX.3.95.1021014110505.12302A-100000@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=big5
Content-Disposition: inline
In-Reply-To: <Pine.LNX.3.95.1021014110505.12302A-100000@chaos.analogic.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > 
> > When the connection has been established asynchronously, select() and poll()
> > shall indicate that the file descriptor for the socket is ready for writing."
> > 
> > On linux-2.4 i noticed the following behaviour:
> > 
> > On connect() success select() returns writability for the socket.
> > On connect() failure select() returns readability and writability for the
> > socket.
> > 
> > This behaviour is according to the specification.
> > 
> > However with poll() (with events=POLLIN|POLLOUT) i get the following
> > behaviour:
> > 
> > On connect() success poll() returns POLLOUT in revents.
> > On connect() failure poll() returns POLLIN|POLLHUP|POLLERR in revents.
> > 
> > It does not set the POLLOUT bit here..
> 
> This is a failure to connect! The socket is therefore not ready for
> writing  or reading -ever. This behavior may not be correct, not
> because of a failure to set the POLLOUT bit, but because the POLLIN
> bit is set. Check if this is really true. I can't duplicate this
> on 2.4.18 here because it's hard to get a deferred connect with my
> setup.
> 


Hello!



I have done some experimentation.


First I used telnet to verify that the host xx.xx.xx.xx on port 80 is
up and listening.  We verify that this is true.

Then, we run a test program.

The test program creates a TCP socket which will connect to a given host
on a given port then use the fcntl() call to set the non-blocking bit.

We then use connect() to connect to the host.  We verify that the errno
is indeed EINPROGRESS.

We then use poll with an events member set to POLLIN | POLLOUT.


This is the result on a return from poll().

glee@orion ~/tmp $ ./poll-new -h xx.xx.xx.xx -p 80
connect
connect: INPROGRESS
poll: POLLOUT is set
terminating
glee@orion ~/tmp $


So, POLLOUT is set.


Now, we try to connect to an invalid port.

n ~/tmp $ ./poll-new -h xx.xx.xx.xx -p 4
connect
connect: INPROGRESS
poll: POLLERR set
poll: POLLHUP set
poll: POLLOUT is set
terminating
glee@orion ~/tmp $


So, POLLOUT is set.

By the way, what constants should be defined when you do a #include <poll.h>?


A lot of them are not defined, those listed in the poll() document on 
the opengroup website, only POLLPRI and POLLIN, POLLOUT, POLLNVAL,
POLLHUP and POLLERR are defined.


POLLRDNORM, POLLRDBAND, POLLWRBAND, POLLWRNORM are not defined.


	-- G.
	
