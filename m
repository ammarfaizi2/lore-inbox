Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264659AbSJ3Kie>; Wed, 30 Oct 2002 05:38:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264661AbSJ3Kie>; Wed, 30 Oct 2002 05:38:34 -0500
Received: from uucp.cistron.nl ([62.216.30.38]:61451 "EHLO ncc1701.cistron.net")
	by vger.kernel.org with ESMTP id <S264659AbSJ3Kid>;
	Wed, 30 Oct 2002 05:38:33 -0500
From: "Miquel van Smoorenburg" <miquels@cistron.nl>
Subject: Re: TCP hangs in 2.4 - blocking write() in wait_for_tcp_memory
Date: Wed, 30 Oct 2002 10:44:20 +0000 (UTC)
Organization: Cistron
Message-ID: <apod64$sv5$1@ncc1701.cistron.net>
References: <apme9u$n2n$1@ncc1701.cistron.net>
Content-Type: text/plain; charset=iso-8859-15
X-Trace: ncc1701.cistron.net 1035974660 29669 62.216.29.67 (30 Oct 2002 10:44:20 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: miquels@cistron-office.nl (Miquel van Smoorenburg)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <apme9u$n2n$1@ncc1701.cistron.net>,
Miquel van Smoorenburg <miquels@cistron.nl> wrote:
>On the gateway machine, the proxy consistantly hangs in a write().
>I've replaced the squid proxy with a simple perl script + nc to
>make sure it isn't a squid-related problem..

Right, I found the cause of the problem, but I'm not sure if the
application of the kernel is wrong here.

On 2 machines do this:

machine1# socket -s 12345 < /dev/zero > /dev/null		# server
machine2# socket -w machine1 12345 < /dev/zero			# client

The first command starts a listening process on port 12345, that
sends an infinite stream of zeros to the remote side and sinks
all data received.

The second command connects to the first machine, sends an
infinite stream of zeros, but never does a read() on the socket
(the '-w' option).

The 'socket' program doesn't make the sockets non-blocking, it just
does a select() loop to find out readability/writeability on the
file descriptors.

This makes both socket programs hang in write(), in wait_for_tcp_memory.
Shouldn't the kernel return a short write, instead of hanging
both processes ? select() returned writeability.

As I described in my first mail, this happens in the real world
as well - an application is writing lots of data to the remote
side, while the remote side is sending data too - hang.

Oh, tested it on 2.4.19 and 2.4.20-pre11

Mike.

