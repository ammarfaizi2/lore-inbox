Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317005AbSGSUHa>; Fri, 19 Jul 2002 16:07:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317006AbSGSUH3>; Fri, 19 Jul 2002 16:07:29 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:63996 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S317005AbSGSUH3>;
	Fri, 19 Jul 2002 16:07:29 -0400
Message-ID: <1027109386.3d38720ad79f5@imap.linux.ibm.com>
Date: Fri, 19 Jul 2002 13:09:46 -0700
From: Nivedita Singhvi <niv@us.ibm.com>
To: hayden@spinbox.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.2 to 2.4... serious TCP send slowdowns
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.0
X-Originating-IP: 9.47.18.15
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> We're finally migrating to the 2.4 kernel due to hardware
> incompatibilities with the 2.2.  The 2.2 has worked better
> for us in the past as far as our application performs.
> Our application is an adserver and becomes bogged down in 2.4
> when sending files such as images across

When you say bogged down, what exactly does that mean? Does it
hang? Can you quantify the slowdown with any measurements?
Have you looked at TCP and network statistics to check for
timeouts, drops, other errors, the like? netstat -s should
give you some extended TCP stats which might help you diagnose
that sort of problem..

> the wire.  They're in general between 20-50k in size.  I've been
> researching the differences between 2.4 and 2.2 and have noticed
> that a lot of work has gone into autotuning with 2.4 and I'm
> wondering if this is what's slowing things down.  When I do tcpdumps
> to see the traffic being sent to the client I'm noticing that the
> receiver window is almost always set to 6430 bytes.  When looking at
> the same transfer on our 2.2 boxes the receiver window is almost
> always over 31000 bytes.  I've tried to increase the size of the
> buffers using the proc settings that are provided however

Whats your interface MTU? How did you change the size of the buffers?
Note that you need to increase the tcp_rmem[1] and tcp_wmem[1] to
affect the default tcp socket buffer sizes. Also note that
approximately half that is used by the kernel, so if you really want
64K user space, try setting the size to 128K.

> this hasn't seemed to make a difference even after restarting
> servers after each change the window is still 6430 bytes.  I've
> tried manually settting the size with setsockopt calls in the server
> code but this hasn't seemed to help.  I believe the problem is
> definately with sending the files over the line.  We files are read
> into the socket to be sent across the network byte by byte.  The boss
> says this is the best way to do it but I'm curious if this is so.

You cant optimize your read() from a fd and writes to a socket fd()
simultaneously. Are you setting TCP_NODELAY?

If all you are doing is reading large files from disk and sending them
out over a socket, consider using sendfile() instead. Much more
efficient.

thanks,
Nivedita




