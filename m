Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262405AbSJEQzv>; Sat, 5 Oct 2002 12:55:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262406AbSJEQzv>; Sat, 5 Oct 2002 12:55:51 -0400
Received: from uucp.cistron.nl ([62.216.30.38]:37390 "EHLO ncc1701.cistron.net")
	by vger.kernel.org with ESMTP id <S262405AbSJEQzu>;
	Sat, 5 Oct 2002 12:55:50 -0400
From: "Miquel van Smoorenburg" <miquels@cistron.nl>
Subject: Re: Why does x86_64 support a SuSE-specific ioctl?
Date: Sat, 5 Oct 2002 17:00:52 +0000 (UTC)
Organization: Cistron
Message-ID: <ann5s4$87a$1@ncc1701.cistron.net>
References: <Pine.NEB.4.44.0210041654570.11119-100000@mimas.fachschaften.tu-muenchen.de.
	 suse.lists.linux.kernel> <3D9E72C8.1070203@pobox.com> <20021005071003.A15345@wotan.suse.de> <1033824115.3425.2.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain; charset=iso-8859-15
X-Trace: ncc1701.cistron.net 1033837252 8426 62.216.29.67 (5 Oct 2002 17:00:52 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: miquels@cistron-office.nl (Miquel van Smoorenburg)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <1033824115.3425.2.camel@irongate.swansea.linux.org.uk>,
Alan Cox  <alan@lxorguk.ukuu.org.uk> wrote:
>I see no good reason for this ioctl at all, in any tree.

Check out 'bootlogd.c' in sysvinit.

It starts at boot time, created a tty/pty pair, and does a TIOCCONS
on it. Everything that gets written to /dev/console now goes
ty the pty, so it can log all output.

However you still want to see the output on the screen. But
you can't copy it to /dev/console, because you'd get it right
back in the pty.

So you need to know what the _real_ console is so you can write
a copy to the real console. The only way to find that out is
to call TIOCGDEV on /dev/console, then scan /dev. That is
what bootlogd does, I've tried to get TIOCGDEV in the kernel
since 2.2 days but gave up because it was ignored. So bootlogd
has always been 'experimental', though it is very useful,
since it has no kernel support.

Now, to solve this particular problem, there are a few
alternatives.

One is a TIOCCONS_COPY ioctl, so that output is not redirected
but copied to the pty.

Another, perhaps more elegant solution is that writes
to the pty slave that receives the console output should
go to the real console. A swap instead of a redirect.

The last one probably makes more sense - it seems
very logical, and is trivial to implement.

Mike.

