Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314083AbSFIRts>; Sun, 9 Jun 2002 13:49:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314085AbSFIRtr>; Sun, 9 Jun 2002 13:49:47 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:57618 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S314083AbSFIRtq> convert rfc822-to-8bit; Sun, 9 Jun 2002 13:49:46 -0400
Date: Sun, 9 Jun 2002 10:49:50 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Peter =?iso-8859-1?Q?W=E4chtler?= <pwaechtler@loewe-komp.de>
cc: Rusty Russell <rusty@rustcorp.com.au>, <linux-kernel@vger.kernel.org>,
        <frankeh@watson.ibm.com>, <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] Futex Asynchronous Interface
In-Reply-To: <3D0328D2.8CD47269@loewe-komp.de>
Message-ID: <Pine.LNX.4.44.0206091029001.13459-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-MIME-Autoconverted: from 8bit to quoted-printable by deepthought.transmeta.com id g59HnCj02317
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 9 Jun 2002, Peter Wächtler wrote:
>
> Still you can open a file in the namespace and write some commands to it.
> Then it turns out to be a socket on port 25:
>
> fd=open("/dev/socket",O_RDWR);
> write(fd,"connect stream 25\n",sizeof(..));
> write(fd,"helo mail.my.com\n",..);

Yes, obviously you can avoid system calls entirely, and replace all of
them with read/write of commands.

This is not even a very uncommon idea: the above is basically message
passing, and is largely how many microkernels work. Except they don't call
it read/write, they tend to call it send/recv, and they aren't "file
descriptors", they are "ports".

It has advantages: because you only have one set of primitives, it's more
easily abtracted at that level, meaning that you can (and people do) make
it distributed etc without having to worry about local semantics.

It has disadvantages too: performance tends to be bad (you have to copy
around and parse the commands that are no longer implicit in the system
call number), and while there is a high level of abstraction on one level
("everything is a 'port' that can receive or send messages), at some point
the proverbial shit hits the fan and you've moved the details behind the
abstraction down (and now the data stream is no longer just bytes, but has
a meaning in itself).

But yes, the sequences

	open("/dev/socket")		->	socket()
	write(fd,"connect stream 25")	->	connect()

are obviously "equivalent". It's not my personal favourite equivalence,
though. I'd much rather add the information at _open_ time, and make it a
name-space issue, so that you'd do something like

	open("//sockfs/dst=123.45.67.89:25", O_RDWR);

instead. Which is _also_ entirely equivalent, of course (the "namespace"
approach does require that you be able to do "fd-relative" lookups, so
that you could also do

	sk = open("//sockfs", O_RDWR);
	sk2 = fd_open(sk, "dst=123.45.67.89:25", O_RDWR);

which is actually useful even in regular files too, just as a way of doing
directory-relative file opens without having to do a "chdir()").

HOWEVER, the fact is that exactly because they are equivalent, there is no
real difference between them. So you might as well just use the old UNIX
behaviour, and if you want to open sockets from a script, you use any of
the already _existing_ socket script helpers. For port 25, you have one
called "sendmail". For port 80, you have things like "lynx -source".

And you have tons of things like "netpipes", for doing generic scripting
of sockets.

The fact is, trying to come up with new ways to do the same old thing is
_not_ a good idea. It may look cool to expose sockets in the namespace,
but what's the actual added advantage over existing standard practices?
Unless that can be shown, there's just no point.

Do a google search for "netpipes", I'm sure you'll find it can do what you
wanted.

Sorry to rain on the "cool feature" parade, but I want to see some
_advantage_ from exposing new names in the namespace.

		Linus

